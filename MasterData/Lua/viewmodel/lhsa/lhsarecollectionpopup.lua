require("ViewModel/LHSA/LHSARecollectionItem")
local objs = {
    prefab = {path = "template/Prefab", type = UITool.GameObject},
    maskBtn = {path = "root/Mask", type = UITool.Button},
    progressFill = {path = "root/Right/ProgressGroup/Progress", type = UITool.Image},
    progressText = {path = "root/Right/ProgressGroup/ProgressText", type = UITool.Text},
    scrollViewObj = {path = "root/Right/ScrollView", type = UITool.GameObject}
}

local this = {
    toggleNames = {"RepeatToggle", "MainToggle", "HardToggle"},
    eventTypes = {LHSAMgr.EventType.Repeat, LHSAMgr.EventType.MainLine, LHSAMgr.EventType.Hard},
    curSelectPage = 1,
    curSelectGameNpcIndex = 1
}

this.before_awake = function()
    this.curSelectPage = LHSAMgr.GetDungeonPageIndex()

    this.toggleNodes = {}
    for i = 1, #this.toggleNames do
        local name = this.toggleNames[i]

        local toggleNode = CommonToggleItem.New(this[name], nil, false, i, this.ClickPageToggle)
        this.toggleNodes[i] = toggleNode
        local data = {}
        toggleNode:SetData(data)
        toggleNode:SetIsOn(i == 1)
        toggleNode.toggle.isOn = i == 1
    end
    this.scrollViewUI = UIScrollView.New(this.scrollViewObj)
    RedMgr.Singleton:RegisterViewModel(UIName.LHSARecollectionPopup)
end

this.before_active = function()
    this.curSelectPage = LHSAMgr.GetDungeonPageIndex()
    if this.curSelectPage == nil then
        this.curSelectPage = 1
    end
    for i = 1, #this.toggleNodes do
        local toggleNode = this.toggleNodes[i]
        toggleNode:SetIsOn(index == i)
        if this.curSelectPage == i then
            toggleNode.toggle.isOn = true
        else
            toggleNode.toggle.isOn = false
        end
    end
    LHSAMgr.SetNeedOpenDungeonUI(false)
    this.SwitchPage()
end

this.ClickPageToggle = function(index, value)
    if value == true then
        this.curSelectPage = index
        this.SwitchPage()
        for i = 1, #this.toggleNodes do
            local toggleNode = this.toggleNodes[i]
            toggleNode:SetIsOn(index == i)
        end
    end
end

this.SwitchPage = function()
    LHSAMgr.SetDungeonPageIndex(this.curSelectPage)
    this.RefreshListView()
end

this.RefreshListView = function()
    local eventTypeName = this.eventTypes[this.curSelectPage]
    local finishDatas, allDatas, _ = LHSAMgr.GetDungeonDatas(eventTypeName)
    this.scrollViewUI:Clear()
    this.allDatas = {}
    local scrollDatas = {}
    local width = 389
    for i = 1, #allDatas do
        local data = allDatas[i]
        local scrollData = UIScrollData.GetData(this.prefab, "LHSARecollectionItem", width, 75, data)
        if data.EventType ~= nil then
            data.OnClickCallback = this.OnClickCallback
            table.insert(this.allDatas, data)
        end
        table.insert(scrollDatas, #scrollDatas + 1, scrollData)
    end
    this.scrollViewUI:SetParams(width, 484)
    this.scrollViewUI:SetData(scrollDatas, true)
    this.progressText.text = string.format("%d/%d", #finishDatas, #this.allDatas)
    this.progressFill.fillAmount = #finishDatas / #this.allDatas
end


this.OnClickCallback = function(item)
    if item.data.Status == CommonRewardItem.Status.Lock then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, item.data.UnlockDesc)
        return
    end
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
    enterDungeonParams.eventId = item.data.id
    enterDungeonParams.dungeonId = item.data.eventParam
    BattlePrepareMgr.BattlePrepare(enterDungeonParams)
    LuaMgr.HidePanel(UIName.LHSARecollectionPopup)
    LHSAMgr.SetNeedOpenDungeonUI(true)
    local key = DataMgr.Player.uid .. "LHSA_" .. item.data.id
    if item.data.IsNew == true then
        PlayerPrefs.SetInt(key, 1)
        item.data.IsNew = false
    end
    LHSAMgr.SetEventRed()
end

this.OnClickMaskBtn = function()
    LuaMgr.HidePanel(UIName.LHSARecollectionPopup)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        for key, name in pairs(this.toggleNames) do
            local data = {}
            data.path = "root/Right/ToggleGroup/" .. name
            data.type = UITool.GameObject
            objs[name] = data
        end
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.maskBtn, this.OnClickMaskBtn)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function()
        UIScrollView.ClearItem("LHSARecollectionItem")
        this.curSelectGameNpcIndex = 0
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMaskBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)
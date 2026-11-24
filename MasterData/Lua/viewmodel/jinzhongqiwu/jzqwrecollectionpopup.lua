require("ViewModel/JinZhongQiWu/ViewItem/JZQWRecollectionItem")
local objs = {
    prefab = {path = "template/Prefab", type = UITool.GameObject},
    maskBtn = {path = "root/Mask", type = UITool.Button},
    progressFill = {path = "root/Right/ProgressGroup/Progress", type = UITool.Image},
    progressText = {path = "root/Right/ProgressGroup/ProgressText", type = UITool.Text},
    scrollViewObj = {path = "root/Right/ScrollView", type = UITool.GameObject},
    gamePanel = {path = "root/Right/GamePanel", type = UITool.GameObject},
    npcIcon = {path = "root/Right/GamePanel/Icon", type = UITool.Image},
    leftBtn = {path = "root/Right/GamePanel/LeftBtn", type = UITool.Button},
    rightBtn = {path = "root/Right/GamePanel/RightBtn", type = UITool.Button},
    npcName = {path = "root/Right/GamePanel/Name", type = UITool.Text},
    descText1 = {path = "root/Right/GamePanel/ScrollView/Viewport/Content/Desc1/DescText1", type = UITool.Text},
    descText2 = {path = "root/Right/GamePanel/ScrollView/Viewport/Content/Desc2/DescText2", type = UITool.Text},
    descScrollView = {path = "root/Right/GamePanel/ScrollView", type = UITool.ScrollRect},
    emptyObj = {path = "root/Right/EmptyObj", type = UITool.GameObject}
}

local this = {
    toggleNames = {"DungeonToggle", "NovelToggle", "GameToggle"},
    curSelectPage = 1,
    curSelectGameNpcIndex = 1
}

this.before_awake = function()
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
end

this.before_active = function()
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
    SetActive(this.gamePanel, false)
    SetActive(this.scrollViewObj, false)
    if this.curSelectPage == JZQWConst.PageType.Game then
        this.RefreshGamePanel()
        SetActive(this.gamePanel, #this.npcDatas > 0)
        SetActive(this.emptyObj, #this.npcDatas == 0)
    else
        this.RefreshListView()
        SetActive(this.scrollViewObj, #this.allDatas > 0)
        SetActive(this.emptyObj, #this.allDatas == 0)
    end
end

this.RefreshListView = function()
    local allDatas = {}
    if this.curSelectPage == JZQWConst.PageType.Novel then
        allDatas = JZQWData.GetAllNovelDatas()
    else
        allDatas = JZQWData.GetDungeonDatas(JZQWConst.EventType.Repeat)
        local tempDatas = JZQWData.GetDungeonDatas(JZQWConst.EventType.MainLine)
        if #tempDatas > 0 then
            if #allDatas > 0 then
                table.insert(allDatas, {})
            end
            for i = 1, #tempDatas do
                table.insert(allDatas, tempDatas[i])
            end
        end
        local tempDatas1 = JZQWData.GetDungeonDatas(JZQWConst.EventType.Hard)
        if #tempDatas1 > 0 then
            if #allDatas > 0 then
                table.insert(allDatas, {})
            end
            for i = 1, #tempDatas1 do
                table.insert(allDatas, tempDatas1[i])
            end
        end
    end
    this.scrollViewUI:Clear()
    this.allDatas = {}
    local scrollDatas = {}
    local width = 389
    for i = 1, #allDatas do
        local data = allDatas[i]
        local scrollData = UIScrollData.GetData(this.prefab, "JZQWRecollectionItem", width, 75, data)
        if data.EventType ~= nil then
            data.OnClickCallback = this.OnClickCallback
            table.insert(this.allDatas,data)
        end
        table.insert(scrollDatas, #scrollDatas + 1, scrollData)
    end
    this.scrollViewUI:SetParams(width, 484)
    this.scrollViewUI:SetData(scrollDatas, true)
    local maxCount = JZQWData.GetRecollectionCount(this.curSelectPage)
    this.progressText.text = string.format("%d/%d", #this.allDatas, maxCount)
    this.progressFill.fillAmount = #this.allDatas / maxCount
end

this.RefreshGamePanel = function()
    SetActive(this.leftBtn.gameObject, false)
    SetActive(this.rightBtn.gameObject, false)
    local allDatas, maxCount = JZQWData.GetOwnerNpcDatas()
    this.npcDatas = allDatas
    if #allDatas > 0 then
        if this.curSelectGameNpcIndex == 0 or this.curSelectGameNpcIndex > #allDatas then
            this.curSelectGameNpcIndex = 1
        end
    end
    if #allDatas == 2 then
        if this.curSelectGameNpcIndex == 1 then
            SetActive(this.rightBtn.gameObject, true)
        else
            SetActive(this.leftBtn.gameObject, true)
        end
    elseif #allDatas > 2 then
        if this.curSelectGameNpcIndex == 1 then
            SetActive(this.rightBtn.gameObject, true)
        elseif this.curSelectGameNpcIndex == #allDatas then
            SetActive(this.leftBtn.gameObject, true)
        else
            SetActive(this.leftBtn.gameObject, true)
            SetActive(this.rightBtn.gameObject, true)
        end
    end
    if #allDatas > 0 then
        this.RefreshNpcInfo()
        SetActive(this.gamePanel, true)
    end
    local count = 0
    for k, v in pairs(allDatas) do
        for k1, v1 in pairs(v.DescList) do
            count = count + 1
        end
    end
    this.progressText.text = string.format("%d/%d", count, maxCount)
    this.progressFill.fillAmount = count / maxCount
end

this.RefreshNpcInfo = function()
    local curNpcData = this.npcDatas[this.curSelectGameNpcIndex]
    SetActive(this.descText2.gameObject, #curNpcData.DescList > 1)
    this.descText1.text = curNpcData.DescList[1]
    if #curNpcData.DescList > 1 then
        this.descText2.text = curNpcData.DescList[2]
    end
    this.npcName.text = curNpcData.Name
    this.npcIcon.sprite = LuaMgr.GetSprite(JZQWConst.GameAtlasName, curNpcData.Icon)
end


this.OnClickCallback = function(item)
    if this.curSelectPage == JZQWConst.PageType.Novel then
        local playNovelCallback = function()
            LuaMgr.ShowLuaPanel(UIName.JZQWHomePanel)
            LuaMgr.ShowLuaPanel(UIName.JZQWRecollectionPopup)
        end
        JZQWData.SetIsChildPanel(true)
        LuaMgr.PlayNovel(item.data.eventParam, playNovelCallback)
        LuaMgr.HidePanel(UIName.JZQWRecollectionPopup)
    elseif this.curSelectPage == JZQWConst.PageType.Dungeon then
        JZQWData.SetIsChildPanel(true)
        local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
        enterDungeonParams.eventId = item.data.id
        enterDungeonParams.dungeonId = item.data.eventParam
        BattlePrepareMgr.BattlePrepare(enterDungeonParams)
        LuaMgr.HidePanel(UIName.JZQWRecollectionPopup)
    end
end

this.OnClickMaskBtn = function()
    LuaMgr.HidePanel(UIName.JZQWRecollectionPopup)
end

this.OnClickLeftBtn = function()
    local tempIndex = this.curSelectGameNpcIndex - 1
    if tempIndex <= 1 then
        SetActive(this.leftBtn.gameObject, false)
    end
    SetActive(this.rightBtn.gameObject, true)
    this.curSelectGameNpcIndex = tempIndex
    this.RefreshNpcInfo()
end

this.OnClickRightBtn = function()
    local tempIndex = this.curSelectGameNpcIndex + 1
    if tempIndex >= #this.npcDatas then
        SetActive(this.rightBtn.gameObject, false)
    end
    SetActive(this.leftBtn.gameObject, true)
    this.curSelectGameNpcIndex = tempIndex
    this.RefreshNpcInfo()
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
        LuaMgr.AddClick(this.leftBtn, this.OnClickLeftBtn)
        LuaMgr.AddClick(this.rightBtn, this.OnClickRightBtn)
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
        UIScrollView.ClearItem("JZQWRecollectionItem")
        this.curSelectGameNpcIndex = 0
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMaskBtn)
        LuaMgr.RemoveClick(this.leftBtn, this.OnClickLeftBtn)
        LuaMgr.RemoveClick(this.rightBtn, this.OnClickRightBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)
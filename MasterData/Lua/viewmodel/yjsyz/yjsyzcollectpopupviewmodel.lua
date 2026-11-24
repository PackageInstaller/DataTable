require("ViewModel/YJSYZ/YJSYZCollectPopupItem")
local this = {}

local objs = {
    prefab = {path = "template/MissionItem", type = UITool.GameObject},
    closeBtn = {path = "root/Middle/CollectPanel/CloseBtn", type = UITool.Button},
    maskCloseBtn = {path = "root/Middle/CollectPanel/Mask", type = UITool.Button},
    scrollView = {path = "root/Middle/CollectPanel/ScrollView", type = UITool.GameObject},
}

this.before_awake = function()
    this.scrollViewUI = UIScrollView.New(this.scrollView)
end

this.before_active = function()
    this:SetData()
end

this.OnClickCloseBtn = function()
    LuaMgr.HidePanel(UIName.YJSYZCollectPopupViewModel)
end

this.SetData = function()
    this.medalList = DataExHelper.GetMedalList("5170")
    this.scrollViewUI:Clear(false)
    local scrollDatas = {}
    for i, v in pairs(this.medalList) do
        local curScore = this.GetTotalScore(v.id)
        local groupData = {}
        groupData.data = v
        groupData.isFinish = curScore.Current >= curScore.Target
        groupData.progress = LuaMgr.GetLangText("YJSYZCollectPopupViewModel_0") .. tostring(curScore.Current) .. " / " .. tostring(curScore.Target)
        local scrollData = UIScrollData.GetData(this.prefab, "YJSYZCollectPopupItem", 620, 100, groupData)
        table.insert(scrollDatas, scrollData)
    end
    this.scrollViewUI:SetParams(650, 198)
    this.scrollViewUI:SetData(scrollDatas, true)
end

this.AddMedalList = function(list)
    for key, value in pairs(list) do
        table.insert(this.medalList, value)
    end
end

this.GetTotalScore = function(_id)
    if IsNull(DataMgr.Player.MedalStepMap[_id]) then
        return {Current = 0, Target = 1}
    end
    return DataMgr.Player.MedalStepMap[_id]
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.closeBtn, this.OnClickCloseBtn)
        LuaMgr.AddClick(this.maskCloseBtn, this.OnClickCloseBtn)
        this.before_awake()
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickCloseBtn)
        LuaMgr.RemoveClick(this.maskCloseBtn, this.OnClickCloseBtn)
        UIScrollView.ClearItem("YJSYZCollectPopupItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)
require("ViewModel/SongShiYouXin/ViewItem/SSYXBuildRewardItem")
local objs = {
    rewardItem = {path = "template/RewardItem", type = UITool.GameObject},
    closeBtn = {path = "root/Middle/CloseBtn", type = UITool.Button},
    maskBtn = {path = "root/Mask", type = UITool.Button},
    fastGetBtn = {path = "root/Middle/FastGetBtn", type = UITool.Button},
    rewardScroll = {path = "root/Middle/ScrollView", type = UITool.GameObject}
}

local this = {
    canGetCount = 0
}

this.before_awake = function()
    this.rewardScrollUI = UIScrollView.New(this.rewardScroll)
end

this.before_active = function()
    this.canGetCount = 0
    this.RefreshScrollList()
end

this.RefreshScrollList = function()
    this.rewardScrollUI:Clear(false)
    local allDatas, canGetCount = SSYXData.GetRewardQuestDatas()
    this.canGetCount = canGetCount
    local scrollDatas = {}
    for i = 1, #allDatas do
        local data = allDatas[i]
        data.OnGetReward = this.GetReward
        local scrollData = UIScrollData.GetData(this.rewardItem, "SSYXBuildRewardItem", 962, 95, data)
        table.insert(scrollDatas, scrollData)
    end
    this.rewardScrollUI:SetParams(962, 269)
    this.rewardScrollUI:SetData(scrollDatas, true)
end

this.OnClickCloseBtn = function()
    LuaMgr.HidePanel(UIName.SSYXSceneBuild1004)
end



this.GetReward = function(item)
    DataExHelper.EX_GetAward(item.data.Config.id, this.OnGetCallback)
end

this.OnClickFastGetBtn = function()
    if this.canGetCount == 0 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10453"))
        return
    end
    DataExHelper.EX_GetGroupAward(SSYXConst.QuestEventGroupId, this.OnGetCallback)
end

this.OnGetCallback = function()
    this.RefreshScrollList()
    local buildData = SSYXData.GetBuildDataByID(SSYXConst.BuildID.JieDao)
    LuaMgr.InvokeUIEventListeners(UIEventConst.SSYXRefreshGameScene, buildData)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.closeBtn, this.OnClickCloseBtn)
        LuaMgr.AddClick(this.maskBtn, this.OnClickCloseBtn)
        LuaMgr.AddClick(this.fastGetBtn, this.OnClickFastGetBtn)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.buildData = vm.behaviour.Params[0]
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickCloseBtn)
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickCloseBtn)
        LuaMgr.RemoveClick(this.fastGetBtn, this.OnClickFastGetBtn)
        UIScrollView.ClearItem("SSYXBuildRewardItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)
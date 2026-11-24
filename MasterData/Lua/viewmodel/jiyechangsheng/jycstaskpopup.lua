require("ViewModel/JiYeChangSheng/ViewItem/JYCSGameTaskItem")
local objs = {
    taskItemPrefab = {path = "template/TaskItemPrefab", type = UITool.GameObject},
    maskBtn = {path = "root/Mask", type = UITool.Button},
    taskScrollView = {path = "root/Right/ScrollView", type = UITool.GameObject}
}

local this = {}

this.before_awake = function()
    this.taskScrollViewUI = UIScrollView.New(this.taskScrollView)
end

this.before_active = function()
    this.RefreshTaskList()
end

this.RefreshTaskList = function()
    local scrollDatas = {}
    local allDatas = JYCSData.GetQuestEventDatas(JYCSConst.TaskEventIDName)
    table.sort(allDatas, this.SortDatas)
    for i = 1, #allDatas do
        local data = allDatas[i]
        data.Index = i
        data.OnClickGotReward = this.OnClickGotReward
        local scrollData = UIScrollData.GetData(this.taskItemPrefab, "JYCSGameTaskItem", 542, 59, data)
        table.insert(scrollDatas, scrollData)
    end
    this.taskScrollViewUI:SetParams()
    this.taskScrollViewUI:SetData(scrollDatas, true)
end

this.SortDatas = function(data1, data2)
    if data1.Status ~= CommonRewardItem.Status.CanGet and data2.Status == CommonRewardItem.Status.CanGet then
        return false
    elseif data1.Status == CommonRewardItem.Status.CanGet and data2.Status ~= CommonRewardItem.Status.CanGet then
        return true
    elseif data1.Status ~= CommonRewardItem.Status.Got and data2.Status == CommonRewardItem.Status.Got then
        return true
    elseif data1.Status == CommonRewardItem.Status.Got and data2.Status ~= CommonRewardItem.Status.Got then
        return false
    end
    return data1.Config.sort < data2.Config.sort
end


this.OnClickGotReward = function(item)
    local callback = function()
        this.RefreshTaskList()
        JYCSData.CheckRedPoint()
    end
    DataExHelper.EX_GetAward(item.data.QuestData.id, callback)
end

this.OnClickMaskBtn = function()
    LuaMgr.HidePanel(UIName.JYCSTaskPopup)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.maskBtn, this.OnClickMaskBtn)
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
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMaskBtn)
        UIScrollView.ClearItem("JYCSGameTaskItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)
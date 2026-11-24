require("ViewModel/JinZhongQiWu/ViewItem/JZQWTaskItem")
local objs = {
    chapterItem = {path = "template/ChapterItem", type = UITool.GameObject},
    eventItem = {path = "template/EventItem", type = UITool.GameObject},
    rewardItem = {path = "template/RewardItem", type = UITool.GameObject},
    scrollViewContent = {path = "root/Right/ScrollView/Viewport/Content", type = UITool.Transform},
    maskBtn = {path = "root/Mask", type = UITool.Button}
}

local this = {

    taskItems = nil,
    curShowChapterIndex = 0
}

this.before_awake = function()
end

this.before_active = function()
    local allDatas = JZQWGameData.GetAllChapterDatas()
    if this.taskItems == nil then
        this.taskItems = {}
        this.taskItems[JZQWConst.TaskItemType.Chapter] = {}
        this.taskItems[JZQWConst.TaskItemType.Event] = {}
        this.taskItems[JZQWConst.TaskItemType.Reward] = {}
        if this.curShowChapterIndex == 0 then
            this.curShowChapterIndex = 1
        end
        for i = 1, #allDatas do
            local tempChapterData = allDatas[i]
            local chapterItem = JZQWTaskItem.New(this.chapterItem, this.scrollViewContent, JZQWConst.TaskItemType.Chapter)
            table.insert(this.taskItems[JZQWConst.TaskItemType.Chapter], chapterItem)

            local chapterData = {}
            chapterData.Name = LuaMgr.GetLangText(tempChapterData.Config.NameLan)
            chapterData.Index = i
            chapterData.OnClickChapterItem = this.OnClickChapterItem
            chapterItem:SetData(chapterData)

            local tempChildItems = {}
            for j = 1, #tempChapterData.EventList do
                local eventItem = JZQWTaskItem.New(this.eventItem, this.scrollViewContent, JZQWConst.TaskItemType.Event)
                table.insert(this.taskItems[JZQWConst.TaskItemType.Event], eventItem)

                local tempEventData = tempChapterData.EventList[j]
                local eventData = {}
                eventData.Name = LuaMgr.GetLangText(tempEventData.Config.EventNameLan)
                eventData.Status = tempEventData.Status
                eventItem:SetData(eventData)
                table.insert(tempChildItems, eventItem)
            end

            local rewardItem = JZQWTaskItem.New(this.rewardItem, this.scrollViewContent, JZQWConst.TaskItemType.Reward)
            table.insert(this.taskItems[JZQWConst.TaskItemType.Reward], rewardItem)
            table.insert(tempChildItems, rewardItem)
            chapterItem:SetChildItems(tempChildItems, this.curShowChapterIndex == i)

            local rewardData = JZQWData.GetQuestDataByIndex(i)
            rewardData.callback = this.before_active
            rewardItem:SetData(rewardData)
        end
    else
        for i = 1, #allDatas do
            local tempChapterData = allDatas[i]
            local chapterItem = this.taskItems[JZQWConst.TaskItemType.Chapter][i]
            local chapterData = chapterItem.data
            chapterData.Name = LuaMgr.GetLangText(tempChapterData.Config.NameLan)
            chapterItem:SetData(chapterData)

            local tempChildItems = {}
            for j = 1, #tempChapterData.EventList do
                local eventItem = chapterItem.childItems[j]
                local tempEventData = tempChapterData.EventList[j]
                local eventData = {}
                eventData.Name = LuaMgr.GetLangText(tempEventData.Config.EventNameLan)
                eventData.Status = tempEventData.Status
                eventItem:SetData(eventData)
                table.insert(tempChildItems, eventItem)
            end

            local rewardItem = chapterItem.childItems[#tempChapterData.EventList + 1]
            local rewardData = JZQWData.GetQuestDataByIndex(i)
            rewardData.callback = this.before_active
            rewardItem:SetData(rewardData)
        end
    end
    JZQWData.CheckHomeRedPoint()
end



this.OnClickChapterItem = function(item)
    if item.data.Index == this.curShowChapterIndex then
        this.curShowChapterIndex = 0
    else
        local chapterItems = this.taskItems[JZQWConst.TaskItemType.Chapter]
        if this.curShowChapterIndex ~= 0 then
            local chapterItem = chapterItems[this.curShowChapterIndex]
            chapterItem:RefreshChapterStatus(false)
        end
        this.curShowChapterIndex = item.data.Index
        chapterItem = chapterItems[this.curShowChapterIndex]
        chapterItem:RefreshChapterStatus(true)
    end
end

this.OnClickMaskBtn = function()
    LuaMgr.HidePanel(UIName.JZQWGameTaskPopup)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
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
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMaskBtn)
        this.taskItems = nil
        this.curShowChapterIndex = 0
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)
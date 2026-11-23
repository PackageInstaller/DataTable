
local this = {
    vm = nil,
    newStoryIdList = {},
};

local data = {
    StoryList = {
        { bg = DefaultSprite, new = false, canReview = false, lock = false, anchoredPos = Vector2.zero }
    },
}

local anchoredPos1 = Vector2(0, -135)
local anchoredPos2 = Vector2(0, -338)

local command = {
    storyItemBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = param + 1
            if this.vm.data.StoryList[index].lock then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26231"));
                return
            end
            LuaMgr.PlayNovel(this.vm.data.StoryList[index].narrativeId, function()
                LuaMgr.ShowLuaPanel(UIName.RogueReviewViewModel)
            end)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.Refresh()
        RogueMgr.PlayBgm()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        for i, v in ipairs(this.newStoryIdList) do
            PlayerPrefs.SetInt(DataMgr.Player.uid .. "RogueStoryReview_" .. v, 1);
        end
    end,
    before_destroy = function(vm)
        this = nil;
    end
}

this.Refresh = function()
    this.newStoryIdList = {}
    local storyCfgs = ConfigMgr.Config.RogueConstants.RogueStory
    local bgName = "ui_hd_xhyt_jq"
    if RogueMgr.CurShowPage == 2 then
        storyCfgs = ConfigMgr.Config.RogueConstants.Rogue2Story
        bgName = "ui_hd_wsch_jq"
    end
    local tempList = {}
    for i, v in ipairs(storyCfgs) do
        local storyItem = {
            narrativeId = v
        }
        local bgIndex = i
        local tampBgName = ""
        if bgIndex < 10 then
            tampBgName = bgName .. "0" .. bgIndex
        else
            tampBgName = bgName .. bgIndex
        end
        storyItem.anchoredPos = i % 2 == 1 and anchoredPos1 or anchoredPos2
        storyItem.new = false
        local isComplete = DataHelper.CheckNovelComplete(v)
        storyItem.lock = not isComplete
        storyItem.canReview = isComplete
        if storyItem.lock then
            tampBgName = "ui_hd_xhyt_jqs"
        else
            storyItem.new = PlayerPrefs.GetInt(DataMgr.Player.uid .. "RogueStoryReview_" .. v, 0) == 0;
        end
        if storyItem.new then
            table.insert(this.newStoryIdList, v)
        end
        storyItem.bg = LuaMgr.GetSprite("Rogue", tampBgName)
        table.insert(tempList, storyItem)
    end
    this.vm.data.StoryList = tempList
end

return vm({
    data = data,
    command = command,
    hook = hook
})
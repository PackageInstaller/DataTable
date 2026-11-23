require("RhythmGame/ViewModel/RhythmGameGetBuffItem")
require("RhythmGame/ViewModel/RhythmGameBuffItem")

local this = {
    msBtDriveList = {},
};

local objs = {
    closeBtn = { path = "root/Middle/BG/Close", type = "Button" },
    startBtn = { path = "root/Middle/BG/Start", type = "Button" },
    getBuffItem = { path = "template/GetBuffItem", type = "GameObject" },
    buffItem = { path = "template/BuffItem", type = "GameObject" },
    scrollViewLeftGo = { path = "root/Middle/BG/ScrollViewLeft", type = "GameObject" },
    scrollViewRightGo = { path = "root/Middle/BG/ScrollViewRight", type = "GameObject" },
    tempLayoutGroup = { path = "template/BuffItemTemp", type = "VerticalLayoutGroup" },
    tempRec = { path = "template/BuffItemTemp", type = "RectTransform" },
    tempContentText = { path = "template/BuffItemTemp/contentText", type = "Text" },
    tempContentTextRec = { path = "template/BuffItemTemp/contentText", type = "RectTransform" },
};


this.SetData = function(data)
    this.data = data
    this.config = data.config
    this.eventMap = ConfigRhythmGameMgr.GetEventDriveContent(this.config.id)
    local getCurSaveBuffs = PlayerRhythmGameMgr.GetSaveEquipBuffs()
    PlayerRhythmGameMgr.SetEquipBuffs(nil)
    local maxNum = this.eventMap.quantityBUFF
    local num = 0
    for i, v in ipairs(getCurSaveBuffs) do
        if (string.match(this.eventMap.archiveBUFF, v.id)) then
            num = num + 1
            if (num <= maxNum) then
                PlayerRhythmGameMgr.SetEquipBuffs(v)
            end
        end
    end
    this.Init()
end

this.Init = function()
    if (this.heightMap ~= nil) then
        this.SetScrollViewLeft()
        this.SetScrollViewRight()
        PlayerRhythmGameMgr.CheckBuffNewDot(this.eventMap)
        RedMgr.Singleton:Refresh()
    else
        this.InitBuffHeightMap()
    end
end

this.InitBuffHeightMap = function()
    this.heightMap = {}
    if this.startDelay ~= nil then
        coroutine_runner.stop(this.startDelay)
    end
    this.startDelay = coroutine_runner.start(function()
        local list = NumTool.split(this.eventMap.archiveBUFF, ";");
        for k, v in pairs(list) do
            local config = ConfigMgr.Config.MsBtDriveMap[v]
            local buff = ConfigRhythmGameMgr.GetBuffById(config.buffID)
            this.tempContentText.text = LuaMgr.GetLangText(buff.DescriptionLan)
            this.tempLayoutGroup:SetLayoutVertical()
            coroutine_runner.waitForEndOfFrame();
            local height = this.tempRec.sizeDelta.y
            if(height < 140)then
                height = 140
            end
            this.heightMap[config.buffID] = height
        end
        this.SetScrollViewLeft()
        this.SetScrollViewRight()
        PlayerRhythmGameMgr.CheckBuffNewDot(this.eventMap)
        RedMgr.Singleton:Refresh()
    end)
end

this.SetScrollViewLeft = function()
    this.scrollViewLeft:Clear(false);
    local scrollDatasLeft = {}
    local list = NumTool.split(this.eventMap.archiveBUFF, ";");

    for i, v in ipairs(list) do
        local data = {}
        data.index = i
        data.config = ConfigMgr.Config.MsBtDriveMap[v]
        data.height = this.heightMap[data.config.buffID]
        local scrollData = UIScrollData.GetData(this.buffItem, "RhythmGameBuffItem", 749, data.height + 10 , data);
        table.insert(scrollDatasLeft, scrollData);
    end
    this.scrollViewLeft:SetParams(760, 500);
    this.scrollViewLeft:SetData(scrollDatasLeft, false);
end

this.SetScrollViewRight = function()
    this.scrollViewRight:Clear(false);
    local scrollDatas = {}
    for i = 1, 3 do
        local data = {}
        data.unlock = i <= this.eventMap.quantityBUFF
        data.maxNum = this.eventMap.quantityBUFF
        data.index = i
        local scrollData = UIScrollData.GetData(this.getBuffItem, "RhythmGameGetBuffItem", 104, 130, data);
        table.insert(scrollDatas, scrollData);
    end
    this.scrollViewRight:SetParams(172, 375);
    this.scrollViewRight:SetData(scrollDatas, false);
end

this.UpdateEquipBuff = function(...)
    local getCurBuffs = PlayerRhythmGameMgr.GetEquipBuffs()
    local num = #getCurBuffs
    if (num > this.eventMap.quantityBUFF) then
        table.remove(getCurBuffs, num)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("2254"));
    end
    this.Init()
end



this.OnClickClose = function()
    LuaMgr.HidePanel(UIName.RhythmGameChapterBuffViewModel);
end


this.OnClickStart = function()
    PlayerRhythmGameMgr.SaveEquipBuffs()
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
    enterDungeonParams.eventId = this.data.config.id;
    enterDungeonParams.dungeonId = this.data.config.eventParam;
    BattlePrepareMgr.BattlePrepare(enterDungeonParams);
    LuaMgr.HidePanel(UIName.RhythmGameChapterBuffViewModel);
end

local data = {}
local command = {}



local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose);
        LuaMgr.AddClick(this.startBtn, this.OnClickStart);
        this.scrollViewLeft = UIScrollView.New(this.scrollViewLeftGo);
        this.scrollViewRight = UIScrollView.New(this.scrollViewRightGo);
        LuaMgr.AddUIEventListener(UIEventConst.RhythmGameEquipBuff, this.UpdateEquipBuff);
        RedMgr.Singleton:RegisterViewModel(UIName.RhythmGameChapterBuffViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.SetData(vm.behaviour.Params[0]);
    end,
    before_deactive = function(vm)
        this.scrollViewLeft:Clear(true);
        this.scrollViewRight:Clear(true);
        if (not coroutine_runner.checkIsDestory()) and this.startDelay ~= nil then
            coroutine_runner.stop(this.startDelay);
            this.startDelay = nil;
        end
        this.heightMap = nil
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose);
        LuaMgr.RemoveClick(this.startBtn, this.OnClickStart);
        UIScrollView.ClearItem("RhythmGameGetBuffItem");
        UIScrollView.ClearItem("RhythmGameBuffItem");
        LuaMgr.RemoveUIEventListener(UIEventConst.RhythmGameEquipBuff, this.UpdateEquipBuff);
        RedMgr.Singleton:RemoveViewModel(UIName.RhythmGameChapterBuffViewModel);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})
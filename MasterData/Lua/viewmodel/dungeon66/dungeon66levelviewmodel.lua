require("ViewModel/Dungeon66/Dungeon66LevelItem")

local this = {
    scrollView = nil,
    campSeries = nil,
    levelDatas = nil,
}

local objs = {
    levelItem = { path = "template/LevelItem", type = "GameObject" },
    scrollViewGO = { path = "root/Middle/ScrollView", type = "GameObject" },
    time = { path = "root/Middle/Time/Text", type = "Text" },
    msg = { path = "root/Middle/Msg/Text", type = "Text" },
    buffEffectBtn = { path = "root/Middle/BuffEffectBtn", type = "Button" },
    talentTreeBtn = { path = "root/Middle/TalentTreeBtn", type = "Button" },
    rewardBtn = { path = "root/Middle/Reward", type = "Button" },
    rewardText = { path = "root/Middle/Reward/Text", type = "Text" },
}


this.SetData = function()
    local curSeriesId=TrainingCampMgr.GetCurWheelSeriesID();
    if curSeriesId==nil then
        print("lose config for curSeries")
        return
    end;
    this.campSeries = TrainingCampMgr.GetCampSeries(curSeriesId);
    if (this.levelDatas == nil) then
        this.levelDatas = TrainingCampMgr.GetCampPlots(this.campSeries.ID);
    end
    this.msg.text = LuaMgr.GetLangText(this.campSeries.DescLan);
    this.SetTime();
    this.SetLevelList();
    this.SetLevelStar();
end


this.SetTime = function()
    local summerCamp = DataExHelper.GetDataExByTag(ActivityKey.SummerCamp);
    if (summerCamp == nil) then return end
    
    local time = summerCamp.expireTime - LuaMgr.Timestamp();
    local timeStr = "";
    local d, h, m = GetTimeDHM(time);
    if (not IsNullOrEmpty(d)) then
        timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"));
    end
    if (not IsNullOrEmpty(h)) then
        timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("10366"));
    end
    if (not IsNullOrEmpty(m)) then
        timeStr = timeStr .. string.format("%s%s", m, ConfigMgr.LangGlobal("10367"));
    end
    this.time.text = string.format(LuaMgr.GetLangText("Dungeon66LevelViewModel_1"), timeStr);
end


this.SetLevelList = function()
    local scrollWidth = LuaMgr.GetScreenWidth();
    this.scrollView:Clear(false);
    local scrollData;
    local scrollDatas = {};
    local len = #this.levelDatas;
    for i = 1, len do
        scrollData = UIScrollData.GetData(this.levelItem, "Dungeon66LevelItem", 277, 400, {config=this.levelDatas[i], index=i});
        table.insert(scrollDatas, scrollData);
    end
    this.scrollView:SetParams(scrollWidth, 400);
    this.scrollView:SetPadding(0, 0, 0, 0);
    this.scrollView:SetData(scrollDatas, true);
end


this.SetLevelStar = function()
    local star = TrainingCampMgr.GetTotalStar(this.campSeries.ID);
    local maxStar = #this.levelDatas * 2 * 3;
    this.rewardText.text = string.format("%d/%d", star, maxStar);
end


this.OnClickBuffEffect = function()
    LuaMgr.ShowLuaPanel(UIName.Dungeon66BuffPopup)
end


this.OnClickTalentTree = function()
    LuaMgr.ShowLuaPanel(UIName.Dungeon66TechViewModel)
end


this.OnClickReward = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.SummerCamp) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("15901"));
        return
    end
    LuaMgr.ShowLuaPanel(UIName.Dungeon66RewardViewModel);
end


this.OnRewardGoto = function(index)
    this.scrollView:MoveToIndex(index);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.scrollView = UIScrollView.New(this.scrollViewGO);
        LuaMgr.AddClick(this.buffEffectBtn, this.OnClickBuffEffect);
        LuaMgr.AddClick(this.talentTreeBtn, this.OnClickTalentTree);
        LuaMgr.AddClick(this.rewardBtn, this.OnClickReward);
        RedMgr.Singleton:RegisterViewModel(UIName.Dungeon66LevelViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.AddUIEventListener(UIEventConst.Dungeon66RewardGoto, this.OnRewardGoto);
        this.SetData();
        HeroRedDataHelper.SetDungeon66Red();
        RedMgr.Singleton:Refresh();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.Dungeon66RewardGoto, this.OnRewardGoto);
        this.scrollView:Clear(true);
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.buffEffectBtn, this.OnClickBuffEffect);
        LuaMgr.RemoveClick(this.talentTreeBtn, this.OnClickTalentTree);
        LuaMgr.RemoveClick(this.rewardBtn, this.OnClickReward);
        RedMgr.Singleton:RemoveViewModel(UIName.Dungeon66LevelViewModel);
        UIScrollView.ClearItem("Dungeon66LevelItem");
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})
require("ViewModel/SpringCamp/SpringCampLevelItem")
require("ViewModel/SpringCamp/SpringCampNightLevelItem")
local this = {
    scrollView = nil,
    campSeries = nil,
    levelDatas = nil,
}

local objs = {
    levelItem = { path = "template/LevelItem", type = "GameObject" },
    nightlevelItem = { path = "template/Item", type = "GameObject" },
    scrollViewGO = { path = "root/Middle/ScrollView", type = "GameObject" },
    scrollViewAni = { path = "root/Middle/ScrollView", type = "Animator" },
    time = { path = "root/Middle/Time/Text", type = "Text" },
    msg = { path = "root/Middle/Msg/Text", type = "Text" },
    buffEffectBtn = { path = "root/Middle/BuffEffectBtn", type = "Button" },
    talentTreeBtn = { path = "root/Middle/TalentTreeBtn", type = "Button" },
    rewardBtn = { path = "root/Middle/Reward", type = "Button" },
    rewardText = { path = "root/Middle/Reward/Text", type = "Text" },
    normalToggle = { path = "root/Middle/switchType/NormalToggle", type = "Toggle" },
    nightToggle = { path = "root/Middle/switchType/NightToggle", type = "Toggle" },
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

    local levelType = PlayerPrefs.GetInt("SpringCampLevelType",0)


    if levelType == 0 then
        if this.normalToggle.isOn == true then
            this.SetLevelList();
        end
        this.normalToggle.isOn = true
        this.nightToggle.isOn = false
    else
        if this.nightToggle.isOn == true then
            this.SetNightLevelList();
        end
        this.normalToggle.isOn = false
        this.nightToggle.isOn = true
    end
    
    this.SetLevelStar();
end


this.SetTime = function()
    local summerCamp = DataExHelper.GetDataExByTag(ActivityKey.SpringCamp);
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
    this.time.text = string.format(LuaMgr.GetLangText("SpringCampLevelViewModel_0"), timeStr);
end


this.SetLevelList = function()
    local scrollWidth = LuaMgr.GetScreenWidth();
    this.scrollView:Clear(false);
    local scrollData;
    local scrollDatas = {};
    local len = #this.levelDatas;
    for i = 1, len do
        scrollData = UIScrollData.GetData(this.levelItem, "SpringCampLevelItem", 277, 400, {config=this.levelDatas[i], index=i});
        table.insert(scrollDatas, scrollData);
    end
    this.scrollView:SetParams(277 * 4, 400);
    this.scrollView:SetPadding(0, 0, 0, 0);
    this.scrollView:SetData(scrollDatas, true);
end


this.SetNightLevelList = function()
    local scrollWidth = LuaMgr.GetScreenWidth();
    this.scrollView:Clear(false);
    local scrollData;
    local scrollDatas = {};
    local len = #this.levelDatas;
    for i = 1, len do
        scrollData = UIScrollData.GetData(this.nightlevelItem, "SpringCampNightLevelItem", 277, 232, {config=this.levelDatas[i], index=i});
        table.insert(scrollDatas, scrollData);
    end
    this.scrollView:SetParams(277 * 4, 400);
    this.scrollView:SetPadding(0, 0, 0, 0);
    this.scrollView:SetData(scrollDatas, true);
end


this.SetLevelStar = function()
    local star = TrainingCampMgr.GetTotalStar(this.campSeries.ID);
    local maxStar = #this.levelDatas * 3 * 3;
    this.rewardText.text = string.format("%d/<color=#1c664b>%d</color>", star, maxStar);
end


this.OnClickBuffEffect = function()
    LuaMgr.ShowLuaPanel(UIName.SpringCampBuffPopup)
end


this.OnClickTalentTree = function()
    LuaMgr.ShowLuaPanel(UIName.SpringCampTechViewModel)
end


this.OnClickReward = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.SpringCamp) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("15901"));
        return
    end
    LuaMgr.ShowLuaPanel(UIName.SpringCampRewardViewModel);
end

this.SwitchToNight = function(state)
    if state then

        this.scrollViewAni:Play("ani_SpringCampLevelPanel_ScrollView_01",0,0)
        for i, v in pairs(this.scrollView.itemMap) do
            v:Hide()
        end
        LuaMgr.NextFrame(function()
            PlayerPrefs.SetInt("SpringCampLevelType",1)
            this.SetNightLevelList()
            this.scrollViewAni:Play("ani_SpringCampLevelPanel_ScrollView_02",0,0) 
        end,15)
    end

end

this.SwitchToNormal = function(state)
    if state then
        this.scrollViewAni:Play("ani_SpringCampLevelPanel_ScrollView_01",0,0)
        for i, v in pairs(this.scrollView.itemMap) do
            v:Hide()
        end
        LuaMgr.NextFrame(function()
            PlayerPrefs.SetInt("SpringCampLevelType",0)
            this.SetLevelList()
            this.scrollViewAni:Play("ani_SpringCampLevelPanel_ScrollView_02",0,0) 
        end,15)
    end

end


this.OnRewardGoto = function(index)
    this.scrollView:MoveToIndex(index);
    LuaMgr.Hide(UIName.SpringCampRewardViewModel)
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
        this.normalToggle.onValueChanged:AddListener(this.SwitchToNormal)
        this.nightToggle.onValueChanged:AddListener(this.SwitchToNight)
        RedMgr.Singleton:RegisterViewModel(UIName.SpringCampLevelViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        if vm.behaviour.Params.Length>0 then
            
        end
        
        LuaMgr.AddUIEventListener(UIEventConst.SpringCampRewardGoto, this.OnRewardGoto);
        this.SetData();
        HeroRedDataHelper.SetSpringCampRed();
        RedMgr.Singleton:Refresh();
        LuaMgr.NextFrame(function()
            this.scrollViewAni:Play("ani_SpringCampLevelPanel_ScrollView_02",0,0)
        end,15)
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.SpringCampRewardGoto, this.OnRewardGoto);
        this.scrollView:Clear(true);
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.buffEffectBtn, this.OnClickBuffEffect);
        LuaMgr.RemoveClick(this.talentTreeBtn, this.OnClickTalentTree);
        LuaMgr.RemoveClick(this.rewardBtn, this.OnClickReward);
        RedMgr.Singleton:RemoveViewModel(UIName.SpringCampLevelViewModel);
        UIScrollView.ClearItem("SpringCampLevelItem");
        UIScrollView.ClearItem("SpringCampNightLevelItem");
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})
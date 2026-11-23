local this =
{
    canFightArea = nil,
    abyssCantFigthMsg = nil,
    activityKey = nil,
    medalActivityID = "fusang"
};

local objs = {
    sandTableBtn = { path = "root/Right/SandTable", type = "Button" },
    storyBtn = { path = "root/Right/Story", type = "Button" },
    videoBtn = { path = "root/Right/Video", type = "Button" },
    missionBtn = { path = "root/Right/Mission", type = "Button" },
    missionLock = { path = "root/Right/Mission/bgLock", type = "GameObject" },
    signInBtn = { path = "root/Left/SignIn", type = "Button" },
    textRatio = { path = "root/Left/SignIn/TextRatio", type = "Text" },
    rewardBtn = { path = "root/Left/Reward", type = "Button" },
    dayText = { path = "root/Middle/TimeImg/TextTime", type = "Text" },
    bg1 = { path = "root/Bg1", type = "GameObject" },
};




this.SetData = function()
    this.activityKey = ActivityKey.WMFC
    SetActive(this.sandTableBtn.gameObject, true)
    SetActive(this.videoBtn.gameObject, false)
    this.dayText.text = WMFCMgr.GetTimeStr()

    this.canFightArea = PlayerAreaMapMgr.CheckAreaCanFight("zhengzhuan").area
    local abyssCanFight, abyssCantFight = PlayerAreaMapMgr.CheckAreaCanFight("abyss")
    this.abyssCantFigthMsg = nil
    if (abyssCanFight == nil) then
        local tipName = LuaMgr.GetLangText(ConfigMgr.Config.dungeonMap[abyssCantFight.unlockParam].NameLan)
        local tipStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["12002"].NameLan), tipName)
        this.abyssCantFigthMsg = tipStr
    end
    local finishMedalCount1 = DataExHelper.GetMedalFinishCount(this.medalActivityID)
    local medalList1 = DataExHelper.GetMedalList(this.medalActivityID)
    this.medalList = {}
    for key, value in pairs(medalList1) do
        table.insert(this.medalList, value)
    end
    this.textRatio.text = string.format(LuaMgr.GetLangText("CrisisContract2MainViewModel_0"), finishMedalCount1,
        #this.medalList)
end


this.OnBack = function()
    if DataExHelper.CommonActivityCheck(this.activityKey) then
        LuaMgr.Back(this.activityKey)
    else
        LuaMgr.Back()
    end
end


this.OnClickStory = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.WMFCNovelViewModel)
    end
end


this.OnClickVideo = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.PlayVideoViewModel, "Main6_PV")
    end
end


this.OnClickMission = function()
    if this.CheckActivityRunning() then
        if (this.abyssCantFigthMsg == nil) then
            LuaMgr.ShowLuaPanel(UIName.AreaMapViewModel, this.canFightArea, 2099)
        else
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", this.abyssCantFigthMsg)
        end
    end
end


this.OnClickSandTable = function()
    if this.CheckActivityRunning() then
        if (RedMgr.Singleton:CheckRedCondition("17305")) then
            RedMgr.Singleton:FrushRedCondition("17305")
        end
        LuaMgr.ShowLuaPanel(UIName.AreaMapViewModel, this.canFightArea)
    end
end


this.OnClickReward = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.WMFCShopViewModel);
    end
end




this.OnClickSignIn = function()
    if this.CheckActivityRunning() then
        local data = {}
        data.medalActivityID = this.medalActivityID
        data.medalColor = "#3d6053"
        data.medalImgKey = "ui_hd_ty_dtyl_bt_wmfc"
        data.bgmPath = "Assets/_BundleResources/Audio/Bgm/Bgm_Map_7.mp3"
        LuaMgr.ShowLuaPanel(UIName.PassesMain2ViewModel, data);
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.storyBtn, this.OnClickStory);
        LuaMgr.AddClick(this.videoBtn, this.OnClickVideo);
        LuaMgr.AddClick(this.missionBtn, this.OnClickMission)
        LuaMgr.AddClick(this.rewardBtn, this.OnClickReward);
        LuaMgr.AddClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.AddClick(this.sandTableBtn, this.OnClickSandTable);
        RedMgr.Singleton:RegisterViewModel(UIName.WMFCHomeViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        HeroRedDataHelper.SetWMFCRed()
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.SetData();












    end,
    before_deactive = function(vm)
        if this.flyDoTween ~= nil then
            this.flyDoTween.onComplete = nil
            this.flyDoTween:Kill()
            this.flyDoTween = nil
        end
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.storyBtn, this.OnClickStory);
        LuaMgr.RemoveClick(this.videoBtn, this.OnClickVideo);
        LuaMgr.RemoveClick(this.missionBtn, this.OnClickMission)
        LuaMgr.RemoveClick(this.rewardBtn, this.OnClickReward);
        LuaMgr.RemoveClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.RemoveClick(this.sandTableBtn, this.OnClickSandTable);
        RedMgr.Singleton:RemoveViewModel(UIName.WMFCHomeViewModel);




    end
}


this.CheckActivityRunning = function()
    if not DataExHelper.CommonActivityCheck(this.activityKey) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        return false;
    end
    return true;
end


return vm({
    data = data,
    command = command,
    hook = hook
})
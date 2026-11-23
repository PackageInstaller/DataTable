local this = {
    medalActivityID = "4190"
};

local objs = {
    bgRt = { path = "root/Bg", type = "RectTransform" },
    sandTableBtn = { path = "root/Middle/Right/SandTable", type = "Button" },
    storyBtn = { path = "root/Middle/Right/Story", type = "Button" },
    gameBtn = { path = "root/Middle/Right/Game", type = "Button" },
    signInBtn = { path = "root/Middle/Left/SignIn", type = "Button" },
    textRatio = { path = "root/Middle/Left/SignIn/Image/TextRatio", type = "Text" },
    rewardBtn = { path = "root/Middle/Left/Reward", type = "Button" },
    dayText = { path = "root/Middle/TimeImg/TextTime", type = "Text" },
};


this.SetData = function()
    this.dayText.text = XCHDMgr.GetTimeStr()
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
    if DataExHelper.CommonActivityCheck(ActivityKey.XCHD) then
        LuaMgr.Back(ActivityKey.XCHD)
    else
        LuaMgr.Back()
    end
end


this.OnClickStory = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.XCHDNovelViewModel);
    end
end


this.OnClickSandTable = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.XCHDLevelViewModel);
    end
end


this.OnClickReward = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.XCHDShopViewModel);
    end
end


this.OnClickSignIn = function()
    if this.CheckActivityRunning() then
        local data = {}
        data.medalActivityID = this.medalActivityID
        data.medalColor = "#3d6053"
        data.medalImgKey = "ui_hd_ty_dtyl_bt_rsrh"
        data.bgmPath = "Assets/_BundleResources/Audio/Bgm/Bgm_xchd.mp3"
        LuaMgr.ShowLuaPanel(UIName.PassesMain2ViewModel, data)
    end
end

this.OnClickGame = function()
    if this.CheckActivityRunning() then
        SimulateRoomMgr.Open();
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.storyBtn, this.OnClickStory);
        LuaMgr.AddClick(this.rewardBtn, this.OnClickReward);
        LuaMgr.AddClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.AddClick(this.sandTableBtn, this.OnClickSandTable);
        LuaMgr.AddClick(this.gameBtn, this.OnClickGame);
        RedMgr.Singleton:RegisterViewModel(UIName.XCHDMainViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        HeroRedDataHelper.SetXCHDRed()
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.SetData();








    end,
    before_deactive = function(vm)

    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.storyBtn, this.OnClickStory);
        LuaMgr.RemoveClick(this.rewardBtn, this.OnClickReward);
        LuaMgr.RemoveClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.RemoveClick(this.sandTableBtn, this.OnClickSandTable);
        LuaMgr.RemoveClick(this.gameBtn, this.OnClickGame);
        RedMgr.Singleton:RemoveViewModel(UIName.XCHDMainViewModel);
        if (this.spineGO ~= nil) then
            LuaMgr.Destroy(this.spineGO);
            this.spineGO = nil;
        end
    end
}


this.CheckActivityRunning = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.XCHD) then
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
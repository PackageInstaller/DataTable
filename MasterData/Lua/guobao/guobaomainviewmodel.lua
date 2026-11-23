require("GuoBao/GuoBaoMgr")

local this = {
    spineGO = nil,
    aniName = "ani_GuoBaoMainPanel_root",
    aniName01 = "ani_GuoBaoMainPanel_root_01",
};

local objs = {
    animator = { path = "root", type = "UIAnimator" },
    middleTF = { path = "root/Middle", type = "Transform" },
    dayText = { path = "root/Right/Time/Day", type = "Text" },
    shopBtn = { path = "root/Left/Shop", type = "Button" },
    shopRedDot = { path = "root/Left/Shop/RedDot", type = "GameObject" },
    missionBtn = { path = "root/Left/Mission", type = "Button" },
    missionRedDot = { path = "root/Left/Mission/RedDot", type = "GameObject" },
    novelBtn = { path = "root/Right/Group/Novel", type = "Button" },
    novelRedDot = { path = "root/Right/Group/Novel/RedDot", type = "GameObject" },
    levelBtn = { path = "root/Right/Group/Level", type = "Button" },
    levelRedDot = { path = "root/Right/Group/Level/RedDot", type = "GameObject" },
    manageBtn = { path = "root/Right/Group/Manage", type = "Button" },
    manageRedDot = { path = "root/Right/Group/Manage/RedDot", type = "GameObject" },
};


this.SetData = function()
    local timeStr = "";
    local guobao = DataExHelper.GetDataExByTag(ActivityKey.GuoBao);
    if (guobao ~= nil) then
        local time = guobao.expireTime - LuaMgr.Timestamp();
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
    end
    this.dayText.text = timeStr;
end


this.SetKV = function()
    if (this.spineGO ~= nil) then return end
    
    local path = "Assets/_BundleResources/UI/KV/KVGJBZ.prefab";
    this.spineGO = LuaMgr.GetPrefab(path);
    local spineTF = this.spineGO.transform;
    local logo = spineTF:Find("logo");
    SetActive(logo.gameObject, false);
    spineTF:SetParent(this.middleTF, false);
end


this.OnClickShop = function()
    if (PlayerGuoBaoMgr.CheckActivityStatus()) then
        LuaMgr.ShowLuaPanel(UIName.GuoBaoShopViewModel);
    end
end


this.OnClickMission = function()
    if (PlayerGuoBaoMgr.CheckActivityStatus()) then
        LuaMgr.ShowLuaPanel(UIName.PassesMainViewModel);
    end
end


this.OnClickNovel = function()
    if (PlayerGuoBaoMgr.CheckActivityStatus()) then
        LuaMgr.ShowLuaPanel(UIName.GuoBaoNovelViewModel);
    end
end


this.OnClickLevel = function()
    if (PlayerGuoBaoMgr.CheckActivityStatus()) then
        PlayerGuoBaoMgr.SetLevelType(GuoBaoActivity.Main);
        LuaMgr.ShowLuaPanel(UIName.GuoBaoLevelViewModel);
    end
end


this.OnClickManage = function()
    if (PlayerGuoBaoMgr.CheckActivityStatus()) then
        GuoBaoMgr.Open();
    end
end


this.OnAniDelay = function()
    LuaMgr.RemoveTimer(TimerConst.GuoBaoMainAniDelay);
    this.animator.AnimationName = this.aniName;
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.shopBtn, this.OnClickShop);
        LuaMgr.AddClick(this.missionBtn, this.OnClickMission);
        LuaMgr.AddClick(this.novelBtn, this.OnClickNovel);
        LuaMgr.AddClick(this.levelBtn, this.OnClickLevel);
        LuaMgr.AddClick(this.manageBtn, this.OnClickManage);
        RedMgr.Singleton:RegisterViewModel(UIName.GuoBaoMainViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.HidePanel(UIName.NonsenseChickViewModel);
        if (not vm.behaviour.IsPop) then
            if (GuoBaoMgr.IsFirstPage()) then
                LuaMgr.ShowLuaPanel(UIName.GuoBaoFirstPageViewModel);
                this.animator.AnimationName = this.aniName01;
                LuaMgr.AddTimer(TimerConst.GuoBaoMainAniDelay, this.OnAniDelay, 4, 1, false);
            else
                this.animator.AnimationName = this.aniName;
            end
            GuoBaoMgr.SetFirstPage(true);
        else
            this.animator.AnimationName = this.aniName;
        end
        HeroRedDataHelper.SetGuoBaoRed();
        RedMgr.Singleton:Refresh();
        this.SetData();
        this.SetKV();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.GuoBaoMainAniDelay);
        RedMgr.Singleton:RefreshOtherViewModel(UIName.GuoBaoMainViewModel);
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.shopBtn, this.OnClickShop);
        LuaMgr.RemoveClick(this.missionBtn, this.OnClickMission);
        LuaMgr.RemoveClick(this.novelBtn, this.OnClickNovel);
        LuaMgr.RemoveClick(this.levelBtn, this.OnClickLevel);
        LuaMgr.RemoveClick(this.manageBtn, this.OnClickManage);
        RedMgr.Singleton:RemoveViewModel(UIName.GuoBaoHomeViewModel);
        if (this.spineGO ~= nil) then
            LuaMgr.Destroy(this.spineGO);
            this.spineGO = nil;
        end
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})
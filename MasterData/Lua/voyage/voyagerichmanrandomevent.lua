VoyageRichManRandomEvent = {}

local this = {
    eventGO = nil,
    eventTF = nil,
    eventConfig = nil,
    eventData = nil,
    animator = nil,
    animators = {"ani_HH_terrain02_11_roll_Red", "ani_HH_terrain02_11_roll_Blue", "ani_HH_terrain02_11_roll_Yellow"},
};

VoyageRichManRandomEvent.Init = function(container)
    this.eventGO = LuaMgr.GetPrefab("Assets/_BundleResources/Voyage/HH_terrain02_11_p.prefab");
    this.eventTF = this.eventGO.transform;
    this.eventTF:SetParent(container, false);
    this.animator = this.eventGO:GetComponent("UIAnimator");
    SetActive(this.eventGO, false);
end

VoyageRichManRandomEvent.Show = function(grid, event)
    this.eventConfig = grid.config;
    this.eventData = event;
    this.eventTF.localPosition = grid.pos;
    SetActive(this.eventGO, true);
    local aniName = this.animators[math.random(1, 3)];
    this.animator.AnimationName = aniName;
    VoyageRichManTimeMgr.AddTime(1.5, this.OnTimer, nil);
end

VoyageRichManRandomEvent.Destroy = function()
    LuaMgr.RemoveTimer(0);
    this.eventConfig = nil;
    this.eventData = nil;
    if (this.eventGO ~= nil) then
        LuaMgr.DestroyImmediateGO(this.eventGO);
        this.eventGO = nil;
        this.eventTF = nil;
    end
end

this.OnTimer = function()
    SetActive(this.eventGO, false);
    LuaMgr.ShowLuaPanel(UIName.VoyageRichManEventViewModel, this.eventConfig, this.eventData);
end
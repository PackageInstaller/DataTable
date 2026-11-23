require("Parkour/ParkourConst")
require("Parkour/ParkourMap")
require("Parkour/ParkourMapBgItem")
require("Parkour/ParkourMapObstacleMgr")
require("Parkour/ParkourMapObstacleItem")
require("Parkour/ParkourMapItemMgr")
require("Parkour/ParkourMapItemItem")
require("Parkour/ParkourMissionItem")
require("Parkour/ParkourCharacter")

local this = {
    obstacleMap = nil,
    itemMap = nil,
    missionList = nil,
    levelConfig = nil,
    rewardProgressSize = Vector2(256, 10),
    aniName = "ani_ParkourPanel_root_001",
    rewardTipsAniName = "ani_ParkourPanel_root_RewardTips",
    rewardTipsHideAniName = "ani_ParkourPanel_root_RewardTips_hide",
    isTouchDown = false,
    touchPosY = 0,
    boxMission = nil,
    scoreMission = nil,
    frameRate = nil,
};

local objs = {
    animator = { path = "root", type = "UIAnimator" },
    mapBgItem = { path = "template/MapBgItem", type = "GameObject" },
    mapObstacle1 = { path = "template/MapObstacle1", type = "GameObject" },
    mapObstacle2 = { path = "template/MapObstacle2", type = "GameObject" },
    mapObstacle3 = { path = "template/MapObstacle3", type = "GameObject" },
    mapObstacle4 = { path = "template/MapObstacle4", type = "GameObject" },
    mapObstacle5 = { path = "template/MapObstacle5", type = "GameObject" },
    mapObstacle6 = { path = "template/MapObstacle6", type = "GameObject" },
    mapObstacle7 = { path = "template/MapObstacle7", type = "GameObject" },
    mapItem1 = { path = "template/MapItem1", type = "GameObject" },
    mapItem2 = { path = "template/MapItem2", type = "GameObject" },
    mapItem3 = { path = "template/MapItem3", type = "GameObject" },
    mapItem4 = { path = "template/MapItem4", type = "GameObject" },
    mapItem5 = { path = "template/MapItem5", type = "GameObject" },
    mapItem6 = { path = "template/MapItem6", type = "GameObject" },
    mapItem7 = { path = "template/MapItem7", type = "GameObject" },
    mapTF = { path = "root/Map", type = "Transform" },
    touchEvent = { path = "root/Touch", type = "EventTriggerListener" },
    touchGroup = { path = "root/Touch/Group", type = "GameObject" },
    touchUp = { path = "root/Touch/Group/Up", type = "GameObject" },
    touchDown = { path = "root/Touch/Group/Down", type = "GameObject" },
    upEvent = { path = "root/Right/Up", type = "EventTriggerListener" },
    downEvent = { path = "root/Right/Down", type = "EventTriggerListener" },
    character = { path = "root/Map/Character", type = "UISpineCharacter" },

    fxParkourInvincible = { path = "root/Map/Character/Group/fx_parkour_invincible", type = "GameObject" },
    fxParkourSpeed = { path = "root/Map/Character/Group/fx_parkour_speed", type = "GameObject" },
    fxParkourAdsorb = { path = "root/Map/Character/Group/fx_parkour_adsorb", type = "GameObject" },
    fxParkourRecover = { path = "root/Map/Character/Group/fx_parkour_recover", type = "GameObject" },
    hp1Animator = { path = "root/Left/HpBar/List/Hp1", type = "UIAnimator" },
    hp2Animator = { path = "root/Left/HpBar/List/Hp2", type = "UIAnimator" },
    hp3Animator = { path = "root/Left/HpBar/List/Hp3", type = "UIAnimator" },
    hp4Animator = { path = "root/Left/HpBar/List/Hp4", type = "UIAnimator" },
    hp5Animator = { path = "root/Left/HpBar/List/Hp5", type = "UIAnimator" },
    score = { path = "root/Middle/Score/Text", type = "Text" },
    rewardProgress = { path = "root/Left/Reward/Progress/Mask", type = "RectTransform" },
    pauseBtn = { path = "root/Right/Pause", type = "Button" },
    rewardTips = { path = "root/Middle/RewardTips", type = "GameObject" },
    missionItem = { path = "template/MissionItem", type = "GameObject" },
    missionTF = { path = "root/Right/Mission", type = "Transform" },
};


this.OnBack = function()
    if (ParkourMap.IsResult()) then return end
    
    ParkourMap.Pause();
    LuaMgr.ShowLuaPanel(UIName.ParkourPauseViewModel);
end


this.SetData = function()
    this.ClearTouch();
    this.ClearEffects();
    ParkourMap.Init(this.levelConfig, this.mapBgItem, this.obstacleMap, this.itemMap, this.mapTF);
    ParkourCharacter.Init(this.character, "ED90201", "ED90201", this.SetHpBar, this.SetScore, this.SetRewardTime, this.SetRewardTips, this.SetEffect);
    ParkourCharacter.SetHistoryScore(this.levelConfig.LevelID);
    this.SetHpBar(0);
    this.missionList:Clear();
    this.scoreMission = nil;
    this.SetScore();
    this.SetRewardTime();
    this.SetRewardTips(false, false);
end


this.SetEffect = function(effName, status)
    local obj = this[effName];
    if (IsObjectNull(obj)) then return end
    
    if (status and obj.activeSelf) then
        SetActive(obj, false);
    end
    SetActive(obj, status);
end


this.ClearEffects = function()

    SetActive(this.fxParkourInvincible, false);
    SetActive(this.fxParkourSpeed, false);
    SetActive(this.fxParkourAdsorb, false);
    SetActive(this.fxParkourRecover, false);
end


this.SetHpBar = function(status)
    local hp = ParkourCharacter.GetHp();
    local maxHp = ParkourCharacter.GetMaxHp();
    for i = 1, maxHp do
        local animator = this["hp"..i.."Animator"];
        if (status == 1) then
            if (i == hp) then
                animator.AnimationName = "ani_ParkourPanel_HpItem_002";
            end
        elseif (status == -1) then
            if (i == hp + 1) then
                animator.AnimationName = "ani_ParkourPanel_HpItem_001";
            end
        else
            animator.AnimationName = "ani_ParkourPanel_HpItem_002";
        end
    end
end


this.SetMission = function()
    local listDatas = {};


    local historyScore = ParkourCharacter.GetHistoryScore();
    local score = ParkourCharacter.GetScore();
    if (historyScore < this.levelConfig.Score and score >= this.levelConfig.Score) then
        if (this.scoreMission == nil) then
            this.scoreMission = UIListData.GetData(this.missionItem, "ParkourMissionItem", 2);
            table.insert(listDatas, this.scoreMission);
        end
    end
    if (#listDatas > 0) then
        this.missionList:SetData(listDatas);
    end
end


this.SetScore = function()
    local score = ParkourCharacter.GetScore();
    this.score.text = tostring(score);
    this.SetMission();
end


this.SetRewardTime = function()
    local progress = 0;
    if (ParkourCharacter.IsRewardTime()) then
        progress = ParkourCharacter.GetRewardTimeProgress();
    else
        local rewardNum = ParkourCharacter.GetRewardNum();
        if (rewardNum >= this.levelConfig.RewardNum) then
            ParkourCharacter.RewardNum(this.levelConfig.RewardTime);
        end
        progress = rewardNum / this.levelConfig.RewardNum;
    end
    this.rewardProgressSize.x = progress * 256;
    this.rewardProgress.sizeDelta = this.rewardProgressSize;
end


this.SetRewardTips = function(status, isAni)
    if (status) then
        SetActive(this.rewardTips, status);
        this.animator.AnimationName = this.rewardTipsAniName;
    else
        if (isAni) then
            this.animator.AnimationName = this.rewardTipsHideAniName;
        else
            SetActive(this.rewardTips, status);
        end
    end
end


this.ClearTouch = function()
    this.touchPosY = 0;
    this.isTouchDown = false;
    ParkourCharacter.SetDirection(0);
    SetActive(this.touchGroup, false);
    SetActive(this.touchDown, false);
    SetActive(this.touchUp, false);
end


this.OnTouchDown = function()
    local pos = UnityEngine.Input.mousePosition;
    this.touchPosY = pos.y;
    this.isTouchDown = true;
    SetActive(this.touchGroup, true);
end


this.OnTouchUp = function()
    this.ClearTouch();
end


this.OnTouchLongPress = function()
    if (this.isTouchDown) then
        local pos = UnityEngine.Input.mousePosition;
        if (pos.y > this.touchPosY) then
            ParkourCharacter.SetDirection(1);
            SetActive(this.touchUp, true);
            SetActive(this.touchDown, false);
        elseif (pos.y < this.touchPosY) then
            ParkourCharacter.SetDirection(-1);
            SetActive(this.touchUp, false);
            SetActive(this.touchDown, true);
        else
            ParkourCharacter.SetDirection(0);
            SetActive(this.touchUp, false);
            SetActive(this.touchDown, false);
        end
        if (ConfigMgr.Config.DHConstants.UpdateCoord == 1) then
            this.touchPosY = pos.y;
        end
    end
end


this.OnUpDown = function()
    ParkourCharacter.SetDirection(1);
end


this.OnUpUp = function()
    ParkourCharacter.SetDirection(0);
end


this.OnDownDown = function()
    ParkourCharacter.SetDirection(-1);
end


this.OnDownUp = function()
    ParkourCharacter.SetDirection(0);
end


this.OnRestart = function()
    ParkourMap.Clear();
    ParkourCharacter.Clear();
    this.SetData();
    ParkourMap.Show();
end


this.OnClickPause = function()
    if (ParkourMap.IsResult()) then return end
    
    ParkourMap.Pause();
    LuaMgr.ShowLuaPanel(UIName.ParkourPauseViewModel);
end


this.OnAniPlayFinish = function(args)
    if (args.Length <= 0) then return end

    local aniName = args[0];
    if (aniName == this.rewardTipsHideAniName) then
        SetActive(this.rewardTips, false);
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.obstacleMap = {};
        for i = 1, 7 do
            local id = tostring(i);
            this.obstacleMap[id] = this["mapObstacle" .. id];
        end
        this.itemMap = {};
        for i = 1, 7 do
            local id = tostring(i);
            this.itemMap[id] = this["mapItem" .. id];
        end
        this.touchEvent.onDown = this.OnTouchDown;
        this.touchEvent.onUp = this.OnTouchUp;
        this.touchEvent.onLongPress = this.OnTouchLongPress;
        this.upEvent.onDown = this.OnUpDown;
        this.upEvent.onUp = this.OnUpUp;
        this.downEvent.onDown = this.OnDownDown;
        this.downEvent.onUp = this.OnDownUp;
        this.missionList = UIListView.New(this.missionTF);
        LuaMgr.AddClick(this.pauseBtn, this.OnClickPause);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        this.frameRate = CS.UnityEngine.Application.targetFrameRate;
        CS.UnityEngine.Application.targetFrameRate = 30;
        vm.behaviour:UpdateTopBar("", this.OnBack);
        LuaMgr.AddUIEventListener(UIEventConst.ParkourRestart, this.OnRestart);
        LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAniPlayFinish);
        this.levelConfig = vm.behaviour.Params[0];
        this.SetData();
        ParkourMap.Show();
        this.animator.AnimationName = this.aniName;
    end,
    before_deactive = function(vm)
        if (this.frameRate ~= nil) then
            CS.UnityEngine.Application.targetFrameRate = this.frameRate;
            this.frameRate = nil;
        end
        LuaMgr.RemoveUIEventListener(UIEventConst.ParkourRestart, this.OnRestart);
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAniPlayFinish);
        if (vm.behaviour.Params ~= nil) then
            ParkourMap.Clear();
            ParkourCharacter.Clear();
            this.missionList:Clear();
            this.boxMission = nil;
            this.scoreMission = nil;
        end
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.pauseBtn, this.OnClickPause);
        ParkourMap.Destroy();
        UIListView.ClearItem("ParkourMissionItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})
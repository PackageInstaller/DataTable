ParkourMap = {};

local this = {
    levelConfig = nil,
    screenWidth = 0,
    halfWidth = 0,
    offsetWidth = 0,
    bgSpeed = 3,
    moveSpeed = 10,
    speedStatus = false,
    speedStatusTime = 0,
    mapBgList = nil,
    mapBgPath = "Assets/_BundleResources/Images/Parkour/%s.png",
    mapBgItem1 = nil,
    mapBgItem2 = nil,
    mapBgIndex = 1,
    rectX = 0,
    showMinX = 0,
    isPlay = false,
    audioPath = "Assets/_BundleResources/Audio/Parkour/%s.mp3",
    isResult = false,
    oldTime = 0,
    gameTime = 0,
};

ParkourMap.Init = function(levelConfig, mapBgItem, obstacleMap, itemMap, mapTF)
    this.levelConfig = levelConfig;
    local obstaclesTF = mapTF:Find("Obstacles");
    ParkourMapObstacleMgr.Init(levelConfig, obstacleMap, obstaclesTF);
    local itemsTF = mapTF:Find("Items");
    ParkourMapItemMgr.Init(levelConfig, itemMap, itemsTF);
    this.screenWidth = LuaMgr.ScreenWidth();
    this.halfWidth = this.screenWidth / 2;
    this.rectX = 0;
    this.showMinX = -this.halfWidth -500;
    this.isPlay = true;
    this.isResult = false;
    this.gameTime = 0;
    ParkourMap.SetSpeedStatus(true);
    this.offsetWidth = 0;
    this.mapBgList = {};
    local len = #this.levelConfig.BgRes;
    for i = 1, len do
        this.mapBgList[i] = LuaMgr.GetTexture(string.format(this.mapBgPath, this.levelConfig.BgRes[i]));
    end
    local bgsTF = mapTF:Find("Bgs");
    if (this.mapBgItem1 == nil) then
        this.mapBgItem1 = ParkourMapBgItem.New(mapBgItem, bgsTF);
    end
    if (this.mapBgItem2 == nil) then
        this.mapBgItem2 = ParkourMapBgItem.New(mapBgItem, bgsTF);
    end
    this.SetMapBg();
    this.SetObstacleItem();
end

ParkourMap.Show = function()
    ParkourMap.Stop();
    this.oldTime = ParkourMap.TimestampMS();
    LuaMgr.AddUpdate(this.OnUpdate);
    ParkourMap.PlayAudio("DH_parkour_6");
    LuaMgr.ShowLuaPanel(UIName.ParkourTipsViewModel, 1);
end

ParkourMap.Clear = function()
    LuaMgr.RemoveUpdate(this.OnUpdate);
    ParkourMapObstacleMgr.Clear();
    ParkourMapItemMgr.Clear();
    this.levelConfig = nil;
    this.mapBgList = nil;
end

ParkourMap.Destroy = function()
    this.DestroyMapBg();
    ParkourMap.Clear();
    ParkourMapObstacleMgr.Destroy();
    ParkourMapItemMgr.Destroy();
end

ParkourMap.Play = function()
    this.isPlay = true;
end

ParkourMap.Stop = function()
    this.isPlay = false;
end

ParkourMap.Pause = function()
    ParkourMap.Stop();
    LuaMgr.ShowLuaPanel(UIName.ParkourPauseViewModel);
end

ParkourMap.Time = function()
    return this.gameTime;
end

ParkourMap.TimestampMS = function()
    return LuaMgr.TimestampMS();
end

ParkourMap.PlayAudio = function(id)
    AudioMgr.Singleton:PlayUISFX(string.format(this.audioPath, id));
end


ParkourMap.SetSpeedStatus = function(status)
    this.speedStatus = status;
    if (status) then
        this.bgSpeed = ConfigMgr.Config.DHConstants.ParkourBgSpeed_1;
        this.moveSpeed = ConfigMgr.Config.DHConstants.ParkourItemSpeed_1;
        this.speedStatusTime = ParkourMap.Time() + ConfigMgr.Config.DHConstants.ParkourBgSpeedTime;
    else
        this.bgSpeed = ConfigMgr.Config.DHConstants.ParkourBgSpeed;
        this.moveSpeed = ConfigMgr.Config.DHConstants.ParkourItemSpeed;
    end
end


ParkourMap.IsResult = function()
    return this.isResult;
end


ParkourMap.ParkourReward = function()
    this.isResult = true;
    if (DataExHelper.CommonActivityCheck(ActivityKey.DunHuang)) then
        local score = ParkourCharacter.GetScore();
        ApiMgr.Request("dunhuang/parkourReward", {LevelId=this.levelConfig.LevelID, Score=score}, true, this.ParkourRewardResponse, nil, true, true);
    else
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"));
        LuaMgr.ShowLuaPanel(UIName.MainPageViewModel);
    end
end


this.ParkourRewardResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        local levelConfig = this.levelConfig;
        LuaMgr.ShowLuaPanel(UIName.ParkourResultViewModel, levelConfig);
    end
end


this.CheckSpeedStatus = function()
    if (this.speedStatus) then
        local time = ParkourMap.TimestampMS();
        if (time >= this.speedStatusTime) then
            ParkourMap.SetSpeedStatus(false);
        else
            local dhConstants = ConfigMgr.Config.DHConstants;
            local rate = 1 - (this.speedStatusTime - time) / dhConstants.ParkourBgSpeedTime;
            local addSpeed = dhConstants.ParkourBgSpeed - dhConstants.ParkourBgSpeed_1;
            local speed = math.floor(rate * addSpeed * 100) * 0.01;
            this.bgSpeed = dhConstants.ParkourBgSpeed_1 + speed;
            addSpeed = dhConstants.ParkourItemSpeed - dhConstants.ParkourItemSpeed_1;
            speed = math.floor(rate * addSpeed * 100) * 0.01;
            this.moveSpeed = dhConstants.ParkourItemSpeed_1 + speed;
        end
    end
end


this.SetMapBg = function()
    local x = -(this.screenWidth - 1680) / 2;
    this.mapBgItem1:SetData(this.mapBgList[this.mapBgIndex], x + this.offsetWidth);
    this.mapBgIndex = this.mapBgIndex + 1;
    if (this.mapBgIndex > #this.mapBgList) then
        this.mapBgIndex = 1;
    end
    this.mapBgItem2:SetData(this.mapBgList[this.mapBgIndex], x + 1680 + this.offsetWidth);
    this.offsetWidth = this.offsetWidth + 1680;
end


this.SetMapBgPos = function(speedRate)
    local distance = this.bgSpeed * speedRate
    this.offsetWidth = this.offsetWidth - distance;
    this.mapBgItem1:Move(distance);
    this.mapBgItem2:Move(distance);
    if (this.offsetWidth <= 0) then
        this.SetMapBg();
    end
end


this.DestroyMapBg = function()
    if (this.mapBgItem1 ~= nil) then
        this.mapBgItem1:Destroy();
        this.mapBgItem1 = nil;
    end
    if (this.mapBgItem2 ~= nil) then
        this.mapBgItem2:Destroy();
        this.mapBgItem2 = nil;
    end
end


this.SetObstacleItem = function()
    local rectMinX = this.rectX - this.halfWidth - 500;
    local rectMaxX = this.rectX + this.halfWidth + 500;
    ParkourMapObstacleMgr.Update(this.rectX, rectMinX, rectMaxX, this.showMinX);
    ParkourMapItemMgr.Update(this.rectX, rectMinX, rectMaxX, this.showMinX);
end


this.OnUpdate = function()
    local nowTime = ParkourMap.TimestampMS();
    local time = nowTime - this.oldTime;
    this.oldTime = nowTime;
    ParkourCharacter.CheckSubHpEffect();
    ParkourCharacter.CheckMoveOffScreen();
    if (this.isPlay) then
        this.gameTime = this.gameTime + time;
        ParkourCharacter.Update();
        if (not ParkourCharacter.IsMoveOffScreen()) then
            this.CheckSpeedStatus();
            local speedRate = ParkourCharacter.GetSpeedRate();
            this.rectX = this.rectX + this.moveSpeed * speedRate;
            this.SetMapBgPos(speedRate);
            ParkourCharacter.Move();
            if (not this.isResult) then
                ParkourCharacter.AddScore(ParkourMapItem.Distance);
            end
            this.SetObstacleItem();
        end
    end
end
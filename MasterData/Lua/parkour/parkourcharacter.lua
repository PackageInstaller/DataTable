ParkourCharacter = {};

local this = {
    characterTF = nil,
    characterMaterial = nil,
    character = nil,
    direction = 0,
    pos = Vector3(0, 0, 0),
    moveMinY = -290,
    moveMaxY = 250,
    speed = 10,
    hp = 0,
    maxHp = 0,
    speedRate = 1,
    speedUpTime = 0,
    invincibleTime = 0,
    magnetTime = 0,
    score = 0,
    coins1 = 0,
    coins2 = 0,
    setHpBar = nil,
    setScore = nil,
    rewardStartTime = 0,
    rewardEndTime = 0,
    rewardNum = 0,
    setRewardNum = nil,
    moveOffScreen = nil,
    moveOffScreenX = 0,
    historyScore = 0,
    setRewardTips = nil,
    setEffect = nil,
    subHpColor = UnityEngine.Color(1,1,1,1),
    subHpColorStep = 0,
    subHpColorTime = 0,
    isResult = false,
};

ParkourCharacter.Init = function(character, characterId, skinId, setHpBar, setScore, setRewardNum, setRewardTips, setEffect)
    this.character = character;
    this.setHpBar = setHpBar;
    this.setScore = setScore;
    this.setRewardNum = setRewardNum;
    this.setRewardTips = setRewardTips;
    this.setEffect = setEffect;
    this.characterTF = character.transform;
    local characterImg = this.characterTF:GetComponent("RawImage");
    this.characterMaterial = characterImg.material;
    this.pos.y = 0;
    this.hp = 5;
    this.maxHp = 5;
    this.speed = ConfigMgr.Config.DHConstants.ParkourSpeed;
    this.speedRate = 1;
    this.speedUpTime = 0;
    this.invincibleTime = 0;
    this.magnetTime = 0;
    this.score = 0;
    this.coins1 = 0;
    this.coins2 = 0;
    this.rewardStartTime = 0;
    this.rewardNum = 0;
    this.moveOffScreenX = 0;
    this.pos.x = -390;
    this.characterTF.localPosition = this.pos;
    this.character:SetBattle(characterId, skinId, "-1", 0, this.OnCharacter);
    this.isResult = false;
end

this.OnCharacter = function()
    this.character:Play("run", true, nil);
    this.SpineTimeScale(1);
    this.SetSubHpColor(1, 1, 1);
end

ParkourCharacter.Clear = function()
    this.setHpBar = nil;
    this.setScore = nil;
    this.setRewardNum = nil;
    this.moveOffScreen = nil;
    this.setRewardTips = nil;
    this.setEffect = nil;
    this.characterTF = nil;
    this.characterMaterial = nil;
    if (this.character ~= nil) then
        this.character:Clear();
        this.character = nil;
    end
end

ParkourCharacter.SetDirection = function(direction)
    this.direction = direction;
end

ParkourCharacter.GetCharacterTF = function()
    return this.characterTF;
end

ParkourCharacter.Move = function()
    if (this.direction == 0) then return end
    
    local y = this.pos.y + this.direction * this.speed;
    if (y > this.moveMaxY) then
        y = this.moveMaxY;
    end
    if (y < this.moveMinY) then
        y = this.moveMinY;
    end
    this.pos.y = y;
    this.characterTF.localPosition = this.pos;
end

ParkourCharacter.MoveOffScreen = function(callback)
    this.moveOffScreen = callback;
    this.moveOffScreenX = LuaMgr.ScreenWidth() / 2 + 100;
    this.setRewardTips(false, false);
    this.isResult = true;
end

ParkourCharacter.IsMoveOffScreen = function()
    return this.moveOffScreenX > 0;
end

ParkourCharacter.Update = function()
    this.CheckSpeedUp();
    this.CheckInvincible();
    this.CheckMagnet();
    this.CheckRewardNum();
end


ParkourCharacter.SpeedUp = function()
    this.speedRate = ConfigMgr.Config.DHConstants.ParkourSpeedUp;
    this.speedUpTime = ParkourMap.Time() + ConfigMgr.Config.DHConstants.ParkourSpeedUpTime;
    this.SpineTimeScale(this.speedRate);
    this.setEffect(ParkourMapEffect.SpeedUp, true);
end


ParkourCharacter.GetSpeedRate = function()
    return this.speedRate;
end


ParkourCharacter.Invincible = function()
    this.invincibleTime = ParkourMap.Time() + ConfigMgr.Config.DHConstants.ParkourInvincibleTime;
    this.setEffect(ParkourMapEffect.Invincible, true);
end


ParkourCharacter.IsInvincible = function()
    return this.invincibleTime > 0;
end


ParkourCharacter.Magnet = function()
    this.magnetTime = ParkourMap.Time() + ConfigMgr.Config.DHConstants.ParkourAdsorbTime;
    this.setEffect(ParkourMapEffect.Magnet, true);
end


ParkourCharacter.IsMagnet = function()
    return this.magnetTime > 0;
end


ParkourCharacter.RewardNum = function(time)
    local timestampMS = ParkourMap.Time();
    this.rewardStartTime = timestampMS;
    this.rewardEndTime = timestampMS + time;
    this.speedRate = ConfigMgr.Config.DHConstants.ParkourSpeedUp;
    local nowTime = ParkourMap.Time();
    this.speedUpTime = nowTime + time;
    this.SpineTimeScale(this.speedRate);
    this.invincibleTime = nowTime + time;
    this.magnetTime = nowTime + time;
    this.setRewardTips(true, true);
    this.setEffect(ParkourMapEffect.Invincible, true);
    this.setEffect(ParkourMapEffect.SpeedUp, true);
    this.setEffect(ParkourMapEffect.Magnet, true);
end


ParkourCharacter.GetRewardNum = function()
    return this.rewardNum;
end


ParkourCharacter.IsRewardTime = function()
    return this.rewardStartTime > 0;
end


ParkourCharacter.GetRewardTimeProgress = function()
    local total = this.rewardEndTime - this.rewardStartTime;
    local time = this.rewardEndTime - ParkourMap.Time();
    return time / total;
end


ParkourCharacter.AddHp = function(hp)
    this.setEffect(ParkourMapEffect.AddHp, true);
    if (this.hp >= this.maxHp) then return end
    
    this.hp = this.hp + hp;
    this.setHpBar(1);
end


ParkourCharacter.SubHp = function(hp)
    if (this.isResult) then return end
    if (this.invincibleTime > 0) then return end
    if (this.hp <= 0) then return end
    
    this.hp = this.hp - hp;
    this.setHpBar(-1);
    this.PlaySubHpEffect();
    if (this.hp <= 0) then
        ParkourMapItemMgr.Clear();
        ParkourMap.Stop();
        LuaMgr.ShowLuaPanel(UIName.ParkourTipsViewModel, 3);
    end
end


ParkourCharacter.GetHp = function()
    return this.hp;
end


ParkourCharacter.GetMaxHp = function()
    return this.maxHp;
end


ParkourCharacter.AddScore = function(type)
    local score = 0;
    if (type == ParkourMapItem.Distance) then
        score = ConfigMgr.Config.DHConstants.DistanceScore;
    elseif (type == ParkourMapItem.Coins1) then
        this.coins1 = this.coins1 + 1;
        if (this.rewardStartTime == 0) then
            this.rewardNum = this.rewardNum + 1;
        end
        score = ConfigMgr.Config.DHConstants.SmallCoinScore;
    elseif (type == ParkourMapItem.Coins2) then
        this.coins2 = this.coins2 + 1;
        score = ConfigMgr.Config.DHConstants.BigCoinScore;
    elseif (type == ParkourMapItem.Box) then
        score = 0;
    end
    this.score = this.score + score;
    this.setScore();
    this.setRewardNum();
end


ParkourCharacter.GetScore = function()
    return this.score;
end


ParkourCharacter.GetCoins1 = function()
    return this.coins1;
end


ParkourCharacter.GetCoins2 = function()
    return this.coins2;
end


ParkourCharacter.SetHistoryScore = function(levelId)
    this.historyScore = 0;
    local dunHuang = DataMgr.Player.DunHuang;
    if (dunHuang ~= nil) then
        local score = dunHuang.ParkourMap[levelId];
        if (score ~= nil) then
            this.historyScore = score;
        end
    end
end


ParkourCharacter.GetHistoryScore = function()
    return this.historyScore;
end


this.SpineTimeScale = function(timeScale)
    this.character:SetAnimationStateTimeScale(timeScale);
end


this.CheckSpeedUp = function()
    if (this.speedUpTime == 0) then return end

    if (ParkourMap.Time() > this.speedUpTime) then
        this.speedRate = 1;
        this.speedUpTime = 0;
        this.SpineTimeScale(1);
        this.setEffect(ParkourMapEffect.SpeedUp, false);
    end
end


this.CheckInvincible = function()
    if (this.invincibleTime == 0) then return end

    if (ParkourMap.Time() > this.invincibleTime) then
        this.invincibleTime = 0;
        this.setEffect(ParkourMapEffect.Invincible, false);
    end
end


this.CheckMagnet = function()
    if (this.magnetTime == 0) then return end

    if (ParkourMap.Time() > this.magnetTime) then
        this.magnetTime = 0;
        this.setEffect(ParkourMapEffect.Magnet, false);
    end
end


this.CheckRewardNum = function()
    if (this.rewardStartTime == 0) then return end

    this.setRewardNum();
    if (ParkourMap.Time() > this.rewardEndTime) then
        this.rewardStartTime = 0;
        this.rewardEndTime = 0;
        this.rewardNum = 0;
        this.setRewardTips(false, true);
    end
end


ParkourCharacter.CheckMoveOffScreen = function()
    if (this.moveOffScreenX == 0) then return false end
    
    local x = this.pos.x + this.speed * 2;
    this.pos.x = x;
    this.characterTF.localPosition = this.pos;
    if (x >= this.moveOffScreenX) then
        this.moveOffScreenX = 0;
        this.moveOffScreen();
    end
    return true;
end


this.SetSubHpColor = function(r, g, b)
    this.subHpColor.r = r;
    this.subHpColor.g = g;
    this.subHpColor.b = b;
    this.characterMaterial:SetColor("_TintColor", this.subHpColor);
end


this.PlaySubHpEffect = function()
    this.SetSubHpColor(0.86, 0.66, 0.66);
    this.subHpColorStep = 1;
    this.subHpColorTime = ParkourMap.Time() + 0.05;
end


ParkourCharacter.CheckSubHpEffect = function()
    if (this.subHpColorStep == 0) then return end

    local time = ParkourMap.Time();
    if (time >= this.subHpColorTime) then
        if (this.subHpColorStep == 1) then
            this.SetSubHpColor(1, 1, 1);
            this.subHpColorStep = 2;
            this.subHpColorTime = time + 0.05;
        elseif (this.subHpColorStep == 2) then
            this.SetSubHpColor(0.86, 0.66, 0.66);
            this.subHpColorStep = 3;
            this.subHpColorTime = time + 0.05;
        else
            this.SetSubHpColor(1, 1, 1);
            this.subHpColorStep = 0;
        end
    end
end
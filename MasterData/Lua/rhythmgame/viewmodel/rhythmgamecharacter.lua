RhythmGameCharacter = {}

local this = {
    spine = nil,
    startGame = nil,
    clickAniNames = {"MUS_combo01", "MUS_combo02", "MUS_combo03"},
    clickAniNameIndex = 0,
    clickCount = 0,
    isConvert = false,
    resultStatus = 0,
};

RhythmGameCharacter.Init = function(spine, startGame)
    this.spine = spine;
    this.startGame = startGame;
    local musicConfig = PlayerRhythmGameMgr.GetMusicConfig();
    local skinId = musicConfig.character;
    local characterId = string.sub(skinId, 1, 5);
    this.spine:SetBattle(characterId, skinId, "-1", 0, this.OnInit);
    this.clickCount = 0;
    this.isConvert = false;
    this.resultStatus = 0;
end

RhythmGameCharacter.Clear = function()
    this.startGame = nil;
    this.clickAniNameIndex = 0;
    if (this.spine ~= nil) then
        this.spine:Clear();
        this.spine = nil;
    end
end


this.PlayIdle = function()
    if (RhythmGameMgr.isEnergy) then
        this.spine:Play("MUS_idle_energy", true, nil);
    else
        this.spine:Play("MUS_idle", true, nil);
    end
end


this.OnInit = function()
    this.spine:Play("MUS_born", false, this.OnBorn);
end


this.OnBorn = function(aniName)
    this.spine:Play("MUS_idle", true, nil);
    this.startGame();
end


RhythmGameCharacter.PlayEnergy = function(isEnergy)
    if (this.spine == nil) then return end

    this.isConvert = true;
    if (isEnergy and this.clickCount == -1) then return end
    
    this.spine:Play(isEnergy and "MUS_convert01" or "MUS_convert02", false, this.OnConvert);
end


this.OnConvert = function(aniName)
    this.isConvert = false;
    this.PlayIdle();
end


RhythmGameCharacter.PlayClick = function(note)
    if (this.clickCount == -1) then return end
    if (this.isConvert) then return end
    if (RhythmGameMgr.isEnergy) then return end

    this.clickCount = this.clickCount + 1;
    if (this.clickCount < 10) then return end

    this.clickCount = -1;
    local index = this.clickAniNameIndex;
    local len = #this.clickAniNames;
    while (this.clickAniNameIndex == index) do
        index = math.random(1, len);
    end
    this.clickAniNameIndex = index;
    this.spine:Play(this.clickAniNames[index], false, this.OnClick);
end


this.OnClick = function()
    this.clickCount = 0;
    if (this.isConvert) then
        this.spine:Play("MUS_convert01", false, this.OnConvert);
        return;
    end
    this.PlayIdle();
end


RhythmGameCharacter.PlayResult = function(isDelay)
    if (this.resultStatus == 3) then
        this.CheckWinOrLose();
        return;
    end
    this.resultStatus = 1;
    if (isDelay) then
        LuaMgr.AddTimer(TimerConst.RhythmGameResultDelay, this.OnResultDelay, 2, 1, false);
    else
        this.OnResultDelay();
    end
end


this.OnResultDelay = function()
    if (RhythmGameMgr.isEnergy) then
        this.spine:Play("MUS_convert02", false, this.OnResultConvert);
    else
        this.CheckWinOrLose();
    end
end


this.OnResultConvert = function()
    this.CheckWinOrLose();
end


this.CheckWinOrLose = function()
    if (RhythmGameMgr.Data.hp > 0) then
        this.spine:Play("MUS_victory", false, this.OnResultVictory);
    else
        this.spine:Play("MUS_lose", false, this.OnResultLose);
    end
end


this.OnResultVictory = function()
    if (this.resultStatus == 3) then
    else
        this.resultStatus = 2;
        this.spine:Play("MUS_victory_sustain", true, nil);
    end
    RhythmGameMgr.SendCompleteSong();
end


this.OnResultLose = function()
    this.resultStatus = 2;
    this.spine:Play("MUS_lose_sustain", true, nil);
    LuaMgr.ShowLuaPanel(UIName.RhythmGameLoseViewModel);
end


RhythmGameCharacter.IsResultComplete = function()
    return this.resultStatus == 2;
end


RhythmGameCharacter.PlayEnd = function()
    this.resultStatus = 3;
end
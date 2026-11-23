require("RhythmGame/ViewModel/RhythmGameWinConditionItem")

local this = {
    conditionList = nil,
    rootAniName = "ani_RhythmGamewinPanel_apper",
    isScoreNew = false,
    judgeAniName = "",
    typeStr = nil,
};

local objs = {
    animator = { path = "root", type = "UIAnimator" },
    characterBody = { path = "root/Middle/Character/Body", type = "DrawingAdjustTool" },
    characterSpine = { path = "root/Middle/Character/Body", type = "UISpineCharacter" },
    nameBg = { path = "root/Left/Name", type = "Image" },
    name = { path = "root/Left/Name/Text", type = "Text" },
    level = { path = "root/Left/Level/Text", type = "Text" },
    conditionTF = { path = "root/Left/Condition", type = "Transform" },
    conditionItem = { path = "template/ConditionItem", type = "GameObject" },
    countS = { path = "root/Left/Count/S/Text", type = "Text" },
    countA = { path = "root/Left/Count/A/Text", type = "Text" },
    countB = { path = "root/Left/Count/B/Text", type = "Text" },
    countMiss = { path = "root/Left/Count/Miss/Text", type = "Text" },
    countPrecise = { path = "root/Left/Count/Precise/Text", type = "Text" },
    countLose = { path = "root/Left/Count/Lose/Text", type = "Text" },
    rightAnimator = { path = "root/Right", type = "UIAnimator" },
    score = { path = "root/Right/Score/Text", type = "Text" },
    scoreNew = { path = "root/Right/Score/New", type = "GameObject" },
    judgeGO = { path = "root/Right/Judge", type = "GameObject" },
    judgeImg = { path = "root/Right/Judge", type = "Image" },
    msg = { path = "root/Right/Msg/Text", type = "UIText" },
    restartBtn = { path = "root/Right/Restart", type = "Button" },
    continueBtn = { path = "root/Right/Continue", type = "Button" },
};


this.SetData = function()
    local musicConfig,typeStr = PlayerRhythmGameMgr.GetMusicConfig();
    this.typeStr = typeStr
    if (musicConfig == nil) then return end
    
    local musicSongConfig = ConfigRhythmGameMgr.GetMusicSongByEventId(musicConfig.id,typeStr);
    if (musicSongConfig == nil) then return end

    local musicSongData = PlayerRhythmGameMgr.GetMusicSong(musicSongConfig.id,typeStr);
    if (musicSongData == nil) then return end
    
    this.name.text = musicConfig.name;
    this.level.text = LuaMgr.GetLangText("RhythmGameWinViewModel_0") .. tostring(musicConfig.rank);
    this.SetCondition(musicConfig, musicSongData);
    this.countS.text = tostring(RhythmGameMgr.Data.perfect);
    this.countA.text = tostring(RhythmGameMgr.Data.great);
    this.countB.text = tostring(RhythmGameMgr.Data.good);
    this.countMiss.text = tostring(RhythmGameMgr.Data.miss);
    local precise = (RhythmGameMgr.Data.perfectCount / RhythmGameMgr.Data.allNoteCount) * 100;
    if (precise > 0 and precise < 1) then
        precise = 1;
    end
    this.countPrecise.text = string.format("%dB", math.floor(precise));
    local lose = (RhythmGameMgr.Data.missCount / RhythmGameMgr.Data.allNoteCount) * 100;
    if (lose > 0 and lose < 1) then
        lose = 1;
    end
    this.countLose.text = string.format("%dB", math.floor(lose));
    this.score.text = tostring(RhythmGameMgr.Data.score);
    local historyScore = PlayerRhythmGameMgr.GetHistoryScore();
    this.isScoreNew = musicSongData.score > historyScore;
    SetActive(this.scoreNew, this.isScoreNew);
    local judge = ConfigRhythmGameMgr.GetJudge(musicConfig, RhythmGameMgr.Data.score, musicSongData.maxScore);
    this.judgeImg.sprite = LuaMgr.GetSprite("RhythmGame", "ui_hd_yy_jn_js_score_" .. judge);
    SetActive(this.judgeGO, false);
    this.judgeAniName = this.GetJudgeAniName(judge);
    this.rightAnimator.AnimationName = "ani_RhythmGamewinPanel_Judge";    
    local skinId = musicConfig.character
    local characterId = string.sub(skinId, 1, string.len(skinId) - 3)
    local defatSkinID = characterId.."001"
    local cfgCharacterLines = ConfigMgr.Config.characterLines[defatSkinID];   
    if(cfgCharacterLines == nil)then
        LuaDebug.error("没有对应的配置数据，无法读取characterLines中的内容")
        print("没有读取到的id = "..defatSkinID)
    else
        this.msg.text = LuaMgr.GetLangText(cfgCharacterLines.victoryLine_1Lan)
    end    
    this.SetCharacter(musicConfig.character);
    local song = ConfigRhythmGameMgr.GetSongContent(musicConfig.id,typeStr);  
    local bNotNil = song.songBanner ~= nil and #song.songBanner > 0   
    if (bNotNil) then
        local list = NumTool.split(song.songBanner, "/");  
        if(list[2] ~= nil)then     
            this.nameBg.sprite = LuaMgr.GetSprite("RhythmGame", list[2]);
        else
            this.nameBg.sprite = LuaMgr.GetSprite("RhythmGame", "ui_hd_yy_xg_tm_di");
        end
    else
        this.nameBg.sprite = LuaMgr.GetSprite("RhythmGame", "ui_hd_yy_xg_tm_di");
    end     
end


this.GetJudgeAniName = function(judge)
    if (judge == 5) then
        return "ani_RhythmGamewinPanel_JudgeS";
    elseif (judge == 4) then
        return "ani_RhythmGamewinPanel_JudgeA";
    elseif (judge == 3) then
        return "ani_RhythmGamewinPanel_JudgeB";
    elseif (judge == 2) then
        return "ani_RhythmGamewinPanel_JudgeC";
    end
    return "ani_RhythmGamewinPanel_JudgeD";
end


this.OnPlayFinish = function(args)
    if (args.Length > 0) then
        local aniName = args[0];
        if (aniName == this.rootAniName) then
            this.rightAnimator.AnimationName = this.judgeAniName;
        elseif (this.isScoreNew and aniName == this.judgeAniName) then
            this.rightAnimator.AnimationName = "ani_RhythmGamewinPanel_new";
        end
    end
end


this.SetCharacter = function(characterId)
    local skinId = characterId;
    characterId = string.sub(characterId, 1, 5);
    local path = HeroManager.SetCharacterDrawing(this.characterSpine, characterId, skinId);
    if (path ~= "") then
        this.characterBody.Sprite = path;
    end
end


this.SetCondition = function(musicConfig, musicSongData)
    this.conditionList:Clear();
    local condition;
    local conditionData;
    local listData;
    local listDatas = {};
    local len = 3;
    for i = 1, len do
        condition = musicConfig["Condition" .. i];
        conditionData = {};
        conditionData.content = ConfigRhythmGameMgr.GetConditionText(condition[1], condition[2]);
        conditionData.status = musicSongData["condition" .. i];
        listData = UIListData.GetData(this.conditionItem, "RhythmGameWinConditionItem", conditionData);
        table.insert(listDatas, listData);
    end
    this.conditionList:SetData(listDatas);
end


this.OnClickRestart = function()
    LuaMgr.HidePanel(UIName.RhythmGameWinViewModel);
    LuaMgr.InvokeUIEventListeners(UIEventConst.RhythmGameRestart);
end


this.OnClickContinue = function()
    ConfigRhythmGameMgr.ShowMusicPanel(this.typeStr)   
    LuaMgr.HidePanel(UIName.RhythmGameWinViewModel);    
end

local command = {}
local data = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.conditionList = UIListView.New(this.conditionTF);
        LuaMgr.AddClick(this.restartBtn, this.OnClickRestart);
        LuaMgr.AddClick(this.continueBtn, this.OnClickContinue);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end       
        LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnPlayFinish);
        this.SetData();
        LuaMgr.ShowTouchEffect();
        LuaMgr.InvokeUIEventListeners(UIEventConst.RhythmGameTouchEffect, false);
        this.animator.AnimationName = this.rootAniName;
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnPlayFinish);
        SetActive(this.judgeGO, false);
        this.judgeImg.sprite = nil;
        this.typeStr = nil
        this.conditionList:Clear();
        this.characterSpine:Clear();
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.restartBtn, this.OnClickRestart);
        LuaMgr.RemoveClick(this.continueBtn, this.OnClickContinue);
        UIListView.ClearItem("RhythmGameWinConditionItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})
require("RhythmGame/ViewModel/RhythmGameUIMgr")
require("RhythmGame/ViewModel/RhythmGameTime")
require("RhythmGame/ViewModel/RhythmGameSpectrum")
require("RhythmGame/ViewModel/RhythmGameCharacter")

local this = {
    rootAniName = "ani_RhythmGamePanel_apper",
    bgNormalAniName = "ani_RhythmGamePanel_bg_normal",
    bgEnergyAniName = "ani_RhythmGamePanel_bg_energy",
    changeblackAniName = "ani_RhythmGamePanel_changeblack",
    changereturnAniName = "ani_RhythmGamePanel_changereturn",
    showColor = UnityEngine.Color(1,1,1,1),
    hideColor = UnityEngine.Color(1,1,1,0),
    puLines = nil,
    leftPuAniName = "ani_RhythmGamePanel_Center_Puleft",
    rightPuAniName = "ani_RhythmGamePanel_Center_Puright",
    hpList = nil,
    wawaClicks = {"MUS_click01"},
    isLeftPuWawa = false,
    isRightPuWawa = false,
    isEnergy = false,
    energy = 0,
    energyTime = 0,
    comboRedchange = "ani_RhythmGamePanel_Center_Combo_redchange",
    comboYellowchange = "ani_RhythmGamePanel_Center_Combo_yellowchange",
    comboDoublehitgreen = "ani_RhythmGamePanel_Center_Combo_doublehitgreen",
    comboDoublehityellow = "ani_RhythmGamePanel_Center_Combo_doublehityellow",
    comboDoublehitred = "ani_RhythmGamePanel_Center_Combo_doublehitred",
    comboType = 1,
    leftLongpress = false,
    rightLongpress = false,
    bIsGameStart = false,
    leftAllEvents = {},
    rightAllEvents = {},
};

local objs = {
    template = { path = "template", type = "Transform" },
    animator = { path = "root", type = "UIAnimator" },
    bgAnimator = { path = "root/Bg", type = "UIAnimator" },
    time = { path = "root/Center/Time", type = "GameObject" },
    leftBtn = { path = "root/Center/LeftBtn", type = "RectTransform" },
    rightBtn = { path = "root/Center/RightBtn", type = "RectTransform" },
    leftNotesGO = { path = "root/Center/LeftNotes", type = "GameObject" },
    leftNotes = { path = "root/Center/LeftNotes", type = "RectTransform" },
    rightNotesGO = { path = "root/Center/RightNotes", type = "GameObject" },
    rightNotes = { path = "root/Center/RightNotes", type = "RectTransform" },
    checkAnimator = { path = "root/Center/Top/Check", type = "UIAnimator" },
    leftPuTarget = { path = "root/Center/Top/LeftTarget", type = "RectTransform" },
    rightPuTarget = { path = "root/Center/Top/RightTarget", type = "RectTransform" },
    leftPuAnimator = { path = "root/Center/Top/LeftPu", type = "UIAnimator" },
    rightPuAnimator = { path = "root/Center/Top/RightPu", type = "UIAnimator" },
    leftPuWawa = { path = "root/Center/Top/LeftPu/Wawa", type = "UISpineCharacter" },
    rightPuWawa = { path = "root/Center/Top/RightPu/Wawa", type = "UISpineCharacter" },
    leftLine = { path = "root/Center/Top/LeftLine", type = "RawImage" },
    rightLine = { path = "root/Center/Top/RightLine", type = "RawImage" },
    character = { path = "root/Center/Character", type = "RectTransform" },
    comboGO = { path = "root/Center/Combo", type = "GameObject" },
    comboAnimator = { path = "root/Center/Combo/Combo", type = "UIAnimator" },
    comboImg = { path = "root/Center/Combo/Combo", type = "Image" },
    comboLine = { path = "root/Center/Combo/Combo/Line", type = "Image" },
    comboLian = { path = "root/Center/Combo/Combo/Lian", type = "Image" },
    comboNum1 = { path = "root/Center/Combo/Combo/Num1", type = "Text" },
    comboNum2 = { path = "root/Center/Combo/Combo/Num2", type = "Text" },
    comboNum3 = { path = "root/Center/Combo/Combo/Num3", type = "Text" },
    evaluateGO = { path = "root/Center/Evaluate", type = "GameObject" },
    evaluateAnimator = { path = "root/Center/Evaluate", type = "UIAnimator" },
    evaluateImg = { path = "root/Center/Evaluate", type = "Image" },
    evaluateText = { path = "root/Center/Evaluate/Text", type = "Image" },
    hpBar = { path = "root/Center/Hp/Bar", type = "Image" },
    hpNum = { path = "root/Center/Hp/Num/Text", type = "Text" },
    hpRedGlow = { path = "root/Center/Hp/Bar/UI_Energy_redglow", type = "GameObject" },
    hpRedGlowFullScreen = { path = "root/Center/Hp/Bar/UI_Energy_redglow_fullscreen", type = "GameObject" },
    score = { path = "root/Right/Score/Text", type = "Text" },
    pauseGO = { path = "root/Left/Pause", type = "GameObject" },
    pauseBtn = { path = "root/Left/Pause", type = "Button" },
    continueGO = { path = "root/Left/Continue", type = "GameObject" },
    energyBar1 = { path = "root/Center/Energy/Bar1", type = "Image" },
    energyBar1Glow = { path = "root/Center/Energy/Bar1/UI_Energy_glow", type = "GameObject" },
    energyBar1Click = { path = "root/Center/Energy/Bar1/UI_Energy_click", type = "GameObject" },
    energyBar2 = { path = "root/Center/Energy/Bar2", type = "Image" },
    energyBar2Glow = { path = "root/Center/Energy/Bar2/UI_Energy_glow", type = "GameObject" },
    energyNum = { path = "root/Center/Energy/Num/Text", type = "Text" },
    spectrum = { path = "root/Spectrum", type = "Transform" },
    spineCharacter = { path = "root/Center/Character", type = "UISpineCharacter" },
    touchEffect = { path = "root/TouchEffect", type = "GameObject" },
    longpressEffect = { path = "root/Center/Top/Check/UI_Rhythm_longpress", type = "GameObject" },
    checkRedEffect = { path = "root/Center/Top/Check/UI_Check_red", type = "GameObject" },
    checkBlueEffect = { path = "root/Center/Top/Check/UI_Check_blue", type = "GameObject" },
    checkYellowEffect = { path = "root/Center/Top/Check/UI_Check_yellow", type = "GameObject" },
    checkBlackEffect = { path = "root/Center/Top/Check/UI_Check_black", type = "GameObject" },
    redEffect = { path = "root/Center/UI_Rhythm_red", type = "GameObject" },
    blueEffect = { path = "root/Center/UI_Rhythm_blue", type = "GameObject" },
    yellowEffect = { path = "root/Center/UI_Rhythm_yellow", type = "GameObject" },
    blackEffect = { path = "root/Center/UI_Rhythm_black", type = "GameObject" },
    
    checkTest = { path = "root/Center/Top/CheckTest", type = "GameObject" },
    imagePBegin = { path = "root/Center/Top/CheckTest/ImagePBegin", type = "RectTransform" },
    imagePEnd = { path = "root/Center/Top/CheckTest/ImagePEnd", type = "RectTransform" },
    imageGBegin = { path = "root/Center/Top/CheckTest/ImageGBegin", type = "RectTransform" },
    imageGEnd = { path = "root/Center/Top/CheckTest/ImageGEnd", type = "RectTransform" },
    imageGoodBegin = { path = "root/Center/Top/CheckTest/ImageGoodBegin", type = "RectTransform" },
    imageGoodEnd = { path = "root/Center/Top/CheckTest/ImageGoodEnd", type = "RectTransform" },
    imageMissBegin = { path = "root/Center/Top/CheckTest/ImageMissBegin", type = "RectTransform" },
    imageMissEnd = { path = "root/Center/Top/CheckTest/ImageMissEnd", type = "RectTransform" },

    btnTestObj = { path = "root/Left/BtnTest", type = "GameObject" },
    btnTest = { path = "root/Left/BtnTest", type = "Button" },
};

this.OnUpdate = function()    
    this.CheckNoteRecycle()
    RhythmGameMgr.UpdateBtnCtrl()

    if RhythmGameMgr.onClickLeft then
        RhythmGameMgr.OnClickLeftBtn(this.leftEvents, this.curLeftEvent, this.curRightEvent)
        this.PlayTouchEffect(false);
        RhythmGameMgr.onClickLeft = false
    end

    if RhythmGameMgr.onClickRight then
        RhythmGameMgr.OnClickRightBtn(this.rightEvents, this.curLeftEvent, this.curRightEvent)
        this.PlayTouchEffect(true);
        RhythmGameMgr.onClickRight = false
    end

    if RhythmGameMgr.onClickLeftUP then
        RhythmGameMgr.OnClickLeftBtnUP(this.leftEvents, this.curLeftEvent, this.curRightEvent)
        RhythmGameMgr.onClickLeftUP = false
    end

    if RhythmGameMgr.onClickRightUP then
        RhythmGameMgr.OnClickRightBtnUP(this.rightEvents, this.curLeftEvent, this.curRightEvent)
        RhythmGameMgr.onClickRightUP = false
    end
    for _, v in ipairs(this.leftEvents) do
        RhythmGameMgr.UpdatePosition(v.transform, this.targetLeftPos, v, true)
    end

    for _, v in ipairs(this.rightEvents) do
        RhythmGameMgr.UpdatePosition(v.transform, this.targetRightPos, v)
    end

    RhythmGameMgr.CheckMissNote()
    this.SetTime();
    this.SetEnergy();
    RhythmGameSpectrum.Update();
    RhythmGameMgr.CheckGameResult(this.leftEvents, this.rightEvents);
    this.CheckNoteEnd();
end

this.CheckNoteRecycle = function()
    if this.leftEvents then
        local count = #this.leftAllEvents - #this.leftEvents
        for i = 1, count, 1 do
            local left = this.leftAllEvents[i]
            if not left.recycle then
                RhythmGameUIMgr.AddNote(left)
            end
        end
    end

    if this.rightEvents then
        local count = #this.rightAllEvents - #this.rightEvents
        for i = 1, count, 1 do
            local left = this.rightAllEvents[i]
            if not left.recycle then
                RhythmGameUIMgr.AddNote(left)
            end
        end
    end
end


this.CheckNoteEnd = function()
    if (#this.leftEvents <= 0 and #this.rightEvents <= 0) then
        RhythmGameMgr.CalcMissAndPerfectRatio();
        RhythmGameCharacter.PlayResult(true);
        RhythmGameMgr.StopUpdate();
        RhythmGameTime.Update(1)
    end
end

function this.InitSong()   
    AudioMgr.Singleton:StopBgm(false);
    local musicConfig = PlayerRhythmGameMgr.GetMusicConfig();
    RhythmGameMgr.LoadSong(musicConfig, 0, false)

    this.RemoveNoteGO()

    this.leftEvents = this.GetSongEvent("normal_Left", true)
    this.rightEvents = this.GetSongEvent("normal_Right", false)

    this.leftAllEvents = {}
    for i, v in ipairs(this.leftEvents) do
        table.insert(this.leftAllEvents, v)
    end
    this.rightAllEvents = {}
    for i, v in ipairs(this.rightEvents) do
        table.insert(this.rightAllEvents, v)
    end

    SetActive(this.leftNotesGO, false);
    SetActive(this.rightNotesGO, false);
    SetActive(this.longpressEffect, false);   
    RhythmGameMgr.LoadCompleted()
end

function this.RemoveNoteGO()
    for i = 1, this.leftNotesGO.transform.childCount, 1 do
        local c = this.leftNotesGO.transform:GetChild(i - 1)
        if c then
            if c.localPosition.y ~= 10000 then
                local pos = c.localPosition;
                pos.y = 10000
                c.localPosition = pos
            end
        end
    end 

    for i = 1, this.rightNotesGO.transform.childCount, 1 do
        local c = this.rightNotesGO.transform:GetChild(i - 1)
        if c then
            if c.localPosition.y ~= 10000 then
                local pos = c.localPosition;
                pos.y = 10000
                c.localPosition = pos
            end
        end
    end 
end

function this.GetSongEvent(eventID, isLeft)
    local node;
    local eventList = RhythmGameMgr.GetEvents(eventID, isLeft, this.OnNoteHit, this.OnNoteMiss, this.OnSpanNoteOver, this.OnNoteRemove)
    local events = {}
    local container = isLeft and this.leftNotes or this.rightNotes;   
    for i, v in ipairs(eventList) do        
        node = RhythmGameUIMgr.GetNote(v.NoteType, container, isLeft);
        if (node ~= nil) then
            node.gameObject.name = i .. eventID .. v.key
            node.event = v
            node.leftTarget = this.leftPuTarget
            v.data = node
            node.idx = i
            RhythmGameMgr.InitPosition(node.transform, this.targetLeftPos, node, isLeft)
            table.insert(events, node)
        end
    end   
    return events
end


this.RemoveEvents = function()
    if (this.leftEvents ~= nil) then
        local len = #this.leftEvents;
        for i = 1, len do
            RhythmGameUIMgr.AddNote(this.leftEvents[i]);
        end
        this.leftEvents = {};
    end
    if (this.rightEvents ~= nil) then
        local len = #this.rightEvents;
        for i = 1, len do
            RhythmGameUIMgr.AddNote(this.rightEvents[i]);
        end
        this.rightEvents = {};
    end
end

this.OnNoteHit = function(note)
    this.SetJudge(note);
    this.SetLongpress(note);
    this.SetCombo();
    this.score.text = tostring(RhythmGameMgr.Data.score);

    if not note.isSpan and not note.isDoubleSpan then 
        this.OnNoteRemove(note)
    end
end 

this.OnNoteMiss = function(note)
    this.SetJudge(note);
    this.SetLongpress(note);
    this.SetCombo();
    if not note.isSpan and not note.isDoubleSpan then
        this.OnNoteRemove(note)
    end
end

this.OnNoteRemove = function(note)
    note.data.leftTarget = nil
    RhythmGameUIMgr.AddNote(note.data)
    this.RemoveEvent(note)
end

this.RemoveEvent = function(note)
    if note.isLeft then
        table.remove(this.leftEvents, 1)
    else
        table.remove(this.rightEvents, 1)
    end
end


this.SetJudge = function(note)
    local judge = note.judge;
    if judge == RhythmGameMgr.JudgeType.None then return end
    
    if (judge == RhythmGameMgr.JudgeType.Perfect) then
        this.PlayEvaluateEffect("ui_hd_yy_jn_letter4", "ani_RhythmGamePanel_Center_Evaluate_red");
        RhythmGameCharacter.PlayClick(note);
        this.PlayWawa(note.isLeft);
    elseif (judge == RhythmGameMgr.JudgeType.Great) then
        this.PlayEvaluateEffect("ui_hd_yy_jn_letter3", "ani_RhythmGamePanel_Center_Evaluate_yellow");
        RhythmGameCharacter.PlayClick(note);
        this.PlayWawa(note.isLeft);
    elseif (judge == RhythmGameMgr.JudgeType.Good) then
        this.PlayEvaluateEffect("ui_hd_yy_jn_letter2", "ani_RhythmGamePanel_Center_Evaluate_green");
        RhythmGameCharacter.PlayClick(note);
        this.PlayWawa(note.isLeft);
    elseif (judge == RhythmGameMgr.JudgeType.Miss) then
        this.PlayEvaluateEffect("ui_hd_yy_jn_letter1", "ani_RhythmGamePanel_Center_Evaluate_black");
        this.SetHp();
    end
    this.PlayEvaluateLight(judge);
    RhythmGameUIMgr.JudgeSound(judge, note.spanHited);
end


this.SetLongpress = function(note)
    if (note.NoteType ~= RhythmGameMgr.NoteType.SpanType) then return end
    if (note.judge == RhythmGameMgr.JudgeType.Miss or note.judge == RhythmGameMgr.JudgeType.None) then return end
    
    if (note.isLeft) then
        this.leftLongpress = true;
    else
        this.rightLongpress = true;
    end
    SetActive(this.longpressEffect, true);
end


this.RemoveLongpress = function(note)
    if (note.isLeft) then
        this.leftLongpress = false;
    else
        this.rightLongpress = false;
    end
    if (this.leftLongpress or this.rightLongpress) then return end
    
    SetActive(this.longpressEffect, false);
end


this.PlayWawa = function(isLeft)
    if (isLeft) then
        if (this.isLeftPuWawa) then return end

        this.isLeftPuWawa = true;
        local index = math.random(1, #this.wawaClicks);
        this.leftPuWawa:Play(this.wawaClicks[index], false, this.OnLeftPlayWawa);
    else
        if (this.isRightPuWawa) then return end
        
        this.isRightPuWawa = true;
        local index = math.random(1, #this.wawaClicks);
        this.rightPuWawa:Play(this.wawaClicks[index], false, this.OnRightPlayWawa);
    end
end


this.OnLeftPlayWawa = function()
    this.isLeftPuWawa = false;
    this.leftPuWawa:Play("MUS_idle", true, nil);
end


this.OnRightPlayWawa = function()
    this.isRightPuWawa = false;
    this.rightPuWawa:Play("MUS_idle", true, nil);
end


this.PlayEvaluateEffect = function(type, aniName)
    if this.evaluateImg == nil or this.evaluateText == nil then
        return
    end
    this.evaluateImg.sprite = LuaMgr.GetSprite("RhythmGame", type .. "_di");
    this.evaluateText.sprite = LuaMgr.GetSprite("RhythmGame", type);
    this.evaluateText:SetNativeSize();
    SetActive(this.evaluateGO, true);
    this.evaluateAnimator.AnimationName = aniName;
end


this.SetCombo = function()
    local combo = RhythmGameMgr.Data.combo;
    local comboSection = RhythmGameMgr.ComboSection;
    if (combo >= comboSection[1]) then
        SetActive(this.comboGO, true);
        this.comboNum1.text = "";
        this.comboNum2.text = "";
        this.comboNum3.text = "";
        local type;
        if (combo >= comboSection[3]) then
            type = 3;
            this.comboNum3.text = tostring(combo);
        elseif (combo >= comboSection[2]) then
            type = 2;
            this.comboNum2.text = tostring(combo);
        else
            type = 1;
            this.comboNum1.text = tostring(combo);
        end
        this.comboImg.sprite = LuaMgr.GetSprite("RhythmGame", "ui_hd_yy_jn_combo"..type.."_di");
        this.comboLine.sprite = LuaMgr.GetSprite("RhythmGame", "ui_hd_yy_jn_combo"..type.."_line");
        this.comboLian.sprite = LuaMgr.GetSprite("RhythmGame", "ui_hd_yy_jn_combo"..type.."_letter");
        if (type > this.comboType) then
            if (type == 2) then
                this.comboAnimator.AnimationName = this.comboYellowchange;
            elseif (type == 3) then
                this.comboAnimator.AnimationName = this.comboRedchange;
            end
        else
            if (type == 1) then
                this.comboAnimator.AnimationName = this.comboDoublehitgreen;
            elseif (type == 2) then
                this.comboAnimator.AnimationName = this.comboDoublehityellow;
            elseif (type == 3) then
                this.comboAnimator.AnimationName = this.comboDoublehitred;
            end
        end
        this.comboType = type;
    else
        SetActive(this.comboGO, false);
    end
end


this.OnSpanNoteOver = function(note)
    RhythmGameUIMgr.AddNote(note.data)
    this.RemoveEvent(note)
    this.RemoveLongpress(note);
end


this.PlayTouchEffect = function(dir)
    local index = math.random(2, #this.puLines);
    if (dir) then
        this.rightLine.texture = this.puLines[index];
        this.rightPuAnimator.AnimationName = this.rightPuAniName;
    else
        this.leftLine.texture = this.puLines[index];
        this.leftPuAnimator.AnimationName = this.leftPuAniName;
    end
    this.checkAnimator.AnimationName = "ani_RhythmGamePanel_Center_ball";
end


this.RightPuComplete = function()
    this.rightLine.texture = this.puLines[1];
    this.rightPuAnimator.AnimationName = "ani_RhythmGamePanel_Center_Puright_normal";
end


this.LeftPuComplete = function()
    this.leftLine.texture = this.puLines[1];
    this.leftPuAnimator.AnimationName = "ani_RhythmGamePanel_Center_Puleft_normal";
end


this.InitPuLine = function()
    this.puLines = {};
    this.puLines[1] = LuaMgr.GetTexture("Assets/_BundleResources/Images/RhythmGame/ui_hd_yy_jn_line.png");
    this.puLines[2] = LuaMgr.GetTexture("Assets/_BundleResources/Images/RhythmGame/ui_hd_yy_jn_line1.png");
    this.puLines[3] = LuaMgr.GetTexture("Assets/_BundleResources/Images/RhythmGame/ui_hd_yy_jn_line2.png");
    this.puLines[4] = LuaMgr.GetTexture("Assets/_BundleResources/Images/RhythmGame/ui_hd_yy_jn_line3.png");
end


this.SetTime = function()
    local time = RhythmGameMgr.GetCurrentTime();
    local totalTime = RhythmGameMgr.GetTotalTime();
    RhythmGameTime.Update(time / totalTime);
end


this.PlayEvaluateLight = function(judge)
    this.RemoveEvaluateLight();
    if (judge == RhythmGameMgr.JudgeType.Perfect) then
        SetActive(this.redEffect, true);
        SetActive(this.checkRedEffect, true);
    elseif (judge == RhythmGameMgr.JudgeType.Great) then
        SetActive(this.yellowEffect, true);
        SetActive(this.checkYellowEffect, true);
    elseif (judge == RhythmGameMgr.JudgeType.Good) then
        SetActive(this.blueEffect, true);
        SetActive(this.checkBlueEffect, true);
    elseif (judge == RhythmGameMgr.JudgeType.Miss) then
        SetActive(this.blackEffect, true);
        SetActive(this.checkBlackEffect, true);
    end
end


this.RemoveEvaluateLight = function()
    SetActive(this.redEffect, false);
    SetActive(this.blueEffect, false);
    SetActive(this.yellowEffect, false);
    SetActive(this.blackEffect, false);
    SetActive(this.checkRedEffect, false);
    SetActive(this.checkBlueEffect, false);
    SetActive(this.checkYellowEffect, false);
    SetActive(this.checkBlackEffect, false);
end


this.PlayWarning = function()
    SetActive(this.hpRedGlow, true);
    SetActive(this.hpRedGlowFullScreen, true);
end


this.RemoveWarning = function()
    SetActive(this.hpRedGlow, false);
    SetActive(this.hpRedGlowFullScreen, false);
end


this.OnClickPause = function()
    if(not this.bIsGameStart)then return end
    this.SetPause(true);
    this.SetTouchEffect(false);
    RhythmGameMgr.Pause();
    LuaMgr.ShowLuaPanel(UIName.RhythmGamePauseViewModel);
end


this.OnBack = function()
    if LuaMgr.IsPanelOpen(UIName.RhythmGameHelp) or
        LuaMgr.IsPanelOpen(UIName.RhythmGameHelpNote) then
        return
    end
    this.OnClickPause()
end


this.SetPause = function(status)
    SetActive(this.pauseGO, not status);
    SetActive(this.continueGO, status);
end


this.OnRestart = function(args) 
    RhythmGameCharacter.Clear()  
    this.score.text = "0";
    SetActive(this.evaluateGO, false);
    SetActive(this.comboGO, false);
    this.RightPuComplete();
    this.LeftPuComplete();
    RhythmGameMgr.Stop();
    RhythmGameMgr.StopUpdate();
    this.RemoveEvents();
    this.InitSong();
    this.OnLeftPlayWawa();
    this.OnRightPlayWawa();
    this.hpBar.fillAmount = 1;
    this.ClearEnergy();
    this.SetHp();
    this.SetEnergyNum();
    RhythmGameSpectrum.Clear();
    this.ChangeEnergy(true);
    RhythmGameMgr.TimeScale(1);
    RhythmGameTime.Update(0);
    this.bIsGameStart = false
    RhythmGameCharacter.Init(this.spineCharacter, this.StartGame);
    LuaMgr.HideTouchEffect();
    this.SetTouchEffect(true);
    this.animator.AnimationName = this.rootAniName;
end


this.OnPlayFinish = function(args)
    if (args.Length > 0) then
        local aniName = args[0];
        if (aniName == this.leftPuAniName) then
            this.LeftPuComplete();
        elseif (aniName == this.rightPuAniName) then
            this.RightPuComplete();
        end
    end
end

this.OnTest = function()
    this.SetPause(true);
    this.SetTouchEffect(false);
    RhythmGameMgr.Pause();
    LuaMgr.ShowLuaPanel(UIName.RhythmGameTest);
end


this.StartGame = function()  
    SetActive(this.btnTestObj, LuaMgr.IsDebug());

    this.oldRate = CS.UnityEngine.Application.targetFrameRate;
    CS.UnityEngine.Application.targetFrameRate = 60;

    LuaMgr.RemoveClick(this.pauseBtn, this.OnClickPause);
    LuaMgr.AddClick(this.pauseBtn, this.OnClickPause);
    SetActive(this.leftNotesGO, true);
    SetActive(this.rightNotesGO, true);
    RhythmGameMgr.Play();
    this.bIsGameStart = true
    this.SetHp();
    this.SetEnergy();
    this.SetPause(false);

    this.CheckGuide()
end

this.CheckGuide = function()
    local musicConfig = PlayerRhythmGameMgr.GetMusicConfig()
    local id = musicConfig.id
    local picConfig = ConfigRhythmGameMgr.GetGuidePic(id)
    if not picConfig or #picConfig <= 0 then
        LuaDebug.error("no pid" .. id)
        return
    end

    local guideData = PlayerRhythmGameMgr.GetGuideData()
    if guideData and not guideData.Pic[id] then
        this.StartGuide()
        guideData.Pic[id] = true
        PlayerRhythmGameMgr.SetGuideData(guideData)
    end
end

this.StartGuide = function()
    this.SetPause(true);
    this.SetTouchEffect(false);
    RhythmGameMgr.Pause();
    RhythmGameMgr.TimeScale(1);
    LuaMgr.ShowLuaPanel(UIName.RhythmGameHelp);
end


this.OnResume = function(args)
    this.SetTouchEffect(true);
    this.SetPause(false);
end

this.ShowCheckTest = function(parms)
    SetActive(this.checkTest, parms.bCheck) 
    this.imagePBegin.localPosition = parms.PBegin
    this.imagePEnd.localPosition  = parms.PEnd
    this.imageGBegin.localPosition = parms.GBegin
    this.imageGEnd.localPosition =parms.GEnd
    this.imageGoodBegin.localPosition =parms.GoodBegin
    this.imageGoodEnd.localPosition =parms.GoodEnd
    this.imageMissBegin.localPosition =parms.MissBegin
    this.imageMissEnd.localPosition =parms.MissEnd
end


this.InitHp = function()







end


this.SetHp = function()
    local basicHP = RhythmGameMgr.BasicHP or ConfigRhythmGameMgr.GetMusicConstants().BasicHP;
    local hp = RhythmGameMgr.Data.hp;
    local hpp = hp / basicHP
    this.hpBar.fillAmount = hpp
    this.hpNum.text = string.format("%d/%d", hp, basicHP);















    if hpp * 100 > ConfigRhythmGameMgr.GetMusicConstants().Endangered then
        this.RemoveWarning();
    else
        this.PlayWarning();
    end
end


this.SetEnergy = function()
    local energy = RhythmGameMgr.Data.energy;
    local maxPower = RhythmGameMgr.MaxPower;
    local num = energy / maxPower;
    if (RhythmGameMgr.isEnergy) then
        this.energyBar1.fillAmount = 0;
        this.energyBar2.fillAmount = num;
    else
        this.energyBar1.fillAmount = num;
        this.energyBar2.fillAmount = 0;
        this.AddEnergy(energy);
    end
    this.ChangeEnergy(false);
    this.SetEnergyNum();
end


this.AddEnergy = function(energy)   
    if (this.energy >= energy) then return end  


    this.energy = energy;     
    this.energyBar1Click:SetActive(false)

    this.energyBar1Click:SetActive(true)  
end


this.ClearEnergy = function()
    this.energyBar1.fillAmount = 0;
    this.energyBar2.fillAmount = 0;
    SetActive(this.energyBar1Glow, false);
    SetActive(this.energyBar1Click, false);
    SetActive(this.energyBar2Glow, false);
end


this.ChangeEnergy = function(need)
    if (this.isEnergy == RhythmGameMgr.isEnergy and not need) then return end             
    this.isEnergy = RhythmGameMgr.isEnergy;
    if (RhythmGameMgr.isEnergy) then
        SetActive(this.energyBar1Glow, false);
        SetActive(this.energyBar2Glow, true);
        RhythmGameSpectrum.SetData("rhythmGame_spectrum01");
        if (need) then
            this.bgAnimator.Loop = false;
            this.bgAnimator.AnimationName = this.bgEnergyAniName;
        else
            this.bgAnimator.Loop = true;
            this.bgAnimator.AnimationName = this.changereturnAniName
        end
    else
        SetActive(this.energyBar1Glow, true);
        SetActive(this.energyBar2Glow, false);
        RhythmGameSpectrum.SetData("rhythmGame_spectrum02");
        if (need) then
            this.bgAnimator.Loop = false;
            this.bgAnimator.AnimationName = this.bgNormalAniName
        else
            this.bgAnimator.Loop = true;
            this.bgAnimator.AnimationName = this.changeblackAniName;
        end
    end             
end


this.SetEnergyNum = function()
    local energy = RhythmGameMgr.Data.energy;
    local maxPower = RhythmGameMgr.MaxPower;
    local num = energy / maxPower;
    num = math.floor(num * 100);
    this.energyNum.text = tostring(num) .. "%";
end


this.OnEnergy = function(isEnergy)
    RhythmGameCharacter.PlayEnergy(isEnergy);
end


this.AdjustScreen = function()
    local width = UnityEngine.Screen.width * 0.5;
    local sizeDelta = this.leftBtn.sizeDelta;
    sizeDelta.x = width;
    this.leftBtn.sizeDelta = sizeDelta;
    local leftPos = this.leftBtn.localPosition;
    leftPos.x = -width * 0.5;
    this.leftBtn.localPosition = leftPos;

    sizeDelta = this.rightBtn.sizeDelta;
    sizeDelta.x = width;
    this.rightBtn.sizeDelta = sizeDelta;
    local rightPos = this.rightBtn.localPosition;
    rightPos.x = width * 0.5;
    this.rightBtn.localPosition = rightPos;
end


this.SetTouchEffect = function(status)
    SetActive(this.touchEffect, status);
end


this.OnTouchEffect = function(args)
    this.SetTouchEffect(args[0]);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.AdjustScreen();
        this.targetLeftPos = this.leftPuTarget.localPosition
        this.targetRightPos = this.rightPuTarget.localPosition

        RhythmGameMgr.InitClickBtn(this.leftBtn, this.rightBtn)


        RhythmGameUIMgr.Init(this.template);
        RhythmGameTime.Init(this.time);
        RhythmGameSpectrum.Init(this.spectrum);
        this.leftPuWawa:SetDrawing();
        this.rightPuWawa:SetDrawing();
        this.InitPuLine();


        LuaMgr.AddClick(this.btnTest, this.OnTest)
    end,
    before_active = function(vm)   
        LuaMgr.ApiHeartbeat(false)
        this.bIsGameStart = false    
        if (vm.behaviour.Params == nil) then return end
        vm.behaviour:UpdateTopBar("", this.OnBack);
        AudioMgr.Singleton:PlayBgm("",true); 
        AudioMgr.Singleton:StopBgm(false);
        this.score.text = "0";
        LuaMgr.AddUIEventListener(UIEventConst.RhythmGameRestart, this.OnRestart); 
        LuaMgr.AddUIEventListener(UIEventConst.RhythmGameResume, this.OnResume);
        LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnPlayFinish);
        LuaMgr.AddUIEventListener(UIEventConst.RhythmGameTouchEffect, this.OnTouchEffect);
        AudioMgr.Singleton:StopBgm(true);
        SetActive(this.comboGO, false);
        RhythmGameMgr.Init(this.OnUpdate, this.OnEnergy, this.RemoveEvents, this.ShowCheckTest);
        LuaMgr.MultiTouchEnabled(true);
        LuaMgr.HideTouchEffect();
        this.SetTouchEffect(true);
        this.OnRestart(vm.behaviour.Params);

        SetActive(this.btnTestObj, false);
    end,
    before_deactive = function(vm)

        LuaMgr.ApiHeartbeat(true)

        CS.UnityEngine.Application.targetFrameRate = this.oldRate or 30

        LuaMgr.RemoveUIEventListener(UIEventConst.RhythmGameRestart, this.OnRestart);
        LuaMgr.RemoveUIEventListener(UIEventConst.RhythmGameResume, this.OnResume);
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnPlayFinish);
        LuaMgr.RemoveUIEventListener(UIEventConst.RhythmGameTouchEffect, this.OnTouchEffect);
        LuaMgr.RemoveClick(this.pauseBtn, this.OnClickPause);
        RhythmGameManager.Singleton:Pause()
        this.score.text = "";
        this.comboImg.sprite = nil;
        this.rightLine.texture = nil;
        this.leftLine.texture = nil;
        RhythmGameMgr.Clear();
        RhythmGameUIMgr.Clear();
        RhythmGameCharacter.Clear();
        this.RemoveEvaluateLight();
        this.RemoveEvents();
        this.RemoveWarning();        
        ConfigFoundationMgr.PlayBgmMusic();
        LuaMgr.MultiTouchEnabled(false);
        LuaMgr.ShowTouchEffect();
        this.SetTouchEffect(false);
        this.RemoveNoteGO()
    end,
    before_destroy = function(vm)
        this.hpList = nil;
        this.puLines = nil;
        RhythmGameUIMgr.Destroy();
        RhythmGameMgr.Destroy();
        LuaMgr.RemoveClick(this.btnTest, this.OnTest)
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})
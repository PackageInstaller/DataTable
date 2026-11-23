require("RhythmGame/Helper/LuaQueue")

RhythmGameMgr = {
    onUpdate = nil,
    onEnergy = nil,
    onRemoveEvents = nil,
}

local this = RhythmGameMgr

this.NoteType = {
OneOffType = 36,
SpanType = 38,
DoubleSpanType = 40,
BombType = 41,
ReverseType = 43,
HideType = 45,
DoubleClickType = 47,
}

this.NoteTypeName = {
    [this.NoteType.OneOffType] = LuaMgr.GetLangText("RhythmGameMgr_0"),
    [this.NoteType.SpanType] = LuaMgr.GetLangText("RhythmGameMgr_1"),
    [this.NoteType.DoubleSpanType] = LuaMgr.GetLangText("RhythmGameMgr_2"),
    [this.NoteType.BombType] = LuaMgr.GetLangText("RhythmGameMgr_3"),
    [this.NoteType.ReverseType] = LuaMgr.GetLangText("RhythmGameMgr_4"),
    [this.NoteType.HideType] = LuaMgr.GetLangText("RhythmGameMgr_5"),
    [this.NoteType.DoubleClickType] = LuaMgr.GetLangText("RhythmGameMgr_6"),
}

this.NoteTypeKey = {
    [this.NoteType.OneOffType] = "OneOffType",
    [this.NoteType.SpanType] = "SpanType",
    [this.NoteType.DoubleSpanType] = "DoubleSpanType",
    [this.NoteType.BombType] = "BombType",
    [this.NoteType.ReverseType] = "ReverseType",
    [this.NoteType.HideType] = "HideType",
    [this.NoteType.DoubleClickType] = "DoubleClickType",
}

this.JudgeType = {
    None = 0,
    Perfect = 1,
    Great = 2,
    Good = 3,
    Miss = 4
}

function this.InitClickBtn(leftCtrlBtn, rightCtrlBtn)
    this.leftCtrl = CS.Laigu.Tools.RhythmGameCtrl()
    this.leftCtrl:SetKeyCode(102)
    this.leftCtrl:SetData(LuaMgr.UICamera(), leftCtrlBtn, function(keyType)
        if keyType == 0 then 
            this.onClickLeft = true
        elseif keyType == 2 or keyType == 3 then
            this.onClickLeftUP = true
        end
    end)

    this.rightCtrl = CS.Laigu.Tools.RhythmGameCtrl()
    this.rightCtrl:SetKeyCode(106)
    this.rightCtrl:SetData(LuaMgr.UICamera(), rightCtrlBtn, function(keyType) 
        if keyType == 0 then 
            this.onClickRight = true
        elseif keyType == 2 or keyType == 3 then
            this.onClickRightUP = true
        end
    end)
end


function this.UpdateBtnCtrl()
    if this.leftCtrl then
        this.leftCtrl:Update()
    end
    if this.rightCtrl then
        this.rightCtrl:Update()
    end
end

function this.Destroy()
    if this.leftCtrl then
        this.leftCtrl:Clear()
    end
    if this.rightCtrl then
        this.rightCtrl:Clear()
    end

    this.leftCtrl = nil
    this.rightCtrl = nil
end

function this.Init(onUpdate, onEnergy, onRemoveEvents, showTest)
    this.onUpdate = onUpdate;
    this.onEnergy = onEnergy;
    this.onRemoveEvents = onRemoveEvents;
    this.showTest = showTest
    this.rhythmGameManager = RhythmGameManager.Singleton
    this.forceFinish = false
    this.overTime = 0
end

function this.Clear()
    this.StopUpdate();
    this.onUpdate = nil;
    this.onEnergy = nil;
    this.onRemoveEvents = nil;
    this.guideEvent = nil
end

function this.LoadSong(musicEventConfig, startSample, autoPlay)
    if autoPlay == nil then
        autoPlay = false
    end

    
    this.mCurConfig = musicEventConfig or ConfigMgr.Config.SongContents[1]
    this.noteTime = this.noteTime or 0
    this.forceFinish = false
    this.overTime = 0
    this.InitMusicConstantsConfig()
    this.InitData()
    
    RhythmGameManager.Singleton:LoadSong(this.mCurConfig.musicFace, startSample or 0, autoPlay)
   
    print(this.mCurConfig.musicFace)
    print("this.pixSpeed" .. this.pixSpeed)
    print("speed" .. this.mCurConfig.speed)
    this.mAudioTotalTime = RhythmGameManager.Singleton:GetAudioLength()
    this.mAudioCom = this.rhythmGameManager.audioCom

    this.mAudioCom.volume = ConfigRhythmGameMgr.GetMusicConstants().SoundBGM

    this.mAllEvents = {}
    this.mSortEvents = {}
    this.isEnergy = false
    this.mLeftQueueEvents = nil
    this.mRightQueueEvents = nil

    this.SampleRate = RhythmGameManager.Singleton.SampleRate
    this.noteSpeed = RhythmGameManager.Singleton.noteSpeed
    this.DelayedSampleTime = RhythmGameManager.Singleton.DelayedSampleTime

    this.HideSampleLen = 1 * this.SampleRate
    this.HideLen = this.HideSampleLen / 2

    this.showTest({
        bCheck = ConfigRhythmGameMgr.GetMusicConstants().AuxiliaryLine == 1,
        PBegin = Vector3(-this.PerfectMS / 1000 * this.pixSpeed,0,0),
        PEnd = Vector3(this.EndPerfectMS / 1000 * this.pixSpeed,0,0),
        GBegin = Vector3(-this.GreatMS / 1000 * this.pixSpeed,0,0),
        GEnd = Vector3(this.EndGreatMS / 1000 * this.pixSpeed,0,0),
        GoodBegin = Vector3(-this.GoodMS / 1000 * this.pixSpeed,0,0),
        GoodEnd = Vector3(this.EndGoodMS / 1000 * this.pixSpeed,0,0),
        MissBegin = Vector3(-this.MissMS / 1000 * this.pixSpeed,0,0),
        MissEnd = Vector3(this.EndMissMS / 1000 * this.pixSpeed,0,0),
    })
end

function this.InitData()
    this.Data = {
        hp = this.BasicHP,
        energy = 0,
        score = 0,
        combo = 0,

        perfect = 0,
        great = 0,
        good = 0,
        miss = 0,

        allNoteCount = 0,
        maxEnergyCount = 0
    }
end

function this.GetHitCountRatio()
    for i = #this.ComboSection, 1, -1 do
        if this.Data.combo >= this.ComboSection[i] then
            return this.HitScore[i]
        end
    end

    return 1
end

function this.CalcScore(note)
    local energyRatio = this.StateMultiple
    if this.isEnergy then
        energyRatio = this.StateMultiple_Burn
    end

    local typeRatio = this.NoteTypeScore[note.NoteType]
    if note.isSpan then
        typeRatio = this.CalcSpanKeyDownRatio(note, this.DelayedSampleTime)
        if typeRatio == -1 then
            return 0
        end
    end

    local addScore = this.BaseScore[note.judge] * typeRatio * this.GetHitCountRatio() * energyRatio

    addScore = math.ceil(addScore)
    this.Data.score = this.Data.score + addScore
    note.addScore = note.addScore or 0
    note.addScore = note.addScore + addScore
    return addScore
end

function this.CalcSpanKeyDownRatio(note, curSampleTime)
    local typeRatio = this.NoteTypeScore[note.NoteType]
    note.spanHited = false
    if note.isSpan then
        local curMS = curSampleTime / this.SampleRate * 1000
        local startMS = note.startSample / this.SampleRate * 1000
        if curMS > startMS then            
            local curIDX = math.floor((curMS - startMS) / this.HoldFrequency)
            note.spanCount = note.spanCount or 0
            if curIDX > note.spanCount then
                local r = curIDX -  note.spanCount
                typeRatio = r * this.PointBatType_HoldOn
                note.spanCount = curIDX
                
                note.spanHited = true
             
                return typeRatio


            else
                return -1
            end
        else
            return -1
        end
    end
    return typeRatio
end

function this.GetEvents(eventID, isLeft, OnNoteHit, OnNoteMiss, OnSpanNoteOver, OnNoteRemove)
    local rawEvents = RhythmGameManager.Singleton:GetEvents(eventID)

    local eventList = this.mAllEvents[eventID]
    if eventList then
        return eventList
    end

    eventList = {}
    local queEvents = LuaQueue.New()
    for i=0, rawEvents.Count - 1 do
        local node = {}
        local evt = rawEvents[i]
        node.idx = i
        node.key = RhythmGameManager.GetIntValue(evt)
        node.startSample = evt.StartSample
        node.endSample = evt.EndSample

        node.isOneOff = node.key == this.NoteType.OneOffType
        node.isSpan = node.key == this.NoteType.SpanType
        node.isDoubleSpan = node.key == this.NoteType.DoubleSpanType
        node.isBomb = node.key == this.NoteType.BombType
        node.isReverse = node.key == this.NoteType.ReverseType
        node.isHide = node.key == this.NoteType.HideType
        node.isDoubleClick = node.key == this.NoteType.DoubleClickType
        if node.isSpan or node.isDoubleSpan then
            node.widthLen = node.endSample - node.startSample
        end

        node.judge = this.JudgeType.None
        node.isLeft = isLeft
        node.doubleSpanCount = 0

        node.NoteType = node.key
        node.event = evt
        node.OnNoteHit = OnNoteHit
        node.OnNoteMiss = OnNoteMiss
        node.OnSpanNoteOver = OnSpanNoteOver
        node.OnNoteRemove= OnNoteRemove
        
        table.insert(eventList, node)
        queEvents:Enqueue(node)

        table.insert(this.mSortEvents, node)
    end

    this.mAllEvents[eventID] = eventList
    if isLeft then
        this.mLeftQueueEvents = queEvents
    else
        this.mRightQueueEvents = queEvents
    end

    this.Data.allNoteCount = this.Data.allNoteCount + #eventList

    return eventList
end

function this.GetAllNoteCount()
    local noteCount = {}
    for k, v in ipairs(this.mSortEvents) do
        local count = noteCount[v.key] or 0
        noteCount[v.key] = count + 1
    end
    for k, v in pairs(noteCount) do
        if  k == this.NoteType.DoubleClickType then
            v = v / 2
            noteCount[k] = v
        end
    end
    return noteCount
end

function this.LoadCompleted()
    table.sort(this.mSortEvents, function(a, b)
        return a.startSample < b.startSample
    end)
    local maxScore = 0
    local allNoteCount = this.Data.allNoteCount
    this.InitData()
    this.isEnergy = false
    local calcDoubleClick = false
    for i, node in ipairs(this.mSortEvents) do
        local energyRatio = this.StateMultiple
        if this.isEnergy then
            energyRatio = this.StateMultiple_Burn
        end
        local noteRatio = this.NoteTypeScore[node.NoteType]
        if not noteRatio then
            LuaDebug.error("node.noteType is nil: " .. node.NoteType)
        end
        if node.isSpan then
            node.spanCount = 0
            node.spanHited = false
            noteRatio = this.CalcSpanKeyDownRatio(node, node.endSample)
            node.spanCount = 0
            node.spanHited = false
            if noteRatio == -1 then
                noteRatio = this.NoteTypeScore[node.NoteType]
            end
        end

        local calcScoreTemp = true
        if node.isDoubleSpan then
            for i = 1, this.MaxDoubleSpanCount, 1 do
                this.Data.combo = this.Data.combo + 1
                local addScore = this.BaseScore[this.JudgeType.Perfect] * noteRatio * this.GetHitCountRatio() * energyRatio
                maxScore = maxScore + addScore
                this.AddEnergy(this.BaseAddEnergy[this.JudgeType.Perfect])

                energyRatio = this.StateMultiple
                if this.isEnergy then
                    energyRatio = this.StateMultiple_Burn
                end
            end
        else
            if node.isDoubleClick then
                if calcDoubleClick then
                    calcDoubleClick = false
                    calcScoreTemp = false
                else                    
                    calcDoubleClick = true
                    calcScoreTemp = true
                end
            end

            if calcScoreTemp then 
                this.Data.combo = this.Data.combo + 1
                local addScore = this.BaseScore[this.JudgeType.Perfect] * noteRatio * this.GetHitCountRatio() * energyRatio
                this.AddEnergy(this.BaseAddEnergy[this.JudgeType.Perfect])
                maxScore = maxScore + addScore
            end
        end

        if this.isEnergy and calcScoreTemp then
            this.CheckStartEnergyTime = this.CheckStartEnergyTime or node.startSample / this.SampleRate
            local secd = this.MaxPower/this.BurnExpend

            this.engerCount = this.engerCount or this.Data.combo
            if node.startSample / this.SampleRate >= this.CheckStartEnergyTime + secd then
                print(this.engerCount .. "secd:" .. secd .. "/" .. (this.CheckStartEnergyTime + secd))
                this.QuitEnergy()
                this.CheckStartEnergyTime = nil
                this.engerCount = nil
            end
        end
    end

    print(this.Data.combo)
    this.isEnergy = false
    this.InitData()
    this.Data.allNoteCount = allNoteCount
    this.Data.maxScore = math.floor(maxScore)
    this.CheckStartEnergyTime = nil
    print(maxScore)
end

function this.Play()
    this.TimeScale(1);
    RhythmGameManager.Singleton:Play()
    LuaMgr.AddUpdate(this.Update);
    LuaMgr.InvokeUIEventListeners(UIEventConst.RhythmGameResume);
end

function this.Pause()
    this.TimeScale(0);
    RhythmGameManager.Singleton:Pause();
    RhythmGameMgr.StopUpdate();
end

function this.Stop()
    RhythmGameManager.Singleton:Stop()
    if (this.onRemoveEvents ~= nil) then
        this.onRemoveEvents();
    end
end

function this.StopUpdate()
    LuaMgr.RemoveUpdate(this.Update);
end

function this.TimeScale(timeScale)
    UnityEngine.Time.timeScale = timeScale;
end

function this.GetCurrentTime()
    return this.mAudioCom.time
end

function this.GetTotalTime()
    return this.mAudioTotalTime
end

function this.AddHP(_hp, force)
    if RhythmGameMgr.Cheat and RhythmGameMgr.Cheat.god then
        return
    end

    this.Data.hp = this.Data.hp + _hp
    if this.Data.hp <= 0 then
        this.Data.hp = 0
    end

    this.TriggetItemEffect()
end

function this.AddEnergy(_energy, force)
    if RhythmGameMgr.Cheat and RhythmGameMgr.Cheat.maxPower then
        return
    end

    if _energy > 0 and this.isEnergy and not force then
        return
    end

    this.Data.energy = this.Data.energy + _energy
    if this.Data.energy <= 0 then
        this.QuitEnergy()
    end

    if this.Data.energy >= this.MaxPower then
        this.isEnergy = true
        this.Data.maxEnergyCount = this.Data.maxEnergyCount + 1
        this.onEnergy(true);
    end
end

function this.OnNoteHited(note, isLeft)
    if note.hit then
        this.AddEnergy(this.BaseAddEnergy[note.judge])
        this.CalcScore(note)

        if note.OnNoteHit then
            note:OnNoteHit()
        end

        this.TriggetItemEffect()
    end




    if note.isLeft then
        this.alreadyCheckLeft = true
    else
        this.alreadyCheckRight = true
    end
end

function this.OnNoteMissed(note, isLeft)
    if note.miss then
        this.AddHP(-this.TakeOutHP)

        local energy = this.BaseAddEnergy[this.JudgeType.Miss]
        if this.isEnergy then
            energy = -this.BurnMiss
        end
        this.AddEnergy(energy)

        if note.OnNoteMiss then
            note:OnNoteMiss()
        end
    end
end

function this.QuitEnergy()
    if this.isEnergy and this.onEnergy ~= nil then
        this.onEnergy(false);
    end
    this.isEnergy = false
    this.Data.energy = 0
end

function this.Update()
    this.DelayedSampleTime = RhythmGameManager.Singleton.DelayedSampleTime
    this.curAudioTime = RhythmGameManager.Singleton.audioCom.time
    this.UnityDeltaTime = UnityEngine.Time.deltaTime

    this.noteTime = this.noteTime + this.UnityDeltaTime

    if this.isEnergy then
        this.AddEnergy(-this.BurnExpend * this.UnityDeltaTime)
    end
    
    if (this.onUpdate ~= nil) then
        this.onUpdate();
    end
end

function this.InitPosition(transform, targetPosition, node, isLeft)
    this.noteSpeed = 1
    local perUnit = this.SampleRate / this.noteSpeed

    local trackedEvent = node.event
    
    local x = targetPosition.x

    local sec = (trackedEvent.startSample - this.DelayedSampleTime) / perUnit
    local miss = sec * this.pixSpeed

    
    if isLeft then
        x = targetPosition.x - miss
    else
        x = targetPosition.x + miss
    end

    if (trackedEvent.isSpan or trackedEvent.isDoubleSpan) then
        this.SetNoteWidth(node)
    end

    transform.localPosition = Vector3(x, targetPosition.y, targetPosition.z)

    
    trackedEvent.speed = miss / sec
    trackedEvent.len = miss



end

function this.UpdatePosition(transform, targetPosition, node, isLeft)
    this.noteSpeed = 1
    local perUnit = this.SampleRate / this.noteSpeed

    local trackedEvent = node.event
    local x = targetPosition.x

    local sec = (trackedEvent.startSample - this.DelayedSampleTime) / perUnit
    local miss = sec * this.pixSpeed
    trackedEvent.len = trackedEvent.len - this.UnityDeltaTime * trackedEvent.speed





    if not trackedEvent.hit and not trackedEvent.spanMiss or (trackedEvent.hit and trackedEvent.isDoubleClick ) then
        if isLeft then
            x = targetPosition.x - trackedEvent.len
        else
            x = targetPosition.x + trackedEvent.len
        end
    else
        x = transform.localPosition.x
    end

    if trackedEvent.isSpan or trackedEvent.isDoubleSpan then

        if trackedEvent.down or trackedEvent.doubleDown or trackedEvent.spanMiss then 
            this.SetNoteWidth(node, true, (trackedEvent.spanMiss or trackedEvent.downUP) and trackedEvent.isSpan)
        end
    end

    if trackedEvent.isHide then
        this.SetNoteColor(node)
    end

    transform.localPosition = Vector3(x, targetPosition.y, targetPosition.z)

    this.UpdateGuideNote(trackedEvent)
end




function this.UpdateGuideNote(trackedEvent)
    local guideData = PlayerRhythmGameMgr.GetGuideData()
    if not guideData or guideData.Note[this.NoteTypeKey[trackedEvent.NoteType]] then
        return
    end
    local guideControlConfig = ConfigRhythmGameMgr.GetGuideControl(this.NoteTypeKey[trackedEvent.NoteType])
    if not guideControlConfig then

        return
    end

    if this.guideEvent and this.guideEvent ~= trackedEvent then
        return
    end

    local ms = (trackedEvent.startSample / this.SampleRate) * 1000
    local mc = (this.DelayedSampleTime / this.SampleRate) * 1000
    local judgeTime = mc - ms
    if judgeTime >= -2000 and judgeTime < this.EndGoodMS then
        if guideControlConfig.TeachSwitch == 1 and not this.guideEvent then
            this.guideEvent = trackedEvent
            trackedEvent.FirstShow = true
            trackedEvent.OnClickBtn = false

            this.ShowGuideNote(trackedEvent)
            return
        end


        if guideControlConfig.ClickSwitch == 1 and not this.guideEvent then
            this.guideEvent = trackedEvent
        end

        if judgeTime >= -this.PerfectMS and judgeTime < this.EndPerfectMS then
            if guideControlConfig.ClickSwitch == 1 and not trackedEvent.isBomb then
                if not this.guideClickEvent then
                    this.guideClickEvent = trackedEvent
                    trackedEvent.OnClickBtn = true

                    guideData.Note[this.NoteTypeKey[trackedEvent.NoteType]] = true
                    PlayerRhythmGameMgr.SetGuideData(guideData)

                    this.ShowGuideNote(trackedEvent)
                    
                    trackedEvent.FirstShow = false
                    this.guideEvent = nil
                    this.guideClickEvent = nil
                    this.guideControlConfig = nil
                end
            else
                guideData.Note[this.NoteTypeKey[trackedEvent.NoteType]] = true
                PlayerRhythmGameMgr.SetGuideData(guideData)

                trackedEvent.FirstShow = false
                this.guideEvent = nil
                this.guideClickEvent = nil
                this.guideControlConfig = nil
            end
        end
    end
end

function this.ShowGuideNote(trackedEvent)
    this.Pause()   
    this.TimeScale(1)
    LuaMgr.ShowLuaPanel(UIName.RhythmGameHelpNote, trackedEvent);
end

function this.SetNoteWidth(node, down, status)
    this.noteSpeed = 1
    local perUnit = this.SampleRate / this.noteSpeed
    local trackedEvent = node.event
    if (trackedEvent.isSpan or trackedEvent.isDoubleSpan) then
        local len = trackedEvent.widthLen
        local speed = this.pixSpeed
        if down then
            if not trackedEvent.downTime then
                trackedEvent.downTime = this.DelayedSampleTime
            end
            len = len - this.DelayedSampleTime + trackedEvent.downTime
            speed = trackedEvent.speed

        end

        local w = len / perUnit * speed
       
        node:SetData(w, trackedEvent.isLeft and -1 or 1, not status)
    end    
end


function this.SetNoteColor(node)
    local trackedEvent = node.event
    if trackedEvent.isHide then
        local startReal = trackedEvent.startSample - this.HideSampleLen
        local w = 1
        if this.DelayedSampleTime >= startReal then      
            local len = (this.DelayedSampleTime - startReal ) + this.HideLen
            w = 1 - len / this.HideSampleLen
            
            if w <= 0 then
                w = 0
            end
        end
        node:SetData(w)
    end
end


function this.ClickOneOff(note, isLeft)
    local curQueue = this.mRightQueueEvents
    if isLeft then
        curQueue = this.mLeftQueueEvents
    end

    if not note.hit and RhythmGameMgr.IsNoteHittable(note, isLeft) then
        note.hit = true
        this.OnNoteHited(note, isLeft)
        this.DequeueNote(curQueue)
    end
end

function this.ClickSpan(note, isLeft)
    if not note.hit and RhythmGameMgr.IsNoteSpanHittable(note, isLeft) then
        note.hit = true
        note.down = true
        this.OnNoteHited(note, isLeft)
    end
end


function this.ClickDoubleSpan(note, isLeft)
    if not note.hit then
        if RhythmGameMgr.IsNoteDoubleSpanHittable(note, isLeft) then
            note.hit = true
            note.doubleDown = true
            note.doubleSpanCount = note.doubleSpanCount + 1
            this.OnNoteHited(note, isLeft)
        end
elseif note.hit and note.doubleSpanCount < this.MaxDoubleSpanCount then
        if this.DelayedSampleTime <= note.endSample then            
            this.Data.perfect = this.Data.perfect + 1
            note.judge = this.JudgeType.Perfect
            note.doubleSpanCount = note.doubleSpanCount + 1
            this.Data.combo = this.Data.combo + 1
            this.OnNoteHited(note, isLeft)
        end
    end
end

function this.ClickBomb(note, isLeft)
    local curQueue = this.mRightQueueEvents
    if isLeft then
        curQueue = this.mLeftQueueEvents
    end

    if not note.hit and RhythmGameMgr.IsNoteHittable(note, isLeft) then
        note.hit = true
        note.bombDown = true
        this.OnNoteMissed(note, isLeft)
        this.DequeueNote(curQueue)
    end
end

function this.ClickHide(note, isLeft)
    local curQueue = this.mRightQueueEvents
    if isLeft then
        curQueue = this.mLeftQueueEvents
    end

    if not note.hit and RhythmGameMgr.IsNoteHittable(note, isLeft) then
        note.hit = true
        note.hideDown = true
        this.OnNoteHited(note, isLeft)
        this.DequeueNote(curQueue)
    end
end


function this.CheckReverseHit(isLeft)
    local curLeft = this.mLeftQueueEvents:Peek()
    local curRight = this.mRightQueueEvents:Peek()
    local v = nil
    local curQueue = nil
    if isLeft and curRight and curRight.isReverse then
        v = curRight
        curQueue = this.mRightQueueEvents
    elseif not isLeft and curLeft and curLeft.isReverse then
        v = curLeft
        curQueue = this.mLeftQueueEvents
    end

    if v and curLeft and curRight then
        if curLeft.startSample > curRight.startSample then
            if curRight ~= v then
                return false
            end
        elseif curLeft.startSample < curRight.startSample then
            if curLeft ~= v then
                return false
            end
        end
    end

    if v and not v.hit and RhythmGameMgr.IsNoteHittable(v, isLeft) then
        v.hit = true
        v.reverseDown = true
        v.leftDown = isLeft

        this.OnNoteHited(v,  isLeft)
        this.DequeueNote(curQueue)

        return true
    end
    return false
end

function this.RemoveDoubleTypeUINote(isLeft)
    local leftNote = this.mLeftQueueEvents:Peek()
    local rightNote = this.mRightQueueEvents:Peek()
    if isLeft then
        if rightNote then 
            rightNote:OnNoteRemove()
        end
    else
        if leftNote then
            leftNote:OnNoteRemove()
        end
    end
end

function this.ClickDoubleClick(note, isLeft)
    local curQueue = this.mRightQueueEvents
    if isLeft then
        curQueue = this.mLeftQueueEvents
    end

    local leftNote = this.mLeftQueueEvents:Peek()
    local rightNote = this.mRightQueueEvents:Peek()
    if (leftNote and not leftNote.isDoubleClick) or (rightNote and not rightNote.isDoubleClick) then













        LuaDebug.warn("note do not doubleclick")
        return
    end

    if not note.hit and RhythmGameMgr.IsNoteHittable(note, isLeft) then
        note.hit = true
        note.doubleClickHit = true

        if this.startDoubleClick then
            if note.judge < this.startDoubleClick.judge then
                this.startDoubleClick = note
            end

            this.OnNoteHited(this.startDoubleClick, isLeft)
            this.RemoveDoubleTypeUINote(this.startDoubleClick.isLeft)


            this.DequeueNote(this.mLeftQueueEvents)
            this.DequeueNote(this.mRightQueueEvents)
            this.alreadyCheckLeft = true
            this.alreadyCheckRight = true
            this.startDoubleClick = nil
        else 
            this.startDoubleClick = note
        end
    end
end

this.ClickTypeFunc = {
    [this.NoteType.OneOffType] = this.ClickOneOff,
    [this.NoteType.SpanType] = this.ClickSpan,
    [this.NoteType.DoubleSpanType] = this.ClickDoubleSpan,
    [this.NoteType.BombType] = this.ClickBomb,
    [this.NoteType.HideType] = this.ClickHide,

    [this.NoteType.DoubleClickType] = this.ClickDoubleClick,
}


function this.OnClickLeftBtnUP(events, curLeftEvent, curRightEvent)
    this.OnClickBtnUP(events, curLeftEvent, curRightEvent, true)
end

function this.OnClickRightBtnUP(events, curLeftEvent, curRightEvent)
    this.OnClickBtnUP(events, curLeftEvent, curRightEvent)
end


function this.OnClickBtnUP(events, curLeftEvent, curRightEvent, isLeft)
    local curLeftQueue = this.mLeftQueueEvents
    local curRightQueue = this.mRightQueueEvents

    local curQueue = curRightQueue
    if isLeft then
        curQueue = curLeftQueue
    end

    local v = curQueue:Peek()

    if this.guideEvent and this.guideEvent == v and v then
        return
    end

    if this.guideEvent and (this.guideEvent.isDoubleClick or this.guideEvent.isReverse) then
        return
    end


    if not v then
        return
    end
if v.isSpan and v.hit then
        v.downUP = true
        this.SetNoteWidth(v,true,false)
    end
end


function this.OnClickLeftBtn(events, curLeftEvent, curRightEvent)
    this.OnClickBtn(events, curLeftEvent, curRightEvent, true)
end

function this.OnClickRightBtn(events, curLeftEvent, curRightEvent)
    this.OnClickBtn(events, curLeftEvent, curRightEvent)
end

function this.OnClickBtn(events, curLeftEvent, curRightEvent, isLeft)


    if this.noteTime < 0.08 then
        local ms = ConfigRhythmGameMgr.GetMusicSongByEventId(this.mCurConfig.id)
        if ms and ms.type == "Easy" then
            return
        end

    end

    local curLeftQueue = this.mLeftQueueEvents
    local curRightQueue = this.mRightQueueEvents
    
    local curQueue = curRightQueue
    if isLeft then
        curQueue = curLeftQueue
    end
    
    local v = curQueue:Peek()

    if this.guideEvent and this.guideEvent == v and v then
        return
    end

    if this.guideEvent and (this.guideEvent.isDoubleClick or this.guideEvent.isReverse) then
        return
    end

if this.CheckReverseHit(isLeft) then
        return    
    end


    if not v or (v.spanMiss and not v.isDoubleSpan) then
        return
    end

    if this.ClickTypeFunc[v.NoteType] then
        this.ClickTypeFunc[v.NoteType](v, isLeft)
    else
        LuaDebug.error("no clickType" .. v.NoteType)
    end
end



function this.IsNoteHittable(node, isLeft)
    local trackedEvent = node
    local mc = (this.DelayedSampleTime / this.SampleRate)  * 1000
    local startM = (trackedEvent.startSample / this.SampleRate) * 1000
    
    local judgeTime = mc - startM
    return  this.Judge(judgeTime, node)

end

function this.IsNoteSpanHittable(node, left)
    local trackedEvent = node

    local mc = (this.DelayedSampleTime / this.SampleRate)  * 1000
    local startM = (trackedEvent.startSample / this.SampleRate) * 1000


    local judgeTime = mc - startM

    return  this.Judge(judgeTime, node)

end

function this.IsNoteDoubleSpanHittable(node, left)
    local trackedEvent = node

    local mc = (this.DelayedSampleTime / this.SampleRate)  * 1000
    local startM = (trackedEvent.startSample / this.SampleRate) * 1000


    local judgeTime = mc - startM
    return  this.Judge(judgeTime, node)
end

function this.Judge(judgeTime, node)
    local find = false
    if judgeTime >= -this.PerfectMS and judgeTime < this.EndPerfectMS then
        if not node.isBomb then
            this.Data.perfect = this.Data.perfect + 1
            node.judge = this.JudgeType.Perfect
            this.Data.combo = this.Data.combo + 1
        end
        find = true
    elseif judgeTime >= -this.GreatMS and judgeTime < this.EndGreatMS then
        if not node.isBomb then
            this.Data.great = this.Data.great + 1
            node.judge = this.JudgeType.Great
            this.Data.combo = this.Data.combo + 1
        end
        find = true
    elseif judgeTime >= -this.GoodMS and judgeTime < this.EndGoodMS then
        if not node.isBomb then
            this.Data.good = this.Data.good + 1
            node.judge = this.JudgeType.Good
            this.Data.combo = this.Data.combo + 1
        end
        find = true
    elseif judgeTime >= -this.MissMS and judgeTime < this.EndMissMS then
        if not node.isBomb then
            this.Data.miss = this.Data.miss + 1
            node.miss = true
            if node.isSpan or node.isDoubleSpan then
                node.spanMiss = true
            end
            node.judge = this.JudgeType.Miss
            this.Data.combo = 0
        end
        find = true
    end

    if node.miss and node.isDoubleSpan then
        this.Data.perfect = this.Data.perfect + 1
        node.judge = this.JudgeType.Perfect
        this.Data.combo = this.Data.combo + 1
        return true
    end

    if find then
        if node.isBomb then
            this.Data.miss = this.Data.miss + 1
            node.miss = true
            node.judge = this.JudgeType.Miss
            this.Data.combo = 0
        end
        if node.miss then
            return false
        end
        return true
    end
end



function this.CheckMissNote()
    if not this.alreadyCheckLeft then
        this.CheckMissReal(this.mLeftQueueEvents)
    end

    if not this.alreadyCheckRight then
        this.CheckMissReal(this.mRightQueueEvents)
    end

    this.alreadyCheckLeft = false
    this.alreadyCheckRight = false
end

function this.DequeueNote(noteQueue)
    noteQueue:Dequeue()
end

function this.CheckMissTime(event)
    local ms = (event.startSample / this.SampleRate) * 1000
    local mc = (this.DelayedSampleTime / this.SampleRate)  * 1000
    local judgeTime = mc - ms

    return judgeTime >= this.NoInputMissMS
end
function this.CheckNormalMiss(event, noteQueue)
    if event.miss then
        this.OnNoteMissed(event)
        this.DequeueNote(noteQueue)
    else
if not event.hit and this.CheckMissTime(event) then
            event.miss = true
            this.Data.miss = this.Data.miss + 1
            event.judge = this.JudgeType.Miss
            this.Data.combo = 0

            this.OnNoteMissed(event)

            this.DequeueNote(noteQueue)
            this.noteTime = 0
        end
    end
end

function this.CheckBombMiss(event, noteQueue)
    if event.miss then
        this.OnNoteMissed(event)
        this.DequeueNote(noteQueue)
    else
if not event.hit and this.CheckMissTime(event) then
            event.hit = true
            event.bombDown = true
            this.Data.perfect = this.Data.perfect + 1
            event.judge = this.JudgeType.Perfect
            this.Data.combo = this.Data.combo + 1

            this.OnNoteHited(event)

            this.DequeueNote(noteQueue)
        end
    end
end

function this.CheckSpanMiss(event, noteQueue)
if not event.hit and not event.spanMiss and this.CheckMissTime(event) then
        event.miss = true
        this.Data.miss = this.Data.miss + 1
        event.judge = this.JudgeType.Miss
        this.Data.combo = 0

        this.OnNoteMissed(event)
        event.spanMiss = true
        this.SetNoteWidth(event.data, true, not event.isDoubleSpan)

        this.noteTime = 0
elseif event.hit or event.spanMiss then
        local a = this.DelayedSampleTime >= event.downTime + event.widthLen
        if event.miss and event.spanMiss and not event.onMiss then
            event.onMiss = true
            this.OnNoteMissed(event)
        end

        if a then
            this.DequeueNote(noteQueue)
            if event.OnSpanNoteOver then
                event:OnSpanNoteOver()
            end
        elseif event.hit and event.isSpan and event.down and not event.downUP then
            this.CalcScore(event, true)
            if event.spanHited then
                if event.OnNoteHit then
                    event:OnNoteHit()
                end
                event.spanHited = false
            end
        end
    end
end


function this.CheckDoubleClickMiss(event, noteQueue)
    if event.miss then
        this.OnNoteMissed(event)

        this.RemoveDoubleTypeUINote(event.isLeft)
        this.DequeueNote(this.mLeftQueueEvents)
        this.DequeueNote(this.mRightQueueEvents)
        this.alreadyCheckLeft = true
        this.alreadyCheckRight = true
        this.startDoubleClick = nil
    else
if not event.hit and this.CheckMissTime(event) then
            event.miss = true
            this.Data.miss = this.Data.miss + 1
            event.judge = this.JudgeType.Miss
            this.Data.combo = 0

            this.OnNoteMissed(event)
            this.RemoveDoubleTypeUINote(event.isLeft)

            this.DequeueNote(this.mLeftQueueEvents)
            this.DequeueNote(this.mRightQueueEvents)
            this.alreadyCheckLeft = true
            this.alreadyCheckRight = true
            this.startDoubleClick = nil

            this.noteTime = 0
        end
    end
end

this.CheckMissFunc = {
    [this.NoteType.OneOffType] = this.CheckNormalMiss,
    [this.NoteType.SpanType] = this.CheckSpanMiss,
    [this.NoteType.DoubleSpanType] = this.CheckSpanMiss,
    [this.NoteType.BombType] = this.CheckBombMiss,
    [this.NoteType.HideType] = this.CheckNormalMiss,
    [this.NoteType.ReverseType] = this.CheckNormalMiss,
    [this.NoteType.DoubleClickType] = this.CheckDoubleClickMiss,
}

function this.CheckMissReal(v)
    if v.Count > 0 then
        local event = v:Peek()
        if this.CheckMissFunc[event.NoteType] then
            this.CheckMissFunc[event.NoteType](event, v)
        end
    end
end

function this.CalcMissAndPerfectRatio()
    local missCount = 0
    local perfectCount = 0
    for i, v in pairs(this.mAllEvents) do
        for _, node in ipairs(v) do
            if node.judge == this.JudgeType.Perfect then
                perfectCount = perfectCount + 1
            elseif node.judge == this.JudgeType.Miss then
                missCount = missCount + 1
            end
        end
    end
    print(missCount, missCount/this.Data.allNoteCount)
    print(perfectCount, perfectCount/this.Data.allNoteCount)
    print(this.Data.allNoteCount)
    this.Data.missCount = missCount
    this.Data.perfectCount = perfectCount
end

function this.CheckGameResult(leftEvents, rightEvents)
     if this.Data.hp <= 0 then
         this.CalcMissAndPerfectRatio()
         this.Stop()
         RhythmGameCharacter.PlayResult(false);
         return
     end

    local isOver = this.mLeftQueueEvents.Count == 0 and this.mRightQueueEvents.Count == 0
    if isOver then
        this.overTime = this.overTime or 0
        this.overTime = this.overTime + this.UnityDeltaTime
        if this.overTime > 5 then
            LuaDebug.warn(math.abs(this.GetCurrentTime() - this.GetTotalTime()))
            this.forceFinish = true
        end
    end
    
    local currentTime = this.GetCurrentTime();
    if (currentTime == 0 and #leftEvents == 0 and #rightEvents == 0) or currentTime >= this.GetTotalTime() or this.forceFinish then
        this.CalcMissAndPerfectRatio()
        this.Stop()
        if (RhythmGameCharacter.IsResultComplete()) then
            RhythmGameMgr.SendCompleteSong();
        else
            RhythmGameCharacter.PlayEnd();
        end
        this.forceFinish = false
        this.overTime = 0
    end
end


function this.SendCompleteSong()
    LuaMgr.ApiHeartbeat(true);
    local musicConfig,typeStr = PlayerRhythmGameMgr.GetMusicConfig();
    if (musicConfig == nil) then return end
    
    local musicSong = ConfigRhythmGameMgr.GetMusicSongByEventId(musicConfig.id,typeStr);
    if (musicSong == nil) then return end

    if not this.Data.perfectCount then
        this.CalcMissAndPerfectRatio();
    end
    local precise = (this.Data.perfectCount / this.Data.allNoteCount) * 100;
    if (precise > 0 and precise < 1) then
        precise = 1;
    end
    local data = {id=musicSong.id,
                  score=this.Data.score,
                  maxScore=this.Data.maxScore,
                  hit=math.floor(precise),
                  hp=this.Data.hp,
                  sp=this.Data.maxEnergyCount,
                  perfect=this.Data.perfect,
                  nice=this.Data.great,
                  good=this.Data.good,
                  miss=this.Data.miss};
    PlayerRhythmGameMgr.CompleteSong(data,typeStr);
end 
local this = RhythmGameMgr

function this.EffectMaxHP(config)
    if #config.num > 0 then
        local num = tonumber(config.num[1])
        if not num then
            return
        end

        local bhp = ConfigRhythmGameMgr.GetMusicConstants().BasicHP
        this.BasicHP = bhp + math.ceil(num / 100 * bhp)
        print("hp: " .. this.BasicHP)
    end
end

function this.EffectPowerSAB(config)
    if #config.num ~= 3 then
        return
    end

    local num = tonumber(config.num[1])
    this.BaseAddEnergy[this.JudgeType.Perfect] = this.BaseAddEnergy[this.JudgeType.Perfect] + num
    local num = tonumber(config.num[2])
    this.BaseAddEnergy[this.JudgeType.Great] = this.BaseAddEnergy[this.JudgeType.Great] + num
    local num = tonumber(config.num[3])
    this.BaseAddEnergy[this.JudgeType.Good] = this.BaseAddEnergy[this.JudgeType.Good] + num

    print("EffectPowerSAB Perfect: " .. this.BaseAddEnergy[this.JudgeType.Perfect] .. "Great" .. this.BaseAddEnergy[this.JudgeType.Great] .. "Good" .. this.BaseAddEnergy[this.JudgeType.Good])
end

function this.EffectBurnExpend(config)
    if #config.num ~= 1 then
        return
    end

    this.BurnExpend = this.BurnExpend + tonumber(config.num[1])
    print("BurnExpend is: " .. this.BurnExpend)
end

function this.EffectJudgeRegion(config)
    if #config.num ~= 2 then
        return
    end

    this.PerfectMS = this.PerfectMS + tonumber(config.num[1])
    this.EndPerfectMS = this.EndPerfectMS + tonumber(config.num[2])

    print("this.PerfectMS is: " .. this.PerfectMS)
    print("this.EndPerfectMS is: " .. this.EndPerfectMS)
end

function this.EffectBurnMiss(config)
    if #config.num ~= 1 then
        return
    end

    this.BurnMiss = this.BurnMiss + tonumber(config.num[1])
    print("BurnMiss is: " .. this.BurnMiss)
end

function this.EffectTriggerHPAndTakeOutHP(config)
    if #config.num ~= 2 then
        return
    end

    this.TakeOutHP = this.OriTakeOutHP
    if this.Data.hp / this.BasicHP < tonumber(config.num[1]) / 100 then
        this.TakeOutHP = this.TakeOutHP + tonumber(config.num[2])

        print("this.TakeOutHP is: " .. this.TakeOutHP)
    end
end

function this.EffectComboSection3(config)
    if #config.num ~= 1 then
        return
    end

    this.HitScore[3] = this.PointComboSect_3
    if this.Data.combo > 100 then
        this.HitScore[3] = this.PointComboSect_3 + tonumber(config.num[1])

        print("this.HitScore[3] is: " .. this.HitScore[3])
    end
end

function this.EffectSpeedAndPointPreciseS(config)
    if #config.num ~= 2 then
        return
    end

    this.pixSpeed = this.pixSpeed + tonumber(config.num[1])
    this.BaseScore[this.JudgeType.Perfect] = this.BaseScore[this.JudgeType.Perfect] + tonumber(config.num[2])

    print("this.pixSpeed is: " .. this.pixSpeed)
end

this.ItemEffects = {
    [1] = {Func=this.EffectMaxHP},
    [2] = {Func=this.EffectPowerSAB},
    [3] = {Func=this.EffectBurnExpend},
    [4] = {Func=this.EffectJudgeRegion},
    [5] = {Func=this.EffectBurnMiss},
    [6] = {Func=this.EffectTriggerHPAndTakeOutHP,Trigger=true},
    [7] = {Func=this.EffectComboSection3,Trigger=true},
    [8] = {Func=this.EffectSpeedAndPointPreciseS},
}


function this.InitMusicConstantsConfig()

    local MusicConstants = ConfigRhythmGameMgr.GetMusicConstants()
    if this.mCurConfig.speed < 200 then
        LuaDebug.error("speed < 200 use 200 up auto set 200")
        this.pixSpeed = 200
    else
        this.pixSpeed = this.mCurConfig.speed
    end
    
    this.TakeOutHP = MusicConstants.TakeOutHP
    this.OriTakeOutHP = this.TakeOutHP
    this.MaxPower = MusicConstants.MaxPower
    this.BasicHP = MusicConstants.BasicHP

    this.PerfectMS = tonumber(MusicConstants.PreciseRadius_S[1])
    this.EndPerfectMS = tonumber(MusicConstants.PreciseRadius_S[2])
    this.GreatMS = tonumber(MusicConstants.PreciseRadius_A[1])
    this.EndGreatMS = tonumber(MusicConstants.PreciseRadius_A[2])
    this.GoodMS = tonumber(MusicConstants.PreciseRadius_B[1])
    this.EndGoodMS = tonumber(MusicConstants.PreciseRadius_B[2])
    this.MissMS = tonumber(MusicConstants.PreciseRadius_Miss[1])
    this.EndMissMS = tonumber(MusicConstants.PreciseRadius_Miss[2])

    this.NoInputMissMS = tonumber(MusicConstants.PreciseRadius_Miss2)

    this.HoldFrequency = MusicConstants.HoldFrequency or 200

    this.BaseScore = {
        [this.JudgeType.None] = 0,
        [this.JudgeType.Perfect] = MusicConstants.PointPrecise_S,
        [this.JudgeType.Great] = MusicConstants.PointPrecise_A,
        [this.JudgeType.Good] = MusicConstants.PointPrecise_B,
        [this.JudgeType.Miss] = MusicConstants.PointPrecise_Miss
    }

    this.BurnExpend = MusicConstants.BurnExpend
    this.BurnMiss = MusicConstants.BurnMiss
    this.BaseAddEnergy = {
        [this.JudgeType.None] = 0,
        [this.JudgeType.Perfect] = MusicConstants.PowerUP_S,
        [this.JudgeType.Great] = MusicConstants.PowerUP_A,
        [this.JudgeType.Good] = MusicConstants.PowerUP_B,
        [this.JudgeType.Miss] = MusicConstants.PowerDown_Miss,
    }

    this.PointBatType_HoldOn = MusicConstants.PointBatType_HoldOn
    this.NoteTypeScore = {
[this.NoteType.OneOffType] = MusicConstants.PointBatType_TAP,
[this.NoteType.SpanType] = MusicConstants.PointBatType_Hold,
[this.NoteType.DoubleSpanType] = MusicConstants.PointBatType_Continuous,
[this.NoteType.BombType] = MusicConstants.PointBatType_Evade,
[this.NoteType.ReverseType] = MusicConstants.PointBatType_Reverse,
[this.NoteType.HideType] = MusicConstants.PointBatType_Vanish,
[this.NoteType.DoubleClickType] = MusicConstants.PointBatType_Double,
    }

    this.StateMultiple = MusicConstants.StateMultiple
    this.StateMultiple_Burn = MusicConstants.StateMultiple_Burn

    this.ComboSection = {}
    table.insert(this.ComboSection, tonumber(MusicConstants.ComboSection[1]))
    table.insert(this.ComboSection, tonumber(MusicConstants.ComboSection[2]))
    table.insert(this.ComboSection, tonumber(MusicConstants.ComboSection[3]))


    this.PointComboSect_3 = MusicConstants.PointComboSect_3
    this.HitScore = {
        MusicConstants.PointComboSect_1,
        MusicConstants.PointComboSect_2,
        MusicConstants.PointComboSect_3,

    }

    this.MaxDoubleSpanCount = 20

    this.AddItemEffect()
end

function this.GetMusicEquip(id)
    for k, v in pairs(ConfigMgr.Config.MusicEquips) do
        if id == v.id then
            return v
        end
    end
end

function this.AddItemEffect()
    local musicEquips = DataMgr.Player.musicEquips.Equip
    this.TriggerEvents = {}
    local musicConfig,typeStr = PlayerRhythmGameMgr.GetMusicConfig();
    if (typeStr ~= nil) then return end
    for i, v in pairs(musicEquips) do
        i = tonumber(i)
        local item = this.GetMusicEquip(i)
        if item then
            local configItem = this.ItemEffects[item.id]
            if configItem then
                if not configItem.Trigger then
                    configItem.Func(item)
                else
                    table.insert(this.TriggerEvents, item)
                end
            else
                LuaDebug.error("no ItemEffects config music equip id" .. item.id)
            end
        else
            LuaDebug.error("no config music equip id" .. i)
        end
    end 
end

function this.TriggetItemEffect()
    for i, item in pairs(this.TriggerEvents) do
        if item then
            local configItem = this.ItemEffects[item.id]
            if configItem then
                if configItem.Trigger then
                    configItem.Func(item)
                end
            else
                LuaDebug.error("no ItemEffects config music equip id" .. item.id)
            end
        else
            LuaDebug.error("no config music equip id" .. i)
        end
    end 
end
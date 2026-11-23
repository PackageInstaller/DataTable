local this = {












};

local objs = {
    rootMask = {
        path = "root/RootMask",
        type = "Button"
    },

    songName = {
        path = "root/Middle/Info/Name",
        type = "Text"
    },
    maxSocre = {
        path = "root/Middle/Info/MaxScore",
        type = "Text"
    },
    cutNum = {
        path = "root/Middle/Info/CutNum",
        type = "Text"
    },

    autoJudge = {
        path = "root/Middle/AutoJudge",
        type = "Toggle"
    },
    maxPower = {
        path = "root/Middle/MaxPower",
        type = "Toggle"
    },
    god = {
        path = "root/Middle/God",
        type = "Toggle"
    },

    btnWin = {
        path = "root/Middle/BtnWin",
        type = "Button"
    },

    btnClearHelp = {
        path = "root/Middle/BtnClearHelp",
        type = "Button"
    }
};

this.SetData = function()
    SetActive(this.autoJudge.gameObject, false)
    local musicConfig,typeStr = PlayerRhythmGameMgr.GetMusicConfig()
    local content = ConfigRhythmGameMgr.GetMusicSongByEventId(musicConfig.id,typeStr)

    this.songName.text = LuaMgr.GetLangText("RhythmGameTest_0") .. LuaMgr.GetLangText(content.nameLan) .. LuaMgr.GetLangText("RhythmGameTest_1") .. content.type .. " ID: " ..
                             content.id .. " eventID: " .. musicConfig.id
    this.maxSocre.text = LuaMgr.GetLangText("RhythmGameTest_2") .. RhythmGameMgr.Data.maxScore

    local allCount = RhythmGameMgr.GetAllNoteCount()
    local str = ""
    for i, v in pairs(RhythmGameMgr.NoteTypeName) do
        str = str .. v .. ": " .. (allCount[i] or 0) .. " "
    end

    this.cutNum.text = LuaMgr.GetLangText("RhythmGameTest_3") .. str

    if RhythmGameMgr.Cheat then
        this.autoJudge.isOn = RhythmGameMgr.Cheat.autoJudge
        this.maxPower.isOn = RhythmGameMgr.Cheat.maxPower
        this.god.isOn = RhythmGameMgr.Cheat.god
    else
        this.autoJudge.isOn = false
        this.maxPower.isOn = false
        this.god.isOn = false
    end
end

this.OnClose = function()
    RhythmGameMgr.Play();
    LuaMgr.HidePanel(UIName.RhythmGameTest);

    RhythmGameMgr.Cheat = {}
    RhythmGameMgr.Cheat.autoJudge = this.autoJudge.isOn
    RhythmGameMgr.Cheat.maxPower = this.maxPower.isOn
    RhythmGameMgr.Cheat.god = this.god.isOn

    if this.god.isOn then
        RhythmGameMgr.Data.hp = RhythmGameMgr.BasicHP
    end

    if RhythmGameMgr.Cheat.maxPower then
        RhythmGameMgr.Data.energy = RhythmGameMgr.MaxPower
        RhythmGameMgr.isEnergy = true
        RhythmGameMgr.onEnergy(true);
    end
end

this.OnWin = function()
    RhythmGameMgr.TimeScale(1)
    LuaMgr.HidePanel(UIName.RhythmGameTest);

    RhythmGameMgr.Data.perfect = 0
    RhythmGameMgr.Data.great = 0
    RhythmGameMgr.Data.good = 0
    RhythmGameMgr.Data.miss = 0
    RhythmGameMgr.Data.perfect = RhythmGameMgr.Data.allNoteCount
    RhythmGameMgr.Data.score = RhythmGameMgr.Data.maxScore
    RhythmGameMgr.Data.perfectCount = RhythmGameMgr.Data.allNoteCount
    RhythmGameMgr.Data.missCount = 0
    RhythmGameMgr.Stop()
    RhythmGameMgr.StopUpdate()
    RhythmGameMgr.SendCompleteSong();
end

this.OnResetHelp = function()
    PlayerRhythmGameMgr.SetGuideData({Note={},Pic = {}} )
    if RhythmGameMgr.guideEvent then        
        RhythmGameMgr.guideEvent.FirstShow = true
        RhythmGameMgr.guideEvent.OnClickBtn = false
        RhythmGameMgr.guideEvent = nil
    end
end

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.rootMask, this.OnClose)

        LuaMgr.AddClick(this.btnWin, this.OnWin)
        LuaMgr.AddClick(this.btnClearHelp, this.OnResetHelp)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end

        this.SetData();
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.rootMask, this.OnClose)
        LuaMgr.RemoveClick(this.btnWin, this.OnWin)
        LuaMgr.RemoveClick(this.btnClearHelp, this.OnResetHelp)
    end
}

return vm({

    command = command,
    hook = hook
})
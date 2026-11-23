require("RhythmGame/ViewModel/RhythmGamePauseNoteItem")

local this = {
    time = 3,
    noteDatas = {
        {name="10701",tips="10711",select=false},
        {name="10702",tips="10712",select=false},
        {name="10703",tips="10713",select=false},
        {name="10704",tips="10714",select=false},
        {name="10705",tips="10715",select=false},
        {name="10706",tips="10716",select=false},
        {name="10707",tips="10717",select=false},
    },
    noteList = nil,
    selectNote = nil,
};

local objs = {
    animator = { path = "root/Middle", type = "UIAnimator" },
    pauseMaskGO = { path = "root/PauseMask", type = "GameObject" },
    pauseGO = { path = "root/Middle/Pause", type = "GameObject" },
    note1 = { path = "root/Middle/Pause/Notes/List/Note1", type = "GameObject" },
    note2 = { path = "root/Middle/Pause/Notes/List/Note2", type = "GameObject" },
    note3 = { path = "root/Middle/Pause/Notes/List/Note3", type = "GameObject" },
    note4 = { path = "root/Middle/Pause/Notes/List/Note4", type = "GameObject" },
    note5 = { path = "root/Middle/Pause/Notes/List/Note5", type = "GameObject" },
    note6 = { path = "root/Middle/Pause/Notes/List/Note6", type = "GameObject" },
    note7 = { path = "root/Middle/Pause/Notes/List/Note7", type = "GameObject" },
    noteTips = { path = "root/Middle/Pause/Tips/Text", type = "Text" },
    exitBtn = { path = "root/Middle/Pause/Exit", type = "Button" },
    restartBtn = { path = "root/Middle/Pause/Restart", type = "Button" },
    resumeBtn = { path = "root/Middle/Pause/Resume", type = "Button" },
    timeMaskGO = { path = "root/TimeMask", type = "GameObject" },
    timeGO = { path = "root/Middle/Time", type = "GameObject" },
    timeNum1 = { path = "root/Middle/Time/Num1", type = "GameObject" },
    timeNum2 = { path = "root/Middle/Time/Num2", type = "GameObject" },
    timeNum3 = { path = "root/Middle/Time/Num3", type = "GameObject" },
};


this.SetData = function()
    SetActive(this.pauseMaskGO, true);
    SetActive(this.pauseGO, true);
    SetActive(this.timeMaskGO, false);
    SetActive(this.timeGO, false);
    this.selectNote = this.noteDatas[1];
    this.selectNote.select = true;
    this.SetNoteList();
    this.animator.AnimationName = "ani_RhythmGamePausePanel_Middle_Pause";
end


this.OnTimer = function()
    if (this.time > 0) then
        this.time = this. time - 1;
        return;
    end
    LuaMgr.RemoveTimer(TimerConst.RhythmGamePauseTime);
    LuaMgr.HidePanel(UIName.RhythmGamePauseViewModel);
    RhythmGameMgr.Play();
end


this.InitNoteList = function()
    this.noteList = {};
    local len = #this.noteDatas;
    for i = 1, len do
        this.noteList[i] = RhythmGamePauseNoteItem.New(this["note" .. i], this.noteDatas[i]);
    end
end


this.SetNoteList = function()
    local len = #this.noteList;
    for i = 1, len do
        this.noteList[i]:SetData();
    end
    if (this.selectNote ~= nil) then
        this.noteTips.text = ConfigMgr.LangGlobal(this.selectNote.tips);
    end
end


this.OnNoteSelect = function(args)
    if (this.selectNote ~= nil) then
        this.selectNote.select = false;
    end
    this.selectNote = args[0];
    this.selectNote.select = true;
    this.SetNoteList();
end


this.OnClickExit = function()
    LuaMgr.HidePanel(UIName.RhythmGamePauseViewModel);
    local musicConfig,typeStr = PlayerRhythmGameMgr.GetMusicConfig();
    ConfigRhythmGameMgr.ShowMusicPanel(typeStr)   
end


this.OnClickRestart = function()
    LuaMgr.HidePanel(UIName.RhythmGamePauseViewModel);
    LuaMgr.InvokeUIEventListeners(UIEventConst.RhythmGameRestart);
end


this.OnClickResume = function()
    SetActive(this.pauseMaskGO, false);
    SetActive(this.pauseGO, false);
    SetActive(this.timeMaskGO, true);
    SetActive(this.timeGO, true);
    this.time = 3;
    this.animator.AnimationName = "ani_RhythmGamePausePanel_Middle_Time";
    LuaMgr.AddTimer(TimerConst.RhythmGamePauseTime, this.OnTimer, 1, -1, true);
end

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);

        this.InitNoteList();
        LuaMgr.AddClick(this.exitBtn, this.OnClickExit);
        LuaMgr.AddClick(this.restartBtn, this.OnClickRestart);
        LuaMgr.AddClick(this.resumeBtn, this.OnClickResume);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.AddUIEventListener(UIEventConst.RhythmGamePauseNoteSelect, this.OnNoteSelect);
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.RhythmGamePauseTime);
        LuaMgr.RemoveUIEventListener(UIEventConst.RhythmGamePauseNoteSelect, this.OnNoteSelect);
        RhythmGameMgr.TimeScale(1);
        if (this.selectNote ~= nil) then
            this.selectNote.select = false;
            this.selectNote = nil;
        end
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.exitBtn, this.OnClickExit);
        LuaMgr.RemoveClick(this.restartBtn, this.OnClickRestart);
        LuaMgr.RemoveClick(this.resumeBtn, this.OnClickResume);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})
local this = {
    curType = nil,
};

local objs = {
    exitBtn = { path = "root/Middle/Pause/Exit", type = "Button" },
    restartBtn = { path = "root/Middle/Pause/Restart", type = "Button" },
    textRestart = { path = "root/Middle/Pause/Restart/TextRestart", type = "Text" },
    textExit = { path = "root/Middle/Pause/Exit/TextExit", type = "Text" },
    textTitle = { path = "root/Middle/Pause/TextTitle", type = "Text" },
    textContent = { path = "root/Middle/Pause/TextContant", type = "Text" },
};


this.SetData = function(type)
    this.curType = type
    if (type == 1) then
        this.textContent.text = LuaMgr.GetLangText("FSMYGamePauseViewModel_0")
        this.textRestart.text = LuaMgr.GetLangText("FSMYGamePauseViewModel_1")
        this.textExit.text = LuaMgr.GetLangText("FSMYGamePauseViewModel_2")
    elseif (type == 2) then
        this.textContent.text = LuaMgr.GetLangText("FSMYGamePauseViewModel_3")
        this.textRestart.text = LuaMgr.GetLangText("FSMYGamePauseViewModel_4")
        this.textExit.text = LuaMgr.GetLangText("FSMYGamePauseViewModel_5")
    elseif (type == 3) then
        this.textContent.text = LuaMgr.GetLangText("FSMYGamePauseViewModel_6")
        this.textRestart.text = LuaMgr.GetLangText("FSMYGamePauseViewModel_7")
        this.textExit.text = LuaMgr.GetLangText("FSMYGamePauseViewModel_8")
    else
        this.textContent.text = LuaMgr.GetLangText("FSMYGamePauseViewModel_9")
        this.textRestart.text = LuaMgr.GetLangText("FSMYGamePauseViewModel_10")
        this.textExit.text = LuaMgr.GetLangText("FSMYGamePauseViewModel_11")
    end
end


this.OnClickExit = function()
    LuaMgr.HidePanel(UIName.FSMYGamePauseViewModel);
    if (this.curType == 4) then
        LuaMgr.Back()
    end
end


this.OnClickRestart = function()
    LuaMgr.HidePanel(UIName.FSMYGamePauseViewModel);
    if (this.curType == 1 or this.curType == 4) then
        LuaMgr.InvokeUIEventListeners(UIEventConst.FSMYGameRestart);
    elseif (this.curType == 2) then
        LuaMgr.InvokeUIEventListeners(UIEventConst.FSMYGameSkip);
    else
        LuaMgr.Back()
    end
end

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.exitBtn, this.OnClickExit);
        LuaMgr.AddClick(this.restartBtn, this.OnClickRestart);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.SetData(vm.behaviour.Params[0]);
    end,
    before_deactive = function(vm)

    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.exitBtn, this.OnClickExit);
        LuaMgr.RemoveClick(this.restartBtn, this.OnClickRestart);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})
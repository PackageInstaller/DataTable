local this = {
    curType = nil,
};

local objs = {
    exitBtn = { path = "root/Middle/Pause/Exit", type = "Button" },
    exit2Btn = { path = "root/Middle/Pause/Exit2", type = "Button" },
    restartBtn = { path = "root/Middle/Pause/Restart", type = "Button" },
    textContent = { path = "root/Middle/Pause/TextContant", type = "Text" },
    typeBox1 = { path = "root/Middle/Pause/typeBox1", type = "GameObject" },
    typeBox2 = { path = "root/Middle/Pause/typeBox2", type = "GameObject" },
    typeBox3 = { path = "root/Middle/Pause/typeBox3", type = "GameObject" },
    typeBox4 = { path = "root/Middle/Pause/typeBox4", type = "GameObject" },
};


this.SetData = function(type)
    this.curType = type
    if (type == 1) then
        this.textContent.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_33207")
    elseif (type == 2) then
        this.textContent.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_33208")
    elseif (type == 3) then
        this.textContent.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_33209")
    else
        this.textContent.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_33206")
    end
    for i = 1, 4 do
        local isShow = i == this.curType
        this["typeBox" .. i]:SetActive(isShow)
    end
end


this.OnClickExit = function()
    LuaMgr.HidePanel(UIName.WJWYGamePausePanel);
    if (this.curType == 4) then
        LuaMgr.Back()
    end
end


this.OnClickRestart = function()
    LuaMgr.HidePanel(UIName.WJWYGamePausePanel);
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
        LuaMgr.AddClick(this.exit2Btn, this.OnClickExit);
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
        LuaMgr.RemoveClick(this.exit2Btn, this.OnClickExit);
        LuaMgr.RemoveClick(this.restartBtn, this.OnClickRestart);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})
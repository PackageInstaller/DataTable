local this = {
    vm = nil,
    characterId = "",
};

local data = {
    title = "",
    effectList = {
        {
            name = "",
            desc = "",
            isChoose = false,
            isNotChoose = false,
        }
    },
}

local command = {
    closeBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.RogueDebuffPopup);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.characterId = vm.behaviour.Params[0]
        this.Refresh()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
    end,
    before_destroy = function(vm)
        this = nil;
    end
}

this.Refresh = function()
    local debuffGroup = ConfigMgr.Config.RogueConstants.RogueDeBuff
    local debuffGroupDesc = ConfigMgr.Config.RogueConstants.RogueDeBuffDesc
    local debuffLevel = RogueMgr.GetCharacterDebuffLevel(this.characterId)
    this.vm.data.title = string.format(LuaMgr.GetLangText("RogueDebuffPopup_0"), debuffLevel, #debuffGroup)
    local tempList = {}
    for i = 1, #debuffGroup do
        local desc = ""
        if not TableIsNull(debuffGroupDesc) and i <= #debuffGroupDesc then
            desc = ConfigMgr.LangGlobal(debuffGroupDesc[i])
        end
        local effectItem = {
            name = string.format(LuaMgr.GetLangText("RogueDebuffPopup_1"), NumTool.GetMaxNum(i)),
            desc = desc,
            isChoose = i <= debuffLevel,
            isNotChoose = i > debuffLevel
        }
        table.insert(tempList, effectItem)
    end
    this.vm.data.effectList = tempList
end

return vm({
    data = data,
    command = command,
    hook = hook
})
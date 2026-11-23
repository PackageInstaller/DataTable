local this = {
    vm = nil,
    characterId = "",
};

local data = {
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
            LuaMgr.HidePanel(UIName.RogueExploreLevelPopup);
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
    local RogueLevelAttribute = ConfigMgr.Config.RogueConstants.RogueLevelAttribute
    local RogueLevelAttrDesc = ConfigMgr.Config.RogueConstants.RogueLevelAttributeDesc
    local exploreLevel = RogueMgr.GetCharacterExploreLevel(this.characterId)
    local tempList = {}
    for i = 1, #RogueLevelAttribute do
        local desc = ""
        if not TableIsNull(RogueLevelAttrDesc) and i <= #RogueLevelAttrDesc then
            desc = ConfigMgr.LangGlobal(RogueLevelAttrDesc[i])
        end
        local effectItem = {
            name = string.format(LuaMgr.GetLangText("RogueExploreLevelPopup_0"), i),
            desc = desc,
            isChoose = i <= exploreLevel,
            isNotChoose = i > exploreLevel
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
local this = {
    vm = nil,
}

local data = {
    icon = DefaultTexture,
    rare = DefaultSprite,
    job = DefaultSprite,
    name = "",
    attr1_img = DefaultSprite,
    attr1_desc = "",
    attr2_img = DefaultSprite,
    attr2_desc = "",
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.ActivityBossDummyBonusPreviewViewModel)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        local params = this.vm.behaviour.Params
        local heroid = params[0]
        local config = params[1]

        local characterConfig = ConfigMgr.Config.characterTable[heroid]
        this.vm.data.name = LuaMgr.GetLangText(characterConfig.namelan)
        this.vm.data.icon = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(heroid))
        this.vm.data.rare = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_pz_" .. ConfigMgr.Config.characterTable[heroid].rare)
        this.vm.data.job = LuaMgr.GetSprite("JobIcon", "job_" .. ConfigMgr.Config.characterTable[heroid].job)

        local ls = {}
        for _, v in ipairs(config.Condition3desc) do
            if v[1] == heroid then
                table.insert(ls, v)
            end
        end
        if #ls == 2 then
            this.vm.data.attr1_img = LuaMgr.GetSprite("AttributeIcon", ls[1][2])
            this.vm.data.attr1_desc = LuaMgr.GetLangText(ConfigMgr.Config.attrDesMap[ls[1][2]].NameLan) .. "+" .. ls[1][3] .. "%"

            this.vm.data.attr2_img = LuaMgr.GetSprite("AttributeIcon", ls[2][2])
            this.vm.data.attr2_desc = LuaMgr.GetLangText(ConfigMgr.Config.attrDesMap[ls[2][2]].NameLan) .. "+" .. ls[2][3] .. "%"
        end
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})
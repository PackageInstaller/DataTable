local this = {
    vm = nil,
    skillLevel_1 = 1,
    skillLevel_2 = 1,
}

local data = {
    ascensionSkillIcon_1 = DefaultTexture,
    ascensionSkillIcon_2 = DefaultTexture,
    ascensionSkillLevel_1 = "",
    ascensionSkillLevel_2 = "",
    ascensionLevelLimit_1 = "",
    ascensionLevelLimit_2 = "",
}

local command = {
    infoSkill1Command = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowPanel(UIName.SkillTipsViewModel, 5, this.curWeaponId, nil, nil, 5, nil, this.skillLevel_1)
        end
    },
    infoSkill2Command = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowPanel(UIName.SkillTipsViewModel, 5, this.curWeaponId, nil, nil, 5, nil, this.skillLevel_2)
        end
    },
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.TeamWeaponAscensionSuccessPopup)
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
        this.curWeaponId = vm.behaviour.Params[0]
        this.SetData()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.SetData = function()
    local weaponCfg = TeamWeaponMgr.GetTeamWeaponCfg(this.curWeaponId)
    local weaponData = TeamWeaponMgr.GetTeamWeaponData(this.curWeaponId)
    local beforeStar = weaponData.Star - 1
    local curStar = weaponData.Star
    local skillId = weaponCfg.TeamWeaponSkill[1]
    local skillIcon = LuaMgr.GetTexture(LuaMgr.GetSkillIcon(string.gsub(skillId, "ex", "")))
    this.skillLevel_1 = weaponCfg.TeamWeaponSkillStar[beforeStar]
    this.skillLevel_2 = weaponCfg.TeamWeaponSkillStar[curStar]
    this.vm.data.ascensionSkillLevel_1 = this.skillLevel_1
    this.vm.data.ascensionSkillLevel_2 = this.skillLevel_2
    this.vm.data.ascensionSkillIcon_1 = skillIcon
    this.vm.data.ascensionSkillIcon_2 = skillIcon
    this.vm.data.ascensionLevelLimit_1 = string.format(LuaMgr.GetLangText("TeamWeaponAscensionSuccessPopup_0"), weaponCfg.LevelLimite[beforeStar])
    this.vm.data.ascensionLevelLimit_2 = string.format(LuaMgr.GetLangText("TeamWeaponAscensionSuccessPopup_1"), weaponCfg.LevelLimite[curStar])
end

return vm(
        {
            data = data,
            command = command,
            hook = hook
        }
)
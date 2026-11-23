local this = {
    vm = nil,
}

local data = {
    teamList = {
        {
            teamName = "",
            characterList = {
                {
                    icon = DefaultTexture,
                    rare = DefaultSprite,
                    job = DefaultSprite,
                    level = "",
                    characterHeadActive = false,
                }
            },
            isOn = false,
            isOff = false,
            replaceIconActive = false,
            weaponIcon = DefaultSprite,
            weaponLevel = "",
            showEffect = false,
        }
    }
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.TeamWeaponPreparePopup)
        end
    },
    teamCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local teamFormationId = param
            local tempTeam = {}
            local chaList = this.vm.data.teamList[teamFormationId + 1]
            for i = 1, #chaList.characterList do
                if chaList.characterList[i].characterId ~= "" then
                    table.insert(tempTeam, chaList.characterList[i].characterId)
                end
            end
            HeroParameter.SaveTeamParam(teamFormationId, true, "", function()
                HeroParameter.isTeamChanged = true
            end)

            PlayerAssistMgr.isSupport = false
            TeamWeaponMgr.isShowPreparePopup = true
            LuaMgr.HidePanel(UIName.TeamWeaponPreparePopup)
            FeatureManager.GotoPanel("1004")
        end
    },
    relpaceCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local teamId = tostring(param)
            local originTeamData = DataMgr.Player.teams[teamId]
            local param = {
                members = {},
                helps = {},
            }
            if originTeamData ~= nil then
                param = table.Copy(originTeamData)
            end
            param.teamId = teamId
            if not IsNullOrEmpty(originTeamData.teamWeapon) and originTeamData.teamWeapon == this.curWeaponId then
                param.teamWeapon = ""
            else
                param.teamWeapon = this.curWeaponId
            end
            BattlePrepareMgr.CheckAndSaveTeam(param, function(result)
                this.RefreshData()
                this.vm.data.teamList[tonumber(teamId) + 1].showEffect = true
                LuaMgr.InvokeUIEventListeners(UIEventConst.TeamWeaponChangeWeaponTeam)
            end)
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
        TeamWeaponMgr.isShowPreparePopup = false
        this.curWeaponId = vm.behaviour.Params[0]
        this.RefreshData()
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

this.RefreshData = function()
    local teamDatas = DataMgr.Player.teams
    local tempTeamList = {}
    local count = ConfigMgr.Config.constants.maxSquadCount
    for teamIndex = 0, count - 1 do
        local teamItemData = {
            teamId = teamIndex,
            teamName = LuaMgr.GetLangText("BattlePrepareViewModel_14") .. (teamIndex + 1),
            isOn = false,
            isOff = true,
            replaceIconActive = false,
            showEffect = false,
            characterList = {}
        }

        local team = DataMgr.Player.teams[tostring(teamIndex)]
        if team ~= nil then
            teamItemData.teamName = team.name
            local weaponId = team.teamWeapon
            if not IsNullOrEmpty(weaponId) then
                local weaponCfg = TeamWeaponMgr.GetTeamWeaponCfg(weaponId)
                local weaponData = TeamWeaponMgr.GetTeamWeaponData(weaponId)
                teamItemData.isOn = true
                teamItemData.isOff = false
                teamItemData.replaceIconActive = weaponId ~= this.curWeaponId
                teamItemData.weaponIcon = LuaMgr.GetSprite("TeamWeapon", weaponCfg.IconRes)
                teamItemData.weaponLevel = tostring(weaponData.Level)
            end
            local tempChaList = {}
            for i = 0, 5 do
                local characterId = team.members[tostring(i)]
                local uid = team.helps[tostring(i)]
                local chaItemData = {}
                if IsNullOrEmpty(characterId) or not IsNullOrEmpty(uid) then
                    chaItemData.characterHeadActive = false
                    chaItemData.sort = 5 + i
                else
                    local characterConfig = ConfigMgr.Config.characterTable[characterId]
                    local character = DataMgr.Player.characters[characterId];
                    local tempRare = HeroMgr.GetHeroNowRare(characterId)
                    local imageRare = tempRare >= 5 and 4 or tempRare
                    chaItemData.sort = i
                    chaItemData.characterId = characterId
                    chaItemData.name = LuaMgr.GetLangText(characterConfig.namelan)
                    chaItemData.icon = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(characterId, character.curSkin))
                    chaItemData.rare = LuaMgr.GetSprite("CommonRes", "ui_home_kbn_tx" .. imageRare)
                    chaItemData.job = LuaMgr.GetSprite("JobIcon", "job_" .. characterConfig.job)
                    chaItemData.level = tostring(character.level)
                    chaItemData.characterHeadActive = true
                end
                table.insert(tempChaList, chaItemData)
            end
            table.sort(tempChaList, function(a, b)
                return a.sort < b.sort
            end)
            teamItemData.characterList = tempChaList
        else
            for i = 0, 5 do
                table.insert(teamItemData.characterList, {
                    characterHeadActive = false
                })
            end
        end
        table.insert(tempTeamList, teamItemData)
    end
    table.sort(tempTeamList, function(a, b)
        return a.teamId < b.teamId
    end)
    this.vm.data.teamList = tempTeamList
end

return vm(
        {
            data = data,
            command = command,
            hook = hook
        }
)
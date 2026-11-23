





local this = {vm = nil,friendlyLevel = nil,characterId = nil,characterData = nil,prestigeConfig = nil,
              recordRect = nil,assessRect = nil,tableInsert = table.insert,HeroManager = CS.Laigu.ViewModel.Hero.HeroManager,
              AUDIO_PATH_SHOW = "Assets/_BundleResources/Audio/UI/Friendship_tips.mp3",
              AUDIO_PATH_POPUP = "Assets/_BundleResources/Audio/UI/Friendship_content.mp3"}

local data = {
    skillRoot = false,report = false,
    record = false,assess = false,
    headIcon = DefaultTexture,
    level1 = "",level2 = "",
    skillIcon = DefaultTexture,
    skillName = "",
    skillLevel1 = "",skillLevel2 = "",
    skillBox1 = DefaultSprite,skillBox2 = DefaultSprite,
    skillIntro1 = "",skillIntro2 = "",
    recordList = {{strText = ""}},
    assessList = {{strText = ""}},
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.FriendlyTipsViewModel)
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.recordRect = vm.behaviour.transform:Find("root/Content/Report/Record/Text/List"):GetComponent("RectTransform")
        this.assessRect = vm.behaviour.transform:Find("root/Content/Report/Assess/Text/List"):GetComponent("RectTransform")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        AudioMgr.Singleton:PlayUISFX(this.AUDIO_PATH_SHOW)
        this.InitParameter()
        this.InitCharacter()
        if this.GetType() == 1 then
            this.UnlockSkillType()
        elseif this.GetType() == 3 then
            this.UnlockReport()
            LuaMgr.NextFrame(function()
                if this ~= nil then
                    RectTool.RebuildLayoutImmediate(this.recordRect)
                    RectTool.RebuildLayoutImmediate(this.assessRect)
                end
            end)
        end
        this.UpdateStatus()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
    before_destroy = function(vm)
        this = nil
    end,
}


this.InitParameter = function()
    if this.vm.behaviour.Params.Length > 0 then
        this.characterId = this.vm.behaviour.Params[0]
        this.friendlyLevel = this.vm.behaviour.Params[1]
        this.characterData = DataMgr.Player.characters[this.characterId]
        this.prestigeConfig = ConfigMgr.Config.characterPreferences[this.characterId]
    end
end


this.InitCharacter = function()
    local text = ""
    this.vm.data.headIcon = LuaMgr.GetTexture(this.HeroManager.GetCharacterAvatar(this.characterId))
    if this.friendlyLevel==nil then
        this.friendlyLevel=1;
    end
    text = LuaMgr.GetLangText(ConfigMgr.Config.friendshipDescription[tostring(this.friendlyLevel - 1)].iconDescriptionLan)
    this.vm.data.level1 = text
    text = LuaMgr.GetLangText(ConfigMgr.Config.friendshipDescription[tostring(this.friendlyLevel)].iconDescriptionLan)
    this.vm.data.level2 = text
end


this.UnlockSkillType = function()
    local skill = this.prestigeConfig.friendshipTalent[this.friendlyLevel]
    if skill ~= nil then
        local id,level = skill[1],tonumber(skill[3])
        local config = ConfigSkillMgr.GetCharacterSkill(id..skill[3])
        this.vm.data.skillName = LuaMgr.GetLangText(config.NameLan)
        this.vm.data.skillIcon = LuaMgr.GetTexture(LuaMgr.GetSkillIcon(id))
        this.vm.data.skillLevel1 = tostring(level - 1)
        this.vm.data.skillLevel2 = tostring(level)
        this.vm.data.skillBox1 = LuaMgr.GetSprite("SkillLevelBox","Level_"..level - 1)
        this.vm.data.skillBox2 = LuaMgr.GetSprite("SkillLevelBox","Level_"..level)
        skill = LuaMgr.GetCharacterSkillDes(id,level - 1)
        this.vm.data.skillIntro1 = skill[0]
        skill = LuaMgr.GetCharacterSkillDes(id,level)
        this.vm.data.skillIntro2 = skill[0]
    end
end


this.UnlockReport = function()
    local config = this.prestigeConfig.friendshipTalent[this.friendlyLevel]
    if config ~= nil then
        local index,lingth = 2,#config / 2
        local archives,tempItem = nil,nil
        local tempRecords,tempAssess = {},{}
        for i = 1, lingth do
            if config[index] == "3" then
                archives = this.GetLinesUnlock(config[index - 1])
                if archives == nil then return end
                tempItem = {strText = LuaMgr.GetLangText(archives.typeNamelan)}
                this.tableInsert(tempRecords,tempItem)
            elseif config[index] == "4" then
                archives = this.GetArchives(config[index - 1])
                if archives == nil then return end
                tempItem = {strText = LuaMgr.GetLangText(archives.titleLan)}
                this.tableInsert(tempAssess,tempItem)
            end
            index = index + 2
        end
        this.vm.data.recordList = tempRecords
        this.vm.data.record = #tempRecords >= 1
        this.vm.data.assessList = tempAssess
        this.vm.data.assess = #tempAssess >= 1
    end
end

this.UpdateStatus = function()
    this.vm.data.skillRoot = this.GetType() == 1
    this.vm.data.report = this.GetType() == 3
    AudioMgr.Singleton:PlayUISFX(this.AUDIO_PATH_POPUP);
end


this.GetType = function()
    local config = ConfigMgr.Config.characterPreferences[this.characterId].friendshipTalent
    for i = 2, #config[this.friendlyLevel],2 do
        if config[this.friendlyLevel][i] == "1" then return 1 end
        if config[this.friendlyLevel][i] == "2" then return 2 end
        if config[this.friendlyLevel][i] == "3" then return 3 end
        if config[this.friendlyLevel][i] == "4" then return 4 end
    end
end

this.GetLinesUnlock = function(linesType)
    for i = 1, #ConfigMgr.Config.linesUnlock do
        if ConfigMgr.Config.linesUnlock[i].linesType == linesType then
            return ConfigMgr.Config.linesUnlock[i]
        end
    end
    return nil
end

this.GetArchives = function(id)
    return ConfigMgr.Config.characterFileTextMap[id]
end
return vm({
    data = data,
    command = command,
    hook = hook
})
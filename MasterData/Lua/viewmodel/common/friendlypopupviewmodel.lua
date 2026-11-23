





local this = {vm = nil,level = nil,characterId = nil,characterData = nil,prestigeConfig = nil,
              lockStatus = nil,tableInsert = table.insert,HeroManager = CS.Laigu.ViewModel.Hero.HeroManager,
              BADGE_ICON_PATH = "Assets/_BundleResources/Images/FriendlyIcon/",
              voicePath = "Assets/_BundleResources/Character/",tweener = nil,voiceBool = false,voiceIndex = 0,
              msgIndex = 0,masStr = nil}
local data = {
    skillRoot = false,report = false,goods = false,
    textObject = false,lanText = "",titleText = "",
    friendlyLevel = "",
    bgWidth = Vector2.zero,
    recordPos = Vector2.zero,
    skillIcon = DefaultTexture,skillName = "",
    SkillLevel = "",skillIntro = "",skillBox = DefaultSprite,
    badgePos = Vector2.zero,badgeIcon = DefaultTexture,nameText = "",
    badgeTextRoot = false,badgeText = "",symbolNameText = "",
    assessList = {{aNewIcon = false,headIcon = DefaultTexture,aTitle = "",aLock = false}},
    recordList = {{rNewIcon = false,rTitle = "",rLock = false,rTimeBar = false,rBar = 0.0}},
    tagList = {{tagBox = DefaultSprite,tagText = ""}}
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            AudioMgr.Singleton:StopVoice()
            LuaMgr.HidePanel(UIName.FriendlyPopupViewModel)
        end
    },
    unLockCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param) + 1
            local text = this.vm.data.assessList[index].textLan
            this.vm.data.titleText = this.vm.data.assessList[index].aTitle
            this.vm.data.lanText = LuaMgr.GetLangText(text)
            this.vm.data.textObject = true
        end
    },
    playSoundCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param) + 1
            AudioMgr.Singleton:StopVoice(false)
            if this.voiceBool then
                if this.voiceIndex == index then
                    this.voiceBool = false
                    this.voiceIndex = 0
                    if this.tweener ~= nil then
                        this.tweener:Kill()
                    end
                    this.vm.data.recordList[index].rTimeBar = false
                    return
                end
            end
            this.PlayerSound(index)
        end
    },
    lockCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.level ~= this.characterData.prestigeLevel then
                local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2131"].NameLan)
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(tipStr,this.level,ConfigHelper.GetFriendlyLevelText(this.level)))
            end
        end
    },
    hideTextCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.vm.data.textObject = false
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.voiceBool = false
        this.voiceIndex = 0
        this.InitParameter()
        if this.GetType() == 1 then
            this.UnlockSkillType()
        elseif this.GetType() == 2 then
            this.UnlockGoods()
        elseif this.GetType() == 3 or this.GetType() == 4 then
            this.UnlockReport()
        end
        this.UpdateStatus()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.vm.data.badgeText = ""
    end,
    before_destroy = function(vm)
        this = nil
    end,
}


this.InitParameter = function()
    if this.vm.behaviour.Params.Length > 0 then
        this.characterId = this.vm.behaviour.Params[0]
        this.level = this.vm.behaviour.Params[1]
        this.characterData = DataMgr.Player.characters[this.characterId]
        this.prestigeConfig = ConfigMgr.Config.characterPreferences[this.characterId]
        this.lockStatus = this.level > this.characterData.prestigeLevel
        local name = ConfigHelper.GetFriendlyLevelAllText(this.level)
        this.vm.data.friendlyLevel = name
    end
end


this.UnlockSkillType = function()
    if TableIsNull(this.prestigeConfig) or TableIsNull(this.prestigeConfig.friendshipTalent) then
        return
    end
    if #this.prestigeConfig.friendshipTalent < this.level then
        return
    end
    local skill = this.prestigeConfig.friendshipTalent[this.level]
    if skill ~= nil then
        local id,lv = skill[1],tonumber(skill[3])
        local config = ConfigSkillMgr.GetCharacterSkill(id..skill[3])
        this.vm.data.skillName = LuaMgr.GetLangText(config.NameLan)
        this.vm.data.skillIcon = LuaMgr.GetTexture(LuaMgr.GetSkillIcon(id))
        this.vm.data.SkillLevel = skill[3]
        this.vm.data.skillBox = LuaMgr.GetSprite("SkillLevelBox","Level_"..skill[3])
        local text = LuaMgr.GetCharacterSkillDes(id,lv)
        if text ~= nil and text.Count > 0 then
            this.vm.data.skillIntro = text[0]
        end
        local tempList = {}
        if config.SkillTag ~= "" and config.SkillTag ~= nil then
            local tagTab = NumTool.split(config.SkillTag,",")
            for i = 1, #tagTab,2 do
                local item = {tagBox = DefaultSprite,tagText = ""}
                local str = LuaMgr.GetLangText(tagTab[i])
                item.tagBox = LuaMgr.GetSprite("HeroRes","ui_yc_tc_kuang1")
                item.tagText = string.format("<color=#c1c0c0>%s</color>",str)





                table.insert(tempList,item)
            end
        end
        this.vm.data.tagList = tempList
    end
end


this.UnlockReport = function()
    local config = this.prestigeConfig.friendshipTalent[this.level]
    if config ~= nil then
        local index,lingth = 2,#config / 2
        local archives,tempItem = nil,nil
        local tempRecords,tempAssess = {},{}
        for i = 1, lingth do
            if config[index] == "3" then
                archives = this.GetLinesUnlock(config[index - 1])
                if archives == nil then return end
                tempItem = {rNewIcon = not this.lockStatus,rLock = this.lockStatus,
                            rTitle = LuaMgr.GetLangText(archives.typeNamelan),
                            lineType = archives.linesType,rTimeBar = false,rBar = 0.0}
                this.tableInsert(tempRecords,tempItem)
            elseif config[index] == "4" then
                archives = this.GetArchives(config[index - 1])
                if archives == nil then return end
                tempItem = {aNewIcon = not this.lockStatus,aLock = this.lockStatus,
                            headIcon = LuaMgr.GetTexture(this.HeroManager.GetCharacterAvatar(this.characterId)),
                            aTitle = LuaMgr.GetLangText(archives.titleLan),textLan = archives.textLan}
                this.tableInsert(tempAssess,tempItem)
            end
            index = index + 2
        end
        this.vm.data.recordList = tempRecords
        this.vm.data.assessList = tempAssess
        if #tempAssess == 0 then
            this.vm.data.recordPos = Vector2(0,73)
        else
            this.vm.data.recordPos = Vector2(0,-104)
        end
    end
end


this.UnlockGoods = function()
    local config = this.prestigeConfig.friendshipTalent[this.level]
    this.vm.data.badgeIcon = LuaMgr.GetTexture(this.BADGE_ICON_PATH.."friendly_"..config[1]..".png")
    local nameStr = LuaMgr.GetLangText(ConfigMgr.Config.characterTable[this.characterId].namelan)
    this.vm.data.nameText = nameStr
    if this.characterData.prestigeLevel == 10 then
        this.vm.data.symbolNameText = LuaMgr.GetLangText("FriendlyPopupViewModel_3")..nameStr
        this.msgIndex,this.masStr = 0,LuaMgr.GetLangText(this.prestigeConfig.poemLan)
        LuaMgr.AddTimer(TimerConst.TalentEffectTime,this.SetBadgeStr,0.05,-1,false)
    end
    this.vm.data.badgePos = this.characterData.prestigeLevel == 10 and Vector2(0,88) or Vector2(0,20)
    this.vm.data.badgeTextRoot = this.characterData.prestigeLevel == 10
end
this.UpdateStatus = function()
    this.vm.data.skillRoot = this.GetType() == 1
    this.vm.data.goods = this.GetType() == 2
    this.vm.data.report = this.GetType() == 3 or this.GetType() == 4
    if this.GetType() == 4 then
        this.vm.data.bgWidth = Vector2(510,443)
    else
        this.vm.data.bgWidth = Vector2(663,443)
    end
end


this.GetType = function()
    local config = ConfigMgr.Config.characterPreferences[this.characterId].friendshipTalent
    for i = 2, #config[this.level],2 do
        if config[this.level][i] == "1" then return 1 end
        if config[this.level][i] == "2" then return 2 end
        if config[this.level][i] == "3" then return 3 end
        if config[this.level][i] == "4" then return 4 end
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
this.PlayerSound = function(index)
    local skinID = DataHelper.GetCharacterSkin(this.characterId)
    local lineType = this.vm.data.recordList[index].lineType
    local audioName = "character_"..lineType.."_"..skinID
    local audioPath = LuaMgr.GetCharacterLineTypeAudioPatn(this.characterId)
    local path = Path.Character_PATH..this.characterId.."/"..audioPath.."/"..audioName..".mp3"
    local audioSource = AudioMgr.Singleton:PlayVoice(path)
    this.voiceBool = true
    if audioSource == nil then
        audioName = "character_"..lineType.."_"..this.characterId.."001"
        audioPath = LuaMgr.GetCharacterLineTypeAudioPatn(this.characterId)
        path = Path.Character_PATH..this.characterId.."/"..audioPath.."/"..audioName..".mp3"
        audioSource = AudioMgr.Singleton:PlayVoice(path)
        this.voiceBool = true
        if audioSource == nil then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("HeroArchivesViewModel_15"));
            return
        end
    end
    this.voiceIndex = index
    for i = 1, #this.vm.data.recordList do
        if i == index then
            this.vm.data.recordList[i].rBar = 0.0
        end
        this.vm.data.recordList[i].rTimeBar = i == index
    end
    if this.tweener ~= nil then
        this.tweener:Kill()
    end
    this.tweener = DOTWeen.To(function() return 0.0 end,
            function(o) this.vm.data.recordList[index].rBar = o
            end,1,audioSource.clip.length):SetEase(Ease.Linear)
    this.tweener.onComplete = function()
        this.voiceBool = false
        this.voiceIndex = 0
        this.vm.data.recordList[index].rBar = 0.0
        this.vm.data.recordList[index].rTimeBar = false
    end
end

this.SetBadgeStr = function()
    if this.msgIndex < NumTool.GetStringLength(this.masStr) then
        this.msgIndex = this.msgIndex + 1
        this.vm.data.badgeText = LuaMgr.SubstringLen(this.masStr,0,this.msgIndex)
        if this.msgIndex == NumTool.GetStringLength(this.masStr) then
            this.msgIndex = 0
            LuaMgr.RemoveTimer(TimerConst.TalentEffectTime)
        end
    end
end
return vm({
    data = data,
    command = command,
    hook = hook
})
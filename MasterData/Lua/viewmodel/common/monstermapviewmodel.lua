




local label = {
    basis = 1,
    ability = 2,
    archives = 3
}
local this = {vm = nil,labelType = nil,monsterMap = nil,monsterConfig = nil,contentRect = nil,
              MonsterPath = "Assets/_BundleResources/Character/",TableInsert = table.insert}
local data = {
    monsterName = "",videoBtn = Vector3.zero,
    monsterBody = DefaultTexture,
    boosType = Vector3.zero,boosText = "",
    normalType = Vector3.zero,normalText = "",
    ability = Vector3.zero,
    archives = Vector3.zero,
    basisView = false,
    basisText1 = "",basisText2 = "",basisText3 = "",basisText4 = "",basisText5 = "",
    basisText6 = "",basisText7 = "",basisText8 = "",basisText9 = "",basisText10 = "",
    abilityView = false,
    abilityText1 = "",
    archivesView = false,abilityWidth = Vector2.zero,
    archivesText1 = "",archivesText2 = "",
    scrollPos = 0.0,
    skillList = {{skillIcon = DefaultTexture,skillName = "",skillIntro = "",isBuff = false,buff = {}}},
    buffList = {{buffName = "",buffIntro = ""}}
}

local command = {
    backCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.Back()
        end
    },
    videoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.PlayVideoViewModel,this.monsterMap.MonsterPV)
        end
    },
    basisCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.labelType = label.basis
            this.SwitchLabelView()
        end
    },
    abilityCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.labelType = label.ability
            this.SwitchLabelView()
        end
    },
    archivesCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.labelType = label.archives
            this.SwitchLabelView()
        end
    },
    leftCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if #HeroParameter.terminalMapList == 1 then
               return 
            end
            if HeroParameter.terminalMapIndex - 1 < 1 then
                HeroParameter.terminalMapIndex = #HeroParameter.terminalMapList
            else
                HeroParameter.terminalMapIndex = HeroParameter.terminalMapIndex - 1
            end
            this.InitParameter()
        end
    },
    rightCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if #HeroParameter.terminalMapList == 1 then
                return
            end
            if HeroParameter.terminalMapIndex + 1 > #HeroParameter.terminalMapList then
                HeroParameter.terminalMapIndex = 1
            else
                HeroParameter.terminalMapIndex = HeroParameter.terminalMapIndex + 1
            end
            this.InitParameter()
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.contentRect = vm.behaviour.transform:Find("root/_Right/AbilityView/Viewport/Content/SkillContent"):GetComponent("RectTransform")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
}

this.InitParameter = function()
    local monsterId = HeroParameter.terminalMapList[HeroParameter.terminalMapIndex]
    this.monsterMap = ConfigMgr.Config.MonsterFileMap[monsterId]
    this.monsterConfig = ConfigMgr.Config.monsterMap[this.monsterMap.MonsterSkin]
    this.InitMonster()
    this.labelType = label.basis
    this.SwitchLabelView()
end

this.InitMonster = function()
    this.vm.data.monsterName = LuaMgr.GetLangText(this.monsterConfig.NameLan)
    local texture = LuaMgr.GetTexture(this.MonsterPath..this.monsterConfig.monsterModel.."/Drawing/"..this.monsterConfig.monsterSkin..".png")
    if texture == nil then
        texture = LuaMgr.GetTexture(this.MonsterPath..this.monsterConfig.monsterModel.."/Drawing/"..this.monsterConfig.monsterModel.."01"..".png")
    end
    this.vm.data.monsterBody = texture
    if this.monsterMap.Type == 4 then
        this.vm.data.boosText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2199"].NameLan)
    else
        if this.monsterMap.Type == 0 then this.vm.data.normalText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2202"].NameLan) end
        if this.monsterMap.Type == 1 then this.vm.data.normalText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2201"].NameLan) end
        if this.monsterMap.Type == 2 then this.vm.data.normalText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2200"].NameLan) end
        if this.monsterMap.Type == 3 then this.vm.data.normalText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2203"].NameLan) end
    end
    this.vm.data.boosType = this.monsterMap.Type == 4 and Vector3.one or Vector3.zero
    this.vm.data.normalType = this.monsterMap.Type == 4 and Vector3.zero or Vector3.one

    this.vm.data.videoBtn = this.monsterMap.MonsterPV == "" and Vector3.zero or Vector3.one
    this.vm.data.ability = this.monsterMap.SkillType == 0 and Vector3.zero or Vector3.one
    this.vm.data.archives = this.monsterMap.FileTest == "" and Vector3.zero or Vector3.one
end

this.SwitchLabelView = function()

    if this.labelType == label.basis then
        this.InitBasis()
    elseif this.labelType == label.ability then
        this.InitAbility()
    elseif this.labelType == label.archives then
        this.InitArchives()
    end

    this.vm.data.scrollPos = 1.0
    this.vm.data.basisView = this.labelType == label.basis
    this.vm.data.abilityView = this.labelType == label.ability
    this.vm.data.archivesView = this.labelType == label.archives
end

this.InitBasis = function()
    this.vm.data.basisText1 = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2336"].NameLan)
    this.vm.data.basisText2 = LuaMgr.GetLangText(this.monsterMap.PackEntry01Lan)
    this.vm.data.basisText3 = LuaMgr.GetLangText(this.monsterMap.PackEntry02Lan)
    this.vm.data.basisText4 = LuaMgr.GetLangText(this.monsterMap.PackEntry03Lan)
    this.vm.data.basisText5 = LuaMgr.GetLangText(this.monsterMap.PackSPLan)
    this.vm.data.basisText6 = LuaMgr.GetLangText(this.monsterMap.Peculiarity01Lan)
    this.vm.data.basisText7 = LuaMgr.GetLangText(this.monsterMap.Peculiarity02Lan)
    this.vm.data.basisText8 = LuaMgr.GetLangText(this.monsterMap.Peculiarity03Lan)
    this.vm.data.basisText9 = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2337"].NameLan)
    this.vm.data.basisText10 = LuaMgr.GetLangText(this.monsterMap.MonsterDesLan)
end

this.InitAbility = function()
    this.vm.data.abilityText1 = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2338"].NameLan)

    local skillDes = LuaMgr.GetMonsterSkillDes(this.monsterMap.MonsterSkin)
    if skillDes.Count <= 0 then return end
    local skillTab,skillItem = {},{}
    local buffTexts = nil
    local length = 0
    for i = 1, skillDes.Count do
        skillItem = {skillIcon = LuaMgr.GetTexture(LuaMgr.GetSkillIcon(skillDes[i - 1][0])),
                    skillName = skillDes[i - 1][2],skillIntro = skillDes[i - 1][3],isBuff = false,buff = {}}
        skillItem.isBuff = skillDes[i - 1][4] ~= ""
        if skillItem.isBuff then
            buffTexts = this.GetSkillBuffList(skillDes[i - 1][4])
            length = #buffTexts - 1
            if buffTexts ~= nil and buffTexts ~= "" then
                local buffTab,buffItem = {},{}
                for j = 1, length, 2 do
                    buffItem = {buffName = buffTexts[j],buffIntro = buffTexts[j + 1]}
                    this.TableInsert(buffTab,buffItem)
                end
                skillItem.buff = buffTab
            end
        end
        this.TableInsert(skillTab,skillItem)
    end
    this.vm.data.skillList = skillTab
    skillTab,skillItem = nil,nil
    buffTab,buffItem = nil,nil
    LuaMgr.NextFrame(function() this.CalculateHeight() end,4)
end

this.InitArchives = function()
    this.vm.data.archivesText1 = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2339"].NameLan)
    this.vm.data.archivesText2 = LuaMgr.GetLangText(this.monsterMap.FileTestLan)
end

this.GetSkillBuffList = function(buffStr)
    local tempStr = NumTool.split(buffStr,"|")
    return tempStr
end


this.CalculateHeight = function()
    local length = #this.vm.data.skillList
    local totalHeight,tempHeight = 0,0
    local skillItemObj,skillTextObj,skillHeight = nil,nil,nil
    local buffObj,buffListObj,buffItemObj,buffTextObj = nil,nil,nil,nil
    for i = 1, length do
        tempHeight = 0
        skillItemObj = this.contentRect:GetChild(i - 1)
        skillTextObj = skillItemObj:Find("Text")
        buffObj = skillItemObj:Find("Buff")
        buffListObj = buffObj:Find("ViewList")

        if #this.vm.data.skillList[i].buff > 0 then
            for j = 1, #this.vm.data.skillList[i].buff do
                buffItemObj = buffListObj:GetChild(j - 1)
                buffTextObj = buffItemObj:Find("Text")
                tempHeight = tempHeight + 28 + buffTextObj.sizeDelta.y
                buffItemObj.sizeDelta = Vector2(buffItemObj.sizeDelta.x,28 + buffTextObj.sizeDelta.y)
            end
        else
            tempHeight = 0
        end
        
        tempHeight = tempHeight + ((#this.vm.data.skillList[i].buff - 1) * 10)
        buffObj.sizeDelta = Vector2(buffObj.sizeDelta.x,tempHeight)
        buffListObj.sizeDelta = Vector2(buffListObj.sizeDelta.x,tempHeight)
        if #this.vm.data.skillList[i].buff > 0 then
            buffListObj:GetComponent("VerticalLayoutGroup"):SetLayoutVertical()
        end

        if skillTextObj.sizeDelta.y < 64 then
            skillHeight = 112 + tempHeight
        else
            skillHeight = 112 + skillTextObj.sizeDelta.y - 50 + tempHeight
        end
        skillItemObj.sizeDelta = Vector2(skillItemObj.sizeDelta.x,skillHeight)
        totalHeight = totalHeight + skillHeight
    end
    totalHeight = totalHeight + ((length - 1) * 12) + 62
    this.vm.data.abilityWidth = Vector2(489,totalHeight)
    totalHeight,tempHeight = nil,nil
    skillItemObj,skillTextObj,skillHeight = nil,nil,nil
    buffObj,buffListObj,buffItemObj,buffTextObj = nil,nil,nil,nil
end
return vm({
    data = data,
    command = command,
    hook = hook
})
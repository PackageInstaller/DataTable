




local this = {
    vm = nil,
    characterId = nil,
    characterRare = nil,
    characterData = nil,
    curIndex = nil,
    canSelectAttr = nil,
    sceneWidth = nil,
    canTalentBool = nil,
    bgScrollViewPos = 0,
    coroutine_key = nil,
    itemClick = nil,
    doTween = nil,
    strFormat = string.format,
    tableInsert = table.insert,
    scrollPos = 0,
talentItems = nil,
lineItems = nil,
skillBefore = nil,
skillAfter = nil,
conditions = nil,
goodsMaterial = nil,
levelPointPos = nil,
attrSkillPointPos = nil,
    lockColor = "<color=#9A9A9A>%s</color>",
    unLockColor = "<color=#FFFFFF>%s</color>",
    countColor = "<color=#FF0000>%d</color>",
    itemIconPath = "Assets/_BundleResources/Images/ItemIcons/itemicon_home_",
    isAssisHero = false,
    comPoundList = {},
}
local uiRoot = {}

local data = {
    hideTalentItem = false,
}

local command = {
    viewportCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.CloseTalentDetails()
        end
    },
    itemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not this.itemClick then return end
            local index = tonumber(param) + 1
            this.OpenTalentDetails(index)
            this.SelectItemPlayAnim(index)
        end
    },
    skillCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local skillId, skillLevel = nil, nil
            if param == "1" then
                skillId, skillLevel = this.skillBefore.skillId, this.skillBefore.intLevel
            else
                skillId, skillLevel = this.skillAfter.skillId, this.skillAfter.intLevel
            end
            LuaMgr.ShowPanel(UIName.SkillTipsViewModel, SkillType.Character, this.characterId, skillId, nil,
                SkillShowType.Battle, skillLevel ~= 0, skillLevel)
        end
    },
    canExamineCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.canTalentBool then
                this.SendTalent()
            end
        end
    },
    canCompoundCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local interaction = ConfigFoundationMgr.GetInteractionById("201")
            if (interaction == nil) then
                interaction = PlayerFoundationMgr.GetBuildingConfigByGroup("201")
            end
            local existParticurMat = false
            local needMatTb = {}
            if interaction ~= nil then
                local formulaMap = ConfigMgr.Config.FormulaMap
                for i, v in ipairs(this.comPoundList) do
                    local yieldsItem = interaction.YieldsItem
                    local hasCount = DataHelper.GetItemCountById(v.id)
                    local needCount = v.count - hasCount
                    if (needCount > 0) then
                        for key, value in pairs(formulaMap) do
                            if (value.RecipeGroup == yieldsItem and value.Produce[1].id == v.id and value.Unlock) then
                                table.insert(needMatTb, value)
                                if value.CostRequire and value.CostRequire > 0 then
                                    existParticurMat = true
                                end
                            end
                        end
                    end
                end
            end
            if existParticurMat == true and #needMatTb == 1 then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29673"));
            else
                LuaMgr.ShowLuaPanel(UIName.TalentCompoundViewModel, this.comPoundList);
            end
        end
    },
    noExamineCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2101"].NameLan)
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
        end
    },
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.CloseTalentDetails()

        end
    },
    detailsCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.CloseTalentDetails()

        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.InitGetView()
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.ScreenSize()
        this.InitParameter()
        this.SetJobSprite()
        this.AddUIEveneListener()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.ClosePanel()
    end,
    before_destroy = function(vm)
        this.DeletePanel()
    end,
}
this.ScreenSize = function()
    this.sceneWidth = LuaMgr.ScreenWidth() - LuaMgr.GetScreenAddWidth()
    uiRoot.scrollView.horizontalNormalizedPosition = 0

    uiRoot.ui_kh_xz01:SetActive(false)
    uiRoot.ui_kh_xz02:SetActive(false)
    uiRoot.ui_kh_xz03:SetActive(false)
    uiRoot.alreadyEffect:SetActive(false)
end

this.AddUIEveneListener = function()
    LuaMgr.AddUIEventListener(UIEventConst.UpdateActivateSkin, this.UpdataPanel)

    uiRoot.scrollView.onValueChanged:AddListener(this.HeroJobBgMove)
    LuaMgr.AddUIEventListener(UIEventConst.PropUse, this.UpdateMaterial)
end

this.RemoveUIEventListener = function()
    LuaMgr.RemoveUIEventListener(UIEventConst.UpdateActivateSkin, this.UpdataPanel)

    uiRoot.scrollView.onValueChanged:RemoveListener(this.HeroJobBgMove)
    LuaMgr.RemoveUIEventListener(UIEventConst.PropUse, this.UpdateMaterial)
end


this.InitParameter = function()
    if this.vm.behaviour.Params.Length == 0 then return end
    this.levelPointPos = {}
    this.attrSkillPointPos = {}
    this.curIndex = -1
    this.itemClick = true
    this.goodsMaterial = {}
    uiRoot.contentSizeDelta.sizeDelta = Vector2(3242,641)
    this.characterId = this.vm.behaviour.Params[0]
    this.isAssisHero = PlayerAssistMgr.IsCurAssistCharacter(this.characterId)
    if this.isAssisHero then
        this.vm.behaviour:UpdateTopBar("assist", function()
            LuaMgr.Back();
        end);
    end

    if not IsNullOrEmpty(this.characterId) and ConfigMgr.Config.characterTable[this.characterId] ~= nil then
        this.characterRare = ConfigMgr.Config.characterTable[this.characterId].rare
        if this.isAssisHero then
            this.characterData = PlayerAssistMgr.GetCurAssist_CharacterData();
        else
            this.characterData = DataMgr.Player.characters[this.characterId]
        end
    else
        this.characterRare = 2
        this.characterData = DataMgr.Player.characters["V0064"]
    end
    this.InitTalentItem()
    this.InitPositioning()
    this.InitTalentLine()
end


this.InitPositioning = function()

    if #this.levelPointPos > 0 then
        table.sort(this.levelPointPos)
        for i = 1, #this.talentItems do
            if this.talentItems[i].talentId == this.levelPointPos[1] then
                if i > 10 then
                    this.curIndex = i
                    this.MovePosition()
                    this.curIndex = -1
                end
                return
            end
        end
    end

    if #this.attrSkillPointPos > 0 then
        table.sort(this.attrSkillPointPos)
        for i = 1, #this.talentItems do
            if this.talentItems[i].talentId == this.attrSkillPointPos[1] then
                if i > 10 then
                    this.curIndex = i
                    this.MovePosition()
                    this.curIndex = -1
                end
                return
            end
        end
    end
    uiRoot.scrollView.horizontalNormalizedPosition = 1
    return
end

this.SetJobSprite = function()

    if IsNullOrEmpty(this.characterId) then
        return
    end
    if ConfigMgr.Config.characterTable[this.characterId] ~= nil then
        local job = ConfigMgr.Config.characterTable[this.characterId].job
        if job == nil or job <= 0 then
            job = 1
        end
        uiRoot.jobIcon.sprite = LuaMgr.GetSprite("TalentJobIcon", "job_" .. job)
    end
end


this.InitTalentItem = function()
    local talentConfig, talentBack, index = nil, nil, 0
    local iconSprite = nil
    for i, v in pairs(this.characterData.talents) do
        talentConfig = ConfigMgr.Config.characterTalentMap[i]
        if talentConfig == nil then return end
        index = talentConfig.index + 1





        this.talentItems[index].select:SetActive(index == this.curIndex)
        talentBack = ConfigMgr.Config.talentBankMap[talentConfig.talentBankId]
        if (talentBack.type == 0 or talentBack.type == 3) and v.status ~= 2 then
            this.tableInsert(this.levelPointPos, i)
        end
        if (talentBack.type == 1 or talentBack.type == 2) and v.status ~= 2 then
            this.tableInsert(this.attrSkillPointPos, i)
        end
        iconSprite = LuaMgr.GetSprite("TalentIcon", talentBack.icon)
        this.talentItems[index].lock:SetActive(not (v.status == 2))
        this.talentItems[index].lockScale:SetActive(not (v.status == 1))


































        this.talentItems[index].icon.sprite, this.talentItems[index].lockImg.sprite = iconSprite, iconSprite
        this.talentItems[index].icon:SetNativeSize()
        this.talentItems[index].lockImg:SetNativeSize()
        this.talentItems[index].unlock:SetActive(v.status == 1)
        this.talentItems[index].talentId = v.id
        local red = false
        if v.status == 1 then red = PlayerCharacterMgr.TalentRedState(i, this.characterId) end
        this.talentItems[index].redPoint:SetActive(red)
        ::continue::
    end

end


this.InitTalentLine = function()
    local talentConfig, key = nil, nil
    for i, v in pairs(this.characterData.talents) do
        talentConfig = ConfigMgr.Config.characterTalentMap[i]
        if talentConfig == nil then return end
        key = "Line" .. talentConfig.index
        if this.lineItems[key] == nil then goto continue end
        this.lineItems[key].light:SetActive(v.status == 2)
        ::continue::
    end
end

this.OpenTalentDetails = function(index)
    if index == this.curIndex then return end
    if this.curIndex ~= -1 then
        this.talentItems[this.curIndex].select:SetActive(false)
    end
    this.curIndex = index
    this.canSelectAttr = true
    this.canTalentBool = true
    local talentId = this.talentItems[this.curIndex].talentId
    local config = ConfigMgr.Config.characterTalentMap[talentId]
    local talentBack = ConfigMgr.Config.talentBankMap[config.talentBankId]
    local boxSprite = LuaMgr.GetSprite("TalentIcon", talentBack.pitch)
    this.talentItems[this.curIndex].selectImg.sprite = boxSprite
    this.talentItems[this.curIndex].selectImg:SetNativeSize()
    this.talentItems[this.curIndex].select:SetActive(true)

    if (config.talentType == 2 and this.characterData.talents[talentId].status ~= 2) or config.talentType == 3 then
if config.talentType == 2 and this.characterData.talents[talentId].status ~= 2 then
            LuaMgr.ShowLuaPanel(UIName.TalentUnlockViewModel, this.characterId, config.id, true)
elseif config.talentType == 3 then
            this.GotoHuanZhangPanel(config, this.characterData.talents[talentId])
        end
        this.CloseTalentDetails()
        return
    end

    if RectTransformTool.CheckUIWhetherOverlap(uiRoot.detailsMask, this.talentItems[this.curIndex].rectRoot) then
        this.MovePosition()
    end
    this.UpdateTalentDetails(talentId, config, talentBack)
end


this.SelectItemPlayAnim = function(index)
    if this.doTween ~= nil then this.doTween:Kill() end
    this.doTween = DOTWeen.To(
        function() return Vector3(1.2, 1.2, 1.2) end,
        function(vector)
            this.talentItems[index].rectRoot.localScale = vector
        end, Vector3.one, 0.15):SetEase(Ease.Linear)
end

this.CloseTalentDetails = function()
    if this.curIndex == -1 then return end
    this.talentItems[this.curIndex].select:SetActive(false)
    this.curIndex = -1

    SetActive(uiRoot.talentDetails, false)
end


this.UpdateTalentDetails = function(talentId, config, talentBack)

    local talentData = this.characterData.talents[talentId]
    if talentData == nil then return end

    uiRoot.talentName.text = LuaMgr.GetLangText(config.namelan)
    if talentBack.type == 1 then
        this.SetTalentSkill(talentBack)
    else
        this.SetTalentIntro(config, talentBack)
    end
    this.SetUnlockCondition(config)
    if talentData.status == 2 then







        SetActive(uiRoot.completeGoodsView.transform.gameObject, false)
        SetActive(uiRoot.canCompoundBtn, false)
    else
        this.SetMaterial(config)

    end
    SetActive(uiRoot.already, talentData.status == 2)
    this.SetButtonState(config, talentData)
    SetActive(uiRoot.talentDetails, true)
end

this.SetTalentIntro = function(config, talentBack)
    uiRoot.skillContent.localScale = Vector3.zero
    local introStr = LuaMgr.GetLangText(talentBack.DescriptionLan)



    uiRoot.talentIntro.text = introStr
end

this.SetTalentSkill = function(talentBack)
    uiRoot.talentIntro.text = ""
    if talentBack == nil or talentBack.talentParam1 == "" then return end
    local skillData = this.characterData.skills[talentBack.talentParam1]
    local skillConfigId = ConfigMgr.Config.characterTable[this.characterId][talentBack.talentParam1][1]
    local skillConfig = nil
    if skillData.type == 0 then
        skillConfig = ConfigSkillMgr.GetCharacterSkill(skillConfigId .. skillData.level)
    elseif skillData.type == 1 then
        skillConfig = ConfigSkillMgr.GetCharacterPassiveSkill(skillConfigId .. skillData.level)
    end
    if skillConfig == nil then return end
    local skillIcon = LuaMgr.GetTexture(LuaMgr.GetSkillIcon(skillConfigId))
    local skillType = LuaMgr.GetSprite("HeroRes", "skillType_" .. skillConfig.Type)
    this.skillBefore.intLevel = talentBack.talentParam2 > 1 and talentBack.talentParam2 - 1 or talentBack.talentParam2
    this.skillBefore.skillId = skillConfigId
    this.skillBefore.icon.texture, this.skillBefore.type.sprite = skillIcon, skillType
    this.skillBefore.levelText.text = talentBack.talentParam2 - 1
    this.skillBefore.level.localScale = talentBack.talentParam2 - 1 == 0 and Vector3.zero or Vector3.one
    this.skillBefore.lock.localScale = talentBack.talentParam2 - 1 == 0 and Vector3.one or Vector3.zero

    this.skillAfter.intLevel = talentBack.talentParam2
    this.skillAfter.skillId = skillConfigId
    this.skillAfter.icon.texture, this.skillAfter.type.sprite = skillIcon, skillType
    this.skillAfter.levelText.text = talentBack.talentParam2
    this.skillAfter.level.localScale = Vector3.one
    this.skillAfter.lock.localScale = Vector3.zero

    uiRoot.skillContent.localScale = Vector3.one
end

this.SetUnlockCondition = function(config)
    local index = 1
    local str = ""
if config.requireLevel ~= 0 then
        str = this.strFormat(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2355"].NameLan), config.requireLevel)
        str = config.requireLevel > this.characterData.level and this.strFormat(this.lockColor, str) or
            this.strFormat(this.unLockColor, str)
        this.conditions[index].text.text = str
        this.conditions[index].lock.localScale = config.requireLevel > this.characterData.level and Vector3.one or
            Vector3.zero
        this.conditions[index].unLock.localScale = config.requireLevel <= this.characterData.level and Vector3.one or
            Vector3.zero
        index = index + 1
        if config.requireLevel > this.characterData.level then
            this.canTalentBool = false
        end
    end
if config.requireStar ~= 0 then
        str = this.strFormat(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2356"].NameLan), config.requireStar)
        str = config.requireStar > this.characterData.star and this.strFormat(this.lockColor, str) or
            this.strFormat(this.unLockColor, str)
        this.conditions[index].text.text = str
        this.conditions[index].lock.localScale = config.requireLevel > this.characterData.star and Vector3.one or
            Vector3.zero
        this.conditions[index].unLock.localScale = config.requireLevel <= this.characterData.star and Vector3.one or
            Vector3.zero
        index = index + 1
        if config.requireStar > this.characterData.star then
            this.canTalentBool = false
        end
    end
    local id, name = "", ""
for i = 1, #config.requireTalent do
        id = config.requireTalent[i]
        name = LuaMgr.GetLangText(ConfigMgr.Config.characterTalentMap[id].namelan)
        str = this.strFormat(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2357"].NameLan), name)
        str = this.characterData.talents[id].status == 2 and this.strFormat(this.unLockColor, str) or
            this.strFormat(this.lockColor, str)
        this.conditions[index].text.text = str
        this.conditions[index].lock.localScale = this.characterData.talents[id].status == 2 and Vector3.zero or
            Vector3.one
        this.conditions[index].unLock.localScale = this.characterData.talents[id].status == 2 and Vector3.one or
            Vector3.zero
        index = index + 1
        if this.characterData.talents[id].status ~= 2 then
            this.canTalentBool = false
        end
    end
    if index ~= 1 then
        for i = 1, #this.conditions do
            this.conditions[i].active:SetActive(i < index)
        end
    end
    uiRoot.conditionNull.localScale = index == 1 and Vector3.one or Vector3.zero
    uiRoot.conditionView.localScale = index == 1 and Vector3.zero or Vector3.one
end

this.SetMaterial = function(config)

    this.comPoundList = {}
    local length = ConfigHelper.GetTableLength(config.requireItems)
    local material = nil
    local cantCompound = true
    local interaction = nil
    local formulaMap = ConfigMgr.Config.FormulaMap
    for i = 1, length do
        if this.goodsMaterial[i] == nil then
            material = MaterialItem.New(uiRoot.goodsView)
            this.tableInsert(this.goodsMaterial, material)
        end
        local requireItem = config.requireItems[i]
        if cantCompound and DataHelper.GetItemCountById(requireItem.id) < requireItem.count then
            cantCompound = false
        end
        this.goodsMaterial[i]:SetData(i, requireItem.id, requireItem.count, 0.65)
        local itemConfig = ConfigMgr.Config.itemMap[requireItem.id]
        local needComPound = false
        if (this.canTalentBool and itemConfig ~= nil and itemConfig.Source4[1] ~= nil) then
            for k, v in pairs(itemConfig.Source4) do
                if (v == "1320") then
                    needComPound = true
                    break
                end
            end
        end
        if (needComPound) then
            if (interaction == nil) then
                interaction = ConfigFoundationMgr.GetInteractionById("201")
                if (interaction == nil) then
                    interaction = PlayerFoundationMgr.GetBuildingConfigByGroup("201")
                end
            end
            local haveCount = DataHelper.GetItemCountById(itemConfig.id)
            if (haveCount < requireItem.count and interaction ~= nil) then
                local yieldsItem = interaction.YieldsItem
                for key, value in pairs(formulaMap) do
                    if (value.RecipeGroup == yieldsItem and value.Produce[1].id == requireItem.id and value.Unlock) then
                        table.insert(this.comPoundList, requireItem)
                    end
                end
            end
        end
    end
    if length < #this.goodsMaterial then
        for i = length + 1, #this.goodsMaterial do
            this.goodsMaterial[i]:Hide()
        end
    end
    if (not cantCompound) then
        this.canTalentBool = false
    end
    SetActive(uiRoot.completeGoodsView.transform.gameObject, not this.isAssisHero)
    SetActive(uiRoot.canCompoundBtn, #this.comPoundList > 0)
end
this.UpdateMaterial = function(args)
    local tempIndex = this.curIndex
    this.curIndex = -1
    this.InitTalentItem()
    this.OpenTalentDetails(tempIndex)
end


this.SetButtonState = function(config, talentData)
    local requireState = type(config.requireCoin) == "function" or next(config.requireCoin) == nil
    if not requireState and talentData.status ~= 2 then
        local id, count = config.requireCoin[1].id, config.requireCoin[1].count
        if DataHelper.GetItemCountById(id) < count then
            count = this.strFormat(this.countColor, count)
            this.canTalentBool = false
        end
        uiRoot.consumeText.text = count
        uiRoot.consumeIcon.texture = LuaMgr.GetTexture(this.itemIconPath .. id .. ".png")
    end
    SetActive(uiRoot.consume, not this.isAssisHero and requireState == false and talentData.status ~= 2)

    uiRoot.canExamineBtn:SetActive(not this.isAssisHero and talentData.status ~= 2 and this.canTalentBool)
    uiRoot.noExamineBtn:SetActive(not this.isAssisHero and talentData.status ~= 2 and not this.canTalentBool)
end

this.SendTalent = function()
    this.itemClick = false
    local tempData = {}
    tempData["TalentID"] = this.talentItems[this.curIndex].talentId
    ApiMgr.Request("activate_talent", tempData, true, function(result)
        local re = json.decode(result)
        if re.code == 0 then
            this.PlayEffect()
        end
    end, nil, true)
end

this.PlayEffect = function()
    if this.coroutine_key ~= nil then
        coroutine_runner.stop(this.coroutine_key)
    end
    local talentId = this.talentItems[this.curIndex].talentId
    local tempConfig = ConfigMgr.Config.characterTalentMap[talentId]
    local talentBack = ConfigMgr.Config.talentBankMap[tempConfig.talentBankId]
    if tempConfig == nil or tempConfig.talentType ~= 1 then return end
    if talentBack.pitch == nil then return end

    SetActive(uiRoot.consume, false)
    SetActive(uiRoot.completeGoodsView.transform.gameObject, false)
    uiRoot.canExamineBtn:SetActive(false)

    uiRoot[talentBack.pitch].transform:SetParent(this.talentItems[this.curIndex].effectRoot)
    uiRoot[talentBack.pitch].transform.localPosition = Vector3.zero
    uiRoot[talentBack.pitch]:SetActive(true)
    uiRoot.alreadyEffect:SetActive(true)
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/Talent_up.mp3");
    this.coroutine_key = coroutine_runner.start(function()
        coroutine_runner.wait(1)
        SetActive(uiRoot.already, true)
        coroutine_runner.wait(0.4)
        this.UpdataPanel()
        this.itemClick = true
        uiRoot[talentBack.pitch]:SetActive(false)
        uiRoot.alreadyEffect:SetActive(false)



    end)
end

this.UpdataPanel = function(args)
    local tempIndex = this.curIndex
    this.curIndex = -1
    this.characterRare = ConfigMgr.Config.characterTable[this.characterId].rare
    this.characterData = DataMgr.Player.characters[this.characterId]
    this.InitTalentItem()
    this.InitTalentLine()
    this.OpenTalentDetails(tempIndex)
end








this.MovePosition = function()
    local viewport = uiRoot.scrollView.viewport
    local content = uiRoot.scrollView.content
    local target = this.talentItems[this.curIndex].rectRoot

    local targetWorldPos = target:TransformPoint(Vector3(target.rect.center.x,target.rect.center.y,0))
    local viewportWorldCenter = viewport:TransformPoint(Vector3(viewport.rect.center.x,viewport.rect.center.y,0))

    local offset = viewportWorldCenter - targetWorldPos
    local contentTargetPos = content.position + offset
    
    local startPos = uiRoot.scrollView.content.position
    local posX = contentTargetPos.x < -36.11 and -36.11 or contentTargetPos.x
    local entPos = Vector3(posX,uiRoot.scrollView.content.position.y,uiRoot.scrollView.content.position.z)
    DOTWeen.To(function() return startPos end,
            function(pos)
                uiRoot.scrollView.content.position = pos
            end,entPos,0.25):SetEase(Ease.Linear)
end


this.HeroJobBgMove = function()
    this.scrollPos = uiRoot.scrollView.horizontalNormalizedPosition
    if this.scrollPos > 1 then this.scrollPos = 1 end
    if this.scrollPos < 0 then this.scrollPos = 0 end
    this.bgScrollViewPos = 1 - (1 - this.scrollPos)
    if this.bgScrollViewPos > 1 then this.bgScrollViewPos = 1 end
    if this.bgScrollViewPos < 0 then this.bgScrollViewPos = 0 end
    uiRoot.bgScrollView.horizontalNormalizedPosition = this.bgScrollViewPos
end

this.GotoHuanZhangPanel = function(cTalent, dTalent)
    if this.isAssisHero then
        return
    end
    local rare = HeroMgr.GetHeroNowRare(this.characterId)
    if rare > 4 then rare = 4 end
    local brilliantKey = this.characterId .. rare
    local brilliant = ConfigMgr.Config.BrilliantMap[brilliantKey]
    local tipStr = ""
    if TableIsNull(brilliant) or TableIsNull(cTalent) or TableIsNull(dTalent) then
        tipStr = ConfigMgr.LangGlobal("2103")
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
        return
    else
        local tip = ""
        if dTalent.status == 0 then
            tip = LuaMgr.GetLangText(ConfigMgr.Config.characterTalentMap[cTalent.requireTalent[1]].namelan)
            tipStr = this.strFormat(ConfigMgr.LangGlobal("2086"), tip)
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
            return
        else
            local curTime = LuaMgr.Timestamp()
            local unlockTime = brilliant.UnlockDate
            if curTime < unlockTime then
                tip = os.date("%Y/%m/%d %H:%M", unlockTime)
                tipStr = this.strFormat(ConfigMgr.LangGlobal("2390"), tip)
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
                return
            end
        end
    end
    LuaMgr.ShowLuaPanel(UIName.HeroHuanZhangViewModel, this.characterId)
end

this.GetHeroRare = function(character)
    local rare = 0
    local tempConfig = ConfigCharacterMgr.GetInfo(character.id)
    if not TableIsNull(tempConfig) then
        rare = tempConfig.rare
        if not TableIsNull(character) and type(character.brilliant) ~= "function" and not TableIsNull(character.brilliant) then
            rare = rare + character.brilliant.RareLevel
        end
    end
    return rare
end

this.GetTalentNode = function(transform)

    local talent = {
        select = { path = "Icon/Selected", type = "GameObject" },
        selectImg = { path = "Icon/Selected", type = "Image" },
        icon = { path = "Icon", type = "Image" },
        lock = { path = "Icon/Lock", type = "GameObject" },
        lockImg = { path = "Icon/Lock", type = "Image" },
        lockScale = { path = "Icon/Lock/Image", type = "GameObject" },
        unlock = { path = "Icon/Unlock", type = "GameObject" },
        redPoint = { path = "Icon/RedPoint", type = "GameObject" },
        effectRoot = { path = "Effect", type = "RectTransform" },
    }

    this.talentItems = {}
    local object, item = nil, {}
    for i = 1, transform.childCount do
        object = transform:Find("Item" .. i - 1)
        item = {}
        UITool.Parse(object, item, talent)
        if this.talentItems[i] == nil then
            item.rectRoot = object
            this.tableInsert(this.talentItems, i, item)
        end
    end
    talent = nil
end

this.GetLineNode = function(transform)

    local line = { light = { path = "Light", type = "GameObject" } }

    this.lineItems = {}
    local object, item = nil, {}
    for i = 1, transform.childCount do
        object = transform:GetChild(i - 1)
        item = {}
        UITool.Parse(object, item, line)
        if this.lineItems[object.name] == nil then
            this.lineItems[object.name] = item
        end
    end
    line = nil
end

this.GetSkillNode = function(trans1, trans2)

    local skill = {
        icon = { path = "Icon", type = "RawImage" },
        level = { path = "Level", type = "RectTransform" },
        levelText = { path = "Level/Text", type = "Text" },
        type = { path = "Type", type = "Image" },
        lock = { path = "Lock", type = "RectTransform" },
    }

    this.skillBefore, this.skillAfter = {}, {}
    UITool.Parse(trans1.gameObject, this.skillBefore, skill)
    UITool.Parse(trans2.gameObject, this.skillAfter, skill)
    skill = nil
end

this.GetConditionNode = function(transform)

    local condition = {
        lock = { path = "Lock", type = "RectTransform" },
        unLock = { path = "UnLock", type = "RectTransform" },
        text = { path = "Text", type = "Text" },
    }

    this.conditions = {}
    local object, objectName = nil, ""
    local item = {}
    for i = 1, transform.childCount do
        objectName = "ConditionItem" .. i - 1
        object = transform:Find(objectName).gameObject
        item = {}
        UITool.Parse(object, item, condition)
        if this.conditions[i] == nil then
            item.active = object
            this.tableInsert(this.conditions, i, item)
        end
    end
    condition = nil
end


this.InitGetView = function()
    local panelNode = {
        talentName = { path = "root/_Middle/TalentDetails/NmaeText", type = "Text" },
        talentIntro = { path = "root/_Middle/TalentDetails/TalentIntro", type = "Text" },
        talentDetails = { path = "root/_Middle/TalentDetails", type = "GameObject" },
        contentSizeDelta = {path = "root/_Middle/Canvas/ScrollView/Viewport/Content",type = "RectTransform"},
        skillContent = { path = "root/_Middle/TalentDetails/SkillContent", type = "RectTransform" },
        conditionNull = { path = "root/_Middle/TalentDetails/Condition/Null", type = "RectTransform" },
        conditionView = { path = "root/_Middle/TalentDetails/Condition/View", type = "RectTransform" },
        goodsView = { path = "root/_Middle/TalentDetails/CompleteGoods/Goods", type = "RectTransform" },



        completeGoodsView = { path = "root/_Middle/TalentDetails/CompleteGoods", type = "RectTransform" },
        already = { path = "root/_Middle/TalentDetails/Already", type = "GameObject" },
        consume = { path = "root/_Middle/TalentDetails/Consume", type = "GameObject" },
        consumeText = { path = "root/_Middle/TalentDetails/Consume/Value", type = "Text" },
        consumeIcon = { path = "root/_Middle/TalentDetails/Consume/Value/Icon", type = "RawImage" },

        canExamineBtn = { path = "root/_Middle/TalentDetails/CanExamineBtn", type = "GameObject" },
        noExamineBtn = { path = "root/_Middle/TalentDetails/NoExamineBtn", type = "GameObject" },
        canCompoundBtn = { path = "root/_Middle/TalentDetails/CanCompoundBtn", type = "GameObject" },
        detailsMask = { path = "root/_Middle/Mask", type = "RectTransform" },
        scrollView = { path = "root/_Middle/Canvas/ScrollView", type = "ScrollRect" },
        bgScrollView = { path = "root/BgScrollView", type = "ScrollRect" },
        jobIcon = { path = "root/BgScrollView/Content/Job", type = "Image" },



        alreadyEffect = { path = "root/_Middle/TalentDetails/UI_HeroTalentPanel_Already_01", type = "GameObject" },
        ui_kh_xz01 = { path = "root/_Middle/Canvas/ScrollView/Viewport/Content/UI_kh_xz_01", type = "GameObject" },
        ui_kh_xz02 = { path = "root/_Middle/Canvas/ScrollView/Viewport/Content/UI_kh_xz_03", type = "GameObject" },
        ui_kh_xz03 = { path = "root/_Middle/Canvas/ScrollView/Viewport/Content/UI_kh_xz_04", type = "GameObject" },
    }
    UITool.Parse(this.vm.behaviour.transform, uiRoot, panelNode)
    panelNode = nil

    local lineLayer = this.vm.behaviour.transform:Find("root/_Middle/Canvas/ScrollView/Viewport/Content/LineLayerLight")
        :GetComponent("Transform")
    local itemLayer = this.vm.behaviour.transform:Find("root/_Middle/Canvas/ScrollView/Viewport/Content/ItemLayer")
        :GetComponent("Transform")
    if itemLayer ~= nil then this.GetTalentNode(itemLayer) end
    if lineLayer ~= nil then this.GetLineNode(lineLayer) end
    local trans1 = this.vm.behaviour.transform:Find("root/_Middle/TalentDetails/SkillContent/Skill1"):GetComponent(
        "Transform")
    local trans2 = this.vm.behaviour.transform:Find("root/_Middle/TalentDetails/SkillContent/Skill2"):GetComponent(
        "Transform")
    if trans1 ~= nil and trans2 ~= nil then
        this.GetSkillNode(trans1, trans2)
    end
    local conditionTrans = this.vm.behaviour.transform:Find("root/_Middle/TalentDetails/Condition/View"):GetComponent(
        "Transform")
    if conditionTrans ~= nil then
        this.GetConditionNode(conditionTrans)
    end
end

this.DeletePanel = function()
    this.talentItems, this.lineItems = nil, nil
    this.skillBefore, this.skillAfter = nil, nil
    this.conditions = nil
    if this.doTween ~= nil then this.doTween:Kill() end
    this.doTween = nil
    if this.coroutine_key ~= nil then
        coroutine_runner.stop(this.coroutine_key)
    end
    uiRoot = nil
    this = nil
end
this.ClosePanel = function()
    if this.doTween ~= nil then this.doTween:Kill() end
    this.doTween = nil
    this.CloseTalentDetails()
    this.RemoveUIEventListener()
    for i = 1, #this.goodsMaterial do
        this.goodsMaterial[i]:Clear()
    end
    if this.coroutine_key ~= nil then
        coroutine_runner.stop(this.coroutine_key)
    end
    this.goodsMaterial = {}
    this.levelPointPos = {}
    this.attrSkillPointPos = {}
    AudioMgr.Singleton:Clear()
    uiRoot.bgScrollView.horizontalNormalizedPosition = 0
end
return vm({
    data = data,
    command = command,
    hook = hook
})
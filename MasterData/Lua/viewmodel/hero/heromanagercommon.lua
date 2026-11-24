local this = { vm = nil }

this.msgTransform = nil
local characterMsg
local star
local starIndex = 0

local skillIndex = 0
local skillLockingColor = UnityEngine.Color(1, 1, 1, 0.5)

this.isAttributeName = false

local heroDragPage = nil
this.dragPageTr = nil

this.isDraging = false

this.leftRect = nil
this.rightRect = nil
local leftCanvasGroup = nil
local rightCanvasGroup = nil

this.isAssisHero = false;

require("ViewModel/Hero/HeroDragPage")

local data = {
    levelMin = "",
    levelMax = "",
    levelExp = "",
    isMaxLevel = false,
    isNotMaxLevel = false,
    hgText = "",
    isMaxExp = false,
    levelExpProgress = 0.0;
    isLockHZ = false,
    isLockHG = false,
    isLockDA = false,
    isLockKH = false,
    isLockLP = false,
    isLockChange = false,
    isLockZZ = false,
    isLockLevel = false,
    addLevelColor = UnityEngine.Color.white,
    animationName = "",

    hgIcon = DefaultSprite,
    hgLv = "";

    isShowLevelUpBtn = true,
    isShowHZBtn = true,
    isShowHGBtn = true,
    isShowResetBtn = false,
    isShowDebuffBtn = false,
    isShowNoAttentionBtn = false,
    isShowDABtn = false,
    isShowExploreLevelBtn = false,
    exploreLevelStr = "",
    isShowWeaponClickMask = false,

    isNotWear = false,
    isWeapon = false,
    weaponLevel = "",

    qzName = "",
    fullName = "",
    qzIcon = DefaultSprite,
    limitIcon_1001 = false,
    star1 = false,
    star2 = false,
    star3 = false,
    star4 = false,
    star5 = false,
    star6 = false,
    isTag1 = false,
    isTag2 = false,
    isTag3 = false,
    isTag4 = false,
    tag1 = "",
    tag2 = "",
    tag3 = "",
    tag4 = "",
    zzLevel = "",
    zzBg = DefaultSprite,
    khSp = DefaultSprite,

    isLpShow = false,
    isLpIconShow = false,
    lpIcon = DefaultSprite,
    lpName = "",
    attention = false,

    isHZLock = false,
    isHZUnLock = false,
    isHZNormal = false,
    hzSlider1 = false,
    hzSlider2 = false,
    hzSlider3 = false,
    hzBtnText = "",

    equipItem = { isClick = false, itemId = "", level = "", rare = 0, rareIcon = DefaultSprite, root = false, scale = Vector3.zero,
                  star1 = false, star2 = false, star3 = false, star4 = false, star5 = false, star6 = false, usingId = "", icon = DefaultTexture },
    skillDatas = { { skillData = {} } },
    attributeDatas = { {} },


    isAssistMaskInfo = false;
}

local command = {
    attributeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickAttribute(param)
        end
    },
    detailsBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickDetails(param)
        end
    },
    changeBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickChange(param)
        end
    },
    weaponMaskCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickWeaponMask(param)
        end
    },
    hzCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickHZ(param)
        end
    },
    debuffCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickDebuff(param)
        end
    },
    exploreLevelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickExploreLevel(param)
        end
    },
    hgCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickHG(param)
        end
    },
    resetCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickReset(param)
        end
    },
    daCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickDA(param)
        end
    },
    khCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickKH(param)
        end
    },
    zzCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickZZ(param)
        end
    },
    zyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickZY(param)
        end
    },
    levelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickLevel(param)
        end
    },
    lpCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickLP(param)
        end
    },
    attentionCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.isAssisHero then
                return
            end ;
            this.HeroAttention(param)
        end
    },
    huanZhangCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.isAssisHero then
                return
            end ;
            this.OnClickHuanZhang()
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        RedMgr.Singleton:RegisterViewModel(UIName.HeroManagerViewModel);
        this.msgTransform = vm.behaviour.transform:Find("root/Left/Group/Msg")
        this.dragPageTr = vm.behaviour.transform:Find("root/Middle/DragPage")
        this.leftRect = vm.behaviour.transform:Find("root/Left"):GetComponent("RectTransform")
        this.rightRect = vm.behaviour.transform:Find("root/Right"):GetComponent("RectTransform")
    end,

    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        if HeroParameter.isRogueHeroInfo then
            this.vm.behaviour:UpdateTopBar("rogue", this.OnBack)
            LuaMgr.SetShowRogueCharacterData(true)
        end

        if not IsNull(HeroParameter.characterList) and HeroParameter.characterIndex > #HeroParameter.characterList then
            HeroParameter.characterIndex = #HeroParameter.characterList
        end
        HeroParameter.CheckCharacterListIsNull()
        characterMsg = LuaMgr.LoadCharacterMsgViewModel(characterMsg, this.msgTransform, HeroParameter.characterId, CharacterMsgType.LoginMain)
        this.isAttributeName = true
        this.isAssisHero = PlayerAssistMgr.IsCurAssistCharacter(HeroParameter.characterId);
        this.SetInfo()
        this.SetDragPage()




        LuaMgr.AddTimer(TimerConst.HeroViewShowMsg, this.ShowMSG, 60)
        LuaMgr.AddUIEventListener(UIEventConst.EquipTipsSplit, this.OnEquipTipsSplit)
        LuaMgr.AddUIEventListener(UIEventConst.HeroManagerDragEnd, this.OnEndDrag);
        LuaMgr.AddUIEventListener(UIEventConst.HeroManagerUpdateInfo, this.ResetInfo)

        this.vm.data.animationName = "ani_ui_HeroManagePanel_001"
    end,

    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        LuaMgr.RemoveTimer(TimerConst.HeroDragPageTime)
        LuaMgr.RemoveTimer(TimerConst.HeroManageStar)
        LuaMgr.RemoveTimer(TimerConst.HeroManageSkillDelay)
        LuaMgr.RemoveTimer(TimerConst.HeroViewShowMsg)
        LuaMgr.RemoveUIEventListener(UIEventConst.EquipTipsSplit, this.OnEquipTipsSplit)
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish)
        LuaMgr.RemoveUIEventListener(UIEventConst.HeroManagerDragEnd, this.OnEndDrag)
        if characterMsg ~= nil then
            characterMsg:Clear()
        end

        if heroDragPage ~= nil then
            heroDragPage:Clear()
        end
        HeroParameter.isRogueHeroInfo = false
        LuaMgr.SetShowRogueCharacterData(false)
    end,

    before_destroy = function(vm)
        characterMsg = nil
    end
}

this.ResetInfo = function()
    if this.isAssisHero then

        this.isAssisHero = false;
    end
    this.SetInfo();
end



this.SetInfo = function()
    local characterConfig = ConfigCharacterMgr.GetInfo(HeroParameter.characterId)
    local character = this.GetCharacter(HeroParameter.characterId)
    if character == nil then
        print("line 251,character is null")
    end
    this.vm.data.isShowHZBtn = not this.isAssisHero;
    this.vm.data.isAssistMaskInfo = this.isAssisHero;

    local tempRare = nil
    if this.isAssisHero then
        character = PlayerAssistMgr.GetCurAssist_CharacterData();
        if character == nil then
            print("this.isAssisHero, line 259,character is null")
            character = this.GetCharacter(HeroParameter.characterId)
        end
    end
    tempRare = this.GetHeroRare(character)
    local curExp = character.exp
    local next_level = ConfigCharacterMgr.GetCharacterLevelByAddExp(character.level, curExp, 0)
    local nextExp = ConfigCharacterMgr.GetCharacterLevelUpExp(next_level)
    local curLevelExp = ConfigCharacterMgr.GetCharacterExpByLevel(next_level)

    local hgMax = character.prestigeLevel >= 10;
    this.vm.data.hgText = ConfigCharacterMgr.GetFriendlyText(character.prestigeLevel)

    if hgMax ~= true then
        this.vm.data.hgLv = tostring(character.prestigeLevel);
        this.vm.data.hgIcon = LuaMgr.GetSprite("HeroPage", "ui_yc_hg0")
    else
        this.vm.data.hgLv = "";
        this.vm.data.hgIcon = LuaMgr.GetSprite("HeroPage", "ui_yc_hg")
    end

    this.vm.data.levelMin = tostring(character.level)
    this.vm.data.levelMax = "/" .. tostring(character.limitedLevel)
    this.vm.data.isShowResetBtn = not this.isAssisHero and character.level <= 30 and character.exp > 0;
    if character.level >= character.limitedLevel then
        this.vm.data.levelExp = ""
        this.vm.data.isMaxExp = true
        this.vm.data.levelExpProgress = 1
        if character.level >= ConfigMgr.Config.constants.maxCharacterLevel then
            this.vm.data.isMaxLevel = true
            this.vm.data.isNotMaxLevel = false
        else
            this.vm.data.isMaxLevel = false
            this.vm.data.isNotMaxLevel = true
        end
    else
        this.vm.data.isMaxExp = false
        this.vm.data.isMaxLevel = false
        this.vm.data.isNotMaxLevel = true
        local progress = ((curExp - curLevelExp) % nextExp) / nextExp
        this.vm.data.levelExpProgress = progress
        this.vm.data.levelExp = string.format("<color=#efe5cc>%s</color><color=#b0a791>/%s</color>", curExp - curLevelExp, nextExp)
    end

    if not this.isAssisHero and FeatureManager.IsLock("1005") then
        this.vm.data.addLevelColor = skillLockingColor
        this.vm.data.isLockLevel = true
    else
        this.vm.data.addLevelColor = UnityEngine.Color.white
        this.vm.data.isLockLevel = false
    end


    local styleBool = type(character.style) == "function" or TableIsNull(character.style)
    this.vm.data.isLpShow = styleBool
    this.vm.data.isLpIconShow = not styleBool
    if not styleBool then
        local styleConfig = ConfigMgr.Config.jobStyleMap[tostring(character.style.id)]
        this.vm.data.lpIcon = LuaMgr.GetSprite("SpecialityIcon", styleConfig.styleIcon)
        this.vm.data.lpName = LuaMgr.GetLangText(styleConfig.styleNameLan)
    end

    if tempRare > 4 then
        local propertyLevel = 0
        if type(character.brilliant) ~= "function" then
            propertyLevel = character.brilliant.PropertyLevel
        end
        this.vm.data.hzSlider1 = propertyLevel >= 1
        this.vm.data.hzSlider2 = propertyLevel >= 2
        this.vm.data.hzSlider3 = propertyLevel >= 3
    end
    this.vm.data.isHZNormal = tempRare > 4
    local brilliantKey = character.id .. (tempRare > 4 and 4 or tempRare)
    local brilliant = ConfigMgr.Config.BrilliantMap[brilliantKey]
    local timeBool = false
    if not TableIsNull(brilliant) then
        local curTime = LuaMgr.Timestamp()
        local unlockTime = brilliant.UnlockDate
        timeBool = curTime >= unlockTime
    end
    this.vm.data.isHZLock = not timeBool or TableIsNull(brilliant)
    this.vm.data.isHZUnLock = timeBool and not TableIsNull(brilliant)
    this.vm.data.hzBtnText = ConfigMgr.LangGlobal("22605")

    this.vm.data.attention = character.focus
    this.vm.data.qzName = LuaMgr.GetLangText(characterConfig.namelan)
    this.vm.data.fullName = LuaMgr.GetLangText(characterConfig.FullnameLan)

    local imageRare = tempRare >= 5 and 4 or tempRare
    this.vm.data.qzIcon = HeroMgr.GetHeroJobRareIcon1(characterConfig.job, imageRare)

    if IsNullOrEmpty(characterConfig.Linkage) then
        this.vm.data.limitIcon_1001 = false
    else
        this.vm.data.limitIcon_1001 = characterConfig.Linkage == "1001"
    end
    if character.star > 0 then
        this.vm.data.zzBg = LuaMgr.GetSprite("HeroRes", "ui_yc_zz01")
        this.vm.data.zzLevel = string.format("<color=#efe5cc>%s</color>", HeroMgr.GetNumStr(character.star))
    else
        this.vm.data.zzBg = LuaMgr.GetSprite("HeroRes", "ui_yc_zz02")
        this.vm.data.zzLevel = string.format("<color=#e7e3db>%s</color>", HeroMgr.GetNumStr(1))
    end
    this.SetStar(HeroMgr.GetCharacterRareStar(imageRare))
    this.SetAttribute(character)
    this.SetWeapon(character.wear)
    this.SetSkill(character)
    this.SetTags(LuaMgr.GetLangText(characterConfig.CharacterTagLan))
    this.SetRed()
    this.SetKH(character)

    this.vm.data.isLockChange = FeatureManager.IsLock("1025")
    this.vm.data.isLockHZ = FeatureManager.IsLock("1011")
    this.vm.data.isLockHG = FeatureManager.IsLock("1010")
    this.vm.data.isLockDA = FeatureManager.IsLock("1064")
    this.vm.data.isLockKH = FeatureManager.IsLock("1006")
    this.vm.data.isLockZZ = FeatureManager.IsLock("1007")
    local levelBool = character.level < ConfigMgr.Config.constants.ShenzaoUnlock
    this.vm.data.isLockLP = FeatureManager.IsLock("1110") or levelBool
    HeroRedDataHelper.InitArchivesRedData(HeroParameter.characterId)

    if HeroParameter.isRogueHeroInfo then
        this.vm.data.isShowLevelUpBtn = false
        this.vm.data.isShowHZBtn = false
        this.vm.data.isShowHGBtn = false
        this.vm.data.isShowResetBtn = false
        this.vm.data.isShowNoAttentionBtn = false
        this.vm.data.isShowDebuffBtn = true
        this.vm.data.isShowDABtn = false
        this.vm.data.isShowExploreLevelBtn = true
        this.vm.data.exploreLevelStr = string.format("%d / %d",
                RogueMgr.GetCharacterExploreLevel(HeroParameter.characterId), ConfigMgr.Config.RogueConstants.RogueMaxDiscoverLevel)
    else
        this.vm.data.isShowLevelUpBtn = true
        this.vm.data.isShowHGBtn = true
        this.vm.data.isShowNoAttentionBtn = true
        this.vm.data.isShowDebuffBtn = false
        this.vm.data.isShowDABtn = true
        this.vm.data.isShowExploreLevelBtn = false
    end
end


this.SetStar = function(rareStar)
    star = rareStar
    starIndex = 1
    for i = 1, 6 do
        this.vm.data["star" .. i] = false
    end
    LuaMgr.AddTimer(TimerConst.HeroManageStar, this.OnStar, 0.05, 99, true)
end

this.OnStar = function()
    if starIndex <= 6 then
        this.vm.data["star" .. starIndex] = star >= starIndex
        starIndex = starIndex + 1
    else
        LuaMgr.RemoveTimer(TimerConst.HeroManageStar)
    end
end

this.GetTalentBankID = function()
    return nil
end


this.SetAttribute = function(character)
    local attrTab
    local attrs = HeroMgr.GetMainAttrList()
    local uid = nil;
    if this.isAssisHero then
        uid = PlayerAssistMgr.GetCurAssist_HeroUid();
    end
    local levelingType = 0
    if HeroParameter.isRogueHeroInfo then
        levelingType = 2
    end
    local dataJson = "";
    if character.wear ~= "" then
        if this.isAssisHero then
            local equipmentData = PlayerAssistMgr.GetCurAssist_equipData();
            if not IsNull(equipmentData) then
                dataJson = json.encode(equipmentData);
            end
        elseif DataMgr.Player.equipments[character.wear] ~= nil then
            dataJson = json.encode(DataMgr.Player.equipments[character.wear])
        end
    end
    attrTab = LuaMgr.GetCharacterPropertyCopy(character.id, dataJson, this.GetHeroAttrKey(attrs), -1, levelingType, this.GetTalentBankID(character), uid)
    attrTab = json.decode(attrTab)
    local tempList = {}
    local tempItem = {}
    for i = 1, #attrs do
        local attrId = attrs[i].id
        local attrValue = attrTab[attrId] ~= nil and tonumber(attrTab[attrId]) or 0
        attrValue = LuaMgr.GetShowAttrValue(attrs[i].PanelScopeControl, attrId, attrValue)
        local attrIntValue = math.floor(attrValue)
        if attrIntValue == attrValue then
            attrValue = tostring(attrIntValue)
        else
            attrValue = tostring(attrValue)
        end
        tempItem = {
            icon = LuaMgr.GetSprite("AttributeIcon", attrId),
            name = LuaMgr.GetLangText(attrs[i].NameLan),
            isName = this.isAttributeName,
            value = attrValue,
            value1 = this.isAttributeName and attrValue or "",
            value2 = this.isAttributeName and "" or attrValue,
        }
        table.insert(tempList, tempItem)
    end
    this.vm.data.attributeDatas = tempList
end

this.GetHeroAttrKey = function(data)
    local attrKey = {}
    for i = 1, #data do
        table.insert(attrKey, data[i].id)
    end
    return attrKey
end


this.SetWeapon = function(wear)
    if IsNullOrEmpty(wear) then
        this.vm.data.isWeapon = false
        this.vm.data.isNotWear = true
        this.vm.data.equipItem = { root = false }
    else
        this.vm.data.isWeapon = true
        this.vm.data.isNotWear = false
        local equipData = nil;
        if this.isAssisHero then
            equipData = PlayerAssistMgr.GetCurAssist_equipData();
        elseif HeroParameter.isRogueHeroInfo then
            local equipmentData = json.decode(LuaMgr.GetRogueEquipment(HeroParameter.characterId))
            equipData = equipmentData
        else
            equipData = DataMgr.Player.equipments[wear]
        end
        if equipData == nil then
            return
        end
        local equipConfig = ConfigMgr.Config.equipments[equipData.equipmentId]
        if equipConfig == nil then
            return
        end

        local equipItemData = {}
        local canClick = not this.isAssisHero and not HeroParameter.isRogueHeroInfo
        EquipHelper.SetData(equipItemData, equipData, equipConfig, canClick, 0.75)

        this.vm.data.isShowWeaponClickMask = HeroParameter.isRogueHeroInfo
        this.vm.data.equipItem = equipItemData
        this.vm.data.weaponLevel = equipData.grade
    end
end


this.SetSkill = function(character)
    local tempList = {}
    for i = 1, #HeroMgr.SkillList do
        local key = HeroMgr.SkillList[i]
        local skill = character.skills[key]
        if not ConfigSkillMgr.SkillShouldHide(skill.groupId .. skill.level, i <= 3 and 1 or 2) then
            local item = { skillData = {} }
            local color = skill.locking and skillLockingColor or UnityEngine.Color.white
            SkillHelper.SetSkill(item.skillData, skill.groupId, skill.level, i <= 3 and 1 or 2, color,
                    not skill.locking, skill.locking)
            SkillHelper.SetData(item.skillData, SkillType.Character, HeroParameter.characterId, true, SkillShowType.Hero, 0.53)
            item.skillData.isShow = false
            item.skillData.isAssistHero = this.isAssisHero;
            table.insert(tempList, item)
        end
    end
    this.vm.data.skillDatas = tempList
    skillIndex = -3
    LuaMgr.AddTimer(TimerConst.HeroManageSkillDelay, this.OnSkillDelay, 0.05, -1, true)
end

this.OnSkillDelay = function()
    if skillIndex <= #this.vm.data.skillDatas then
        if skillIndex > 0 then
            this.vm.data.skillDatas[skillIndex].skillData.isShow = true
        end
        skillIndex = skillIndex + 1
        if skillIndex > #this.vm.data.skillDatas then
            LuaMgr.RemoveTimer(TimerConst.HeroManageSkillDelay)
        end
    end
end


this.SetTags = function(tag)
    local tags = NumTool.split(tag, ';')
    local len = #tags
    for i = 1, 4 do
        local str = i <= len and tags[i] or ""
        if i == 1 then
            this.vm.data.isTag1 = not IsNullOrEmpty(str)
            this.vm.data.tag1 = str
        elseif i == 2 then
            this.vm.data.isTag2 = not IsNullOrEmpty(str)
            this.vm.data.tag2 = str
        elseif i == 3 then
            this.vm.data.isTag3 = not IsNullOrEmpty(str)
            this.vm.data.tag3 = str
        elseif i == 4 then
            this.vm.data.isTag4 = not IsNullOrEmpty(str)
            this.vm.data.tag4 = str
        end
    end
end


this.SetRed = function()
    if HeroParameter.isRogueHeroInfo then
        return
    end
    RedMgr.Singleton:UpdateClientRedData("1026", not this.isAssisHero and PlayerCharacterMgr.RedUpLevel(HeroParameter.characterId) and 1 or 0)
    RedMgr.Singleton:UpdateClientRedData("1023", not this.isAssisHero and PlayerCharacterMgr.RedZZ(HeroParameter.characterId) and 1 or 0)
    RedMgr.Singleton:UpdateClientRedData("1024", not this.isAssisHero and PlayerCharacterMgr.RedTalent(HeroParameter.characterId) and 1 or 0)
    RedMgr.Singleton:UpdateClientRedData("1027", not this.isAssisHero and PlayerCharacterMgr.EquipmentWearState(HeroParameter.characterId) and 1 or 0)
    RedMgr.Singleton:UpdateClientRedData("1150", not this.isAssisHero and PlayerCharacterMgr.RedFriendly(HeroParameter.characterId))
    RedMgr.Singleton:UpdateClientRedData("1192", not this.isAssisHero and PlayerCharacterMgr.RedSpeciality(HeroParameter.characterId) and 1 or 0)
    local brilliantRed = PlayerCharacterMgr.RedHuanZhang(HeroParameter.characterId) or PlayerCharacterMgr.RedHuanZhangReward(HeroParameter.characterId)
    RedMgr.Singleton:UpdateClientRedData("16203", not this.isAssisHero and brilliantRed and 1 or 0)
    RedMgr.Singleton:Refresh()
end


this.SetKH = function(character)
    local key = character.id .. "18"
    local data = character.talents[key]
    this.vm.data.khSp = LuaMgr.GetSprite("HeroRes", (data ~= nil and data.status == 2) and "ui_yc_kh_ytp" or "ui_yc_kh_wtp")
end


this.SetDragPage = function()
    if heroDragPage == nil then
        heroDragPage = HeroDragPage.New(this.dragPageTr)
    end
    local dragData = {
        rectSize = 1500,
        dragDist = 200,
        onClick = this.OnClickHeroMsg,
        onEnd = this.EndDragCB,
        ani = true,
        leftRect = this.leftRect,
        rightRect = this.rightRect,
        leftCanvasGroup = leftCanvasGroup,
        rightCanvasGroup = rightCanvasGroup,
        canDrag = false,
        isAssistHero = this.isAssisHero,
    }
    heroDragPage:SetData(dragData)
    LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish);
end

this.OnEndDrag = function(args)
    local status = args[0]
    this.isDraging = status ~= 0
end


this.EndDragCB = function()
    LuaMgr.HidePanel(UIName.HeroAttributeDetailsViewModel)
    LuaMgr.HidePanel(UIName.HeroOccupationViewModel)
    LuaMgr.HidePanel(UIName.SkillTipsViewModel)
    LuaMgr.HidePanel(UIName.WeaponTipsViewModel)
    this.SetInfo()
    if characterMsg ~= nil then
        characterMsg:Clear()
    end
    if DataHelper.CheckIsBirthDay() then
        AudioMgr.Singleton:StopVoice(true)
        LuaMgr.RemoveTimer(TimerConst.HeroViewShowMsg)
        characterMsg = LuaMgr.LoadCharacterMsgViewModel(characterMsg, this.msgTransform, HeroParameter.characterId, CharacterMsgType.HappyBirthdayLine)
    else
        this.OnClickHeroMsg()
    end
    this.isDraging = false
end


this.ShowMSG = function()
    characterMsg = LuaMgr.LoadCharacterMsgViewModel(characterMsg, this.msgTransform, HeroParameter.characterId, CharacterMsgType.ClickCharacter)
end

this.OnEquipTipsSplit = function(args)
    local character = this.GetCharacter(HeroParameter.characterId)
    this.SetWeapon(character.wear)
end

this.OnAnimatorPlayFinish = function(args)
    if args[0] == "ani_ui_HeroManagePanel_001" then
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAnimatorPlayFinish)
        heroDragPage:SetCanDrag(true)
    end
end


this.OnClickAttribute = function(param)
    if this.isDraging then
        return
    end
    this.isAttributeName = not this.isAttributeName
    for i, item in ipairs(this.vm.data.attributeDatas) do
        if this.isAttributeName then
            item.value1 = item.value
            item.value2 = ""
        else
            item.value1 = ""
            item.value2 = item.value
        end
        item.isName = this.isAttributeName
    end
end

this.OnClickDetails = function(param)
    if this.isDraging or this.isAssisHero then
        return
    end
    LuaMgr.ShowPanel(UIName.HeroAttributeDetailsViewModel, HeroParameter.characterId, false)
end

this.OnClickChange = function(param)
    if this.isDraging or this.isAssisHero then
        return
    end
    if this.vm.data.isLockChange then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1025"))
        return
    end
    if HeroParameter.isRogueHeroInfo then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26208"));
        return
    end
    LuaMgr.ShowLuaPanel("EquipWearViewModel", HeroParameter.characterId)
end

this.OnClickWeaponMask = function(param)
    if this.isDraging or this.isAssisHero then
        return
    end
    if this.vm.data.isLockChange then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1025"))
        return
    end
    if HeroParameter.isRogueHeroInfo then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26208"));
        return
    end
end

this.OnClickHZ = function(param)
    if this.isDraging then
        return
    end
    if this.vm.data.isLockHZ then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1011"))
        return
    end
    LuaMgr.ShowLuaPanel("HeroSkinViewModel")
end

this.OnClickDebuff = function(param)
    if not HeroParameter.isRogueHeroInfo then
        return
    end
    LuaMgr.ShowLuaPanel(UIName.RogueDebuffPopup, HeroParameter.characterId)
end

this.OnClickExploreLevel = function(param)
    if not HeroParameter.isRogueHeroInfo then
        return
    end
    LuaMgr.ShowLuaPanel(UIName.RogueExploreLevelPopup, HeroParameter.characterId)
end

this.OnClickHG = function(param)
    if this.isDraging or this.isAssisHero then
        return
    end
    if this.vm.data.isLockHG then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1010"))
        return
    end
    LuaMgr.ShowLuaPanel("HeroFriendlyViewModel", HeroParameter.characterId)
end

this.OnClickReset = function(param)
    if this.isDraging then
        return
    end
    local character = this.GetCharacter(HeroParameter.characterId)
    if character.level > 30 then
        return
    end
    LuaMgr.ShowLuaPanel("HeroResetViewModel", HeroParameter.characterId)
end

this.OnClickDA = function(param)
    if this.isDraging or this.isAssisHero then
        return
    end
    if this.vm.data.isLockDA then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1064"))
        return
    end
    LuaMgr.LoadAB("character_" .. HeroParameter.characterId .. ".ab", true)
    LuaMgr.ShowLuaPanel("HeroArchivesViewModel")
end

this.OnClickKH = function(param)
    if this.isDraging then
        return
    end
    if this.vm.data.isLockKH then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1006"))
        return
    end
    if HeroParameter.isRogueHeroInfo then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26203"));
        return
    end
    LuaMgr.ShowLuaPanel(UIName.HeroTalentViewModel, HeroParameter.characterId)
end

this.OnClickZZ = function(param)
    if this.isDraging then
        return
    end
    if this.vm.data.isLockZZ then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1007"))
        return
    end
    if HeroParameter.isRogueHeroInfo then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26205"));
        return
    end
    LuaMgr.ShowLuaPanel("HeroZZViewModel", HeroParameter.characterId)
end

this.OnClickZY = function(param)
    if this.isDraging then
        return
    end
    LuaMgr.ShowLuaPanel("HeroOccupationViewModel")
end

this.OnClickLevel = function(param)
    if this.isDraging or this.isAssisHero then
        return
    end
    if FeatureManager.IsLock("1005") then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1005"))
        return
    end
    if HeroParameter.isRogueHeroInfo then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26211"));
        return
    end
    LuaMgr.ShowLuaPanel(UIName.HeroUpLevelViewModel)
end

this.OnClickLP = function(param)
    if this.isDraging then
        return
    end
    local character = this.GetCharacter(HeroParameter.characterId)
    if this.isAssisHero then
        character = PlayerAssistMgr.GetCurAssist_CharacterData();
    end
    local levelBool = character.level < ConfigMgr.Config.constants.ShenzaoUnlock
    if FeatureManager.IsLock("1110") then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1110"))
        return
    end
    if levelBool then
        local str = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2130"].NameLan)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(str, ConfigMgr.Config.constants.ShenzaoUnlock))
        return
    end
    if this.isAssisHero and IsNull(character.style) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("2932"));
        return ;
    end
    if HeroParameter.isRogueHeroInfo then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26204"));
        return
    end
    LuaMgr.ShowLuaPanel(UIName.HeroSpecialityViewModel, HeroParameter.characterId)
end

this.HeroAttention = function(param)
    local character = this.GetCharacter(HeroParameter.characterId)
    local focus = {}
    focus[character.id] = param == "1"
    local tempData = {}
    tempData["CharacterIds"] = focus
    ApiMgr.Request("set_character_focus", tempData, true, function(result)
        local re = json.decode(result)
        if re.code == 0 then
            character = this.GetCharacter(HeroParameter.characterId)
            this.vm.data.attention = character.focus
            local tipStr = ""
            if character.focus then
                tipStr = ConfigMgr.LangGlobal("2611")
            else
                tipStr = ConfigMgr.LangGlobal("2612")
            end
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
        end
    end, nil, true)
end

this.OnClickHuanZhang = function()
    local character = this.GetCharacter(HeroParameter.characterId)
    if character == nil then
        return
    end
    local rare = HeroMgr.GetHeroNowRare(HeroParameter.characterId)
    if rare > 4 then
        rare = 4
    end
    local brilliantKey = HeroParameter.characterId .. rare
    local brilliant = ConfigMgr.Config.BrilliantMap[brilliantKey]
    local tipStr = ""
    if TableIsNull(brilliant) then
        tipStr = ConfigMgr.LangGlobal("2103")
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
        return
    end
    local curTime = LuaMgr.Timestamp()
    local unlockTime = brilliant.UnlockDate
    if curTime < unlockTime then
        local tip = os.date("%Y/%m/%d %H:%M", unlockTime)
        tipStr = string.format(ConfigMgr.LangGlobal("2390"), tip)
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
        return
    end
    if HeroParameter.isRogueHeroInfo then
        local character = this.GetCharacter(HeroParameter.characterId)
        if character.brilliant ~= nil and character.brilliant.RareLevel > 0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26206"));
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26207"));
        end
        return
    end
    LuaMgr.ShowLuaPanel(UIName.HeroHuanZhangViewModel, HeroParameter.characterId)
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

this.OnClickHeroMsg = function(param)
    AudioMgr.Singleton:StopVoice(true)
    LuaMgr.RemoveTimer(TimerConst.HeroViewShowMsg)
    this.ShowMSG()
end

this.GetCharacter = function(characterId)
    if HeroParameter.isRogueHeroInfo then
        return RogueMgr.GetCharacterDataByID(HeroParameter.characterId)
    end
    return PlayerCharacterMgr.GetCharacter(HeroParameter.characterId)
end

return {
    this = this,
    data = data,
    command = command,
    hook = hook,
}
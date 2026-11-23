





local this = {
    vm = nil,spineCharacter = nil,tableInsert = table.insert,strFormat = string.format,
    characterId = nil,characterData = nil,characterConfig = nil,characterRare = nil,
    curStatus = nil,statusEnum = {UpRare = 1,LockOrnament = 2,UnLockOrnament = 3},
    BRILLIANT_ICON_PATH = "Assets/_BundleResources/Images/HuanZhangIcon/",
    countColor = "<color=#FF0000>%d</color>",goodsMaterial = nil,
    attrColor = "<color=#32716F>%s</color>",
    materialView = nil,canUpRareBool = nil,skillIntroRect = nil,
    isPreview = false,isOrnamentUp = false,ornamentMax = 3,
    animatorRoot=nil;coroutine_key = nil,isClick = false,isCondition = false,
    brilliantDungeonId = "",
    brilliantGuidePictureIds = nil
}

local data = {
    bodyPath = "",
    tag1 = "", tag2 = "", tag3 = "", tag4 = "",
    isTag1 = false, isTag2 = false, isTag3 = false, isTag4 = false,
    qzName = "",fullName = "",qzIcon = DefaultSprite,limitIcon_1001 = false,

    upRareRoot = false,
    titleText1 = "",tipText1 = "",afterRare = DefaultSprite,
    tipText2 = "",

    lockOrnamentRoot = false,
    titleText2 = "",goodsName = "",goodsTexture = DefaultTexture,tipText3 = "",

    unLockOrnament = false,
    titleText3 = "",tipText4 = "",skillName = "",skillIntro = "",
    closeBtn = false,closeText = "",
    retrospectBtn = false,retrospectText = "",
    upFavorText="",
    upLevelText = "",closeUpLevelText = "",
    upLevelBtn = false,closeUpLevelBtn = false,confirmUpLevelBtn = false,
    slider1 = false,slider2 = false,slider3 = false,
    consume = false, consumeValue = "",consumeIcon = DefaultTexture,
    isMax = false,maxText = "",condition = false,tipText7 = "",

    confirmBtnText = "",
    materialRoot = false,
    materialListPos = Vector2.zero,
    confirmBtnRoot = false,
    noConfirmBtnRoot = false,
    confirmBtnPos = Vector2.zero,
    attrRoot = false,
    attrListPos = Vector2.zero,
    isCurrency = false,currencyIcon = DefaultTexture,currencyText = "",
    attrList = {{attrIcon = DefaultSprite,attrName = "",beforeValue = "",afterValue = "",isShowBefore = false,isVfx=false;}},
    

    unlockPopupRoot = false,tipText5 = "",goodsIntro = "",confirmBtnText_1 = "",
    contentPos = Vector2.zero,bodyRoot = false,unLockTip = false,
    upLevelVFX01=false;
    

    UpLevelTip = false,
    rareDi = DefaultSprite,rareDi_1 = DefaultSprite,rare = DefaultSprite,
    jobRare = DefaultSprite,jobIcon = DefaultSprite, tipText6 = "",
    upLevelAttrList = {{attrIcon = DefaultSprite,attrName = "",attrValue = ""}},
    rareEffectR = false,rareEffectSR = false,

    
    brilliantDetailBtnActive = false,
    brilliantDungeonBtnActive = false,
    brilliantDungeonMiniBtnActive = false,
    brilliantDungeonRewardRare = DefaultSprite,
    brilliantDungeonRewardIcon = DefaultTexture,
    brilliantDungeonRewardCount = "",
    brilliantDungeonRewardReceived = false,
    brilliantDungeonRewardAlpha = 1.0,
}

local command = {
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SendConfirm()
        end
    },
    noConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local tips = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["22612"].NameLan)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tips)
            return
        end
    },
    zyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickZY()
        end
    },
    previewCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OpenPreview()
        end
    },
    closePreviewCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.ClosePreview()
        end
    },
    retrospectCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OpenUnLockPopup()
        end
    },
    closeRetrospectCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.unLockTip = false
            this.vm.data.unlockPopupRoot = false
            this.SetStatus();
            this.animatorRoot:Play("ani_HeroHuanZhangPanel_root",0,0);
        end
    },
    upLevelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.isOrnamentUp = true
            this.vm.data.upLevelBtn = false
            this.vm.data.closeUpLevelBtn = true
            this.vm.data.confirmUpLevelBtn = true
            local propertyLevel = 0
            if type(this.characterData.brilliant) ~= "function" then
                propertyLevel = this.characterData.brilliant.PropertyLevel
            end
            this.SetAttrList(true)
            this.SetMaterial(propertyLevel + 1)
        end
    },
    closeUpLevelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.isOrnamentUp = false
            this.SetAttrList()
            this.vm.data.materialRoot = false
            this.vm.data.consume = false
            this.vm.data.upLevelBtn = true
            this.vm.data.closeUpLevelBtn = false
            this.vm.data.confirmUpLevelBtn = false
        end
    },
    confirmUpLevelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SendUpLevelConfirm()
        end
    },
    closeUpLevelPopup = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not this.isClick then return end
            this.vm.data.UpLevelTip = false
            this.vm.data.rareEffectR = false
            this.vm.data.rareEffectSR = false
        end
    },
    brilliantDetailCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if TableIsNull(this.brilliantGuidePictureIds) then
                return
            end
            local jsonData = json.encode (this.brilliantGuidePictureIds);
            LuaMgr.ShowLuaPanel(UIName.NewHelpViewModel, jsonData)
        end
    },
    brilliantDungeonCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local hzKey = DataMgr.Player.uid.."huanzhangReward"..this.characterId
            if not UnityEngine.PlayerPrefs.HasKey(hzKey) then
                UnityEngine.PlayerPrefs.SetString(hzKey)
                PlayerCharacterMgr.UpdateRedHuanZhangReward(this.characterData)
            end
            BattlePrepareMgr.EnterBattlePrepare(this.brilliantDungeonId,this.brilliantDungeonId);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.spineCharacter = vm.behaviour.transform:Find("root/Middle/BodyObject/Body"):GetComponent("UISpineCharacter")
        this.materialView = vm.behaviour.transform:Find("root/_Right/Content/MaterialList"):GetComponent("RectTransform")

        this.animatorRoot=vm.behaviour.transform:Find("root"):GetComponent("Animator")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        vm.behaviour:UpdateTopBar("", this.Back)
        this.AddUIEvent()
        this.SetLanguageText()
        this.animatorRoot:Play("ani_HeroHuanZhangPanel_root",0,0);
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.isOrnamentUp = false
        this.spineCharacter:Clear()
        this.ClearMaterial()
        this.RemoveUIEvent()
        this.vm.data.unlockPopupRoot = false
        this.vm.data.unLockTip = false
        this.vm.data.UpLevelTip = false
        this.vm.data.rareEffectR = false
        this.vm.data.rareEffectSR = false
        this.vm.data.attrList = {}
        this.vm.data.upLevelAttrList = {}
        if this.coroutine_key ~= nil then
            coroutine_runner.stop(this.coroutine_key)
        end
        this.isClick = false
    end,
    before_destroy = function(vm)
        if this.coroutine_key ~= nil then
            coroutine_runner.stop(this.coroutine_key)
        end
        this = nil
    end,
}

this.AddUIEvent = function()
    LuaMgr.AddUIEventListener(UIEventConst.PropUse,this.UpdateMaterial)
end
this.RemoveUIEvent = function()
    LuaMgr.RemoveUIEventListener(UIEventConst.PropUse,this.UpdateMaterial)
end

this.Back=function()
    if this.vm.data.unlockPopupRoot then
        this.vm.data.unLockTip = false
        this.vm.data.unlockPopupRoot=false;
        this.SetStatus();
        this.animatorRoot:Play("ani_HeroHuanZhangPanel_root",0,0);
        return;
    end
    if this.isPreview then



        this.ClosePreview();
        return;
    end
    LuaMgr.Back();
end



this.SetLanguageText = function()

    this.vm.data.tipText2 = ConfigMgr.LangGlobal("22603")
    this.vm.data.titleText2 = ConfigMgr.LangGlobal("22601")
    this.vm.data.tipText3 = ConfigMgr.LangGlobal("22604")

    this.vm.data.tipText4 = ConfigMgr.LangGlobal("22607")

    this.vm.data.confirmBtnText = ConfigMgr.LangGlobal("22605")
    this.vm.data.closeText = ConfigMgr.LangGlobal("22609")
    this.vm.data.retrospectText = ConfigMgr.LangGlobal("22613")
    this.vm.data.confirmBtnText_1 = ConfigMgr.LangGlobal("22614")
    this.vm.data.upLevelText = ConfigMgr.LangGlobal("22617")
    this.vm.data.upFavorText=ConfigMgr.LangGlobal("22621")
    this.vm.data.closeUpLevelText = ConfigMgr.LangGlobal("10187")
    this.vm.data.maxText = ConfigMgr.LangGlobal("22618")
    this.vm.data.tipText6 = ConfigMgr.LangGlobal("22623")
    this.vm.data.tipText7 = ConfigMgr.LangGlobal("22625")
end


this.InitParameter = function()
    if this.vm.behaviour.Params.Length > 0 then
        local addWidth = LuaMgr.GetScreenAddWidth()
        if addWidth <= 0 then
            this.vm.data.contentPos = Vector2(50,0)
        else
            this.vm.data.contentPos = Vector2(-39,0)
        end
        
        this.characterId = this.vm.behaviour.Params[0]
        if IsNullOrEmpty(this.characterId) then return end
        
        this.characterConfig = ConfigCharacterMgr.GetInfo(this.characterId)
        if TableIsNull(this.characterConfig) then return end
        
        this.characterData = DataMgr.Player.characters[this.characterId]
        if TableIsNull(this.characterData) then return end
        this.isCondition = this.characterData.level >= ConfigMgr.Config.constants.BrilliantUnlockLevel
        local hzKey = DataMgr.Player.uid.."huanzhang"..this.characterId
        if not UnityEngine.PlayerPrefs.HasKey(hzKey) then
            UnityEngine.PlayerPrefs.SetString(hzKey)
            PlayerCharacterMgr.UpdateRedHuanZhang(this.characterData)
        end
        
        this.characterRare = HeroMgr.GetHeroNowRare(this.characterId)
        if not this.isCondition then

            this.characterRare = CharacterRare.SSR
        end
        if this.characterRare == nil or this.characterRare == 0 then return end
        this.vm.data.unLockTip = false
        this.vm.data.upLevelVFX01=false;
        this.SetStatus()
        this.SetTags()
        this.SetSpineCharacter()
        this.SetBrilliantReward()
    end
end


this.SetSpineCharacter = function()
    if this.curStatus == this.statusEnum.UnLockOrnament then
        return
    end
    local path = HeroManager.SetCharacterDrawing(this.spineCharacter,this.characterId)
    if (not IsNullOrEmpty(path)) then
        this.vm.data.bodyPath = path
    end
end


this.SetBrilliantReward = function()
    local tempRare = this.characterRare >= 5 and 4 or this.characterRare
    local brilliantKey = this.characterId..tempRare
    local brilliantCfg = ConfigMgr.Config.BrilliantMap[brilliantKey]
    if IsNullOrEmpty(brilliantCfg.DungeonId) then
        this.vm.data.brilliantDungeonBtnActive = false
        this.vm.data.brilliantDungeonMiniBtnActive = false
    else
        local dungeonCfg = ConfigMgr.Config.dungeonMap[brilliantCfg.DungeonId]
        local firstRewardList = ConfigHelper.GetRewardListByDrop(dungeonCfg.firstDrop);
        local dungeonRecord = DataMgr.Player.dungeonRecords[brilliantCfg.DungeonId]
        local completed = dungeonRecord ~= nil and not IsNullOrEmpty(dungeonRecord.historyRating)
        if firstRewardList ~= nil and next(firstRewardList) ~= nil then
            local tempConfig = ConfigMgr.Config.itemMap[firstRewardList[1].id]
            this.vm.data.brilliantDungeonRewardRare = GetRareSprite(tempConfig.rare)
            this.vm.data.brilliantDungeonRewardIcon = GetItemTexture(firstRewardList[1].id)
            this.vm.data.brilliantDungeonRewardCount = firstRewardList[1].count
            this.vm.data.brilliantDungeonRewardReceived = completed
            this.vm.data.brilliantDungeonRewardAlpha = completed and 0.7 or 1.0
            this.vm.data.brilliantDungeonBtnActive = true
            this.vm.data.brilliantDungeonMiniBtnActive = this.curStatus == this.statusEnum.UnLockOrnament or (this.curStatus ~= this.statusEnum.LockOrnament or this.isCondition)
            this.brilliantDungeonId = brilliantCfg.DungeonId
        end
    end
    this.brilliantGuidePictureIds = brilliantCfg.GuidePictureId
    this.vm.data.brilliantDetailBtnActive = not TableIsNull(brilliantCfg.GuidePictureId) and next(brilliantCfg.GuidePictureId) ~= nil
end


this.SetTags = function()
    if this.curStatus == this.statusEnum.UnLockOrnament then
        return
    end
    local tag = LuaMgr.GetLangText(this.characterConfig.CharacterTagLan)
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
    this.vm.data.qzName = LuaMgr.GetLangText(this.characterConfig.namelan)
    this.vm.data.fullName = LuaMgr.GetLangText(this.characterConfig.FullnameLan)
    local imageRare = this.characterRare >= 5 and 4 or this.characterRare
    this.vm.data.qzIcon = HeroMgr.GetHeroJobRareIcon1(this.characterConfig.job, imageRare)
    if IsNullOrEmpty(this.characterConfig.Linkage) then
        this.vm.data.limitIcon_1001 = false
    else
        this.vm.data.limitIcon_1001 = this.characterConfig.Linkage == "1001"
    end
end


this.SetStatus = function()
    this.curStatus = nil
    this.isPreview = false
    local brilliantKey = this.characterId..this.characterRare
    local brilliant = ConfigMgr.Config.BrilliantMap[brilliantKey]
    this.canUpRareBool = true
    if TableIsNull(brilliant) then
        this.curStatus = this.statusEnum.UnLockOrnament
    else
        if brilliant.Rare[1] == brilliant.Rare[2] then
            this.curStatus = this.statusEnum.LockOrnament
        else
            this.curStatus = this.statusEnum.UpRare
        end
    end
    if this.curStatus == nil then return end
    this.SetRootStatus()
end

this.SetRootStatus = function()
    if this.curStatus == this.statusEnum.UpRare then
        this.SetUpRareRoot()
    elseif this.curStatus == this.statusEnum.LockOrnament then
        this.SetLockOrnamentRoot()
    elseif this.curStatus == this.statusEnum.UnLockOrnament then
        this.isOrnamentUp = false
        this.SetUnlockOrnamentRoot()
    end

    this.SetConfirmBtnPos()
    this.SetMaterial()
    this.SetAttrList()
    this.vm.data.upRareRoot = this.curStatus == this.statusEnum.UpRare
    this.vm.data.lockOrnamentRoot = this.curStatus == this.statusEnum.LockOrnament
    this.vm.data.unLockOrnament = this.curStatus == this.statusEnum.UnLockOrnament
    this.vm.data.noConfirmBtnRoot = not this.canUpRareBool
    this.vm.data.bodyRoot = this.curStatus ~= this.statusEnum.UnLockOrnament
    this.vm.data.condition = not this.isCondition
end


this.SetUpRareRoot = function()
    local tempRare = this.characterRare + 1
    this.vm.data.titleText1 = this.strFormat(ConfigMgr.LangGlobal("22600"),this.GetHeroRareStr(tempRare))
    local iconTexture = LuaMgr.GetSprite("TalentIcon","kh_UpRare"..tempRare)
    this.vm.data.afterRare = iconTexture
end


this.SetLockOrnamentRoot = function()
    local brilliantKey = this.characterId..this.characterRare
    local brilliant = ConfigMgr.Config.BrilliantMap[brilliantKey]
    if TableIsNull(brilliant) then return end
    this.vm.data.goodsName = LuaMgr.GetLangText(brilliant.IconName)
    this.vm.data.goodsTexture = LuaMgr.GetTexture(this.BRILLIANT_ICON_PATH..brilliant.Icon..".png")
end


this.SetUnlockOrnamentRoot = function()
    local propertyLevel = 0
    if type(this.characterData.brilliant) ~= "function" then
        propertyLevel = this.characterData.brilliant.PropertyLevel
    end
    this.vm.data.isMax = propertyLevel >= this.ornamentMax
    this.vm.data.slider1 = propertyLevel >= 1
    this.vm.data.slider2 = propertyLevel >= 2
    this.vm.data.slider3 = propertyLevel >= this.ornamentMax
    this.vm.data.upLevelBtn = not this.isOrnamentUp and propertyLevel < this.ornamentMax and not this.isPreview
    this.vm.data.closeUpLevelBtn = this.isOrnamentUp and propertyLevel < this.ornamentMax
    this.vm.data.confirmUpLevelBtn = this.isOrnamentUp and propertyLevel < this.ornamentMax
    local tempRare = this.characterRare >= 5 and 4 or this.characterRare
    local brilliantKey = this.characterId..tempRare
    local brilliant = ConfigMgr.Config.BrilliantMap[brilliantKey]
    if TableIsNull(brilliant) then return end
    this.vm.data.goodsName = LuaMgr.GetLangText(brilliant.IconName)
    this.vm.data.goodsTexture = LuaMgr.GetTexture(this.BRILLIANT_ICON_PATH..brilliant.Icon..".png")
    if TableIsNull(brilliant.Skill1) and TableIsNull(brilliant.Skill2) then
        this.OrnamentBuff(brilliant)
    else
        this.OrnamentSkill(brilliant)
    end
    this.vm.data.closeBtn = this.isPreview
    this.vm.data.retrospectBtn = not this.isPreview and this.characterRare >= 5
end

this.SetConfirmBtnPos = function()
    if not this.isCondition then
        this.vm.data.confirmBtnRoot = false
        return
    end
    if this.curStatus == this.statusEnum.UpRare then
        this.vm.data.confirmBtnPos = Vector2(-6,-300)
    elseif this.curStatus == this.statusEnum.LockOrnament then
        this.vm.data.confirmBtnPos = Vector2(-6,-282)
    end
    if this.curStatus ~= this.statusEnum.UnLockOrnament then
        local brilliantKey = this.characterId..this.characterRare
        local brilliant = ConfigMgr.Config.BrilliantMap[brilliantKey]
        local isShow = true
        if TableIsNull(brilliant) or type(brilliant.RequireCoin) == "function" or TableIsNull(brilliant.RequireCoin) then
            isShow = false
        else
            local id,count = brilliant.RequireCoin[1].id,brilliant.RequireCoin[1].count
            if DataHelper.GetItemCountById(id) < count then
                this.canUpRareBool = false
                count = this.strFormat(this.countColor,count)
            end
            this.vm.data.currencyText = count
            this.vm.data.currencyIcon = GetItemHomeIcon(id)
        end
        this.vm.data.isCurrency = isShow
    end
    this.vm.data.confirmBtnRoot = this.curStatus ~= this.statusEnum.UnLockOrnament
end

this.SetMaterial = function(level)
    if (this.curStatus == this.statusEnum.UnLockOrnament and (level == nil or level > this.ornamentMax)) or not this.isCondition then
        this.vm.data.consume = false
        this.vm.data.materialRoot = false
        return
    end
    local tempMaterial = nil
    if level == nil then
        local brilliantKey = this.characterId..this.characterRare
        local brilliant = ConfigMgr.Config.BrilliantMap[brilliantKey]
        if TableIsNull(brilliant) or type(brilliant.ItemCost1) == "function" or TableIsNull(brilliant.ItemCost1) then
            this.vm.data.materialRoot = false
            return
        end
        tempMaterial = brilliant.ItemCost1
    else
        local upItemCostKey = this.characterId..(level)
        local upItemCost = ConfigMgr.Config.BrilliantUpMap[upItemCostKey]
        if TableIsNull(upItemCost) then
            this.vm.data.materialRoot = false
            return
        end
        local id,count = "3",upItemCost.Coin
        if DataHelper.GetItemCountById(id) < count then
            this.canUpRareBool = false
            this.vm.data.consumeValue = this.strFormat(this.countColor,count)
        else
            this.vm.data.consumeValue = count
        end
        this.vm.data.consumeIcon = GetItemHomeIcon(id)
        this.vm.data.consume = upItemCost.Coin > 0
        tempMaterial = upItemCost.Res
    end
    if TableIsNull(tempMaterial) then return end
    if this.goodsMaterial == nil then
        this.goodsMaterial = {}
    end
    local length = #tempMaterial
    local material = nil
    for i = 1, length do
        if this.goodsMaterial[i] == nil then
            material = MaterialItem.New(this.materialView)
            this.tableInsert(this.goodsMaterial,material)
        end
        if DataHelper.GetItemCountById(tempMaterial[i].id) < tempMaterial[i].count then
            this.canUpRareBool = false
        end
        this.goodsMaterial[i]:SetData(i,tempMaterial[i].id,tempMaterial[i].count,0.65)
    end
    if length < #this.goodsMaterial then
        for i = length + 1, #this.goodsMaterial do
            this.goodsMaterial[i]:Hide()
        end
    end
    if this.curStatus == this.statusEnum.UpRare then
        this.vm.data.materialListPos = Vector2(0,-197.5)
    elseif this.curStatus == this.statusEnum.LockOrnament then
        this.vm.data.materialListPos = Vector2(0,-157)
    elseif this.curStatus == this.statusEnum.UnLockOrnament then
        this.vm.data.materialListPos = Vector2(-6.5,-180)
    end
    this.vm.data.materialRoot = true
end

this.SetAttrList = function(isFx)
    if this.curStatus == this.statusEnum.LockOrnament then
        this.vm.data.attrRoot = false
        return
    end
    local attrName,attrValue,attrType,iconName = nil,nil,nil,nil
    local beforeAttrs = {}
    local afterAttrs = {}
    local tempRare = this.characterRare >= 5 and 4 or this.characterRare
    local brilliantKey = this.characterId..tempRare
    local brilliant = ConfigMgr.Config.BrilliantMap[brilliantKey]
    if TableIsNull(brilliant) or TableIsNull(brilliant.PropertyUp) then
        return
    end
    local propertyLevel = 0
    if type(this.characterData.brilliant) ~= "function" then
        propertyLevel = this.characterData.brilliant.PropertyLevel
    end
    local key = propertyLevel == 0 and 1 or propertyLevel + 1
    for i = 1, #brilliant.PropertyUp[key] do
        attrName,attrValue,attrType,iconName = ConfigHelper.GetAttrNameStr(brilliant.PropertyUp[key][i])
        this.tableInsert(beforeAttrs,{name = attrName,value = tonumber(attrValue),type = attrType,icon = iconName})
    end
    if this.isOrnamentUp and propertyLevel < this.ornamentMax then
        key = key + 1
        for i = 1, #brilliant.PropertyUp[key] do
            attrName,attrValue,attrType,iconName = ConfigHelper.GetAttrNameStr(brilliant.PropertyUp[key][i])
            this.tableInsert(afterAttrs,{name = attrName,value = tonumber(attrValue),type = attrType,icon = iconName})
        end
    end

    local tempList,tempItem = {},{}




    local attrIconName = ""
    for i = 1, #beforeAttrs do









        attrIconName=beforeAttrs[i].icon~=nil and beforeAttrs[i].icon or "";
        tempItem = {
            attrIcon = LuaMgr.GetSprite("AttributeIcon",attrIconName),
            attrName = LuaMgr.GetLangText(beforeAttrs[i].name),
            beforeValue = TableIsNull(afterAttrs) and "" or beforeAttrs[i].value..beforeAttrs[i].type,
            afterValue = TableIsNull(afterAttrs) and beforeAttrs[i].value..beforeAttrs[i].type or 
                    this.strFormat(this.attrColor,afterAttrs[i].value..afterAttrs[i].type),
            isShowBefore = not TableIsNull(afterAttrs),
            isVfx=isFx~=nil;
        }
        this.tableInsert(tempList,tempItem)
    end
    this.vm.data.attrList = tempList
    if this.curStatus == this.statusEnum.UpRare then
        this.vm.data.attrListPos = Vector2(0,-58)
    elseif this.curStatus == this.statusEnum.UnLockOrnament then

        this.vm.data.attrListPos = Vector2(-665.3,-143)
    end
    this.vm.data.attrRoot = true
end

this.OrnamentBuff = function(brilliant)
    if TableIsNull(brilliant) or TableIsNull(brilliant.Buff) then return end





    this.vm.data.skillIntro = LuaMgr.GetPassiveSkillBuffDescList(this.characterId ,brilliant.Buff[1],brilliant.Level)
end


this.OrnamentSkill = function(brilliant)
    
end

this.OpenPreview = function()
    this.isPreview = true
    this.characterRare = 5
    this.curStatus = this.statusEnum.UnLockOrnament
    this.SetUnlockOrnamentRoot()
    this.SetAttrList()
    this.vm.data.materialRoot = false
    this.vm.data.confirmBtnRoot = false
    this.vm.data.noConfirmBtnRoot = false
    this.vm.data.lockOrnamentRoot = false
    this.vm.data.unLockOrnament = true
    this.vm.data.bodyRoot = false
    this.vm.data.consume = false
end

this.ClosePreview = function()
    this.characterRare = HeroMgr.GetHeroNowRare(this.characterId)
    if not this.isCondition then

        this.characterRare = CharacterRare.SSR
    end
    this.SetStatus()
    this.vm.data.bodyRoot = true
end

this.SendConfirm = function()
    if this.canUpRareBool == false then
        return
    end
    local tipStr = ""
    if this.curStatus == this.statusEnum.LockOrnament then
        tipStr = ConfigMgr.LangGlobal("22619")
    elseif this.curStatus == this.statusEnum.UpRare then
        tipStr = ConfigMgr.LangGlobal("22624")
    end
    LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, tipStr, function()
        local tempData = {}
        tempData["CharacterId"] = this.characterId
        ApiMgr.Request("brilliant/rare_up", tempData,true,function(result)
            local re = json.decode(result)
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/hightea_levelup.mp3");
            if re.code == 0 then
                this.characterData = DataMgr.Player.characters[this.characterId]
                this.characterRare = HeroMgr.GetHeroNowRare(this.characterId)
                if this.curStatus == this.statusEnum.LockOrnament then
                    this.vm.data.bodyRoot=false;
                    this.vm.data.unLockTip = true
                    this.OpenUnLockPopup()
                    NumTool.DelayHandler(function()
                        this.vm.data.unLockTip = false;
                    end,1.2);
                elseif this.curStatus == this.statusEnum.UpRare then
                    this.OpenUnLevelPopup()
                end
            end
        end,nil,true)
    end,nil)
end

this.SendUpLevelConfirm = function()
    if this.canUpRareBool == false then
        local tips = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10204"].NameLan)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tips)
        return
    end
    local tempData = {}
    tempData["CharacterId"] = this.characterId
    ApiMgr.Request("brilliant/property_up", tempData,true,function(result)
        local re = json.decode(result)
        if re.code == 0 then
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/Foundation_levelup_1.mp3");
            this.vm.data.upLevelVFX01=false;
            this.vm.data.upLevelVFX01=true;
            this.characterData = DataMgr.Player.characters[this.characterId]
            this.SetUnlockOrnamentRoot()
            this.SetAttrList()
            local propertyLevel = 0
            if type(this.characterData.brilliant) ~= "function" then
                propertyLevel = this.characterData.brilliant.PropertyLevel
            end
            this.SetMaterial(propertyLevel + 1)
        end
    end,nil,true)
end

this.OpenUnLockPopup = function()
    local tempRare = this.characterRare >= 5 and 4 or this.characterRare
    local brilliantKey = this.characterId..tempRare
    local brilliant = ConfigMgr.Config.BrilliantMap[brilliantKey]
    if TableIsNull(brilliant) then return end
    this.vm.data.goodsIntro = LuaMgr.GetLangText(brilliant.IconInfoLan)
    this.vm.data.unlockPopupRoot = true
    this.vm.data.unLockOrnament = false
end

this.OpenUnLevelPopup = function()
    this.SetTags()
    if #this.vm.data.attrList > 0 then
        local tempItem = nil
        local tempList = {}
        for i = 1, #this.vm.data.attrList do
            tempItem = {
                attrIcon = this.vm.data.attrList[i].attrIcon,
                attrName = this.vm.data.attrList[i].attrName,
                attrValue = "+"..this.vm.data.attrList[i].afterValue}
            this.tableInsert(tempList,tempItem)
        end
        this.vm.data.upLevelAttrList = tempList
    end
    local tempRare = this.characterRare - 1
    local iconName = tempRare.."_di"
    local iconSprite = LuaMgr.GetSprite("HuanZhangRare",iconName)
    this.vm.data.rareDi = iconSprite
    
    iconName = tempRare.."_di_1"
    iconSprite = LuaMgr.GetSprite("HuanZhangRare",iconName)
    this.vm.data.rareDi_1 = iconSprite
    
    iconName = tempRare
    iconSprite = LuaMgr.GetSprite("HuanZhangRare",iconName)
    this.vm.data.rare = iconSprite
    
    iconName = "job_"..this.characterConfig.job.."_"..tempRare
    iconSprite = LuaMgr.GetSprite("HuanZhangRare",iconName)
    this.vm.data.jobRare = iconSprite
    
    iconName = "job_"..this.characterConfig.job
    iconSprite = LuaMgr.GetSprite("HuanZhangRare",iconName)
    this.vm.data.jobIcon = iconSprite
    
    if this.coroutine_key ~= nil then
        coroutine_runner.stop(this.coroutine_key)
    end
    this.coroutine_key = coroutine_runner.start(function()
        this.isClick = false
        this.vm.data.UpLevelTip = true
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/Character_StarUp.mp3");
        iconName = this.characterRare.."_di"
        local diSprite = LuaMgr.GetSprite("HuanZhangRare",iconName)
        iconName = this.characterRare.."_di_1"
        local diSprite_1 = LuaMgr.GetSprite("HuanZhangRare",iconName)
        iconName = tempRare.."_"..this.characterRare
        local rareSprite = LuaMgr.GetSprite("HuanZhangRare",iconName)
        coroutine_runner.wait(0.8)
        this.vm.data.rareDi = diSprite
        this.vm.data.rareDi_1 = diSprite_1
        this.vm.data.rare = rareSprite
        coroutine_runner.wait(0.7)
        rareSprite = LuaMgr.GetSprite("HuanZhangRare",tostring(this.characterRare))
        iconName = "job_"..this.characterConfig.job.."_"..tostring(this.characterRare)
        iconSprite = LuaMgr.GetSprite("HuanZhangRare",iconName)
        this.vm.data.rareEffectR = this.characterRare == CharacterRare.SR
        this.vm.data.rareEffectSR = this.characterRare == CharacterRare.SSR
        coroutine_runner.wait(0.2)
        this.vm.data.rare = rareSprite
        this.vm.data.jobRare = iconSprite
        coroutine_runner.wait(0.8)
        this.isClick = true
    end)
    this.SetStatus()
end

this.GetHeroAttrKey = function(param)
    local attrKey = {}
    for i = 1, #param do
        table.insert(attrKey,param[i].id)
    end
    return attrKey
end

this.GetHeroRareStr = function(rare)
    if rare == 2 then
        return LuaMgr.GetLangText("CardPoolProbabilityViewModel_2")
    elseif rare == 3 then
        return LuaMgr.GetLangText("CardPoolProbabilityViewModel_3")
    elseif rare == 4 then
        return LuaMgr.GetLangText("CardPoolProbabilityViewModel_4")
    end
end

this.ClearMaterial = function()
    if TableIsNull(this.goodsMaterial) then
        return
    end
    for i = 1, #this.goodsMaterial do
        this.goodsMaterial[i]:Clear()
    end
    this.goodsMaterial = nil
end

this.OnClickZY = function()
    LuaMgr.ShowLuaPanel("HeroOccupationViewModel")
end

this.UpdateMaterial = function()
    this.SetStatus()
end

return vm({
    data = data,
    command = command,
    hook = hook
})
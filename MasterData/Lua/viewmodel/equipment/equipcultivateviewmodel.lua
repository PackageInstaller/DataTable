





require("ViewModel/Equipment/EquipExchangeGroup")
require("ViewModel/Equipment/EquipExchangeItem")

local this = {
    vm = nil,
    opType = nil,
    equipData = nil,
    equipConfig = nil,
    expValue = 0.0,
    consumed = {},
    materialCost = {},
    currencyCost = 0,
    ToString = tostring,
    ToNumber = tonumber,
    TableInsert = table.insert,
    rColor = UnityEngine.Color(33 / 225, 155 / 225, 161 / 225, 1),
    srColor = UnityEngine.Color(216 / 225, 187 / 225, 70 / 225, 1),
    ssrColor = UnityEngine.Color(236 / 225, 56 / 225, 57 / 225, 1),
    nilColor = UnityEngine.Color(0, 0, 0, 0),
    equipPicPath = "Assets/_BundleResources/Images/ItemIcons_pic/itemicon_pic_",
    coroutine_key = nil,
    iconPath = "Assets/_BundleResources/Images/ItemIcons/itemicon_",
    nextLevelFormat = "LV <color=#089090>%d</color>",
    starLevelFormat = "LV <color=#EF5D22>%d</color>",
    coinEnough = "<color=#6AA5F1>%s</color>/%s",
    coinNotEnough = "<color=#FF0000>%s</color>/%s",
    TypeEnum = {level = 1, grade = 2, star = 3, refine = 4, exchange = 5},
    upCoin = 0,
    newAttrList = {},
    isAuto = false,
    isMaterial = false,
    isCanRefine = false,
    exchangeEquipList = nil,
    skillLevel = "LV <color=#D36B34>%d</color>",
    exchangeEquipGroup = 0,
    exchangeEquipIndex = 0,
    exchangeEquipSuccAnimName = "ani_EquipCultivatePanel_ExchangeView",
    exchangeEquipDetailAnimName = "ani_EquipCultivatePanel_EquipOpenDetail",
    exchangeEquipDetailAnimName1 = "ani_EquipCultivatePanel_EquipOpenDetail1",
    exchangeEquipListAnimName = "ani_EquipCultivatePanel_EquipOpenList",
}

local data = {
    rootAnimName = "",
    upLevel = false,
    upGrade = false,
    upStar = false,
    middleView = Vector2(460, 621),
    listView = false,
    refine = false,
    exchange = false,
    noneProp = Vector3.zero,
    equipView = false,
    name = "",
    rare = UnityEngine.Color(0, 0, 0, 0),
    equipPic = DefaultTexture,
    effectR = Vector3.zero,
    effectSR = Vector3.zero,
    effectSSR = Vector3.zero,
    effectUR = Vector3.zero,
    equip = false,
    details = false,
    equipRare = DefaultSprite,
    equipIcon = DefaultTexture,
    equipName = "",
    jobText = "",
    WearState = false,
    lockState = false,
    headIcon = DefaultTexture,
    expBar = Vector3.zero,
    lineBar = 0.0,
    previewBar = 0.0,
    nowLevelText = "",
    nextLevel = Vector3.zero,
    nextLevelText = "",
    lackExp = "",
    addAttrTip = false,
    attrTipText = "",
    litreAttrTip = false,
    literTipText = "",
    nowSkillName = "",
    nowSkillLevel = "",
    nowSkillIntro = "",
    nextSkillName = "",
    nextSkillLevel = "",
    nextSkillIntro = "",
    nowLevel = "",
    gradeLevel = "",
    urColor = false,
    maxTipHide = Vector3.zero,
    maxTipText = "",
    materialHide = false,
    consumeHide = Vector3.zero,
    consumeWidth = Vector2(330, 28),

    consumeText = "",
    isLockStarLevel = false,
    isLockRefine = false,
    isLockReplace = false,
    refineLabelText = "",
    replaceLabelText = "",

    lockAttrText = "",
    formerNull = "",
    former = "",
    newNull = "",
    newText = "",
    refineName = "",
    refineBtnText = "",
    lockAttrBtnColor = UnityEngine.Color(1, 1, 1, 1),
    formerNullObj = false,
    formerAttrObj = false,
    newNullObj = false,
    newAttrObj = false,
    refineRoot = false,
    resultRoot = false,
    autoRefine = false,
    autoText = "",
    refineBtn = false,
    restoreBtnText = "",
    saveBtnText = "",
    stopBtn = false,
    stopBtnText = "",
    refineViewAnim = "",
    isAutoObj = false,
    notRefineBtn = false,
    typeList = {{typeIndex = 1, select = false}, {typeIndex = 3, select = false}, {typeIndex = 4, select = false}, {typeIndex = 5, select = false}},
    starList = {{rStar = false}, {rStar = false}, {rStar = false}, {rStar = false}, {rStar = false}, {rStar = false}},
    middleList = {
        {
            rare = DefaultSprite,
            icon = DefaultTexture,
            level = "",
            star = Vector3.zero,
            star0 = false,
            star1 = false,
            star2 = false,
            star3 = false,
            star4 = false,
            star5 = false,
            select = Vector3.zero,
            num = "",
            count = Vector3.zero,
            countText = ""
        }
    },
    basisAttr = {
        {attrIcon = DefaultSprite, attrName = "", attrValue = "", next = Vector3.zero, nextValue = "", curr = Vector3.zero, maxValue = ""},
        {attrIcon = DefaultSprite, attrName = "", attrValue = "", next = Vector3.zero, nextValue = "", curr = Vector3.zero, maxValue = ""}
    },
    subjoinAttr = {{attrIcon = DefaultSprite, attrName = "", attrValue = "", attrLock = false}},
    levelMaterial = {
        {material = Vector3.zero, mRare = DefaultSprite, mIcon = DefaultTexture, mCount = ""},
        {material = Vector3.zero, mRare = DefaultSprite, mIcon = DefaultTexture, mCount = ""},
        {material = Vector3.zero, mRare = DefaultSprite, mIcon = DefaultTexture, mCount = ""},
        {material = Vector3.zero, mRare = DefaultSprite, mIcon = DefaultTexture, mCount = ""},
        {material = Vector3.zero, mRare = DefaultSprite, mIcon = DefaultTexture, mCount = ""}
    },
    materialList = {{materialRare = DefaultSprite, materialIcon = DefaultTexture, materialCount = ""}},
    refineMaterial = {{rRare = DefaultSprite, rIcon = DefaultTexture, rCount = ""}},
    formerAttrList = {{former = false, lock = false, attrName = "", attrValue = "", attrIcon = DefaultSprite}},
    afterAttrList = {{after = false, lock = false, attrName = "", attrValue = "", attrIcon = DefaultSprite, attrEffect = false}},


    oldExchangeEquipName = "",
    oldExchangeStar = {{rStar = false}, {rStar = false}, {rStar = false}, {rStar = false}, {rStar = false}, {rStar = false}},
    newExchangeEquipName = "",
    newExchangeEquipIcon = DefaultTexture,
    newExchangeStar = {{rStar = false}, {rStar = false}, {rStar = false}, {rStar = false}, {rStar = false}, {rStar = false}},
    showEquipDetailArrow = false,
    showExchangeEquipList = false,
    showEquipDetail = false,
    exchangeEquipNull = false,
    choosedEquip = false,
    exchangeEquipIsLock = false,
    equipDetailMask = false,
    exchangeSuccEffect = false,
    exchangeOperateMask = false,
    equipDetailPos = Vector2.zero,
    equipEffectPos = {Vector3.zero, Vector3.zero, Vector3.zero, Vector3.zero},
    exchangeEquipList = {},
    exchangeMaterial = {{rRare = DefaultSprite, rIcon = DefaultTexture, rCount = ""}},
    equipDetailsData = {
        wRare = DefaultSprite,
        wIcon = DefaultTexture,
        wLevel = "",
        wStar0 = false,
        wStar1 = false,
        wStar2 = false,
        wStar3 = false,
        wStar4 = false,
        wStar5 = false,
        wName = "",
        wJob = "",
        wExpBar = 0.0,
        wExpText = "",
        wtipObj = Vector3.zero,
        wWearState = false,
        wHeadIcon = DefaultTexture,
        wLockState = false,
        wBasisAttr = {{}},
        wSubjoinAttr = {{}},
        wSkillName = "",
        wSkillLevel = "",
        wSkillIntro = ""
    },

    equipEffectShow = true
}

local command = {
    upgradeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.isAuto then
                local tipStr = ConfigMgr.LangGlobal("16127")
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr)
                return
            end
            if this.equipData.level == this.equipData.limitedLevel then
                this.opType = this.TypeEnum.grade
            else
                this.opType = this.TypeEnum.level
            end
            this.UpdateView()
        end
    },
    starLevelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if FeatureManager.IsLock("1027") then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1027"))
                return
            end
            if this.isAuto then
                local tipStr = ConfigMgr.LangGlobal("16127")
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr)
                return
            end
            this.opType = this.TypeEnum.star
            this.UpdateView()
        end
    },
    refineCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if FeatureManager.IsLock("1027") then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1027"))
                return
            end
            this.opType = this.TypeEnum.refine
            this.UpdateView()
        end
    },
    replaceCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            PlayerBackpackMgr.ResetSift()
            this.opType = this.TypeEnum.exchange
            this.chooseEquipData = nil
            this.UpdateView()
        end
    },
    pressCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = param + 1
            LuaMgr.AddTimer(
                TimerConst.EquipMaterialClick,
                function()
                    this.AddMaterial(index)
                end,
                0.1,
                10000,
                true
            )
        end
    },
    liftUpCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.RemoveTimer(TimerConst.EquipMaterialClick)
        end
    },
    materialCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = param + 1
            this.AddMaterial(index)
        end
    },
    subtractCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = param + 1
            this.SubtractMaterial(index, true)
        end
    },
    nullCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = this.ToNumber(param)
            this.SubtractMaterial(index, false)
        end
    },
    emptyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.EmptyMaterial()
        end
    },
    fastSelectCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.FastSelectMaterial()
        end
    },
    levelBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.WhetherHaveTmpAdditionalAttrs() then
                this.SendLevelUp()
            end
        end
    },
    autoLevelBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.WhetherHaveTmpAdditionalAttrs() then
                local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["23910"].NameLan)
                LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,tipStr,this.SendAutoLevelUp,nil)
            end
        end
    },
    gradeBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.WhetherHaveTmpAdditionalAttrs() then
                this.SendGradeUp()
            end
        end
    },
    starBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.WhetherHaveTmpAdditionalAttrs() then
                this.SendStarUp()
            end
        end
    },
    autoStarBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.WhetherHaveTmpAdditionalAttrs() then
                local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["23911"].NameLan)
                LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,tipStr,this.SendAutoStarUp,nil)
            end
        end
    },
    popupCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param) + 1
            local goodsId = this.vm.data.materialList[index].materialID
            local needCount = this.vm.data.materialList[index].needCount
            local materialHaveCount = this.vm.data.materialList[index].materialHaveCount
            if needCount > materialHaveCount then
                HeroParameter.SaveTarItem(goodsId, needCount - materialHaveCount)
            end
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, goodsId, true, true, true, 0, needCount)
        end
    },
    refineMaterialCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param) + 1
            this.LookMaterialInfo(this.TypeEnum.refine, index)
        end
    },
    refineConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not this.isCanRefine then
                return
            end
            if TableIsNull(this.equipData.additionalAttrs) then
                local tipStr = ConfigMgr.LangGlobal("16133")
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr)
                return
            end
            if this.GetCanRefineAttrCount() <= 0 then
                local tipStr = ConfigMgr.LangGlobal("16141")
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr)
                return
            end
            if not this.isMaterial then
                local tipStr = ConfigMgr.LangGlobal("16109")
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr)
                return
            end
            this.ConfirmRefine()
        end
    },
    restoreCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SendRestoreAttr(false)
        end
    },
    saveCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SendRestoreAttr(true)
        end
    },
    lockAttrCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local tipStr = ""
            if this.isAuto then
                tipStr = ConfigMgr.LangGlobal("16127")
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr)
                return
            end
            if type(this.equipData.tmpAdditionalAttrs) ~= "function" and not TableIsNull(this.equipData.tmpAdditionalAttrs) then
                tipStr = ConfigMgr.LangGlobal("16132")
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr)
                return
            end
            if TableIsNull(this.equipData.additionalAttrs) then
                tipStr = ConfigMgr.LangGlobal("16133")
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr)
                return
            end
            LuaMgr.ShowLuaPanel(UIName.EquipAttrLockPopup, this.equipData.id)
        end
    },
    attrPreviewCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.EquipAttrPreviewPopup, this.equipData.id)
        end
    },
    stopCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.isAuto = false
            HeroParameter.EmptyAttrTarget()
            this.CreateCostMaterial(this.TypeEnum.refine)
            if this.coroutine_key ~= nil then
                coroutine_runner.stop(this.coroutine_key)
            end
            this.SetRefineState()
            this.vm.data.autoRefine = this.isAuto
            this.vm.data.stopBtn = this.isAuto
            this.vm.data.refineBtn = not this.isAuto
        end
    },
    autoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.isAuto then
                local tipStr = ConfigMgr.LangGlobal("16127")
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr)
                return
            end
            if TableIsNull(this.equipData.additionalAttrs) then
                local tipStr = ConfigMgr.LangGlobal("16133")
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr)
                return
            end
            if this.GetCanRefineAttrCount() <= 0 then
                local tipStr = ConfigMgr.LangGlobal("16141")
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr)
                return
            end
            LuaMgr.ShowLuaPanel(UIName.EquipTargetAttrPopup, this.equipData.id, this.StartAutoRefineAttr)
        end
    },
    exchangeOpenListCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.GetEquipConfig()
        end

    },
    exchangeChooseCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.equipDetailMask = false
            this.OnChooseNewEquip()
        end
    },
    exchangeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.WhetherHaveTmpAdditionalAttrs() then
                this.ClickExchangeBtn()
            end
        end
    },
    exchangeMaterialCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param) + 1
            this.LookMaterialInfo(this.TypeEnum.exchange, index)
        end
    },
    siftCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.EquipSiftPopup, true)
        end
    },
    lockCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.exchangeEquipIsLock = not this.exchangeEquipIsLock
            this.vm.data.exchangeEquipIsLock = this.exchangeEquipIsLock
            this.UpdateEquipSift()
        end
    },
    unlockSelectEquip = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.UnlockChooseEquip()
        end
    },
    lookLeftEquipCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.showExchangeEquipList = false
            this.SetChooseEquipAttr(true)
        end
    },
    closeEquipListAndDetail = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.equipDetailMask = false
            this.vm.data.equipEffectShow = true
            this.vm.data.showEquipDetailArrow = false
            this.vm.data.showExchangeEquipList = false
            this.vm.data.showEquipDetail = false
            this.exchangeChoosedEquip = nil
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.InitView()
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.vm.data.rootAnimName = "UI_EquipCultivatePanel_01"
        this.ViewAdaptive()
        this.SetLanguageText()
        this.InitParameter()
        this.UpdateView()
        this.AddUIEveneListener()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        if this.coroutine_key ~= nil then
            coroutine_runner.stop(this.coroutine_key)
        end
        HeroParameter.EmptyAttrTarget()
        this.RemoveUIEventListener()
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("EquipExchangeGroup")
        this.vm.data.refineMaterial = {}
        this.vm.data.exchangeMaterial = {}
        this = nil
    end
}


this.InitView = function()
    this.exchangeEquipList = UIScrollView.New(this.vm.behaviour.transform:Find("root/Middle/ExchangeView/EquipCloseMask/EquipListGroup/ScrollView").gameObject)
    this.itemTemplate = this.vm.behaviour.transform:Find("template/ExchangeEquipItem").gameObject
    this.groupTemplate = this.vm.behaviour.transform:Find("template/ExchangeEquipGroup").gameObject
    this.animExchangeView = this.vm.behaviour.transform:Find("root/Middle/ExchangeView").gameObject:GetComponent(UITool.Animator)
    this.animExchangeEquipMask = this.vm.behaviour.transform:Find("root/Middle/ExchangeView/EquipCloseMask").gameObject:GetComponent(UITool.Animator)
end


this.ViewAdaptive = function()
    local addWidth = LuaMgr.GetScreenAddWidth()
    local width = 460 + addWidth
    this.vm.data.middleView = Vector2(width, 621)
end
this.AddUIEveneListener = function()
    LuaMgr.AddUIEventListener(UIEventConst.PropUse, this.UpdateMaterial)
    LuaMgr.AddUIEventListener(UIEventConst.EquipAttrLockEvent, this.UpdateAttrLock)
    LuaMgr.AddUIEventListener(UIEventConst.EquipWearClick, this.SelectEquipItem)
    LuaMgr.AddUIEventListener(UIEventConst.EquipSiftConfirmClick, this.UpdateEquipSift)
end
this.RemoveUIEventListener = function()
    LuaMgr.RemoveTimer(TimerConst.EquipRefineUpdateAnim)
    LuaMgr.RemoveUIEventListener(UIEventConst.PropUse, this.UpdateMaterial)
    LuaMgr.RemoveUIEventListener(UIEventConst.EquipAttrLockEvent, this.UpdateAttrLock)
    LuaMgr.RemoveUIEventListener(UIEventConst.EquipWearClick, this.SelectEquipItem)
    LuaMgr.RemoveUIEventListener(UIEventConst.EquipSiftConfirmClick, this.UpdateEquipSift)
end

this.InitParameter = function()
    if this.vm.behaviour.Params.Length <= 0 then
        return
    end
    local equipId = this.vm.behaviour.Params[0]
    PlayerBackpackMgr.equipPositioningId = equipId
    this.equipData = DataMgr.Player.equipments[equipId]
    if this.equipData ~= nil then
        if type(this.equipData.additionalAttrs) == "function" then
            this.equipData.additionalAttrs = nil
        end
        this.equipConfig = ConfigMgr.Config.equipments[this.equipData.equipmentId]
        if this.equipData.level == this.equipData.limitedLevel then
            this.opType = this.TypeEnum.grade
        else
            this.opType = this.TypeEnum.level
        end
    end
    this.upCoin = 0
    if this.equipConfig.rare == 2 then
        this.upCoin = ConfigMgr.Config.constants.REquipLevelUpCoin
    elseif this.equipConfig.rare == 3 then
        this.upCoin = ConfigMgr.Config.constants.SREquipLevelUpCoin
    elseif this.equipConfig.rare == 4 then
        this.upCoin = ConfigMgr.Config.constants.SSREquipLevelUpCoin
    elseif this.equipConfig.rare == 5 then
        this.upCoin = ConfigMgr.Config.constants.UREquipLevelUpCoin
    end
    this.EffectRestore()
    this.vm.data.refineLabelText = ConfigMgr.LangGlobal("16117")
    this.vm.data.isLockStarLevel = FeatureManager.IsLock("1027")
    this.vm.data.isLockRefine = FeatureManager.IsLock("1027")
    this.vm.data.replaceLabelText = ConfigMgr.LangGlobal("22902")
end


this.UpdateView = function()
    this.isAuto = false
    this.vm.data.equipEffectShow = true
    this.vm.data.exchangeOperateMask = false
    if this.opType == this.TypeEnum.level then
        this.InitConsume()
        this.consumed = {}
        this.InitEquipList()
        this.UpdateLevelView()
        this.EffectRestore()
    elseif this.opType == this.TypeEnum.grade then
        this.InitConsume()
        this.materialCost = {}
        this.UpdateMiddleView()
        this.UpdateGradeView()
    elseif this.opType == this.TypeEnum.star then
        this.InitConsume()
        this.materialCost = {}
        this.UpdateMiddleView()
        this.UpdateStarView()
    elseif this.opType == this.TypeEnum.refine then
        this.isCanRefine = true
        this.materialCost = {}
        this.UpdateMiddleView()
        this.UpdateRefineView()
        this.vm.data.refineViewAnim = "ani_EquipCultivatePanel_RefineView_root"
    elseif this.opType == this.TypeEnum.exchange then
        this.vm.data.choosedEquip = false
        this.vm.data.exchangeSuccEffect = false
        this.UpdateMiddleView()
        this.UpdateExchange()
    end

    this.vm.data.typeList[1].select = this.opType == this.TypeEnum.level or this.opType == this.TypeEnum.grade
    this.vm.data.typeList[2].select = this.opType == this.TypeEnum.star
    this.vm.data.typeList[3].select = this.opType == this.TypeEnum.refine
    this.vm.data.typeList[4].select = this.opType == this.TypeEnum.exchange

    this.vm.data.listView = this.opType == this.TypeEnum.level
    this.vm.data.equipView = this.opType == this.TypeEnum.star or this.opType == this.TypeEnum.grade
    this.vm.data.refine = this.opType == this.TypeEnum.refine
    this.vm.data.exchange = this.opType == this.TypeEnum.exchange

    this.vm.data.details = this.opType ~= this.TypeEnum.refine and this.opType ~= this.TypeEnum.exchange
    this.vm.data.equip = this.opType == this.TypeEnum.level or this.opType == this.TypeEnum.grade
    this.vm.data.upLevel = this.opType == this.TypeEnum.level
    this.vm.data.upGrade = this.opType == this.TypeEnum.grade
    this.vm.data.upStar = this.opType == this.TypeEnum.star
    this.vm.data.consumeWidth = this.opType == this.TypeEnum.level and Vector2(330, 28) or Vector2(195, 28)
end

this.EffectRestore = function()
    this.vm.data.effectR = Vector3(3000, 0)
    this.vm.data.effectSR = Vector3(3000, 0)
    this.vm.data.effectSSR = Vector3(3000, 0)
    this.vm.data.effectUR = Vector3(3000, 0)
end


this.InitConsume = function()

    if TableIsNull(this.equipData) or this.equipData.star == nil then
        return
    end
    local hide
    if this.opType == this.TypeEnum.grade then
        local levelMax = ConfigHelper.GetTableLength(ConfigMgr.Config.equipmentLevelUp[this.ToString(this.equipConfig.rare)])
        hide = this.equipData.level == levelMax
        if hide then
            this.vm.data.maxTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2141"].NameLan)
        end
    elseif this.opType == this.TypeEnum.star then
        hide = this.equipData.star == ConfigMgr.Config.constants.maxStar
        if hide then
            this.vm.data.maxTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2142"].NameLan)
        end
    end
    this.vm.data.consumeText = "0"
    this.vm.data.consumeHide = hide and Vector3.zero or Vector3.one
    this.vm.data.maxTipHide = hide and Vector3.one or Vector3.zero
end


this.UpdateConsume = function()
    this.currencyCost = math.floor(this.currencyCost)
    if DataHelper.GetItemCountById("3") < this.currencyCost then
        local strCost = string.format("<color=#FF0000>%d</color>", this.currencyCost)
        this.vm.data.consumeText = strCost
    else
        this.vm.data.consumeText = this.ToString(this.currencyCost)
    end
end


this.InitEquipList = function()
    ConfigHelper.ExpGoodsDes()
    local tempList = {}
    local itemConfig = nil

    for _, v in ipairs(ConfigHelper.ExpDes) do
        if DataHelper.GetItemCountById(v.ID) ~= 0 then
            itemConfig = ConfigMgr.Config.itemMap[v.ID]
            local tempItem = {
                rare = LuaMgr.GetSprite("ItemRare", "itemRare" .. itemConfig.rare),
                num = "",
                icon = LuaMgr.GetTexture(this.iconPath .. v.ID .. ".png"),
                level = "",
                star = Vector3.zero,
                select = Vector3.zero,
                count = Vector3.one,
                countText = this.ToString(DataMgr.Player.items[v.ID].count0),
                type = 1,
                rareInt = itemConfig.rare,
                starInt = 0,
                levelInt = 0,
                id = v.ID,
                onlyId = v.ID
            }
            this.TableInsert(tempList, tempItem)
        end
    end
    table.sort(tempList, this.ListSort)
    this.vm.data.middleList = tempList
    this.vm.data.noneProp = next(tempList) == nil and Vector3.one or Vector3.zero
end


this.UpdateMiddleView = function()
    if this.equipConfig == nil then
        return
    end
    this.vm.data.equipEffectShow = true
    this.vm.data.showEquipDetailArrow = false
    this.vm.data.showExchangeEquipList = false
    this.vm.data.showEquipDetail = false
    this.exchangeChoosedEquip = nil
    this.vm.data.name = LuaMgr.GetLangText(this.equipConfig.NameLan)
    local localPos = Vector3.zero
    if this.opType == this.TypeEnum.refine then
        localPos = Vector3(119, 54, 0)
    elseif this.opType == this.TypeEnum.exchange then
        localPos = Vector3(-139, 54, 0)
    else
        localPos = Vector3(-127, -13, 0)
    end
    if this.equipConfig.rare == 2 then
        this.vm.data.rare = this.rColor
        this.vm.data.effectR = localPos
    elseif this.equipConfig.rare == 3 then
        this.vm.data.rare = this.srColor
        this.vm.data.effectSR = localPos
    elseif this.equipConfig.rare == 4 then
        this.vm.data.rare = this.ssrColor
        this.vm.data.effectSSR = localPos
    else
        this.vm.data.rare = this.nilColor
        this.vm.data.effectUR = localPos
    end
    this.vm.data.urColor = this.equipConfig.rare == 5
    local starNum = 1
    if this.equipData ~=nil then
        starNum = this.equipData.star
    end
    for i = 1, 6 do
        this.vm.data.starList[i].rStar = i <= starNum
        this.vm.data.oldExchangeStar[i].rStar = i <= starNum
    end
    this.vm.data.equipPic = LuaMgr.GetTexture(this.equipPicPath .. this.equipConfig.id .. ".png")
end


this.UpdateLevelView = function()
    this.vm.data.materialHide = false
    this.UpdateDetailsData()
    this.InitExpBar()
    this.InitEquipAttr()
    this.UpdateUpLevelMaterial()
end


this.UpdateGradeView = function()
    this.UpdateDetailsData()
    this.InitEquipAttr()
    local maxLevel = ConfigHelper.GetTableLength(ConfigMgr.Config.equipmentLevelUp[this.ToString(this.equipConfig.rare)])
    local isMaxLevel = this.equipData.limitedLevel == maxLevel
    local limitedLevel = 0
    if isMaxLevel then
        limitedLevel = maxLevel
    else
        local grade = this.equipData.grade + 1
        local tempMaterial = ConfigMgr.Config.equipmentGradeUps[this.equipConfig.id][this.ToString(grade)].res
        this.CreateMaterial(tempMaterial)
        this.currencyCost = ConfigMgr.Config.equipmentGradeUps[this.equipConfig.id][this.ToString(grade)].coin
        this.UpdateConsume()

        limitedLevel = ConfigMgr.Config.equipmentGradeUps[this.equipConfig.id][this.ToString(grade)].limitedLevel
        local tempData = table.Copy(this.equipData)
        tempData.grade = grade
        this.AttrsPreview(tempData)
    end
    this.vm.data.materialHide = not isMaxLevel
    this.vm.data.nowLevel = string.format("%d/%d", this.equipData.limitedLevel, this.equipData.limitedLevel)
    this.vm.data.gradeLevel = string.format("%d/%d", this.equipData.limitedLevel, limitedLevel)
end


this.UpdateStarView = function()
    if this.equipConfig == nil then
        return
    end
    if #this.equipConfig.equipSkill > 0 then
        local skill = ConfigMgr.Config.equipmentSkills[this.equipConfig.equipSkill[1]][this.ToString(this.equipData.star)]
        local isMaxLevel = this.equipData.star == ConfigMgr.Config.constants.maxStar
        this.vm.data.nowSkillName = LuaMgr.GetLangText(skill.NameLan)
        this.vm.data.nowSkillLevel = string.format(this.starLevelFormat, this.equipData.star)
        this.vm.data.nowSkillIntro = LuaMgr.GetEquipSkillText(this.equipData.equipmentId, this.equipData.star)
        this.vm.data.materialHide = not isMaxLevel
        if not isMaxLevel then
            local starLevel = this.equipData.star + 1
            this.vm.data.nextSkillName = LuaMgr.GetLangText(skill.NameLan)
            this.vm.data.nextSkillLevel = string.format(this.starLevelFormat, starLevel)
            this.vm.data.nextSkillIntro = LuaMgr.GetEquipSkillText(this.equipData.equipmentId, starLevel)
            this.currencyCost = ConfigMgr.Config.equipmentStarUps[this.ToString(this.equipConfig.rare)][this.ToString(starLevel)].coin
            this.UpdateConsume()
            local tempMaterial = ConfigMgr.Config.equipmentStarUps[this.ToString(this.equipConfig.rare)][this.ToString(starLevel)].res
            this.CreateMaterial(tempMaterial)
        end
    end
end




this.UpdateRefineView = function()
    this.vm.data.refineName = LuaMgr.GetLangText(this.equipConfig.NameLan) .. "  LV." .. this.equipData.level
    this.vm.data.autoRefine = this.isAuto
    this.vm.data.stopBtn = this.isAuto
    this.vm.data.refineBtn = not this.isAuto
    this.vm.data.notRefineBtn = false
    this.vm.data.formerNullObj = TableIsNull(this.equipData.additionalAttrs)
    this.vm.data.formerAttrObj = not TableIsNull(this.equipData.additionalAttrs)
    this.vm.data.isAutoObj = ConfigMgr.Config.equipConstants.AutoSwitch == 1
    this.CreateRefineFormerAttr()
    this.CreateRefineAfterAttr()
    this.CreateCostMaterial(this.TypeEnum.refine)
end


this.CreateRefineFormerAttr = function()
    local tempList, tempItem = {}, nil
    local attrData = nil
    local iconSprite = nil
    local lockCount = 0
    if not TableIsNull(this.equipData.additionalAttrs) then
        attrData = this.GetEquipAttribute(this.equipData)
        this.vm.data.formerAttrList = {}
        for key, value in pairs(attrData) do
            if value.lock then
                lockCount = lockCount + 1
            end
            iconSprite = LuaMgr.GetSprite("AttributeIcon", value.key)
            tempItem = {former = not value.lock, lock = value.lock, attrName = value.name, attrValue = value.attrValue .. value.attrDisplayType, attrIcon = iconSprite}
            this.TableInsert(tempList, tempItem)
        end
        this.vm.data.formerAttrList = tempList
    end
    this.vm.data.lockAttrBtnColor = lockCount > 0 and UnityEngine.Color(1, 1, 1, 0.5) or UnityEngine.Color(1, 1, 1, 1)
    this.vm.data.lockAttrText = lockCount > 0 and ConfigMgr.LangGlobal("16131") or ConfigMgr.LangGlobal("16114")
end

this.CreateRefineAfterAttr = function()
    local tempList, tempItem = {}, nil
    local attrData = nil
    local iconSprite = nil
    this.newAttrList = type(this.equipData.tmpAdditionalAttrs) ~= "function" and this.equipData.tmpAdditionalAttrs or {}
    this.SetRefineState()
    if not TableIsNull(this.newAttrList) then
        local equip = table.Copy(this.equipData)
        equip.additionalAttrs = this.newAttrList
        attrData = this.GetEquipAttribute(equip)
        this.vm.data.afterAttrList = {}
        for key, value in pairs(attrData) do
            iconSprite = LuaMgr.GetSprite("AttributeIcon", value.key)
            tempItem = {
                after = not value.lock,
                lock = value.lock,
                attrName = value.name,
                attrValue = value.attrValue .. value.attrDisplayType,
                attrIcon = iconSprite,
                attrEffect = not value.lock
            }
            this.TableInsert(tempList, tempItem)
        end
        this.vm.data.afterAttrList = tempList
    end
end


this.GetEquipAttribute = function(equipData)
    local dataJson = json.encode(equipData)
    dataJson = LuaMgr.GetEquipPropertyCopy(dataJson)
    local equip = json.decode(dataJson)
    local attrList, config, attrItem, tempLock = {}, nil, nil, false
    for i = 1, #equipData.additionalAttrs do
        config = ConfigMgr.Config.additionalAttrs[equipData.additionalAttrs[i].id]
        attrItem = {
            key = config.addAttr,
            attrValue = equip[config.addAttr],
            id = config.id,
            name = LuaMgr.GetLangText(config.NameLan),
            attrDisplayType = config.attrDisplayType,
            lock = equipData.additionalAttrs[i].lock
        }
        this.TableInsert(attrList, attrItem)
    end
    return attrList
end


this.CreateCostMaterial = function(operateType)
    local tempData = nil
    local materialNode = nil
    if operateType == this.TypeEnum.refine then
        tempData = ConfigMgr.Config.equipConstants.WashingItem[1]
        materialNode = this.vm.data.refineMaterial
    elseif operateType == this.TypeEnum.exchange then
        tempData = ConfigMgr.Config.equipConstants.ExchangeItem[1]
        materialNode = this.vm.data.exchangeMaterial
    end
    if tempData == nil or materialNode == nil then
        return
    end
    this.isMaterial = true
    local tempList, tempItem = {}, nil
    local countStr = ""
    local itemConfig = ConfigMgr.Config.itemMap[tempData.id]
    local haveCount = DataHelper.GetItemCountById(itemConfig.id)
    if tempData.count > haveCount then
        this.isMaterial = false
        countStr = string.format(this.coinNotEnough, LuaMgr.NumFormat(haveCount), LuaMgr.NumFormat(tempData.count))
    else
        countStr = string.format(this.coinEnough, LuaMgr.NumFormat(haveCount), LuaMgr.NumFormat(tempData.count))
    end
    if materialNode[1].needCount == nil then
        tempItem = {
            rRare = ConfigHelper.GetRareSprite(itemConfig.rare),
            rIcon = ConfigHelper.GetItemTexture(tempData.id),
            rCount = countStr,
            materialID = tempData.id,
            materialHaveCount = haveCount,
            needCount = tempData.count
        }
        this.TableInsert(tempList, tempItem)

        if operateType == this.TypeEnum.refine then
            this.vm.data.refineMaterial = tempList
        elseif operateType == this.TypeEnum.exchange then
            this.vm.data.exchangeMaterial = tempList
        end
    else
        if operateType == this.TypeEnum.refine then
            this.vm.data.refineMaterial[1].rCount = countStr
            this.vm.data.refineMaterial[1].needCount = tempData.count
            this.vm.data.refineMaterial[1].materialHaveCount = haveCount
        elseif operateType == this.TypeEnum.exchange then
            this.vm.data.exchangeMaterial[1].rCount = countStr
            this.vm.data.exchangeMaterial[1].needCount = tempData.count
            this.vm.data.exchangeMaterial[1].materialHaveCount = haveCount
        end
    end
end

this.LookMaterialInfo = function(operateType, index)
    local nodeData = nil
    if operateType == this.TypeEnum.refine then
        nodeData = this.vm.data.refineMaterial
    elseif operateType == this.TypeEnum.exchange then
        nodeData = this.vm.data.exchangeMaterial
    end
    if nodeData == nil then
        return
    end
    local goodsId = nodeData[index].materialID
    local needCount = nodeData[index].needCount
    local materialHaveCount = nodeData[index].materialHaveCount

    if needCount > materialHaveCount and operateType == this.TypeEnum.refine then
        HeroParameter.SaveTarItem(goodsId, needCount - materialHaveCount)
    end
    LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, goodsId, true, true, true, 0, needCount)
end


this.StartAutoRefineAttr = function()
    this.isAuto = true
    this.vm.data.autoRefine = this.isAuto
    this.vm.data.stopBtn = this.isAuto
    this.vm.data.refineBtn = not this.isAuto
    if this.coroutine_key ~= nil then
        coroutine_runner.stop(this.coroutine_key)
    end
    this.coroutine_key =
        coroutine_runner.start(
        function()
            while (true) do
                if not this.isMaterial then
                    command.stopCommand.execute()
                    local tipStr = ConfigMgr.LangGlobal("16109")
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr)
                    return
                end
                this.ConfirmRefine()
                coroutine_runner.wait(5)
            end
        end
    )
end


this.AutoRefineAttrAchieved = function()
    if this.isAuto then
        if this.TargetAchieved() then
            command.stopCommand.execute()
            local tipStr = ConfigMgr.LangGlobal("16142")
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr)
        end
    end
end


this.ConfirmRefine = function()
    this.isCanRefine = false
    this.vm.data.notRefineBtn = true
    local tempData = {}
    tempData["id"] = this.equipData.id
    ApiMgr.Request(
        "equipment/attr/washing",
        tempData,
        true,
        function(result)
            local re = json.decode(result)
            if re.code == 0 then
                this.equipData = DataMgr.Player.equipments[this.equipData.id]
                if type(this.equipData.additionalAttrs) == "function" then
                    this.equipData.additionalAttrs = nil
                end
                AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/friendship_levelup.mp3")
                this.vm.data.refineViewAnim = "ani_EquipCultivatePanel_RefineView_change"
                LuaMgr.AddTimer(
                    TimerConst.EquipRefineUpdateAnim,
                    function()
                        LuaMgr.RemoveTimer(TimerConst.EquipRefineUpdateAnim)
                        this.CreateRefineAfterAttr()
                        this.CreateCostMaterial(this.TypeEnum.refine)
                        this.AutoRefineAttrAchieved()
                        this.isCanRefine = true
                    end,
                    1,
                    1,
                    false
                )
            end
        end,
        nil,
        true
    )
end

this.TargetAchieved = function()
    local count = 0
    for i = 1, #this.newAttrList do
        if HeroParameter.EquipRefineAttrTarget[this.newAttrList[i].id] ~= nil then
            count = count + 1
        end
    end
    return count >= HeroParameter.TargetCount
end


this.SendRestoreAttr = function(param)
    if type(this.equipData.tmpAdditionalAttrs) == "function" or TableIsNull(this.equipData.tmpAdditionalAttrs) then
        return
    end
    local tempData = {}
    tempData["id"] = this.equipData.id
    tempData["save"] = param
    ApiMgr.Request(
        "equipment/attr/washing_save",
        tempData,
        true,
        function(result)
            local re = json.decode(result)
            if re.code == 0 then
                this.equipData = DataMgr.Player.equipments[this.equipData.id]
                if type(this.equipData.additionalAttrs) == "function" then
                    this.equipData.additionalAttrs = nil
                end
                if param then
                    this.CreateRefineFormerAttr()
                end
                this.CreateRefineAfterAttr()
                this.CreateCostMaterial(this.TypeEnum.refine)
                this.vm.data.notRefineBtn = false
            end
        end,
        nil,
        true
    )
end

this.SetRefineState = function()
    this.vm.data.refineRoot = TableIsNull(this.newAttrList) or this.isAuto
    this.vm.data.resultRoot = not TableIsNull(this.newAttrList) and not this.isAuto
    this.vm.data.newNullObj = TableIsNull(this.newAttrList)
    this.vm.data.newAttrObj = not TableIsNull(this.newAttrList)
end





this.UpdateExchange = function()
    this.CreateCostMaterial(this.TypeEnum.exchange)
    this.vm.data.oldExchangeEquipName = string.format("%s  LV.%d", LuaMgr.GetLangText(this.equipConfig.NameLan), this.equipData.level)
    for i = 1, 6 do
        this.vm.data.starList[i].rStar = i <= this.equipData.star
        this.vm.data.oldExchangeStar[i].rStar = i <= this.equipData.star
    end
end


this.OnOpenEquipList = function()
    this.exchangeEquipList:Clear(false)
    this.vm.data.showExchangeEquipList = true
    this.vm.data.equipDetailMask = true
    this.vm.data.exchangeEquipNull = #this.allEquipDatas == 0
    if #this.allEquipDatas == 0 then
        return
    end
    this.animExchangeEquipMask:Play(this.exchangeEquipListAnimName)
    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    local index = 1
    this.colCount = 4
    this.viewWidth = 420
    while (index <= #this.allEquipDatas) do
        groupData = {}
        groupData.item = this.itemTemplate
        groupData.spaceX = 1
        groupData.equip = {}
        for i = 1, this.colCount do
            if this.allEquipDatas[index + i - 1] ~= nil then
                this.allEquipDatas[index + i - 1].index = i
                if this.isHaveEquip then
                    this.allEquipDatas[index + i - 1].choose = index == 1 and i == 1
                else
                    this.allEquipDatas[index + i - 1].choose = false
                end
                this.allEquipDatas[index + i - 1].contrast = false
                table.insert(groupData.equip, this.allEquipDatas[index + i - 1])
            end
        end
        scrollData = UIScrollData.GetData(this.groupTemplate, "EquipExchangeGroup", this.viewWidth, 102, groupData)
        table.insert(scrollDatas, scrollData)
        index = index + this.colCount
    end
    this.exchangeEquipList:SetParams(this.viewWidth, 532)
    this.exchangeEquipList:SetData(scrollDatas, true)
end


this.SelectEquipItem = function(args)
    if args == nil or args.Length < 3 then
        return
    end
    this.animExchangeEquipMask:Play(this.exchangeEquipDetailAnimName)
    this.vm.data.showEquipDetailArrow = true
    this.vm.data.equipEffectShow = false
    local tempGroup, tempIndex = args[0], args[1]
    this.selectEquipItem = args[2]
    if this.exchangeEquipGroup ~= 0 and this.exchangeEquipIndex ~= 0 then
        if this.isHaveEquip then
            this.exchangeEquipList.dataList[this.exchangeEquipGroup].data.equip[this.exchangeEquipIndex].contrast = false
        else
            local exchangeEquipGroupDatas = this.exchangeEquipList.dataList[this.exchangeEquipGroup]
            if exchangeEquipGroupDatas then
                exchangeEquipGroupDatas.data.equip[this.exchangeEquipIndex].choose = false
            end
        end
    end
    this.exchangeEquipGroup, this.exchangeEquipIndex = tempGroup, tempIndex
    if this.isHaveEquip then
        this.exchangeEquipList.dataList[this.exchangeEquipGroup].data.equip[this.exchangeEquipIndex].contrast = true
    else
        this.exchangeEquipList.dataList[this.exchangeEquipGroup].data.equip[this.exchangeEquipIndex].choose = true
    end
    this.exchangeEquipList:Refresh()
    local equipID = this.exchangeEquipList.dataList[this.exchangeEquipGroup].data.equip[this.exchangeEquipIndex].equipId
    this.chooseEquipData = DataMgr.Player.equipments[equipID]
    this.SetChooseEquipAttr(false)
end


this.OnChooseNewEquip = function(args)
    this.vm.data.equipEffectShow = true
    this.vm.data.showEquipDetailArrow = false
    this.vm.data.showExchangeEquipList = false
    this.vm.data.choosedEquip = this.chooseEquipData ~= nil
    this.vm.data.showEquipDetail = false
    if this.exchangeChoosedEquip and this.exchangeChoosedEquip.id ~= this.equipData.id then
        local equipData = this.chooseEquipData
        if equipData == nil then
            return
        end
        local equipConfig = ConfigMgr.Config.equipments[equipData.equipmentId]
        if equipConfig == nil then
            return
        end
        this.exchangeChoosedEquip = nil
        this.OnChooseNewEquipEffect(equipConfig)
        this.vm.data.newExchangeEquipIcon = LuaMgr.GetTexture(this.equipPicPath .. equipConfig.id .. ".png")
        this.vm.data.newExchangeEquipName = string.format("%s  LV.%d", LuaMgr.GetLangText(equipConfig.NameLan), equipData.level)
        for i = 1, 6 do
            this.vm.data.newExchangeStar[i].rStar = i <= equipData.star
        end
    end
end


this.OnChooseNewEquipEffect = function(equipConfig)
    local index = -1
    if equipConfig ~= nil then
        if equipConfig.rare == 2 then
            index = 2
        elseif equipConfig.rare == 3 then
            index = 3
        elseif equipConfig.rare == 4 then
            index = 4
        else
            index = 1
        end
    end
    for key, value in pairs(this.vm.data.equipEffectPos) do
        if key == index then
            this.vm.data.equipEffectPos[index] = Vector3(2496, -90, 0)
        else
            this.vm.data.equipEffectPos[index] = Vector3(5000, 0)
        end
    end
end

this.SetChooseEquipAttr = function(isLeft)
    local equipData = nil
    if isLeft == true then
        equipData = this.equipData
        this.vm.data.equipDetailPos = Vector2(-186, -18.1)
    else
        equipData = this.chooseEquipData
        this.vm.data.equipDetailPos = Vector2(-443.6, -18.1)
    end
    this.exchangeChoosedEquip = equipData
    if equipData == nil then
        return
    end
    local equipConfig = ConfigMgr.Config.equipments[equipData.equipmentId]
    if equipConfig == nil then
        return
    end
    this.vm.data.equipDetailMask = true
    this.vm.data.showEquipDetail = true
    if isLeft == true then
        this.animExchangeEquipMask:Play(this.exchangeEquipDetailAnimName1) 
    end
    this.vm.data.equipDetailsData.wRare = LuaMgr.GetSprite("ItemRare", "itemRare" .. equipConfig.rare)
    this.vm.data.equipDetailsData.wIcon = LuaMgr.GetTexture("Assets/_BundleResources/Images/ItemIcons/itemicon_" .. equipConfig.id .. ".png")
    this.vm.data.equipDetailsData.wLevel = string.format("lv.%d", equipData.level)
    this.vm.data.equipDetailsData.wStar0 = equipData.star >= 1
    this.vm.data.equipDetailsData.wStar1 = equipData.star >= 2
    this.vm.data.equipDetailsData.wStar2 = equipData.star >= 3
    this.vm.data.equipDetailsData.wStar3 = equipData.star >= 4
    this.vm.data.equipDetailsData.wStar4 = equipData.star >= 5
    this.vm.data.equipDetailsData.wStar5 = equipData.star >= 6
    this.vm.data.equipDetailsData.wName = LuaMgr.GetLangText(equipConfig.NameLan)
    this.vm.data.equipDetailsData.wJob = LuaMgr.GetLangText(ConfigMgr.Config.jobs[this.ToString(equipConfig.job)].NameLan)
    local expBar = this.CalculateExp(equipData.exp, equipData.level, equipConfig.rare)
    this.vm.data.equipDetailsData.wExpBar = expBar
    this.vm.data.equipDetailsData.wExpText = math.floor(expBar * 100) .. "%"
    local tempTable = ConfigMgr.Config.equipmentLevelUp[this.ToString(equipConfig.rare)]
    if equipData.level < ConfigHelper.GetTableLength(tempTable) then
        this.vm.data.equipDetailsData.wtipObj = equipData.level == equipData.limitedLevel and Vector3.one or Vector3.zero
    else
        this.vm.data.equipDetailsData.wtipObj = Vector3.zero
    end
    this.vm.data.equipDetailsData.wWearState = equipData.characterId ~= ""
    this.vm.data.equipDetailsData.wLockState = equipData.locking
    local GetEquipAttribute = function(equipData)
        local dataJson = json.encode(equipData)
        dataJson = LuaMgr.GetEquipPropertyCopy(dataJson)
        return json.decode(dataJson)
    end
    local attrData = GetEquipAttribute(equipData)
    this.vm.data.equipDetailsData.wBasisAttr = this.CreateAttrItem(true, attrData)
    local additionalAttrs = nil
    if type(equipData.additionalAttrs) == "function" or TableIsNull(equipData.additionalAttrs) then
        additionalAttrs = {}
    else
        additionalAttrs = equipData.additionalAttrs
    end
    this.vm.data.equipDetailsData.wSubjoinAttr = this.CreateAttrItem(false, attrData, additionalAttrs)
    if equipData.characterId ~= "" then
        local curSkin = DataMgr.Player.characters[equipData.characterId].curSkin
        local path = ConfigHelper.GetCharacterAvatarPath(equipData.characterId, curSkin)
        this.vm.data.equipDetailsData.wHeadIcon = LuaMgr.GetTexture(path)
    end
    if #equipConfig.equipSkill > 0 then
        local skill = ConfigMgr.Config.equipmentSkills[equipConfig.equipSkill[1]][this.ToString(equipData.star)]
        this.vm.data.equipDetailsData.wSkillName = LuaMgr.GetLangText(skill.NameLan)
        this.vm.data.equipDetailsData.wSkillLevel = string.format(this.skillLevel, equipData.star)
        this.vm.data.equipDetailsData.wSkillIntro = LuaMgr.GetEquipSkillText(equipData.equipmentId, equipData.star)
    end
end

this.UnlockChooseEquip = function ()
    if this.exchangeChoosedEquip == nil then
        return
    end
    local onSuccess = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            LuaDebug.error("开始游戏请求失败，错误码：" .. tostring(res.code))
            return
        end
        local newData = DataMgr.Player.equipments[this.exchangeChoosedEquip.id]
        if this.chooseEquipData and this.chooseEquipData.id == this.exchangeChoosedEquip.id then
            this.chooseEquipData = newData
            if this.selectEquipItem ~= nil then
                this.selectEquipItem:SetLocked(false)
            end
        else 
            this.UpdateAttrLock()
        end
        this.vm.data.equipDetailsData.wLockState = newData.locking
    end
    local data = {}
    data.id= this.exchangeChoosedEquip.id
    ApiMgr.Request("equipment/lock", data, true, onSuccess, nil, true)
end

this.CalculateExp = function(exp, level, rare)
    if exp == 0 then
        return 0
    end
    local levelMax = ConfigHelper.GetTableLength(ConfigMgr.Config.equipmentLevelUp[this.ToString(rare)])
    if level == levelMax then
        return 1
    end
    local nextLevel = level + 1

    local levelExp = ConfigMgr.Config.equipmentLevelUp[this.ToString(rare)][this.ToString(level)]

    local nextLevelExp = ConfigMgr.Config.equipmentLevelUp[this.ToString(rare)][this.ToString(nextLevel)]
    local barValue = (exp - levelExp) / (nextLevelExp - levelExp)
    barValue = barValue - (barValue % 0.01)
    return barValue
end


this.CreateAttrItem = function(param, attrData, additionalAttrs)
    local attrList, atkItem = {}, {}
    local color = UnityEngine.Color(121 / 225, 112 / 225, 83 / 225, 1)
    if param then
        atkItem = {
            attrIcon = LuaMgr.GetSprite("AttributeIcon", "Atk"),
            attrType = "Atk",
            numberValue = attrData["Atk"],
            attrName = LuaMgr.GetLangText(ConfigHelper.GetAttrDes("Atk_FIX").NameLan),
            attrValue = this.ToString(attrData["Atk"]),
            litre = false,
            drop = false,
            color = color,
            attrLock = false
        }
        this.TableInsert(attrList, atkItem)
        atkItem = {
            attrIcon = LuaMgr.GetSprite("AttributeIcon", "Hp"),
            attrType = "Hp",
            numberValue = attrData["Hp"],
            attrName = LuaMgr.GetLangText(ConfigHelper.GetAttrDes("Hp_FIX").NameLan),
            attrValue = this.ToString(attrData["Hp"]),
            litre = false,
            drop = false,
            color = color,
            attrLock = false
        }
        this.TableInsert(attrList, atkItem)
    else
        local attrDes = {}
        for i = 1, #additionalAttrs do
            attrDes = ConfigMgr.Config.additionalAttrs[additionalAttrs[i].id]
            if not TableIsNull(attrDes) then
                atkItem = {
                    attrIcon = LuaMgr.GetSprite("AttributeIcon", attrDes.addAttr),
                    attrName = LuaMgr.GetLangText(attrDes.NameLan),
                    litre = false,
                    drop = false,
                    attrType = attrDes.addAttr,
                    color = color,
                    attrId = attrDes.id,
                    numberValue = this.ToNumber(attrData[attrDes.addAttr]),
                    attrLock = additionalAttrs[i].lock
                }
                if (attrDes.addAttr == "EnergyRecoveryCycle_FIX") then
                    atkItem.attrValue = LuaMgr.Division(tonumber(attrData[attrDes.addAttr]), 100) .. attrDes.attrDisplayType
                else
                    atkItem.attrValue = this.ToString(attrData[attrDes.addAttr]) .. attrDes.attrDisplayType
                end
                this.TableInsert(attrList, atkItem)
            end
        end
    end
    return attrList
end

this.ClickExchangeBtn = function()
    local oldEquipData = this.equipData
    local newEquipData = this.chooseEquipData
    if oldEquipData == nil or newEquipData == nil then
        local tipStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23690")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr)
        return
    elseif oldEquipData.locking == true or newEquipData.locking == true then
        local tipStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23691")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr)
        return
    else
        local itemCfg = ConfigMgr.Config.equipConstants.ExchangeItem[1]
        local itemConfig = ConfigMgr.Config.itemMap[itemCfg.id]
        local haveCount = DataHelper.GetItemCountById(itemConfig.id)
        if itemCfg.count > haveCount then
            local tipStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23692")
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr)
            return
        end
    end
    local data = {}
    data.clickCallbacks = {}
    data.btnTextStrs = {}
    data.clickCallbacks[ConfirmCommonPanel.BtnType.Confirm] = this.OnExchange
    data.contentStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23693")
    LuaMgr.ShowLuaPanel(UIName.ConfirmCommonPanel, ConfirmCommonPanel.MsgBoxType.ImageButton, data)
end

this.GetLang = function(nameLan)
    return CS.Laigu.Manager.LangManager.Singleton:GetData(nameLan)
end

this.OnExchange = function()
    local oldEquipData = this.equipData
    local newEquipData = this.chooseEquipData
    if oldEquipData == nil or newEquipData == nil then
        return
    end
    local onSuccess = function(result)
        local re = json.decode(result)
        if re.code ~= 0 then
            return
        end
        this.PlaySuccessAnim()
    end
    local data = {}
    data.Src = oldEquipData.id
    data.Dst = newEquipData.id
    ApiMgr.Request("equipexchange/exchange", data, true, onSuccess, nil, true)
end

this.OnExchangeSuccess = function()
    local data = {}
    table.insert(data, {ID = this.chooseEquipData.id, Count = 1})
    table.insert(data, {ID = this.equipData.id, Count = 1})
    LuaMgr.ShowLuaPanel(UIName.GetRewardsViewModel, json.encode(data))
    this.equipData = DataMgr.Player.equipments[this.equipData.id]
    this.chooseEquipData = nil
    this.OnChooseNewEquip()
    PlayerBackpackMgr.UpdateEquip()
    this.vm.data.choosedEquip = false
    this.UpdateMiddleView()
    this.UpdateExchange()
end

this.PlaySuccessAnim = function()
    this.vm.data.exchangeSuccEffect = false
    this.vm.data.exchangeOperateMask = true
    local callBack = function ()
        this.vm.data.exchangeSuccEffect = true
    end
    local callBack1 = function ()
        this.OnExchangeSuccess()
        this.vm.data.exchangeOperateMask = false
    end
    this.animExchangeView:Play(this.exchangeEquipSuccAnimName)
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/huazhao_donghua2.mp3")
    if this.sequence ~= nil then
        this.sequence:Kill()
    end
    if this.sequence1 ~= nil then
        this.sequence1:Kill()
    end
    this.sequence = DOTWeen:Sequence()
    this.sequence1 = DOTWeen:Sequence()
    local during = 2
    local during1 = 0.5
    this.sequence:AppendInterval(during):OnComplete(callBack)
    this.sequence1:AppendInterval(during + during1):OnComplete(callBack1)
end




this.UpdateEquipSift = function()
    this.GetEquipConfig()
end

this.GetEquipConfig = function()
    if this.equipData == nil then
        LuaDebug.error("this.GetEquipConfig equipData is nil")
        return
    end
    local curChooseEquipCfg = ConfigMgr.Config.equipments[this.equipData.equipmentId]
    if curChooseEquipCfg == nil then
        LuaDebug.error("this.GetEquipConfig curChooseEquipCfg is nil ID:" .. this.equipData.equipmentId)
        return
    end
    this.allEquipDatas = {}
    this.lockEquipDatas = {}
    PlayerBackpackMgr.UpdateSiftEquip()

    for i = 1, #PlayerBackpackMgr.equipData do
        local tempData = PlayerBackpackMgr.equipData[i]
        local equipConfig = ConfigMgr.Config.equipments[tempData.equipmentId]
        local isFullCondition = equipConfig ~= nil and equipConfig.rare == this.equipData.rare and equipConfig.job == curChooseEquipCfg.job and tempData.id ~= this.equipData.id and equipConfig.Series ~= curChooseEquipCfg.Series
        if isFullCondition then
            local tempItem = {
                usingState = tempData.characterId ~= "",
                rareState = equipConfig.rare,
                starState = tempData.star,
                gradeState = tempData.grade,
                levelState = tempData.level,
                timeState = tempData.createTime,
                equipIdState = equipConfig.id,
                characterWearId = tempData.characterId,
                equipId = tempData.id,
                locking = tempData.locking
            }
            table.insert(this.allEquipDatas, tempItem)
            if tempData.locking == true then
                table.insert(this.lockEquipDatas, tempItem)
            end
        end
    end
    if this.exchangeEquipIsLock == true then
        this.allEquipDatas = this.lockEquipDatas
    end
    this.OnOpenEquipList()
end





this.WhetherHaveTmpAdditionalAttrs = function()
    local isMainEquipAttrEmpty = type(this.equipData.tmpAdditionalAttrs) == "function" or TableIsNull(this.equipData.tmpAdditionalAttrs)
    
    local isChooseEquipAttrEmpty = true
    if this.chooseEquipData ~= nil then
        isChooseEquipAttrEmpty = type(this.chooseEquipData.tmpAdditionalAttrs) == "function" or TableIsNull(this.chooseEquipData.tmpAdditionalAttrs)
    end

    if isMainEquipAttrEmpty and isChooseEquipAttrEmpty then
        return true
    elseif isMainEquipAttrEmpty == false then
        command.refineCommand.execute()
    end
    local tipStr = ConfigMgr.LangGlobal("16132")
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr)
    return false
end


this.SetLanguageText = function()
    this.vm.data.formerNull = ConfigMgr.LangGlobal("16133")
    this.vm.data.former = ConfigMgr.LangGlobal("16115")
    this.vm.data.newNull = ConfigMgr.LangGlobal("16116")
    this.vm.data.newText = ConfigMgr.LangGlobal("16118")
    this.vm.data.refineBtnText = ConfigMgr.LangGlobal("16117")
    this.vm.data.autoText = ConfigMgr.LangGlobal("16127")
    this.vm.data.restoreBtnText = ConfigMgr.LangGlobal("16129")
    this.vm.data.saveBtnText = ConfigMgr.LangGlobal("16130")
    this.vm.data.stopBtnText = ConfigMgr.LangGlobal("16128")
end


this.CreateMaterial = function(tempMaterial)
    local tempList, itemConfig = {}, nil
    local count = ""
    if IsNull(tempMaterial) then
        return
    end
    for i = 1, #tempMaterial do
        itemConfig = ConfigMgr.Config.itemMap[tempMaterial[i].id]
        local haveCount = DataHelper.GetItemCountById(tempMaterial[i].id)
        if tempMaterial[i].count > haveCount then
            count = string.format(this.coinNotEnough, LuaMgr.NumFormat(haveCount), LuaMgr.NumFormat(tempMaterial[i].count))
        else
            count = string.format(this.coinEnough, LuaMgr.NumFormat(haveCount), LuaMgr.NumFormat(tempMaterial[i].count))
        end
        local tempItem = {
            materialRare = LuaMgr.GetSprite("ItemRare", "itemRare" .. itemConfig.rare),
            materialIcon = LuaMgr.GetTexture(this.iconPath .. itemConfig.id .. ".png"),
            materialCount = count,
            materialID = itemConfig.id,
            materialHaveCount = haveCount,
            needCount = tempMaterial[i].count
        }
        this.TableInsert(tempList, tempItem)
        this.materialCost[itemConfig.id] = tempMaterial[i].count
    end
    this.vm.data.materialList = tempList
end


this.UpdateDetailsData = function()
    if this.equipConfig ~= nil then
        this.vm.data.equipRare = LuaMgr.GetSprite("ItemRare", "itemRare" .. this.equipConfig.rare)
        this.vm.data.equipIcon = LuaMgr.GetTexture(this.equipPicPath .. this.equipConfig.id .. ".png")
        this.vm.data.equipName = LuaMgr.GetLangText(this.equipConfig.NameLan)
        this.vm.data.jobText = LuaMgr.GetLangText(ConfigMgr.Config.jobs[this.ToString(this.equipConfig.job)].NameLan)
    end
    for i = 1, 6 do
        this.vm.data.starList[i].rStar = i <= this.equipData.star
    end
    this.vm.data.WearState = this.equipData.characterId ~= ""
    if this.equipData.characterId ~= "" then
        local curSkin = DataMgr.Player.characters[this.equipData.characterId].curSkin
        local path = ConfigHelper.GetCharacterAvatarPath(this.equipData.characterId, curSkin)
        this.vm.data.headIcon = LuaMgr.GetTexture(path)
    end
    this.vm.data.lockState = this.equipData.locking
    this.vm.data.expBar = this.opType == this.TypeEnum.level and Vector3.one or Vector3.zero
end


this.InitEquipAttr = function()
    if this.equipConfig == nil then
        return
    end
    local dataJson = json.encode(this.equipData)
    local equipAttr = json.decode(LuaMgr.GetEquipPropertyCopy(dataJson))
    local tempAttr = {"Atk", "Hp"}
    local key = ""
    local maxLevel = ConfigHelper.GetTableLength(ConfigMgr.Config.equipmentLevelUp[this.ToString(this.equipConfig.rare)])
    local isMaxLevel = this.equipData.level == maxLevel
    for i = 1, #tempAttr do
        key = tempAttr[i]
        this.vm.data.basisAttr[i].attrIcon = LuaMgr.GetSprite("AttributeIcon", key)
        this.vm.data.basisAttr[i].attrName = LuaMgr.GetLangText(ConfigHelper.GetAttrDes(key .. "_FIX").NameLan)
        this.vm.data.basisAttr[i].next = Vector3.zero
        this.vm.data.basisAttr[i].attrValue = isMaxLevel and "" or this.ToString(equipAttr[key])
        this.vm.data.basisAttr[i].maxValue = not isMaxLevel and "" or this.ToString(equipAttr[key])
        this.vm.data.basisAttr[i].curr = Vector3.one

        equipAttr[key] = nil
    end
    if this.opType == this.TypeEnum.level then
        local attrDes = {}
        local attrList = {}
        if not TableIsNull(this.equipData.additionalAttrs) then
            for i = 1, #this.equipData.additionalAttrs do
                attrDes = ConfigMgr.Config.additionalAttrs[this.equipData.additionalAttrs[i].id]
                if attrDes ~= nil then
                    local atkItem = {
                        attrIcon = LuaMgr.GetSprite("AttributeIcon", attrDes.addAttr),
                        attrName = LuaMgr.GetLangText(attrDes.NameLan),
                        attrLock = this.equipData.additionalAttrs[i].lock
                    }
                    if (attrDes.addAttr == "EnergyRecoveryCycle_FIX") then
                        atkItem.attrValue = LuaMgr.Division(tonumber(equipAttr[attrDes.addAttr]), 100) .. attrDes.attrDisplayType
                    else
                        atkItem.attrValue = this.ToString(equipAttr[attrDes.addAttr]) .. attrDes.attrDisplayType
                    end
                    this.TableInsert(attrList, atkItem)
                end
            end
        end
        this.vm.data.subjoinAttr = attrList
    end
    this.vm.data.addAttrTip = false
    this.vm.data.litreAttrTip = false
end


this.InitExpBar = function()
    this.expValue = 0.0
    if this.equipData.exp > 0 then
        local levelExp = ConfigMgr.Config.equipmentLevelUp[this.ToString(this.equipConfig.rare)][this.ToString(this.equipData.level)]
        local nextLevelExp = ConfigMgr.Config.equipmentLevelUp[this.ToString(this.equipConfig.rare)][this.ToString(this.equipData.level + 1)]
        this.expValue = (this.equipData.exp - levelExp) / (nextLevelExp - levelExp)
    end
    this.vm.data.lineBar = this.expValue
    this.vm.data.previewBar = this.expValue
    this.vm.data.nowLevelText = string.format("LV %d", this.equipData.level)
    this.vm.data.nextLevel = Vector3.zero
    this.CalculateLackExp(this.equipData.exp, 0)
end


this.AddMaterial = function(index)
    local materialId = this.vm.data.middleList[index].onlyId
    local tabIndex = this.WhetherContains(materialId)
    if #this.consumed >= 5 and tabIndex == false then
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2064"].NameLan)
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
        LuaMgr.RemoveTimer(TimerConst.EquipMaterialClick)
        return
    end
    local expMax = 0
    if this.equipConfig ~= nil then
        expMax = ConfigMgr.Config.equipmentLevelUp[this.ToString(this.equipConfig.rare)][this.ToString(this.equipData.limitedLevel)]
    end
    if this.CalculateAddExp() + this.equipData.exp > expMax then
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2007"].NameLan)
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
        LuaMgr.RemoveTimer(TimerConst.EquipMaterialClick)
        return
    end
    local isCan = this.CacheMaterial(materialId, 1)
    tabIndex = this.WhetherContains(materialId)
    if isCan == false then
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2095"].NameLan)
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
        LuaMgr.RemoveTimer(TimerConst.EquipMaterialClick)
        return
    end
    this.vm.data.middleList[index].select = Vector3.one
    this.vm.data.middleList[index].num = this.ToString(this.consumed[tabIndex].Count)
    this.UpdateUpLevelMaterial()
    this.LevelPreview()
end



this.SubtractMaterial = function(index, param)
    local materialId
    if param then
        materialId = this.vm.data.middleList[index].onlyId
        local _index = this.WhetherContains(materialId)
        this.consumed[_index].Count = this.consumed[_index].Count - 1
        if this.consumed[_index].Count == 0 then
            table.remove(this.consumed, _index)
            this.vm.data.middleList[index].select = Vector3.zero
        else
            this.vm.data.middleList[index].num = this.ToString(this.consumed[_index].Count)
        end
    else
        materialId = this.consumed[index].ID
        table.remove(this.consumed, index)
        for i = 1, #this.vm.data.middleList do
            if this.vm.data.middleList[i].onlyId == materialId then
                this.vm.data.middleList[i].select = Vector3.zero
                break
            end
        end
    end
    this.UpdateUpLevelMaterial()
    this.LevelPreview()
end


this.FastSelectMaterial = function()
    if #this.vm.data.middleList == 0 then
        return
    end
    local numBool = #this.consumed >= 5
    if numBool then
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2064"].NameLan)
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
        return
    end
    local expMax = ConfigMgr.Config.equipmentLevelUp[this.ToString(this.equipConfig.rare)][this.ToString(this.equipData.limitedLevel)]
    local expBool = this.CalculateAddExp() + this.equipData.exp > expMax
    if expBool then
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2007"].NameLan)
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
        return
    end

    local lackExp = expMax - this.CalculateAddExp() - this.equipData.exp
    for i = 1, #this.vm.data.middleList do
        local itemExp = this.GetAddExpValue(this.vm.data.middleList[i].onlyId, 1)
        if lackExp > itemExp then
            local count = math.floor(lackExp / itemExp)
            local isCan = this.CacheMaterial(this.vm.data.middleList[i].onlyId, count)
            local tabIndex = this.WhetherContains(this.vm.data.middleList[i].onlyId)
            if isCan == false then
                local haveCount = DataHelper.GetItemCountById(this.vm.data.middleList[i].onlyId)
                count = haveCount - this.consumed[tabIndex].Count
                this.CacheMaterial(this.vm.data.middleList[i].onlyId, count)
            end
            this.vm.data.middleList[i].select = Vector3.one
            this.vm.data.middleList[i].num = this.ToString(this.consumed[tabIndex].Count)
            lackExp = expMax - this.CalculateAddExp() - this.equipData.exp
        end
    end
    this.ReplenishExp(lackExp)
    this.UpdateUpLevelMaterial()
    this.LevelPreview()
end


this.ReplenishExp = function(lackExp)
    if lackExp > 0 then
        local length = #this.vm.data.middleList
        for i = length, 1, -1 do
            local materialId = this.vm.data.middleList[i].onlyId
            local itemExp = this.GetAddExpValue(materialId, 1)
            local count = math.ceil(lackExp / itemExp)
            local isCan = this.CacheMaterial(materialId, count)
            local tabIndex = this.WhetherContains(materialId)
            if isCan then
                this.vm.data.middleList[i].num = this.consumed[tabIndex].Count
                this.vm.data.middleList[i].select = Vector3.one
                return
            else
                local haveCount = DataHelper.GetItemCountById(materialId)
                count = haveCount - this.consumed[tabIndex].Count
                if count > 0 then
                    this.CacheMaterial(materialId, count)
                end
            end
        end
    end
end


this.CacheMaterial = function(materialId, count)
    local tabIndex = this.WhetherContains(materialId)
    local haveCount = DataHelper.GetItemCountById(materialId)
    if tabIndex == false then
        if count > haveCount then
            count = haveCount
        end
        local tempCost = {ID = materialId, Count = count}
        this.TableInsert(this.consumed, tempCost)
    else
        if this.consumed[tabIndex].Count + count > haveCount then
            return false
        end
        this.consumed[tabIndex].Count = this.consumed[tabIndex].Count + count
    end
    return true
end


this.EmptyMaterial = function()
    if #this.consumed == 0 then
        return
    end
    local count = 0
    for i = 1, #this.consumed do
        for j = 1, #this.vm.data.middleList do
            if this.consumed[i].ID == this.vm.data.middleList[j].onlyId then
                count = count + 1
                this.vm.data.middleList[j].select = Vector3.zero
                break
            end
        end
        if count == #this.consumed then
            break
        end
    end
    this.consumed = {}
    this.UpdateUpLevelMaterial()
    this.LevelPreview()
end


this.CalculateAddExp = function()
    local addExp = 0
    local itemConfig
    for i = 1, #this.consumed do
        addExp = addExp + this.GetAddExpValue(this.consumed[i].ID, this.consumed[i].Count)
    end
    return addExp
end


this.CalculateLackExp = function(exp, addExp)
    if this.equipConfig == nil then
        return
    end
    local tempExp = 0
    local totalExp = exp + addExp
    local canLevel = this.MatchNextLevel(totalExp)
    local barValue = 0.0
    if canLevel > this.equipData.limitedLevel then
        barValue = 1.0
        tempExp = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2254"].NameLan)
    else
        local expMax = ConfigMgr.Config.equipmentLevelUp[this.ToString(this.equipConfig.rare)][this.ToString(canLevel)]
        tempExp = expMax - totalExp

        local levelExp = ConfigMgr.Config.equipmentLevelUp[this.ToString(this.equipConfig.rare)][this.ToString(canLevel - 1)]
        barValue = (totalExp - levelExp) / (expMax - levelExp)

        if canLevel - 1 > this.equipData.level then
            this.vm.data.lineBar = 0.0
        else
            this.vm.data.lineBar = this.expValue
        end
    end
    this.vm.data.previewBar = barValue
    this.vm.data.lackExp = this.ToString(tempExp)
end


this.MatchNextLevel = function(totalExp)
    if this.equipConfig == nil then
        return
    end
    local nextlevel = 0
    local levelMax = ConfigHelper.GetTableLength(ConfigMgr.Config.equipmentLevelUp[this.ToString(this.equipConfig.rare)])
    local tempExp
    for i = this.equipData.level, levelMax do
        tempExp = ConfigMgr.Config.equipmentLevelUp[this.ToString(this.equipConfig.rare)][this.ToString(i + 1)]
        if i == levelMax then
            nextlevel = levelMax + 1
            break
        end
        if tempExp > totalExp then
            nextlevel = i + 1
            break
        end
    end
    return nextlevel
end


this.GetAddExpValue = function(id, count)
    local exp = 0
    itemConfig = ConfigMgr.Config.itemMap[id]
    if itemConfig == nil then
        local itemData = DataMgr.Player.equipments[id]
        itemConfig = ConfigMgr.Config.equipments[itemData.equipmentId]
        if itemData.exp == 0 then
            exp = exp + itemConfig.expVol
        else
            exp = exp + math.floor(itemData.exp * (ConfigMgr.Config.constants.EquipExpCompose / 100)) + itemConfig.expVol
        end
    else
        exp = exp + itemConfig.drop * count
    end
    return exp
end


this.UpdateUpLevelMaterial = function()
    local index = 1
    local itemConfig = {}
    for i = 1, #this.consumed do
        if this.consumed[i].Count > 0 then
            itemConfig = ConfigMgr.Config.itemMap[this.consumed[i].ID]
            if itemConfig == nil then
                local tempData = DataMgr.Player.equipments[this.consumed[i].ID]
                itemConfig = ConfigMgr.Config.itemMap[tempData.equipmentId]
            end
            this.vm.data.levelMaterial[index].mRare = LuaMgr.GetSprite("ItemRare", "itemRare" .. itemConfig.rare)
            this.vm.data.levelMaterial[index].mIcon = LuaMgr.GetTexture(this.iconPath .. itemConfig.id .. ".png")
            this.vm.data.levelMaterial[index].mCount = this.ToString(this.consumed[i].Count)
            this.vm.data.levelMaterial[index].material = Vector3.one
            index = index + 1
        end
    end
    for i = index, #this.vm.data.levelMaterial do
        this.vm.data.levelMaterial[i].material = Vector3.zero
    end
end


this.LevelPreview = function()
    this.currencyCost = 0
    local addExp = this.CalculateAddExp()
    local canLevel = this.MatchNextLevel(this.equipData.exp + addExp) - 1
    if canLevel > this.equipData.level then


        if canLevel > this.equipData.limitedLevel then
            canLevel = this.equipData.limitedLevel
        end
        this.vm.data.nextLevelText = string.format(this.nextLevelFormat, canLevel)






    end
    this.vm.data.nextLevel = canLevel > this.equipData.level and Vector3.one or Vector3.zero
    if canLevel >= this.equipData.limitedLevel then
        local exp = ConfigMgr.Config.equipmentLevelUp[this.ToString(this.equipConfig.rare)][this.ToString(this.equipData.limitedLevel)]
        this.currencyCost = (exp - this.equipData.exp) * this.upCoin / 100
    else
        this.currencyCost = addExp * this.upCoin / 100
    end
    this.CalculateLackExp(this.equipData.exp, addExp)
    this.WhetherOpenTip(canLevel)
    if this.equipData.level ~= canLevel then
        local tempData = table.Copy(this.equipData)
        tempData.level = canLevel
        this.AttrsPreview(tempData)
    end
    this.UpdateConsume()
end


this.WhetherOpenTip = function(canLevel)
    if this.equipData.level == canLevel then
        this.vm.data.addAttrTip = false
        this.vm.data.litreAttrTip = false
        for i = 1, #this.vm.data.basisAttr do
            this.vm.data.basisAttr[i].next = Vector3.zero
            this.vm.data.basisAttr[i].curr = Vector3.one
        end
    else
        for i = this.equipData.level + 1, canLevel do
            if i % 4 == 0 then
                this.vm.data.literTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2140"].NameLan)
                this.vm.data.litreAttrTip = true
                if #this.vm.data.subjoinAttr >= 3 then
                    return
                end
                this.vm.data.attrTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2139"].NameLan)
                this.vm.data.addAttrTip = #this.vm.data.subjoinAttr < 3
                if #this.vm.data.subjoinAttr < 3 then
                    return
                end
            end
        end
        this.vm.data.litreAttrTip = false
        this.vm.data.addAttrTip = false
    end
end


this.AttrsPreview = function(tempData)
    local dataJson = json.encode(tempData)
    local equipAttr = json.decode(LuaMgr.GetEquipPropertyCopy(dataJson))
    local tempAttr = {"Atk", "Hp"}
    local key = ""
    for i = 1, #tempAttr do
        key = tempAttr[i]
        this.vm.data.basisAttr[i].nextValue = this.ToString(equipAttr[key])
        this.vm.data.basisAttr[i].next = Vector3.one
        this.vm.data.basisAttr[i].maxValue = ""
        this.vm.data.basisAttr[i].curr = Vector3.zero
    end
end

this.UpdateMaterial = function()
    this.UpdateConsume()
    if this.opType == this.TypeEnum.grade then
        this.UpdateGradeView()
    elseif this.opType == this.TypeEnum.star then
        this.UpdateStarView()
    end
end

this.UpdateAttrLock = function()
    this.equipData = DataMgr.Player.equipments[this.equipData.id]
    this.CreateRefineFormerAttr()
end

this.SendLevelUp = function()
    if #this.consumed == 0 then
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2008"].NameLan)
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
        return
    end
    local tempData = {}
    tempData["ID"] = this.equipData.id
    local tempCost = {}
    for i = 1, #this.consumed do
        tempCost[this.consumed[i].ID] = this.consumed[i].Count
    end
    tempData["Consumed"] = tempCost
    ApiMgr.Request(
        "equipment/level_up",
        tempData,
        true,
        function(result)
            local re = json.decode(result)
            if re.code == 0 then
                this.consumed = {}
                LuaMgr.ShowLuaPanel(UIName.EquipTipViewModel, this.equipData.id, this.opType, this.equipData)
                this.equipData = DataMgr.Player.equipments[this.equipData.id]
                if type(this.equipData.additionalAttrs) == "function" then
                    this.equipData.additionalAttrs = nil
                end
                if this.equipData.level == this.equipData.limitedLevel then
                    this.opType = this.TypeEnum.grade
                end
                this.UpdateView()
            end
        end,
        nil,
        true
    )
end


this.SendAutoLevelUp = function()





    local tempData = {}
    tempData["ID"] = this.equipData.id
    ApiMgr.Request(
        "equipment/level_up_multiple",
        tempData,
        true,
        function(result)
            local re = json.decode(result)
            if re.code == 0 then
                this.consumed = {}
                LuaMgr.ShowLuaPanel(UIName.EquipTipViewModel, this.equipData.id, this.opType, this.equipData)
                this.equipData = DataMgr.Player.equipments[this.equipData.id]
                if type(this.equipData.additionalAttrs) == "function" then
                    this.equipData.additionalAttrs = nil
                end
                if this.equipData.level == this.equipData.limitedLevel then
                    this.opType = this.TypeEnum.grade
                end
                this.UpdateView()
            end
        end,
        function(code)
            if code == 7 then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("23101"))
            end
        end,
        true
    )
end

this.SendGradeUp = function()
    local tempData = {}
    tempData["ID"] = this.equipData.id
    tempData["Cost"] = this.materialCost
    ApiMgr.Request(
        "equipment/grade_up",
        tempData,
        true,
        function(result)
            local re = json.decode(result)
            if re.code == 0 then
                LuaMgr.ShowLuaPanel(UIName.EquipTipViewModel, this.equipData.id, this.opType, this.equipData)
                this.equipData = DataMgr.Player.equipments[this.equipData.id]
                if type(this.equipData.additionalAttrs) == "function" then
                    this.equipData.additionalAttrs = nil
                end
                this.opType = this.TypeEnum.level
                this.UpdateView()
            end
        end,
        nil,
        true
    )
end

this.SendStarUp = function()
    local tempData = {}
    tempData["ID"] = this.equipData.id
    tempData["Cost"] = this.materialCost
    this.materialCost = {}
    ApiMgr.Request(
        "equipment/star_up",
        tempData,
        true,
        function(result)
            local re = json.decode(result)
            if re.code == 0 then
                LuaMgr.ShowLuaPanel(UIName.EquipTipViewModel, this.equipData.id, this.opType, this.equipData)
                this.equipData = DataMgr.Player.equipments[this.equipData.id]
                if type(this.equipData.additionalAttrs) == "function" then
                    this.equipData.additionalAttrs = nil
                end
                this.UpdateView()
            end
        end,
        nil,
        true
    )
end


this.SendAutoStarUp = function()
    local tempData = {}
    tempData["ID"] = this.equipData.id
    ApiMgr.Request(
        "equipment/star_up_multiple",
        tempData,
        true,
        function(result)
            local re = json.decode(result)
            if re.code == 0 then
                LuaMgr.ShowLuaPanel(UIName.EquipTipViewModel, this.equipData.id, this.opType, this.equipData)
                this.equipData = DataMgr.Player.equipments[this.equipData.id]
                if type(this.equipData.additionalAttrs) == "function" then
                    this.equipData.additionalAttrs = nil
                end
                this.UpdateView()
            end
        end,
        function(code)
            if code == 7 then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("23102"))
            end
        end,
        true
    )
end

this.GetCanRefineAttrCount = function()
    local count = 0
    for i = 1, #this.equipData.additionalAttrs do
        if not this.equipData.additionalAttrs[i].lock then
            count = count + 1
        end
    end
    return count
end

this.WhetherContains = function(id)
    for i = 1, #this.consumed do
        if this.consumed[i].ID == id then
            return i
        end
    end
    return false
end

this.ListSort = function(equip1, equip2)

    if equip1.rareInt ~= equip2.rareInt then
        return equip1.rareInt > equip2.rareInt
    else
        return false
    end
end

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)





require("ViewModel/Equipment/EquipWearGroup")
require("ViewModel/Equipment/EquipWearItem")

local this = {
    vm = nil,ToString = tostring,ToNumber = tonumber,TableInsert = table.insert,characterData = nil,
    characterConfig = nil,qSpineCharacter = nil,rightAnim = nil,rootAnim = nil,
    compareGroup = 0,compareIndex = 0,isHaveEquip = false,
    compareState = false,intensifyLockState = false,skillLevel = "LV <color=#D36B34>%d</color>",
    scrollView = nil,itemTemplate = nil,
    groupTemplate = nil,colCount = 0,viewWidth = 0, wearEquipConfig = nil,
    sortType = nil,TableSort = table.sort,selectEquipId = nil,isLock = false,}

local data = {
    leftBgImage = Vector2(354,720),
    namePosition = Vector2(-25,-254),
    spinePosition = Vector2(-16,0),
    
    heroName = "", notSelect = false,
    wearDetails = false, equipNull = false, details = false, compareDetails = false,
    intensifyBtn = false, intensifyLock = false, wearBtn = false, removeBtn = false,
    sortArrow = Vector3(1,-1,1),sortText = "",sortOptions = false,
    levelText = "",rareText = "",starText = "",timeText = "",
    isLockState = false,
    
    attrItem = {{attrIcon = DefaultSprite,color = UnityEngine.Color(0,0,0,1),attrName = "",attrValue = "",litre = false,drop = false,attrLock = false}},
    

    equipDetailsData = {
        {wRare = DefaultSprite,wIcon = DefaultTexture,wLevel = "",wStar0 = false,wStar1 = false,
         wStar2 = false,wStar3 = false,wStar4 = false,wStar5 = false,wName = "",wJob = "",wExpBar = 0.0,
         wExpText = "",wtipObj = Vector3.zero,wWearState = false,wHeadIcon = DefaultTexture,wLockState = false,wBasisAttr = {{}},
         wSubjoinAttr = {{}}, wSkillName = "",wSkillLevel = "",wSkillIntro = ""},
        {wRare = DefaultSprite,wIcon = DefaultTexture,wLevel = "",wStar0 = false,wStar1 = false,
         wStar2 = false,wStar3 = false,wStar4 = false,wStar5 = false,wName = "",wJob = "",wExpBar = 0.0,
         wExpText = "",wtipObj = Vector3.zero,wWearState = false,wHeadIcon = DefaultTexture,wLockState = false,wBasisAttr = {{}},
         wSubjoinAttr = {{}},wSkillName = "",wSkillLevel = "",wSkillIntro = ""}}
}

local command = {
    intensifyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.intensifyLockState then
                local equipId = nil
                if this.isHaveEquip then
                    equipId = this.characterData.wear
                else
                    equipId = this.scrollView.dataList[this.compareGroup].data.equip[this.compareIndex].equipId
                end
                LuaMgr.ShowLuaPanel(UIName.EquipCultivateViewModel,equipId)
            else
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1026"))
            end
        end
    },
    wearCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.WearEquipment()
        end
    },
    removeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.RemoveEquipment()
        end
    },
    cancelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.CloseAttrTag()
        end
    },
    getEquipCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SetOptions(false)
            this.OnClickGetEquip()
        end
    },
    openSortCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SetOptions(not this.vm.data.sortOptions)
        end 
    },
    levelSortCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SetOptions(false)
            this.SetEquipSort(EquipSortType.Level)
            this.CheckSelectEquip()
        end
    },
    rareSortCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SetOptions(false)
            this.SetEquipSort(EquipSortType.Rare)
            this.CheckSelectEquip()
        end
    },
    starSortCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SetOptions(false)
            this.SetEquipSort(EquipSortType.Star)
            this.CheckSelectEquip()
        end
    },
    siftCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.EquipSiftPopup,this.characterConfig.job)
        end
    },

    lockCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.isLock = not this.isLock
            this.vm.data.isLockState = this.isLock
            this.UpdateEquipSift()
        end
    },
    timeSortCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SetOptions(false)
            this.SetEquipSort(EquipSortType.time)
            this.CheckSelectEquip()
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.rootAnim = vm.behaviour.transform:Find("root"):GetComponent("Animator")
        this.rightAnim = vm.behaviour.transform:Find("root/Right"):GetComponent("Animator")
        this.scrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Left/EquipView/View").gameObject)
        this.groupTemplate = vm.behaviour.transform:Find("template/EquipGroup").gameObject
        this.itemTemplate = vm.behaviour.transform:Find("template/EquipItem").gameObject
        this.qSpineCharacter = vm.behaviour.transform:Find("root/Middle/Spine"):GetComponent("UISpineCharacter")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.SetLanguageText()
        this.ViewAdaptive()
        this.InitParameter()
        this.GetEquipConfig()
        local tempSortType = UnityEngine.PlayerPrefs.GetInt("equipSort")
        this.SetEquipSort(tempSortType)
        this.UpdateButton()
        LuaMgr.AddUIEventListener(UIEventConst.EquipWearClick, this.SelectEquipItem)
LuaMgr.AddUIEventListener(UIEventConst.EquipSiftConfirmClick,this.UpdateEquipSift)
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.selectEquipId = nil
        this.sortType = nil
        this.wearEquipConfig = nil
        this.SetOptions(false)
        this.compareGroup,this.compareIndex = 0,0
        this.compareState = false
        this.qSpineCharacter:Clear()
        this.vm.data.details = false
        this.vm.data.compareDetails = false
        this.scrollView:Clear(false)
        LuaMgr.CheckRefCount();
        PlayerBackpackMgr.ResetSift()
        PlayerBackpackMgr.equipPositioningId = nil
        PlayerBackpackMgr.ClearEquip()
        LuaMgr.RemoveUIEventListener(UIEventConst.EquipWearClick, this.SelectEquipItem)
        LuaMgr.RemoveUIEventListener(UIEventConst.EquipSiftConfirmClick,this.UpdateEquipSift)
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("EquipWearGroup")
        this = nil
    end,
}

this.SetLanguageText = function()
    this.vm.data.levelText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2810"].NameLan)
    this.vm.data.rareText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2811"].NameLan)
    this.vm.data.starText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2812"].NameLan)
    this.vm.data.timeText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["23660"].NameLan)
end

this.ViewAdaptive = function()
    local addWidth = LuaMgr.GetScreenAddWidth()
    if addWidth <= 0 then
        this.colCount = 3
        this.vm.data.namePosition = Vector2(-25,-254)
        this.vm.data.spinePosition = Vector2(-22,0)
        this.viewWidth = 354
    else
        this.colCount = 4
        this.vm.data.namePosition = Vector2(25,-254)
        this.vm.data.spinePosition = Vector2(28,0)
        this.viewWidth = 463
    end
    this.vm.data.leftBgImage = Vector2(this.viewWidth,720)
end


this.InitParameter = function()
    if this.vm.behaviour.Params.Length > 0 then
        this.isLock = false
        this.vm.data.isLockState = this.isLock
        local characterId = this.ToString(this.vm.behaviour.Params[0])
        this.characterData = DataMgr.Player.characters[characterId]
        if TableIsNull(this.characterData) then
            return
        end
        this.characterConfig = ConfigMgr.Config.characterTable[characterId]
        this.isHaveEquip = this.characterData.wear ~= ""
        if this.isHaveEquip then
            this.UpdateWearDetails(1,this.characterData.wear)
        end
        this.vm.data.notSelect = not this.isHaveEquip
        this.vm.data.wearDetails = this.isHaveEquip
        this.InitQSpine()
    end

    local panelInfo = FeatureManager.GetPanelInfo("1026")
    this.intensifyLockState = FeatureManager.CheckFeatureStatus(panelInfo)
end


this.InitQSpine = function()
    local wearId = ""
    if this.isHaveEquip then
        local equipId = DataMgr.Player.equipments[this.characterData.wear].equipmentId
        local equipConfig = ConfigMgr.Config.equipments[equipId]
        if equipConfig ~= nil then
            wearId = equipConfig.Mid
        end
    end
    this.vm.data.heroName = LuaMgr.GetLangText(this.characterConfig.namelan)
    this.qSpineCharacter:SetBattle(this.characterData.id, this.characterData.curSkin, wearId, this.characterConfig.job)
end

this.SetEquipSort = function(type)
    if this.sortType == type then return end
    this.sortType = type
    UnityEngine.PlayerPrefs.SetInt("equipSort",this.sortType)
    if this.sortType == EquipSortType.Level then
        this.TableSort(this.wearEquipConfig,this.LevelSort)
        this.vm.data.sortText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2810"].NameLan)
    elseif this.sortType == EquipSortType.Rare then
        this.TableSort(this.wearEquipConfig,this.RareSort)
        this.vm.data.sortText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2811"].NameLan)
    elseif this.sortType == EquipSortType.Star then
        this.TableSort(this.wearEquipConfig,this.StarSort)
        this.vm.data.sortText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2812"].NameLan)
    elseif this.sortType == EquipSortType.time then
        this.TableSort(this.wearEquipConfig,this.TimeSort)
        this.vm.data.sortText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["23660"].NameLan)
    end
    this.InitEquipList()
end

this.CheckSelectEquip = function()
    if this.selectEquipId == nil then return end
    if #this.wearEquipConfig <= 0 then return end
    for i = 1, #this.scrollView.itemMap do
        for j = 1, #this.scrollView.itemMap[i].itemList do
            if this.scrollView.itemMap[i].itemList[j].data.equipId == this.selectEquipId then
                SetActive(this.scrollView.itemMap[i].itemList[j].choose,true)
                return
            end
        end
    end
end

this.InitEquipList = function()
    this.scrollView:Clear(false)
    if this.isHaveEquip then
        this.ReplacePosition()
    end
    this.vm.data.equipNull = #this.wearEquipConfig == 0
    if #this.wearEquipConfig == 0 then return end
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    local index = 1
    while (index <= #this.wearEquipConfig) do
        groupData = {}
        groupData.item = this.itemTemplate
        groupData.spaceX = 8
        groupData.equip = {}
        for i = 1, this.colCount do
            if this.wearEquipConfig[index + i - 1] ~= nil then
                this.wearEquipConfig[index + i - 1].index = i
                if this.isHaveEquip then
                    this.wearEquipConfig[index + i - 1].choose = index == 1 and i == 1
                else
                    this.wearEquipConfig[index + i - 1].choose = false
                end
                this.wearEquipConfig[index + i - 1].contrast = false
                this.TableInsert(groupData.equip,this.wearEquipConfig[index + i - 1])
            end
        end
        scrollData = UIScrollData.GetData(this.groupTemplate,"EquipWearGroup",this.viewWidth,102,groupData)
        this.TableInsert(scrollDatas,scrollData)
        index = index + this.colCount
    end
    this.scrollView:SetParams(this.viewWidth,525)
    this.scrollView:SetData(scrollDatas, true)
end


this.SelectEquipItem = function(args)
    if this.vm.data.sortOptions then
        this.SetOptions(false)
    end
    this.selectEquipId = nil
    local tempGroup,tempIndex = args[0],args[1]
    if this.isHaveEquip then
        if tempGroup == 1 and tempIndex == 1 then
            if this.compareState then
                this.CloseAttrTag()
            end
            return
        end
    end
    if this.compareGroup == tempGroup and this.compareIndex == tempIndex then
        return
    end
    if this.compareGroup ~= 0 and this.compareIndex ~= 0 then
        if this.isHaveEquip then
            this.scrollView.dataList[this.compareGroup].data.equip[this.compareIndex].contrast = false
        else
            this.scrollView.dataList[this.compareGroup].data.equip[this.compareIndex].choose = false
        end
    end
    this.compareGroup,this.compareIndex = tempGroup,tempIndex
    if this.isHaveEquip then
        this.scrollView.dataList[this.compareGroup].data.equip[this.compareIndex].contrast = true
    else
        this.scrollView.dataList[this.compareGroup].data.equip[this.compareIndex].choose = true
    end
    this.scrollView:Refresh()
    local equipId = this.scrollView.dataList[this.compareGroup].data.equip[this.compareIndex].equipId
    if not this.isHaveEquip then
        this.selectEquipId = equipId
        this.UpdateWearDetails(1,equipId)
    else
        this.selectEquipId = nil
        this.UpdateWearDetails(2,equipId)
    end
    this.UpdateButton()
end


this.UpdateWearDetails = function(param,equipId)
    local equipData = DataMgr.Player.equipments[equipId]
    local equipConfig = ConfigMgr.Config.equipments[equipData.equipmentId]
    if equipConfig == nil then
        return
    end
    this.vm.data.equipDetailsData[param].wRare = LuaMgr.GetSprite("ItemRare","itemRare"..equipConfig.rare)
    this.vm.data.equipDetailsData[param].wIcon = LuaMgr.GetTexture("Assets/_BundleResources/Images/ItemIcons/itemicon_"..equipConfig.id..".png")
    this.vm.data.equipDetailsData[param].wLevel = string.format("lv.%d",equipData.level)
    this.vm.data.equipDetailsData[param].wStar0 = equipData.star >= 1
    this.vm.data.equipDetailsData[param].wStar1 = equipData.star >= 2
    this.vm.data.equipDetailsData[param].wStar2 = equipData.star >= 3
    this.vm.data.equipDetailsData[param].wStar3 = equipData.star >= 4
    this.vm.data.equipDetailsData[param].wStar4 = equipData.star >= 5
    this.vm.data.equipDetailsData[param].wStar5 = equipData.star >= 6
    this.vm.data.equipDetailsData[param].wName = LuaMgr.GetLangText(equipConfig.NameLan)
    this.vm.data.equipDetailsData[param].wJob = LuaMgr.GetLangText(ConfigMgr.Config.jobs[this.ToString(equipConfig.job)].NameLan)
    local expBar = this.CalculateExp(equipData.exp,equipData.level,equipConfig.rare)
    this.vm.data.equipDetailsData[param].wExpBar = expBar
    this.vm.data.equipDetailsData[param].wExpText = math.floor(expBar * 100).."%"
    local tempTable = ConfigMgr.Config.equipmentLevelUp[this.ToString(equipConfig.rare)]
    if equipData.level < ConfigHelper.GetTableLength(tempTable) then
        this.vm.data.equipDetailsData[param].wtipObj = equipData.level == equipData.limitedLevel and Vector3.one or Vector3.zero
    else
        this.vm.data.equipDetailsData[param].wtipObj = Vector3.zero
    end
    this.vm.data.equipDetailsData[param].wWearState = equipData.characterId ~= ""
    this.vm.data.equipDetailsData[param].wLockState = equipData.locking
    local attrData = this.GetEquipAttribute(equipData)
    this.vm.data.equipDetailsData[param].wBasisAttr = this.CreateAttrItem(true,attrData,param)
    local additionalAttrs = nil
    if type(equipData.additionalAttrs) == "function" or TableIsNull(equipData.additionalAttrs) then
        additionalAttrs = {} 
    else
        additionalAttrs = equipData.additionalAttrs
    end
    this.vm.data.equipDetailsData[param].wSubjoinAttr = this.CreateAttrItem(false,attrData,param,additionalAttrs)
    if equipData.characterId ~= "" then
        local curSkin = DataMgr.Player.characters[equipData.characterId].curSkin
        local path = ConfigHelper.GetCharacterAvatarPath(equipData.characterId,curSkin)
        this.vm.data.equipDetailsData[param].wHeadIcon = LuaMgr.GetTexture(path)
    end
    if #equipConfig.equipSkill > 0 then
        local skill = ConfigMgr.Config.equipmentSkills[equipConfig.equipSkill[1]][this.ToString(equipData.star)]
        this.vm.data.equipDetailsData[param].wSkillName = LuaMgr.GetLangText(skill.NameLan)
        this.vm.data.equipDetailsData[param].wSkillLevel = string.format(this.skillLevel,equipData.star)
        if LuaMgr.GetEquipSkillText ~= nil and type(LuaMgr.GetEquipSkillText) == "function" then
            this.vm.data.equipDetailsData[param].wSkillIntro = LuaMgr.GetEquipSkillText(equipData.equipmentId,equipData.star)
        else
            this.vm.data.equipDetailsData[param].wSkillIntro = ""
        end
    end
    if param == 1 then
        this.vm.data.notSelect = false
        this.vm.data.wearDetails = true
    elseif param == 2 then
        this.compareState = true
        this.vm.data.details = true
        this.rightAnim:Play("EquipWearPanel_Right",0.0)
        this.vm.data.compareDetails = true
        this.EquipAttrContrast()
    end
end


this.WearEquipment = function()
    local equipId = this.scrollView.dataList[this.compareGroup].data.equip[this.compareIndex].equipId
    local equipData = DataMgr.Player.equipments[equipId]
    local isUse = this.characterData.wear ~= ""
    local tempData = {}
    tempData["ID"] = equipId
    tempData["CharacterID"] = this.characterData.id
    local callBack = function()
        this.SetOptions(false)
        this.rootAnim:Play("EquipWearPanel_Update",0,0)
        this.CloseAttrTag()
        this.UpdateWearDetails(1,equipId)
        this.UpdateButton()
        local tipStr = nil
        if isUse then
            tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2802"].NameLan)
        else
            tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2800"].NameLan)
        end
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
        tipStr = nil
    end
    if equipData.characterId == "" then
        this.SendWearRequest(tempData,callBack)
    else
        local tempConfig = ConfigMgr.Config.characterTable[equipData.characterId]
        local tipStr = ""
        local tempRare = HeroMgr.GetHeroNowRare(equipData.characterId)
        local imageRare = tempRare >= 5 and 4 or tempRare
        if imageRare == CharacterRare.R then
            tipStr = string.format(LuaMgr.GetLangText("EquipWearViewModel_6"),tempConfig.name)
        elseif imageRare == CharacterRare.SR then
            tipStr = string.format(LuaMgr.GetLangText("EquipWearViewModel_7"),tempConfig.name)
        elseif imageRare == CharacterRare.SSR then
            tipStr = string.format(LuaMgr.GetLangText("EquipWearViewModel_8"),tempConfig.name)
        end
        LuaMgr.ShowConfirmSmallViewModel(tipStr,function()
            this.SendWearRequest(tempData,callBack)
        end,nil)
    end
end


this.RemoveEquipment = function()
    local tempData = {}
    tempData["ID"] = nil
    tempData["CharacterID"] = this.characterData.id
    this.SendWearRequest(tempData,function()
        this.SetOptions(false)
        this.rootAnim:Play("EquipWearPanel_Update",0,0)
        this.compareGroup,this.compareIndex = 0,0
        this.vm.data.notSelect = not this.isHaveEquip
        this.vm.data.wearDetails = this.isHaveEquip
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2801"].NameLan)
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
    end)
end


this.GetEquipAttribute = function(equipData)
    local dataJson = json.encode(equipData)
    dataJson = LuaMgr.GetEquipPropertyCopy(dataJson) 
    return json.decode(dataJson)
end


this.CreateAttrItem = function(param,attrData,type,additionalAttrs)
    local attrList,atkItem = {},{}
    local color = nil
    if type == 1 then
        color = UnityEngine.Color(121/225,112/225,83/225,1)
    else
        color = UnityEngine.Color(39/225,74/225,70/225,1)
    end
    if param then
        atkItem = {attrIcon = LuaMgr.GetSprite("AttributeIcon","Atk"),attrType = "Atk",numberValue = attrData["Atk"],
                         attrName = LuaMgr.GetLangText(ConfigHelper.GetAttrDes("Atk_FIX").NameLan),
                         attrValue = this.ToString(attrData["Atk"]),litre = false,drop = false,color = color,attrLock = false}
        this.TableInsert(attrList,atkItem)
        atkItem = {attrIcon = LuaMgr.GetSprite("AttributeIcon","Hp"),attrType = "Hp",numberValue = attrData["Hp"],
                        attrName = LuaMgr.GetLangText(ConfigHelper.GetAttrDes("Hp_FIX").NameLan),
                        attrValue = this.ToString(attrData["Hp"]),litre = false,drop = false,color = color,attrLock = false}
        this.TableInsert(attrList,atkItem)
    else
        local attrDes = {}
        for i = 1, #additionalAttrs do
            attrDes = ConfigMgr.Config.additionalAttrs[additionalAttrs[i].id]
            if not TableIsNull(attrDes) then
                atkItem = {attrIcon = LuaMgr.GetSprite("AttributeIcon",attrDes.addAttr),
                           attrName = LuaMgr.GetLangText(attrDes.NameLan),
                           litre = false,drop = false,attrType = attrDes.addAttr,color = color,attrId = attrDes.id,
                           numberValue = this.ToNumber(attrData[attrDes.addAttr]),attrLock = additionalAttrs[i].lock}
                if (attrDes.addAttr == "EnergyRecoveryCycle_FIX") then
                    atkItem.attrValue = LuaMgr.Division(tonumber(attrData[attrDes.addAttr]), 100)..attrDes.attrDisplayType;
                else
                    atkItem.attrValue = this.ToString(attrData[attrDes.addAttr])..attrDes.attrDisplayType;
                end
                this.TableInsert(attrList,atkItem)
            end
        end
    end
    return attrList
end


this.EquipAttrContrast = function()
    local wearAttrData,compareAttrData = {},{}
    

    wearAttrData = this.vm.data.equipDetailsData[1].wBasisAttr
    compareAttrData = this.vm.data.equipDetailsData[2].wBasisAttr
    this.OpenAttrTag(wearAttrData,compareAttrData)
    

    wearAttrData = this.vm.data.equipDetailsData[1].wSubjoinAttr
    compareAttrData = this.vm.data.equipDetailsData[2].wSubjoinAttr
    this.OpenAttrTag(wearAttrData,compareAttrData)
end


this.OpenAttrTag = function(wearAttrData,compareAttrData)
    local equalCount = 0
    for i = 1, #wearAttrData do
        if wearAttrData[i].attrType == nil then return end
        for j = 1, #compareAttrData do
            if compareAttrData[j].attrType == nil then return end
            if wearAttrData[i].attrType == compareAttrData[j].attrType then
                equalCount = equalCount + 1
                local wearValue,compareValue = wearAttrData[i].numberValue,compareAttrData[j].numberValue
                wearAttrData[i].litre = wearValue > compareValue
                wearAttrData[i].drop = wearValue < compareValue
                compareAttrData[j].litre = wearValue < compareValue
                compareAttrData[j].drop = wearValue > compareValue
                break
            else
                wearAttrData[i].litre,wearAttrData[i].drop = false,false
            end
        end
    end

    if equalCount == 0 then
        for i = 1, #wearAttrData do
            wearAttrData[i].litre = false
            wearAttrData[i].drop = false
        end
    end
end


this.CloseAttrTag = function()
    if this.compareGroup ~= 0 and this.compareIndex ~= 0 then
        if this.scrollView.dataList[this.compareGroup] ~= nil then
            if this.scrollView.dataList[this.compareGroup].data.equip[this.compareIndex] ~= nil then
                this.scrollView.dataList[this.compareGroup].data.equip[this.compareIndex].contrast = false
            end
        end
        this.scrollView:Refresh()
        this.compareGroup,this.compareIndex = 0,0
    end
    this.compareState = false
    this.vm.data.details = false
    this.rightAnim:Play("EquipWearPanel_Right_in",0.0)
    if this.vm.data.compareDetails then
        for i = 1, #this.vm.data.equipDetailsData[1].wBasisAttr do
            this.vm.data.equipDetailsData[1].wBasisAttr[i].litre = false
            this.vm.data.equipDetailsData[1].wBasisAttr[i].drop = false
        end
        for i = 1, #this.vm.data.equipDetailsData[1].wSubjoinAttr do
            this.vm.data.equipDetailsData[1].wSubjoinAttr[i].litre = false
            this.vm.data.equipDetailsData[1].wSubjoinAttr[i].drop = false
        end
    end
    this.UpdateButton()
    this.vm.data.compareDetails = false
end


this.SetOptions = function(state)
    this.vm.data.sortOptions = state
    if this.compareState then
        this.CloseAttrTag()
    end
    if this.vm.data.sortOptions then
        this.vm.data.sortArrow = Vector3(1,1,1)
    else
        this.vm.data.sortArrow = Vector3(1,-1,1)
    end
end


this.UpdateButton = function()
    this.vm.data.intensifyBtn = not this.compareState
    this.vm.data.intensifyLock = not this.intensifyLockState
    this.vm.data.wearBtn = not this.isHaveEquip
    this.vm.data.removeBtn = this.isHaveEquip and not this.compareState
end


this.CalculateExp = function(exp,level,rare)
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


this.ReplacePosition = function()
    if not this.isHaveEquip then
        return
    end
    local index = 0
    for i = 1, #this.wearEquipConfig do
        if this.wearEquipConfig[i].characterWearId == this.characterConfig.id then
            index = i
            break
        end
    end
    if index ~= 0 then
        local tempData = this.wearEquipConfig[index]
        table.remove(this.wearEquipConfig,index)
        this.TableInsert(this.wearEquipConfig,1,tempData)
    end
end


this.SendWearRequest = function(paramData,callBack)
    ApiMgr.Request("equipment/wear",paramData,true,function(result)
        this.characterData = DataMgr.Player.characters[this.characterConfig.id]
        this.isHaveEquip = this.characterData.wear ~= ""
        local tempType = this.sortType
        this.sortType = nil
        this.wearEquipConfig = nil
        this.GetEquipConfig()
        this.SetEquipSort(tempType)
        this.InitQSpine()
        this.SetEquipAudio()
        if callBack ~= nil then
            callBack()
        end
    end,nil,true)
end

this.SetEquipAudio = function()
    local num = math.random(1,2)
    local lineType = "equipLine_"..num
    if this.characterData.unlockedLines[lineType] == nil then
        lineType = "equipLine_1"
    end
local audioName = "character_"..lineType.."_"..this.characterData.id.."001"
    local audioPath = LuaMgr.GetCharacterLineTypeAudioPatn(this.characterConfig.id)
    local path = Path.Character_PATH..this.characterConfig.id.."/"..audioPath.."/"..audioName..".mp3"
    AudioMgr.Singleton:PlayVoice(path)
end

this.GetEquipConfig = function()
    if this.wearEquipConfig == nil then
        this.wearEquipConfig = {}
        local equipConfig,tempData,tempItem = nil,nil,nil
        PlayerBackpackMgr.equipJob = this.characterConfig.job
        PlayerBackpackMgr.UpdateSiftEquip()
        for i = 1, #PlayerBackpackMgr.equipData do
            tempData = PlayerBackpackMgr.equipData[i]
            equipConfig = ConfigMgr.Config.equipments[tempData.equipmentId]
            if equipConfig ~= nil then
                tempItem = {usingState = tempData.characterId ~= "",rareState = equipConfig.rare,starState = tempData.star,
                            gradeState = tempData.grade,levelState = tempData.level,timeState = tempData.createTime,
                            equipIdState = equipConfig.id,characterWearId = tempData.characterId,equipId = tempData.id,locking = tempData.locking}
                this.TableInsert(this.wearEquipConfig,tempItem)
            end
        end
        if this.isLock then
            for i = #this.wearEquipConfig, 1, -1 do
                if not this.wearEquipConfig[i].locking and this.wearEquipConfig[i].characterWearId ~= this.characterData.id then
                    table.remove(this.wearEquipConfig,i)
                end
            end
        end
    end
end

this.UpdateEquipSift = function()
    this.compareGroup,this.compareIndex = 0,0
    this.SetOptions(false)
    local tempType = this.sortType
    this.sortType = nil
    this.wearEquipConfig = nil
    this.GetEquipConfig()
    this.SiftEquipFindWear()
    this.SetEquipSort(tempType)
end


this.SiftEquipFindWear = function()
    if this.isHaveEquip and not IsNullOrEmpty(this.characterData.wear) then
        for i = 1, #this.wearEquipConfig do
            if this.wearEquipConfig[i].equipId == this.characterData.wear then
                return
            end
        end
        local tempData = DataMgr.Player.equipments[this.characterData.wear]
        local tempItem = nil
        tempItem = {usingState = tempData.characterId ~= "",rareState = tempData.rare,starState = tempData.star,
                    gradeState = tempData.grade,levelState = tempData.level,timeState = tempData.createTime,
                    equipIdState = tempData.equipmentId,characterWearId = tempData.characterId,equipId = tempData.id}
        this.TableInsert(this.wearEquipConfig,tempItem)
    end
end



this.LevelSort = function(equip1,equip2)
    if equip1.levelState ~= equip2.levelState then
        return equip1.levelState > equip2.levelState
    elseif equip1.rareState ~= equip2.rareState then
        return equip1.rareState > equip2.rareState
    elseif equip1.starState ~= equip2.starState then
        return equip1.starState > equip2.starState
    elseif equip1.usingState ~= equip2.usingState then
        return equip1.usingState and not equip2.usingState
    elseif equip1.equipIdState ~= equip2.equipIdState then
        return equip1.equipIdState > equip2.equipIdState
    elseif equip1.timeState ~= equip2.timeState then
        return equip1.timeState > equip2.timeState
    end
end



this.RareSort = function(equip1,equip2)
    if equip1.rareState ~= equip2.rareState then
        return equip1.rareState > equip2.rareState
    elseif equip1.levelState ~= equip2.levelState then
        return equip1.levelState > equip2.levelState
    elseif equip1.starState ~= equip2.starState then
        return equip1.starState > equip2.starState
    elseif equip1.usingState ~= equip2.usingState then
        return equip1.usingState and not equip2.usingState
    elseif equip1.equipIdState ~= equip2.equipIdState then
        return equip1.equipIdState > equip2.equipIdState
    elseif equip1.timeState ~= equip2.timeState then
        return equip1.timeState > equip2.timeState
    end
end



this.StarSort = function(equip1,equip2)
    if equip1.starState ~= equip2.starState then
        return equip1.starState > equip2.starState
    elseif equip1.levelState ~= equip2.levelState then
        return equip1.levelState > equip2.levelState
    elseif equip1.rareState ~= equip2.rareState then
        return equip1.rareState > equip2.rareState
    elseif equip1.usingState ~= equip2.usingState then
        return equip1.usingState and not equip2.usingState
    elseif equip1.equipIdState ~= equip2.equipIdState then
        return equip1.equipIdState > equip2.equipIdState
    elseif equip1.timeState ~= equip2.timeState then
        return equip1.timeState > equip2.timeState
    end
end



this.TimeSort = function(equip1,equip2)
    if equip1.timeState ~= equip2.timeState then
        return equip1.timeState > equip2.timeState
    elseif equip1.levelState ~= equip2.levelState then
        return equip1.levelState > equip2.levelState
    elseif equip1.rareState ~= equip2.rareState then
        return equip1.rareState > equip2.rareState
    elseif equip1.starState ~= equip2.starState then
        return equip1.starState > equip2.starState
    elseif equip1.usingState ~= equip2.usingState then
        return equip1.usingState and not equip2.usingState
    elseif equip1.equipIdState ~= equip2.equipIdState then
        return equip1.equipIdState > equip2.equipIdState
    end
end

this.OnClickGetEquip = function ()
    LuaMgr.ShowPanel("Laigu.ViewModel.Common.EquipGetViewModel");
end

return vm({
    data = data,
    command = command,
    hook = hook
})
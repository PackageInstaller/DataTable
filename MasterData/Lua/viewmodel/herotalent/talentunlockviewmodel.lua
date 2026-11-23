




local this = {vm = nil,spineCharacter = nil,materialView = nil,characterData = nil,
              characterConfig = nil,talentConfig = nil,strFormat = string.format,
              tableInsert = table.insert,goodsMaterial = nil,canTalentBool = nil,
              countColor = "<color=#FF0000>%d</color>",talentType = false,
              skinPicPath = "Assets/_BundleResources/Character/%s/Drawing/%s.png",
              itemIconPath = "Assets/_BundleResources/Images/ItemIcons/itemicon_home_",
              isAssisHero=false;
}


local data = {
    bodyPath = "",bodyEnabled = false,name = "",fullName = "",
    srImg = Vector3.zero,ssrImg = Vector3.zero,urImg = Vector3.zero,
    skinRoot = false,skinLockBtn = false,rareLockBtn = false,
    consumeText = "",consumeIcon = DefaultTexture,
    
    upRareRoot = false,upRareTip1 = "",upRareTip2 = "",
    rareIcon = DefaultSprite,
    conditions = {{lock = Vector3.zero,unLock = Vector3.zero,conditionText = ""}},

    isDisableBtnByAssis=true,
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.TalentUnlockViewModel)
        end
    },
    examineCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not this.canTalentBool then
                local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2101"].NameLan)
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
                return
            else
                if not this.talentType then
                    local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2135"].NameLan)
                    LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
                    return
                end
            end
            this.SendTalent()
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.spineCharacter = vm.behaviour.transform:Find("root/Middle/BodyRoot/Mask/Body"):GetComponent("UISpineCharacter")
        this.materialView = vm.behaviour.transform:Find("root/Middle/Material"):GetComponent("RectTransform")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.spineCharacter:Clear()
        for i = 1, #this.goodsMaterial do
            this.goodsMaterial[i]:Clear()
        end
        this.goodsMaterial = {}
    end,
    before_destroy = function(vm)
        this = nil
    end,
}


this.InitParameter = function()
    if this.vm.behaviour.Params.Length == 0 then return end
    this.goodsMaterial = {}
    this.canTalentBool = true

    local characterId = this.vm.behaviour.Params[0]
    this.isAssisHero=PlayerAssistMgr.IsCurAssistCharacter(characterId);
    this.vm.data.isDisableBtnByAssis=not this.isAssisHero;
    if this.isAssisHero then
        this.characterData = PlayerAssistMgr.GetCurAssist_CharacterData();
    else
        this.characterData = DataMgr.Player.characters[characterId]
    end


    if TableIsNull(this.characterData) then
        return
    end
    this.characterConfig = ConfigMgr.Config.characterTable[characterId]
    local talentId = this.vm.behaviour.Params[1]
    this.talentConfig = ConfigMgr.Config.characterTalentMap[talentId]
    
    local type = this.vm.behaviour.Params[2]
    this.talentType = type
    local skin = nil
    if type then

        local tempConfig = this.GetSkinConfig(this.talentConfig.rewardItemId)
        if tempConfig ~= nil then
            skin = tempConfig.skinID
        end
        this.SetSkinData()
    else
        skin = this.characterData.curSkin
        this.SetUpRareData()
    end
    this.SetCondition()
    this.SetConsume()
    this.SetMaterial()
    this.vm.data.skinLockBtn = not this.isAssisHero and type and not this.canTalentBool
    this.vm.data.rareLockBtn = not type and not this.canTalentBool
    this.UpdateSpineUICharacter(skin)
    this.vm.data.skinRoot = type
    this.vm.data.upRareRoot = not type
end

this.SetSkinData = function()
    this.vm.data.srImg = Vector3.zero
    this.vm.data.ssrImg = Vector3.zero
    this.vm.data.urImg = Vector3.zero

end

this.SetUpRareData = function()
    local strForm = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2358"].NameLan)
    this.vm.data.upRareTip1 = this.strFormat(strForm,this.SetRareStr(this.characterConfig.rare))
    this.vm.data.upRareTip2 = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2359"].NameLan)
    local iconName = ConfigMgr.Config.talentBankMap[this.talentConfig.talentBankId].icon
    this.vm.data.rareIcon = LuaMgr.GetSprite("TalentIcon",iconName)
    this.vm.data.srImg = this.characterConfig.rare == CharacterRare.R and Vector3.one or Vector3.zero
    this.vm.data.ssrImg = this.characterConfig.rare == CharacterRare.SR and Vector3.one or Vector3.zero
    this.vm.data.urImg = this.characterConfig.rare == CharacterRare.SSR and Vector3.one or Vector3.zero
end

this.UpdateSpineUICharacter = function(skin)
    this.vm.data.name = LuaMgr.GetLangText(this.characterConfig.namelan)
    this.vm.data.fullName = LuaMgr.GetLangText(this.characterConfig.FullnameLan)
    local path = this.strFormat(this.skinPicPath,this.characterData.id,skin)
    if path ~= "" then
        this.spineCharacter:Clear()
        this.vm.data.bodyPath = path
        this.vm.data.bodyEnabled = true
    end
end

this.SetCondition = function()
    local tempList,tempItem,str = {},{},""
if this.talentConfig.requireLevel ~= 0 then
        if this.talentConfig.requireLevel > this.characterData.level then
            this.canTalentBool = false
        end
        str = this.strFormat(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2355"].NameLan),this.talentConfig.requireLevel)
        tempItem = {
            lock = this.talentConfig.requireLevel > this.characterData.level and Vector3.one or Vector3.zero,
            unLock = this.talentConfig.requireLevel > this.characterData.level and Vector3.zero or Vector3.one,
            conditionText = str}
        this.tableInsert(tempList,tempItem)
    end
if this.talentConfig.requireStar ~= 0 then
        if this.talentConfig.requireStar > this.characterData.star then
            this.canTalentBool = false
        end
        str = this.strFormat(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2356"].NameLan),this.talentConfig.requireStar)
        tempItem = {
            lock = this.talentConfig.requireStar > this.characterData.star and Vector3.one or Vector3.zero,
            unLock = this.talentConfig.requireStar > this.characterData.star and Vector3.zero or Vector3.one,
            conditionText = str}
        this.tableInsert(tempList,tempItem)
    end
    local strForm = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2364"].NameLan)
    strForm = this.strFormat(strForm,this.SetRareStr(this.characterConfig.rare - 1))
    tempItem = {lock = Vector3.zero,unLock = Vector3.one,conditionText = strForm}
    this.tableInsert(tempList,tempItem)













    this.vm.data.conditions = tempList
end
this.SetConsume = function()
    if type(this.talentConfig.requireCoin) ~= "function" then
        local id,count = this.talentConfig.requireCoin[1].id,this.talentConfig.requireCoin[1].count
        if DataHelper.GetItemCountById(id) < count then
            count = this.strFormat(this.countColor,count)
            this.canTalentBool = false
        end
        this.vm.data.consumeText = count
        this.vm.data.consumeIcon = LuaMgr.GetTexture(this.itemIconPath..id..".png")
    end
end

this.SetMaterial = function()
    if type(this.talentConfig.requireItems) == "function" then return end
    local length = ConfigHelper.GetTableLength(this.talentConfig.requireItems)
    local material = nil
    for i = 1, length do
        if this.goodsMaterial[i] == nil then
            material = MaterialItem.New(this.materialView)
            this.tableInsert(this.goodsMaterial,material)
        end
        if DataHelper.GetItemCountById(this.talentConfig.requireItems[i].id) < this.talentConfig.requireItems[i].count then
            this.canTalentBool = false
        end
        this.goodsMaterial[i]:SetData(i,this.talentConfig.requireItems[i].id,this.talentConfig.requireItems[i].count,0.65)
    end
end

this.SendTalent = function()
    local tempData = {}
    tempData["TalentID"] = this.talentConfig.id
    ApiMgr.Request("activate_talent", tempData,true,function(result)
        local re = json.decode(result)
        if re.code == 0 then
            LuaMgr.InvokeUIEventListeners(UIEventConst.UpdateActivateSkin)
            LuaMgr.ShowItemRewared(json.encode(re.result.rewards))
            LuaMgr.HidePanel(UIName.TalentUnlockViewModel)
        end
    end,nil,true)
end

this.GetSkinConfig = function(goodsId)
    if TableIsNull(this.characterData) or IsNullOrEmpty(this.characterData.id) then
        return
    end
    local skins = ConfigMgr.Config.characterSkins[this.characterData.id]
    if skins == nil then return end
    for i = 1, #skins do
        if skins[i].mapItemsID == goodsId then
            return skins[i]
        end
    end
    return nil
end

this.SetRareStr = function(rare)
    if rare == 1 then
        return LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2360"].NameLan)
    elseif rare == 2 then
        return LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2361"].NameLan)
    elseif rare == 3 then
        return LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2362"].NameLan)
    elseif rare == 4 then
        return LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2363"].NameLan)
    end
    return ""
end

return vm({
    data = data,
    command = command,
    hook = hook
})
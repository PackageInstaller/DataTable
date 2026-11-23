




local this = {vm = nil,index = 1,rootAnim,dataInfo = nil,canClick = false,skinData,characterData,
              spineCharacter = nil,HeroManager = CS.Laigu.ViewModel.Hero.HeroManager,
              ITEM_ICON_PATH = "Assets/_BundleResources/Images/ItemIcons/itemicon_",
              OPEN_PANEL_SOUND_PATH = "Assets/_BundleResources/Audio/UI/skin_get.mp3",
              voicePath = "Assets/_BundleResources/Character/",textScrollPos = nil}

local data = {
    bodyPath = "",
    bodyEnabled = false,
    linesText = "",
    skinLogo = DefaultSprite,
    skinNull = Vector3.zero,
    newImage = Vector3.zero,
    repeatImage = Vector3.zero,
    wearBtn = Vector3.zero,
    already = Vector3.zero,
    heroName = "",
    skinName = "",
    skipBtn = Vector3.zero,
    rewardList = {{itemRare = DefaultSprite,itemIcon = DefaultTexture,numText = ""}}
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.NewCardSkinViewModel)
        end
    },
    wearCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SendChangedSkin()
        end
    },
    nextCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.canClick then
                this.canClick = not this.canClick
                this.index = this.index + 1
                if this.index > #this.dataInfo then
                    LuaMgr.HidePanel(UIName.NewCardSkinViewModel)
                else
                    this.InitSkinInfo()
                end
            end
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.rootAnim = this.vm.behaviour.transform:Find("root"):GetComponent("Animator")
        this.spineCharacter = this.vm.behaviour.transform:Find("root/AnimMask/BodyObject/Body"):GetComponent("UISpineCharacter")
        this.textScrollPos = this.vm.behaviour.transform:Find("root/AnimMask/Text/TextScroll/Viewport/Text"):GetComponent("RectTransform")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.textScrollPos.anchoredPosition = Vector2.zero
        AudioMgr.Singleton:PlayUISFX(this.OPEN_PANEL_SOUND_PATH);
        this.index = 1
        this.dataInfo = json.decode(this.vm.behaviour.Params[0])
        this.InitSkinInfo()
        this.canClick = false
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        AudioMgr.Singleton:StopVoice(false)
        this.spineCharacter:Clear()
        this.vm.data.bodyPath="";
        LuaMgr.RemoveTimer(TimerConst.SkinShowPlayVoice)
        LuaMgr.RemoveTimer(TimerConst.FriendlyCloseTime)
        LuaMgr.InvokeUIEventListeners(UIEventConst.SkinBayEvent)
    end,
    before_destroy = function(vm)
        this = nil
    end,
}
this.InitSkinInfo = function()
    this.vm.data.already = Vector3.zero
    this.rootAnim:Play("UI_NewCardSkinPanel_01",0,0)
    this.vm.data.skipBtn = #this.dataInfo > 1 and Vector3.one or Vector3.zero
    this.skinData = ConfigHelper.GetHeroSkinConfig(this.dataInfo[this.index].Card)
    this.characterData = ConfigMgr.Config.characterTable[this.skinData.characterId]
    if this.skinData.skinLOGO == nil or this.skinData.skinLOGO == 0 then
        this.vm.data.skinNull = Vector3.zero
    else
        this.vm.data.skinLogo = LuaMgr.GetSprite("SkinLogo","SkinLogo_"..this.skinData.skinLOGO)
        this.vm.data.skinNull = Vector3.one
    end
    this.vm.data.newImage = this.dataInfo[this.index].Type == "CharacterSkins" and Vector3.one or Vector3.zero
    this.vm.data.repeatImage = this.dataInfo[this.index].Type == "CharacterSkins" and Vector3.zero or Vector3.one
    this.vm.data.heroName = LuaMgr.GetLangText(this.characterData.namelan)
    this.vm.data.skinName = LuaMgr.GetLangText(this.skinData.skinNamelan)
    this.SetspineUICharacter(this.skinData.characterId,this.skinData.skinID)
    this.vm.data.rewardList = {}
    this.vm.data.wearBtn = Vector3.zero
    if this.dataInfo[this.index].Type == "Items" and #this.dataInfo[this.index].Items > 0 then
        local tempItem,tempList = {},{}
        local id,itemData = "",nil
        for i = 1, #this.dataInfo[this.index].Items do
            id = this.dataInfo[this.index].Items[i].ID
            itemData = ConfigMgr.Config.itemMap[id]
            tempItem = {
                itemRare = LuaMgr.GetSprite("ItemRare","itemRare"..itemData.rare),
                itemIcon = LuaMgr.GetTexture(this.ITEM_ICON_PATH..id..".png"),
                numText = "+"..this.dataInfo[this.index].Items[i].Count}
            table.insert(tempList,tempItem)
        end
        this.vm.data.rewardList = tempList
    else
        if DataMgr.Player.characters[this.characterData.id] ~= nil then
            this.vm.data.wearBtn = Vector3.one
        end
    end
    LuaMgr.AddTimer(TimerConst.SkinShowPlayVoice,function()
        this.PlayCharacterVoice(this.skinData.characterId,this.skinData.skinID)
    end,2.3,1,false)
    LuaMgr.AddTimer(TimerConst.FriendlyCloseTime,function()
        this.canClick = true
    end,3.5,1,false)
end
this.SetspineUICharacter = function(cardId,skinId)
    local path = this.HeroManager.SetCharacterDrawing(this.spineCharacter,cardId,skinId)
    if path ~= "" then
        this.spineCharacter:Clear()
        this.vm.data.bodyPath = path
        this.vm.data.bodyEnabled = true
    end
    this.spineCharacter.colorR = 0
    this.spineCharacter.colorG = 0
    this.spineCharacter.colorB = 0
    this.vm.data.linesText = this.HeroManager.CheckCharacterLine(cardId,"StrengthenLine_3",skinId)
end
this.PlayCharacterVoice = function(cardId,skinId)
    local audioName = "character_".."strengthenLine_3".."_"..skinId
    path = this.voicePath..cardId.."/Audio/"..audioName..".mp3"
    local audioSource = AudioMgr.Singleton:PlayVoice(path)
    if audioSource == nil then
        audioName = "character_".."strengthenLine_3".."_"..cardId.."001"
        path = this.voicePath..cardId.."/Audio/"..audioName..".mp3"
        audioSource = AudioMgr.Singleton:PlayVoice(path)
    end
end
this.SendChangedSkin = function()
    local tempData = {}
    tempData["CharacterID"] = this.skinData.characterId
    tempData["CharacterSkin"] = this.skinData.skinID
    ApiMgr.Request("update_skin",tempData,true,function(result)
        local re = json.decode(result)
        if re.code == 0 then
            this.vm.data.already = Vector3.one
            this.vm.data.wearBtn = Vector3.zero
            LuaMgr.InvokeUIEventListeners(UIEventConst.ObtainSkinWear)
        end
    end,nil,true)
end
return vm({
    data = data,
    command = command,
    hook = hook
})
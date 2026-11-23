




local this = {vm = nil,tagTime = 0,materialIndex = 0,downTime = 0,interval = 0,
              ToString = tostring,ToNumber = tonumber,TableInsert = table.insert,StringFormat = string.format,
              levelMax = 10,coroutine_key = nil,isClick = true,canConfirm = true,characterId = nil,
              heroFriendlyLevel = nil,nowLevelExp = nil,nowLevelExpMax = nil,materialCost = {},levelItems = nil,
              panelAnimName = "UI_HeroFriendlyPanel_01",levelMaxAnimName = "UI_FriendlyPopup_NotRoot",
              expFormat = "Lv.%d：<color=#9E2D2D>%d</color>/%d",AUDIO_PATH_UP = "Assets/_BundleResources/Audio/UI/Friendship_up.mp3",
              AUDIO_PATH_LOCK = "Assets/_BundleResources/Audio/UI/Friendship_unlock.mp3",
              AUDIO_LIKE_PATH = "%s/%s/character_giftVictoryLine_%s%s.mp3",
              AUDIO_GENERAL_PATH = "%s/%s/character_giftLoseLine_%s%s.mp3",
              BADGE_ICON_PATH = "Assets/_BundleResources/Images/FriendlyIcon/"}

local uiRoot = nil
local panelNode = {
    panelAnimator = {path = "root",type = "Animator"},
    spineCharacter = {path = "root/_Middle/BodyObject/Body",type = "UISpineCharacter"},
    badge_Lock = {path = "root/_Right/Content/LockRoot",type = "GameObject"},
    badge_UnLock = {path = "root/_Right/Content/UnLockRoot",type = "GameObject"},
    badge_Icon = {path = "root/_Right/Content/UnLockRoot/RawImage",type = "RawImage"},
    emptyBtn = {path = "root/_Right/Content/EmptyBtn",type = "GameObject"},
    confirmBtn = {path = "root/_Right/Content/ConfirmBtn",type = "GameObject"},
    confirmBtnText = {path = "root/_Right/Content/ConfirmBtn/Text",type = "Text"},
    heroName = {path = "root/_Right/Content/NameText",type = "Text"},
    effect_Love = {path = "root/_Middle/UI_HeroFriendlyPanel_love",type = "GameObject"},
    effect_UnLock = {path = "root/_Middle/ItemView/UI_HFP_Stage_Unlock",type = "GameObject"},
    effect_Lightup = {path = "root/_Middle/ItemView/UI_HFP_Stage_Lightup",type = "GameObject"},
    effect_Breathing = {path = "root/_Middle/ItemView/UI_HFP_Stage_Breathing",type = "GameObject"},
    effect_Shine = {path = "root/_Right/Content/UI_HeroFriendly_Shine",type = "GameObject"},
    materialRect = {path = "root/_Right/Content/MaterialScroll",type = "ScrollRect"},
    levelItemRect = {path = "root/_Middle/ItemView",type = "ScrollRect"},
    likeRoot = {path = "root/_Middle/Like",type = "GameObject"},
    textRoot = {path = "root/_Middle/TextObject",type = "GameObject"},
    textLine = {path = "root/_Middle/TextObject/Image/Text",type = "UIText"},
    allBtn = {path = "root/_Right/Content/AllBtn",type = "GameObject"},
}

local data = {
    bodyPath = "",
    materialItems = {{itemId = "",itemRare = DefaultSprite,itemIcon = DefaultTexture,
                     like = false,numText = "",choose = false,chooseNum = "",name = ""}}
}

local command = {

    itemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not this.isClick then return end
            this.materialIndex = param + 1

            local id = this.vm.data.materialItems[this.materialIndex].itemId
            if DataHelper.GetItemCountById(id) == 0 then
                LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, id, true, false, false, 0);
                return
            end
            this.AddSelectProp()
            this.UpdateButtonState()
            this.canConfirm = false
        end
    },

    pressCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not this.isClick then return end
            this.materialIndex = param + 1
            this.tagTime = UnityEngine.Time.realtimeSinceStartup
            this.downTime = UnityEngine.Time.realtimeSinceStartup
            LuaMgr.AddUpdate(this.OnUpdate)
        end
    },

    liftUpCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not this.isClick then return end
            LuaMgr.RemoveUpdate(this.OnUpdate)
            this.UpdateButtonState()
            this.canConfirm = false
            LuaMgr.AddTimer(TimerConst.FriendlyInterval,function()
                this.canConfirm = true
            end,0.2,1,false)
        end
    },

    minusCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not this.isClick then return end
            if LuaMgr.IsGuide() then return end
            local index = param + 1
            this.MinusSelectProp(index)
            this.UpdateButtonState()
        end
    },

    emptyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not this.isClick then return end
            if ConfigHelper.GetTableLength(this.materialCost) <= 0 then return end
            this.AllEmpty()
            this.UpdateButtonState()
        end
    },

    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not this.isClick then return end
            if this.canConfirm then this.SendConfirm() end
        end
    },

    levelDetails = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not this.isClick then return end
            local level = this.ToNumber(param)
            local barValue = 0
            if DataMgr.Player.characters[this.characterId] ~= nil then
                barValue = this.GetLevelExp(level,DataMgr.Player.characters[this.characterId].prestige)
                if barValue >= 1 and level > DataMgr.Player.characters[this.characterId].prestigeLevel then
                    this.SendUpLevel()
                else
                    LuaMgr.ShowLuaPanel(UIName.FriendlyPopupViewModel,this.characterId,level)
                end
            end
        end
    },
    allCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not this.isClick then return end
            local count = 0
            local itemId = ""
            for i = 1, #this.vm.data.materialItems do
                itemId = this.vm.data.materialItems[i].itemId
                count = count + DataHelper.GetItemCountById(itemId)
            end
            if count <= 0 then
                local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10154"].NameLan)
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
                return
            end
            if this.heroFriendlyLevel == this.levelMax or this.nowLevelExp >= this.nowLevelExpMax then
                tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2096"].NameLan)
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
                LuaMgr.RemoveUpdate(this.OnUpdate)
                return
            end
            this.materialCost = {}
            this.FastSelectMaterial()
            this.UpdateButtonState()
            this.canConfirm = true
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        local itemLayer = this.vm.behaviour.transform:Find("root/_Middle/ItemView/Viewport/Content"):GetComponent("Transform")
        if itemLayer ~= nil then this.GetFriendlyNode(itemLayer) end
        uiRoot = {}
        UITool.Parse(vm.behaviour.transform,uiRoot,panelNode)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        uiRoot.panelAnimator:Play(this.panelAnimName,0,0)
        this.InitParameter()
        this.SetScrollRect()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.ClosePanel()
    end,
    before_destroy = function(vm)
        this.DeletePanel()
        this = nil
    end,
}


this.InitParameter = function()
    if this.vm.behaviour.Params.Length > 0 then
        this.isClick = true
        this.canConfirm = true
        this.characterId = this.ToString(this.vm.behaviour.Params[0])
        local character = DataMgr.Player.characters[this.characterId]
        this.heroFriendlyLevel = character == nil and 0 or character.prestigeLevel
        uiRoot.heroName.text = LuaMgr.GetLangText(ConfigMgr.Config.characterTable[this.characterId].namelan)
        uiRoot.confirmBtnText.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2098"].NameLan)
        uiRoot.badge_Lock:SetActive(this.heroFriendlyLevel ~= this.levelMax)
        uiRoot.badge_UnLock:SetActive(this.heroFriendlyLevel == this.levelMax)
        
        local skinId = character == nil and this.characterId.."001" or character.curSkin
        this.SetSpineCharacter(skinId)
        this.SetFriendlyLevel()
        if character ~= nil then
            this.SetLevelText(character.prestige)
        end
        this.SetMaterial()
        this.UpdateButtonState()
        this.vm.behaviour:UpdateTopBar("",this.OnBack)
    end
end

this.SetScrollRect = function()
    uiRoot.materialRect.verticalNormalizedPosition = 1
    local horizontalPos = 0
    if this.heroFriendlyLevel ~= nil then
        if this.heroFriendlyLevel >= 4 then
            horizontalPos = 1 / 9 * this.heroFriendlyLevel
        end
    end
    uiRoot.levelItemRect.horizontalNormalizedPosition = horizontalPos
end

this.SetSpineCharacter = function(skinId)
    local path = HeroManager.SetCharacterDrawing(uiRoot.spineCharacter,this.characterId,skinId)
    if (path ~= "") then
        this.vm.data.bodyPath = path
    end
    if this.heroFriendlyLevel == this.levelMax then
        local id = ConfigMgr.Config.characterPreferences[this.characterId].friendshipTalent[this.levelMax][1]
        uiRoot.badge_Icon.texture = LuaMgr.GetTexture(this.BADGE_ICON_PATH.."friendly_"..id..".png")
    end
end

this.SetFriendlyLevel = function()
    local isUnLock,levelType,barValue = false,0,0
    for i = 1, #this.levelItems do
        levelType = this.GetLevelType(i)
        if levelType == 1 then
            this.levelItems[i].lockImg.sprite = LuaMgr.GetSprite("FriendlyLevel","LockType_1")
        else
            this.levelItems[i].lockImg.sprite = LuaMgr.GetSprite("FriendlyLevel","LockType_2")
        end
        this.levelItems[i].unLockImg.sprite = LuaMgr.GetSprite("FriendlyLevel","LevelType_"..levelType)
        if DataMgr.Player.characters[this.characterId] ~= nil then
            barValue = this.GetLevelExp(i,DataMgr.Player.characters[this.characterId].prestige)
            this.levelItems[i].redPoint:SetActive(barValue >= 1 and i > DataMgr.Player.characters[this.characterId].prestigeLevel)
        end
        this.levelItems[i].addExpBar.fillAmount = barValue
        this.levelItems[i].expBar.fillAmount = barValue
        
        if this.levelItems[i].redPoint.activeSelf then
            uiRoot.effect_Breathing.transform:SetParent(this.levelItems[i].effectRoot)
            uiRoot.effect_Breathing.transform.localPosition = Vector3.zero
            uiRoot.effect_Breathing:SetActive(true)
        end
        
        isUnLock = (i <= this.heroFriendlyLevel) or (i - this.heroFriendlyLevel == 1)
        this.levelItems[i].unLock:SetActive(isUnLock)
        if isUnLock and i <= this.heroFriendlyLevel then
            this.levelItems[i].levelImg.sprite = LuaMgr.GetSprite("FriendlyLevel","Friendly_"..i)
        else
            this.levelItems[i].levelImg.sprite = LuaMgr.GetSprite("FriendlyLevel","Lock_"..i)
        end
        this.levelItems[i].expRoot:SetActive(false)
    end
end

this.SetLevelText = function(exp)
    if this.heroFriendlyLevel == this.levelMax then return end
    local nextLevel = this.heroFriendlyLevel + 1 > this.levelMax and this.levelMax or this.heroFriendlyLevel + 1

    this.nowLevelExp = exp - this.GetBeforeAllExp(this.heroFriendlyLevel)
    this.nowLevelExpMax = ConfigMgr.Config.friendshipLevelUp[this.ToString(nextLevel)]-ConfigMgr.Config.friendshipLevelUp[this.ToString(nextLevel-1)]
    this.levelItems[nextLevel].expText.text = this.StringFormat(this.expFormat,nextLevel,this.nowLevelExp,this.nowLevelExpMax)
    this.levelItems[nextLevel].expRoot:SetActive(true)
end

this.SetMaterial = function()

    if PlayerBackpackMgr.friendData == nil then
        PlayerBackpackMgr.friendData = {}
        for key,value in pairs(ConfigMgr.Config.itemMap) do
            if value.type == 14 then
                this.TableInsert(PlayerBackpackMgr.friendData,key)
            end
        end
    end
    this.vm.data.materialItems = {}
    local tempList,tempItem = {},nil
    local id,itemConfig = nil,nil
    for i = 1, #PlayerBackpackMgr.friendData do
        id = PlayerBackpackMgr.friendData[i]
        itemConfig = ConfigMgr.Config.itemMap[id]
        tempItem = {itemId = id,like = this.IsLikeMaterial(id),
                    itemRare = LuaMgr.GetSprite("ItemRare","itemRare"..itemConfig.rare),
                    itemIcon = LuaMgr.GetTexture(ConfigHelper.GetItemIconPath(id)),
                    numText = this.ToString(DataHelper.GetItemCountById(id)),choose = false,
                    chooseNum = "",name = LuaMgr.GetLangText(itemConfig.nameLan),rareSort = itemConfig.rare}
        this.TableInsert(tempList,tempItem)
    end
    table.sort(tempList,this.ListSort)
    this.vm.data.materialItems = tempList
end

this.SetCharacterText = function()
    local isLike = false
    for k, v in pairs(this.materialCost) do
        if this.IsLikeMaterial(k) then
            isLike = true
            uiRoot.likeRoot:SetActive(true)
            uiRoot.effect_Love:SetActive(true)
            break
        end
    end


local skinId = "001"
    local str,path = nil,nil
    local audioPath = LuaMgr.GetCharacterLineTypeAudioPatn(this.characterId)
    if isLike then
        str = HeroManager.CheckCharacterLine(this.characterId,"GiftVictoryLine",this.characterId..skinId)
        path = this.StringFormat(this.AUDIO_LIKE_PATH,this.characterId,audioPath,this.characterId,skinId)
    else
        str = HeroManager.CheckCharacterLine(this.characterId,"GiftLoseLine",this.characterId..skinId)
        path = this.StringFormat(this.AUDIO_GENERAL_PATH,this.characterId,audioPath,this.characterId,skinId)
    end
    uiRoot.textLine.text = str
    uiRoot.textRoot:SetActive(true)
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/friendship_gift.mp3")
    local audioSource = AudioMgr.Singleton:PlayVoice(Path.Character_PATH..path)
    local closeTime = audioSource == nil and 5 or audioSource.clip.length
    LuaMgr.AddTimer(TimerConst.FriendlyCloseTime,function()
        uiRoot.likeRoot:SetActive(false)
        uiRoot.textRoot:SetActive(false)
        uiRoot.effect_Love:SetActive(false)
    end,closeTime,1,false)
end

this.UpdateButtonState = function()
    uiRoot.emptyBtn:SetActive(ConfigHelper.GetTableLength(this.materialCost) > 0)
    uiRoot.allBtn:SetActive(not uiRoot.emptyBtn.activeSelf)
    if ConfigHelper.GetTableLength(this.materialCost) <= 0 then
        uiRoot.confirmBtn.transform.anchoredPosition = Vector2(-7.5,-306)
    else
        uiRoot.confirmBtn.transform.anchoredPosition = Vector2(-7.5,-306)
    end
end
this.OnUpdate = function()
    if UnityEngine.Time.realtimeSinceStartup - this.downTime > 0 and UnityEngine.Time.realtimeSinceStartup - this.downTime < 1 then
        this.interval = 0.2
    elseif UnityEngine.Time.realtimeSinceStartup - this.downTime >= 1 and UnityEngine.Time.realtimeSinceStartup - this.downTime < 2 then
        this.interval = 0.1
    else
        this.interval = 0
    end
    if UnityEngine.Time.realtimeSinceStartup - this.tagTime > this.interval then
        this.tagTime = UnityEngine.Time.realtimeSinceStartup
        this.AddSelectProp()
    end
end

this.AddSelectProp = function()

    local tipStr = ""
    if this.heroFriendlyLevel == this.levelMax or this.nowLevelExp >= this.nowLevelExpMax then
        tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2096"].NameLan)
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
        LuaMgr.RemoveUpdate(this.OnUpdate)
        return
    end
    local id = this.vm.data.materialItems[this.materialIndex].itemId
    if this.materialCost[id] == nil then
        if DataHelper.GetItemCountById(id) <= 0 then
            tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2094"].NameLan)
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
            LuaMgr.RemoveUpdate(this.OnUpdate)
            return
        else
            this.materialCost[id] = 1
            this.vm.data.materialItems[this.materialIndex].choose = true
        end
    else
        if DataHelper.GetItemCountById(id) <= this.materialCost[id] then
            tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2095"].NameLan)
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
            LuaMgr.RemoveUpdate(this.OnUpdate)
            return
        else
            this.materialCost[id] = this.materialCost[id] + 1
        end
    end
    this.CalculateAddExp(id,true)
    this.vm.data.materialItems[this.materialIndex].chooseNum = this.materialCost[id]
end

this.MinusSelectProp = function(index)
    local id = this.vm.data.materialItems[index].itemId
    if this.materialCost[id] ~= nil and this.materialCost[id] > 0 then
        this.materialCost[id] = this.materialCost[id] - 1
        if this.materialCost[id] <= 0 then
            this.materialCost[id] = nil
        end
    end
    this.CalculateAddExp(id,false)
    if this.materialCost[id] ~= nil then
        this.vm.data.materialItems[index].chooseNum = this.materialCost[id]
    else
        this.vm.data.materialItems[index].choose = false
    end
end

this.AllEmpty = function()
    this.materialCost = {}
    for i = 1, #this.vm.data.materialItems do
        if this.vm.data.materialItems[i].choose then
            this.vm.data.materialItems[i].choose = false
        end
    end
    if DataMgr.Player.characters[this.characterId] ~= nil then
        this.SetLevelText(DataMgr.Player.characters[this.characterId].prestige)
    end
    local nextLevel = this.heroFriendlyLevel + 1 > this.levelMax and this.levelMax or this.heroFriendlyLevel + 1
    this.levelItems[nextLevel].addExpBar.fillAmount = this.levelItems[nextLevel].expBar.fillAmount
end

this.SendConfirm = function()
    if ConfigHelper.GetTableLength(this.materialCost) <= 0 then
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2097"].NameLan)
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
        return
    end
    local tempData = {}
    tempData["CharacterID"] = this.characterId
    tempData["Cost"] = this.materialCost
    ApiMgr.Request("add_prestige",tempData,true,function(result)
        local re = json.decode(result)
        if re.code == 0 then
            this.ConfirmSucceed()
            this.SetCharacterText()
            this.materialCost = {}
            this.UpdateButtonState()
        end
    end,nil,true)
end

this.SendUpLevel = function()
    local tempData = {}
    tempData["CharacterID"] = this.characterId
    ApiMgr.Request("level_up_prestige",tempData,true,function(result)
        local re = json.decode(result)
        if re.code == 0 then
            if DataMgr.Player.characters[this.characterId] ~= nil then
                this.heroFriendlyLevel = DataMgr.Player.characters[this.characterId].prestigeLevel
            end
            this.SetScrollRect()
            this.PlayEffect(this.heroFriendlyLevel)
        end
    end,nil,true)
end

this.ConfirmSucceed = function()
    local level = this.heroFriendlyLevel + 1 > this.levelMax and this.levelMax or this.heroFriendlyLevel + 1
    local barValue = 0
    if DataMgr.Player.characters[this.characterId] ~= nil then
        barValue = this.GetLevelExp(level,DataMgr.Player.characters[this.characterId].prestige)
        this.levelItems[level].addExpBar.fillAmount = barValue
        this.levelItems[level].expBar.fillAmount = barValue
        this.levelItems[level].redPoint:SetActive(barValue >= 1 and level > DataMgr.Player.characters[this.characterId].prestigeLevel)
    end
    if this.levelItems[level].redPoint.activeSelf then
        uiRoot.effect_Breathing.transform:SetParent(this.levelItems[level].effectRoot)
        uiRoot.effect_Breathing.transform.localPosition = Vector3.zero
        uiRoot.effect_Breathing:SetActive(true)
    end
    this.SetMaterial()
end

this.PlayEffect = function()
    this.isClick = false
    local nextLevel = this.heroFriendlyLevel + 1 > this.levelMax and this.levelMax or this.heroFriendlyLevel + 1
    if this.coroutine_key ~= nil then
        coroutine_runner.stop(this.coroutine_key)
    end
    this.levelItems[this.heroFriendlyLevel].expRoot:SetActive(false)
    this.levelItems[this.heroFriendlyLevel].redPoint:SetActive(false)
    this.levelItems[this.heroFriendlyLevel].levelImg.sprite = LuaMgr.GetSprite("FriendlyLevel","Friendly_"..this.heroFriendlyLevel)
    uiRoot.effect_Breathing:SetActive(false)
    this.coroutine_key = coroutine_runner.start(function()
        local objRoot = nil
        if this.heroFriendlyLevel + 1 <= this.levelMax then

            AudioMgr.Singleton:PlayUISFX(this.AUDIO_PATH_UP)
            objRoot = this.levelItems[nextLevel].effectRoot
            uiRoot.effect_Lightup.transform:SetParent(objRoot)
            uiRoot.effect_Lightup.transform.localPosition = Vector3.zero
            uiRoot.effect_Lightup:SetActive(true)
            coroutine_runner.wait(1)

            AudioMgr.Singleton:PlayUISFX(this.AUDIO_PATH_LOCK)
            uiRoot.effect_UnLock.transform:SetParent(objRoot)
            uiRoot.effect_UnLock.transform.localPosition = Vector3.zero
            uiRoot.effect_UnLock:SetActive(true)
            coroutine_runner.wait(0.4)
            LuaMgr.ShowLuaPanel(UIName.FriendlyTipsViewModel,this.characterId,this.heroFriendlyLevel)

            this.levelItems[nextLevel].unLock:SetActive(true)
            local prestige, prestigeLevel = 0, 0
            if DataMgr.Player.characters[this.characterId] ~= nil then
                prestige = DataMgr.Player.characters[this.characterId].prestige
                prestigeLevel = DataMgr.Player.characters[this.characterId].prestigeLevel
            end
            barValue = this.GetLevelExp(nextLevel, prestige)
            this.levelItems[nextLevel].redPoint:SetActive(barValue >= 1 and nextLevel > prestigeLevel)
            this.levelItems[nextLevel].addExpBar.fillAmount = barValue
            this.levelItems[nextLevel].expBar.fillAmount = barValue
            if this.heroFriendlyLevel ~= nil and this.levelItems[this.heroFriendlyLevel] ~= nil then
                objRoot = this.levelItems[this.heroFriendlyLevel].effectRoot
            end
            if this.levelItems[nextLevel].redPoint.activeSelf then
                uiRoot.effect_Breathing.transform:SetParent(this.levelItems[nextLevel].effectRoot)
                uiRoot.effect_Breathing.transform.localPosition = Vector3.zero
                uiRoot.effect_Breathing:SetActive(true)
            end
            if DataMgr.Player.characters[this.characterId] ~= nil then
                this.SetLevelText(DataMgr.Player.characters[this.characterId].prestige)
            end
        else
            uiRoot.effect_Breathing:SetActive(false)
            local id = ConfigMgr.Config.characterPreferences[this.characterId].friendshipTalent[this.levelMax][1]
            uiRoot.badge_Icon.texture = LuaMgr.GetTexture(this.BADGE_ICON_PATH.."friendly_"..id..".png")
            uiRoot.panelAnimator:Play(this.levelMaxAnimName,0,0)
            coroutine_runner.wait(0.6)
            uiRoot.badge_UnLock:SetActive(true)
            coroutine_runner.wait(0.2)
            uiRoot.effect_Shine:SetActive(true)
            coroutine_runner.wait(0.9)
            LuaMgr.ShowLuaPanel(UIName.FriendlyPopupViewModel,this.characterId,this.heroFriendlyLevel)
        end
        uiRoot.effect_Lightup:SetActive(false)
        uiRoot.effect_UnLock:SetActive(false)
        uiRoot.effect_Shine:SetActive(false)
        this.isClick = true
    end)
end

this.CalculateAddExp = function(id,type)
    local config = ConfigMgr.Config.itemMap[id]

    local basisValue = ConfigMgr.Config.constants.GiftFriendship[this.ToString(config.rare)]

    local additionalValue = ConfigMgr.Config.constants.GiftFriendshipUp[this.ToString(config.rare)]
    if type then
        this.nowLevelExp = this.nowLevelExp + basisValue
        if this.IsLikeMaterial(id) then
            this.nowLevelExp = this.nowLevelExp + additionalValue
        end
    else
        this.nowLevelExp = this.nowLevelExp - basisValue
        if this.IsLikeMaterial(id) then
            this.nowLevelExp = this.nowLevelExp - additionalValue
        end
    end
    local nextLevel = this.heroFriendlyLevel + 1 > this.levelMax and this.levelMax or this.heroFriendlyLevel + 1
    this.levelItems[nextLevel].expText.text = this.StringFormat(this.expFormat,nextLevel,this.nowLevelExp,this.nowLevelExpMax)
    this.levelItems[nextLevel].addExpBar.fillAmount = this.nowLevelExp / this.nowLevelExpMax
end

this.FastSelectMaterial = function()
    local item = nil
    local basisValue = 0
    local additionalValue = 0
    local allValue = 0
    local needCount = 0
    local haveCount = 0
    local exp = 0
    for i = 1, #this.vm.data.materialItems do
        this.materialIndex = i
        item = ConfigMgr.Config.itemMap[this.vm.data.materialItems[i].itemId]
        haveCount = DataHelper.GetItemCountById(item.id)
        if haveCount <= 0 then
            goto continue
        end
        basisValue = ConfigMgr.Config.constants.GiftFriendship[this.ToString(item.rare)]
        if not this.vm.data.materialItems[i].like then
            additionalValue = 0
        else
            additionalValue = ConfigMgr.Config.constants.GiftFriendshipUp[this.ToString(item.rare)]
        end
        allValue = basisValue + additionalValue
        exp = this.nowLevelExpMax - this.nowLevelExp
        needCount = math.floor(exp / allValue)
        if needCount <= 0 then
            goto continue
        else
            if needCount > haveCount then
                needCount = haveCount
            end
            for j = 1, needCount do
                this.AddSelectProp()
            end
        end
        ::continue::
    end

    if exp > 0 then
        local chooseCount = 0
        for i = #this.vm.data.materialItems, 1,-1 do
            item = ConfigMgr.Config.itemMap[this.vm.data.materialItems[i].itemId]
            haveCount = DataHelper.GetItemCountById(item.id)
            chooseCount = this.materialCost[item.id] == nil and 0 or this.materialCost[item.id]
            if haveCount > 0 and chooseCount < haveCount then
                this.materialIndex = i
                this.AddSelectProp()
                return
            end
        end
    end
end



this.GetLevelType = function(level)
    if ConfigMgr.Config.characterPreferences[this.characterId] ~= nil then
        local config = ConfigMgr.Config.characterPreferences[this.characterId].friendshipTalent
        for i = 2, #config[level],2 do
            if config[level][i] == "1" then return 1 end
            if config[level][i] == "2" then return 2 end
            if config[level][i] == "3" or config[level][i] == "4" then return 3 end
        end
    end
    return 3
end

this.GetLevelExp = function(level,exp)

    if level == nil or this == nil or this.heroFriendlyLevel == nil then
        return 0
    end
    if level <= this.heroFriendlyLevel then
        return 1
    else
        if level - this.heroFriendlyLevel == 1 then

            local beforeLevel = level - 1 < 1 and 1 or level - 1

local beforeLevelExp = this.GetBeforeAllExp(beforeLevel)

            local levelExp = ConfigMgr.Config.friendshipLevelUp[this.ToString(level)]-beforeLevelExp
            return (exp - beforeLevelExp) / levelExp
        end
    end
    return 0
end

this.GetBeforeAllExp = function(level)
    return ConfigMgr.Config.friendshipLevelUp[this.ToString(level)]
end

this.IsLikeMaterial = function(id)
    if ConfigMgr.Config.characterPreferences[this.characterId] ~= nil then
        for i = 1, #ConfigMgr.Config.characterPreferences[this.characterId].preference do
            if ConfigMgr.Config.characterPreferences[this.characterId].preference[i] == id then
                return true
            end
        end
    end
    return false
end

this.GetFriendlyNode = function(transform)

    local friendly = {
        lockImg = {path = "Lock",type = "Image"},
        unLock = {path = "UnLock",type = "GameObject"},
        unLockImg = {path = "UnLock",type = "Image"},
        addExpBar = {path = "AddExpBar",type = "Image"},
        expBar = {path = "ExpBar",type = "Image"},
        levelImg = {path = "Level",type = "Image"},
        expRoot = {path = "LevelText",type = "GameObject"},
        redPoint = {path = "RedPoint",type = "GameObject"},
        expText = {path = "LevelText/Text",type = "Text"},
        effectRoot = {path = "Effect",type = "RectTransform"},
    }
    
    this.levelItems = {}
    local object = nil
    for i = 1, transform.childCount - 1 do
        object = transform:Find("Item"..i)
        local item = {}
        UITool.Parse(object,item,friendly)
        if this.levelItems[i] == nil then
            this.TableInsert(this.levelItems,i,item)
        end
    end
    friendly = nil
end
this.ListSort = function(item1,item2)

    if item1.like ~= item2.like then
        return item1.like and not item2.like
    else
        if item1.rareSort ~= item2.rareSort then
            return item1.rareSort > item2.rareSort
        end
    end
end
this.OnBack = function()
    if not this.isClick then return end
    LuaMgr.Back()
end
this.ClosePanel = function()
    this.characterId = nil
    this.heroFriendlyLevel = nil
    this.nowLevelExp = nil
    this.nowLevelExpMax = nil
    this.materialCost = {}
    uiRoot.spineCharacter:Clear()
    LuaMgr.RemoveUpdate(this.OnUpdate)
    LuaMgr.RemoveTimer(TimerConst.FriendlyInterval)
    LuaMgr.RemoveTimer(TimerConst.FriendlyCloseTime)
    uiRoot.effect_Lightup:SetActive(false)
    uiRoot.effect_UnLock:SetActive(false)
    uiRoot.effect_Breathing:SetActive(false)
    uiRoot.likeRoot:SetActive(false)
    uiRoot.effect_Love:SetActive(false)
    uiRoot.textRoot:SetActive(false)
    uiRoot.effect_Shine:SetActive(false)
    if this.coroutine_key ~= nil then
        coroutine_runner.stop(this.coroutine_key)
    end
end

this.DeletePanel = function()
    uiRoot = nil
    this.levelItems = nil
    panelNode = nil
    if this.coroutine_key ~= nil then
        coroutine_runner.stop(this.coroutine_key)
    end
end
return vm({
    data = data,
    command = command,
    hook = hook
})
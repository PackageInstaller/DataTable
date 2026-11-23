




require("ViewModel/Home/CharacterHighSkin");
local this = {vm = nil,tipType = nil,characterId = nil,characterIndex = nil,characterList = nil,
              characterData = nil,spineCharacter = nil,qSpineCharacter = nil,skinDragBehaviour = nil,
              scrollCountTransform = nil,spineContentRect = nil,characterJob = nil,selectIndex = 0,
              contentWidth = 0,buySkinId = nil,isDrag = false,localPosition = nil,spinePosLimit = {},
              HeroManager = CS.Laigu.ViewModel.Hero.HeroManager,bodyPost = Vector2(-330,0),bodyTarPost = Vector2(-110,0),
              bgPost = Vector3(-223,31.5,0),bgTarPost = Vector3(0,31.5,0),countFormat = "%d<color=#d2c2a9>/%d</color>",
              skinPicPath = "Assets/_BundleResources/Character/%s/Drawing/%s.png",isClick = false,spineMaterial = nil,
              isPlayingAnim=false}

local data = {
    bodyPath = "",bodyEnabled = false,
    contentSize = Vector2(0,0),bodyScale = Vector3.one,
    bodyPos = Vector2.zero,bgImage = Vector3.zero, 
    skinDetails = false,setting = false,
    effectIcon = false,qIcon = false,voiceIcon = false,highSkin=false,bgIcon=false;
    heroName = "",fullName = "",haveCount = "",
    textLan = "",tipScale = false,tipText = "",
    wearScale = Vector3.zero,replaceScale = Vector3.zero,
    buyScale = Vector3.zero,slider = 0.0,buyText = "",
    leftBtn = false,rightBtn = false,leftAnimName = "",
    leftScale = Vector3.zero,qPicScale = Vector3.zero,
    tipRoot = false,tipRootText = "",tipPos = Vector2.zero,
    storyBtn = false,story = false,storyText = "",
    notState = false,notMagnifyBtn = false,
    skinList = {{skinPic = DefaultTexture,typeIcon = DefaultSprite,iconScale = false,skinName = "",effect = false,
                 qPic = false,voice = false,mask = false,iconMask = false,lock = false,notHave = false,voice2 = false,
                 high = false,bgIcon = false}};
    playAnimAlpha=1.0;
}

local command = {
    skinItemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = param + 1
            if this.selectIndex == index then return end
            this.vm.data.skinList[this.selectIndex].mask = true
            this.vm.data.tipRoot = false
            this.tipType = ""
            if this.vm.data.skinList[this.selectIndex].logoBool then
                this.vm.data.skinList[this.selectIndex].iconMask = true
            end
            this.vm.data.skinList[index].mask = false
            if this.vm.data.skinList[index].logoBool then
                this.vm.data.skinList[index].iconMask = false
            end
            this.selectIndex = index
            local skinId = this.vm.data.skinList[index].skinId





            this.UpdateSpineUICharacter(skinId)
            this.ContentMove(true)
        end
    },
    changedCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SendChangedSkin()
        end
    },
    buyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SendBuySkin()
        end
    },
    returnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.NormalStatus()
            this.CloseAnim()
        end
    },
    magnifyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.MagnifyStatus()
        end
    },
    notMagnifyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2656"].NameLan)
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
        end
    },
    sliderCommand = {
        type = XLuaCommandType.Float,
        execute = function(vm,param)
            this.UpdateBodyScale(param)
        end
    },
    rightCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.characterIndex + 1 > #this.characterList then
                this.characterIndex = 1
            else
                this.characterIndex = this.characterIndex + 1
            end
            this.SwitchCharacter()
        end
    },
    leftCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.characterIndex - 1 <= 0 then
                this.characterIndex = #this.characterList
            else
                this.characterIndex = this.characterIndex - 1
            end
            this.SwitchCharacter()
        end
    },
    tipRootCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OpenTipRoot(param)
        end
    },
    tipRootCommand2 = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OpenTipRoot2(param)
        end
    },
    storyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.isClick then
                UnityEngine.PlayerPrefs.SetInt("skinStory",0)
                this.InitStory()
            end
        end
    },
    storyClickCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.isClick then
                UnityEngine.PlayerPrefs.SetInt("skinStory",1)
                this.InitStory()
            end
        end
    },
    pvClickCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
           this.PlayPVExecute();
        end
    },
    idleClickCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.PlayIdleExecute();
        end
    },
    skinClickCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if SettingHelper.GetCurImageQuality()==ESetting.Image_QualityLow then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("25509"))
                return
            end
            if this.isPlayingAnim then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("25504"))
                return
            end
            this.PlaySkinExecute();
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.spineMaterial = vm.behaviour.transform:Find("root/Middle/Contnet/BodyObject/Body"):GetComponent("UIRefRawImage")
        this.spineCharacter = vm.behaviour.transform:Find("root/Middle/Contnet/BodyObject/Body"):GetComponent("UISpineCharacter")
        this.qSpineCharacter = vm.behaviour.transform:Find("root/Right/SkinDetails/QPic/Spine"):GetComponent("UISpineCharacter")
        this.spineContentRect = vm.behaviour.transform:Find("root/Middle/Contnet/BodyObject"):GetComponent("RectTransform")
        this.scrollCountTransform = vm.behaviour.transform:Find("root/Right/SkinDetails/Skin/SkinView/Viewport/Content"):GetComponent("RectTransform")
        this.skinDragBehaviour = vm.behaviour.transform:Find("root/Middle/Contnet/BodyObject"):GetComponent("OnDragBehaviour")
        this.skinDragBehaviour.onDrag = this.OnDrag
        this.skinDragBehaviour.onPointerDown = this.PointerDown
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.characterHighSkinVM=nil;
        this.lastHighSkinClick=nil;
        this.InitParameter()
        this.InitSkinList()
        this.InitSkinDetails()
        if this.characterIndex == nil then
            this.UpdateSpineUICharacter(this.buySkinId)
        else
            this.UpdateSpineUICharacter(this.characterData.curSkin)
        end
        this.ContentMove(false)
        this.vm.behaviour:UpdateTopBar("show")
        LuaMgr.AddUIEventListener(UIEventConst.SkinBayEvent,this.UpdateBuyResults)
        LuaMgr.AddUIEventListener(UIEventConst.ObtainSkinWear,this.UpdateWear)
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.characterId = nil
        this.characterIndex = nil
        this.characterList = nil
        this.characterData = nil
        this.selectIndex = 1
        this.buySkinId = nil
        this.spineCharacter:Clear()
        this.qSpineCharacter:Clear()
        this.vm.data.tipRoot = false
        this.tipType = ""
        LuaMgr.RemoveUIEventListener(UIEventConst.SkinBayEvent,this.UpdateBuyResults)
        LuaMgr.RemoveUIEventListener(UIEventConst.ObtainSkinWear,this.UpdateWear)
        LuaMgr.RemoveTimer(TimerConst.HeroSkinCloseTextAnim)
        LuaMgr.RemoveTimer(TimerConst.HeroSkinCloseClict)

        if this.characterHighSkinVM~=nil then
            this.characterHighSkinVM:Destroy();
        end
    end,
    before_destroy = function(vm)
        this = nil
    end,
}


this.InitParameter = function()
    if this.vm.behaviour.Params.Length == 0 then
        this.characterIndex = HeroParameter.characterIndex
        this.characterList = HeroParameter.characterList

        if this.characterList == nil then
            this.characterList = {}
        end
        this.characterId = this.characterList[this.characterIndex]
        if IsNullOrEmpty(this.characterId) then
            this.characterId = "V0064"
        end

        this.vm.data.leftBtn = #this.characterList > 1
        this.vm.data.rightBtn = #this.characterList > 1
        this.characterData = DataMgr.Player.characters[this.characterId]
    elseif this.vm.behaviour.Params.Length == 2 then
        this.characterIndex = nil
        this.characterId = this.vm.behaviour.Params[0]
        this.characterData = DataMgr.Player.characters[this.characterId]
        this.buySkinId = this.vm.behaviour.Params[1]
        this.vm.data.leftBtn = false
        this.vm.data.rightBtn = false
    end
end

this.InitSkinList = function()
    local skinTable = ConfigMgr.Config.characterSkins[this.characterId]
    if skinTable == nil then return end
    local tempList = {};
    local tempItem;
    local skinPath;
    local skinConfig;
    local _bool = nil
    local sysTime = LuaMgr.Timestamp();
    local index = 0
    for i = 1, #skinTable do
        skinConfig = skinTable[i];
        if (sysTime > skinConfig.UnlockDate) then
            index = index + 1
            skinPath = this.HeroManager.GetCharacterCard(this.characterId, skinConfig.skinID)
            _bool = DataHelper.IsContainsSkin(this.characterId,skinConfig.skinID)





            tempItem = {skinPic = LuaMgr.GetTexture(skinPath),typeIcon = DefaultSprite,iconScale = false,
                        skinName = LuaMgr.GetLangText(skinConfig.skinNamelan),skinId = skinConfig.skinID,
                        effect = false,qPic = false,voice = false,mask = true,iconMask = false,lock = false}

            if skinConfig.skinLOGO == nil or skinConfig.skinLOGO == 0 then
                tempItem.logoBool = false
                tempItem.iconScale = false
            else
                tempItem.typeIcon = LuaMgr.GetSprite("SkinLogo","SkinLogo_"..skinConfig.skinLOGO)
                tempItem.iconScale = true
                tempItem.logoBool = true
            end
            tempItem.lock = skinConfig.skinLOGO ~= 102 and not _bool
            tempItem.notHave = skinConfig.skinLOGO == 102 and not _bool

            if this.characterIndex ~= nil then
                if skinConfig.skinID == this.characterData.curSkin then
                    this.selectIndex = index
                    tempItem.mask = false
                end
                tempItem.iconMask = tempItem.logoBool and skinConfig.skinID ~= this.characterData.curSkin
            else
                if skinConfig.skinID == this.buySkinId then
                    this.selectIndex = index
                    tempItem.mask = false
                end
                tempItem.iconMask = tempItem.logoBool and skinConfig.skinID ~= this.buySkinId
            end

            tempItem.effect = this.SettingSkinLogo(skinConfig.resLOGO,"effects")
            tempItem.qPic = this.SettingSkinLogo(skinConfig.resLOGO,"Qspine")
            tempItem.voice = this.SettingSkinLogo(skinConfig.resLOGO,"lines")
            local isHighSkin = not IsNull(skinConfig.highskin) and skinConfig.highskin > 0
            tempItem.voice2 = isHighSkin
            tempItem.high = isHighSkin
            tempItem.bgIcon = isHighSkin
            table.insert(tempList,tempItem)
        end
    end
    this.vm.data.skinList = tempList
    this.contentWidth = 163 * #tempList + (#tempList - 1) * 2 + 4
    this.vm.data.contentSize = Vector2(this.contentWidth,408)
end

this.InitSkinDetails = function()
    local characterConfig = ConfigMgr.Config.characterTable[this.characterId]
    this.characterJob = characterConfig.job
    this.vm.data.heroName = LuaMgr.GetLangText(characterConfig.namelan)
    this.vm.data.fullName = LuaMgr.GetLangText(characterConfig.FullnameLan)
    this.UpDateCountText()
    this.NormalStatus()
end

this.InitStory = function(skinFileLan,animBool)
    if skinFileLan == "" then
        this.vm.data.storyBtn = false
        this.vm.data.story = false
    else
        this.isClick = false
        LuaMgr.AddTimer(TimerConst.HeroSkinCloseClict, function()
            this.isClick = true
            LuaMgr.RemoveTimer(TimerConst.HeroSkinCloseClict)
        end, 0.66, -1, false)
        if skinFileLan ~= nil then this.vm.data.storyText = LuaMgr.GetLangText(skinFileLan) end
        local story = UnityEngine.PlayerPrefs.GetInt("skinStory")
        if story == 0 then
            this.isClick = true
            this.vm.data.story = true
            this.vm.data.storyBtn = false
            this.vm.data.leftAnimName = "ani_ui_HeroSkinPanel_Left"
        else
            if animBool ~= nil then
                this.vm.data.story = false
                this.vm.data.storyBtn = true
            else
                this.vm.data.storyBtn = true
                this.vm.data.leftAnimName = "ani_ui_HeroSkinPanel_Left01"
                LuaMgr.AddTimer(TimerConst.HeroSkinCloseTextAnim, function()
                    this.vm.data.story = false
                    LuaMgr.RemoveTimer(TimerConst.HeroSkinCloseTextAnim)
                end, 0.4, -1, false)
            end
        end
    end
end

this.UpDateCountText = function()
    local num = 1
    if ConfigHelper.GetTableLength(DataMgr.Player.characterSkins) ~= 0 then
        if DataMgr.Player.characterSkins[this.characterId] ~= nil then
            num = #DataMgr.Player.characterSkins[this.characterId] + num
        end
    end
    local time = LuaMgr.Timestamp()
    local characterSkins = ConfigMgr.Config.characterSkins[this.characterId]
    if characterSkins~=nil then
        local numConfig = 0
        for i = 1, #characterSkins do
            if time > characterSkins[i].UnlockDate then
                numConfig = numConfig + 1
            end
        end
        this.vm.data.haveCount = string.format(this.countFormat,num,numConfig)
    end
end


this.UpdateSpineUICharacter = function(skinId)
    this.vm.data.playAnimAlpha=1.0;
    this.isPlayingAnim=false;
    this.characterHighSkinVM=nil
    local path = ""
    local _bool = DataHelper.IsContainsSkin(this.characterId,skinId)
    if not _bool and skinId == this.characterId.."002" then
        path = string.format(this.skinPicPath,this.characterId,skinId)
        this.vm.data.notState = true
        local material = LuaMgr.GetMaterial("Assets/_BundleResources/Shader/Res/Materials/UISpriteGray.mat")
        this.spineMaterial.material = material
        this.spineMaterial.color = UnityEngine.Color(1,1,1,210 / 255)
    else
        path = this.HeroManager.SetCharacterDrawing(this.spineCharacter,this.characterId,skinId)
        this.vm.data.notState = false
        this.spineMaterial.material = nil
        this.spineMaterial.color = UnityEngine.Color(1,1,1,1)
    end
    if path ~= "" then
        this.spineCharacter:Clear()
        this.vm.data.bodyPath = path
        this.vm.data.bodyEnabled = true
    end
    this.vm.data.notMagnifyBtn = not _bool
    this.skinConfig = ConfigHelper.GetHeroSkinConfig(skinId)

    if this.skinConfig == nil then
        return
    end
    this.InitStory(this.skinConfig.skinFileLan,false)
    this.UpdateBtnStatus(_bool,skinId)
    this.vm.data.textLan = this.skinConfig.tipsLan == nil and "" or LuaMgr.GetLangText(this.skinConfig.tipsLan)
    this.vm.data.effectIcon = this.SettingSkinLogo(this.skinConfig.resLOGO,"effects")
    this.vm.data.qIcon = this.SettingSkinLogo(this.skinConfig.resLOGO,"Qspine")

    local isHighSkin = not IsNull(this.skinConfig.highskin) and this.skinConfig.highskin>0;
    this.vm.data.voiceIcon = isHighSkin
    this.vm.data.highSkin = isHighSkin
    this.vm.data.bgIcon = isHighSkin
    this.vm.data.qPicScale = this.vm.data.qIcon and Vector3.one or Vector3.zero
    if this.vm.data.qIcon then
        this.qSpineCharacter:SetBattle(this.characterId,skinId,"",this.characterJob)
    end

end

this.SendChangedSkin = function()
    local tempData = {}
    tempData["CharacterID"] = this.characterId
    tempData["CharacterSkin"] = this.vm.data.skinList[this.selectIndex].skinId
    ApiMgr.Request("update_skin",tempData,true,function(result)
        local re = json.decode(result)
        if re.code == 0 then
            this.characterData = DataMgr.Player.characters[this.characterId]
            this.UpdateBtnStatus(true,this.characterData.curSkin)
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2651"].NameLan)
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
        end
    end,nil,true)
end

this.SendBuySkin = function()
    local skinId = this.vm.data.skinList[this.selectIndex].skinId
    local skinConfig = ConfigHelper.GetHeroSkinConfig(skinId)
    local charge = this.GetSkinCharge(skinConfig)
    LuaMgr.ShowLuaPanel(UIName.ShopSkinsConfirmViewModel,charge.Id)
end

this.UpdateBuyResults = function()
    local skinId = this.vm.data.skinList[this.selectIndex].skinId
    for i = 1, #this.vm.data.skinList do
        if this.vm.data.skinList[i].skinId == skinId then
            this.vm.data.skinList[i].lock = false
            break
        end
    end
    this.UpdateSpineUICharacter(skinId)
    this.UpdateBtnStatus(true,skinId)
    this.UpDateCountText()
end

this.UpdateWear = function()
    this.characterData = DataMgr.Player.characters[this.characterId]
    this.UpdateBtnStatus(true,this.characterData.curSkin)
end


this.NormalStatus = function()
    this.vm.data.bodyPos = this.bodyPost
    this.vm.data.bgImage = this.bgPost
    this.vm.data.bodyScale = Vector3.one
    this.vm.data.setting = false
    this.vm.data.skinDetails = true
    this.vm.data.leftScale = Vector3.one
    this.isDrag = false
end

this.CloseAnim = function()
    DOTWeen.To(
            function() return this.bodyTarPost end,
            function(vector)
                this.vm.data.bodyPos = vector
            end,
            this.bodyPost, 0.2):SetEase(Ease.OutCubic)
    DOTWeen.To(function() return this.bgTarPost end,
            function(vector)
                this.vm.data.bgImage = vector
            end, this.bgPost, 0.2):SetEase(Ease.OutCubic)
    this.vm.behaviour:UpdateTopBar("show")
end


this.MagnifyStatus = function()
    this.isDrag = true
    this.vm.data.skinDetails = false
    this.vm.data.leftScale = Vector3.zero

    local bodyTweener = DOTWeen.To(
            function() return this.bodyPost end,
            function(vector)
                this.vm.data.bodyPos = vector
            end,
            this.bodyTarPost, 0.4):SetEase(Ease.OutCubic)
    bodyTweener.onComplete=function()
        this.vm.data.setting = true
    end
    DOTWeen.To(function() return this.bgPost end,
            function(vector)
                this.vm.data.bgImage = vector
            end, this.bgTarPost, 0.4):SetEase(Ease.OutCubic)
    this.vm.data.slider = 0.0
    this.vm.behaviour:UpdateTopBar("hide")
    local halfScreenWidth = LuaMgr.ScreenWidth() / 2
    this.spinePosLimit={halfScreenWidth,-halfScreenWidth,512,-512}
    this.vm.data.tipRoot = false
    this.tipType = ""
end

this.UpdateBodyScale = function(sliderValue)
    this.vm.data.bodyScale = Vector3.one + Vector3(sliderValue,sliderValue,0)
end


this.UpdateBtnStatus = function(_bool,skinId)
    if this.characterData == nil then
        this.vm.data.buyText=""
        this.vm.data.replaceScale = Vector3.zero
        this.vm.data.wearScale = Vector3.zero
        local skinConfig = ConfigHelper.GetHeroSkinConfig(skinId)
        local charge = this.GetSkinCharge(skinConfig)
        local timeBool = false
        if charge ~=nil  then
            timeBool = (charge.StartTime == 0 or charge.EndTime == 0) or (LuaMgr.Timestamp() > charge.StartTime and LuaMgr.Timestamp() < charge.EndTime)
            local skinData = HeroRedDataHelper.GetSkinByItemID(charge.Reward[1].id)
            if skinData~=nil and (not HeroRedDataHelper.CheckSkinIDById(skinData.characterId,skinData.skinID)) and timeBool then
                this.vm.data.tipScale = false
                this.vm.data.buyScale = Vector3.one
            else
                this.vm.data.tipScale = true
                this.vm.data.buyScale = Vector3.zero

                if DataHelper.IsContainsSkin(this.characterId,skinData.skinID) then
                    this.vm.data.tipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["12200"].NameLan)
                else
                    this.vm.data.tipText = LuaMgr.GetLangText(skinConfig.getdescriptionLan)
                end
            end
        else
            this.vm.data.tipScale = true
            this.vm.data.buyScale = Vector3.zero
            this.vm.data.tipText = LuaMgr.GetLangText(skinConfig.getdescriptionLan)
        end
    else
        this.vm.data.buyText = ""
        if _bool and skinId == this.characterData.curSkin then
            this.vm.data.wearScale = Vector3.one
            this.vm.data.tipScale = false
            this.vm.data.buyScale = Vector3.zero
            this.vm.data.replaceScale = Vector3.zero
        elseif _bool and skinId ~= this.characterData.curSkin then
            this.vm.data.wearScale = Vector3.zero
            this.vm.data.tipScale = false
            this.vm.data.replaceScale = Vector3.one
            this.vm.data.buyScale = Vector3.zero
        elseif not _bool then
            this.vm.data.wearScale = Vector3.zero
            this.vm.data.replaceScale = Vector3.zero
            local skinConfig = ConfigHelper.GetHeroSkinConfig(skinId)
            local charge = this.GetSkinCharge(skinConfig)
            local timeBool = false
            if charge ~=nil  then
                timeBool = (charge.StartTime == 0 or charge.EndTime == 0) or (LuaMgr.Timestamp() > charge.StartTime and LuaMgr.Timestamp() < charge.EndTime)
                local skinData = HeroRedDataHelper.GetSkinByItemID(charge.Reward[1].id)
                if skinData~=nil and (not HeroRedDataHelper.CheckSkinIDById(skinData.characterId,skinData.skinID)) and timeBool then
                    this.vm.data.tipScale = false
                    this.vm.data.buyScale = Vector3.one
                else
                    this.vm.data.tipScale = true
                    this.vm.data.buyScale = Vector3.zero

                    if DataHelper.IsContainsSkin(this.characterId,skinData.skinID)  then
                        this.vm.data.tipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["12200"].NameLan)
                    else
                        this.vm.data.tipText = LuaMgr.GetLangText(skinConfig.getdescriptionLan)
                    end
                end
            else
                this.vm.data.tipScale = true
                this.vm.data.buyScale = Vector3.zero
                this.vm.data.tipText = LuaMgr.GetLangText(skinConfig.getdescriptionLan)
            end
        end
    end
end

this.GetSkinCharge = function(skinConfig)
    local charge = HeroRedDataHelper.GetChargeById(skinConfig.goodsID)
    local curTime = LuaMgr.Timestamp()

    if charge == nil or curTime < charge.StartTime or curTime >= charge.EndTime then
        charge = HeroRedDataHelper.GetChargeById(skinConfig.discountGoodsID)

        if charge == nil or curTime < charge.StartTime or curTime >= charge.EndTime then
            charge = nil
        end
    end
    return charge
end

this.SwitchCharacter = function()
    HeroParameter.characterIndex = this.characterIndex
    this.characterId = this.characterList[this.characterIndex]
    this.characterData = DataMgr.Player.characters[this.characterId]
    this.InitSkinList()
    this.InitSkinDetails()
    this.UpdateSpineUICharacter(this.characterData.curSkin)
    this.vm.data.tipRoot = false
    this.tipType = ""
    this.ContentMove(false)
end

this.OpenTipRoot = function(typeStr)
    if this.vm.data.tipRoot == true and this.tipType == typeStr then
        this.vm.data.tipRoot = false
        this.tipType = ""
        return
    end
    local position = Vector2.zero
    this.tipType = typeStr
    if typeStr == "effect" then
        position = Vector2(-532,181)
        this.vm.data.tipRootText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2653"].NameLan)
    elseif typeStr == "qicon" then
        if this.vm.data.effectIcon == false then
            position = Vector2(-532,181)
        else
            position = Vector2(-532,129)
        end
        this.vm.data.tipRootText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2652"].NameLan)
    end
    this.vm.data.tipPos = position
    this.vm.data.tipRoot = true
end

this.OpenTipRoot2 = function(typeStr)
    if this.vm.data.tipRoot == true and this.tipType == typeStr then
        this.vm.data.tipRoot = false
        this.tipType = ""
        return
    end
    local position = Vector2.zero
    if typeStr == "voice" then
        position = Vector2(-560,208)
        this.vm.data.tipRootText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2654"].NameLan)
    elseif typeStr == "anim" then
        position = Vector2(-560,156)
        this.vm.data.tipRootText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["25501"].NameLan)
    elseif typeStr == "bg" then
        position = Vector2(-560,102)
        this.vm.data.tipRootText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["25503"].NameLan)
    end
    this.vm.data.tipPos = position
    this.vm.data.tipRoot = true
end


this.SettingSkinLogo = function(resLOGO,logoStr)
    local _bool = false
    for i = 1, #resLOGO do
        if resLOGO[i] == logoStr then
            _bool = true
            break
        end
    end
    return _bool
end



this.ContentMove = function(animBool)
    local posX = 0
    local length = #this.vm.data.skinList
    local viewWidth = this.scrollCountTransform.sizeDelta.x - 436

    if this.selectIndex == nil then this.selectIndex = 1 end
    
    if this.selectIndex == 1 or this.selectIndex == 2 then
        posX = 0
    else
        posX = -(viewWidth / length * this.selectIndex)
    end
    if animBool then
        DOTWeen.To(function() return this.scrollCountTransform.anchoredPosition end,
                function(vector)
                    this.scrollCountTransform.anchoredPosition = vector
                end, Vector2(posX,0), 0.5):SetEase(Ease.OutCubic)
    else
        this.scrollCountTransform.anchoredPosition = Vector2(posX,0)
    end
end

this.PointerDown = function(eventData)
    if not this.isDrag then return end
    this.localPosition = LuaMgr.Screen2Local(eventData.position,this.spineContentRect)
end

this.OnDrag = function(eventData)
    if not this.isDrag then return end
    local tarPos = LuaMgr.Screen2Local(eventData.position,this.spineContentRect)
    local dirVector = tarPos - this.localPosition
    if this.vm.data.bodyPos.x > this.spinePosLimit[1] and dirVector.x > 0 then
        dirVector = Vector2(0,dirVector.y)
    end
    if this.vm.data.bodyPos.x < this.spinePosLimit[2] and dirVector.x < 0 then
        dirVector = Vector2(0,dirVector.y)
    end
    if this.vm.data.bodyPos.y > this.spinePosLimit[3] and dirVector.y > 0 then
        dirVector = Vector2(dirVector.x,0)
    end
    if this.vm.data.bodyPos.y < this.spinePosLimit[4] and dirVector.y < 0 then
        dirVector = Vector2(dirVector.x,0)
    end
    this.vm.data.bodyPos = this.vm.data.bodyPos + dirVector
end


this.PlayPVExecute=function()
    if ConfigMgr.Config.CharacterHighSkinMap[this.skinConfig.skinID]~=nil then
        local cfgHightSkin=ConfigMgr.Config.CharacterHighSkinMap[this.skinConfig.skinID];
        if not IsNullOrEmpty(cfgHightSkin.pv) then
            AudioMgr.Singleton:StopVoice();
            LuaMgr.ShowLuaPanel(UIName.PlayVideoMaxViewModel,cfgHightSkin.pv);
        end
    end
end

this.PlayIdleExecute=function()
    if this.spineCharacter~=nil then
        if this.characterHighSkinVM==nil then
            this.characterHighSkinVM=CharacterHighSkin.New(this.spineCharacter.transform);
        end
        this.characterHighSkinVM:SetData(this.characterId,this.skinConfig.skinID);
        this.characterHighSkinVM:PlayIdle()
    end
end

this.PlaySkinExecute=function()
    if this.spineCharacter~=nil and not this.isPlayingAnim then
        this.vm.data.playAnimAlpha=0.5;
        this.isPlayingAnim=true;
        if this.characterHighSkinVM==nil then
            this.characterHighSkinVM=CharacterHighSkin.New(this.spineCharacter.transform);
        end
        this.characterHighSkinVM:SetData(this.characterId,this.skinConfig.skinID);
        this.characterHighSkinVM:PlayAnimation(function()
            this.isPlayingAnim=false;;
            this.vm.data.playAnimAlpha=1.0;
        end)
    end
end


return vm({
    data = data,
    command = command,
    hook = hook
})
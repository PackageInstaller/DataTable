




local this = {vm = nil,spineCharacter = nil,isOn = nil,label = nil,skinKey = "301",heroKey = "302",drawKey = "303",
              activityData = nil,heroDataTab = nil,skinIndex = 0,headIndex = 0,animator = nil,coroutine_key = nil,
              activeClick = false,rewardContent = nil,rewardData = nil,nowChooseHero = nil,drawHeroConfig = nil,
              skinAnimName = "UI_CollectActivityPanel",heroAnimName = "UI_CollectActivityPanel_Activity1",
              drawAnimName = "UI_CollectActivityPanel_Activity2", drawTwoAnimName = "UI_CollectActivityPanel_Activity3",
              skinIconPath = "Assets/_BundleResources/Images/SkinActivity/",
              heroIconPath = "Assets/_BundleResources/Images/HeroActivity/",
              HEAD_ICON_PATH = "Assets/_BundleResources/Character/",spineCharacterResult = nil,
              spineTwoCharacter = nil,spineTwoCharacterResult = nil,
              labelType = {label0 = "Skin",label1 = "Hero",label2 = "Draw",label3 = "DrawTwo",},isCanDraw = nil,cardList = nil,cardIndex = nil,
              labelRect_1 = nil,labelRect_2 = nil,labelRect_3 = nil,drawTwoKey = "304"}
local data = {
    shareRoot = false,labelRoot = false,shareBtnRoot = false,
    labelSkin = false,labelHero = false,labelDraw = false,labelDrawTow = false,
    activityRoot0 = false,activityRoot1 = false,activityRoot2 = false,activityRoot3 = false,
    addressBtn = Vector3.zero,rewardBtn = false,select = Vector3.zero,
    shareLock = Vector3.zero,shareText = "",rewardTip = Vector3.zero,rewardWidth = Vector2.zero,
    headView = false,scrollRect = 0.0,headTipText = "",selectName = "",nameRoot = Vector3.zero,
    timeText = "",tipText = "",yunhaiEffect = false,
    
    normalRoot = false,drawIcon = DefaultTexture,jobIcon = DefaultSprite,drawName = "", drawFullName = "",
    expend = false,expendTipText = "",expendTipText_1 = "",expendTipIcon = DefaultTexture,expendTipCount = "",
    complete = false,completeTipText = "",bodyPath = "",bodyPos = Vector2.zero,bodyScale = Vector3.zero,
    btnActive_1 = false,btnActive_2 = false,btnActive_3 = false,btnActive_4 = false,btnActive_5 = false,
    btnChoose_1 = false,btnChoose_2 = false,btnChoose_3 = false,btnChoose_4 = false,btnChoose_5 = false,
    drawTimeText = "",timeTipText = "",drawAnimRoot = false,
    clickTipText = "",bodyPathResult = "",bodyPosResult = Vector2.zero,
    
    tipPopup = false,headIcon = DefaultTexture,tipText_1 = "",tipText_2 = "",
    confirmName = "",cancelText = "",confirmText = "",sliderValue = 0.0,

    labels = {{labelText = "",labelSelect = false,labelLock = false,labelRedIcon = false},
              {labelText = "",labelSelect = false,labelLock = false,labelRedIcon = false},
              {labelText = "",labelSelect = false,labelLock = false,labelRedIcon = false},
              {labelText = "",labelSelect = false,labelLock = false,labelRedIcon = false}},
    
    skinConfirmRoot = Vector3.zero,
    gotoBtnRoot = Vector3.zero,notTipRoot = Vector3.zero,
    skinList = {{skinPic = DefaultTexture,skinNot = Vector3.zero,skinNull = Vector3.zero,name = Vector3.zero,nameText = "",
                 logIcon = Vector3.zero,itemId = "",rewardEffect = false,animName = "",wenhaoEffect = false},
                {skinPic = DefaultTexture,skinNot = Vector3.zero,skinNull = Vector3.zero,name = Vector3.zero,nameText = "",
                 logIcon = Vector3.zero,itemId = "",rewardEffect = false,animName = "",wenhaoEffect = false},
                {skinPic = DefaultTexture,skinNot = Vector3.zero,skinNull = Vector3.zero,name = Vector3.zero,nameText = "",
                 logIcon = Vector3.zero,itemId = "",rewardEffect = false,animName = "",wenhaoEffect = false},
                {skinPic = DefaultTexture,skinNot = Vector3.zero,skinNull = Vector3.zero,name = Vector3.zero,nameText = "",
                 logIcon = Vector3.zero,itemId = "",rewardEffect = false,animName = "",wenhaoEffect = false}},
    headList = {{headIcon = DefaultTexture,headSelect = Vector3.zero}},
    heroList = {{heroNot = Vector3.zero,heroName = "",heroSize = Vector2.zero,heroLogIcon = Vector3.zero,
                 heroPic = DefaultTexture,heroPicMask = DefaultTexture,effect = false,itemId = "",animName = ""},
                {heroNot = Vector3.zero,heroName = "",heroSize = Vector2.zero,heroLogIcon = Vector3.zero,
                 heroPic = DefaultTexture,heroPicMask = DefaultTexture,effect = false,itemId = "",animName = ""},
                {heroNot = Vector3.zero,heroName = "",heroSize = Vector2.zero,heroLogIcon = Vector3.zero,
                 heroPic = DefaultTexture,heroPicMask = DefaultTexture,effect = false,itemId = "",animName = ""},
                {heroNot = Vector3.zero,heroName = "",heroSize = Vector2.zero,heroLogIcon = Vector3.zero,
                 heroPic = DefaultTexture,heroPicMask = DefaultTexture,effect = false,itemId = "",animName = ""},
                {heroNot = Vector3.zero,heroName = "",heroSize = Vector2.zero,heroLogIcon = Vector3.zero,
                 heroPic = DefaultTexture,heroPicMask = DefaultTexture,effect = false,itemId = "",animName = ""}},
    rewardList = {{rewardIcon = DefaultTexture,rewardCount = "",complete = false}}
}
local command = {
    labelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if param == this.labelType.label0 then
                this.label = this.labelType.label0
            elseif param == this.labelType.label1 then
                this.label = this.labelType.label1
            elseif param == this.labelType.label2 then
                this.label = this.labelType.label2
                RedMgr.Singleton:FrushRedCondition("1200")
            elseif param == this.labelType.label3 then
                this.label = this.labelType.label3
                RedMgr.Singleton:FrushRedCondition("1200")
            end
            this.vm.data.yunhaiEffect = false
            this.vm.data.yunhaiEffect = true
            this.CloseRewardTip()
            this.SwitchLabelView()
        end
    },
    labelLockCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local tipStr = ""
            local temp = ConfigMgr.Config.CollectionActivities[param]
            if temp.UnlockType == 1 then
                tipStr = string.format(LuaMgr.GetLangText("FeatureManager_1"),temp.UnlockParam)
            end
            if temp.UnlockType == 2 then
                local text = LuaMgr.GetLangText(ConfigMgr.Config.dungeonMap[temp.UnlockParam].NameLan)
                tipStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2134"].NameLan),text)
            end
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
            this.CloseRewardTip()
        end
    },
    nullCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/Click_light.mp3");
            if this.CheckActivityTime() then
                this.skinIndex = tonumber(param)
                this.OpenHeadView()
            end
        end
    },
    maskCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.skinIndex = 0
            this.vm.data.headView = false
            this.vm.data.nameRoot = Vector3.zero
        end
    },
    headCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/Click_light.mp3");
            this.SelectHead(tonumber(param) + 1)
        end
    },
    selectCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/Click_light.mp3");
            if this.CheckActivityTime() then
                this.SendSelectSkin()
            end
        end
    },
    activeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/Click_light.mp3");
            local index = tonumber(param)
            if this.activeClick then
                this.SendActive(this.skinKey,index)
            end
        end
    },
    gotoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/Click_light.mp3");
            local index = tonumber(param) + 1
            local characterTable = {this.vm.data.skinList[index].itemId}
            HeroParameter.SaveListParam(nil,nil,nil,nil,1,characterTable)
            HeroParameter.SaveCollectActivityLabel(this.label)
            FeatureManager.GotoPanel("1003")
        end
    },
    heroActiveCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/Click_light.mp3");
            local index = tonumber(param)
            local characterid = this.vm.data.heroList[index + 1].itemId
            if this.activeClick then
                if DataMgr.Player.characters[characterid] == nil then
                    local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["1501"].NameLan)
                    LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr) 
                else
                    this.SendActive(this.heroKey,index)
                end
            end
        end
    },
    shareCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/Click_light.mp3");
            if this.CheckActivityTime() then
                LuaMgr.HidePanel("Laigu.ViewModel.TopBarViewModel")
                LuaMgr.HidePanel(UIName.MessageTipsViewModel);
                LuaMgr.HidePanel(UIName.NoticeRollhorseViewModel)
                this.vm.data.shareRoot = false
                this.vm.data.labelRoot = false
                local filename = "screenshot/shareScreenshot.png"
                LuaMgr.NextFrame(function()
                    LuaMgr.CaptureScreenshot(filename)
                    local path = UnityEngine.Application.persistentDataPath..'/'..filename
                    LuaMgr.NextFrame(function()
                        LuaMgr.ShowPanel("Laigu.ViewModel.SharePopupViewModel","collect",path,function()
                            this.vm.data.shareRoot = this.label == this.labelType.label0
                            this.vm.data.labelRoot = true
                            this.vm.behaviour:UpdateTopBar("", this.OnBack)
                        end)
                    end)
                end)
            end
        end
    },
    getRewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/Click_light.mp3");
            local dataInfo = DataMgr.Player.collection.ActInfos[this.heroKey]
            if not dataInfo.isshare then
                local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7033"].NameLan)
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
            else
                local tempData = {}
                tempData["ActKey"] = this.heroKey
                ApiMgr.Request("collection/getaddr",tempData,true,function(result)
                    local re = json.decode(result)
                    if re.code == 0 then
                        tempData["addinfo"] = re.result.Addr
                        tempData["time"] = this.activityData.delTime
                        LuaMgr.ShowLuaPanel(UIName.ActivityAddressViewModel,tempData)
                    end
                end,nil,true)
            end
        end
    },
    rewardBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/Click_light.mp3")
            this.OpenRewardTip()
        end
    },
    closeRewardTipCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/Click_light.mp3")
            this.CloseRewardTip()
        end
    },
    drawHeroCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param)
            local tempData = nil
            if this.label == this.labelType.label2 then
                tempData = DataMgr.Player.collection.ActInfos[this.drawKey].CollectionMeta
            elseif this.label == this.labelType.label3 then
                tempData = DataMgr.Player.collection.ActInfos[this.drawTwoKey].CollectionMeta
            end
            this.SetChooseHero(tempData[index].characterid)
            this.SetChooseState()
            tempData = nil
        end
    },
    chooseHeroCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel",this.nowChooseHero)
        end
    },
    drawCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OpenDrawCardPopup()
        end
    },
    closeAnimCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.vm.behaviour:UpdateTopBar("", this.OnBack)
            LuaMgr.RemoveTimer(TimerConst.DrawActivityEffectTime)
            this.InitDrawHeroActivity()
            this.vm.data.labelRoot = true
            LuaMgr.SetIsDrawCard(false)
        end
    },
    cancelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.vm.data.tipPopup = false
        end
    },
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.vm.data.tipPopup = false
            DataHelper.ConditionCheck(this.drawHeroConfig.CostItem.id,this.drawHeroConfig.CostItem.count,
                    function()
                        if this.label == this.labelType.label2 then
                            this.SendActive(this.drawKey,this.GetHeroIndex())
                        elseif this.label == this.labelType.label3 then
                            this.SendActive(this.drawTwoKey,this.GetHeroIndex())
                        end
                    end)
        end
    },
    rewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param) + 1
            local id = this.vm.data.rewardList[index].id
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,id,false,false,false,0,0);
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        RedMgr.Singleton:RegisterViewModel(UIName.CollectActivityViewModel)
        this.animator = vm.behaviour.transform:Find("root"):GetComponent("Animator")
        this.rewardContent = vm.behaviour.transform:Find("root/_Middle/ShareHide/TipText/RewardTip")
        this.spineCharacter = vm.behaviour.transform:Find("root/_Middle/Activity2/NormalRoot/BodyObject/Body"):GetComponent("UISpineCharacter")
        this.spineCharacterResult = vm.behaviour.transform:Find("root/_Middle/Activity2/AnimRoot/BodyObject/BodyObject/Body"):GetComponent("UISpineCharacter")
        this.spineTwoCharacter = vm.behaviour.transform:Find("root/_Middle/Activity3/NormalRoot/BodyObject/Body"):GetComponent("UISpineCharacter")
        this.spineTwoCharacterResult = vm.behaviour.transform:Find("root/_Middle/Activity3/AnimRoot/BodyObject/BodyObject/Body"):GetComponent("UISpineCharacter")
        this.labelRect_1 = vm.behaviour.transform:Find("root/_Left/Labels/Labels0"):GetComponent("RectTransform")
        this.labelRect_2 = vm.behaviour.transform:Find("root/_Left/Labels/Labels1"):GetComponent("RectTransform")
        this.labelRect_3 = vm.behaviour.transform:Find("root/_Left/Labels/Labels2"):GetComponent("RectTransform")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.SetLanguageText()
        this.SetLabelLayer()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.vm.data.activityRoot0 = false
        this.vm.data.activityRoot1 = false
        this.vm.data.activityRoot2 = false
        this.vm.data.activityRoot3 = false
        this.vm.data.headView = false
        this.vm.data.tipPopup = false
        this.label = nil
        this.spineCharacter:Clear()
        this.spineCharacterResult:Clear()
        this.spineTwoCharacter:Clear()
        this.spineTwoCharacterResult:Clear()
        this.vm.data.yunhaiEffect = false
        this.CloseRewardTip()
        LuaMgr.RemoveTimer(TimerConst.CollectTime)
        LuaMgr.RemoveTimer(TimerConst.CollectClickTime)
        LuaMgr.RemoveTimer(TimerConst.DrawActivityEffectTime)
        LuaMgr.RemoveTimer(TimerConst.DrawActivitySoundTime)
        if this.coroutine_key ~= nil then
            coroutine_runner.stop(this.coroutine_key)
        end
        this.vm.data.rewardList = {}
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.SetLanguageText = function()
    this.vm.data.shareText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7021"].NameLan)
    this.vm.data.headTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7022"].NameLan)
    this.vm.data.labels[1].labelText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7005"].NameLan)
    this.vm.data.labels[2].labelText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7006"].NameLan)
    this.vm.data.labels[3].labelText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["6980"].NameLan)
    this.vm.data.labels[4].labelText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["6986"].NameLan)
    this.vm.data.expendTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["6984"].NameLan)
    this.vm.data.expendTipText_1 = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["6983"].NameLan)
    this.vm.data.completeTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["6985"].NameLan)
    this.vm.data.timeTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["6982"].NameLan)
    this.vm.data.clickTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["6981"].NameLan)
    this.vm.data.tipText_1 = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["13201"].NameLan)
    this.vm.data.tipText_2 = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["13202"].NameLan)
    this.vm.data.confirmText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["13203"].NameLan)
    this.vm.data.cancelText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["13204"].NameLan)
end
this.SetLabelLayer = function()
    local layer = ConfigMgr.Config.CollectionActivities[this.skinKey].ID
    this.labelRect_1:SetSiblingIndex(layer)
    layer = ConfigMgr.Config.CollectionActivities[this.heroKey].ID
    this.labelRect_2:SetSiblingIndex(layer)
    layer = ConfigMgr.Config.CollectionActivities[this.drawKey].ID
    this.labelRect_3:SetSiblingIndex(layer)
end
this.OnBack=function()
    if this.vm.behaviour.Params.Length > 0 then
        local key = this.vm.behaviour.Params[0]
        LuaMgr.Back(key);
    else
        LuaMgr.Back()
    end
    HeroParameter.EmptyCollectActivityLabel()
end

this.InitParameter = function()
    this.isOn = LuaMgr.GetRenderLevelEnable("SpineEnable")
    this.vm.data.labelRoot = true
    this.vm.behaviour:UpdateTopBar("", this.OnBack)
    this.heroDataTab = {}
    this.vm.data.nameRoot = Vector3.zero
    local groupId = ActivityMgr.groupKeyList["collect"]
    this.activityData = DataMgr.Player.variables[groupId]
    this.SetDefaultLabel()

    local skinData = DataMgr.Player.collection.ActInfos[this.skinKey]
    local heroData = DataMgr.Player.collection.ActInfos[this.heroKey]
    local drawData = DataMgr.Player.collection.ActInfos[this.drawKey]
    if skinData == nil or heroData == nil or drawData == nil then
        local tempData = {}
        tempData["Keys"] = nil
        ApiMgr.Request("collection/normal",tempData,true,function()
            this.CheckLabelRedIcon()
            this.SwitchLabelView()
        end,nil,true)
    else
        this.CheckLabelRedIcon()
        this.SwitchLabelView()
    end
    skinData,heroData,drawData = nil,nil,nil
end
this.SetDefaultLabel = function()

    local sortCheck = {}
    for key,value in pairs(ConfigMgr.Config.CollectionActivities) do
        sortCheck[value.ID] = value.Key
    end
    for i = 1, #sortCheck do
        if this.CheckActivityClose(ConfigMgr.Config.CollectionActivities[sortCheck[i]]) then
            if this.label == nil and sortCheck[i] == this.skinKey then
                this.label = this.labelType.label0
            elseif this.label == nil and sortCheck[i] == this.heroKey then
                this.label = this.labelType.label1
            elseif this.label == nil and sortCheck[i] == this.drawKey then
                this.label = this.labelType.label2
            elseif this.label == nil and sortCheck[i] == this.drawTwoKey then
                this.label = this.labelType.label3
            end
            if HeroParameter.collectLabel ~= nil then
                this.label = HeroParameter.collectLabel
            end
            if this.label ~= nil then break end
        end
    end
    sortCheck = nil
    if this.CheckActivityClose(ConfigMgr.Config.CollectionActivities[this.skinKey]) then
        this.vm.data.labels[1].labelLock = this.WhetherUnLock(ConfigMgr.Config.CollectionActivities[this.skinKey])
    end
    if this.CheckActivityClose(ConfigMgr.Config.CollectionActivities[this.heroKey]) then
        this.vm.data.labels[2].labelLock = this.WhetherUnLock(ConfigMgr.Config.CollectionActivities[this.heroKey])
    end
    if this.CheckActivityClose(ConfigMgr.Config.CollectionActivities[this.drawKey]) then
        this.vm.data.labels[3].labelLock = this.WhetherUnLock(ConfigMgr.Config.CollectionActivities[this.drawKey])
    end
    if this.CheckActivityClose(ConfigMgr.Config.CollectionActivities[this.drawTwoKey]) then
        this.vm.data.labels[4].labelLock = this.WhetherUnLock(ConfigMgr.Config.CollectionActivities[this.drawTwoKey])
    end
end

this.SetActivityTime = function()
    local nowTime = LuaMgr.Timestamp()
    if nowTime >= this.activityData.expireTime then
        if this.label == this.labelType.label0 then
            this.vm.data.timeText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7024"].NameLan)
        elseif this.label == this.labelType.label1 then
            this.vm.data.timeText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7031"].NameLan)
        end
    else
        LuaMgr.AddTimer(TimerConst.CollectTime,this.ShowTime,1,-1,true)
    end
end
this.ShowTime = function()
    local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7007"].NameLan)
    local time = this.activityData.expireTime - LuaMgr.Timestamp()
    if time < 0 then
        this.SetActivityTime()
        LuaMgr.RemoveTimer(TimerConst.CollectTime)
        return
    end




    this.vm.data.timeText = string.format("%s<color=#32D9CE>%s</color>",tipStr,this.GetTimeStrFormat(time))
end

this.SwitchLabelView = function()
    LuaMgr.RemoveTimer(TimerConst.DrawActivityEffectTime)
    this.nowChooseHero = nil
    this.vm.data.shareRoot = this.label == this.labelType.label0
    this.vm.data.activityRoot0 = this.label == this.labelType.label0
    this.vm.data.activityRoot1 = this.label == this.labelType.label1
    this.vm.data.activityRoot2 = this.label == this.labelType.label2
    this.vm.data.activityRoot3 = this.label == this.labelType.label3
    
    local config = ConfigMgr.Config.CollectionActivities[this.skinKey]
    this.vm.data.labelSkin = this.CheckActivityClose(config)
    if this.vm.data.labelSkin then
        this.vm.data.labels[1].labelSelect = this.label == this.labelType.label0
    end
    
    config = ConfigMgr.Config.CollectionActivities[this.heroKey]
    local isShow = this.CheckActivityClose(config)
    this.vm.data.labelHero = isShow
    if this.vm.data.labelHero then
        this.vm.data.labels[2].labelSelect = this.label == this.labelType.label1
    end

    config = ConfigMgr.Config.CollectionActivities[this.drawKey]
    this.vm.data.labelDraw = this.CheckActivityClose(config)
    if this.vm.data.labelDraw then
        this.vm.data.labels[3].labelSelect = this.label == this.labelType.label2
    end
    
    config = ConfigMgr.Config.CollectionActivities[this.drawTwoKey]
    this.vm.data.labelDrawTow = this.CheckActivityClose(config)
    if this.vm.data.labelDrawTow then
        this.vm.data.labels[4].labelSelect = this.label == this.labelType.label3
    end

    this.activeClick = true
    local shareStatus = ConfigHelper.GetShareStatus("Closecollect");
    if this.label == this.labelType.label0 then
        this.InitSkinActivity()
        this.vm.data.shareBtnRoot = shareStatus
        this.vm.data.rewardBtn = false
        this.animator:Play(this.skinAnimName,0,0)
        this.vm.data.tipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7008"].NameLan)
    elseif this.label == this.labelType.label1 then
        this.InitHeroActivity()
        this.vm.data.shareBtnRoot = shareStatus
        this.vm.data.rewardBtn = false
        this.animator:Play(this.heroAnimName)
        this.vm.data.tipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7009"].NameLan)
    elseif this.label == this.labelType.label2 or this.label == this.labelType.label3 then
        this.CloseEffect()
        this.InitDrawHeroActivity()
        local tempName = this.label == this.labelType.label2 and this.drawAnimName or this.drawTwoAnimName
        this.animator:Play(tempName,0,0)
    end
end

this.InitSkinActivity = function()
    SDKMgr.Singleton.onSuccCallBack = nil
    SDKMgr.Singleton.onFailCallBack = nil
    SDKMgr.Singleton.onCancelCallBack = nil
    local tempData = DataMgr.Player.collection.ActInfos[this.skinKey]
    this.vm.data.addressBtn = Vector3.zero
    this.vm.data.select = tempData.isshare and Vector3.one or Vector3.zero
this.vm.data.shareLock = Vector3.zero
    local rewardConfig = ConfigMgr.Config.CollectionMap["1"].ActivateReward
    local tempList,tempItem = {},{}
    local count = 0
    for i = 1, #this.vm.data.skinList do
        local activity = tempData.CollectionMeta[i]
        this.vm.data.skinList[i].itemId = activity.characterid
        
        local state = activity.characterid ~= ""
        this.vm.data.skinList[i].skinPic = state and LuaMgr.GetTexture(this.skinIconPath..activity.characterid..".png") or nil
        this.vm.data.skinList[i].skinNull = state and Vector3.zero or Vector3.one
        this.vm.data.skinList[i].animName = ""
        this.vm.data.skinList[i].wenhaoEffect = not state and #this.heroDataTab ~= 0

        state = activity.characterid ~= "" and activity.status == 0
        this.vm.data.skinList[i].skinNot = state and Vector3.one or Vector3.zero
        if i == 1 then
            if DataMgr.Player.characters[activity.characterid] == nil then
                this.vm.data.notTipRoot = Vector3.one
                this.vm.data.gotoBtnRoot,this.vm.data.skinConfirmRoot = Vector3.zero,Vector3.zero
            else
                this.vm.data.notTipRoot = Vector3.zero
                this.vm.data.gotoBtnRoot = this.WhetherMeetConditions(activity.characterid) and Vector3.zero or Vector3.one
                this.vm.data.skinConfirmRoot = this.WhetherMeetConditions(activity.characterid) and Vector3.one or Vector3.zero
            end
        end
        state = activity.status == 1
        if state then
            count = count + 1
            local characterConfig = ConfigMgr.Config.characterTable[activity.characterid]
            this.vm.data.skinList[i].nameText = LuaMgr.GetLangText(characterConfig.namelan)
        end
        this.vm.data.skinList[i].name = state and Vector3.one or Vector3.zero
        
        state = activity.characterid ~= "" and activity.status == 0 and this.WhetherMeetConditions(activity.characterid) == true
        this.vm.data.skinList[i].logIcon = state and Vector3.one or Vector3.zero
        this.vm.data.skinList[i].rewardEffect = state
        tempItem = {rewardIcon = GetItemTexture(rewardConfig[1].id),rewardCount = tostring(rewardConfig[1].count),complete = false,id = rewardConfig[1].id}
        table.insert(tempList,tempItem)
    end
    for i = 1, #tempList do
        tempList[i].complete = i <= count
    end
    this.vm.data.rewardList = tempList
    this.vm.data.sliderValue = (count - 1) / 3
    this.SetActivityTime()
end

this.InitHeroActivity = function()
    SDKMgr.Singleton.onSuccCallBack = nil
    SDKMgr.Singleton.onFailCallBack = nil
    SDKMgr.Singleton.onCancelCallBack = nil
    local tempData = DataMgr.Player.collection.ActInfos[this.heroKey]
    this.vm.data.addressBtn = Vector3.one
this.vm.data.shareLock = Vector3.zero
    for i = 1, #this.vm.data.heroList do
        local activity = tempData.CollectionMeta[i]
        local characterConfig = ConfigMgr.Config.characterTable[activity.characterid]
        this.vm.data.heroList[i].itemId = activity.characterid
        this.vm.data.heroList[i].heroPic = LuaMgr.GetTexture(this.heroIconPath.."Collect_"..activity.characterid..".png")
        
        local state = activity.status == 0
        if state then
            this.vm.data.heroList[i].heroPicMask = LuaMgr.GetTexture(this.heroIconPath.."Mask_"..activity.characterid..".png")
        end
        this.vm.data.heroList[i].animName = ""
        this.vm.data.heroList[i].heroNot = state and Vector3.one or Vector3.zero
        this.vm.data.heroList[i].heroName = LuaMgr.GetLangText(characterConfig.namelan)
        local size = this.CalculateNameSize(LuaMgr.GetLangText(characterConfig.namelan))
        this.vm.data.heroList[i].heroSize = size
        state = activity.status == 0 and DataMgr.Player.characters[activity.characterid] ~= nil
        this.vm.data.heroList[i].effect = this.CheckActivityTime() and state
        this.vm.data.heroList[i].heroLogIcon = this.vm.data.heroList[i].effect and Vector3.one or Vector3.zero
    end
    this.SetActivityTime()
end

this.InitDrawHeroActivity = function()
    LuaMgr.RemoveTimer(TimerConst.CollectTime)
    this.vm.data.normalRoot = true
    this.vm.data.drawAnimRoot = false
    AudioMgr.Singleton:StopVoice(false)
    local tempData = nil
    if this.label == this.labelType.label2 then
        tempData = DataMgr.Player.collection.ActInfos[this.drawKey]
    elseif this.label == this.labelType.label3 then
        local isRed = UnityEngine.PlayerPrefs.HasKey(this.drawTwoKey)
        if not isRed then
            UnityEngine.PlayerPrefs.SetString(this.drawTwoKey,this.drawTwoKey)
        end
        tempData = DataMgr.Player.collection.ActInfos[this.drawTwoKey]
    end
    if tempData == nil then return end
    local time = this.activityData.expireTime - LuaMgr.Timestamp()
    this.vm.data.drawTimeText = this.GetTimeStrFormat(time)
    this.isCanDraw = true
    local heroId = ""
    for i = 1, #tempData.CollectionMeta do
        if tempData.CollectionMeta[i].status == 1 then
            this.isCanDraw = false
            heroId = tempData.CollectionMeta[i].characterid
            break
        end
    end
    if heroId == "" then
        heroId = tempData.CollectionMeta[1].characterid
    end
    this.vm.data.expend = this.isCanDraw
    this.vm.data.complete = not this.isCanDraw
    if this.isCanDraw then
        this.SetChooseHero(heroId)
        this.SetDrawCost()
    else
        this.SetChooseHero(heroId)
    end
    LuaMgr.AddTimer(TimerConst.DrawActivityEffectTime,function()
        this.SetChooseState()
        this.SetBtnActiveState()
        LuaMgr.RemoveTimer(TimerConst.DrawActivityEffectTime)
    end,0.8,-1,false)
end
this.SetBtnActiveState = function()
    local tempIndex = this.GetHeroIndex() + 1
    this.vm.data.btnActive_1 = tempIndex == 1 and not this.isCanDraw
    this.vm.data.btnActive_2 = tempIndex == 2 and not this.isCanDraw
    this.vm.data.btnActive_3 = tempIndex == 3 and not this.isCanDraw
    this.vm.data.btnActive_4 = tempIndex == 4 and not this.isCanDraw
    this.vm.data.btnActive_5 = tempIndex == 5 and not this.isCanDraw
end
this.SetChooseState = function()
    local tempIndex = this.GetHeroIndex() + 1
    this.vm.data.btnChoose_1 = tempIndex == 1
    this.vm.data.btnChoose_2 = tempIndex == 2
    this.vm.data.btnChoose_3 = tempIndex == 3
    this.vm.data.btnChoose_4 = tempIndex == 4
    this.vm.data.btnChoose_5 = tempIndex == 5
end
this.SetChooseHero = function(heroId)
    if this.nowChooseHero == heroId then
        return
    end
    this.nowChooseHero = heroId
    local heroConfig = ConfigMgr.Config.characterTable[heroId]
    if heroConfig == nil then return end
    this.vm.data.drawName = LuaMgr.GetLangText(heroConfig.namelan)
    this.vm.data.drawFullName = LuaMgr.GetLangText(heroConfig.FullnameLan)
    this.vm.data.jobIcon = HeroMgr.GetHeroJobRareIcon(heroConfig)
    this.vm.data.drawIcon = LuaMgr.GetTexture(this.heroIconPath.."Draw_"..heroId..".png")
    this.SetSpineCharacter()
end

this.SetSpineCharacter = function()
    local path = ""
    if this.label == this.labelType.label2 then
        path = HeroManager.SetCharacterDrawing(this.spineCharacter,this.nowChooseHero,"001")
        if (path ~= "") then this.vm.data.bodyPath = path end
    elseif this.label == this.labelType.label3 then
        path = HeroManager.SetCharacterDrawing(this.spineTwoCharacter,this.nowChooseHero,"001")
        if (path ~= "") then this.vm.data.bodyPath = path end
    end
    this.drawHeroConfig = this.GetCollectionConfig()
    if this.drawHeroConfig == nil then return end
    local position = this.drawHeroConfig.Position
    if this.isOn then
        this.vm.data.bodyPos = Vector2(position[1],position[2])
        local scale = position[3] / 10
        this.vm.data.bodyScale = Vector3(scale,scale,scale)
    else
        this.vm.data.bodyPos = Vector2(position[4],position[5])
        local scale = position[6] / 10
        this.vm.data.bodyScale = Vector3(scale,scale,scale)
    end
end

this.SetDrawCost = function()
    if this.drawHeroConfig == nil then return end
    local count = DataHelper.GetItemCountById(this.drawHeroConfig.CostItem.id)
    if count >= this.drawHeroConfig.CostItem.count then
        this.vm.data.expendTipCount = "X "..this.drawHeroConfig.CostItem.count
    else
        this.vm.data.expendTipCount = "X ".."<color=#FF0000>"..this.drawHeroConfig.CostItem.count.."</color>"
    end
    this.vm.data.expendTipIcon = LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(this.drawHeroConfig.CostItem.id))
end
this.GetHeroIndex = function()
    local tempData = nil
    if this.label == this.labelType.label2 then
        tempData = DataMgr.Player.collection.ActInfos[this.drawKey]
    elseif this.label == this.labelType.label3 then
        tempData = DataMgr.Player.collection.ActInfos[this.drawTwoKey]
    end
    if tempData == nil then return end
    for i = 1, #tempData.CollectionMeta do
        if tempData.CollectionMeta[i].characterid == this.nowChooseHero then
            return i - 1
        end
    end
end
this.GetCollectionConfig = function()
    local tempKey = nil
    if this.label == this.labelType.label2 then
        tempKey = this.drawKey
    elseif this.label == this.labelType.label3 then
        tempKey = this.drawTwoKey
    end
    for key,value in pairs(ConfigMgr.Config.CollectionMap) do
        if value.Key == tempKey and value.CharacterId == this.nowChooseHero then
            return value
        end
    end
end
this.DrawHeroResult = function(resultCards)
    if resultCards == nil or #resultCards <= 0 then return end
    LuaMgr.HidePanel("Laigu.ViewModel.TopBarViewModel")
    LuaMgr.SetIsDrawCard(true)
    this.cardList = {}
    this.cardIndex = 1
    local rootName = this.label == this.labelType.label2 and "Activity2" or "Activity3"
    local parentRoot = this.vm.behaviour.transform:Find("root/_Middle/"..rootName.."/AnimRoot/AnimMove1"):GetComponent("Transform")
    this.GetCardUiRoot(parentRoot,3)
    parentRoot = this.vm.behaviour.transform:Find("root/_Middle/"..rootName.."/AnimRoot/AnimMove2"):GetComponent("Transform")
    this.GetCardUiRoot(parentRoot,4)
    parentRoot = this.vm.behaviour.transform:Find("root/_Middle/"..rootName.."/AnimRoot/AnimMove3"):GetComponent("Transform")
    this.GetCardUiRoot(parentRoot,3)
    local character = nil
    local texture,iconPos,isNew = nil,nil,nil
    local index = 1
    local soundId = nil
    local tempConfig = nil
    if this.label == this.labelType.label2 then
        tempConfig = ConfigMgr.Config.collectionPoolCardsMaps[this.drawKey]
    elseif this.label == this.labelType.label3 then
        tempConfig = ConfigMgr.Config.collectionPoolCardsMaps[this.drawTwoKey]
    end
    if tempConfig == nil then return end
    for i = 1, #resultCards do
        character = ConfigMgr.Config.characterTable[resultCards[i].card]
        if character ~= nil then
            texture = LuaMgr.GetTexture(HeroMgr.GetCharacterCard(character.id,"001"))
            iconPos = tempConfig[character.id].Position
            isNew = resultCards[i].type == "Characters"
            if character.rare == 4 then
                soundId = character.id
                this.cardList[6].cardIcon.texture = texture
                this.cardList[6].cardPos.anchoredPosition = Vector2(iconPos[1],iconPos[2])
                SetActive(this.cardList[6].isNew,isNew)
                local path = ""
                if this.label == this.labelType.label2 then
                    path = HeroManager.SetCharacterDrawing(this.spineCharacterResult,character.id,"001")
                elseif this.label == this.labelType.label3 then
                    path = HeroManager.SetCharacterDrawing(this.spineTwoCharacterResult,character.id,"001")
                end
                if (path ~= "") then this.vm.data.bodyPathResult = path end
                if this.drawHeroConfig ~= nil then
                    if this.isOn then
                        this.vm.data.bodyPosResult = Vector2(this.drawHeroConfig.Position[7],this.drawHeroConfig.Position[8])
                    else
                        this.vm.data.bodyPosResult = Vector2(this.drawHeroConfig.Position[9],this.drawHeroConfig.Position[10])
                    end
                end
            else
                if i < 6 then
                    index = i - 1
                elseif i > 6 then
                    index = i
                else
                    index = 5
                end
                this.cardList[index].cardIcon.texture = texture
                this.cardList[index].cardPos.anchoredPosition = Vector2(iconPos[1],iconPos[2])
                SetActive(this.cardList[index].isNew,isNew)
            end
        end
    end
    this.vm.data.normalRoot = false
    this.vm.data.drawAnimRoot = true
    this.vm.data.labelRoot = false
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/skin_get.mp3")
    LuaMgr.AddTimer(TimerConst.DrawActivitySoundTime,function()
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "UI/card_shine.mp3")
        local skinId = "001"
        local path = soundId.."/Audio".."/character_dropLine_"..soundId..skinId..".mp3"
        AudioMgr.Singleton:PlayVoice(Path.Character_PATH..path)
        LuaMgr.RemoveTimer(TimerConst.DrawActivitySoundTime)
    end,5.9,-1,false)
end

this.OpenDrawCardPopup = function()
    this.vm.data.confirmName = LuaMgr.GetLangText(ConfigMgr.Config.characterTable[this.nowChooseHero].namelan)
    this.vm.data.headIcon = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(this.nowChooseHero,this.nowChooseHero.."001"))
    this.vm.data.tipPopup = true
end

this.OpenRewardTip = function()
    this.rewardData = {}
    local itemConfig,tempItem = nil,nil
    local config = ConfigMgr.Config.CollectionActivities[this.skinKey]
    for i = 1, #config.ShareReward do
        itemConfig = ConfigMgr.Config.itemMap[config.ShareReward[i].id]
        itemConfig["count0"] = config.ShareReward[i].count
        tempItem = GoodsDataItem.New(this.rewardContent)
        tempItem:SetData(i,itemConfig,1,false,Vector3(0.6,0.6,0.6))
        table.insert(this.rewardData,tempItem)
    end
    this.vm.data.rewardWidth = Vector2(100 + (#config.ShareReward * 80) -80,100)
    this.vm.data.rewardTip = Vector3.one
end
this.CloseRewardTip = function()
    if this.rewardData == nil or #this.rewardData == 0 then return end
    for i = #this.rewardData,1,-1  do
        this.rewardData[i]:Clear()
    end
    this.rewardData = nil
    this.vm.data.rewardTip = Vector3.zero
end

this.OpenHeadView = function()
    if #this.heroDataTab == 0 then
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7030"].NameLan)
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
        return
    end
    local tempList,tempItem = {},{}
    local icon = nil
    for i = 1, #this.heroDataTab do
        icon = LuaMgr.GetTexture(this.HEAD_ICON_PATH..this.heroDataTab[i].id.."/Avatar/"..this.heroDataTab[i].id.."002.png")
        tempItem = {headSelect = Vector3.zero,headIcon = icon,characterid = this.heroDataTab[i].id}
        table.insert(tempList,tempItem)
    end
    this.vm.data.headList = tempList
    this.vm.data.scrollRect = 0.0
    this.vm.data.headView = true
    this.headIndex = 0
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/DailyDungeon_switch1.mp3");
end

this.SelectHead = function(index)
    if this.headIndex == index then return end
    local characterid = this.vm.data.headList[index].characterid
    local character = ConfigMgr.Config.characterTable[characterid]
    this.vm.data.selectName = LuaMgr.GetLangText(character.namelan)
    this.vm.data.nameRoot = Vector3.one
    this.vm.data.headList[index].headSelect = Vector3.one
    if this.headIndex ~= 0 then
        this.vm.data.headList[this.headIndex].headSelect = Vector3.zero
    end
    this.headIndex = index
end

this.SendSelectSkin = function()
    if this.headIndex == 0 then return end
    local characterid = this.vm.data.headList[this.headIndex].characterid
    local tempData = {}
    tempData["ActKey"] = this.skinKey
    tempData["Index"] = this.skinIndex
    tempData["CharacterId"] = characterid
    ApiMgr.Request("collection/chooseCharacter",tempData,true,function(result)
        local re = json.decode(result)
        if re.code == 0 then
            this.vm.data.nameRoot = Vector3.zero
            this.vm.data.headView = false
            if this.coroutine_key ~= nil then
                coroutine_runner.stop(this.coroutine_key)
            end
            local id = re.data.collection.ActInfos[this.skinKey].CollectionMeta[this.skinIndex + 1].characterid
            this.vm.data.skinList[this.skinIndex + 1].skinNot = Vector3.one
            this.vm.data.skinList[this.skinIndex + 1].skinPic = LuaMgr.GetTexture(this.skinIconPath..id..".png")
            this.vm.data.skinList[this.skinIndex + 1].animName = "ani_CollectActivityPanel_null"
            this.skinIndex = 0
            this.CheckLabelRedIcon()
            this.coroutine_key = coroutine_runner.start(function()
                coroutine_runner.wait(0.3)
                this.InitSkinActivity()
            end)
        end
    end,nil,true)
end

this.SendActive = function(key,index)
    if this.CheckActivityTime() then
        this.activeClick = false
        local tempData = {}
        tempData["ActKey"] = key
        tempData["Index"] = index
        ApiMgr.Request("collection/activate",tempData,true,function(result)
            local re = json.decode(result)
            if re.code == 0 then
                if this.label == this.labelType.label0 then
                    this.InitSkinActivity()
                    local rewared = json.encode(re.result)
                    LuaMgr.ShowItemRewared(rewared)
                elseif this.label == this.labelType.label1 then
                    if this.coroutine_key ~= nil then
                        coroutine_runner.stop(this.coroutine_key)
                    end
                    this.vm.data.heroList[index + 1].animName = "ani_CollectActivityPanel_Role"
                    this.coroutine_key = coroutine_runner.start(function()
                        coroutine_runner.wait(1)
                        local rewared = json.encode(re.result)
                        LuaMgr.ShowItemRewared(rewared)
                        this.InitHeroActivity()
                    end)
                elseif this.label == this.labelType.label2 or this.label == this.labelType.label3 then
                    this.DrawHeroResult(re.result.Cards)
                end
                LuaMgr.AddTimer(TimerConst.CollectClickTime,function()
                    this.activeClick = true
                end,1.5,1,false)
                this.CheckLabelRedIcon()
            end
        end,nil,true)
    end
end

this.SendShare = function(key)
    if DataMgr.Player.collection.ActInfos[key].isshare then return end
    local tempData = {}
    tempData["ActKey"] = key
    ApiMgr.Request("collection/share",tempData,true,function(result)
        local re = json.decode(result)
        if re.code == 0 then
            local rewared = json.encode(re.result)
            if ConfigHelper.GetTableLength(re.result.Items) == 0 then
                command.getRewardCommand.execute(nil,nil)
            else
                LuaMgr.ShowItemRewared(rewared,function()
                    command.getRewardCommand.execute(nil,nil)
                end)
            end
        end
    end,nil,true)
end

this.CheckLabelRedIcon = function()
    this.InitHeroConfig()
    local tempData = DataMgr.Player.collection.ActInfos[this.skinKey]
    local config = ConfigMgr.Config.CollectionActivities[this.skinKey]
    if config.Open == 1 then
        if this.WhetherCanShare(tempData) then
            this.vm.data.labels[1].labelRedIcon = false
        else
            local tempBool = false
for i = 2, #tempData.CollectionMeta do
                if tempData.CollectionMeta[i].characterid == "" then
                    tempBool = true
                    break
                end
            end
local haveNeedActive=false;
            for i = 1, #this.vm.data.skinList do
                local activity = tempData.CollectionMeta[i]
                local state = activity.characterid ~= "" and activity.status == 0 and this.WhetherMeetConditions(activity.characterid) == true
                if state then
                    haveNeedActive=true;
                    break;
                end
            end
if tempBool and #this.heroDataTab ~= 0 then
                this.vm.data.labels[1].labelRedIcon=true
elseif haveNeedActive then
                this.vm.data.labels[1].labelRedIcon=true
else
                this.vm.data.labels[1].labelRedIcon=false
            end
        end
    end
    this.vm.data.labels[2].labelRedIcon = false
    config = ConfigMgr.Config.CollectionActivities[this.heroKey]
    if config.Open == 1 then
        if this.WhetherUnLock(ConfigMgr.Config.CollectionActivities[this.heroKey]) == false then
            tempData = DataMgr.Player.collection.ActInfos[this.heroKey]
            local state = nil
            local characterid = nil
            for i = 1, #tempData.CollectionMeta do
                characterid = tempData.CollectionMeta[i].characterid
                state = tempData.CollectionMeta[i].status == 0 and DataMgr.Player.characters[characterid] ~= nil
                if state then
                    this.vm.data.labels[2].labelRedIcon = true
                    break
                end
            end
        end
    end
    config = ConfigMgr.Config.CollectionActivities[this.drawKey]
    if config.Open == 1 then
        if this.WhetherUnLock(ConfigMgr.Config.CollectionActivities[this.drawKey]) == false then
            RedMgr.Singleton:Refresh()
        end
    end
    
    config = ConfigMgr.Config.CollectionActivities[this.drawTwoKey]
    if config.Open == 1 then
        if this.WhetherUnLock(ConfigMgr.Config.CollectionActivities[this.drawTwoKey]) == false then
            local isRed = UnityEngine.PlayerPrefs.HasKey(this.drawTwoKey)
            this.vm.data.labels[4].labelRedIcon = not isRed
        end
    end
end
this.CloseEffect = function()
    this.vm.data.btnActive_1,this.vm.data.btnActive_2 = false,false
    this.vm.data.btnActive_3,this.vm.data.btnActive_4 = false,false
    this.vm.data.btnActive_5,this.vm.data.btnChoose_1 = false,false
    this.vm.data.btnChoose_2,this.vm.data.btnChoose_3 = false,false
    this.vm.data.btnChoose_4,this.vm.data.btnChoose_5 = false,false
end
this.GetTimeStrFormat = function(time)
    local day = math.floor(time/86400)
    local hour = math.fmod(math.floor(time/3600),24)
    local minute = math.fmod(math.floor(time/60), 60)
    local timeStr = string.format(LuaMgr.GetLangText("CollectActivityViewModel_3"),day,hour,minute)
    return timeStr
end

this.CheckActivityTime = function()
    local nowTime = LuaMgr.Timestamp()
    if nowTime >= this.activityData.startTime and nowTime < this.activityData.expireTime then
        return true
    end
    local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7023"].NameLan)
    LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
    return false
end

this.CheckActivityClose = function(config)
    if config == nil then return false end
    if config.Open == 1 then return true else return false end
end

this.WhetherUnLock = function(config)
    if config.UnlockType == 0 then
        return false
    end
    if config.UnlockType == 1 then
        if DataMgr.Player.level >= tonumber(config.UnlockParam) then
            return false
        else
            return true
        end
    end
    if config.UnlockType == 2 then
        if DataMgr.Player.dungeonRecords[config.UnlockParam] == nil then
            return true
        else
            return false
        end
    end
end

this.WhetherMeetConditions = function(characterid)
    local character = DataMgr.Player.characters[characterid]
    if character == nil then return false end
    local key = character.id .. "18"
    if character.talents[key].status ~= 2 then return false end
    return true
end

this.WhetherAddHero = function(characterid)
    local tempData = DataMgr.Player.collection.ActInfos[this.skinKey].CollectionMeta
    for i = 1, #tempData do
        if tempData[i].characterid == characterid then
            return true
        end
    end
    return false
end

this.WhetherCanShare = function(tempData)
    for i = 1, #tempData.CollectionMeta do
        local temp = tempData.CollectionMeta[i]
        if temp.characterid == "" or temp.status == 0 then
            return false
        end
    end
    return true
end

this.InitHeroConfig = function()
    this.heroDataTab = {}
    local heroData = table.Copy(DataMgr.Player.characters)
    for k,v in pairs(heroData) do
        if next(v.talents) == nil then goto continue end
        if this.WhetherAddHero(k) then goto continue end
        local key = k .."18"
        if v.talents[key].status == 2 then
            local rare = ConfigMgr.Config.characterTable[k].rare
            v.rare = rare
            table.insert(this.heroDataTab,v)
        end
        ::continue::
    end
    table.sort(this.heroDataTab,this.HeadSort)
end
this.HeadSort = function(a,b)
    if a.rare ~= b.rare then
        return a.rare > b.rare
    else
        if a.level ~= b.level then
            return a.level > b.level
        else
            if a.id ~= b.id then
                return a.id > b.id
            else
                return false
            end
        end
    end
end


this.GetCardUiRoot = function(transform,length)
    local card = {
        cardIcon = {path = "Mask/RawImage",type = "RawImage"},
        cardPos = {path = "Mask/RawImage",type = "RectTransform"},
        isNew = {path = "New",type = "GameObject"},}
    local object,item = nil,{}
    for i = 1, length do
        object = transform:Find("Hero"..this.cardIndex)
        if object ~= nil then
            item = {}
            UITool.Parse(object,item,card)
            table.insert(this.cardList,item)
        end
        this.cardIndex = this.cardIndex + 1
    end
    card = nil
end
this.CalculateNameSize = function(name)
    local length = NumTool.GetStringLength(name)
    return Vector2(39,20 + length * 25)
end
return vm({
    data = data,
    command = command,
    hook = hook
})
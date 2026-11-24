require("ViewModel/LHSA/LHSAGameWitnessItem")

local this = {
    eventConfig = nil,
    caseId = "",

    witnessUIList = {},
    evidenceDataList = {},

    currentVote = 0,


    currentLevelId = nil,
    currentLevelConfig = nil,
    currentEventId = nil,
    currentEventConfig = nil,

    currentAssessScore = 0,
    assessScoreMin = 0,
    assessScoreMax = 200,
}

local objs = {
    witnessManItem = { path = "template/witnessManItem", type = "GameObject" },

    textTitle = { path = "root/Middle/TitleBg/TextTitle", type = "Text" },


    iconPrisoner = { path = "root/Middle/Bg/BgSmal/iconPrisoner", type = "RawImage" },
    namePrisoner = { path = "root/Middle/Bg/BgSmal/namePrisoner", type = "Text" },
    numPrisoner = { path = "root/Middle/Bg/BgSmal/numPrisoner", type = "Text" },
    identityPrisoner = { path = "root/Middle/Bg/BgSmal/identityPrisoner", type = "Text" },
    apartmentPrisoner = { path = "root/Middle/Bg/BgSmal/apartmentPrisoner", type = "Text" },
    chargePrisoner = { path = "root/Middle/Bg/BgSmal/chargePrisoner", type = "Text" },
    bgPrisoner = { path = "root/Middle/Bg/ImageContent2/bgPrisoner", type = "Text" },
    relationPrisoner = { path = "root/Middle/Bg/BgSmal/relationPrisoner", type = "Text" },


    iconPlaintiff = { path = "root/Middle/Bg/iconPlaintiff", type = "RawImage" },
    textTalk = { path = "root/Middle/Bg/Image/TextTalk", type = "Text" },
    textTalk2 = { path = "root/Middle/Bg/Image2/TextTalk2", type = "Text" },
    titlePlaintiff = { path = "root/Middle/Bg/titlePlaintiff", type = "Text" },
    titleContent = { path = "root/Middle/Bg/ImageContent/titleContent", type = "Text" },
    contentPlaintiff = { path = "root/Middle/Bg/ImageContent/contentPlaintiff", type = "Text" },


    scrollViewWitness = { path = "root/Middle/Bg/ScrollViewWitness/Viewport/Content", type = "Transform" },


    witnessBox = { path = "root/Middle/Bg/witnessBox", type = "Transform" },
    evidenceItem1 = { path = "root/Middle/Bg/witnessBox/witnessItem1", type = "Transform" },
    evidenceItem2 = { path = "root/Middle/Bg/witnessBox/witnessItem2", type = "Transform" },
    evidenceItem3 = { path = "root/Middle/Bg/witnessBox/witnessItem3", type = "Transform" },
    evidenceItem4 = { path = "root/Middle/Bg/witnessBox/witnessItem4", type = "Transform" },

    evidenceBtn1 = { path = "root/Middle/Bg/witnessBox/witnessItem1/Image", type = "Button" },
    evidenceBtn2 = { path = "root/Middle/Bg/witnessBox/witnessItem2/Image", type = "Button" },
    evidenceBtn3 = { path = "root/Middle/Bg/witnessBox/witnessItem3/Image", type = "Button" },
    evidenceBtn4 = { path = "root/Middle/Bg/witnessBox/witnessItem4/Image", type = "Button" },


    imgBalanceAni = { path = "root/Middle/Bg/imgBalance", type = "Animator" },
    btnSupport = { path = "root/Middle/Bg/imgBalance/ImgVer/ImgLeft/BtnBox", type = "Button" },
    supportWeight = { path = "root/Middle/Bg/imgBalance/ImgVer/ImgLeft/BtnBox/ImgWeight", type = "GameObject" },
    supportTs = { path = "root/Middle/Bg/imgBalance/ImgVer/ImgLeft/BtnBox/ImaTs", type = "GameObject" },
    textLeft = { path = "root/Middle/Bg/imgBalance/ImgVer/ImgLeft/BtnBox/TextLeft", type = "Text" },

    btnOppose = { path = "root/Middle/Bg/imgBalance/ImgVer/ImgRight/BtnBox", type = "Button" },
    opposeWeight = { path = "root/Middle/Bg/imgBalance/ImgVer/ImgRight/BtnBox/ImgWeight", type = "GameObject" },
    opposeTs = { path = "root/Middle/Bg/imgBalance/ImgVer/ImgRight/BtnBox/ImaTs", type = "GameObject" },
    textRight = { path = "root/Middle/Bg/imgBalance/ImgVer/ImgRight/BtnBox/TextRight", type = "Text" },


    emotionSlider = { path = "root/Middle/Bg/ImgEmotionBg/ImgEmotionSlider", type = "Image" },
    textEmotion = { path = "root/Middle/Bg/ImgEmotionBg/TextEmotion", type = "Text" },
    textContent = { path = "root/Middle/Bg/ImgEmotionBg/TextContent", type = "Text" },


    btnConfirm = { path = "root/Middle/Bg/btnComfirm", type = "Button" },


    tipsBox = { path = "root/Middle/TipsBox", type = "RectTransform" },
    tipCloseBtn = { path = "root/Middle/TipsBox/TipCloseBtn", type = "Button" },
    imageTips = { path = "root/Middle/TipsBox/ImageTips", type = "GameObject" },
    textTips = { path = "root/Middle/TipsBox/ImageTips/TextTips", type = "Text" },
    textTipsTitle = { path = "root/Middle/TipsBox/ImageTips/Image/TextTile", type = "Text" },

    finishAnim = { path = "root/FinishAnim", type = "GameObject" },
    finishAnimImgEmotionSlider = { path = "root/FinishAnim/ImgEmotionBg/ImgEmotionSlider", type = "Image" },
    finishAnimTextEmotion = { path = "root/FinishAnim/ImgEmotionBg/TextEmotion", type = "Text" },
}





this.OnBack = function()
    LuaMgr.Back();
end

this.PlayGame = function(args)
    this.eventConfig = args[0]
    local startLevelId = nil

    if this.eventConfig then
        startLevelId = this.eventConfig.eventParam
    end

    this.LoadCaseData(startLevelId)
end


this.LoadCaseData = function(caseId)
    SetActive(this.imageTips, false)
    SetActive(this.tipCloseBtn.gameObject, false)

    local constants = LHSAMgr.GetCaseConstants()

    this.assessScoreMin = tonumber(constants.CaseAssessScoremin) or 0
    this.assessScoreMax = tonumber(constants.CaseAssessScoremax) or 200
    this.currentAssessScore = LHSAMgr.ClampNumber(
        tonumber(DataMgr.Player.CaseGame.CrtScore) or 0,
        this.assessScoreMin,
        this.assessScoreMax
    )
    local state = LHSAMgr.CheckGameState(caseId)
    if (state == -1) then
        this.currentVote = 0
        this.RefreshVoteUI()
    elseif (state == 0) then
        this.Support()
    elseif (state == 1) then
        this.Oppose()
    end


    local startLevelId = caseId
    if LHSAMgr.IsEmpty(startLevelId) then
        startLevelId = constants.CaseLevel
    end

    if LHSAMgr.IsEmpty(startLevelId) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LHSAGameViewModel_0"))
        return
    end

    this.LoadLevel(startLevelId)
end

this.LoadLevel = function(levelId)
    local levelConfig = LHSAMgr.GetMapConfig("CaseLevelMap", levelId)
    if not levelConfig then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,
            LuaMgr.GetLangText("LHSAGameViewModel_1") .. tostring(levelId) .. "]")
        return
    end

    this.currentLevelId = levelId
    this.currentLevelConfig = levelConfig
    this.LoadCurrentEvent()
end

this.LoadCurrentEvent = function()
    local eventId = DataMgr.Player.CaseGame.LevelEventMap[this.currentLevelId]
    if eventId == nil then
        return
    end

    local eventConfig = LHSAMgr.GetMapConfig("CaseEventMap", eventId)
    if not eventConfig then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,
            LuaMgr.GetLangText("LHSAGameViewModel_2") .. tostring(eventId) .. "]")
        return
    end

    this.currentEventId = eventId
    this.currentEventConfig = eventConfig
    this.RefreshCaseUI(this.currentLevelConfig, eventConfig)
end

this.RefreshCaseUI = function(levelConfig, eventConfig)
    if not levelConfig or not eventConfig then return end

    local caseName = LHSAMgr.GetConfigText(levelConfig.CaseName, levelConfig.CaseNameLan)
    local eventName = LHSAMgr.GetConfigText(eventConfig.EventName, eventConfig.EventNameLan)
    local judgeTalk = LHSAMgr.GetConfigText(levelConfig.NpcInfor, levelConfig.NpcInforLan)
    local evidenceContent = LHSAMgr.GetConfigText(eventConfig.EventText, eventConfig.EventTextLan)

    if not LHSAMgr.IsEmpty(eventName) then
        this.textTitle.text = eventName
        this.titlePlaintiff.text = eventName
    else
        this.textTitle.text = caseName
        this.titlePlaintiff.text = caseName
    end
    this.textLeft.text = LHSAMgr.GetConfigText(eventConfig.RightContent, eventConfig.RightContentLan)
    this.textRight.text = LHSAMgr.GetConfigText(eventConfig.WrongContent, eventConfig.WrongContentLan)
    this.titleContent.text = LuaMgr.GetLangText("LHSAGameViewModel_3")
    this.contentPlaintiff.text = evidenceContent
    this.textTalk.text = judgeTalk
    this.textTalk2.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_31264")
    if not LHSAMgr.IsEmpty(levelConfig.NpcIcon) then
        this.iconPlaintiff.texture = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(levelConfig.NpcIcon))
    end

    local npcConfig = LHSAMgr.GetMapConfig("CaseNpcInforMap", eventConfig.NpcId)
    this.RefreshNpcUI(npcConfig)
    this.RefreshAssessScoreUI()

    this.RefreshWitnessList(LHSAMgr.BuildWitnessList(eventConfig))
    this.RefreshEvidenceList(LHSAMgr.BuildEvidenceList(eventConfig))
end

this.RefreshNpcUI = function(npcConfig)
    if not npcConfig then return end

    this.namePrisoner.text = LHSAMgr.GetConfigText(npcConfig.NpcInfor1, npcConfig.NpcInforLan1)
    this.numPrisoner.text = LHSAMgr.GetConfigText(npcConfig.NpcInfor2, npcConfig.NpcInforLan2)
    this.identityPrisoner.text = LHSAMgr.GetConfigText(npcConfig.NpcInfor3, npcConfig.NpcInforLan3)
    this.apartmentPrisoner.text = LHSAMgr.GetConfigText(npcConfig.NpcInfor4, npcConfig.NpcInforLan4)
    this.chargePrisoner.text = LHSAMgr.GetConfigText(npcConfig.NpcInfor5, npcConfig.NpcInforLan5)
    this.bgPrisoner.text = LHSAMgr.GetConfigText(npcConfig.NpcInfor6, npcConfig.NpcInforLan6)
    this.relationPrisoner.text = LHSAMgr.GetConfigText(npcConfig.NpcInfor7, npcConfig.NpcInforLan7)
    if not LHSAMgr.IsEmpty(npcConfig.NpcIcon) then
        local texture = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(npcConfig.NpcIcon))
        if texture ~= nil then
            this.iconPrisoner.texture = texture
        else
            texture = LHSAMgr.GetTexture(npcConfig.NpcIcon)
            if texture ~= nil then
                this.iconPrisoner.texture = texture
            end
        end
    end
end

this.RefreshAssessScoreUI = function()
    local range = this.assessScoreMax - this.assessScoreMin
    local fill = 0

    if range > 0 then
        fill = (this.currentAssessScore - this.assessScoreMin) / range
    end

    fill = LHSAMgr.ClampNumber(fill, 0, 1)
    this.emotionSlider.fillAmount = fill
    local percent = math.floor(fill * 100) .. "%"
    local str = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_31256")
    this.textEmotion.text = string.format(str, percent)

    local config = LHSAMgr.FindAssessConfig(this.currentAssessScore)
    if not config then return end
    this.textContent.text = LuaMgr.GetLangText(config.RangeTextLan)
end

this.RefreshWitnessList = function(witnessList)
    if not this.witnessUIList then return end

    this.witnessUIList:Clear()

    if not witnessList then return end

    local list = {}
    for i = 1, #witnessList do
        local data = UIListData.GetData(this.witnessManItem, "LHSAGameWitnessItem",
            { config = witnessList[i] })
        table.insert(list, data)
    end
    this.witnessUIList:SetData(list)
end

this.RefreshEvidenceList = function(evidenceList)
    this.evidenceDataList = evidenceList or {}
    local slots = { this.evidenceItem1, this.evidenceItem2, this.evidenceItem3, this.evidenceItem4 }

    for i = 1, 4 do
        local slot = slots[i]
        if slot then
            local bg = slot:Find("Imagebg"):GetComponent("Image")
            local iconObj = slot:Find("Imagebg/ImageIcon"):GetComponent("RawImage")
            if iconObj then
                if this.evidenceDataList[i] then
                    SetActive(iconObj.gameObject, true)
                    bg.enabled = true
                    local textture = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(this.evidenceDataList[i].icon))
                    if (textture ~= nil) then
                        iconObj.texture = textture
                    else
                        textture = LHSAMgr.GetTexture(this.evidenceDataList[i].icon)
                        if (textture ~= nil) then
                            iconObj.texture = textture
                        end
                    end
                else
                    bg.enabled = false
                    SetActive(iconObj.gameObject, false)
                end
            end
        end
    end
end

this.OnClickEvidence = function(index)
    local evidenceData = this.evidenceDataList[index]
    if not evidenceData then return end

    local slots = { this.evidenceItem1, this.evidenceItem2, this.evidenceItem3, this.evidenceItem4 }
    local slot = slots[index]
    if not slot then return end

    this.ShowTips(evidenceData.name or "", evidenceData.content or "", slot.position)
end





this.OnClickSupport = function()
    if (this.currentVote ~= 1) then
        this.Support()
    end
end

this.Support = function()
    this.imgBalanceAni.enabled = true
    this.imgBalanceAni:Rebind()
    if (this.currentVote == 0) then
        this.imgBalanceAni:Play("ani_LHSAGamePanel_imgBalance02");
    else
        this.imgBalanceAni:Play("ani_LHSAGamePanel_imgBalance03");
    end
    this.currentVote = 1
    this.RefreshVoteUI()
end

this.OnClickOppose = function()
    if (this.currentVote ~= 2) then
        this.Oppose()
    end
end

this.Oppose = function()
    this.imgBalanceAni.enabled = true
    this.imgBalanceAni:Rebind()
    if (this.currentVote == 0) then
        this.imgBalanceAni:Play("ani_LHSAGamePanel_imgBalance");
    else
        this.imgBalanceAni:Play("ani_LHSAGamePanel_imgBalance04");
    end
    this.currentVote = 2
    this.RefreshVoteUI()
end

this.RefreshVoteUI = function()
    SetActive(this.supportWeight, this.currentVote == 1)
    SetActive(this.supportTs, this.currentVote == 0)

    SetActive(this.opposeWeight, this.currentVote == 2)
    SetActive(this.opposeTs, this.currentVote == 0)
end

this.OnClickTipsClose = function()
    SetActive(this.imageTips, false)
    SetActive(this.tipCloseBtn.gameObject, false)
end

this.OnClickConfirm = function()
    if this.currentVote == 0 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LHSAGameViewModel_4"))
        return
    end

    if not this.currentEventConfig then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LHSAGameViewModel_5"))
        return
    end


    local state = this.currentVote == 1 and 0 or 1

    local data = {}
    data.content = LuaMgr.GetLangText("LHSAGameViewModel_6")
    data.callback = function()
        local startScore = tonumber(DataMgr.Player.CaseGame.CrtScore) or 0
        ApiMgr.Request("caseGame/summitCase", { LevelId = this.currentLevelId, Right = state }, true,
            function(result)
                if this.startDelay ~= nil then
                    coroutine_runner.stop(this.startDelay)
                    this.startDelay = nil
                end

                local endScore = tonumber(DataMgr.Player.CaseGame.CrtScore) or 0
                local range = this.assessScoreMax - this.assessScoreMin
                local initFill = 0
                if range > 0 then
                    initFill = (startScore - this.assessScoreMin) / range
                end
                initFill = LHSAMgr.ClampNumber(initFill, 0, 1)
                this.finishAnimImgEmotionSlider.fillAmount = initFill
                local initPercent = endScore - startScore
                initPercent = initPercent >= 0 and "+" .. initPercent or initPercent
                local str = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_31265")
                this.finishAnimTextEmotion.text = str .. initPercent

                SetActive(this.finishAnim, false)
                this.startDelay = coroutine_runner.start(function()
                    SetActive(this.finishAnim, true)
                    coroutine_runner.wait(0.75)
                    AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. "UI/gavel_2.mp3");

                    local duration = 1.0
                    local elapsed = 0
                    while elapsed < duration do
                        coroutine_runner.wait(0)
                        elapsed = elapsed + UnityEngine.Time.deltaTime
                        if elapsed > duration then
                            elapsed = duration
                        end

                        local t = elapsed / duration
                        local currentScore = startScore + (endScore - startScore) * t
                        local fill = 0
                        if range > 0 then
                            fill = (currentScore - this.assessScoreMin) / range
                        end
                        fill = LHSAMgr.ClampNumber(fill, 0, 1)

                        this.finishAnimImgEmotionSlider.fillAmount = fill
                    end

                    local remaining = 1.5 - elapsed
                    if remaining > 0 then
                        coroutine_runner.wait(remaining)
                    end
                    LuaMgr.Back()
                end)
            end, nil, true, true);
    end
    LuaMgr.ShowLuaPanel(UIName.LHSAGameResultViewModel, data)
end

this.ShowTips = function(title, content, position)
    this.textTipsTitle.text = title
    this.textTips.text = content

    if position then
        this.tipsBox.position = position
    else
        this.tipsBox.localPosition = Vector3.zero
    end
    SetActive(this.imageTips, true)
    SetActive(this.tipCloseBtn.gameObject, true)
end

this.Clear = function()

end

this.Destroy = function()
end





this.OnClickEvidence1 = function() this.OnClickEvidence(1) end
this.OnClickEvidence2 = function() this.OnClickEvidence(2) end
this.OnClickEvidence3 = function() this.OnClickEvidence(3) end
this.OnClickEvidence4 = function() this.OnClickEvidence(4) end

this.RegisterEvents = function()
    LuaMgr.AddUIEventListener(UIEventConst.LHSAPlayGame, this.PlayGame)
end

this.RemoveEvents = function()
    LuaMgr.RemoveUIEventListener(UIEventConst.LHSAPlayGame, this.PlayGame)
end

local data = {}
local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)

        local witnessTransform = this.scrollViewWitness.transform
        this.witnessUIList = UIListView.New(witnessTransform)

        LuaMgr.AddClick(this.btnSupport, this.OnClickSupport)
        LuaMgr.AddClick(this.btnOppose, this.OnClickOppose)
        LuaMgr.AddClick(this.btnConfirm, this.OnClickConfirm)
        LuaMgr.AddClick(this.tipCloseBtn, this.OnClickTipsClose)

        LuaMgr.AddClick(this.evidenceBtn1, this.OnClickEvidence1)
        LuaMgr.AddClick(this.evidenceBtn2, this.OnClickEvidence2)
        LuaMgr.AddClick(this.evidenceBtn3, this.OnClickEvidence3)
        LuaMgr.AddClick(this.evidenceBtn4, this.OnClickEvidence4)

        RedMgr.Singleton:RegisterViewModel(UIName.LHSAGameViewModel)
    end,
    before_active = function(vm)
        this.RegisterEvents()
        this.imgBalanceAni.enabled = true
        this.imgBalanceAni:Rebind()
        this.imgBalanceAni:Update(0)
        this.imgBalanceAni.enabled = false
        SetActive(this.finishAnim, false)
        if vm.behaviour.Params ~= nil and vm.behaviour.Params.Length > 0 then
            this.PlayGame(vm.behaviour.Params)
        else
            this.LoadCaseData(nil)
        end
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack)
    end,
    before_deactive = function(vm)
        this.Clear()
        this.RemoveEvents()
        if this.witnessUIList then
            this.witnessUIList:Clear()
        end
        if this.startDelay ~= nil then
            coroutine_runner.stop(this.startDelay)
        end
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.btnSupport, this.OnClickSupport)
        LuaMgr.RemoveClick(this.btnOppose, this.OnClickOppose)
        LuaMgr.RemoveClick(this.btnConfirm, this.OnClickConfirm)
        LuaMgr.RemoveClick(this.tipCloseBtn, this.OnClickTipsClose)

        LuaMgr.RemoveClick(this.evidenceBtn1, this.OnClickEvidence1)
        LuaMgr.RemoveClick(this.evidenceBtn2, this.OnClickEvidence2)
        LuaMgr.RemoveClick(this.evidenceBtn3, this.OnClickEvidence3)
        LuaMgr.RemoveClick(this.evidenceBtn4, this.OnClickEvidence4)

        UIListView.ClearItem("LHSAGameWitnessItem")
        RedMgr.Singleton:RemoveViewModel(UIName.LHSAGameViewModel)
        this.Destroy()
    end
}

return vm({ data = data, command = command, hook = hook })
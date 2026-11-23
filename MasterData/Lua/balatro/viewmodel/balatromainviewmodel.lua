









require("Balatro/ViewModel/BlatroMainStartGamePanel")
require("Balatro/ViewModel/BlatroMainGamePanel")
require("Balatro/ViewModel/BalatroBrandShowUI")
require("Balatro/ViewModel/BalatroChangeForeverPopup")
require("Balatro/ViewModel/BalatroBag/BalatroBagPopUp")
local this = {
    startGamePanelData = nil,
    gameMainPanelData = nil,
    otherBrandParentData = nil,
    curHandBrandCount = 0,
    remainHandBrandStyleItems = {}
}

local objs = {
    roundItem = {path = "template/RoundItem", type = BalatroUtil.GameObject},
    brandItem = {path = "template/BrandItem", type = BalatroUtil.GameObject},
    showItem = {path = "template/BrandShowItem", type = BalatroUtil.GameObject},
    remainCardCount = {path = "root/Left/RemainCard/Count", type = BalatroUtil.Text},
    styleCountHearts = {path = "root/Left/RemainCard/Detail1/RemainCount", type = BalatroUtil.Text},
    styleCountSpades = {path = "root/Left/RemainCard/Detail2/RemainCount", type = BalatroUtil.Text},
    styleCountClubs = {path = "root/Left/RemainCard/Detail3/RemainCount", type = BalatroUtil.Text},
    styleCountDiamonds = {path = "root/Left/RemainCard/Detail4/RemainCount", type = BalatroUtil.Text},
    exitBtn = {path = "root/Right/ExitBtn", type = BalatroUtil.Button},
    bagBtn = {path = "root/Right/Anim/BagBtn", type = BalatroUtil.Button},
    brandTypeBtn = {path = "root/Right/Anim/BrandTypeBtn", type = BalatroUtil.Button},
    brandGroupBtn = {path = "root/Right/Anim/BrandGroupBtn", type = BalatroUtil.Button},
    startGamePanel = {path = "root/Middle/StartGamePanel", type = BalatroUtil.GameObject},
    gameMainPanel = {path = "root/Middle/GameMainPanel", type = BalatroUtil.GameObject},
    otherBrandParent = {path = "root/Left/OtherBrandGroup", type = BalatroUtil.GameObject},

    inputFiled1 = {path = "root/Middle/TestObj/GloabalSceneEffect", type = BalatroUtil.InputField},
    inputFiled2 = {path = "root/Middle/TestObj/GloabalSceneEffect/RoundSceneEffect", type = BalatroUtil.InputField},
    inputFiled3 = {path = "root/Middle/TestObj/BrandIDs/PropsID", type = BalatroUtil.InputField},
    inputFiled4 = {path = "root/Middle/TestObj/BrandIDs", type = BalatroUtil.InputField},
    inputFiled5 = {path = "root/Middle/TestObj/BrandIDs/BalatroID", type = BalatroUtil.InputField},
    button1 = {path = "root/Middle/TestObj/GloabalSceneEffect/OKGlobal", type = BalatroUtil.Button},
    button2 = {path = "root/Middle/TestObj/GloabalSceneEffect/RoundSceneEffect/OkRound", type = BalatroUtil.Button},
    button3 = {path = "root/Middle/TestObj/BrandIDs/PropsID/OKProps", type = BalatroUtil.Button},
    button4 = {path = "root/Middle/TestObj/BrandIDs/OKBrands", type = BalatroUtil.Button},
    button5 = {path = "root/Middle/TestObj/BrandIDs/BalatroID/OKProps", type = BalatroUtil.Button},
    sceneID = {path = "root/Middle/TestObj/BrandIDs/sceneID", type = BalatroUtil.Text},
    sceneRoundID = {path = "root/Middle/TestObj/BrandIDs/sceneIDRound", type = BalatroUtil.Text}

}

this.before_awake = function()
    LuaMgr.AddClick(this.exitBtn, this.OnClickBack)
    LuaMgr.AddClick(this.bagBtn, this.OnClickBag)
    LuaMgr.AddClick(this.brandTypeBtn, this.OnClickBrandType)
    LuaMgr.AddClick(this.brandGroupBtn, this.OnClickBrandGroup)


    LuaMgr.AddClick(this.button1, this.ChangeGlobalSceneEffect)
    LuaMgr.AddClick(this.button2, this.ChangeRoundSceneEffect)
    LuaMgr.AddClick(this.button3, this.TestAddPropsBrand)
    LuaMgr.AddClick(this.button4, this.TestChangeHandBrand)
    LuaMgr.AddClick(this.button5, this.TestAddBalatroBrand)

    this.startGamePanelData = BlatroMainStartGamePanel.New(this.roundItem, this.startGamePanel)
    this.gameMainPanelData = BlatroMainGamePanel.New(this.gameMainPanel)
    this.otherBrandParentData = BalatroBrandShowUI.New(this.otherBrandParent, this.showItem, true)
    this.gameMainPanelData:SetBalatroShowUI(this.otherBrandParentData)
    this.remainHandBrandStyleItems = {
        [1] = this.styleCountHearts,
        [2] = this.styleCountSpades,
        [3] = this.styleCountClubs,
        [4] = this.styleCountDiamonds
    }
    BalatroDataMgr.Init()
end

this.before_active = function()
    LuaMgr.AddUIEventListener(UIEventConst.BalatroClickStartGame, this.OnStartGame)
    LuaMgr.AddUIEventListener(UIEventConst.BalatroReplay, this.ReplayGame)
    LuaMgr.AddUIEventListener(UIEventConst.BalatroStartNewRound, this.OnStartNewRound)
    LuaMgr.AddUIEventListener(UIEventConst.BalatroCalculateEnd, this.OnBalatroCalculateEnd)
    LuaMgr.AddUIEventListener(UIEventConst.BalatroChooseGeneralBrand, this.OnChooseGeneralBrand)
    LuaMgr.AddUIEventListener(UIEventConst.BalatroHandBrandChange, this.OnBalatroHandBrandChange)
    LuaMgr.AddUIEventListener(UIEventConst.BalatroPlaycard, this.OnPlaycard)
    LuaMgr.AddUIEventListener(UIEventConst.BalatroDiscard, this.OnDiscard)
    LuaMgr.AddUIEventListener(UIEventConst.BalatroChooseBalatroBrand, this.ChooseBalatroBrand)
    LuaMgr.AddUIEventListener(UIEventConst.BalatroInitShowBalatroItem, this.InitShowBalatroItem)
    LuaMgr.AddUIEventListener(UIEventConst.BalatroGetPropsBrand, this.AddPropsBrand)
    LuaMgr.AddUIEventListener(UIEventConst.BalatroRefreshHandBrand, this.OnRefreshHandBrand)
    LuaMgr.AddUIEventListener(UIEventConst.BalatroDestroyHandBrand, this.OnDestroyHandBrand)
    LuaMgr.AddUIEventListener(UIEventConst.BalatroUpLevelBrandType, this.OnUpLevelBrandType)

    LuaMgr.AddUIEventListener(UIEventConst.BalatroBrandDestroy, this.OnDestroyBalatroBrand)
    LuaMgr.AddUIEventListener(UIEventConst.BalatroBrandRefresh, this.OnRefreshShowBalatro)
    this.ReplayGame()
    this.SetGMUIShow(false)
end

this.before_deactive = function()
    if this.coroutine ~= nil then
        coroutine_runner.stop(this.coroutine)
        this.coroutine = nil
    end
    LuaMgr.RemoveUIEventListener(UIEventConst.BalatroClickStartGame, this.OnStartGame)
    LuaMgr.RemoveUIEventListener(UIEventConst.BalatroReplay, this.ReplayGame)
    LuaMgr.RemoveUIEventListener(UIEventConst.BalatroStartNewRound, this.OnStartNewRound)
    LuaMgr.RemoveUIEventListener(UIEventConst.BalatroCalculateEnd, this.OnBalatroCalculateEnd)
    LuaMgr.RemoveUIEventListener(UIEventConst.BalatroChooseGeneralBrand, this.OnChooseGeneralBrand)
    LuaMgr.RemoveUIEventListener(UIEventConst.BalatroHandBrandChange, this.OnBalatroHandBrandChange)
    LuaMgr.RemoveUIEventListener(UIEventConst.BalatroPlaycard, this.OnPlaycard)
    LuaMgr.RemoveUIEventListener(UIEventConst.BalatroDiscard, this.OnDiscard)
    LuaMgr.RemoveUIEventListener(UIEventConst.BalatroChooseBalatroBrand, this.ChooseBalatroBrand)
    LuaMgr.RemoveUIEventListener(UIEventConst.BalatroInitShowBalatroItem, this.InitShowBalatroItem)
    LuaMgr.RemoveUIEventListener(UIEventConst.BalatroGetPropsBrand, this.AddPropsBrand)
    LuaMgr.RemoveUIEventListener(UIEventConst.BalatroRefreshHandBrand, this.OnRefreshHandBrand)
    LuaMgr.RemoveUIEventListener(UIEventConst.BalatroDestroyHandBrand, this.OnDestroyHandBrand)
    LuaMgr.RemoveUIEventListener(UIEventConst.BalatroUpLevelBrandType, this.OnUpLevelBrandType)
    LuaMgr.RemoveUIEventListener(UIEventConst.BalatroBrandDestroy, this.OnDestroyBalatroBrand)
    LuaMgr.RemoveUIEventListener(UIEventConst.BalatroBrandRefresh, this.OnRefreshShowBalatro)
    this.RefreshBrandPoolCount(true)
    if this.gameMainPanelData then
        this.gameMainPanelData:Clear()
    end
    this.otherBrandParentData:InitItem()
end

this.ReplayGame = function()
    BalatroDataMgr.Init()
    BalatroStepMgr.GameInit()
    if this.gameMainPanelData then
        this.gameMainPanelData:Clear()
    end
    this.otherBrandParentData:InitItem()
    SetActive(this.startGamePanel, true)
    this.startGamePanelData:Refresh()
    SetActive(this.gameMainPanel, false)
    this.RefreshBrandPoolCount()
end


this.OnStartGame = function(args)
    if args.Length == 0 then
        LuaDebug.error("this.OnStartGame 参数错误" .. args.Length)
        return
    end
    this.RefreshBrandPoolCount()
    this.gameMainPanelData:Refresh()
    local data = {
        type = BalatroChangeForeverPopup.ChangeForverType.Init,
        callback = this.StartGame
    }
    LuaMgr.ShowLuaPanel(UIName.BalatroChangeForeverPopup, data)
end


this.StartGame = function()
    if BalatroStepMgr.CheckNewGame() == true then
        BalatroStepMgr.GameStart()
        this.SetGMUIShow(true)
    end
    if BalatroStepMgr.CheckNewPhase() == true then
        BalatroStepMgr.PhaseStart()
    end

    BalatroStepMgr.RoundStart()
    this.gameMainPanelData:Clear()
    SetActive(this.startGamePanel, false)
    SetActive(this.gameMainPanel, true)
    this.gameMainPanelData:Refresh()
    local brandDatas = BalatroDataMgr.GetGeneralBrand(nil, BalatroUtil.StepType.RoundStart)
    this.gameMainPanelData:DealBrand(this.brandItem, brandDatas)
    this.RefreshBrandPoolCount()
    this.ShowSceneEffectID()
end


this.OnStartNewRound = function()
    BalatroStepMgr.RoundStart()
    BalatroDataMgr.ResetBrandPool()
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroBrandRefresh)
    this.StartGame()
end

this.OnChooseGeneralBrand = function(params)
    if params.Length < 1 then
        return
    end
    local data = params[0]

    local item = data.item
    local isChoose = data.isChoose
    local isClick = data.isClick

    if isChoose == true then
        if isClick == true and this.gameMainPanelData:CheckChooseLimit() == true then
            local tip = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20034")
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tip)
            item:Reset()
            item:PlayAnim(BalatroBrandItem.ClickAniName)
            return
        end
    end
    local chooseRes = this.gameMainPanelData:ChooseBrandItem(item, isChoose)
    if chooseRes ~= nil then
        chooseRes:Reset()
        BalatroDataMgr.OnChooseGeneralBrand(chooseRes:GetData(), false)
    end
    BalatroDataMgr.OnChooseGeneralBrand(item:GetData(), isChoose)
    this.gameMainPanelData:BeforePlaycardRefresh()
end


this.OnBalatroCalculateEnd = function(param)
    if BalatroStepMgr.CheckIsGameOver() then
        BalatroDataMgr.SetSettlingStatus(false)
        this.gameMainPanelData:SetGameOver()
        return
    end
    local gameStatus = BalatroStepMgr.OnCheckGameEnd(param, true)

    if gameStatus == BalatroUtil.RoundStatus.GameOverDefeat or gameStatus == BalatroUtil.RoundStatus.Defeat or gameStatus == BalatroUtil.RoundStatus.GameOverVictory then
        BalatroStepMgr.RoundEnd()
        this.gameMainPanelData:SetGameOver()
        local playcardTimesScore = BalatroStepMgr.GetPlaycardTimesScore()
        local discardTimesScore = BalatroStepMgr.GetDiscardTimesScore()
        BalatroStepMgr.AddCalExtraScore(playcardTimesScore + discardTimesScore)
        BalatroDataMgr.RefreshStatisticsData()
        local data = {
            RoundStatus = gameStatus
        }
        LuaMgr.ShowLuaPanel(UIName.BalatroGameEndPopUp, data)
        this.ReportScore()
        return
    elseif gameStatus == BalatroUtil.RoundStatus.Victory then
        BalatroDataMgr.RoundEnd()
        local playcardTimesScore = BalatroStepMgr.GetPlaycardTimesScore()
        local discardTimesScore = BalatroStepMgr.GetDiscardTimesScore()
        BalatroStepMgr.AddCalExtraScore(playcardTimesScore + discardTimesScore)
        BalatroDataMgr.RefreshStatisticsData()
        LuaMgr.ShowLuaPanel(UIName.BalatroVictoryPopup)
        return
    end
    local curRound = BalatroStepMgr.GetCurRoundData()
    local dealBrandCount = curRound:GetFixGetBrandCount()
    local maxHandBrandCount = BalatroStepMgr.GetCurRoundData():GetMaxHandBrandCount()
    if not dealBrandCount or dealBrandCount == 0 then
        dealBrandCount = maxHandBrandCount - this.curHandBrandCount
    elseif dealBrandCount ~= 0 then
        local temp = maxHandBrandCount - this.curHandBrandCount
        dealBrandCount = math.min(temp, dealBrandCount)
    end
    if dealBrandCount <= 0 then
        print("this.OnBalatroCalculateEnd 发牌数量", this.curHandBrandCount, dealBrandCount)
    end
    dealBrandCount = math.max(0, dealBrandCount)
    local brandDatas = BalatroDataMgr.GetGeneralBrand(dealBrandCount)
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroRefreshBrandGroup)
    this.gameMainPanelData:DealBrand(this.brandItem, brandDatas)
    this.RefreshBrandPoolCount()
end

this.ReportScore = function()
    local tbl = {}
    tbl.gameData = BalatroDataMgr.GetStatisticsData()
    local data = {
        Score = math.floor(tbl.gameData.totalScore),
        Detail = json.encode(tbl)
    }
    ApiMgr.Request("balatro/complete", data, true, nil, nil, true)
end

this.RefreshBrandPoolCount = function(isInit)
    local totalBrandCount = 0
    local allBrandDatas = {}
    local brandDatas1 = BalatroDataMgr.GetMainBrandPool()
    local brandDatas2 = BalatroDataMgr.GetSecondBrandPool()
    for _, value in pairs(brandDatas1) do
        if value:IsDestroy() == false and value:GetUsed() == false then
            local style = value:GetStyle()
            allBrandDatas[style] = (allBrandDatas[style] or 0) + 1
        end
        if value:IsDestroy() == false then
            totalBrandCount = totalBrandCount + 1
        end
    end
    for _, value in pairs(brandDatas2) do
        if value:IsDestroy() == false and value:GetUsed() == false then
            local style = value:GetStyle()
            allBrandDatas[style] = (allBrandDatas[style] or 0) + 1
        end
        if value:IsDestroy() == false then
            totalBrandCount = totalBrandCount + 1
        end
    end
    local remainCardCount = ""
    if isInit then
        remainCardCount = BalatroUtil.ColorText("#4EA396", totalBrandCount)
    else
        remainCardCount = BalatroUtil.ColorText("#4EA396", #BalatroDataMgr.GetMainBrandPool())
    end
    this.remainCardCount.text = string.format("%s/%d", remainCardCount, totalBrandCount)
    for key, value in pairs(this.remainHandBrandStyleItems) do
        local remainCount = allBrandDatas[key]
        if remainCount == nil then
            value.text = tostring(0)
        else
            value.text = tostring(remainCount)
        end
    end
end

this.OnBalatroHandBrandChange = function(params)
    if not params or params.Length == 0 then
        return
    end
    this.curHandBrandCount = params[0]
end

this.OnPlaycard = function()
    local brandDatas = BalatroDataMgr.GetChooseBrandList()
    if NumTool.GetLen(brandDatas) == 0 then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20016")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        BalatroDataMgr.SetSettlingStatus(false)
        return
    end
    local callback = function()
        BalatroDataMgr.ResetChooseBrand()
        this.gameMainPanelData:Refresh()
    end
    this.gameMainPanelData:OnPlaycard(this.brandItem, brandDatas, callback)
end

this.OnDiscard = function(params)
    local discardType = BalatroUtil.DiscardType.None
    if params.Length > 0 then
        discardType = params[0]
    end
    local brandDatas = nil
    if discardType == BalatroUtil.DiscardType.ByInitactive then
        brandDatas = BalatroDataMgr.GetChooseBrandList()
    elseif discardType == BalatroUtil.DiscardType.ByScene and params.Length > 1 then
        brandDatas = params[1]
    end
    if NumTool.GetLen(brandDatas) == 0 then
        if discardType == BalatroUtil.DiscardType.ByInitactive then
            local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20017")
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        end
        BalatroDataMgr.SetSettlingStatus(false)
        return
    end
    local callback = function()
        BalatroDataMgr.ResetChooseBrand()
        this.gameMainPanelData:Refresh()
    end
    this.gameMainPanelData:OnDiscard(this.brandItem, brandDatas, discardType, callback)
end

this.InitShowBalatroItem = function()
    this.otherBrandParentData:InitItem()
end

this.ChooseBalatroBrand = function(params)
    local data = params[0]

    local balatroData = data.balatroData
    if data.selected == true then
        if balatroData:GetIsDestroy() == true then
            return
        end
        this.otherBrandParentData:ChangeBalatroItem(balatroData, true)
    else
        this.otherBrandParentData:ChangeBalatroItem(balatroData, false)
    end
end

this.AddPropsBrand = function(params)
    local data = params[0]
    local propsBrandData = data.propsBrandData
    this.otherBrandParentData:AddPropsItem(propsBrandData, true)
end

this.OnRefreshHandBrand = function()
    this.RefreshBrandPoolCount()
    this.gameMainPanelData:RefreshHandBrand()
end

this.OnDestroyHandBrand = function(params)
    this._DestroyBrands = nil
    this._DealBrands = nil
    if params.Length > 0 and type(params[0]) == BalatroUtil.LuaDataType.Table then
        this._DestroyBrands = params[0].destroyBrands
        this._DealBrands = params[0].dealBrands
    end
    if this._DestroyBrands ~= nil then
        for key, value in pairs(this._DestroyBrands) do
            value:SetDestroy()
        end
    end
    this.coroutine = coroutine_runner.start(this.OnDestroyHandBrandCor)
end

this.OnUpLevelBrandType = function()
    this.gameMainPanelData:BeforePlaycardRefresh()
end

this.OnDestroyHandBrandCor = function()
    if this._DestroyBrands then
        this.gameMainPanelData:OnDestroyHandBrand(this._DestroyBrands)
        for key, value in pairs(this._DestroyBrands) do
            BalatroDataMgr.OnChooseGeneralBrand(value, false)
            BalatroDataMgr.AddOrRemoveHandBrand(false, value)
        end
        coroutine_runner.wait(0.5)
    end
    if this._DealBrands then
        this.gameMainPanelData:DealBrand(this.brandItem, this._DealBrands)
    end
    coroutine_runner.wait(0)
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroRefreshBrandGroup)
    this.RefreshBrandPoolCount()
end

this.OnDestroyBalatroBrand = function(params)
    local data = {
        selected = false,
        balatroData = params[0].balatroData,
        callback = function()
            local curRound = BalatroStepMgr.GetCurRoundData()
            curRound:SetSceneEffectValid(true)
        end
    }
    BalatroDataMgr.SelectBrandGroup(params[0].balatroData, false)
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroChooseBalatroBrand, data)
end

this.OnRefreshShowBalatro = function()
    this.otherBrandParentData:OnRefreshShowBalatro()
end

this.OnClickBack = function()
    local data = {
        leftStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20006"),
        rightStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20012"),
        content = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20018"),
        callBackConfirm = function()
            if BalatroStepMgr.CheckGameRealStart() == true then
                local paramsData = {
                    status = BalatroUtil.RoundStatus.Exit
                }
                LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroCalculateEnd, paramsData)
            else
                LuaMgr.HidePanel(UIName.BalatroMainViewModel)
                LuaMgr.ShowLuaPanel(UIName.BalatroLaunchPanel)
                BalatroDataMgr.Destroy()
            end
        end
    }
    LuaMgr.ShowLuaPanel(UIName.BalatroMsgboxPopUp, data)
end

this.OnClickBag = function()
    LuaMgr.ShowLuaPanel(UIName.BalatroBagPopup)
end

this.OnClickBrandType = function()
    LuaMgr.ShowLuaPanel(UIName.BalatroBrandTypePreviewPopup)
end

this.OnClickBrandGroup = function()
    LuaMgr.ShowLuaPanel(UIName.BalatroBrandGroupPreviewPopup)
end


this.SetGMUIShow = function(isStart)
    SetActive(this.inputFiled1.gameObject, isStart == false)
    SetActive(this.inputFiled4.gameObject, isStart == true)
end

this.ShowSceneEffectID = function()
    local sceneEffect = BalatroStepMgr.GetGlobalSceneEffect()
    if sceneEffect ~= nil then
        this.sceneID.text = string.format(LuaMgr.GetLangText("BalatroMainViewModel_0"), sceneEffect:GetID())
    end
    local roundData = BalatroStepMgr.GetCurRoundData()
    local roundSceneEffect = roundData:GetSceneEffect()
    SetActive(this.sceneRoundID.gameObject, false)
    if roundSceneEffect ~= nil then
        SetActive(this.sceneRoundID.gameObject, true)
        this.sceneRoundID.text = roundSceneEffect:GetID()
    end
end

this.ChangeGlobalSceneEffect = function()
    if this.inputFiled1.text == "" then
        return
    end
    local sceneID = tonumber(this.inputFiled1.text)
    if not BalatroDataMgr.GetSceneConfigByID(sceneID) then
        return
    end
    local curRound = BalatroStepMgr.GetCurRoundData()
    curRound:SetSceneEffectValid(true)
    curRound:SetFixGetBrandCount(0)
    curRound:SetScenePlaycardTimes(0)
    curRound:SetSceneDiscardTimes(0)
    curRound:SetExtraResultJudge()
    curRound:SetGetBrandJudge()
    curRound:SetPlaycardCallback()
    curRound:SetBaseDiscardTimes()
    curRound:SetSceneHandBrandCount(0)
    curRound:SetBrandTypeCountCondition(0)
    BalatroDataMgr.Flush_Straight_NeedCount = 5
    BalatroDataMgr.IsUseExtra_Style = false
    BalatroDataMgr.Straight_IsPart = false
    local allBalatro = BalatroDataMgr.GetUsingBalatroLst()
    for key, value in pairs(allBalatro) do
        value:SetInvalid(false)
    end
    local allBrandTypeData = BalatroDataMgr.GetBrandTypeDatas()
    for _, value in pairs(allBrandTypeData) do
        value:CalBeforeReset()
    end
    local sceneData = BalatroSceneData.New(BalatroDataMgr.GetSceneConfigByID(sceneID))
    BalatroStepMgr.SetGlobalSceneEffect(sceneData)
    this.inputFiled1.text = ""
    this.ShowSceneEffectID()
    this.startGamePanelData:Refresh()
end

this.ChangeRoundSceneEffect = function()
    if this.inputFiled2.text == "" then
        return
    end
    local sceneID = BalatroUtil.SplitNumbers(this.inputFiled2.text)
    local curPhaseData = BalatroStepMgr.GetCurPhaseData()
    if curPhaseData ~= nil and sceneID ~= nil then
        if type(sceneID) ~= BalatroUtil.LuaDataType.Table then
            curPhaseData[1]:SetSceneEffectByID(sceneID)
        else
            for key, value in pairs(curPhaseData) do
                if key <= #sceneID then
                    value:SetSceneEffectByID(sceneID[key])
                end
            end
        end
    end
    this.inputFiled2.text = ""
    this.ShowSceneEffectID()
    this.startGamePanelData:Refresh()
end

this.TestAddPropsBrand = function()
    if this.inputFiled3.text == "" then
        return
    end
    local propsBrand = BalatroDataMgr.AddPropsBrandData(tonumber(this.inputFiled3.text))
    if propsBrand ~= nil then
        LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroGetPropsBrand, {propsBrandData = propsBrand})
    end
    this.inputFiled3.text = ""
end

this.TestAddBalatroBrand = function()
    if this.inputFiled5.text == "" then
        BalatroDataMgr.AddDropBalatro()
    else
        BalatroDataMgr.AddDropBalatro(tonumber(this.inputFiled5.text))
    end
    this.inputFiled5.text = ""
end

this.TestChangeHandBrand = function()
    if this.inputFiled4.text == "" then
        return
    end
    BalatroDataMgr.ResetChooseBrand()
    local allBrandStrIDs = BalatroUtil.SplitNumbers(this.inputFiled4.text)
    if type(allBrandStrIDs) == "table" then
        for key, value in pairs(allBrandStrIDs) do
            local brandID = tonumber(value)
            if brandID ~= nil then
                local configData = BalatroDataMgr.GetGeneralBrandConfig(brandID)
                if configData ~= nil then
                    local data = BalatroDataMgr.NewGeneralBrand(configData)
                    local brandItem = this.gameMainPanelData.handBrandItems[key]
                    if brandItem then
                        BalatroDataMgr.AddOrRemoveHandBrand(false, brandItem.data)
                        BalatroDataMgr.AddOrRemoveHandBrand(true, data)
                        brandItem:SetData(BalatroBrandItem.SizeType.Small, configData.ResID, data)
                    end
                end
            end
        end
    else
        local brandID = tonumber(allBrandStrIDs)
        if brandID ~= nil then
            local configData = BalatroDataMgr.GetGeneralBrandConfig(brandID)
            if configData ~= nil then
                local data = BalatroDataMgr.NewGeneralBrand(configData)
                local brandItem = this.gameMainPanelData.handBrandItems[1]
                if brandItem then
                    BalatroDataMgr.AddOrRemoveHandBrand(false, brandItem.data)
                    BalatroDataMgr.AddOrRemoveHandBrand(true, data)
                    brandItem:SetData(BalatroBrandItem.SizeType.Small, configData.ResID, data)
                end
            end
        end
    end
    this.OnRefreshHandBrand()
    this.inputFiled4.text = ""
end


local data = {
    testIsVisible = false
}
local command = {}
local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
    end,
    before_active = function(vm)
        vm.data.testIsVisible = LuaMgr.IsDebug()
        vm.behaviour:UpdateTopBar("", this.OnClickBack)
        this.before_active()
    end,
    before_deactive = function(vm)
        this.before_deactive()
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.exitBtn, this.OnClickBack)
        LuaMgr.RemoveClick(this.bagBtn, this.OnClickBag)
        LuaMgr.RemoveClick(this.brandTypeBtn, this.OnClickBrandType)

        LuaMgr.RemoveClick(this.button1, this.ChangeGlobalSceneEffect)
        LuaMgr.RemoveClick(this.button2, this.ChangeRoundSceneEffect)
        LuaMgr.RemoveClick(this.button3, this.AddPropsBrand)
        LuaMgr.RemoveClick(this.button4, this.TestChangeHandBrand)
        LuaMgr.RemoveClick(this.button5, this.TestAddBalatroBrand)

        if this.gameMainPanelData then
            this.gameMainPanelData:Destroy()
        end
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)
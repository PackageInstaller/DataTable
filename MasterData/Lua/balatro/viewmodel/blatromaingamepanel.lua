







require("Balatro/ViewModel/BalatroBrandItem")
require("Balatro/ViewModel/BalatroJumpWordItem")











































BlatroMainGamePanel = {}
BlatroMainGamePanel.__index = BlatroMainGamePanel

BlatroMainGamePanel.ScoreAnimName = "ani_ScoreValue_click_btn"
BlatroMainGamePanel.RateAnimName = "ani_RateValue_click_btn"
local this = {
    phaseItems = nil,
    handBrandItems = nil,
    selectBrands = nil,
    sortDescenedByStyle = false,
    sortDescenedByPoint = false,

    chooseItems = {}
}

local objs = {
    roundScore = {path = "TopInfoGroup/Group_GoalScore/RoundScore", type = BalatroUtil.Text},
    totalScore = {path = "TopInfoGroup/Group_title/TotalScore", type = BalatroUtil.Text},
    goalScore = {path = "TopInfoGroup/Group_title/GoalScore", type = BalatroUtil.Text},
    brandType = {path = "TopInfoGroup/BrandType_bg/BrandType", type = BalatroUtil.Text},
    brandTypeLv = {path = "TopInfoGroup/BrandType_bg/BrandTypeLv", type = BalatroUtil.Text},
    tempTotalScore = {path = "TopInfoGroup/ScoreValue/BrandTypeScore", type = BalatroUtil.Text},
    tempTotalRate = {path = "TopInfoGroup/RateValue/BrandTypeRate", type = BalatroUtil.Text},
    playcardCount = {path = "TopInfoGroup/Playcard/PlaycardCount", type = BalatroUtil.Text},
    discardCount = {path = "TopInfoGroup/Discard/DiscardCount", type = BalatroUtil.Text},
    roundCount = {path = "TopInfoGroup/Round/RoundCount", type = BalatroUtil.Text},
    phaseNum = {path = "TopInfoGroup/Phase/PhaseNum", type = BalatroUtil.Text},
    globalSceneDes = {path = "TopInfoGroup/SceneDesGroup/GlobalSceneDes", type = BalatroUtil.Text},
    roundSceneDes = {path = "TopInfoGroup/SceneDesGroup/RoundSceneDes", type = BalatroUtil.Text},
    sceneDesGroup = {path = "TopInfoGroup/SceneDesGroup", type = BalatroUtil.GameObject},
    lookSceneBGObj = {path = "TopInfoGroup/BG1", type = BalatroUtil.GameObject},
    lookSceneBtn = {path = "TopInfoGroup/LookSceneBtn", type = BalatroUtil.Button},
    playcardGroup = {path = "PlaycardGroup", type = BalatroUtil.Transform},
    handBrandGroup = {path = "HandBrandGroup", type = BalatroUtil.Transform},
    sortStyleBtn = {path = "SortStyleBtn", type = BalatroUtil.Button},
    sortPointBtn = {path = "SortPointBtn", type = BalatroUtil.Button},
    discardBtn = {path = "DiscardBtn", type = BalatroUtil.Button},
    playcardBtn = {path = "PlaycardBtn", type = BalatroUtil.Button},
    lookSceneBtnRect = {path = "TopInfoGroup/LookSceneBtn", type = BalatroUtil.UIRotateByCurve},
    jumpWordGroup = {path = "JumpWordGroup", type = BalatroUtil.Transform},
    jumpwordPrefab = {path = "JumpWordGroup/ItemPrefab", type = BalatroUtil.GameObject},
    jumpwordTotalScoreObj = {path = "JumpWordGroup/TotalScore", type = BalatroUtil.GameObject},
    scoreValueAni = {path = "TopInfoGroup/ScoreValue", type = BalatroUtil.Animator},
    rateValueAni = {path = "TopInfoGroup/RateValue", type = BalatroUtil.Animator},
    roundScoreAni = {path = "TopInfoGroup/Group_GoalScore/RoundScore", type = BalatroUtil.Animator}
}

function BlatroMainGamePanel.New(obj)

    local self = {}
    setmetatable(self, BlatroMainGamePanel)
    self.gameObject = obj
    UITool.Parse(self.gameObject, self, objs)
    self.phaseItems = {}
    self.handBrandItems = {}
    self.sortDescenedByStyle = false
    self.sortDescenedByPoint = false
    self.curSortMothed = 2
    self.handBrandGroupLayout = self.handBrandGroup:GetComponent(BalatroUtil.HorizontalLayoutGroup)
    self.chooseItems = {}
    self.isOpenSceneDes = true
    self.jumpwordItems = {}
    self.jumpwordTotalScoreData = BalatroJumpWordItem.New(self.jumpwordTotalScoreObj, self.jumpWordGroup, false)
    self:Init()
    return self
end





function BlatroMainGamePanel:DealBrand(brandPrefab, brandDatas)
    if brandPrefab then
        self.brandPrefab = brandPrefab
    end
    if not brandDatas then
        LuaDebug.error("BlatroMainGamePanel:DealBrand 数据错误")
        return
    end
    self.brandDatas = brandDatas
    self.brandPrefab = brandPrefab
    local func = function()
        self:CoroutineDealBrand()
    end
    self.coroutineDealBrand = coroutine_runner.start(func)
end

function BlatroMainGamePanel:CoroutineDealBrand()
    local brandDatasLen = #self.brandDatas
    local oldHandBrandCount = #BalatroDataMgr.GetHandBrandDataList()
    for i = 1, brandDatasLen do
        local data = self.brandDatas[i]
        local obj = BalatroBrandItem.New(self.brandPrefab, self.handBrandGroup, true, i)
        local resName = data:GetResName(true)
        obj.gameObject.name = string.format("Brand_%d", #self.handBrandItems + 1)
        obj:SetData(BalatroBrandItem.SizeType.Middle, resName, data)
        obj:PlayAnim(BalatroBrandItem.LoopAniName)
        BalatroDataMgr.AddOrRemoveHandBrand(true, data)
        self:SetLayoutSpace(oldHandBrandCount + i)
        table.insert(self.handBrandItems, obj)
        coroutine_runner.wait(0.08)
    end
    local curRound = BalatroStepMgr.GetCurRoundData()
    local mustPlaycardCount = curRound:GetMustPlaycardCount()
    local brandDatas = BalatroDataMgr.GetHandBrandDataList()
    if #brandDatas < mustPlaycardCount then
        local paramsData = {
            status = curRound:GetParticularRes(true)
        }
        LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroCalculateEnd, paramsData)
    end
    self:RefreshHandBrand(self.curSortMothed)
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroHandBrandChange, #self.handBrandItems)
    self.operateStatus = BalatroUtil.StepType.Idle

    coroutine_runner.wait(0.1)
    BalatroDataMgr.SetSettlingStatus(false)
end

function BlatroMainGamePanel:SetLayoutSpace(brandCount)
    if brandCount <= 8 then
        self.handBrandGroupLayout.spacing = 0
        return
    end

    local x = brandCount
    local a = 0.00007769090154594732
    local b = -0.012220606708853943
    local c = 0.7055091490733219
    local d = -18.23455865365986
    local e = 103.4041998539911
    self.handBrandGroupLayout.spacing = a * x * x * x * x + b * x * x * x + c * x * x + d * x + e
end




function BlatroMainGamePanel:DeskBrand(brandPrefab, brandDatas, discardType)

    table.sort(brandDatas, BalatroUtil.SortBrandByPoint)
    local brandDatasLen = #brandDatas
    self.desktopBrandItems = {}
    if discardType == BalatroUtil.DiscardType.ByInitactive then
        for i = 1, brandDatasLen do
            local data = brandDatas[i]
            local obj = BalatroBrandItem.New(brandPrefab, self.playcardGroup, false, i)
            local resName = data:GetResName(false)
            obj:SetData(BalatroBrandItem.SizeType.Small, resName, data)
            obj:PlayAnim(BalatroBrandItem.SmallBornAniName)
            table.insert(self.desktopBrandItems, obj)
            BalatroDataMgr.AddOrRemoveHandBrand(false, data)
        end
        self:OnDestroyHandBrand(brandDatas)
    end
    self:RefreshHandBrand(self.curSortMothed)
    local tempTbl = BalatroDataMgr.GetHandBrandDataList()
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroHandBrandChange, NumTool.GetLen(tempTbl))
end


function BlatroMainGamePanel:OnPlaycard(brandPrefab, brandDatas, callback)
    local curRound = BalatroStepMgr.GetCurRoundData()
    if curRound:RemainPlaycardTimes() <= 0 then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20036")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        BalatroDataMgr.SetSettlingStatus(false)
        return
    end
    local isValid, param, callbackParam = BalatroStepMgr.PlaycardBefore(brandDatas)
    if not isValid then
        local func = function()
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tostring(param))
            if callbackParam then
                callbackParam()
            end
            BalatroDataMgr.SetSettlingStatus(false)
        end
        self.coroutineValid = coroutine_runner.start(func)
        return
    end
    self:PlaycardAfter_GetBrandBefore(brandDatas)
    self:DeskBrand(brandPrefab, brandDatas, BalatroUtil.DiscardType.ByInitactive)
    local oldHandBrandCount = #BalatroDataMgr.GetHandBrandDataList()
    self:SetLayoutSpace(oldHandBrandCount)
    local func = function()
        self:OnPlaycardCallback(callback)
    end
    self.coroutinePlaycard = coroutine_runner.start(func)
end

function BlatroMainGamePanel:OnPlaycardCallback(callback)
    self.operateStatus = BalatroUtil.StepType.PlaycardAfter
    local curRoundData = BalatroStepMgr.GetCurRoundData()
    self.oldRoundScore = curRoundData:GetTotalScore()
    BalatroStepMgr.PlaycardAfter()
    local playcardRes = BalatroStepMgr.GetPlaycardResData()
    local isvalid, validType = curRoundData:CheckBrandTypeValid(curRoundData:GetCurBrandType())
    local totalScore = BalatroStepMgr.GetBrandTypeScore(validType)
    local totalRate = BalatroStepMgr.GetBrandTypeRate(validType)
    for key, value in pairs(self.desktopBrandItems) do
        local brandData = value:GetData()
        if brandData:IsJoinCal() then
            local score, rate = 0, 0
            for key1, value1 in pairs(playcardRes) do
                local brandData1 = value1.brandData
                if brandData:GetID() == brandData1:GetID() then
                    score = value1.score or 0
                    rate = value1.rate or 0
                    break
                end
            end
            value:PlayAnim(BalatroBrandItem.DealScoreAniName, true)
            totalScore = totalScore + score
            totalRate = totalRate + rate
            if score ~= 0 then
                self.scoreValueAni:Play(BlatroMainGamePanel.ScoreAnimName)
            end
            if rate ~= 0 then
                self.rateValueAni:Play(BlatroMainGamePanel.RateAnimName)
            end
            self:AfterPlaycardRefresh(totalScore, totalRate)
            BalatroUtil.PlaySound(1)
            coroutine_runner.wait(0.3)
        end
    end
    local allBalatroData = self.balatroShowUI:GetBalatroShowItems()
    local muliRate = 1
    for key, value in pairs(allBalatroData) do
        local data = value:GetBalatroData()
        local during = 0.5
        if data:GetAddRate() > 0 then
            local jumpItemData = {}
            jumpItemData.NumType = BalatroUtil.ResultType.Rate
            jumpItemData.Symbol = BalatroUtil.CalSymbolType.Add
            jumpItemData.Number = data:GetAddRate()
            local jumpItem = self:GetJumpWordItem()
            jumpItem:SetData(jumpItemData)
            totalRate = totalRate + data:GetAddRate()
            self:AfterPlaycardRefresh(totalScore, totalRate * muliRate)
            value:PlayAnim("BalatroMainPanel_BrandShowItem_Jumpword")
            self.rateValueAni:Play(BlatroMainGamePanel.RateAnimName)
            coroutine_runner.wait(during)
        end

        if data:GetMuliRate() > 1 then
            local jumpItemData = {}
            jumpItemData.NumType = BalatroUtil.ResultType.Rate
            jumpItemData.Symbol = BalatroUtil.CalSymbolType.Multiply
            jumpItemData.Number = data:GetMuliRate()
            local jumpItem = self:GetJumpWordItem()
            jumpItem:SetData(jumpItemData)
            muliRate = muliRate * data:GetMuliRate()
            self:AfterPlaycardRefresh(totalScore, totalRate * muliRate)
            value:PlayAnim("BalatroMainPanel_BrandShowItem_Jumpword")
            self.rateValueAni:Play(BlatroMainGamePanel.RateAnimName)
            coroutine_runner.wait(during)
        end

        if data:GetScore() > 0 then
            local jumpItemData = {}
            jumpItemData.NumType = BalatroUtil.ResultType.Score
            jumpItemData.Symbol = BalatroUtil.CalSymbolType.Add
            jumpItemData.Number = data:GetScore()
            local jumpItem = self:GetJumpWordItem()
            jumpItem:SetData(jumpItemData)
            totalScore = totalScore + data:GetScore()
            self:AfterPlaycardRefresh(totalScore, totalRate * muliRate)
            self.scoreValueAni:Play(BlatroMainGamePanel.ScoreAnimName)
            value:PlayAnim("BalatroMainPanel_BrandShowItem_Jumpword")
            coroutine_runner.wait(during)
        end
    end

    local deltaScore = curRoundData:GetTotalScore() - self.oldRoundScore
    local jumpItemData = {}
    jumpItemData.NumType = BalatroUtil.ResultType.Rate
    jumpItemData.AllNumber = true
    jumpItemData.Number = deltaScore
    jumpItemData.AnimName = "UIBalatro_JumpWordTotalScore"
    coroutine_runner.wait(0.8)
    self.jumpwordTotalScoreData:SetData(jumpItemData)

    local during = 1
    local tweenCallback = function(value)
        if value == nil then
            return
        end
        if value ~= math.floor(value) then
            self.roundScore.text = string.format("%.1f", value)
        else
            self.roundScore.text = tostring(value)
        end
    end
    self.roundScoreRollTween = DOTWeen.To(tweenCallback, self.oldRoundScore, curRoundData:GetTotalScore(), during)
    self.roundScoreRollTween.onComplete = function()
        self.roundScoreAni:Play("ani_RoundScore_click_btn")
    end
    coroutine_runner.wait(during + 0.3)
    self:Refresh()
    if callback then
        callback()
    end
    local gameStatus = BalatroStepMgr.OnCheckGameEnd()

    if gameStatus == BalatroUtil.RoundStatus.GameOverDefeat or gameStatus == BalatroUtil.RoundStatus.Defeat or gameStatus == BalatroUtil.RoundStatus.Victory then
        coroutine_runner.wait(1.5)
    end
    for key, value in pairs(self.desktopBrandItems) do
        value:Destroy(true)
    end

    coroutine_runner.wait(0.3)
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroCalculateEnd)
    self.operateStatus = BalatroUtil.StepType.Idle
end


function BlatroMainGamePanel:OnDiscard(brandPrefab, brandDatas, discardType, callback)
    if discardType == BalatroUtil.DiscardType.ByInitactive then
        local isValid = BalatroStepMgr.DiscardBefore(brandDatas)
        if not isValid then
            local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20022")
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
            return
        end
    end

    self:DeskBrand(brandPrefab, brandDatas, discardType)
    local func = function()
        self:OnDiscardCallback(callback)
    end
    self.coroutineOnDiscard = coroutine_runner.start(func)
end

function BlatroMainGamePanel:OnDiscardCallback(callback)
    self.operateStatus = BalatroUtil.StepType.DiscardAfter
    BalatroStepMgr.DiscardAfter()
    coroutine_runner.wait(0.5)
    for key, value in pairs(self.desktopBrandItems) do
        value:Destroy(true)
    end
    coroutine_runner.wait(0.5)
    self:Refresh()
    if callback then
        callback()
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroCalculateEnd)
    self.operateStatus = BalatroUtil.StepType.Idle
    BalatroDataMgr.SetSettlingStatus(false)
end


function BlatroMainGamePanel:SetGameOver()
    coroutine_runner.stop(self.coroutineDealBrand)
    coroutine_runner.stop(self.coroutineValid)
    coroutine_runner.stop(self.coroutinePlaycard)
    coroutine_runner.stop(self.coroutineOnDiscard)
end



function BlatroMainGamePanel:OnDestroyHandBrand(brandDatas)
    local goalIndexTbl = {}
    for key, value in pairs(self.handBrandItems) do
        if value:GetData() == nil then
            LuaDebug.error("[Balatro] 240 value:GetData() is nil")
            break
        end
        for key1, value1 in pairs(brandDatas) do
            if value1:GetID() == value:GetData():GetID() then
                table.insert(goalIndexTbl, key)
                break
            end
        end
    end
    for i = #goalIndexTbl, 1, -1 do
        local item = table.remove(self.handBrandItems, goalIndexTbl[i])
        if item then
            item:Destroy(true)
        end
    end
end


function BlatroMainGamePanel:PlaycardAfter_GetBrandBefore(brandDatas)
    local curRound = BalatroStepMgr.GetCurRoundData()
    local returnRes1, returnRes2 = curRound:CallPlaycardAfter(brandDatas, BalatroUtil.StepType.RoundStart)
    if returnRes1 == false or not returnRes2 or type(returnRes2) ~= BalatroUtil.LuaDataType.Table then
        LuaDebug.error(string.format("[Balatro] 判定错误：returnRes1:%s %s", tostring(returnRes1), tostring(returnRes2)))
        return
    end

    for key, value in pairs(returnRes2) do
        BalatroDataMgr.AddOrRemoveHandBrand(false, value)
    end
    self:OnDestroyHandBrand(returnRes2)
end


function BlatroMainGamePanel:RefreshHandBrand(sortMothed)
    if sortMothed ~= nil then
        self.curSortMothed = sortMothed
    end
    local tempTbl = BalatroDataMgr.GetHandBrandDataList()
    local datasLen = #self.handBrandItems
    if datasLen ~= NumTool.GetLen(tempTbl) then
        LuaDebug.error(string.format("BlatroMainGamePanel:RefreshHandBrand 游戏对象和数据对象数量不一致 datasLen:%d tempTblLen:%d %s", datasLen, NumTool.GetLen(tempTbl), debug.traceback()))
        return
    end
    if self.curSortMothed == 1 then
        if self.sortDescenedByStyle == true then
            table.sort(tempTbl, BalatroUtil.SortBrandByStyle)
        else
            table.sort(tempTbl, BalatroUtil.SortBrandByStyleDescend)
        end
    elseif self.curSortMothed == 2 then
        if self.sortDescenedByPoint == true then
            table.sort(tempTbl, BalatroUtil.SortBrandByPoint)
        else
            table.sort(tempTbl, BalatroUtil.SortBrandByPointDescend)
        end
    end
    for key, value in pairs(self.handBrandItems) do
        value.gameObject.transform:SetSiblingIndex(key - 1)
        local data = tempTbl[key]
        local resName = data:GetResName(true)
        if value:IsChoosed() then
            value:OnChooseBrand()
        end
        value:SetData(BalatroBrandItem.SizeType.Middle, resName, data)
        tempTbl[key]:SetIndex(key)
        value:PlayAnim(BalatroBrandItem.LoopAniName)
    end
    self.chooseItems = {}
end



function BlatroMainGamePanel:Init()
    self.phaseItems = {}
    self.handBrandItems = {}

    self.desktopBrandItems = {}
    self.frequenciesTips = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20023")

    self.OnClickSortStyle = function()
        if self.operateStatus ~= BalatroUtil.StepType.Idle then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, self.frequenciesTips)
            return
        end
        if self.sortDescenedByStyle == false then
            self.sortDescenedByStyle = true
        else
            self.sortDescenedByStyle = false
        end
        self:RefreshHandBrand(1)
    end
    self.OnClickSortPoint = function()
        if self.operateStatus ~= BalatroUtil.StepType.Idle then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, self.frequenciesTips)
            return
        end
        if self.sortDescenedByPoint == false then
            self.sortDescenedByPoint = true
        else
            self.sortDescenedByPoint = false
        end
        self:RefreshHandBrand(2)
    end
    self.OnClickDiscard = function()
        if BalatroDataMgr.GetSettlingStatus() == true or self.operateStatus ~= BalatroUtil.StepType.Idle then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, self.frequenciesTips)
            return
        end
        if #BalatroDataMgr.GetChooseBrandList() > BalatroConstVal.MaxPlaycardCount then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20032"), BalatroConstVal.MaxPlaycardCount))
            return
        end
        local curRound = BalatroStepMgr.GetCurRoundData()
        if curRound:RemainDiscardTimes() == 0 then
            local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20022")
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
            return
        end
        BalatroDataMgr.SetSettlingStatus(true)
        self.chooseItems = {}
        LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroDiscard, BalatroUtil.DiscardType.ByInitactive)
    end
    self.OnClickPlaycard = function()
        if BalatroDataMgr.GetSettlingStatus() == true or self.operateStatus ~= BalatroUtil.StepType.Idle then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, self.frequenciesTips)
            return
        end
        if #BalatroDataMgr.GetChooseBrandList() > BalatroConstVal.MaxPlaycardCount then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20004"), BalatroConstVal.MaxPlaycardCount))
            return
        end
        local curRound = BalatroStepMgr.GetCurRoundData()
        if curRound:RemainPlaycardTimes() == 0 then
            local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20022")
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
            return
        end
        BalatroDataMgr.SetSettlingStatus(true)
        self.chooseItems = {}
        LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroPlaycard)
        BalatroUtil.PlaySound(1)
    end
    self.OnClickLookScene = function()
        if self.isOpenSceneDes == true then
            self.isOpenSceneDes = false
        else
            self.isOpenSceneDes = true
        end
        SetActive(self.sceneDesGroup, self.isOpenSceneDes == true)
        SetActive(self.lookSceneBGObj, self.isOpenSceneDes == true)
        local goalAngle = 0
        if self.isOpenSceneDes == false then
            goalAngle = -180
        end
        self.lookSceneBtn.interactable = false
        local tempBtn = self.lookSceneBtn
        local callback = function()
            tempBtn.interactable = true
        end

        self.lookSceneBtnRect:DOLocalRotate(goalAngle, 0.5, callback, true)
    end

    LuaMgr.AddClick(self.sortStyleBtn, self.OnClickSortStyle)
    LuaMgr.AddClick(self.sortPointBtn, self.OnClickSortPoint)
    LuaMgr.AddClick(self.discardBtn, self.OnClickDiscard)
    LuaMgr.AddClick(self.playcardBtn, self.OnClickPlaycard)
    LuaMgr.AddClick(self.lookSceneBtn, self.OnClickLookScene)

    local stringZero = "0"
    self.roundScore.text = stringZero
    self.totalScore.text = stringZero
    self.goalScore.text = stringZero
    self.brandType.text = stringZero
    self.brandTypeLv.text = stringZero
    self.playcardCount.text = stringZero
    self.discardCount.text = stringZero
    self.roundCount.text = stringZero
    self.phaseNum.text = stringZero
    self.tempTotalScore.text = stringZero
    self.tempTotalRate.text = stringZero
end

function BlatroMainGamePanel:SetBalatroShowUI(balatroShowUI)
    self.balatroShowUI = balatroShowUI
end

function BlatroMainGamePanel:GetJumpWordItem()
    for key, value in pairs(self.jumpwordItems) do
        if value:IsInvalid() == true then
            return value
        end
    end
    local item = BalatroJumpWordItem.New(self.jumpwordPrefab, self.jumpWordGroup, true)
    table.insert(self.jumpwordItems, item)
    return item
end

function BlatroMainGamePanel:Refresh()
    local curRoundData = BalatroStepMgr.GetCurRoundData()
    self.goalScore.text = curRoundData:GetRealGoalScore()
    self.roundCount.text = curRoundData:GetRound()
    self.phaseNum.text = curRoundData:GetPhaseIndex()
    self.playcardCount.text = curRoundData:RemainPlaycardTimes()
    self.discardCount.text = curRoundData:RemainDiscardTimes()
    local tempScore = curRoundData:GetTotalScore()
    self.roundScore.text = string.format("%s", BalatroUtil.ToScientific(tempScore))
    local brandTypeID = curRoundData:GetCurBrandType()
    local brandTypeData = BalatroDataMgr.GetBrandTypeDataByID(brandTypeID)
    local emptyStr = ""
    if brandTypeData then
        self.brandType.text = brandTypeData:GetName()
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20026")
        self.brandTypeLv.text = string.format(tipsContent, BalatroUtil.ColorText("#FFE078", brandTypeData:GetLevel()))
    else
        self.brandType.text = emptyStr
        self.brandTypeLv.text = emptyStr
    end
    self.totalScore.text = BalatroUtil.ToScientific(BalatroStepMgr.GetGlobalTotalScore())
    local globalSceneEffect = BalatroStepMgr.GetGlobalSceneEffect()

    if globalSceneEffect ~= nil then
        self.globalSceneDes.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20041") .. globalSceneEffect:GetDes()
    end
    local roundSceneEffect = curRoundData:GetSceneEffect()
    if roundSceneEffect ~= nil then
        self.roundSceneDes.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20042") .. roundSceneEffect:GetDes()
        SetActive(self.roundSceneDes.gameObject, true)
    else
        SetActive(self.roundSceneDes.gameObject, false)
    end
    self:BeforePlaycardRefresh()
end


function BlatroMainGamePanel:CheckChooseLimit()
    return #self.chooseItems >= 5
end



function BlatroMainGamePanel:ChooseBrandItem(item, isChoose)
    if isChoose == false then
        local index = 0
        for key, value in pairs(self.chooseItems) do
            if value ~= nil and value:GetData() ~= nil and item ~= nil and item:GetData() ~= nil and value:GetData():GetID() == item:GetData():GetID() then
                index = key
                break
            end
        end
        if index ~= 0 and self.chooseItems ~= nil and index ~= nil then
            table.remove(self.chooseItems, index)
        end
        return nil
    end
    local isCountLimit = self:CheckChooseLimit()
    table.insert(self.chooseItems, item)
    if isCountLimit == true then
        return table.remove(self.chooseItems, 1)
    end
    return nil
end

function BlatroMainGamePanel:BeforePlaycardRefresh()
    local brandDatas = BalatroDataMgr.GetChooseBrandList()
    local brandType = BalatroStepMgr.GetBrandType(brandDatas)
    local brandTypeData = BalatroDataMgr.GetBrandTypeDataByID(brandType)
    local emptyStr = ""
    local totalScore = 0
    local totalRate = 0
    if brandTypeData ~= nil then
        self.brandType.text = brandTypeData:GetName()
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20026")
        self.brandTypeLv.text = string.format(tipsContent, BalatroUtil.ColorText("#FFE078", brandTypeData:GetLevel()))
        totalScore = totalScore + BalatroStepMgr.GetBrandTypeScore(brandType)
        totalRate = totalRate + BalatroStepMgr.GetBrandTypeRate(brandType)
    else
        self.brandType.text = emptyStr
        self.brandTypeLv.text = emptyStr
    end
    self.tempTotalScore.text = tostring(totalScore)
    self.tempTotalRate.text = tostring(totalRate)
end

function BlatroMainGamePanel:AfterPlaycardRefresh(brandScore, brandRate)
    local brandDatas = BalatroDataMgr.GetChooseBrandList()
    local brandType = BalatroStepMgr.GetBrandType(brandDatas)
    local curRound = BalatroStepMgr.GetCurRoundData()
    local brandTypeValid, validBrandType = curRound:CheckBrandTypeValid(brandType)
    local brandTypeData = BalatroDataMgr.GetBrandTypeDataByID(validBrandType)
    local emptyStr = ""
    local totalScore = 0
    local totalRate = 0
    if brandTypeData ~= nil then
        self.brandType.text = brandTypeData:GetName()
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20026")
        self.brandTypeLv.text = string.format(tipsContent, BalatroUtil.ColorText("#FFE078", brandTypeData:GetLevel()))
        totalScore = totalScore + brandScore
        totalRate = totalRate + brandRate
    else
        self.brandType.text = emptyStr
        self.brandTypeLv.text = emptyStr
    end
    self.tempTotalScore.text = tostring(totalScore)
    self.tempTotalRate.text = tostring(totalRate)
end

function BlatroMainGamePanel:Clear()
    if self.coroutineDealBrand ~= nil then
        coroutine_runner.stop(self.coroutineDealBrand)
    end
    if self.coroutineValid ~= nil then
        coroutine_runner.stop(self.coroutineValid)
    end
    if self.coroutinePlaycard ~= nil then
        coroutine_runner.stop(self.coroutinePlaycard)
    end
    if self.coroutineOnDiscard ~= nil then
        coroutine_runner.stop(self.coroutineOnDiscard)
    end
    for _, value in pairs(self.handBrandItems) do
        if value then
            value:Destroy(true)
        end
    end
    for _, value in pairs(self.desktopBrandItems) do
        if value then
            value:Destroy(true)
        end
    end
    BalatroDataMgr.ClearHandBrand()
    self.isOpenSceneDes = true
    SetActive(self.sceneDesGroup, true)
    SetActive(self.lookSceneBGObj, true)
    self.lookSceneBtn.interactable = true
    self.lookSceneBtn.transform.localEulerAngles = Vector3
    self.handBrandItems = {}
end

function BlatroMainGamePanel:Destroy()
    LuaMgr.RemoveClick(self.sortStyleBtn, self.OnClickSortStyle)
    LuaMgr.RemoveClick(self.sortPointBtn, self.OnClickSortPoint)
    LuaMgr.RemoveClick(self.discardBtn, self.OnClickDiscard)
    LuaMgr.RemoveClick(self.playcardBtn, self.OnClickPlaycard)
end
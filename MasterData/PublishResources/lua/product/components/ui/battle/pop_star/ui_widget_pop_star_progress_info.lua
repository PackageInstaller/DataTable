_class("UIWidgetPopStarProgressInfo", UICustomWidget)
UIWidgetPopStarProgressInfo = UIWidgetPopStarProgressInfo

function UIWidgetPopStarProgressInfo:Constructor()
end

function UIWidgetPopStarProgressInfo:OnShow()
  self._go = self:GetGameObject()
  self._goStageGroup = self:GetGameObject("StageGroup")
  self._txtStage = self:GetUIComponent("UILocalizationText", "txtStage")
  self._stageInfoRootPath = self:GetUIComponent("UISelectObjectPath", "stageInfoRoot")
  self._stageInfo = self._stageInfoRootPath:SpawnObject("UIWidgetPopStarStageInfo")
  self._goStageGroup:SetActive(false)
  self._rtImgBK = self:GetUIComponent("RectTransform", "imgBK")
  self._rtProgressBtm = self:GetUIComponent("RectTransform", "maskProgressBtm")
  self._rtProgressUp = self:GetUIComponent("RectTransform", "maskProgressUp")
  self._markList = self:GetUIComponent("UISelectObjectPath", "progressMark")
  self._anim = self:GetUIComponent("Animation", "ProgressGroup")
  self._rtEffPointer = self:GetUIComponent("RectTransform", "effPointer")
  self:_InitProgress(0)
  self._curScore = 0
  self._minNum = 0
  self._maxNum = 0
  self._txtScoreNum = self:GetUIComponent("UILocalizationText", "txtScoreNum")
  self._txtScoreNum:SetText("0")
  self:Init()
  self:AttachEvent(GameEventType.PopStarRefreshProgressInfo, self.OnRefreshProgressInfo)
  self:AttachEvent(GameEventType.PopStarRefreshStageInfo, self.OnRefreshStageInfo)
end

function UIWidgetPopStarProgressInfo:OnHide()
  self:DetachEvent(GameEventType.PopStarRefreshProgressInfo, self.OnRefreshProgressInfo)
  self:DetachEvent(GameEventType.PopStarRefreshStageInfo, self.OnRefreshStageInfo)
end

function UIWidgetPopStarProgressInfo:SetActive(state)
  self._go:SetActive(state)
end

function UIWidgetPopStarProgressInfo:_InitProgress()
  local baseWidth = BattleConst.PopStarMaskBaseWidth
  self._rtProgressUp.sizeDelta = Vector2(baseWidth, self._rtProgressUp.sizeDelta.y)
  local btmWidth = self._rtProgressUp.sizeDelta.x + BattleConst.PopStarPointWidth
  self._rtProgressBtm.sizeDelta = Vector2(btmWidth, self._rtProgressBtm.sizeDelta.y)
  local tmpPos = self._rtEffPointer.anchoredPosition3D
  tmpPos.x = 0
  self._rtEffPointer.anchoredPosition3D = tmpPos
end

function UIWidgetPopStarProgressInfo:Init()
  local matchModule = GameGlobal.GetModule(MatchModule)
  local enterData = matchModule:GetMatchEnterData()
  local createInfo = enterData:GetMissionCreateInfo()
  if not createInfo.is_challenge then
    self:InitNormal3StarInfo(createInfo.mission_id)
  else
    self:SetStageInfo()
  end
end

function UIWidgetPopStarProgressInfo:_CalculatePos(curNum)
  if not self._maxNum or self._maxNum == 0 then
    return 0
  end
  local percent = curNum / self._maxNum
  local addLength = BattleConst.PopStarProgressLength * percent
  local curPos = BattleConst.PopStarProgressStart + addLength
  return curPos
end

function UIWidgetPopStarProgressInfo:_CalculateMarkPosX(curNum)
  local basePos = -1 * self._rtImgBK.rect.width / 2
  local curPos = self:_CalculatePos(curNum)
  return curPos + basePos
end

function UIWidgetPopStarProgressInfo:BtnStageOnClick()
  local buffIDList = InnerGameHelperRender.GetPopStarStageBuffIDList()
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIWidgetPopStarProgressInfo",
    input = "BtnStageOnClick",
    args = {}
  })
  self._stageInfo:Init(buffIDList)
end

function UIWidgetPopStarProgressInfo:SetStageInfo()
  local index, score, preScore = InnerGameHelperRender.GetPopStarStageInfo()
  if not index then
    return
  end
  if score == 0 then
    return
  end
  self._goStageGroup:SetActive(true)
  local strIndex = "str_n31_popstar_battle_stage" .. index
  self._txtStage:SetText(StringTable.Get(strIndex))
  self._maxNum = score
  self._minNum = preScore
  self._markList:SpawnObject("UIWidgetPopStarMarkInfo")
  local markGOList = self._markList:GetAllSpawnList()
  local posX = self:_CalculateMarkPosX(score)
  markGOList[1]:Init(posX, score)
end

function UIWidgetPopStarProgressInfo:OnRefreshStageInfo()
  local function callback()
    self:_InitProgress()
    
    local index, score, preScore = InnerGameHelperRender.GetPopStarStageInfo()
    if not index then
      return
    end
    if score == 0 then
      return
    end
    local strIndex = "str_n31_popstar_battle_stage" .. index
    self._txtStage:SetText(StringTable.Get(strIndex))
    self._maxNum = score
    self._minNum = preScore
    self._curScore = self._minNum
    local markGOList = self._markList:GetAllSpawnList()
    markGOList[1]:ResetNum(score)
    local addScore = InnerGameHelperRender.GetPopStarCurScore() - self._minNum
    self:OnRefreshProgressInfo(addScore)
  end
  
  local addScore = self._maxNum - self._curScore
  self:OnRefreshProgressInfo(addScore, callback)
end

function UIWidgetPopStarProgressInfo:InitNormal3StarInfo(missionID)
  local allStarConditions = ConfigServiceHelper.GetPopStar3StarCondition(missionID)
  if allStarConditions and 0 < #allStarConditions then
    self._markList:SpawnObjects("UIWidgetPopStarMarkInfo", #allStarConditions)
    local markGOList = self._markList:GetAllSpawnList()
    local markNumList = {}
    for i = 1, #allStarConditions do
      local conID = allStarConditions[i]
      local paramStrArray = Cfg.cfg_threestarcondition[conID].ConditionNumber
      if #paramStrArray == 1 then
        markNumList[#markNumList + 1] = tonumber(paramStrArray[1])
      end
    end
    if #markNumList ~= #markGOList then
      Log.error("UIWidgetPopStarProgressInfo PopStar missionID:", missionID, " 3 star cfg error!")
      return
    end
    self._maxNum = markNumList[#markNumList]
    for i = 1, #markNumList do
      local curNum = markNumList[i]
      local posX = self:_CalculateMarkPosX(curNum)
      markGOList[i]:Init(posX, curNum)
    end
  end
end

function UIWidgetPopStarProgressInfo:OnRefreshProgressInfo(addScore, callback)
  self:StartTask(self.PlayAnimation, self, addScore, callback)
end

function UIWidgetPopStarProgressInfo:PlayAnimation(TT, addScore, callback)
  local durationTime = addScore * BattleConst.PopStarOneScoreTime / 1000
  local startValue = self._curScore
  local endValue = startValue + addScore
  DoTweenHelper.DoUpdateInt(startValue, endValue, durationTime, function(val)
    local num = math.floor(val)
    self._txtScoreNum:SetText(tostring(num))
  end)
  self._curScore = self._curScore + addScore
  if startValue < self._maxNum then
    self._anim:Play("uieff_UIWidgetPopStarProgressInfo_in")
    local baseWidth = BattleConst.PopStarMaskBaseWidth + BattleConst.PopStarProgressStart
    local tmpPercent = (self._curScore - self._minNum) / (self._maxNum - self._minNum)
    if 1 < tmpPercent then
      tmpPercent = 1
    end
    local addWidth = BattleConst.PopStarProgressLength * tmpPercent
    local upWidth = baseWidth + addWidth
    local tweenUp = self._rtProgressUp:DOSizeDelta(Vector2(upWidth, self._rtProgressUp.sizeDelta.y), durationTime)
    local btmWidth = upWidth + BattleConst.PopStarPointWidth
    local tweenBtm = self._rtProgressBtm:DOSizeDelta(Vector2(btmWidth, self._rtProgressBtm.sizeDelta.y), durationTime)
    local effPosX = addWidth + BattleConst.PopStarProgressStart
    local tweenEff = self._rtEffPointer:DOAnchorPos3DX(effPosX, durationTime)
    local markGOList = self._markList:GetAllSpawnList()
    for i = 1, #markGOList do
      markGOList[i]:RefreshPassState(self._curScore)
    end
    YIELD(TT, durationTime * 1000)
    while tweenUp:IsPlaying() or tweenBtm:IsPlaying() or tweenEff:IsPlaying() do
      YIELD(TT)
    end
    local strName = "uieff_UIWidgetPopStarProgressInfo_out"
    self._anim:Play(strName)
    if self._curScore >= self._maxNum then
      addWidth = addWidth + BattleConst.PopStarMaskEndAdd
      local endPercent = BattleConst.PopStarMaskEndAdd / BattleConst.PopStarProgressLength
      local endNum = endPercent * (self._maxNum - self._minNum)
      local endTime = endNum * BattleConst.PopStarOneScoreTime / 1000
      local upWidth = baseWidth + addWidth
      tweenUp = self._rtProgressUp:DOSizeDelta(Vector2(upWidth, self._rtProgressUp.sizeDelta.y), endTime)
      local btmWidth = upWidth + BattleConst.PopStarPointWidth
      tweenBtm = self._rtProgressBtm:DOSizeDelta(Vector2(btmWidth, self._rtProgressBtm.sizeDelta.y), endTime)
    end
    YIELD(TT, 200)
    while self._anim:IsPlaying(strName) or tweenUp:IsPlaying() or tweenBtm:IsPlaying() do
      YIELD(TT)
    end
  end
  if callback then
    callback()
  end
end

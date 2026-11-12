local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local CookieBoardCtrl = class("CookieBoardCtrl", BaseCtrl)
CookieBoardCtrl._mapNodeConfig = {
  goBlur = {},
  ScoreBoardRhythm = {
    sCtrlName = "Game.UI.Play_Cookie.CookieScoreBoardCtrl"
  },
  ScoreBoardOther = {
    sCtrlName = "Game.UI.Play_Cookie.CookieScoreBoardCtrl"
  },
  btnBackReal = {sComponentName = "NaviButton", callback = "OnBtn_Back"},
  btnPauseReal = {sComponentName = "NaviButton", callback = "OnBtn_Back"},
  txtTotalScore = {sComponentName = "TMP_Text"},
  txtTimerResume = {sNodeName = "txtTime", sComponentName = "TMP_Text"},
  txtAddTime = {sComponentName = "TMP_Text"},
  txtScoreCalculator = {sComponentName = "TMP_Text"},
  animScoreCalculator = {
    sNodeName = "imgScoreCalculator",
    sComponentName = "Animator"
  },
  imgScoreCalculatorFiller = {
    sComponentName = "RectTransform"
  },
  animScoreCalculatorFiller = {
    sNodeName = "imgScoreCalculatorFiller",
    sComponentName = "Animator"
  },
  imgFillerLight = {},
  btnConfirmScore = {
    sComponentName = "UIButton",
    callback = "OnBtn_ConfirmGameOver"
  },
  btnShortcutConfirmScore = {
    sComponentName = "NaviButton",
    callback = "OnBtn_ConfirmGameOver",
    sAction = "Confirm"
  },
  goResult = {},
  animResult = {sNodeName = "goResult", sComponentName = "Animator"},
  animCookiePlate = {
    sNodeName = "imgCookiePlate",
    sComponentName = "Animator"
  },
  goCookieGridList = {
    sComponentName = "RectTransform"
  },
  CookieGameBoard3x3 = {},
  CookieGameBoard4x4 = {},
  goNextBoard4 = {},
  goNextBoard3 = {},
  goNextTwoBoard4 = {},
  goNextTwoBoard3 = {},
  txtTimer = {sComponentName = "TMP_Text"},
  btnA = {
    sComponentName = "NaviButton",
    callback = "OnBtn_A",
    sAction = "CookieLeft"
  },
  btnB = {
    sComponentName = "NaviButton",
    callback = "OnBtn_B",
    sAction = "CookieDown"
  },
  btnC = {
    sComponentName = "NaviButton",
    callback = "OnBtn_C",
    sAction = "CookieRight"
  },
  btnD = {
    sComponentName = "NaviButton",
    callback = "OnBtn_D",
    sAction = "CookieUp"
  },
  btnStart = {
    sNodeName = "txtStart",
    sComponentName = "NaviButton",
    callback = "OnBtn_GameStart",
    sAction = "Confirm"
  },
  txtStartTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Cookie_Act_Start_Tip"
  },
  txtStartTMP = {
    sComponentName = "TMP_Text",
    sLanguageId = "Cookie_Act_GameStart"
  },
  txtRhythmStart = {
    sComponentName = "TMP_Text",
    sLanguageId = "Cookie_Act_Rhythm_Tip"
  },
  goHitEffect = {},
  animPerfectEff = {
    sNodeName = "imgPerfectEff",
    sComponentName = "Animator"
  },
  animExcellentEff = {
    sNodeName = "imgExcellentEff",
    sComponentName = "Animator"
  },
  animMissEff = {sNodeName = "imgMissEff", sComponentName = "Animator"},
  txtPerfectCombo = {sComponentName = "TMP_Text"},
  goBlurRes = {},
  imgScoreNMBg = {},
  imgScoreNormalBg = {},
  txtMissCount = {
    sComponentName = "TMP_Text",
    sLanguageId = "Cookie_Act_Miss_Count"
  },
  txtBoxCount = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Cookie_Act_Box_Count"
  },
  txtBoxCountNumNM = {sComponentName = "TMP_Text"},
  txtBoxCountNumNormal = {sComponentName = "TMP_Text"},
  txtCookieCount = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Cookie_Act_Cookie_Count"
  },
  txtCookieCountNumNM = {sComponentName = "TMP_Text"},
  txtCookieCountNumNormal = {sComponentName = "TMP_Text"},
  txtTips = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue"
  },
  txtClickPre = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Click_Pre"
  },
  txtClickSuf = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Click_Suf"
  },
  goRhythmDots = {},
  imgHeartMissEff = {},
  imgDotInner = {nCount = 4},
  imgLight = {nCount = 4},
  animLightBg = {
    nCount = 4,
    sNodeName = "imgLightBg",
    sComponentName = "Animator"
  },
  animRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  animHeart = {
    nCount = 5,
    sNodeName = "imgHeartHealth",
    sComponentName = "Animator"
  },
  animTime = {sNodeName = "imgTimeBg", sComponentName = "Animator"},
  goNoteIndicator = {},
  imgIndicatorPerfect = {},
  imgIndicatorGreat = {},
  imgIndicatorMiss = {}
}
CookieBoardCtrl._mapEventConfig = {
  CookieRequestCtrl = "OnEvent_CookieRequestCtrl"
}
local nPerfectTiming = 1.067
local sDefaultStartAnim = "CookieBoard_in"
local nPreMusicTime = 4
local nFillerMinSize = 25
local nFillerMaxSize = 527.5
local tbResultAnim = {
  [GameEnum.CookiePackModel.CookiePackNormalModel] = "CookieBoard_OtherResult",
  [GameEnum.CookiePackModel.CookiePackPathsModel] = "CookieBoard_OtherResult",
  [GameEnum.CookiePackModel.CookiePackRhythmlModel] = "CookieBoard_RhythmResult",
  [GameEnum.CookiePackModel.CookiePackComplexModel] = "CookieBoard_RhythmResult"
}

function CookieBoardCtrl:GameInit()
  self._mapNode.txtTimer.gameObject:SetActive(true)
  self.nTimeCount = 0.0
  self.nFixedTimer = 0.0
  self.nBeatsTimer = 0.0
  self.nDisposalBeatTimer = 0.0
  self.nNextHaloAnim = 0.0
  self.nWaitingNextBeat = 0
  self.nCurrGridIndex = 1
  self.nCurrBoardIndex = 1
  self.nCurrGird = {1, 1}
  self.nScore = 0
  self.nCompBoxCount = 0
  self.nCompCookieCount = 0
  self.bFullCombo = true
  self.bAllPerfect = true
  self.bPressed = false
  self.nCurHealth = 0
  if self.nPackModel == GameEnum.CookiePackModel.CookiePackPathsModel or self.nPackModel == GameEnum.CookiePackModel.CookiePackComplexModel then
    self.nPathGroupId = self.tbFloor[self.nCurrLevelConfigIdx].PackagePathsGroupId
  end
  if self.nPackModel == GameEnum.CookiePackModel.CookiePackRhythmlModel or self.nPackModel == GameEnum.CookiePackModel.CookiePackComplexModel then
    self.nHitThreshold = self.tbFloor[self.nCurrLevelConfigIdx].PreRange / 100
    self.nBeatInterval = 60 / self.tbFloor[self.nCurrLevelConfigIdx].RhythmlTime
  end
  self:GetScoreFactors()
  self:RefreshCountDownTimer()
  self.bPaused = false
  self.nPerfectCount = 0
  self.nPerfectCombo = 0
  self.nPerfectTemp = 0
  self.nCriticalPerfectCount = 0
  self.nGoodCount = 0
  self.nMissCount = 0
  self.bCurrNoteHit = false
  self.bMissSwitch = false
  self.bShowBeatLight = false
  self.bNewBeat = true
  self.nBoardSize = self.tbFloor[self.nCurrLevelConfigIdx].Size
  self:RoundStart()
  self:RefreshNextBoards()
end

function CookieBoardCtrl:UpdateActiveButtons()
  local nPreCookieType = self.tbActiveCookieTypes
  local tbButtonsConfig = self.tbFloor[self.nCurrLevelConfigIdx].CookieTypeNum
  self.tbActiveCookieTypes = {}
  if tbButtonsConfig == nil or #tbButtonsConfig == 0 then
    self.tbActiveCookieTypes = {
      1,
      2,
      3,
      4
    }
  else
    for _, nCookieType in ipairs(tbButtonsConfig) do
      table.insert(self.tbActiveCookieTypes, nCookieType)
    end
  end
  local bSwitchPlate = false
  if #nPreCookieType ~= 0 and #nPreCookieType ~= #self.tbActiveCookieTypes then
    bSwitchPlate = true
  else
    for k, v in pairs(nPreCookieType) do
      if v ~= self.tbActiveCookieTypes[k] then
        bSwitchPlate = true
        break
      end
    end
  end
  if bSwitchPlate then
    CS.WwiseAudioManager.Instance:PlaySound("mode_cookie2_drawer")
    self._mapNode.animCookiePlate:Play("CookieBoard_CookiePlate_out", 0, 0)
    local nAnimLength = NovaAPI.GetAnimClipLength(self._mapNode.animCookiePlate, {
      "CookieBoard_CookiePlate_out"
    })
    self:AddTimer(1, nAnimLength, function()
      self._mapNode.animCookiePlate:Play("CookieBoard_CookiePlate_in", 0, 0)
    end, true, true, true)
  end
end

function CookieBoardCtrl:ApplyButtonActivation()
  local function IsButtonActive(nCookieType)
    for _, nActiveCookieType in ipairs(self.tbActiveCookieTypes) do
      if nActiveCookieType == nCookieType then
        return true
      end
    end
    return false
  end
  
  self._mapNode.btnA.gameObject:SetActive(IsButtonActive(1))
  self._mapNode.btnB.gameObject:SetActive(IsButtonActive(2))
  self._mapNode.btnC.gameObject:SetActive(IsButtonActive(3))
  self._mapNode.btnD.gameObject:SetActive(IsButtonActive(4))
end

function CookieBoardCtrl:RoundStart()
  if nil ~= self.CookieGameBoard then
    self.CookieGameBoard:SetActive(false)
  end
  self:GetBoardData()
  if nil ~= self.CookieGameBoard then
    self.CookieGameBoard:SetActive(true)
    self.goCookieGridList = self.CookieGameBoard.transform:Find("goCookieGridList")
    if self.goCookieGridList ~= nil then
      self.goCookieGridList.gameObject:SetActive(true)
    end
    self.trBoardersVertical = self.CookieGameBoard.transform:Find("goBoardersVertical").transform
    if self.trBoardersVertical ~= nil then
      self.trBoardersVertical.gameObject:SetActive(true)
    end
    self.trBoardersHorizontal = self.CookieGameBoard.transform:Find("goBoardersHorizontal").transform
    if self.trBoardersHorizontal ~= nil then
      self.trBoardersHorizontal.gameObject:SetActive(true)
    end
  end
  for i = 1, #self._mapNode.imgDotInner do
    local imgDot = self._mapNode.imgDotInner[i]
    if imgDot ~= nil then
      imgDot.gameObject:SetActive(false)
    end
  end
  for i = 1, #self._mapNode.imgLight do
    local imgDot = self._mapNode.imgLight[i]
    if imgDot ~= nil then
      imgDot.gameObject:SetActive(false)
    end
  end
  self:RefreshBoard()
end

function CookieBoardCtrl:GetBoardData()
  local nGoalBoxNum = 0
  if self.nCurrLevelConfigIdx + 1 <= #self.tbFloor then
    nGoalBoxNum = self.tbFloor[self.nCurrLevelConfigIdx + 1].PackageNum
  else
    nGoalBoxNum = self.nCurrBoardIndex
  end
  if self.nCurrLevelConfigIdx < #self.tbFloor and nGoalBoxNum < self.nCurrBoardIndex then
    self.nCurrLevelConfigIdx = self.nCurrLevelConfigIdx + 1
    self.nBoardSize = self.tbFloor[self.nCurrLevelConfigIdx].Size
    if self.nPackModel == GameEnum.CookiePackModel.CookiePackPathsModel or self.nPackModel == GameEnum.CookiePackModel.CookiePackComplexModel then
      self.nPathGroupId = self.tbFloor[self.nCurrLevelConfigIdx].PackagePathsGroupId
    end
    if self.nPackModel == GameEnum.CookiePackModel.CookiePackRhythmlModel or self.nPackModel == GameEnum.CookiePackModel.CookiePackComplexModel then
      self.nHitThreshold = self.tbFloor[self.nCurrLevelConfigIdx].PreRange / 100
      local nPrevBeat = self.nBeatInterval
      self.nBeatInterval = 60 / self.tbFloor[self.nCurrLevelConfigIdx].RhythmlTime
      if nPrevBeat ~= self.nBeatInterval then
        self.bShowBeatLight = true
      end
    end
    self:UpdateActiveButtons()
    self:ApplyButtonActivation()
  end
  self.tbGrid, self.tbPath = self:GenerateBoard(not self.bPipelineMode)
  self.CookieGameBoard = self.nBoardSize == 3 and self._mapNode.CookieGameBoard3x3 or self._mapNode.CookieGameBoard4x4
end

function CookieBoardCtrl:RefreshBoard()
  self:ResetEff()
  self:UnbindGridCtrl()
  if self.trBoardersVertical ~= nil then
    for i = 0, self.trBoardersVertical.childCount - 1 do
      local child = self.trBoardersVertical:GetChild(i)
      if child ~= nil then
        child.gameObject:SetActive(false)
      end
    end
  end
  if self.trBoardersHorizontal ~= nil then
    for i = 0, self.trBoardersHorizontal.childCount - 1 do
      local child = self.trBoardersHorizontal:GetChild(i)
      if child ~= nil then
        child.gameObject:SetActive(false)
      end
    end
  end
  local nGridNum = self.nBoardSize * self.nBoardSize
  for i = 1, nGridNum do
    local m = self.tbPath[i][1]
    local n = self.tbPath[i][2]
    local nTbIndex = (m - 1) * self.nBoardSize + n
    local goGrid = self.goCookieGridList:GetChild(nTbIndex - 1)
    goGrid.gameObject:SetActive(true)
    local currCtrl = self:BindCtrlByNode(goGrid, "Game.UI.Play_Cookie.CookieGridCtrl")
    self.tbGridCtrl[nTbIndex] = currCtrl
    self.tbGridCtrl[nTbIndex]:Init(self.tbGrid[m][n], self.nHitThreshold, self.nPerfectThreshold)
    if self.bPipelineMode then
      local tbBorders = {
        true,
        true,
        true,
        true
      }
      local nNext = i + 1
      if nGridNum >= nNext then
        local j = self.tbPath[nNext][1]
        local k = self.tbPath[nNext][2]
        if j == m + 1 and k == n then
          tbBorders[2] = false
        end
        if j == m - 1 and k == n then
          tbBorders[1] = false
        end
        if k == n + 1 and j == m then
          tbBorders[4] = false
        end
        if k == n - 1 and j == m then
          tbBorders[3] = false
        end
      end
      local nPrev = i - 1
      if 1 <= nPrev then
        local j = self.tbPath[nPrev][1]
        local k = self.tbPath[nPrev][2]
        if j + 1 == m and k == n then
          tbBorders[1] = false
        end
        if j - 1 == m and k == n then
          tbBorders[2] = false
        end
        if k + 1 == n and j == m then
          tbBorders[3] = false
        end
        if k - 1 == n and j == m then
          tbBorders[4] = false
        end
      end
      local tbBoarderGo = self:GetGridBorders(m, n)
      for idx, bActive in ipairs(tbBorders) do
        local goBoarder = tbBoarderGo[idx]
        if goBoarder ~= nil then
          goBoarder.gameObject:SetActive(bActive)
        end
      end
    end
  end
  self.nextCtrl = self.tbGridCtrl[1]
  self.currCtrl = self.tbGridCtrl[1]
end

function CookieBoardCtrl:GetGridBorders(m, n)
  local up, down, left, right
  local size = self.nBoardSize or 0
  if size <= 0 or self.trBoardersHorizontal == nil or self.trBoardersVertical == nil then
    return {
      up,
      down,
      left,
      right
    }
  end
  
  local function getHorizontal(rowIndex, colIndex)
    if rowIndex < 1 or rowIndex > size then
      return nil
    end
    if colIndex < 1 or colIndex > size then
      return nil
    end
    local boarder = self.trBoardersHorizontal:Find("boarder" .. rowIndex .. "_" .. colIndex)
    return boarder
  end
  
  local function getVertical(rowIndex, colIndex)
    if colIndex < 1 or colIndex > size then
      return nil
    end
    if rowIndex < 1 or rowIndex > size then
      return nil
    end
    local boarder = self.trBoardersVertical:Find("boarder" .. rowIndex .. "_" .. colIndex)
    return boarder
  end
  
  up = getVertical(m - 1, n)
  down = getVertical(m, n)
  left = getHorizontal(m, n - 1)
  right = getHorizontal(m, n)
  return {
    up,
    down,
    left,
    right
  }
end

function CookieBoardCtrl:GetScoreFactors()
  self.nCriticalPerfectFactorA = 0
  self.nCriticalPerfectFactorB = 0.0
  self.nPerfectFactorA = 0
  self.nPerfectFactorB = 0.0
  self.nGoodFactorA = 0
  self.nGoodFactorB = 0.0
  local mapCPF = ConfigTable.GetData("CookieRhythmlResult", GameEnum.CookieRhythmlResult.Excellent)
  if mapCPF ~= nil then
    if mapCPF.AddScoreType == 1 then
      self.nCriticalPerfectFactorA = mapCPF.AddScore
    else
      self.nCriticalPerfectFactorB = mapCPF.AddScore / 100
    end
  end
  local mapPF = ConfigTable.GetData("CookieRhythmlResult", GameEnum.CookieRhythmlResult.Perfect)
  if mapPF ~= nil then
    if mapPF.AddScoreType == 1 then
      self.nPerfectFactorA = mapPF.AddScore
    else
      self.nPerfectFactorB = mapPF.AddScore / 100
    end
  end
  local mapGF = ConfigTable.GetData("CookieRhythmlResult", GameEnum.CookieRhythmlResult.Good)
  if mapGF ~= nil then
    if mapGF.AddScoreType == 1 then
      self.nGoodFactorA = mapGF.AddScore
    else
      self.nGoodFactorB = mapGF.AddScore / 100
    end
  end
end

function CookieBoardCtrl:RefreshNextBoards()
  local nGoalBoxNum = 0
  if self.nCurrLevelConfigIdx + 1 <= #self.tbFloor then
    nGoalBoxNum = self.tbFloor[self.nCurrLevelConfigIdx + 1].PackageNum
  else
    nGoalBoxNum = self.nCurrBoardIndex
  end
  self._mapNode.goNextBoard4:SetActive(false)
  self._mapNode.goNextBoard3:SetActive(false)
  self._mapNode.goNextTwoBoard4:SetActive(false)
  self._mapNode.goNextTwoBoard3:SetActive(false)
  local nNextBoardSize = 3
  local nNextTwoBoardSize = 3
  local nLevelConfigIdx = self.nCurrLevelConfigIdx < #self.tbFloor and self.nCurrLevelConfigIdx + 1 or self.nCurrLevelConfigIdx
  if nGoalBoxNum <= self.nCurrBoardIndex then
    nNextBoardSize = self.tbFloor[nLevelConfigIdx].Size
    nNextTwoBoardSize = self.tbFloor[nLevelConfigIdx].Size
  elseif nGoalBoxNum <= self.nCurrBoardIndex + 1 then
    nNextTwoBoardSize = self.tbFloor[nLevelConfigIdx].Size
  end
  if nNextBoardSize == 3 then
    self._mapNode.goNextBoard3:SetActive(true)
  else
    self._mapNode.goNextBoard4:SetActive(true)
  end
  if nNextTwoBoardSize == 3 then
    self._mapNode.goNextTwoBoard3:SetActive(true)
  else
    self._mapNode.goNextTwoBoard4:SetActive(true)
  end
end

function CookieBoardCtrl:SelectionForward()
  self.nCurrGridIndex = self.nCurrGridIndex + 1
  if self.nCurrGridIndex > #self.tbPath then
    self.nCompBoxCount = self.nCompBoxCount + 1
    self:CalculateScore(false)
    self.nCurrGridIndex = 1
    self.nCurrGird = {1, 1}
    self.nextCtrl = nil
    if self.bRhythmMode then
      self.nWaitingNextBeat = 2
      self:PauseGameCtrl()
    else
      self:NextBox()
    end
    return
  end
  self.nCurrGird = self.tbPath[self.nCurrGridIndex]
  local nTbIndex = (self.nCurrGird[1] - 1) * self.nBoardSize + self.nCurrGird[2]
  local nextCtrl = self.tbGridCtrl[nTbIndex]
  if nil ~= nextCtrl then
    nextCtrl:SetSelect(true)
    self.nextCtrl = nextCtrl
  end
end

function CookieBoardCtrl:NextBox()
  self.nCurrBoardIndex = self.nCurrBoardIndex + 1
  NovaAPI.SetTMPText(self._mapNode.txtBoxCountNumNM, self.nCompBoxCount)
  NovaAPI.SetTMPText(self._mapNode.txtBoxCountNumNormal, self.nCompBoxCount)
  NovaAPI.CtrlDotweenAnimation(self._mapNode.txtBoxCountNumNM.gameObject, 2)
  NovaAPI.CtrlDotweenAnimation(self._mapNode.txtBoxCountNumNM.gameObject, 1)
  NovaAPI.CtrlDotweenAnimation(self._mapNode.txtBoxCountNumNormal.gameObject, 2)
  NovaAPI.CtrlDotweenAnimation(self._mapNode.txtBoxCountNumNormal.gameObject, 1)
  self:SetEnvironmentBeat(false)
  self:DisableGrids()
  self:PauseGameCtrl()
  self.bBlockInput = true
  EventManager.Hit(EventId.BlockInput, true)
  local nAnimLength = NovaAPI.GetAnimClipLength(self._mapNode.animRoot, {
    "CookieBoard_next"
  })
  self:AddTimer(1, nAnimLength, function()
    self:RoundStart()
    self:RefreshNextBoards()
    self._mapNode.animRoot:Play("Empty", 0, 0)
  end, true, true, true)
  if self.bRhythmMode then
    local nBeat = self.nBeatInterval or 0
    if 0 < nBeat then
      nAnimLength = math.ceil(nAnimLength / nBeat) * nBeat
    end
  end
  CS.WwiseAudioManager.Instance:PlaySound("mode_cookie1_move")
  self._mapNode.animRoot:Play("CookieBoard_next", 0, 0)
  if self.timerNextBox ~= nil then
    self.timerNextBox:Cancel()
    self.timerNextBox = nil
  end
  self.timerNextBox = self:AddTimer(1, nAnimLength, function()
    local function nextboxcb()
      self.nFixedTimer = 0
      
      self.nBeatsTimer = 0
      self.nPrevTime = CS.UnityEngine.Time.time
      self.bMissSwitch = false
      self.bCurrNoteHit = false
      self.bCurrNoteClicked = false
      self.bPressed = false
      self.bPaused = false
      self.bNewBeat = true
      self.bBlockInput = false
      if self.timerBeat ~= nil then
        self.timerBeat:Cancel()
      end
      if self.bRhythmMode and self.nBeatInterval ~= nil then
        self.timerBeat = self:AddTimer(0, self.nBeatInterval, self.OnEvent_Beat, true, true, true)
      end
      if self.timerRound ~= nil then
        self.timerRound:Cancel()
      end
      self.timerRound = self:AddTimer(0, 0.034, self.OnEvent_Time, true, true, true)
      local sEvent = self:GetSwitchBoxSoundEvent()
      CS.WwiseAudioManager.Instance:PostEvent(sEvent)
      self:SetEnvironmentBeat(true)
      self.tbGridCtrl[1]:SetSelect(true)
      EventManager.Hit(EventId.BlockInput, false)
    end
    
    if self.bRhythmMode and self.bShowBeatLight then
      self.bShowBeatLight = false
      self:PlayRhythmStartTip(nextboxcb)
    else
      nextboxcb()
    end
    if self.bPipelineMode == true then
      self:PlayPathEffect()
    end
  end, true, true, true)
end

function CookieBoardCtrl:GetSwitchBoxSoundEvent()
  local nBPM = self.tbFloor[self.nCurrLevelConfigIdx].RhythmlTime or 0
  if nBPM <= 0 then
    return "mode_freeTempo_setState"
  end
  local sEvent = "mode_" .. nBPM .. "Tempo_setState"
  return sEvent
end

function CookieBoardCtrl:GetRhythmSwitchSoundEvent()
  if self.bRhythmMode == false then
    return
  end
  local nBPM = self.tbFloor[self.nCurrLevelConfigIdx].RhythmlTime
  local sEvent = "mode_cookie_1_pre_" .. tostring(nBPM)
  return sEvent
end

local tbCookiePutinSound = {
  [3] = "mode_cookie1_putin",
  [4] = "mode_cookie1_putin",
  [2] = "mode_cookie1_putin",
  [1] = "mode_cookie1_putin"
}

function CookieBoardCtrl:FillCurrentGrid(nInputCookie)
  local nTbIndex = (self.nCurrGird[1] - 1) * self.nBoardSize + self.nCurrGird[2]
  local nCurrShape = self.tbGridCtrl[nTbIndex]:GetGirdShape()
  self.bCurrNoteClicked = true
  if nCurrShape == nInputCookie then
    CS.WwiseAudioManager.Instance:PlaySound(tbCookiePutinSound[nInputCookie])
    if self.bRhythmMode then
      self:NoteCheck()
    else
      self:FillSuccess()
    end
  else
    self:FillFail(self.tbGridCtrl[nTbIndex])
  end
  self.bPressed = false
end

function CookieBoardCtrl:FillSuccess()
  self.nCompCookieCount = self.nCompCookieCount + 1
  self:CalculateScore(true)
  NovaAPI.SetTMPText(self._mapNode.txtCookieCountNumNM, self.nCompCookieCount)
  NovaAPI.SetTMPText(self._mapNode.txtCookieCountNumNormal, self.nCompCookieCount)
  NovaAPI.CtrlDotweenAnimation(self._mapNode.txtCookieCountNumNM.gameObject, 2)
  NovaAPI.CtrlDotweenAnimation(self._mapNode.txtCookieCountNumNM.gameObject, 1)
  NovaAPI.CtrlDotweenAnimation(self._mapNode.txtCookieCountNumNormal.gameObject, 2)
  NovaAPI.CtrlDotweenAnimation(self._mapNode.txtCookieCountNumNormal.gameObject, 1)
  self.nCurrGird = self.tbPath[self.nCurrGridIndex]
  local nTbIndex = (self.nCurrGird[1] - 1) * self.nBoardSize + self.nCurrGird[2]
  self.currCtrl = self.tbGridCtrl[nTbIndex]
  if nil ~= self.currCtrl then
    self.currCtrl:SetSelect(false)
    self.currCtrl:SetFilled()
  end
  if self.bRhythmMode then
    self.bWaitingNextBeatNote = true
    if self.nCurrGridIndex + 1 > #self.tbPath then
      self.bBlockInput = true
      EventManager.Hit(EventId.BlockInput, true)
    end
  else
    self:SelectionForward()
  end
end

function CookieBoardCtrl:FillFail(objCtrl)
  local nBlockTime = ConfigTable.GetConfigNumber("Cookie_ErrorTime") or 0.5
  if objCtrl ~= nil then
    objCtrl:PlayWrongAnim(nBlockTime, self.bRhythmMode and self.bPipelineMode)
  end
  CS.WwiseAudioManager.Instance:PlaySound("mode_cookie1_error")
  if self.bRhythmMode then
    self.nMissCount = self.nMissCount + 1
    self.nHitType = GameEnum.CookieRhythmlResult.Miss
    self.nPerfectTemp = 0
    self.nPerfectCombo = 0
    self.bFullCombo = false
    self.bAllPerfect = false
    if self.bPipelineMode then
      self:LoseHeart()
    end
  else
    EventManager.Hit(EventId.TemporaryBlockInput, nBlockTime)
  end
  self:CalculateScore(false)
end

function CookieBoardCtrl:LoseHeart()
  self.nCurHealth = self.nCurHealth + 1
  self._mapNode.animHeart[self.nCurHealth]:Play("CookieBoard_Heart_Lose")
  if self.nCurHealth >= 5 then
    for k, v in pairs(self._mapNode.animHeart) do
      local trChild = v.transform:Find("imgHeartFill1")
      if trChild ~= nil then
        trChild.gameObject:SetActive(false)
      end
    end
    self:PauseGameCtrl()
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      self:LevelEnd()
    end
    
    cs_coroutine.start(wait)
    return
  end
end

function CookieBoardCtrl:PauseGameCtrl()
  self.bPaused = true
end

function CookieBoardCtrl:ResumeGameCtrl()
  self.bBlockInput = true
  EventManager.Hit(EventId.BlockInput, true)
  self._mapNode.animRoot:Play("CookieBoard_restart", 0, 0)
  NovaAPI.SetTMPText(self._mapNode.txtTimerResume, self.nReturnCd)
  CS.WwiseAudioManager.Instance:PlaySound("mode_cookie1_countdown")
  self.nTimeResume = 0
  self.timerPause = self:AddTimer(0, 1, self.OnEvent_PauseResume, true, true, true)
end

function CookieBoardCtrl:GenerateBoard(bFixedPath)
  if not bFixedPath then
    self.tbCurrPath = {}
    if self.nOverridePathId == 0 then
      local tbRandom = {}
      for k, v in pairs(self.tbPathGroup) do
        if v.PathGroupId == self.nPathGroupId then
          table.insert(tbRandom, v.Id)
        end
      end
      local nRandomIdx = math.random(1, #tbRandom)
      local nRetryCount = 0
      while tbRandom[nRandomIdx] == self.nLastPath and nRetryCount < 10 do
        nRetryCount = nRetryCount + 1
        nRandomIdx = math.random(1, #tbRandom)
      end
      self.nLastPath = tbRandom[nRandomIdx]
      self.tbCurrPath = decodeJson(self.tbPathGroup[tbRandom[nRandomIdx]].PackagePathsResource)
    else
      local bFind = false
      for k, v in pairs(self.tbPathGroup) do
        if v.Id == self.nOverridePathId then
          bFind = true
          self.tbCurrPath = decodeJson(v.PackagePathsResource)
          break
        end
      end
      if not bFind then
        self.tbCurrPath = decodeJson(self.tbPathGroup[1].PackagePathsResource)
        self.nOverridePathId = 0
      end
      self.nBoardSize = math.floor(math.sqrt(#self.tbCurrPath))
    end
  else
    self.tbCurrPath = {}
    for i = 1, self.nBoardSize do
      for j = 1, self.nBoardSize do
        table.insert(self.tbCurrPath, {i, j})
      end
    end
  end
  if nil == self.tbCurrPath then
    return
  end
  local tbGrid = {}
  for i = 1, self.nBoardSize do
    tbGrid[i] = {}
    for j = 1, self.nBoardSize do
      tbGrid[i][j] = 0
    end
  end
  local tbPrev = {0, 0}
  for k, v in pairs(self.tbCurrPath) do
    local nActiveCookieCount = #self.tbActiveCookieTypes
    local nRandomIndex = math.random(1, nActiveCookieCount)
    local nCur = self.tbActiveCookieTypes[nRandomIndex]
    local nRetryCount = 0
    while nCur == tbPrev[1] and tbPrev[1] == tbPrev[2] and 1 < nActiveCookieCount and nRetryCount < 10 do
      nRetryCount = nRetryCount + 1
      nRandomIndex = math.random(1, nActiveCookieCount)
      nCur = self.tbActiveCookieTypes[nRandomIndex]
    end
    tbGrid[v[1]][v[2]] = nCur
    tbPrev[1] = tbPrev[2]
    tbPrev[2] = nCur
  end
  return tbGrid, self.tbCurrPath
end

function CookieBoardCtrl:ResetEff()
  self._mapNode.animPerfectEff.transform:SetParent(self._mapNode.goHitEffect.transform, false)
  self._mapNode.animExcellentEff.transform:SetParent(self._mapNode.goHitEffect.transform, false)
  self._mapNode.animMissEff.transform:SetParent(self._mapNode.goHitEffect.transform, false)
  self._mapNode.animPerfectEff.gameObject:SetActive(false)
  self._mapNode.animExcellentEff.gameObject:SetActive(false)
  self._mapNode.animMissEff.gameObject:SetActive(false)
end

function CookieBoardCtrl:SetButtonsActive(bActive)
  self._mapNode.btnA.interactable = bActive
  self._mapNode.btnB.interactable = bActive
  self._mapNode.btnC.interactable = bActive
  self._mapNode.btnD.interactable = bActive
end

function CookieBoardCtrl:CalculateScore(bPlayAnim)
  local nScore = (self.nCompBoxCount * 10 + self.nCompCookieCount + (self.nPerfectCount - self.nMissCount) * 3 + (self.nCriticalPerfectCount * self.nCriticalPerfectFactorA + self.nPerfectCount * self.nPerfectFactorA + self.nGoodCount * self.nGoodFactorA)) * (1 + (self.nCriticalPerfectCount * self.nCriticalPerfectFactorB + self.nPerfectCount * self.nPerfectFactorB + self.nGoodCount * self.nGoodFactorB))
  if nScore < 0 then
    nScore = 0
  end
  self.nScore = math.ceil(nScore)
  if bPlayAnim then
    if self.nHitType == GameEnum.CookieRhythmlResult.Excellent then
      self._mapNode.animScoreCalculator:Play("CookieBoard_Score_CriticalPerfect", 0, 0)
    else
      self._mapNode.animScoreCalculator:Play("CookieBoard_ScoreCalculator_up", 0, 0)
    end
  end
  self.nHitType = GameEnum.CookieRhythmlResult.Miss
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    NovaAPI.SetTMPText(self._mapNode.txtScoreCalculator, self.nScore)
    local nScorePercentage = self.nScore / (self.nPassScore > 0 and self.nPassScore or 1)
    if 1 < nScorePercentage then
      nScorePercentage = 1
      if bPlayAnim then
        self._mapNode.animScoreCalculatorFiller:Play("CookieBoard_Bar_Full", 0, 0)
      end
    end
    local nFillerSize = nScorePercentage * nFillerMaxSize
    if nFillerSize < nFillerMinSize and 0 < nFillerSize then
      nFillerSize = nFillerMinSize
    end
    self._mapNode.imgFillerLight:SetActive(0 < nFillerSize)
    self._mapNode.imgScoreCalculatorFiller.sizeDelta = Vector2(nFillerSize, self._mapNode.imgScoreCalculatorFiller.sizeDelta.y)
  end
  
  cs_coroutine.start(wait)
end

function CookieBoardCtrl:UnbindGridCtrl()
  for k, objCtrl in pairs(self.tbGridCtrl) do
    if objCtrl ~= nil then
      self:UnbindCtrlByNode(objCtrl)
      self.tbGridCtrl[k] = nil
    end
  end
end

function CookieBoardCtrl:DisableGrids()
  for i = 1, self.goCookieGridList.childCount do
    local goGrid = self.goCookieGridList:GetChild(i - 1)
    if goGrid ~= nil then
      goGrid.gameObject:SetActive(false)
    end
  end
end

function CookieBoardCtrl:GetLevelConfig(sTableName)
  local tbConfig = {}
  
  local function fc(tbData)
    if self.nLevelId == tbData.PlayGroupId then
      table.insert(tbConfig, tbData)
    end
  end
  
  ForEachTableLine(ConfigTable.Get(sTableName), fc)
  return tbConfig
end

function CookieBoardCtrl:GameStart()
  if self.bRhythmMode then
    self:PlayRhythmStartTip(function()
      self:GameTrigger()
    end)
  else
    self:GameTrigger()
  end
  if self.bPipelineMode == true then
    self:PlayPathEffect()
  end
end

function CookieBoardCtrl:GameTrigger()
  if self.timerRound ~= nil then
    self.timerRound:Cancel()
  end
  if self.timerBeat ~= nil then
    self.timerBeat:Cancel()
  end
  self:SetEnvironmentBeat(true)
  self.nPrevTime = CS.UnityEngine.Time.time
  self.timerRound = self:AddTimer(0, 0.034, self.OnEvent_Time, true, true, true)
  if self.bRhythmMode and self.nBeatInterval ~= nil then
    self.timerBeat = self:AddTimer(0, self.nBeatInterval, self.OnEvent_Beat, true, true, true)
  end
  local sEvent = self:GetSwitchBoxSoundEvent()
  CS.WwiseAudioManager.Instance:PostEvent(sEvent)
  self.bGameStarted = true
  self._mapNode.btnBackReal.gameObject:SetActive(not self.bGameStarted)
  self._mapNode.btnPauseReal.gameObject:SetActive(self.bGameStarted)
  self.tbGridCtrl[1]:SetSelect(true)
  self:SetButtonsActive(true)
end

function CookieBoardCtrl:PlayRhythmStartTip(callback)
  self._mapNode.goRhythmDots:SetActive(true)
  local nAnimLength = NovaAPI.GetAnimClipLength(self._mapNode.animRoot, {
    "CookieBoard_in_Rhythm"
  })
  self._mapNode.animRoot:Play("CookieBoard_in_Rhythm", 0, 0)
  self:AddTimer(1, nAnimLength, function()
    self:StartBeatLightLoop(self.nBeatInterval, function()
      if callback ~= nil then
        callback()
      end
    end)
  end, true, true, true)
end

function CookieBoardCtrl:SetEnvironmentBeat(bPlay)
  if bPlay == false then
    self.animBtnA:SetFloat("PlaySpeed", 0)
    self.animBtnB:SetFloat("PlaySpeed", 0)
    self.animBtnC:SetFloat("PlaySpeed", 0)
    self.animBtnD:SetFloat("PlaySpeed", 0)
    self._mapNode.animTime:SetFloat("PlaySpeed", 0)
    return
  end
  local nAnimationLength = NovaAPI.GetAnimClipLength(self.animBtnA, {
    "CookieBoard_Platebtn_Loop"
  })
  local nPlaySpeed = nAnimationLength / (self.nBeatInterval or 1)
  self.animBtnA:SetFloat("PlaySpeed", nPlaySpeed)
  self.animBtnB:SetFloat("PlaySpeed", nPlaySpeed)
  self.animBtnC:SetFloat("PlaySpeed", nPlaySpeed)
  self.animBtnD:SetFloat("PlaySpeed", nPlaySpeed)
  self._mapNode.animTime:SetFloat("PlaySpeed", nPlaySpeed)
end

function CookieBoardCtrl:NoteCheck()
  if self.nFixedTimer < self.nBeatInterval - self.nHitThreshold then
    return
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  local nNextRes = self.timerBeat:GetRemainInterval()
  local nRes = self.nBeatInterval - nNextRes
  if math.abs(nNextRes) < math.abs(nRes) then
    nRes = nNextRes
  end
  if nRes > self.nHitThreshold or nRes < -self.nHitThreshold then
    return
  end
  self.bCurrNoteHit = true
  self.nHitType = GameEnum.CookieRhythmlResult.Miss
  if nRes < self.nPerfectThreshold and nRes > -self.nPerfectThreshold then
    self:NotePerfect()
  elseif nRes < self.nGoodThreshold and nRes > -self.nGoodThreshold then
    self:NoteGood()
  else
    self.bCurrNoteHit = false
    self:NoteMiss()
    self:PlayHitEffect(GameEnum.CookieRhythmlResult.Miss)
    CS.WwiseAudioManager.Instance:PlaySound("mode_cookie1_wrong")
    return
  end
  CS.WwiseAudioManager.Instance:PlaySound("mode_cookie1_test")
  self:PlayHitEffect(self.nHitType)
  self:FillSuccess()
end

function CookieBoardCtrl:NotePerfect()
  self.nHitType = GameEnum.CookieRhythmlResult.Perfect
  self.nPerfectTemp = self.nPerfectTemp + 1
  self.nPerfectCount = self.nPerfectCount + 1
  self.nPerfectCombo = self.nPerfectCombo + 1
  self.nTimeCount = self.nTimeCount - 0.3
  NovaAPI.SetTMPText(self._mapNode.txtAddTime, "+0.3s")
  self._mapNode.animTime:Play("CookieBoard_AddTime_in", 0, 0)
  self:RefreshCountDownTimer()
  if self.nPerfectTemp >= 3 then
    self.nCriticalPerfectCount = self.nCriticalPerfectCount + 1
    self.nHitType = GameEnum.CookieRhythmlResult.Excellent
    if self.nPerfectTemp == 3 then
      CS.WwiseAudioManager.Instance:PlaySound("mode_cookie1_perfect_ex_first")
    elseif self.nPerfectTemp > 3 then
      CS.WwiseAudioManager.Instance:PlaySound("mode_cookie1_perfect_ex")
    end
  else
    CS.WwiseAudioManager.Instance:PlaySound("mode_cookie1_perfect")
  end
end

function CookieBoardCtrl:NoteGood()
  self.nHitType = GameEnum.CookieRhythmlResult.Good
  self.nGoodCount = self.nGoodCount + 1
  self.nPerfectTemp = 0
  self.nPerfectCombo = 0
  self.bAllPerfect = false
  CS.WwiseAudioManager.Instance:PlaySound("mode_cookie1_nice")
end

function CookieBoardCtrl:NoteMiss()
  self.nMissCount = self.nMissCount + 1
  self.nPerfectTemp = 0
  self.nPerfectCombo = 0
  self:CalculateScore(false)
  self.bFullCombo = false
  self.bAllPerfect = false
  self.nHitType = GameEnum.CookieRhythmlResult.Miss
  if self.bPipelineMode and self.bRhythmMode then
    self:LoseHeart()
  end
end

function CookieBoardCtrl:PlayPathEffect()
  local nCurIndex = 1
  local nEffInterval = 0.1
  if self.bRhythmMode then
    local nGridCount = self.nBoardSize * self.nBoardSize
    nEffInterval = self.nBeatInterval / 2.5 / nGridCount
  end
  self.gridItemAnimTimer = self:AddTimer(0, nEffInterval, function()
    nCurIndex = nCurIndex + 1
    if nCurIndex > #self.tbGridCtrl and self.gridItemAnimTimer ~= nil then
      self.gridItemAnimTimer:Cancel()
      self.gridItemAnimTimer = nil
      EventManager.Hit(EventId.BlockInput, false)
      return
    end
    local currGrid = self.tbPath[nCurIndex]
    if currGrid == nil then
      return
    end
    local m = self.tbPath[nCurIndex][1]
    local n = self.tbPath[nCurIndex][2]
    local nTbIndex = (m - 1) * self.nBoardSize + n
    local currCtrl = self.tbGridCtrl[nTbIndex]
    if currCtrl ~= nil then
      currCtrl:PlayLightAnim()
    end
  end, true, true, true)
end

function CookieBoardCtrl:PlayHitEffect(nHitType)
  self:ResetEff()
  local objNextCtrl = self.nextCtrl
  if objNextCtrl == nil or objNextCtrl.gameObject == nil then
    return
  end
  local nAnimLength = 0.75
  if nHitType == GameEnum.CookieRhythmlResult.Perfect or nHitType == GameEnum.CookieRhythmlResult.Excellent then
    NovaAPI.SetTMPText(self._mapNode.txtPerfectCombo, string.format("x%d", self.nPerfectCombo))
    self._mapNode.txtPerfectCombo.gameObject:SetActive(self.nPerfectCombo >= 2)
    self._mapNode.animPerfectEff.gameObject:SetActive(true)
    self._mapNode.animPerfectEff.transform:SetParent(objNextCtrl.gameObject.transform, false)
    nAnimLength = NovaAPI.GetAnimClipLength(self._mapNode.animPerfectEff, {
      "CookieBoard_HitEffect_perfect"
    })
    self._mapNode.animPerfectEff:Play("CookieBoard_HitEffect_perfect", 0, 0)
  elseif nHitType == GameEnum.CookieRhythmlResult.Good then
    self._mapNode.animExcellentEff.gameObject:SetActive(true)
    self._mapNode.animExcellentEff.transform:SetParent(objNextCtrl.gameObject.transform, false)
    nAnimLength = NovaAPI.GetAnimClipLength(self._mapNode.animExcellentEff, {
      "CookieBoard_HitEffect_excellent"
    })
    self._mapNode.animExcellentEff:Play("CookieBoard_HitEffect_excellent", 0, 0)
  elseif nHitType == GameEnum.CookieRhythmlResult.Miss then
    self._mapNode.animMissEff.gameObject:SetActive(true)
    self._mapNode.animMissEff.transform:SetParent(objNextCtrl.gameObject.transform, false)
    nAnimLength = NovaAPI.GetAnimClipLength(self._mapNode.animMissEff, {
      "CookieBoard_HitEffect_miss"
    })
    self._mapNode.animMissEff:Play("CookieBoard_HitEffect_miss", 0, 0)
  end
  if self.timerEff ~= nil then
    self.timerEff:Cancel()
  end
  self.timerEff = self:AddTimer(1, nAnimLength + 0.15, "ResetEff", true, true, true)
end

function CookieBoardCtrl:StartBeatLightLoop(nInterval, endCallback)
  for i = 1, #self._mapNode.imgDotInner do
    local imgDot = self._mapNode.imgDotInner[i]
    if imgDot ~= nil then
      imgDot.gameObject:SetActive(false)
    end
  end
  for i = 1, #self._mapNode.imgLight do
    local imgDot = self._mapNode.imgLight[i]
    if imgDot ~= nil then
      imgDot.gameObject:SetActive(false)
    end
  end
  for i = 1, #self._mapNode.animLightBg do
    local currLight = self._mapNode.animLightBg[i]
    if currLight ~= nil then
      local goHalo = currLight.gameObject.transform:Find("imgHalo_01")
      if goHalo ~= nil then
        goHalo.gameObject:SetActive(false)
      end
    end
  end
  self.nBeatLightIndex = nil
  self.nBeatLightCount = 0
  local nHaloCount = 1
  
  local function beatHaloLoop()
    local currLight = self._mapNode.animLightBg[nHaloCount]
    if currLight ~= nil then
      local goHalo = currLight.gameObject.transform:Find("imgHalo_01")
      if goHalo ~= nil then
        goHalo.gameObject:SetActive(true)
      end
      local nAnimTime = NovaAPI.GetAnimClipLength(currLight, {
        "CookieBoard_RhythmStar_Tips"
      })
      currLight:SetFloat("PlaySpeed", math.floor(nAnimTime / self.nHitThreshold * 100) / 100)
      currLight:Play("CookieBoard_RhythmStar_Tips", 0, 0)
    elseif self.timerBeatHalo ~= nil then
      self.timerBeatHalo:Cancel()
      self.timerBeatHalo = nil
    end
    nHaloCount = nHaloCount + 1
  end
  
  self:AddTimer(1, nInterval - self.nHitThreshold, function()
    beatHaloLoop()
    self.timerBeatHalo = self:AddTimer(0, nInterval, beatHaloLoop, true, true, true)
  end, true, true, true)
  local bBeatPlayed = false
  local sEvent = self:GetRhythmSwitchSoundEvent()
  self.timerBeatLight = self:AddTimer(0, nInterval, function()
    self:BeatLightLoop(true)
    if bBeatPlayed == false then
      bBeatPlayed = true
      CS.WwiseAudioManager.Instance:PostEvent(sEvent)
    end
    self.nBeatLightCount = self.nBeatLightCount + 1
    if self.nBeatLightCount >= 4 then
      local nAnimLength = NovaAPI.GetAnimClipLength(self._mapNode.animRoot, {
        "CookieBoard_out_Rhythm"
      })
      self._mapNode.animRoot:Play("CookieBoard_out_Rhythm", 0, 0)
      if endCallback ~= nil then
        endCallback()
      end
      if self.timerBeatLight ~= nil then
        self.timerBeatLight:Cancel()
        self.timerBeatLight = nil
      end
    end
  end, true, true, true)
end

function CookieBoardCtrl:BeatLightLoop(bStart)
  local tbDots = bStart and self._mapNode.imgLight or self._mapNode.imgDotInner
  for i = 1, #tbDots do
    local imgDot = tbDots[i]
    if imgDot ~= nil then
      imgDot.gameObject:SetActive(false)
    end
  end
  if self.nBeatLightIndex == nil then
    self.nBeatLightIndex = 1
  else
    self.nBeatLightIndex = self.nBeatLightIndex + 1
    if self.nBeatLightIndex > #tbDots then
      self.nBeatLightIndex = 1
    end
  end
  local imgDotLight = tbDots[self.nBeatLightIndex]
  if imgDotLight ~= nil then
    imgDotLight.gameObject:SetActive(true)
  end
end

function CookieBoardCtrl:RefreshCountDownTimer()
  local nRemainTime = self.nTimeLimit - self.nTimeCount
  local nRemainMin = math.floor(nRemainTime / 60)
  local nRemainSec = math.floor(nRemainTime % 60)
  local sTime = string.format("%02d:%02d", nRemainMin, nRemainSec)
  NovaAPI.SetTMPText(self._mapNode.txtTimer, sTime)
  if nRemainTime < 0 then
    self:LevelEnd()
  end
end

function CookieBoardCtrl:LevelEnd()
  self:PauseGameCtrl()
  if nil ~= self.CookieGameBoard then
    self.CookieGameBoard:SetActive(false)
  end
  self.bGameStarted = false
  self:SetButtonsActive(false)
  NovaAPI.SetTMPText(self._mapNode.txtTimer, "00:00")
  self:CalculateScore(false)
  self._mapNode.goResult:SetActive(true)
  self._mapNode.goBlurRes:SetActive(true)
  local bNewRecord = false
  local cookieData = PlayerData.Activity:GetActivityDataById(self.nActId)
  local levelData = cookieData:GetLevelDataById(self.nLevelId)
  if levelData ~= nil and self.nScore > levelData.nMaxScore then
    bNewRecord = true
  end
  if self.bRhythmMode == false then
    self.bFullCombo = false
    self.bAllPerfect = false
  end
  if self.timerRound ~= nil then
    self.timerRound:Cancel()
  end
  self:SetEnvironmentBeat(false)
  CS.WwiseAudioManager.Instance:PlaySound("mode_cookie1_complete")
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self.goScoreBoard.gameObject:SetActive(true)
    self.goScoreBoard:Init(self.nPackModel, self.nScore, self.nCompCookieCount, self.nCompBoxCount, self.nCriticalPerfectCount, self.nPerfectCount, self.nGoodCount, self.nMissCount, bNewRecord, self.bFullCombo, self.bAllPerfect, self.nActId)
    self._mapNode.animResult:Play(tbResultAnim[self.nPackModel], 0, 0)
  end
  
  local function callback()
    if bNewRecord and self.bRhythmMode and self.bPipelineMode then
      cookieData:SetNMHighScoreDay()
    end
    self._mapNode.btnConfirmScore.gameObject:SetActive(true)
    self._mapNode.btnShortcutConfirmScore.gameObject:SetActive(true)
  end
  
  EventManager.Hit("Cookie_Game_Complete", self.nLevelId, self.nScore, self.nCompBoxCount, self.nCompCookieCount, self.nGoodCount, self.nPerfectCount, self.nCriticalPerfectCount, self.nMissCount, self.nActId, callback)
  EventManager.Hit(EventId.TemporaryBlockInput, 2)
  cs_coroutine.start(wait)
end

function CookieBoardCtrl:ResumeTrigger()
  self:SetEnvironmentBeat(true)
  self.nFixedTimer = 0
  self.nBeatsTimer = 0
  self.bBlockInput = false
  self.bMissSwitch = false
  self.bCurrNoteHit = false
  self.bCurrNoteClicked = false
  self.bPaused = false
  self.bPressed = false
  self.bNewBeat = true
  EventManager.Hit(EventId.BlockInput, false)
  if self.bRhythmMode then
    EventManager.Hit(EventId.TemporaryBlockInput, 0.1)
  end
  if self.timerPause ~= nil then
    self.timerPause:Cancel()
  end
end

function CookieBoardCtrl:OnBtn_A()
  if self.bPaused or self.bPressed then
    return
  end
  self.bPressed = true
  self.animBtnA:Play("CookieBoard_Platebtn_Hit", 0, 0)
  self:FillCurrentGrid(1)
end

function CookieBoardCtrl:OnBtn_B()
  if self.bPaused or self.bPressed then
    return
  end
  self.bPressed = true
  self.animBtnB:Play("CookieBoard_Platebtn_Hit", 0, 0)
  self:FillCurrentGrid(2)
end

function CookieBoardCtrl:OnBtn_C()
  if self.bPaused or self.bPressed then
    return
  end
  self.bPressed = true
  self.animBtnC:Play("CookieBoard_Platebtn_Hit", 0, 0)
  self:FillCurrentGrid(3)
end

function CookieBoardCtrl:OnBtn_D()
  if self.bPaused or self.bPressed then
    return
  end
  self.bPressed = true
  self.animBtnD:Play("CookieBoard_Platebtn_Hit", 0, 0)
  self:FillCurrentGrid(4)
end

function CookieBoardCtrl:OnBtn_ConfirmGameOver()
  local function closePanel()
    CS.WwiseAudioManager.Instance:PostEvent("mode_cookie_1_stop")
    
    EventManager.Hit(EventId.ClosePanel, PanelId.CookieBoardPanel_400016)
  end
  
  local rewardChangeInfo = self.cookieData:GetLevelReward()
  if rewardChangeInfo ~= nil and #rewardChangeInfo.Props > 0 then
    self.cookieData:SetLevelReward(nil)
    local levelData = ConfigTable.GetData("CookieLevel", self.nLevelId)
    if levelData ~= nil then
      local tbRewardData = {}
      for i = 1, 3 do
        local nItemId = levelData["FirstCompletionReward" .. i .. "Tid"]
        local nItemCount = levelData["FirstCompletionReward" .. i .. "Qty"]
        if nItemId ~= nil and 0 < nItemId then
          local tbData = {
            Tid = nItemId,
            Qty = nItemCount,
            rewardType = AllEnum.RewardType.First
          }
          table.insert(tbRewardData, tbData)
        end
      end
      if tbRewardData ~= nil and 0 < #tbRewardData then
        UTILS.OpenReceiveByDisplayItem(tbRewardData or {}, rewardChangeInfo, function()
          local nRandom = math.random(50, 51)
          EventManager.Hit(EventId.SetTransition, nRandom, closePanel)
        end)
        return
      end
    end
  end
  local nRandom = math.random(50, 51)
  EventManager.Hit(EventId.SetTransition, nRandom, closePanel)
end

function CookieBoardCtrl:OnEvent_Time()
  if self.bRhythmMode then
    local nDeltaTime = 0.034
    if self.nPrevTime ~= nil then
      nDeltaTime = CS.UnityEngine.Time.time - self.nPrevTime
    end
    self.nPrevTime = CS.UnityEngine.Time.time
    self.nFixedTimer = self.nFixedTimer + nDeltaTime
    if self.nWaitingNextBeat > 0 or self.bPaused then
      return
    end
    local nNoteMissTime = self.nBeatsTimer + self.nHitThreshold
    if nNoteMissTime < self.nFixedTimer and self.bMissSwitch then
      if not self.bCurrNoteClicked then
        self:NoteMiss()
        self:PlayHitEffect(GameEnum.CookieRhythmlResult.Miss)
      end
      self.bMissSwitch = false
      self.bCurrNoteHit = false
      self.bCurrNoteClicked = false
    end
    if nNoteMissTime < self.nFixedTimer and self.bWaitingNextBeatNote then
      self.bWaitingNextBeatNote = false
      self:SelectionForward(true)
    end
    if self.bNewBeat then
      self.bNewBeat = false
      self.nNextHaloAnim = self.nBeatsTimer + self.nBeatInterval - self.nHitThreshold
    end
    if self.nFixedTimer >= self.nNextHaloAnim then
      if self.bHaloAnimPlaying == false then
        self.bHaloAnimPlaying = true
        local nAnimSpeed = math.floor(nPerfectTiming / self.nHitThreshold * 100) / 100
        if self.nextCtrl ~= nil then
          self.nextCtrl:PlayHaloAnim(nAnimSpeed)
        end
      end
    elseif self.nFixedTimer < self.nNextHaloAnim then
      self.bHaloAnimPlaying = false
    end
    if self.bOverrideMode then
      local nNextRes = self.timerBeat:GetRemainInterval()
      local nRes = self.nBeatInterval - nNextRes
      if math.abs(nNextRes) < math.abs(nRes) then
        nRes = nNextRes
      end
      if nRes < self.nPerfectThreshold and nRes > -self.nPerfectThreshold then
        EventManager.Hit("CookieNoteIndicator", GameEnum.CookieRhythmlResult.Perfect)
      elseif nRes < self.nGoodThreshold and nRes > -self.nGoodThreshold then
        EventManager.Hit("CookieNoteIndicator", GameEnum.CookieRhythmlResult.Good)
      else
        EventManager.Hit("CookieNoteIndicator", GameEnum.CookieRhythmlResult.Miss)
      end
    end
  end
  if self.bPaused then
    return
  end
  self.nTimeCount = self.nTimeCount + 0.034
  self:RefreshCountDownTimer()
end

function CookieBoardCtrl:OnEvent_Beat()
  self.nBeatsTimer = self.nBeatsTimer + self.nBeatInterval
  self.nDisposalBeatTimer = 0
  self.bMissSwitch = true
  self.bNewBeat = true
  if self.bPaused == false then
    self:BeatLightLoop(false)
  end
  if 0 < self.nWaitingNextBeat then
    self.nWaitingNextBeat = self.nWaitingNextBeat - 1
    if self.nWaitingNextBeat == 0 then
      self:NextBox()
    end
    return
  end
  if self.bPauseResume then
    self:ResumeTrigger()
    self.bPauseResume = false
    return
  end
end

function CookieBoardCtrl:OnEvent_PauseResume()
  self.nTimeResume = self.nTimeResume + 1
  NovaAPI.SetTMPText(self._mapNode.txtTimerResume, self.nReturnCd - self.nTimeResume)
  if self.nTimeResume >= self.nReturnCd then
    if self.bRhythmMode then
      self.bPauseResume = true
    else
      self:ResumeTrigger()
    end
  end
end

function CookieBoardCtrl:OnBtn_Back()
  if self.bBlockInput then
    return
  end
  if self.bGameStarted == false then
    self:OnBtn_ConfirmGameOver()
    return
  end
  self:PauseGameCtrl()
  
  local function confirmCallback()
    self.bAllPerfect = false
    self.bFullCombo = false
    self:LevelEnd()
  end
  
  local function cancelCallback()
    self:ResumeGameCtrl()
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("Cookie_Act_Exit_Tip"),
    callbackConfirm = confirmCallback,
    callbackCancel = cancelCallback,
    bBlur = true
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function CookieBoardCtrl:OnBtn_GameStart()
  if self.bGameStartPressed == true then
    return
  end
  self.bGameStartPressed = true
  self._mapNode.animRoot:Play("CookieBoard_txt_out", 0, 0)
  local nAnimLength = NovaAPI.GetAnimClipLength(self._mapNode.animRoot, {
    "CookieBoard_txt_out"
  })
  self:AddTimer(1, nAnimLength, function()
    self:GameInit()
    self:GameStart()
  end, true, true, true)
end

function CookieBoardCtrl:OnEvent_CookieRequestCtrl()
  EventManager.Hit("CookieRequestCtrlReceive", self)
end

function CookieBoardCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nLevelId = param[1]
    self.bRhythmMode = param[2]
    self.bPipelineMode = param[3]
    self.nTimeLimit = param[4]
    self.nActId = param[5]
    self.nPassScore = param[6]
  end
  self.cookieData = PlayerData.Activity:GetActivityDataById(self.nActId)
  self.tbGamepadUINode = self:GetGamepadUINode()
  self.nPathGroupId = 0
  self.nPackModel = 0
  self.nCurrGridIndex = 1
  self.nCurrBoardIndex = 1
  self.nCurrLevelConfigIdx = 1
  self.nTimeCount = 0.0
  self.nTimeResume = 0
  self.tbNextGrid = {}
  self.tbGrid = {}
  self.tbPath = {}
  self.nLastPath = 0
  self.timerRound = nil
  self.timerPause = nil
  self.nCurrGird = {1, 1}
  self.tbGridCtrl = {}
  self.nOverridePathId = 0
  self.nReturnCd = 3
  self.bCurrNoteHit = false
  self.bCurrNoteClicked = false
  self.bHaloAnimPlaying = false
  self.bOverrideMode = false
  self._mapNode.goNoteIndicator:SetActive(false)
end

function CookieBoardCtrl:OnEnable()
  GamepadUIManager.EnableGamepadUI("CookieBoardCtrl", self.tbGamepadUINode)
  self.mapLevelConfig = ConfigTable.GetData("CookieLevel", self.nLevelId)
  if self.mapLevelConfig == nil or self.mapLevelConfig.Id ~= self.nLevelId then
    printError("CookieLevel config missing or level id mismatch, levelId:" .. tostring(self.nLevelId))
    EventManager.Hit(EventId.CloesCurPanel)
    return
  end
  self.nPackModel = self.mapLevelConfig.PackModel
  self.tbFloor = {}
  ForEachTableLine(ConfigTable.Get("CookieFloor"), function(tbData)
    if tbData.FloorId == self.mapLevelConfig.FloorId then
      table.insert(self.tbFloor, tbData)
    end
  end)
  if self.tbFloor == nil or #self.tbFloor == 0 then
    printError("CookieFloor config missing, levelId:" .. tostring(self.nLevelId) .. ", floorId:" .. tostring(self.mapLevelConfig.FloorId))
    EventManager.Hit(EventId.CloesCurPanel)
    return
  end
  self.tbPathGroup = {}
  ForEachTableLine(ConfigTable.Get("CookiePackagePathsGroup"), function(tbData)
    table.insert(self.tbPathGroup, tbData)
  end)
  self.nPerfectThreshold = ConfigTable.GetData("CookieRhythmlResult", 2).Range
  self.nGoodThreshold = ConfigTable.GetData("CookieRhythmlResult", 3).Range
  local sStartAnim = sDefaultStartAnim
  if self.nPackModel == GameEnum.CookiePackModel.CookiePackRhythmlModel or self.nPackModel == GameEnum.CookiePackModel.CookiePackComplexModel then
    self.goScoreBoard = self._mapNode.ScoreBoardRhythm
  else
    self.goScoreBoard = self._mapNode.ScoreBoardOther
  end
  self.bGameStarted = false
  self:SetButtonsActive(false)
  NovaAPI.SetTMPText(self._mapNode.txtAddTime, "")
  NovaAPI.SetTMPText(self._mapNode.txtScoreCalculator, 0)
  self.goScoreBoard.gameObject:SetActive(false)
  self._mapNode.btnConfirmScore.gameObject:SetActive(false)
  self._mapNode.btnShortcutConfirmScore.gameObject:SetActive(false)
  self._mapNode.goBlur:SetActive(false)
  self._mapNode.goResult:SetActive(false)
  self._mapNode.CookieGameBoard3x3:SetActive(false)
  self._mapNode.CookieGameBoard4x4:SetActive(false)
  self._mapNode.goBlurRes:SetActive(false)
  self._mapNode.btnBackReal.gameObject:SetActive(not self.bGameStarted)
  self._mapNode.btnPauseReal.gameObject:SetActive(self.bGameStarted)
  self._mapNode.goRhythmDots:SetActive(false)
  self._mapNode.imgHeartMissEff:SetActive(self.bRhythmMode and self.bPipelineMode)
  self._mapNode.imgScoreNMBg:SetActive(self.bRhythmMode and self.bPipelineMode)
  self._mapNode.imgScoreNormalBg:SetActive(not self.bRhythmMode or not self.bPipelineMode)
  self._mapNode.imgScoreCalculatorFiller.sizeDelta = Vector2(0, self._mapNode.imgScoreCalculatorFiller.sizeDelta.y)
  NovaAPI.SetTMPText(self._mapNode.txtCookieCountNumNM, 0)
  NovaAPI.SetTMPText(self._mapNode.txtCookieCountNumNormal, 0)
  NovaAPI.SetTMPText(self._mapNode.txtBoxCountNumNM, 0)
  NovaAPI.SetTMPText(self._mapNode.txtBoxCountNumNormal, 0)
  self.animBtnA = self._mapNode.btnA.transform:Find("AnimRoot"):GetComponent("Animator")
  self.animBtnB = self._mapNode.btnB.transform:Find("AnimRoot"):GetComponent("Animator")
  self.animBtnC = self._mapNode.btnC.transform:Find("AnimRoot"):GetComponent("Animator")
  self.animBtnD = self._mapNode.btnD.transform:Find("AnimRoot"):GetComponent("Animator")
  self:SetEnvironmentBeat(false)
  self:ResetEff()
  NovaAPI.SetCanvasSortingName(self._mapNode.animPerfectEff:GetComponent(typeof(CS.UnityEngine.Canvas)), AllEnum.SortingLayerName.UI)
  NovaAPI.SetCanvasSortingName(self._mapNode.animExcellentEff:GetComponent(typeof(CS.UnityEngine.Canvas)), AllEnum.SortingLayerName.UI)
  NovaAPI.SetCanvasSortingName(self._mapNode.animMissEff:GetComponent(typeof(CS.UnityEngine.Canvas)), AllEnum.SortingLayerName.UI)
  local nSortingOrder = self._panel._nIndex * 100 + 99
  NovaAPI.SetCanvasSortingOrder(self._mapNode.animPerfectEff:GetComponent(typeof(CS.UnityEngine.Canvas)), nSortingOrder)
  NovaAPI.SetCanvasSortingOrder(self._mapNode.animExcellentEff:GetComponent(typeof(CS.UnityEngine.Canvas)), nSortingOrder)
  NovaAPI.SetCanvasSortingOrder(self._mapNode.animMissEff:GetComponent(typeof(CS.UnityEngine.Canvas)), nSortingOrder)
  self.nCurrLevelConfigIdx = 1
  self.tbActiveCookieTypes = {}
  self:UpdateActiveButtons()
  self:ApplyButtonActivation()
  self.nBoardSize = self.tbFloor[1].Size
  self.CookieGameBoard = self.nBoardSize == 3 and self._mapNode.CookieGameBoard3x3 or self._mapNode.CookieGameBoard4x4
  if nil ~= self.CookieGameBoard then
    self.CookieGameBoard:SetActive(true)
  end
  EventManager.Hit(EventId.SetTransition)
  CS.WwiseAudioManager.Instance:PlaySound("mode_cookie1_start")
  self._mapNode.animRoot:Play(sStartAnim, 0, 0)
  EventManager.Hit(EventId.BlockInput, true)
  self:AddTimer(1, nPreMusicTime, function()
    EventManager.Hit(EventId.BlockInput, false)
  end, true, true, true)
end

function CookieBoardCtrl:OnDisable()
  GamepadUIManager.DisableGamepadUI("CookieBoardCtrl")
  self:UnbindGridCtrl()
  if self.timerRound ~= nil then
    self.timerRound:Cancel()
  end
  if self.timerPause ~= nil then
    self.timerPause:Cancel()
  end
  if self.timerEff ~= nil then
    self.timerEff:Cancel()
  end
  if self.timerStart ~= nil then
    self.timerStart:Cancel()
  end
  if self.timerNextBox ~= nil then
    self.timerNextBox:Cancel()
  end
  if self.timerBeat ~= nil then
    self.timerBeat:Cancel()
  end
  if self.timerNextBox ~= nil then
    self.timerNextBox:Cancel()
  end
  if self.timerBeatLight ~= nil then
    self.timerBeatLight:Cancel()
  end
  if self.timerBeatHalo ~= nil then
    self.timerBeatHalo:Cancel()
  end
end

return CookieBoardCtrl

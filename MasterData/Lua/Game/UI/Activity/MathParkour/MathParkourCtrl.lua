local MathParkourCtrl = class("MathParkourCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
MathParkourCtrl._mapNodeConfig = {
  rtBuff = {
    nCount = 5,
    sCtrlName = "Game.UI.Activity.MathParkour.MathParkourBuffCtrl"
  },
  txt_newScore = {
    sComponentName = "TMP_Text",
    sLanguageId = "MathParkour_Text_NewScore"
  },
  txt_targetScore = {sComponentName = "TMP_Text"},
  imgActProgress = {sComponentName = "Image"},
  StarItem = {nCount = 3},
  obj_Time = {},
  btnPause = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Pause",
    sAction = "MathParkour_Pause"
  },
  goChallenge = {
    sCtrlName = "Game.UI.Activity.MathParkour.MathParkourResultSuccessCtrl"
  },
  goFailure = {
    sCtrlName = "Game.UI.Activity.MathParkour.MathParkourResultFailCtrl"
  },
  goPause = {
    sNodeName = "MathParkourPause",
    sCtrlName = "Game.UI.Activity.MathParkour.MathParkourPauseCtrl"
  },
  btn_qte = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_QTE",
    sAction = "MathParkour_QTE",
    sActionIconType = "Dark"
  },
  goSmash = {},
  imgSmasProgress = {sComponentName = "Image"},
  txt_SmashScore = {
    sComponentName = "TMP_Text",
    sLanguageId = "MathParkour_Text_SmashScore"
  },
  btnClearthescene = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_ClearTheScene",
    sAction = "MathParkour_Boom"
  },
  txt_Clearthescene = {
    sComponentName = "TMP_Text",
    nCount = 2,
    sLanguageId = "MathParkour_Clearthescene"
  },
  imgProgress = {sComponentName = "Image"},
  txt_Score1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MathParkour_Text_Score1"
  },
  txt_Score = {sComponentName = "TMP_Text"},
  canvasGroup = {
    sNodeName = "----SafeAreaRoot---",
    sComponentName = "CanvasGroup"
  }
}
MathParkourCtrl._mapEventConfig = {
  MathParkour_AddScore = "OnEvent_AddScore",
  MathParkour_BuffItemCollected = "OnEvent_AddBuff",
  MathParkour_UseBuff = "OnEvent_UseBuff",
  MathParkour_BuffConsumed = "OnEvent_BuffConsumed",
  MathParkour_BoomTime = "OnEvent_BoomTime",
  MathParkour_LevelEnd = "OnEvent_LevelEnd",
  MathParkour_BossEncountered = "OnEvent_BossEncountered",
  MathParkour_Confirm = "OnEvent_Confirm",
  MathParkour_Again = "OnEvent_Again",
  MathParkour_NextLevel = "OnEvent_GoNextLevel",
  MathParkour_BuffTimeOut = "OnEvent_BuffTimeOut",
  MathParkour_Exit_OnClick = "OnEvent_Exit",
  MathParkour_Restart_OnClick = "OnEvent_Restart",
  MathParkour_Continue_OnClick = "OnEvent_Continue",
  MathParkour_EnterLevel = "OnEvent_EnterLevel",
  MathParkour_BlockInput = "OnEvent_BlockInput",
  MathParkour_GMRemoveBuff = "OnEvent_GMRemoveBuff",
  MathParkour_GM_ToggleBuffOverlay = "OnEvent_GMToggleBuffOverlay",
  MathParkour_GM_Pause = "OnEvent_GMPause"
}
MathParkourCtrl._mapRedDotConfig = {}

function MathParkourCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
    self.nLevelId = param[2]
  end
  self.tbGamepadUINode = self:GetGamepadUINode()
  GamepadUIManager.AddGamepadUINode("MathParkourCtrl", self.tbGamepadUINode)
  self:InitData()
  self:UpdatePanelData()
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, 0)
end

function MathParkourCtrl:OnDestroy()
  self:ClearGMBuffOverlay()
end

function MathParkourCtrl:InitData()
  self.bPause = true
  self.levelCfg = ConfigTable.GetData("MathParkourLevel", self.nLevelId)
  self.cfg = ConfigTable.GetData("MathParkourConfig", self.levelCfg.ConfigId)
  self.actData = PlayerData.Activity:GetActivityDataById(self.nActId)
  self.CurLevelData = self.actData:GetLevelData(self.nLevelId)
  self.nCurScore = 0
  self.nStar = 0
  self.bInResult = false
  self:UpdateScore(0)
  self.nAddBuffCount = 0
  self.tbUsedBuffItem = {}
  self.tbBuffItem = {}
  self.bBossEncountered = false
  for i = 1, 5 do
    self.tbBuffItem[i] = self._mapNode.rtBuff[i]
    self.tbBuffItem[i].gameObject:SetActive(false)
  end
end

function MathParkourCtrl:UpdatePanelData()
  self._mapNode.btnClearthescene.gameObject:SetActive(false)
  self._mapNode.goChallenge:HidePanel()
  self._mapNode.goFailure:HidePanel()
  self._mapNode.obj_Time:SetActive(true)
  local timeOutGo = self._mapNode.obj_Time.transform:Find("AnimRoot")
  timeOutGo.gameObject:SetActive(false)
  self:InitQTE()
  self._mapNode.txt_Score1.gameObject:SetActive(self.bBossEncountered)
  self._mapNode.txt_Score.gameObject:SetActive(self.bBossEncountered)
end

function MathParkourCtrl:InitQTE()
  self._mapNode.goSmash.gameObject:SetActive(false)
  self._mapNode.btn_qte.gameObject:SetActive(false)
  if self.qteTimer ~= nil then
    self.qteTimer:Cancel()
    self.qteTimer = nil
  end
  self.nQte = 0
end

function MathParkourCtrl:StartGame()
  local bNewLevel = self.actData:GetLevelIsNew(self.nLevelId)
  if bNewLevel and self.levelCfg.DicId ~= 0 then
    self.actData:EnterLevel(self.nLevelId)
    EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, self.levelCfg.DicId, true, function()
      WwiseAudioMgr:PostEvent("Mode_400018_start")
      self:AddTimer(1, 0.5, function()
        local timeOutGo = self._mapNode.obj_Time.transform:Find("AnimRoot")
        timeOutGo.gameObject:SetActive(true)
        NovaAPI.DispatchEventWithData("MATHPARKOUR_STARTLEVEL", nil, nil)
        EventManager.Hit(EventId.BlockInput, true)
        self:AddTimer(1, 3.5, function()
          self._mapNode.obj_Time:SetActive(false)
          self.bPause = false
          EventManager.Hit(EventId.BlockInput, false)
          NovaAPI.DispatchEventWithData("MATHPARKOUR_START", nil, nil)
        end, true, true, true)
      end, true, true, true)
    end)
  else
    EventManager.Hit(EventId.BlockInput, true)
    WwiseAudioMgr:PostEvent("Mode_400018_start")
    self:AddTimer(1, 0.5, function()
      local timeOutGo = self._mapNode.obj_Time.transform:Find("AnimRoot")
      timeOutGo.gameObject:SetActive(true)
      NovaAPI.DispatchEventWithData("MATHPARKOUR_STARTLEVEL", nil, nil)
      self:AddTimer(1, 3.5, function()
        self._mapNode.obj_Time:SetActive(false)
        self.bPause = false
        EventManager.Hit(EventId.BlockInput, false)
        NovaAPI.DispatchEventWithData("MATHPARKOUR_START", nil, nil)
      end, true, true, true)
    end, true, true, true)
    self.actData:EnterLevel(self.nLevelId)
  end
end

function MathParkourCtrl:ShowQTE()
  NovaAPI.SetImageFillAmount(self._mapNode.imgSmasProgress, 0)
  self._mapNode.goSmash.gameObject:SetActive(true)
  self._mapNode.btn_qte.gameObject:SetActive(true)
  self.qteTimer = self:AddTimer(0, 1, function()
    self.nQte = self.nQte - self.cfg.QteProgressDeduction
    self.nQte = math.max(self.nQte, 0)
    NovaAPI.SetImageFillAmount(self._mapNode.imgSmasProgress, self.nQte / self.cfg.QteProgressLimit)
    NovaAPI.DispatchEventWithData("MathParkour_SetQteSpeed", nil, {
      self.nQte * self.cfg.QteSpeedFactor
    })
  end, true, true, true)
end

function MathParkourCtrl:RemoveBuff(nBuffId)
  if self.tbUsedBuffItem[nBuffId] ~= nil then
    local buffItem = self.tbUsedBuffItem[nBuffId]
    table.insert(self.tbBuffItem, buffItem)
    buffItem.gameObject:SetActive(false)
    local buffCfg = ConfigTable.GetData("MathParkourBuffItem", nBuffId)
    if buffCfg.ObjType == GameEnum.MathParkourBuffType.Boom then
      self._mapNode.btnClearthescene.gameObject:SetActive(false)
    end
    self.tbUsedBuffItem[nBuffId] = nil
    NovaAPI.DispatchEventWithData("MathParkour_BuffRemoved", nil, {nBuffId})
  end
end

function MathParkourCtrl:Remap(nValue, nInMin, nInMax, nOutMin, nOutMax)
  if nInMax == nInMin then
    return nOutMin
  end
  return nOutMin + (nValue - nInMin) / (nInMax - nInMin) * (nOutMax - nOutMin)
end

function MathParkourCtrl:UpdateScore(nAddScore)
  self.nCurScore = math.max(self.nCurScore + nAddScore, 0)
  NovaAPI.SetTMPText(self._mapNode.txt_targetScore, self.nCurScore)
  self._mapNode.txt_newScore.gameObject:SetActive(self.nCurScore > self.CurLevelData.nScore)
  local nStar = 0
  if self.nCurScore >= self.levelCfg.Reward3Condition then
    NovaAPI.SetImageFillAmount(self._mapNode.imgActProgress, 1)
    nStar = 3
  elseif self.nCurScore >= self.levelCfg.Reward2Condition then
    local nTempScore = self.nCurScore - self.levelCfg.Reward2Condition
    local amount = self:Remap(nTempScore / (self.levelCfg.Reward3Condition - self.levelCfg.Reward2Condition), 0, 1, 0, 0.33) + 0.66
    NovaAPI.SetImageFillAmount(self._mapNode.imgActProgress, amount)
    nStar = 2
  elseif self.nCurScore >= self.levelCfg.Reward1Condition then
    local nTempScore = self.nCurScore - self.levelCfg.Reward1Condition
    local amount = self:Remap(nTempScore / (self.levelCfg.Reward2Condition - self.levelCfg.Reward1Condition), 0, 1, 0, 0.33) + 0.33
    NovaAPI.SetImageFillAmount(self._mapNode.imgActProgress, amount)
    nStar = 1
  else
    local amount = self:Remap(self.nCurScore / self.levelCfg.Reward1Condition, 0, 1, 0, 0.33)
    NovaAPI.SetImageFillAmount(self._mapNode.imgActProgress, amount)
    nStar = 0
  end
  for i = 1, 3 do
    local star = self._mapNode.StarItem[i].transform:Find("ImgStarGray")
    star.gameObject:SetActive(i > nStar)
  end
  self.nStar = nStar
end

function MathParkourCtrl:ApplyLogicPause(bPause)
  if bPause then
    NovaAPI.DispatchEventWithData("MATHPARKOUR_PAUSE_STATE_CHANGED", nil, {1})
    EventManager.Hit("MathParkour_CastAssistSkillPause", true)
    if self.tbUsedBuffItem ~= nil then
      for _, v in pairs(self.tbUsedBuffItem) do
        v:Pause(true)
      end
    end
    WwiseAudioMgr:PostEvent("Mode_400018_all_pasue")
  else
    NovaAPI.DispatchEventWithData("MATHPARKOUR_PAUSE_STATE_CHANGED", nil, {0})
    EventManager.Hit("MathParkour_CastAssistSkillPause", false)
    if self.tbUsedBuffItem ~= nil then
      for _, v in pairs(self.tbUsedBuffItem) do
        v:Pause(false)
      end
    end
    WwiseAudioMgr:PostEvent("Mode_400018_all_resume")
  end
end

function MathParkourCtrl:IsLogicPaused()
  return self.bPause == true or self.bGMPaused == true
end

function MathParkourCtrl:OnEvent_GMPause(bPause)
  if bPause then
    if self:IsLogicPaused() then
      return
    end
    self.bGMPaused = true
    self:ApplyLogicPause(true)
    return
  end
  if not self.bGMPaused then
    return
  end
  self.bGMPaused = false
  if self:IsLogicPaused() then
    return
  end
  self:ApplyLogicPause(false)
end

function MathParkourCtrl:OnBtnClick_Pause()
  if self.bInResult then
    return
  end
  self.bPause = true
  self:ApplyLogicPause(true)
  self._mapNode.goPause:Open(self.levelCfg.DicId)
end

function MathParkourCtrl:OnBtnClick_Start()
end

function MathParkourCtrl:OnBtnClick_ClearTheScene()
  if self.tempClearSceneBuffId ~= nil and self.tbUsedBuffItem[self.tempClearSceneBuffId] ~= nil then
    NovaAPI.DispatchEventWithData("MATHPARKOUR_CLEAR_THE_SCENE", nil, {
      self.tempClearSceneBuffId
    })
  end
  if self.tbUsedBuffItem[self.tempClearSceneBuffId] ~= nil then
    local buffItem = self.tbUsedBuffItem[self.tempClearSceneBuffId]
    table.insert(self.tbBuffItem, buffItem)
    buffItem.gameObject:SetActive(false)
    local buffCfg = ConfigTable.GetData("MathParkourBuffItem", self.tempClearSceneBuffId)
    if buffCfg.ObjType == GameEnum.MathParkourBuffType.Boom then
      self._mapNode.btnClearthescene.gameObject:SetActive(false)
    end
    self.tbUsedBuffItem[self.tempClearSceneBuffId] = nil
  end
end

function MathParkourCtrl:OnBtnClick_QTE()
  self.nQte = self.nQte + self.cfg.QteProgressPerClick
  self.nQte = math.min(self.nQte, self.cfg.QteProgressLimit)
  NovaAPI.SetImageFillAmount(self._mapNode.imgSmasProgress, self.nQte / self.cfg.QteProgressLimit)
  NovaAPI.DispatchEventWithData("MathParkour_SetQteSpeed", nil, {
    self.nQte * self.cfg.QteSpeedFactor
  })
end

function MathParkourCtrl:OnEvent_AddScore(nAddScore)
  self:UpdateScore(nAddScore)
  if self.bBossEncountered then
    self.nBossScore = self.nBossScore + nAddScore
    NovaAPI.SetTMPText(self._mapNode.txt_Score, "+" .. tostring(self.nBossScore))
  end
end

function MathParkourCtrl:OnEvent_AddBuff(nBuffId)
  self.nAddBuffCount = self.nAddBuffCount + 1
  local buffCfg = ConfigTable.GetData("MathParkourBuffItem", nBuffId)
  if NovaAPI.IsEditorPlatform() then
    print("MathParkourCtrl:OnEvent_AddBuff nBuffId=" .. tostring(nBuffId) .. "=====" .. buffCfg.Name)
  end
  if buffCfg.ObjType == GameEnum.MathParkourBuffType.Rocket then
    NovaAPI.DispatchEventWithData("MathParkour_BuffAdded", nil, {nBuffId})
    NovaAPI.DispatchEventWithData("MathParkour_BuffRemoved", nil, {nBuffId})
    return
  end
  if self.tbUsedBuffItem[nBuffId] == nil then
    local buffItem = self.tbBuffItem[1]
    buffItem.gameObject:SetActive(true)
    buffItem:ShowBuff(nBuffId, self:IsLogicPaused())
    self.tbUsedBuffItem[nBuffId] = buffItem
    if buffCfg.ObjType == GameEnum.MathParkourBuffType.Boom then
      self._mapNode.btnClearthescene.gameObject:SetActive(true)
      self.tempClearSceneBuffId = nBuffId
    end
    table.remove(self.tbBuffItem, 1)
    NovaAPI.DispatchEventWithData("MathParkour_BuffAdded", nil, {nBuffId})
  else
    self.tbUsedBuffItem[nBuffId]:ShowBuff(nBuffId, self:IsLogicPaused())
  end
end

function MathParkourCtrl:OnEvent_BuffTimeOut(nBuffId)
  local cfg = ConfigTable.GetData("MathParkourBuffItem", nBuffId)
  if cfg.ObjType == GameEnum.MathParkourBuffType.Boom then
    self:OnBtnClick_ClearTheScene()
  end
  self:RemoveBuff(nBuffId)
end

function MathParkourCtrl:OnEvent_UseBuff(nBuffId)
  self:RemoveBuff(nBuffId)
end

function MathParkourCtrl:OnEvent_BuffConsumed(nBuffId)
  self:RemoveBuff(nBuffId)
end

function MathParkourCtrl:OnEvent_BoomTime(fTime)
  NovaAPI.SetImageFillAmount(self._mapNode.imgProgress, fTime)
end

function MathParkourCtrl:OnEvent_LevelEnd(bResult)
  self:ClearGMBuffOverlay()
  self.bInResult = true
  if bResult then
    local nNextLevelId = self.actData:GetNextLevelId(self.nLevelId)
    self._mapNode.goChallenge:ShowPanel(self.nCurScore, self.nCurScore > self.CurLevelData.nScore, self.nStar, nNextLevelId ~= nil, self.nActId)
  else
    self._mapNode.goFailure:ShowPanel(self.nCurScore)
  end
  self.actData:DoResult(self.nLevelId, bResult, self.nCurScore, self.nStar, self.nAddBuffCount)
end

function MathParkourCtrl:OnEvent_BossEncountered()
  EventManager.Hit(EventId.TemporaryBlockInput, 1.6)
  EventManager.Hit("MathParkour_CastAssistSkill", 140, 14001)
  self:AddTimer(1, 1.66, function()
    self.bBossEncountered = true
    self:ShowQTE()
    self._mapNode.txt_Score1.gameObject:SetActive(self.bBossEncountered)
    self._mapNode.txt_Score.gameObject:SetActive(self.bBossEncountered)
    self.nBossScore = 0
    NovaAPI.SetTMPText(self._mapNode.txt_Score, "+" .. tostring(self.nBossScore))
  end, true, true, true)
end

function MathParkourCtrl:OnEvent_Confirm()
  if NovaAPI.GetCurrentModuleName() == "MainMenuModuleScene" then
    CS.AdventureModuleHelper.LevelStateChanged(true, 0, false)
    EventManager.Hit(EventId.CloesCurPanel)
    PlayerData.Base:OnBackToMainMenuModule()
  else
    NovaAPI.EnterModule("MainMenuModuleScene", true)
  end
end

function MathParkourCtrl:OnEvent_Again()
  NovaAPI.DispatchEventWithData("MathParkour_Restart", nil, nil)
  self:InitData()
  self:UpdatePanelData()
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, 0)
end

function MathParkourCtrl:OnEvent_GoNextLevel()
  local nNextLevelId = self.actData:GetNextLevelId(self.nLevelId)
  if nNextLevelId == nil then
    return
  end
  WwiseAudioMgr:PostEvent("Mode_400018_all_stop")
  self.nLevelId = nNextLevelId
  self:AddTimer(1, 0.1, function()
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, 0)
  end, true, true, true)
  self:InitData()
  self:UpdatePanelData()
  local param = {}
  table.insert(param, tostring(self.nActId))
  table.insert(param, tostring(self.CurLevelData.nId))
  table.insert(param, tostring(0))
  CS.MiniGameHelper.SetMiniGameData(param)
  NovaAPI.DispatchEventWithData("MathParkour_NextLevel", nil, nil)
end

function MathParkourCtrl:OnEvent_Exit()
  WwiseAudioMgr:PostEvent("Mode_400018_all_stop")
  if NovaAPI.GetCurrentModuleName() == "MainMenuModuleScene" then
    CS.AdventureModuleHelper.LevelStateChanged(true, 0, false)
    EventManager.Hit(EventId.CloesCurPanel)
    PlayerData.Base:OnBackToMainMenuModule()
  else
    NovaAPI.EnterModule("MainMenuModuleScene", true)
  end
end

function MathParkourCtrl:OnEvent_Restart()
  WwiseAudioMgr:PostEvent("Mode_400018_all_stop")
  self._mapNode.goPause:Close()
  NovaAPI.DispatchEventWithData("MathParkour_Restart", nil, nil)
  self:AddTimer(1, 0.1, function()
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, 0)
  end, true, true, true)
  self:InitData()
  self:UpdatePanelData()
end

function MathParkourCtrl:OnEvent_Continue()
  self._mapNode.goPause:Close()
  self.bPause = false
  if self:IsLogicPaused() then
    return
  end
  self:ApplyLogicPause(false)
end

function MathParkourCtrl:OnEvent_EnterLevel()
  local animator = self.gameObject:GetComponent("Animator")
  if animator ~= nil then
    animator:Play("MathParkourPanel_in")
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, 1)
  self:StartGame()
end

function MathParkourCtrl:OnEvent_BlockInput(bBlock)
  EventManager.Hit(EventId.BlockInput, bBlock)
end

function MathParkourCtrl:OnEvent_GMRemoveBuff(nBuffId)
  self:RemoveBuff(nBuffId)
end

function MathParkourCtrl:OnEvent_GMToggleBuffOverlay()
  self.bGMBuffOverlay = not self.bGMBuffOverlay
  if self.bGMBuffOverlay then
    self:EnsureGMBuffOverlay()
    self:RefreshGMBuffOverlay()
    if self.gmOverlayTimer == nil then
      self.gmOverlayTimer = self:AddTimer(0, 0.5, function()
        if self.bGMBuffOverlay then
          self:RefreshGMBuffOverlay()
        end
      end, true, true, true)
    else
      self.gmOverlayTimer:Pause(false)
    end
  else
    if self.goGMBuffOverlay ~= nil and not self.goGMBuffOverlay:IsNull() then
      self.goGMBuffOverlay:SetActive(false)
    end
    if self.gmOverlayTimer ~= nil then
      self.gmOverlayTimer:Pause(true)
    end
  end
end

local GM_OVERLAY_COL_MAX = 4

local function GetGMOverlayFont(trParent)
  local srcTxt = trParent:GetComponentInChildren(typeof(CS.UnityEngine.UI.Text))
  if srcTxt ~= nil and srcTxt.font ~= nil then
    return srcTxt.font
  end
  local ok, builtinFont = pcall(function()
    return CS.UnityEngine.Resources.GetBuiltinResource(typeof(CS.UnityEngine.Font), "LegacyRuntime.ttf")
  end)
  if ok then
    return builtinFont
  end
  return nil
end

local function CreateGMOverlayText(goParent, sName, font)
  local go = CS.UnityEngine.GameObject(sName, typeof(CS.UnityEngine.RectTransform))
  go.layer = goParent.layer
  go.transform:SetParent(goParent.transform, false)
  local txt = go:AddComponent(typeof(CS.UnityEngine.UI.Text))
  txt.fontSize = 22
  txt.color = CS.UnityEngine.Color.black
  txt.alignment = CS.UnityEngine.TextAnchor.UpperLeft
  txt.horizontalOverflow = CS.UnityEngine.HorizontalWrapMode.Overflow
  txt.verticalOverflow = CS.UnityEngine.VerticalWrapMode.Overflow
  txt.raycastTarget = false
  if font ~= nil then
    txt.font = font
  end
  return txt
end

local function StretchGMOverlayText(txt, nAnchorMinX, nAnchorMaxX)
  local rt = txt:GetComponent("RectTransform")
  rt.anchorMin = Vector2(nAnchorMinX, 0)
  rt.anchorMax = Vector2(nAnchorMaxX, 1)
  rt.pivot = Vector2(0.5, 1)
  rt.offsetMin = Vector2(8, 0)
  rt.offsetMax = Vector2(-8, 0)
end

function MathParkourCtrl:EnsureGMBuffOverlay()
  if self.goGMBuffOverlay ~= nil and not self.goGMBuffOverlay:IsNull() and self.txtGMBuffOverlayRight ~= nil then
    self.goGMBuffOverlay:SetActive(true)
    return
  end
  if self.goGMBuffOverlay ~= nil and not self.goGMBuffOverlay:IsNull() then
    destroy(self.goGMBuffOverlay)
  end
  local parent = self._mapNode.canvasGroup.transform
  local go = CS.UnityEngine.GameObject("GMBuffOverlay", typeof(CS.UnityEngine.RectTransform))
  go.layer = parent.gameObject.layer
  go.transform:SetParent(parent, false)
  local rt = go:GetComponent("RectTransform")
  rt.anchorMin = Vector2(0.5, 0.5)
  rt.anchorMax = Vector2(0.5, 0.5)
  rt.pivot = Vector2(0.5, 1)
  rt.anchoredPosition = Vector2(0, -90)
  rt.sizeDelta = Vector2(560, 180)
  local font = GetGMOverlayFont(parent)
  local txtLeft = CreateGMOverlayText(go, "txtLeft", font)
  local txtRight = CreateGMOverlayText(go, "txtRight", font)
  StretchGMOverlayText(txtLeft, 0, 1)
  StretchGMOverlayText(txtRight, 0.5, 1)
  txtRight.gameObject:SetActive(false)
  self.goGMBuffOverlay = go
  self.txtGMBuffOverlay = txtLeft
  self.txtGMBuffOverlayRight = txtRight
end

function MathParkourCtrl:RefreshGMBuffOverlay()
  if self.txtGMBuffOverlay == nil then
    return
  end
  local tbLines = {}
  for nBuffId, buffCtrl in pairs(self.tbUsedBuffItem) do
    local buffCfg = ConfigTable.GetData("MathParkourBuffItem", nBuffId)
    local sName = buffCfg ~= nil and buffCfg.Name or tostring(nBuffId)
    local nTime = buffCtrl.nCurTime or 0
    table.insert(tbLines, {
      nId = nBuffId,
      sText = string.format("%s  %02d:%02d", sName, math.floor(nTime / 60), nTime % 60)
    })
  end
  table.sort(tbLines, function(a, b)
    return a.nId < b.nId
  end)
  
  local function JoinLines(nFrom, nTo)
    local s = "当前效果:\n"
    if nTo < nFrom then
      return s .. "(无)"
    end
    for i = nFrom, nTo do
      s = s .. tbLines[i].sText .. "\n"
    end
    return s
  end
  
  local nCount = #tbLines
  local bTwoCol = nCount > GM_OVERLAY_COL_MAX
  if not bTwoCol then
    StretchGMOverlayText(self.txtGMBuffOverlay, 0, 1)
    self.txtGMBuffOverlay.alignment = CS.UnityEngine.TextAnchor.UpperCenter
    NovaAPI.SetText(self.txtGMBuffOverlay, JoinLines(1, nCount))
    if self.txtGMBuffOverlayRight ~= nil then
      self.txtGMBuffOverlayRight.gameObject:SetActive(false)
    end
    return
  end
  local nLeft = math.ceil(nCount / 2)
  StretchGMOverlayText(self.txtGMBuffOverlay, 0, 0.5)
  self.txtGMBuffOverlay.alignment = CS.UnityEngine.TextAnchor.UpperLeft
  NovaAPI.SetText(self.txtGMBuffOverlay, JoinLines(1, nLeft))
  self.txtGMBuffOverlayRight.gameObject:SetActive(true)
  self.txtGMBuffOverlayRight.alignment = CS.UnityEngine.TextAnchor.UpperLeft
  local sRight = ""
  for i = nLeft + 1, nCount do
    sRight = sRight .. tbLines[i].sText .. "\n"
  end
  NovaAPI.SetText(self.txtGMBuffOverlayRight, "\n" .. sRight)
end

function MathParkourCtrl:ClearGMBuffOverlay()
  self.bGMBuffOverlay = false
  if self.gmOverlayTimer ~= nil then
    self.gmOverlayTimer:Cancel()
    self.gmOverlayTimer = nil
  end
  if self.goGMBuffOverlay ~= nil and not self.goGMBuffOverlay:IsNull() then
    destroy(self.goGMBuffOverlay)
  end
  self.goGMBuffOverlay = nil
  self.txtGMBuffOverlay = nil
  self.txtGMBuffOverlayRight = nil
end

return MathParkourCtrl

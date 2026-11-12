local Avg_7_PersonalityChoiceCtrl = class("Avg_7_PersonalityChoiceCtrl", BaseCtrl)
local AvgData = PlayerData.Avg
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResType = GameResourceLoader.ResType
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
Avg_7_PersonalityChoiceCtrl._mapNodeConfig = {
  goBlurBg = {sNodeName = "imgBlurBg"},
  cgBgRole = {
    sNodeName = "----bg_role----",
    sComponentName = "CanvasGroup"
  },
  animBgRole = {
    sNodeName = "----bg_role----",
    sComponentName = "Animator"
  },
  imgDB = {sComponentName = "Image"},
  rtMainRole = {
    sNodeName = "goMainRole",
    sComponentName = "RectTransform"
  },
  rtBody = {
    sNodeName = "body",
    sComponentName = "RectTransform"
  },
  body = {sComponentName = "Image"},
  face = {sComponentName = "Image"},
  rtEmoji = {
    sComponentName = "RectTransform"
  },
  rtImgThink = {
    sNodeName = "img_think_",
    sComponentName = "RectTransform"
  },
  tmpOS = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  rtTMPOS = {
    sNodeName = "tmpOS",
    sComponentName = "RectTransform"
  },
  trCard = {
    sNodeName = "----card----",
    sComponentName = "Transform"
  },
  btnConfirm = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Choice"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "Avg_Btn_Select"
  },
  rtBtnConfirm = {
    sNodeName = "btnConfirm",
    sComponentName = "RectTransform"
  }
}
Avg_7_PersonalityChoiceCtrl._mapEventConfig = {
  GamepadUIChange = "OnEvent_GamepadUIChange",
  [EventId.AvgSpeedUp] = "OnEvent_AvgSpeedUp"
}

function Avg_7_PersonalityChoiceCtrl:Awake()
  self.tbGoChoice = {}
  self.tbBtnChoice = {}
  self.tbSelectHandler = {}
  self.tbCgChoice = {}
  self.tbAnimChoice = {}
  self.tbAnimChoiceLittleBody = {}
  self.tbTMP_Title = {}
  self.tbTMP_Content = {}
  self.tbImgBright = {}
  self.tbGoChoosed = {}
  self.tbTMP_Choosed = {}
  self.btnConfirmPosY = self._mapNode.rtBtnConfirm.localPosition.y
  for i = 1, 3 do
    local trRoot = self._mapNode.trCard:GetChild(i - 1)
    local tr = trRoot:Find("Choice_1")
    self.tbGoChoice[i] = trRoot.gameObject
    self.tbBtnChoice[i] = tr:GetComponent("NaviButton")
    
    local function func_Handler(...)
      local ui_func = ui_handler(self, self.OnBtnSelect_Choice, self.tbBtnChoice[i], i)
      ui_func(...)
    end
    
    self.tbSelectHandler[i] = func_Handler
    self.tbBtnChoice[i].onSelect:AddListener(func_Handler)
    GamepadUIManager.AddGamepadUINode("AVG", {
      {
        mapNode = self.tbBtnChoice[i],
        sComponentName = "NaviButton"
      }
    })
    self.tbCgChoice[i] = tr:GetComponent("CanvasGroup")
    self.tbAnimChoice[i] = tr:GetComponent("Animator")
    self.tbAnimChoiceLittleBody[i] = tr:GetChild(0):GetChild(0):GetComponent("Animator")
    self.tbTMP_Title[i] = tr:Find("goDefault_1/tmpTitle_1"):GetComponent("RubyTextMeshProUGUI")
    self.tbTMP_Content[i] = tr:Find("goDefault_1/tmpContent_1"):GetComponent("RubyTextMeshProUGUI")
    self.tbImgBright[i] = tr:Find("imgBright_1"):GetComponent("Image")
    self.tbGoChoosed[i] = tr:Find("goDefault_1/goChoosed_1").gameObject
    self.tbTMP_Choosed[i] = tr:Find("goDefault_1/goChoosed_1/tmpChoosed_1"):GetComponent("RubyTextMeshProUGUI")
  end
  self.tbActionContent = {}
  self.tbLogData = {}
end

function Avg_7_PersonalityChoiceCtrl:OnEnable()
  self:AddGamepadUINode()
end

function Avg_7_PersonalityChoiceCtrl:OnDisable()
  for i = 1, 3 do
    self.tbBtnChoice[i].onSelect:RemoveListener(self.tbSelectHandler[i])
  end
  self.tbGoChoice = nil
  self.tbBtnChoice = nil
  self.tbSelectHandler = nil
  self.tbCgChoice = nil
  self.tbAnimChoice = nil
  self.tbTMP_Title = nil
  self.tbTMP_Content = nil
  self.tbImgBright = nil
  self.tbGoChoosed = nil
  self.tbTMP_Choosed = nil
end

function Avg_7_PersonalityChoiceCtrl:LoadPresetEmoji()
  if self.tbHoldEmoji == nil then
    self.tbHoldEmoji = {}
    for _, v in ipairs(self._panel.tbAvgPreset.CharEmoji) do
      local sEmojiName = v[3]
      local bIsLoop = v[5]
      if bIsLoop == true then
        table.insert(self.tbHoldEmoji, sEmojiName)
      end
    end
  end
end

function Avg_7_PersonalityChoiceCtrl:_SetEmoji(sEmoji, sBody, bPlaySound)
  self:LoadPresetEmoji()
  if bPlaySound == nil then
    bPlaySound = true
  end
  if sEmoji ~= nil and sEmoji ~= "none" then
    if sEmoji == "close" then
      if self.goEmojiIns ~= nil then
        local animator = self.goEmojiIns:GetComponent("Animator")
        if animator ~= nil then
          animator:SetTrigger("tOut")
          NovaAPI.SetAnimatorSpeed(animator, self._panel.nSpeedRate or 1)
        end
      end
    else
      delChildren(self._mapNode.rtEmoji)
      local sFullPath = string.format("UI/Avg/AnimEmoji/%s.prefab", sEmoji)
      self.goEmojiIns = self:CreatePrefabInstance(sFullPath, self._mapNode.rtEmoji)
      local animator = self.goEmojiIns:GetComponent("Animator")
      if animator ~= nil then
        animator:SetTrigger("tIn")
        NovaAPI.SetAnimatorSpeed(animator, self._panel.nSpeedRate or 1)
      end
      local sMainRoleAvgCharId = "avg3_100"
      sMainRoleAvgCharId = AdjustMainRoleAvgCharId(sMainRoleAvgCharId)
      local v3OffSetPosEmoji, v3OffsetScaleEmoji = self:GetAvgPortraitEmojiOffsetData(sMainRoleAvgCharId, sBody, self._panel:GetCharEmojiIndex(sEmoji))
      self._mapNode.rtEmoji.anchoredPosition3D = v3OffSetPosEmoji
      self._mapNode.rtEmoji.localScale = v3OffsetScaleEmoji
      if bPlaySound == true then
        self._panel:PlayCharEmojiSound(sEmoji)
      end
      if table.indexof(self.tbHoldEmoji, sEmoji) <= 0 then
        self:AddTimer(1, 5, "_delayHideUnloopEmoji", true, true, true, self.goEmojiIns)
      end
    end
  end
end

function Avg_7_PersonalityChoiceCtrl:_delayHideUnloopEmoji(timer)
  if self.goEmojiIns ~= nil and self.goEmojiIns:IsNull() == false then
    self.goEmojiIns:SetActive(false)
  end
end

function Avg_7_PersonalityChoiceCtrl:_MoveConfirmButton(nIndex)
  local rtBtn = self.tbGoChoice[nIndex]:GetComponent("RectTransform")
  self._mapNode.rtBtnConfirm.localPosition = Vector3(rtBtn.localPosition.x, self.btnConfirmPosY, 0)
  if self._mapNode.btnConfirm.gameObject.activeSelf == false then
    self._mapNode.btnConfirm.gameObject:SetActive(true)
  else
    local animCtrl = self._mapNode.btnConfirm.transform:Find("AnimRoot"):GetComponent("Animator")
    animCtrl:Play("btnConfirm_in", 0, 0)
  end
end

function Avg_7_PersonalityChoiceCtrl:OnEvent_AvgSpeedUp(nRate)
  if self:GetPanelId() ~= PanelId.AvgST then
    return
  end
  self:OnEvent_AvgSpeedUp_Timer(nRate)
  NovaAPI.SetAnimatorSpeed(self._mapNode.animBgRole, nRate)
  for index, value in ipairs(self.tbAnimChoice) do
    NovaAPI.SetAnimatorSpeed(value, nRate)
  end
  for index, value in ipairs(self.tbAnimChoiceLittleBody) do
    NovaAPI.SetAnimatorSpeed(value, nRate)
  end
end

function Avg_7_PersonalityChoiceCtrl:SetPersonalityChoice(tbParam)
  local AvgUIText = require(GetAvgLuaRequireRoot(self._panel.nCurLanguageIdx) .. "Preset/AvgUIText")
  EventManager.Hit(EventId.AvgResetSpeed, true)
  EventManager.Hit(EventId.AvgAllMenuBtnEnable, false)
  self.nCurGroupId = tbParam[1]
  self.nFactor = tbParam[2]
  self.tbActionContent[1] = tbParam[3]
  self.tbActionContent[2] = tbParam[4]
  self.tbActionContent[3] = tbParam[5]
  local sBody = tbParam[6]
  local sFace = tbParam[7]
  local sEmoji = tbParam[8]
  local sContent = tbParam[9]
  local sVoice = tbParam[10]
  if self._panel.bIsPlayerMale == true then
    if tbParam[11] ~= nil and tbParam[11] ~= "" and tbParam[12] ~= nil and tbParam[12] ~= "" and tbParam[13] ~= nil and tbParam[13] ~= "" then
      self.tbActionContent[1] = tbParam[11]
      self.tbActionContent[2] = tbParam[12]
      self.tbActionContent[3] = tbParam[13]
    end
    if tbParam[14] ~= nil and tbParam[14] ~= "" then
      sContent = tbParam[14]
    end
  end
  local nLanguageIndex = self._panel.nCurLanguageIdx
  self:ResetGamepadUI()
  local nHistoryChoosed = AvgData:GetHistoryChoosedPersonality(self._panel.sAvgId, self.nCurGroupId)
  local mapCfgData_RolePersonality = ConfigTable.GetData("StoryRolePersonality", 1)
  if mapCfgData_RolePersonality == nil then
    printError("StoryRolePersonality 表中未找到主角数据")
    return -1
  end
  local tbPersonalitys = mapCfgData_RolePersonality.Personalitys
  if type(tbPersonalitys) ~= "table" then
    printError("StoryRolePersonality 表中主角拥有的三个性格数据有误")
    return -1
  end
  if #tbPersonalitys ~= 3 then
    printError("StoryRolePersonality 表中主角的性格数量不为3")
    return -1
  end
  self._color = {}
  NovaAPI.SetImageColor(self._mapNode.imgDB, Color.white)
  for i = 1, 3 do
    local nPID = tbPersonalitys[i]
    local mapCfgData_Personality = ConfigTable.GetData("StoryPersonality", nPID)
    if mapCfgData_Personality == nil then
      printError("StoryPersonality 表中未找到数据 id:" .. nPID)
      return -1
    end
    self._color[i] = mapCfgData_Personality.Color
    local spBg = self:GetPngSprite(mapCfgData_Personality.Db)
    NovaAPI.SetCanvasGroupBlocksRaycasts(self.tbCgChoice[i], true)
    NovaAPI.SetCanvasGroupInteractable(self.tbCgChoice[i], true)
    NovaAPI.SetText_RubyTMP(self.tbTMP_Title[i], mapCfgData_Personality.Name)
    NovaAPI.SetText_RubyTMP(self.tbTMP_Content[i], ProcAvgTextContent(self.tbActionContent[i], nLanguageIndex))
    NovaAPI.SetImageSpriteAsset(self.tbImgBright[i], spBg)
    self.tbGoChoosed[i]:SetActive(i == nHistoryChoosed)
    NovaAPI.SetText_RubyTMP(self.tbTMP_Choosed[i], AvgUIText.AVG_PersonalityChoice_Choosed)
    self.tbAnimChoiceLittleBody[i]:Play("personality_" .. tostring(i) .. "_idle")
  end
  local sMainRoleAvgCharId = "avg3_100"
  sMainRoleAvgCharId = AdjustMainRoleAvgCharId(sMainRoleAvgCharId)
  local spBody, spFace, v3OffsetPos, v3OffsetScale = self:GetAvgPortrait(sMainRoleAvgCharId, sBody, sFace)
  NovaAPI.SetImageSpriteAsset(self._mapNode.body, spBody)
  NovaAPI.SetImageSpriteAsset(self._mapNode.face, spFace)
  self._mapNode.rtBody.anchoredPosition3D = v3OffsetPos
  self._mapNode.rtBody.localScale = v3OffsetScale
  local tbRoleRootOffset = {
    avg3_100 = {
      870,
      -580,
      1
    },
    avg3_101 = {
      870,
      -580,
      1
    }
  }
  local data = tbRoleRootOffset[sMainRoleAvgCharId]
  self._mapNode.rtMainRole.anchoredPosition = Vector2(data[1], data[2])
  self._mapNode.rtMainRole.localScale = Vector3(data[3], data[3], data[3])
  self:_SetEmoji(sEmoji, sBody, true)
  NovaAPI.SetText_RubyTMP(self._mapNode.tmpOS, ProcAvgTextContent(sContent, nLanguageIndex))
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtTMPOS)
  local nW = self._mapNode.rtTMPOS.rect.width + 106
  if nW < 153 then
    nW = 153
  end
  self._mapNode.rtImgThink.sizeDelta = Vector2(nW, 139)
  if type(sVoice) ~= "string" or sVoice ~= "" then
  end
  self._mapNode.goBlurBg:SetActive(true)
  self:AddTimer(1, 0.05, "_delayVisible", true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 1)
  self.nChosenIdx = 0
  local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.animBgRole, {
    "animMajor_In"
  })
  self:AddTimer(1, nAnimLen + 0.3, "SelectUI", true, true, true)
  NovaAPI.SetScreenSleepTimeout(false)
  return -1
end

function Avg_7_PersonalityChoiceCtrl:_delayVisible()
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgBgRole, 1)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgBgRole, true)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.cgBgRole, true)
  self._mapNode.animBgRole:Play("animMajor_In")
  local sequence = DOTween.Sequence()
  sequence:AppendInterval(0.1)
  sequence:AppendCallback(dotween_callback_handler(self, self._ChoiceInAnim, 1))
  sequence:AppendInterval(0.1)
  sequence:AppendCallback(dotween_callback_handler(self, self._ChoiceInAnim, 2))
  sequence:AppendInterval(0.1)
  sequence:AppendCallback(dotween_callback_handler(self, self._ChoiceInAnim, 3))
  sequence:SetUpdate(true)
end

function Avg_7_PersonalityChoiceCtrl:_ChoiceInAnim(n)
  self.tbAnimChoice[n]:Play("animMajorChoice_In2")
end

function Avg_7_PersonalityChoiceCtrl:SetPersonalityChoiceJumpTo(tbParam)
  EventManager.Hit(EventId.AvgResetSpeed, false)
  EventManager.Hit(EventId.AvgAllMenuBtnEnable, true)
  AvgData:MarkChoosedPersonality(self._panel.sAvgId, tbParam[1], tbParam[2], self.nFactor)
  EventManager.Hit("AvgCheckAutoOnOff")
  return 0
end

function Avg_7_PersonalityChoiceCtrl:SetPersonalityChoiceRollover(tbParam)
  self._panel:SetPersonalityChoiceRollover(tbParam[1])
  return 0
end

function Avg_7_PersonalityChoiceCtrl:SetPersonalityChoiceEnd(tbParam)
  return 0
end

function Avg_7_PersonalityChoiceCtrl:OnBtnClick_Choice(btn)
  if self.nChosenIdx > 0 then
    self:ClearSelect()
    self._mapNode.btnConfirm.gameObject:SetActive(false)
    WwiseAudioMgr:PlaySound("ui_avg_choice_confirm")
    WwiseAudioMgr:PlaySound("ui_avg_card_flyby")
    self:_SetEmoji("close")
    self._mapNode.animBgRole:Play("animMajor_Out")
    local sChoiceAnim = ""
    for i = 1, 3 do
      NovaAPI.SetCanvasGroupBlocksRaycasts(self.tbCgChoice[i], false)
      NovaAPI.SetCanvasGroupInteractable(self.tbCgChoice[i], false)
      if i == self.nChosenIdx then
        sChoiceAnim = "animMajorChoice_SetOut_" .. tostring(i)
      else
        sChoiceAnim = "animMajorChoice_UnsetOut"
      end
      self.tbAnimChoice[i]:Play(sChoiceAnim)
    end
    self.tbLogData.nType = AllEnum.AvgLogType.Choice
    self.tbLogData.sAvgId = nil
    self.tbLogData.sContent = ProcAvgTextContent(self.tbActionContent[self.nChosenIdx], self._panel.nCurLanguageIdx)
    self.tbLogData.sVoice = nil
    EventManager.Hit(EventId.AvgMarkLog, self.tbLogData)
    EventManager.Hit(EventId.TemporaryBlockInput, 1.3)
    self:AddTimer(1, 1.3, "_DoClickChoice", true, true, true)
  end
end

function Avg_7_PersonalityChoiceCtrl:OnBtnSelect_Choice(btn, nIndex)
  if self.nChosenIdx == nIndex then
    return
  end
  WwiseAudioMgr:PlaySound("ui_avg_choice_slide")
  self:_MoveConfirmButton(nIndex)
  local sColor = self._color[nIndex]
  local _b, _color = ColorUtility.TryParseHtmlString(sColor)
  NovaAPI.SetImageColor(self._mapNode.imgDB, _color)
  if self.nChosenIdx > 0 then
    self.tbAnimChoice[self.nChosenIdx]:Play("animMajorChoice_PickDown")
    self.tbAnimChoiceLittleBody[self.nChosenIdx]:Play("personality_" .. tostring(self.nChosenIdx) .. "_idle")
  end
  self.tbAnimChoice[nIndex]:Play("animMajorChoice_PickUp")
  self.tbAnimChoiceLittleBody[nIndex]:Play("personality_" .. tostring(nIndex) .. "_show")
  self.nChosenIdx = nIndex
  EventManager.Hit(EventId.TemporaryBlockInput, 0.4)
end

function Avg_7_PersonalityChoiceCtrl:_DoClickChoice()
  if self:GetPanelId() == PanelId.AvgST then
    self._mapNode.goBlurBg:SetActive(false)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgBgRole, 0)
    NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgBgRole, false)
    NovaAPI.SetCanvasGroupInteractable(self._mapNode.cgBgRole, false)
    self._panel:SetPersonalityChoiceJumpTo(self.nCurGroupId, self.nChosenIdx)
  end
end

function Avg_7_PersonalityChoiceCtrl:AddGamepadUINode()
  GamepadUIManager.AddGamepadUINode("AVG", self:GetGamepadUINode())
end

function Avg_7_PersonalityChoiceCtrl:ResetGamepadUI()
  self._panel.sCurGamepadUI = "PersonalityChoice"
  GamepadUIManager.ClearSelectedUI()
  GamepadUIManager.SetNavigation(self.tbBtnChoice)
end

function Avg_7_PersonalityChoiceCtrl:SelectUI()
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType ~= AllEnum.GamepadUIType.Other then
    local nSelect = self.nChosenIdx ~= 0 and self.nChosenIdx or 1
    GamepadUIManager.SetSelectedUI(self.tbBtnChoice[nSelect].gameObject)
  end
end

function Avg_7_PersonalityChoiceCtrl:ClearSelect()
  GamepadUIManager.ClearSelectedUI()
  self._panel.sCurGamepadUI = nil
end

function Avg_7_PersonalityChoiceCtrl:OnEvent_GamepadUIChange(sName, nBeforeType, nAfterType)
  if sName ~= "AVG" or self._panel.sCurGamepadUI ~= "PersonalityChoice" then
    return
  end
  if nBeforeType == AllEnum.GamepadUIType.Other or nBeforeType == AllEnum.GamepadUIType.Mouse then
    self:SelectUI()
  end
end

return Avg_7_PersonalityChoiceCtrl

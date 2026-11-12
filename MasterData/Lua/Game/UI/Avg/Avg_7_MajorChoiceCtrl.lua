local Avg_7_MajorChoiceCtrl = class("Avg_7_MajorChoiceCtrl", BaseCtrl)
local AvgData = PlayerData.Avg
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResType = GameResourceLoader.ResType
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
Avg_7_MajorChoiceCtrl._mapNodeConfig = {
  cgBgRole = {
    sNodeName = "----bg_role----",
    sComponentName = "CanvasGroup"
  },
  cgRole = {
    sNodeName = "----role----",
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
  rtCard = {
    sNodeName = "----card----",
    sComponentName = "RectTransform"
  },
  btnConfirm = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_MajorChoice"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "Avg_Btn_Select"
  },
  rtBtnConfirm = {
    sNodeName = "btnConfirm",
    sComponentName = "RectTransform"
  },
  goTips = {
    sNodeName = "----tips----"
  },
  animTips = {
    sNodeName = "----tips----",
    sComponentName = "Animator"
  },
  txtTips = {sComponentName = "TMP_Text"},
  txtTips_ = {sComponentName = "TMP_Text"}
}
Avg_7_MajorChoiceCtrl._mapEventConfig = {
  GamepadUIChange = "OnEvent_GamepadUIChange",
  [EventId.AvgSpeedUp] = "OnEvent_AvgSpeedUp"
}

function Avg_7_MajorChoiceCtrl:Awake()
  self.tbGoChoice = {}
  self.tbImgChoice = {}
  self.tbBtnChoice = {}
  self.tbSelectHandler = {}
  self.tbAnimChoice = {}
  self.tbCgChoice = {}
  self.tbIcon = {}
  self.tbTMP_Title = {}
  self.tbTMP_Content = {}
  self.tbTMP_Label = {}
  self.tbImgBright = {}
  self.tbGoChoosedBE = {}
  self.tbGoChoosed = {}
  self.tbTMP_Choosed = {}
  self.tbGoUnknown = {}
  self.tbTMP_UnknownTitle = {}
  self.tbTMP_UnknownContent = {}
  self.btnConfirmPosY = self._mapNode.rtBtnConfirm.localPosition.y
  for i = 1, 3 do
    local trRoot = self._mapNode.trCard:GetChild(i - 1)
    local tr = trRoot:Find("Choice_1")
    self.tbGoChoice[i] = trRoot.gameObject
    self.tbImgChoice[i] = tr:Find("goDefault_1/choice_bg"):GetComponent("Image")
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
    self.tbAnimChoice[i] = tr:GetComponent("Animator")
    self.tbCgChoice[i] = tr:GetComponent("CanvasGroup")
    self.tbIcon[i] = tr:Find("goDefault_1/icon_1"):GetComponent("Image")
    self.tbTMP_Title[i] = tr:Find("goDefault_1/tmpTitle_1"):GetComponent("RubyTextMeshProUGUI")
    self.tbTMP_Content[i] = tr:Find("goDefault_1/tmpContent_1"):GetComponent("RubyTextMeshProUGUI")
    self.tbTMP_Label[i] = tr:Find("goDefault_1/tmpLabel_1"):GetComponent("RubyTextMeshProUGUI")
    self.tbImgBright[i] = tr:Find("goDefault_1/imgBright_1"):GetComponent("Image")
    self.tbGoChoosedBE[i] = tr:Find("goDefault_1/goChoosed_BE").gameObject
    self.tbGoChoosed[i] = tr:Find("goDefault_1/goChoosed_1").gameObject
    self.tbTMP_Choosed[i] = tr:Find("goDefault_1/goChoosed_1/tmpChoosed_1"):GetComponent("RubyTextMeshProUGUI")
    self.tbGoUnknown[i] = tr:Find("goDefault_1/goUnknown_1").gameObject
    self.tbTMP_UnknownTitle[i] = tr:Find("goDefault_1/goUnknown_1/tmpUnknownTitle_1"):GetComponent("RubyTextMeshProUGUI")
    self.tbTMP_UnknownContent[i] = tr:Find("goDefault_1/goUnknown_1/tmpUnknownContent_1"):GetComponent("RubyTextMeshProUGUI")
  end
  self._COLOR = {
    "#ffe3e3",
    "#fff6e5",
    "#d1ffe9",
    "#d8c9ff"
  }
  self.tbDesc = {}
  self.tbLogData = {}
end

function Avg_7_MajorChoiceCtrl:OnEnable()
  self:AddGamepadUINode()
end

function Avg_7_MajorChoiceCtrl:OnDisable()
  local n = #self.tbBtnChoice
  for i = 1, n do
    self.tbBtnChoice[i].onSelect:RemoveListener(self.tbSelectHandler[i])
  end
  self.tbGoChoice = nil
  self.tbImgChoice = nil
  self.tbBtnChoice = nil
  self.tbSelectHandler = nil
  self.tbAnimChoice = nil
  self.tbCgChoice = nil
  self.tbIcon = nil
  self.tbTMP_Title = nil
  self.tbTMP_Content = nil
  self.tbTMP_Label = nil
  self.tbImgBright = nil
  self.tbGoChoosed = nil
  self.tbTMP_Choosed = nil
  self.tbGoUnknown = nil
  self.tbTMP_UnknownTitle = nil
  self.tbTMP_UnknownContent = nil
end

function Avg_7_MajorChoiceCtrl:LoadPresetEmoji()
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

function Avg_7_MajorChoiceCtrl:_SetEmoji(sEmoji, sBody, bPlaySound)
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

function Avg_7_MajorChoiceCtrl:_delayHideUnloopEmoji(timer)
  if self.goEmojiIns ~= nil and self.goEmojiIns:IsNull() == false then
    self.goEmojiIns:SetActive(false)
  end
end

function Avg_7_MajorChoiceCtrl:_ChoiceInAnim(n, sAnimName)
  self.tbAnimChoice[n]:Play(sAnimName)
end

function Avg_7_MajorChoiceCtrl:_PlayTipsAnim(sAnimName, sTipsText)
  if type(sTipsText) == "string" and sTipsText ~= "" then
    NovaAPI.SetTMPText(self._mapNode.txtTips, sTipsText)
    NovaAPI.SetTMPText(self._mapNode.txtTips_, sTipsText)
  end
  self._mapNode.animTips:Play(sAnimName)
end

function Avg_7_MajorChoiceCtrl:_ForceClearAll()
  EventManager.Hit(EventId.AvgClearAllChar)
  EventManager.Hit(EventId.AvgClearStage)
  WwiseAudioMgr:WwiseVoice_StopInAVG()
  WwiseAudioMgr:PlaySound("avg_sfx_all_stop")
  self._panel:SetBGM({
    1,
    "",
    0,
    "",
    "1000ms",
    0,
    false
  })
  self._panel:SetBGM({
    1,
    "",
    1,
    "",
    "1000ms",
    0,
    false
  })
end

function Avg_7_MajorChoiceCtrl:_MoveConfirmButton(nIndex)
  local rtBtn = self.tbGoChoice[nIndex]:GetComponent("RectTransform")
  self._mapNode.rtBtnConfirm.localPosition = Vector3(rtBtn.localPosition.x, self.btnConfirmPosY, 0)
  if self._mapNode.btnConfirm.gameObject.activeSelf == false then
    self._mapNode.btnConfirm.gameObject:SetActive(true)
  else
    local animCtrl = self._mapNode.btnConfirm.transform:Find("AnimRoot"):GetComponent("Animator")
    animCtrl:Play("btnConfirm_in", 0, 0)
  end
end

function Avg_7_MajorChoiceCtrl:OnEvent_AvgSpeedUp(nRate)
  if self:GetPanelId() ~= PanelId.AvgST then
    return
  end
  self:OnEvent_AvgSpeedUp_Timer(nRate)
  NovaAPI.SetAnimatorSpeed(self._mapNode.animBgRole, nRate)
  for index, value in ipairs(self.tbAnimChoice) do
    NovaAPI.SetAnimatorSpeed(value, nRate)
  end
end

function Avg_7_MajorChoiceCtrl:SetMajorChoice(tbParam)
  local AvgUIText = require(GetAvgLuaRequireRoot(self._panel.nCurLanguageIdx) .. "Preset/AvgUIText")
  EventManager.Hit(EventId.AvgResetSpeed, true)
  EventManager.Hit(EventId.AvgAllMenuBtnEnable, false)
  EventManager.Hit(EventId.AvgClearTalk)
  self.nCurGroupId = tbParam[1]
  self.D_bExist = type(tbParam[28]) == "string" and tbParam[28] ~= ""
  self.D_bABC = true
  self.D_b1stAnim = false
  local nOffset = 1
  local _tbData = {}
  for m = 1, 7 do
    _tbData[m] = {}
    for n = 1, 4 do
      local nIdx = (n - 1) * 7 + m + nOffset
      if n == 4 then
        nIdx = m - 1 + 28
      end
      table.insert(_tbData[m], tbParam[nIdx] or "")
    end
  end
  local tbIcon = _tbData[1]
  local tbIconBg = _tbData[2]
  local tbTitle = _tbData[3]
  self.tbDesc = _tbData[4]
  local tbUnlockCondition = _tbData[5]
  self.tbEvId = _tbData[6]
  local tbType = _tbData[7]
  local sBody = tbParam[23]
  local sFace = tbParam[24]
  local sEmoji = tbParam[25]
  local sContent = tbParam[26]
  local sVoice = tbParam[27]
  self:ResetGamepadUI()
  local nLanguageIndex = self._panel.nCurLanguageIdx
  self._color = {}
  NovaAPI.SetImageColor(self._mapNode.imgDB, Color.white)
  local tbSelectBtnObj = {}
  for i = 1, 3 do
    local bIsUnlock = AvgData:IsUnlock(tbUnlockCondition[i])
    local bIsChosen, bIsChosen_Temp = AvgData:IsChosen(self._panel.sAvgId, self.nCurGroupId, i)
    self.D_bABC = self.D_bABC == true and bIsChosen == true
    local bDisableBE = false
    if tbType[i] == 1 and table.indexof(self._panel.tbBEIndex, i) > 0 then
      bDisableBE = true
    end
    local bDisable = tbType[i] == 2
    if tbIcon[i] == "" then
      self.tbGoChoice[i]:SetActive(false)
    else
      self.tbGoChoice[i]:SetActive(true)
      local nIconIndex = tbIconBg[i] + 1
      if bIsUnlock ~= true then
        nIconIndex = 0
      end
      local spBg = self:GetPngSprite("Icon/AvgChoice/db_avg_choice_" .. (bIsUnlock == true and "1" or "0"))
      NovaAPI.SetImageSpriteAsset(self.tbImgChoice[i], spBg)
      self._color[i] = self._COLOR[nIconIndex] or "#FFFFFF"
      self:SetPngSprite(self.tbIcon[i], Avg_ProcRes_M_F("Icon/AvgChoice/" .. tbIcon[i]))
      NovaAPI.SetText_RubyTMP(self.tbTMP_Title[i], ProcAvgTextContent(tbTitle[i], nLanguageIndex))
      NovaAPI.SetText_RubyTMP(self.tbTMP_Content[i], ProcAvgTextContent(self.tbDesc[i], nLanguageIndex))
      NovaAPI.SetText_RubyTMP(self.tbTMP_Label[i], string.format(AvgUIText.AVG_ImportantChoice, i))
      NovaAPI.SetImageSpriteAsset(self.tbImgBright[i], spBg)
      local v3Scale = bIsUnlock == true and Vector3.one or Vector3.zero
      self.tbIcon[i].transform.localScale = v3Scale
      self.tbTMP_Title[i].transform.localScale = v3Scale
      self.tbTMP_Content[i].transform.localScale = v3Scale
      self.tbTMP_Label[i].transform.localScale = v3Scale
      self.tbGoChoosed[i]:SetActive(bIsChosen == true)
      NovaAPI.SetText_RubyTMP(self.tbTMP_Choosed[i], AvgUIText.AVG_ImportantChoice_Choosed)
      local _b, _c = ColorUtility.TryParseHtmlString("#fafafa")
      NovaAPI.SetTMPColor(self.tbTMP_Choosed[i], _c)
      local bInteractable = bIsUnlock == true
      self.tbGoChoosedBE[i]:SetActive(false)
      if bDisableBE == true then
        bInteractable = false
        self.tbGoChoosed[i]:SetActive(true)
        self.tbGoChoosedBE[i]:SetActive(true)
        NovaAPI.SetText_RubyTMP(self.tbTMP_Choosed[i], AvgUIText.AVG_ImportantChoice_BE)
        _b, _c = ColorUtility.TryParseHtmlString("#cad3dd")
        NovaAPI.SetTMPColor(self.tbTMP_Choosed[i], _c)
      end
      if bDisable == true then
        bInteractable = false
        self.tbGoChoosed[i]:SetActive(true)
        self.tbGoChoosedBE[i]:SetActive(true)
        NovaAPI.SetText_RubyTMP(self.tbTMP_Choosed[i], AvgUIText.AVG_ImportantChoice_Disable)
        _b, _c = ColorUtility.TryParseHtmlString("#cad3dd")
        NovaAPI.SetTMPColor(self.tbTMP_Choosed[i], _c)
      end
      self.tbBtnChoice[i].interactable = bInteractable
      NovaAPI.SetCanvasGroupBlocksRaycasts(self.tbCgChoice[i], bInteractable)
      NovaAPI.SetCanvasGroupInteractable(self.tbCgChoice[i], bInteractable)
      if bInteractable == true then
        if not self.nFirstSelect then
          self.nFirstSelect = i
        end
        table.insert(tbSelectBtnObj, self.tbBtnChoice[i])
      end
      self.tbGoUnknown[i]:SetActive(bIsUnlock == false)
      NovaAPI.SetText_RubyTMP(self.tbTMP_UnknownTitle[i], AvgUIText.AVG_ImportantChoice_UnknownTitle)
      NovaAPI.SetText_RubyTMP(self.tbTMP_UnknownContent[i], AvgUIText.AVG_ImportantChoice_UnknownDesc)
    end
  end
  if ENABLE_D ~= nil then
    self.D_bABC = ENABLE_D
  end
  local bD = self.D_bExist == true and self.D_bABC == true and AvgData:IsUnlock(tbUnlockCondition[4]) == true
  if bD == true then
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgRole, 0)
    self._mapNode.rtCard.anchoredPosition = Vector2(0, -17.5)
    self._mapNode.rtCard.sizeDelta = Vector2(2160, 800)
    local goD = self._mapNode.trCard:Find("D").gameObject
    goD:SetActive(true)
    local D_bIsChosen, D_bIsChosen_Temp = AvgData:IsChosen(self._panel.sAvgId, self.nCurGroupId, 4)
    local trRoot = self._mapNode.trCard:GetChild(3)
    local tr = trRoot:Find("Choice_1")
    local cg = tr:GetComponent("CanvasGroup")
    NovaAPI.SetCanvasGroupBlocksRaycasts(cg, true)
    NovaAPI.SetCanvasGroupInteractable(cg, true)
    local imgIcon = tr:Find("goDefault_1/iconMask/icon_1"):GetComponent("Image")
    local TMP_Title = tr:Find("goDefault_1/tmpTitle_1"):GetComponent("RubyTextMeshProUGUI")
    local TMP_Content = tr:Find("goDefault_1/tmpContent_1"):GetComponent("RubyTextMeshProUGUI")
    local TMP_Label = tr:Find("goDefault_1/tmpLabel_1"):GetComponent("RubyTextMeshProUGUI")
    local GoChoosed = tr:Find("goDefault_1/goChoosed_1").gameObject
    local TMP_Choosed = tr:Find("goDefault_1/goChoosed_1/tmpChoosed_1"):GetComponent("RubyTextMeshProUGUI")
    self:SetPngSprite(imgIcon, Avg_ProcRes_M_F("Icon/AvgChoice/" .. tbIcon[4]))
    NovaAPI.SetText_RubyTMP(TMP_Title, ProcAvgTextContent(tbTitle[4], nLanguageIndex))
    NovaAPI.SetText_RubyTMP(TMP_Content, ProcAvgTextContent(self.tbDesc[4], nLanguageIndex))
    NovaAPI.SetText_RubyTMP(TMP_Label, string.format(AvgUIText.AVG_ImportantChoice, 4))
    GoChoosed:SetActive(D_bIsChosen == true)
    NovaAPI.SetText_RubyTMP(TMP_Choosed, AvgUIText.AVG_ImportantChoice_Choosed)
    self.D_b1stAnim = D_bIsChosen == false
    if ENABLE_D_CHOSED ~= nil then
      self.D_b1stAnim = ENABLE_D_CHOSED == false
    end
    local nIconIndex = tbIconBg[4] + 1
    self._color[4] = self._COLOR[nIconIndex] or "#FFFFFF"
    if self.tbGoChoice[4] == nil then
      self.tbGoChoice[4] = goD
      self.tbBtnChoice[4] = tr:GetComponent("NaviButton")
      
      local function func_Handler(...)
        local ui_func = ui_handler(self, self.OnBtnSelect_Choice, self.tbBtnChoice[4], 4)
        ui_func(...)
      end
      
      self.tbSelectHandler[4] = func_Handler
      self.tbBtnChoice[4].onSelect:AddListener(func_Handler)
      GamepadUIManager.AddGamepadUINode("AVG", {
        {
          mapNode = self.tbBtnChoice[4],
          sComponentName = "NaviButton"
        }
      })
      self.tbAnimChoice[4] = tr:GetComponent("Animator")
      self.tbCgChoice[4] = cg
    end
    table.insert(tbSelectBtnObj, self.tbBtnChoice[4])
  else
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgRole, 1)
    self._mapNode.rtCard.anchoredPosition = Vector2(-153, -17.5)
    self._mapNode.rtCard.sizeDelta = Vector2(1500, 800)
    self._mapNode.trCard:Find("D").gameObject:SetActive(false)
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
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgBgRole, 1)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgBgRole, true)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.cgBgRole, true)
  self._mapNode.animBgRole:Play("animMajor_In")
  local nAnimLen = 0
  local sequence = DOTween.Sequence()
  if bD == true then
    if self.D_b1stAnim == true then
      for i = 1, 3 do
        self.tbBtnChoice[i].interactable = false
        NovaAPI.SetCanvasGroupBlocksRaycasts(self.tbCgChoice[i], false)
        NovaAPI.SetCanvasGroupInteractable(self.tbCgChoice[i], false)
      end
      tbSelectBtnObj = {}
      table.insert(tbSelectBtnObj, self.tbBtnChoice[4])
      self.nFirstSelect = 4
      WwiseAudioMgr:PlaySound("ui_mainline_choose")
      sequence:AppendInterval(0.1)
      sequence:AppendCallback(dotween_callback_handler(self, self._ChoiceInAnim, 4, "animMajorChoice_InExD1"))
      sequence:AppendInterval(0.667)
      sequence:AppendCallback(dotween_callback_handler(self, self._ChoiceInAnim, 4, "animMajorChoice_InExD2"))
      sequence:AppendInterval(0.2)
      sequence:AppendCallback(dotween_callback_handler(self, self._ChoiceInAnim, 3, "animMajorChoice_InEx"))
      sequence:AppendInterval(0.1)
      sequence:AppendCallback(dotween_callback_handler(self, self._ChoiceInAnim, 2, "animMajorChoice_InEx"))
      sequence:AppendInterval(0.1)
      sequence:AppendCallback(dotween_callback_handler(self, self._ChoiceInAnim, 1, "animMajorChoice_InEx"))
      nAnimLen = 1.5
      self._mapNode.goTips:SetActive(true)
      local sequenceTips = DOTween.Sequence()
      sequenceTips:AppendInterval(0.1)
      sequenceTips:AppendCallback(dotween_callback_handler(self, self._PlayTipsAnim, "animMajorChoice_TitleIn", AvgUIText.AVG_ImportantChoice_NewChoiceTips1))
      sequenceTips:AppendInterval(0.733)
      sequenceTips:AppendCallback(dotween_callback_handler(self, self._PlayTipsAnim, "animMajorChoice_TitleOut_2", nil))
      sequenceTips:AppendInterval(0.083)
      sequenceTips:AppendCallback(dotween_callback_handler(self, self._PlayTipsAnim, "animMajorChoice_TitleIn_2", AvgUIText.AVG_ImportantChoice_NewChoiceTips2))
      sequenceTips:SetUpdate(true)
    else
      sequence:AppendInterval(0.1)
      sequence:AppendCallback(dotween_callback_handler(self, self._ChoiceInAnim, 1, "animMajorChoice_InEx"))
      sequence:AppendInterval(0.1)
      sequence:AppendCallback(dotween_callback_handler(self, self._ChoiceInAnim, 2, "animMajorChoice_InEx"))
      sequence:AppendInterval(0.1)
      sequence:AppendCallback(dotween_callback_handler(self, self._ChoiceInAnim, 3, "animMajorChoice_InEx"))
      sequence:AppendInterval(0.1)
      sequence:AppendCallback(dotween_callback_handler(self, self._ChoiceInAnim, 4, "animMajorChoice_InEx"))
      nAnimLen = 0.7
      self._mapNode.goTips:SetActive(false)
    end
  else
    sequence:AppendInterval(0.1)
    sequence:AppendCallback(dotween_callback_handler(self, self._ChoiceInAnim, 1, "animMajorChoice_In1"))
    sequence:AppendInterval(0.1)
    sequence:AppendCallback(dotween_callback_handler(self, self._ChoiceInAnim, 2, "animMajorChoice_In1"))
    sequence:AppendInterval(0.1)
    sequence:AppendCallback(dotween_callback_handler(self, self._ChoiceInAnim, 3, "animMajorChoice_In1"))
    nAnimLen = 1
    self._mapNode.goTips:SetActive(false)
  end
  sequence:AppendInterval(0.1)
  sequence:AppendCallback(dotween_callback_handler(self, self._ForceClearAll))
  sequence:SetUpdate(true)
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen + 0.2)
  GamepadUIManager.SetNavigation(tbSelectBtnObj)
  self.nChosenIdx = 0
  self:AddTimer(1, nAnimLen + 0.3, "SelectUI", true, true, true)
  NovaAPI.SetScreenSleepTimeout(false)
  return -1
end

function Avg_7_MajorChoiceCtrl:SetMajorChoiceJumpTo(tbParam)
  EventManager.Hit(EventId.AvgResetSpeed, false)
  EventManager.Hit(EventId.AvgAllMenuBtnEnable, true)
  local nIndex = tbParam[2]
  local sEvId = self.tbEvId[nIndex]
  if type(sEvId) == "string" and sEvId ~= "" then
    AvgData:MarkEvId(sEvId)
  end
  AvgData:MarkChosen(self._panel.sAvgId, tbParam[1], nIndex)
  EventManager.Hit("AvgCheckAutoOnOff")
  return 0
end

function Avg_7_MajorChoiceCtrl:SetMajorChoiceRollover(tbParam)
  self._panel:SetMajorChoiceRollover(tbParam[1])
  return 0
end

function Avg_7_MajorChoiceCtrl:SetMajorChoiceEnd(tbParam)
  return 0
end

function Avg_7_MajorChoiceCtrl:GetEvidence(tbParam)
  local sEvId = tbParam[1]
  if type(sEvId) == "string" and sEvId ~= "" then
    AvgData:MarkEvId(sEvId)
  end
  return 0
end

function Avg_7_MajorChoiceCtrl:OnBtnClick_MajorChoice(btn)
  if self.nChosenIdx > 0 then
    self:ClearSelect()
    self._mapNode.btnConfirm.gameObject:SetActive(false)
    local sAudioConfirm = "ui_avg_choice_confirm"
    local sAudioFade = "ui_avg_card_flyby"
    if self.D_bExist == true and self.D_bABC == true then
      sAudioConfirm = "ui_mainline_choose_click"
      sAudioFade = "ui_mainline_choose_over"
    end
    WwiseAudioMgr:PlaySound(sAudioConfirm)
    WwiseAudioMgr:PlaySound(sAudioFade)
    self:_SetEmoji("close")
    self._mapNode.animBgRole:Play("animMajor_Out")
    local sChoiceAnim = ""
    local nCount = #self.tbCgChoice
    for i = 1, nCount do
      NovaAPI.SetCanvasGroupBlocksRaycasts(self.tbCgChoice[i], false)
      NovaAPI.SetCanvasGroupInteractable(self.tbCgChoice[i], false)
      if i == self.nChosenIdx then
        if self.D_bExist == true and self.D_bABC == true then
          sChoiceAnim = "animMajorChoice_SetOutEx"
        else
          sChoiceAnim = "animMajorChoice_SetOut_" .. tostring(i)
        end
      else
        sChoiceAnim = "animMajorChoice_UnsetOut"
      end
      self.tbAnimChoice[i]:Play(sChoiceAnim)
    end
    self:_PlayTipsAnim("animMajorChoice_TitleOut", nil)
    self.tbLogData.nType = AllEnum.AvgLogType.Choice
    self.tbLogData.sAvgId = nil
    self.tbLogData.sContent = ProcAvgTextContent(self.tbDesc[self.nChosenIdx], self._panel.nCurLanguageIdx)
    self.tbLogData.sVoice = nil
    EventManager.Hit(EventId.AvgMarkLog, self.tbLogData)
    EventManager.Hit(EventId.TemporaryBlockInput, 1.3)
    self:AddTimer(1, 1.3, "_DoClickMajorChoice", true, true, true)
  end
end

function Avg_7_MajorChoiceCtrl:OnBtnSelect_Choice(btn, nIndex)
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
  end
  self.tbAnimChoice[nIndex]:Play("animMajorChoice_PickUp")
  self.nChosenIdx = nIndex
  EventManager.Hit(EventId.TemporaryBlockInput, 0.4)
end

function Avg_7_MajorChoiceCtrl:_DoClickMajorChoice()
  if self:GetPanelId() == PanelId.AvgST then
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgBgRole, 0)
    NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgBgRole, false)
    NovaAPI.SetCanvasGroupInteractable(self._mapNode.cgBgRole, false)
    self._panel:SetMajorChoiceJumpTo(self.nCurGroupId, self.nChosenIdx)
  end
end

function Avg_7_MajorChoiceCtrl:AddGamepadUINode()
  GamepadUIManager.AddGamepadUINode("AVG", self:GetGamepadUINode())
end

function Avg_7_MajorChoiceCtrl:ResetGamepadUI()
  self._panel.sCurGamepadUI = "MajorChoice"
  GamepadUIManager.ClearSelectedUI()
end

function Avg_7_MajorChoiceCtrl:SelectUI()
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType ~= AllEnum.GamepadUIType.Other then
    local nSelect = self.nChosenIdx ~= 0 and self.nChosenIdx or self.nFirstSelect
    if type(nSelect) == "number" then
      local btn = self.tbBtnChoice[nSelect]
      if btn ~= nil and btn.gameObject ~= nil then
        GamepadUIManager.SetSelectedUI(btn.gameObject)
      end
    end
  end
end

function Avg_7_MajorChoiceCtrl:ClearSelect()
  GamepadUIManager.ClearSelectedUI()
  self.nFirstSelect = nil
  self._panel.sCurGamepadUI = nil
end

function Avg_7_MajorChoiceCtrl:OnEvent_GamepadUIChange(sName, nBeforeType, nAfterType)
  if sName ~= "AVG" or self._panel.sCurGamepadUI ~= "MajorChoice" then
    return
  end
  if nBeforeType == AllEnum.GamepadUIType.Other or nBeforeType == AllEnum.GamepadUIType.Mouse then
    self:SelectUI()
  end
end

return Avg_7_MajorChoiceCtrl

local Avg_7_ChoiceCtrl = class("Avg_7_ChoiceCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
Avg_7_ChoiceCtrl._mapNodeConfig = {
  imgMask = {sComponentName = "Image"},
  canvasGroup = {
    sNodeName = "----root----",
    sComponentName = "CanvasGroup"
  },
  anim = {
    sNodeName = "----main_role_choice----",
    sComponentName = "Animator"
  },
  trMainRole = {sNodeName = "goMainRole", sComponentName = "Transform"},
  rubyTmp_Choice_OS = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  goM = {sNodeName = "--M--"},
  tbTMPLayout_M = {
    nCount = 4,
    sNodeName = "rubyTmp_Layout_M_",
    sComponentName = "RubyTextMeshProUGUI"
  },
  tbRT_M = {
    nCount = 4,
    sNodeName = "anim_root_M_",
    sComponentName = "RectTransform"
  },
  tbCG_M = {
    nCount = 4,
    sNodeName = "anim_root_M_",
    sComponentName = "CanvasGroup"
  },
  tbBtn_M = {
    nCount = 4,
    sNodeName = "btn_M_",
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Choice"
  },
  tbTMP_M = {
    nCount = 4,
    sNodeName = "rubyTmp_M_",
    sComponentName = "RubyTextMeshProUGUI"
  },
  goSelect_M = {
    nCount = 4,
    sNodeName = "goSelect_M_"
  },
  goR = {sNodeName = "--R--"},
  tbTMPLayout_R = {
    nCount = 4,
    sNodeName = "rubyTmp_Layout_R_",
    sComponentName = "RubyTextMeshProUGUI"
  },
  tbRT_R = {
    nCount = 4,
    sNodeName = "anim_root_R_",
    sComponentName = "RectTransform"
  },
  tbCG_R = {
    nCount = 4,
    sNodeName = "anim_root_R_",
    sComponentName = "CanvasGroup"
  },
  tbBtn_R = {
    nCount = 4,
    sNodeName = "btn_R_",
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Choice"
  },
  tbGoSelected_R = {
    nCount = 4,
    sNodeName = "goSelected_R_"
  },
  tbGoUnselected_R = {
    nCount = 4,
    sNodeName = "goUnselected_R_"
  },
  tbTMP_R = {
    nCount = 4,
    sNodeName = "rubyTmp_R_",
    sComponentName = "RubyTextMeshProUGUI"
  },
  goSelect_R = {
    nCount = 4,
    sNodeName = "goSelect_R_"
  },
  goL = {sNodeName = "--L--"},
  tbTMPLayout_L = {
    nCount = 4,
    sNodeName = "rubyTmp_Layout_L_",
    sComponentName = "RubyTextMeshProUGUI"
  },
  tbRT_L = {
    nCount = 4,
    sNodeName = "anim_root_L_",
    sComponentName = "RectTransform"
  },
  tbCG_L = {
    nCount = 4,
    sNodeName = "anim_root_L_",
    sComponentName = "CanvasGroup"
  },
  tbBtn_L = {
    nCount = 4,
    sNodeName = "btn_L_",
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Choice"
  },
  tbGoSelected_L = {
    nCount = 4,
    sNodeName = "goSelected_L_"
  },
  tbGoUnselected_L = {
    nCount = 4,
    sNodeName = "goUnselected_L_"
  },
  tbTMP_L = {
    nCount = 4,
    sNodeName = "rubyTmp_L_",
    sComponentName = "RubyTextMeshProUGUI"
  },
  goSelect_L = {
    nCount = 4,
    sNodeName = "goSelect_L_"
  }
}
Avg_7_ChoiceCtrl._mapEventConfig = {
  GamepadUIChange = "OnEvent_GamepadUIChange",
  [EventId.AvgSpeedUp] = "OnEvent_AvgSpeedUp"
}

function Avg_7_ChoiceCtrl:Awake()
  self.tbChoiceData = {}
  self.tbTotalChoiceCount = {}
  self.sCurChoiceGroupId = nil
  self.nType = nil
  NovaAPI.SetImageColor(self._mapNode.imgMask, Color(0, 0, 0, 0))
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvasGroup, false)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvasGroup, false)
  self._mapNode.canvasGroup.gameObject:SetActive(false)
  for i = 1, 4 do
    self._mapNode.tbTMPLayout_M[i].gameObject:SetActive(false)
    self._mapNode.tbTMPLayout_R[i].gameObject:SetActive(false)
    self._mapNode.tbTMPLayout_L[i].gameObject:SetActive(false)
  end
  self._mapNode.goM:SetActive(false)
  self._mapNode.goR:SetActive(false)
  self._mapNode.goL:SetActive(false)
  self.tbLogData = {}
end

function Avg_7_ChoiceCtrl:OnEnable()
  self:AddGamepadUINode()
  self:BindSelect()
end

function Avg_7_ChoiceCtrl:OnDisable()
  self:UnbindSelect()
end

function Avg_7_ChoiceCtrl:_SetMask(bVisible)
  NovaAPI.ImageDoFade(self._mapNode.imgMask, bVisible == true and 0.5 or 0, 0.2, true)
end

function Avg_7_ChoiceCtrl:_Set(nIndex, bVisible, bSelected, sContent, nExtraDelay)
  local tbTxtLayout, tbRT, tbCG, tbTxt
  if self.nType == 0 then
    tbTxtLayout = self._mapNode.tbTMPLayout_M
    tbRT = self._mapNode.tbRT_M
    tbCG = self._mapNode.tbCG_M
    tbTxt = self._mapNode.tbTMP_M
  elseif self.nType == 1 then
    tbTxtLayout = self._mapNode.tbTMPLayout_R
    tbRT = self._mapNode.tbRT_R
    tbCG = self._mapNode.tbCG_R
    tbTxt = self._mapNode.tbTMP_R
  elseif self.nType == 2 then
    tbTxtLayout = self._mapNode.tbTMPLayout_L
    tbRT = self._mapNode.tbRT_L
    tbCG = self._mapNode.tbCG_L
    tbTxt = self._mapNode.tbTMP_L
  end
  local txtLayout = tbTxtLayout[nIndex]
  local rt = tbRT[nIndex]
  local canvasGroup = tbCG[nIndex]
  local txt = tbTxt[nIndex]
  local goChoice = txtLayout.gameObject
  goChoice:SetActive(bVisible)
  self:SetSelectBtnObj(nIndex, bVisible, bSelected)
  if bVisible == false then
    return
  end
  NovaAPI.SetCanvasGroupAlpha(canvasGroup, 0)
  local nOffsetX = 0
  if self.nType == 2 then
    nOffsetX = -72 * (nIndex - 1)
  end
  rt.anchoredPosition = Vector2(500 + nOffsetX, 0)
  rt.localScale = Vector3(0.5, 0.5, 1)
  if self.nType == 1 then
    self._mapNode.tbGoSelected_R[nIndex]:SetActive(bSelected == true)
    self._mapNode.tbGoUnselected_R[nIndex]:SetActive(bSelected == false)
  elseif self.nType == 2 then
    self._mapNode.tbGoSelected_L[nIndex]:SetActive(bSelected == true)
    self._mapNode.tbGoUnselected_L[nIndex]:SetActive(bSelected == false)
  end
  local sColor = "#264278"
  if bSelected == true then
    sColor = "#6E8297"
  end
  NovaAPI.SetTextColor_RubyTMP(txt, sColor)
  sContent = ProcAvgTextContent(sContent, self._panel.nCurLanguageIdx)
  NovaAPI.SetText_RubyTMP(txtLayout, sContent)
  NovaAPI.SetText_RubyTMP(txt, sContent)
  local nDelay = nIndex * 0.03
  if nExtraDelay ~= nil then
    nDelay = nDelay + nExtraDelay
  end
  canvasGroup:DOFade(1, 0.2):SetUpdate(true):SetDelay(nDelay)
  rt:DOAnchorPosX(0 + nOffsetX, 0.2):SetUpdate(true):SetDelay(nDelay)
  local sequence = DOTween.Sequence()
  sequence:AppendInterval(nDelay)
  sequence:Append(rt:DOScale(1.03, 0.2):SetUpdate(true):SetEase(Ease.OutQuint))
  sequence:Append(rt:DOScale(0.99, 0.1):SetUpdate(true):SetEase(Ease.InCubic))
  sequence:Append(rt:DOScale(1, 0.1):SetUpdate(true))
  sequence:SetUpdate(true)
end

function Avg_7_ChoiceCtrl:OnBtnClick_Choice(uiBtn)
  self:ClearSelect()
  local nIndex
  if self.nType == 0 then
    nIndex = table.indexof(self._mapNode.tbBtn_M, uiBtn)
  elseif self.nType == 1 then
    nIndex = table.indexof(self._mapNode.tbBtn_R, uiBtn)
  elseif self.nType == 2 then
    nIndex = table.indexof(self._mapNode.tbBtn_L, uiBtn)
  end
  if nIndex == nil then
    return
  end
  if 0 >= table.indexof(self.tbChoiceData[self.sCurChoiceGroupId], nIndex) then
    table.insert(self.tbChoiceData[self.sCurChoiceGroupId], nIndex)
  end
  local tbTxtLayout, tbRT, tbCG, tbTxt
  if self.nType == 0 then
    tbTxtLayout = self._mapNode.tbTMPLayout_M
    tbRT = self._mapNode.tbRT_M
    tbCG = self._mapNode.tbCG_M
    tbTxt = self._mapNode.tbTMP_M
  elseif self.nType == 1 then
    tbTxtLayout = self._mapNode.tbTMPLayout_R
    tbRT = self._mapNode.tbRT_R
    tbCG = self._mapNode.tbCG_R
    tbTxt = self._mapNode.tbTMP_R
  elseif self.nType == 2 then
    tbTxtLayout = self._mapNode.tbTMPLayout_L
    tbRT = self._mapNode.tbRT_L
    tbCG = self._mapNode.tbCG_L
    tbTxt = self._mapNode.tbTMP_L
  end
  for i = 1, 4 do
    local goChoice = tbTxtLayout[i].gameObject
    local rt = tbRT[i]
    local canvasGroup = tbCG[i]
    if goChoice.activeSelf == true then
      if i == nIndex then
        canvasGroup:DOFade(0, 0.2):SetUpdate(true):SetDelay(0.2)
        rt:DOScale(1.1, 0.2):SetUpdate(true):SetDelay(0.1):SetEase(Ease.OutQuart)
      else
        canvasGroup:DOFade(0, 0.2):SetUpdate(true):SetDelay(0.1)
        rt:DOScale(0.3, 0.2):SetUpdate(true):SetDelay(0.1):SetEase(Ease.InQuart)
      end
    end
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvasGroup, false)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvasGroup, false)
  self:AddTimer(1, 0.4, "_RunNextCmd", true, true, true, nIndex)
  self:_SetMask(false)
  local sReplyContent = NovaAPI.GetText_RubyTMP(tbTxt[nIndex])
  if self.nType == 1 then
    EventManager.Hit(EventId.AvgChoiceToReplyPhoneMessage, sReplyContent)
  end
  if self.bShowMainRole == true then
    self._mapNode.anim:SetTrigger("tOut")
  end
  WwiseAudioMgr:PlaySound("ui_choice_click")
  self.tbLogData.nType = AllEnum.AvgLogType.Choice
  self.tbLogData.sAvgId = nil
  self.tbLogData.sContent = sReplyContent
  self.tbLogData.sVoice = nil
  EventManager.Hit(EventId.AvgMarkLog, self.tbLogData)
end

function Avg_7_ChoiceCtrl:_RunNextCmd(timer, nIndex)
  if self:GetPanelId() == PanelId.AvgST then
    if self.bShowMainRole == true then
      EventManager.Hit(EventId.AvgChoiceMainRoleOS_Out)
    end
    self.bShowMainRole = nil
    self._mapNode.canvasGroup.gameObject:SetActive(false)
    self._panel:SetChoiceJumpTo(self.sCurChoiceGroupId, nIndex)
  end
end

function Avg_7_ChoiceCtrl:OnEvent_AvgSpeedUp(nRate)
  if self:GetPanelId() ~= PanelId.AvgST then
    return
  end
  self:OnEvent_AvgSpeedUp_Timer(nRate)
  NovaAPI.SetAnimatorSpeed(self._mapNode.anim, nRate)
end

function Avg_7_ChoiceCtrl:SetChoiceBegin(tbParam)
  EventManager.Hit(EventId.AvgAllMenuBtnEnable, false)
  local sChoiceGroupId = tbParam[1]
  local bMaskVisible = tbParam[2] == 0
  local tbVisibleType = tbParam[3]
  local tbContent_CN_F = tbParam[4]
  local tbContent_CN_M = tbParam[11]
  local tbContent_JP_F = tbParam[13] or {}
  local tbContent_JP_M = tbParam[14] or {}
  local tbContent = {}
  local _sContent
  for i = 1, 4 do
    if self._panel.sTxtLan == AllEnum.Language.CN then
      _sContent = tbContent_CN_F[i]
      if self._panel.sVoLan == AllEnum.Language.JP and type(tbContent_JP_F[i]) == "string" and tbContent_JP_F[i] ~= "" then
        _sContent = tbContent_JP_F[i]
      end
      table.insert(tbContent, _sContent)
    else
      _sContent = tbContent_JP_F[i]
      if self._panel.bIsPlayerMale == true and type(tbContent_JP_M[i]) == "string" and tbContent_JP_M[i] ~= "" then
        _sContent = tbContent_JP_M[i]
      end
      if self._panel.sVoLan == AllEnum.Language.CN then
        if type(tbContent_CN_F[i]) == "string" and tbContent_CN_F[i] ~= "" then
          _sContent = tbContent_CN_F[i]
        end
        if self._panel.bIsPlayerMale == true and type(tbContent_CN_M[i]) == "string" and tbContent_CN_M[i] ~= "" then
          _sContent = tbContent_CN_M[i]
        end
      end
      table.insert(tbContent, _sContent)
    end
  end
  local nType = tbParam[5]
  self.bShowMainRole = tbParam[6] == 1
  local sBody = tbParam[7]
  local sFace = tbParam[8]
  local sEmoji = tbParam[9]
  local sContentOS = tbParam[10]
  self.sCurChoiceGroupId = sChoiceGroupId
  self.nType = nType
  self._mapNode.goM:SetActive(self.nType == 0)
  self._mapNode.goR:SetActive(self.nType == 1)
  self._mapNode.goL:SetActive(self.nType == 2)
  self:_SetMask(bMaskVisible)
  self._mapNode.canvasGroup.gameObject:SetActive(true)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvasGroup, true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvasGroup, true)
  self:ResetGamepadUI()
  if self.tbChoiceData[sChoiceGroupId] == nil then
    self.tbChoiceData[sChoiceGroupId] = {}
  end
  local tbData = self.tbChoiceData[sChoiceGroupId]
  local nBlockTime = 0.4
  local nChoiceCount = 0
  local nExtraDelay
  if self.bShowMainRole == true then
    nExtraDelay = 0.2
  end
  for i = 1, 4 do
    local bVisible = true
    local sContent = tbContent[i]
    if sContent == "" then
      bVisible = false
    else
      nChoiceCount = nChoiceCount + 1
      local _type = tbVisibleType[i]
      if _type == 0 then
        bVisible = true
      elseif _type == 1 then
        bVisible = 0 < table.indexof(tbData, i - 1)
      elseif _type == 2 then
        for j = 1, 4 do
          if j ~= i and 0 >= table.indexof(tbData, j) then
            bVisible = false
            break
          end
        end
      end
    end
    self:_Set(i, bVisible, 0 < table.indexof(tbData, i), sContent, nExtraDelay)
    if bVisible == true then
      nBlockTime = nBlockTime + 0.03
    end
  end
  GamepadUIManager.SetNavigation(self.tbSelectBtnObj, false)
  self:SelectChoiceBtn()
  self.tbTotalChoiceCount[sChoiceGroupId] = nChoiceCount
  EventManager.Hit(EventId.TemporaryBlockInput, nBlockTime)
  if self.bShowMainRole == true then
    sContentOS = ProcAvgTextContent(sContentOS, self._panel.nCurLanguageIdx)
    NovaAPI.SetText_RubyTMP(self._mapNode.rubyTmp_Choice_OS, sContentOS)
    EventManager.Hit(EventId.AvgChoiceMainRoleOS_In, self._mapNode.trMainRole, sBody, sFace, sEmoji)
    self._mapNode.anim:SetTrigger("tIn")
  end
  NovaAPI.SetScreenSleepTimeout(false)
  return -1
end

function Avg_7_ChoiceCtrl:SetChoiceJumpTo(tbParam)
  EventManager.Hit(EventId.AvgAllMenuBtnEnable, true)
  EventManager.Hit("AvgCheckAutoOnOff")
  return 0
end

function Avg_7_ChoiceCtrl:SetChoiceRollback(tbParam)
  local sGroupId = tbParam[1]
  local nRollBackType = tbParam[2]
  if nRollBackType == 1 then
    local tbData = self.tbChoiceData[sGroupId]
    if #tbData >= self.tbTotalChoiceCount[sGroupId] then
      self._panel:SetChoiceRollover(sGroupId)
    else
      self._panel:SetChoiceRollback(sGroupId)
    end
  else
    self._panel:SetChoiceRollback(sGroupId)
  end
  return 0
end

function Avg_7_ChoiceCtrl:SetChoiceRollover(tbParam)
  self._panel:SetChoiceRollover(tbParam[1])
  return 0
end

function Avg_7_ChoiceCtrl:SetChoiceEnd(tbParam)
  return 0
end

function Avg_7_ChoiceCtrl:RestoreAll(bActive)
  self.gameObject:SetActive(bActive)
end

function Avg_7_ChoiceCtrl:AddGamepadUINode()
  GamepadUIManager.AddGamepadUINode("AVG", self:GetGamepadUINode())
end

function Avg_7_ChoiceCtrl:BindSelect()
  self.handlerBtn_M, self.handlerBtn_R, self.handlerBtn_L = {}, {}, {}
  for k, v in ipairs(self._mapNode.tbBtn_M) do
    self.handlerBtn_M[k] = ui_handler(self, self.OnBtnSelect_Choice, v, k)
    v.onSelect:AddListener(self.handlerBtn_M[k])
  end
  for k, v in ipairs(self._mapNode.tbBtn_R) do
    self.handlerBtn_R[k] = ui_handler(self, self.OnBtnSelect_Choice, v, k)
    v.onSelect:AddListener(self.handlerBtn_R[k])
  end
  for k, v in ipairs(self._mapNode.tbBtn_L) do
    self.handlerBtn_L[k] = ui_handler(self, self.OnBtnSelect_Choice, v, k)
    v.onSelect:AddListener(self.handlerBtn_L[k])
  end
end

function Avg_7_ChoiceCtrl:UnbindSelect()
  for k, v in ipairs(self._mapNode.tbBtn_M) do
    v.onSelect:RemoveListener(self.handlerBtn_M[k])
  end
  for k, v in ipairs(self._mapNode.tbBtn_R) do
    v.onSelect:RemoveListener(self.handlerBtn_R[k])
  end
  for k, v in ipairs(self._mapNode.tbBtn_L) do
    v.onSelect:RemoveListener(self.handlerBtn_L[k])
  end
end

function Avg_7_ChoiceCtrl:GetSelectList()
  local tbSelect
  if self.nType == 0 then
    tbSelect = self._mapNode.goSelect_M
  elseif self.nType == 1 then
    tbSelect = self._mapNode.goSelect_R
  elseif self.nType == 2 then
    tbSelect = self._mapNode.goSelect_L
  end
  return tbSelect
end

function Avg_7_ChoiceCtrl:GetBtnList()
  local tbBtn
  if self.nType == 0 then
    tbBtn = self._mapNode.tbBtn_M
  elseif self.nType == 1 then
    tbBtn = self._mapNode.tbBtn_R
  elseif self.nType == 2 then
    tbBtn = self._mapNode.tbBtn_L
  end
  return tbBtn
end

function Avg_7_ChoiceCtrl:OnBtnSelect_Choice(btn, nIndex)
  if self.nSelectIndex == nIndex then
    return
  end
  local tbSelect = self:GetSelectList()
  for k, v in ipairs(tbSelect) do
    if k == nIndex then
      if GamepadUIManager.GetCurUIType() ~= AllEnum.GamepadUIType.Other and GamepadUIManager.GetCurUIType() ~= AllEnum.GamepadUIType.Mouse then
        v:SetActive(true)
      else
        v:SetActive(false)
      end
    elseif k == self.nSelectIndex then
      v:SetActive(false)
    end
  end
  self.nSelectIndex = nIndex
end

function Avg_7_ChoiceCtrl:SetSelectBtnObj(nIndex, bVisible, bSelected)
  if bVisible then
    if next(self.tbSelectBtnObj) == nil then
      self.nSelectIndex = nIndex
    end
    local tbBtn = self:GetBtnList()
    table.insert(self.tbSelectBtnObj, tbBtn[nIndex])
  end
end

function Avg_7_ChoiceCtrl:SelectChoiceBtn()
  local tbSelect = self:GetSelectList()
  local tbBtn = self:GetBtnList()
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType ~= AllEnum.GamepadUIType.Other and nUIType ~= AllEnum.GamepadUIType.Mouse then
    if self.nSelectIndex and self.nSelectIndex ~= 0 then
      tbSelect[self.nSelectIndex]:SetActive(true)
      GamepadUIManager.SetSelectedUI(tbBtn[self.nSelectIndex].gameObject)
    end
  else
    for k, _ in ipairs(tbBtn) do
      tbSelect[k]:SetActive(false)
    end
  end
end

function Avg_7_ChoiceCtrl:ResetGamepadUI()
  self._panel.sCurGamepadUI = "Choice"
  GamepadUIManager.ClearSelectedUI()
  self.tbSelectBtnObj = {}
  self.nSelectIndex = 0
  local tbSelect = self:GetSelectList()
  for _, v in ipairs(tbSelect) do
    v:SetActive(false)
  end
end

function Avg_7_ChoiceCtrl:ClearSelect()
  GamepadUIManager.ClearSelectedUI()
  self.nSelectIndex = 0
  self._panel.sCurGamepadUI = nil
end

function Avg_7_ChoiceCtrl:OnEvent_GamepadUIChange(sName, nBeforeType, nAfterType)
  if sName ~= "AVG" or self._panel.sCurGamepadUI ~= "Choice" then
    return
  end
  self:SelectChoiceBtn()
end

return Avg_7_ChoiceCtrl

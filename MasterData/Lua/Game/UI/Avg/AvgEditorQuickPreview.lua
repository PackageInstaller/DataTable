local AvgEditorQuickPreview = class("AvgEditorQuickPreview", BaseCtrl)
local PlayerBaseData = PlayerData.Base
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResType = GameResourceLoader.ResType
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local max_chat_width = 708
local max_choice_width = 650
local CONST_WIDTH = 340
local CONST_GRID_WIDTH = 1022.9
local DEFAULT_AUTOPLAY_MIN_TIME = 1
local DEFAULT_AUTOPLAY_MAX_TIME = 2.5
local choice_txt_diff = 22.06
local choice_img_diff = 20.22
local choice_selection_top = 26
local choice_selection_bottom = 28
local choice_selection_input = 116
local choice_selection_space = 12.5
local choice_head_offset = 15
local WwiseAudioManager = CS.WwiseAudioManager
AvgEditorQuickPreview._mapNodeConfig = {
  btnCloseQuickPreview = {
    sComponentName = "Button",
    callback = "CloseQuickPreview"
  },
  Avg_4_Talk = {},
  cgTalk = {
    sNodeName = "----Talk----",
    sComponentName = "CanvasGroup"
  },
  cgSayThink = {
    sNodeName = "----SayThink----",
    sComponentName = "CanvasGroup"
  },
  animSwitchSayThinkBg = {
    sNodeName = "----SayThink----",
    sComponentName = "Animator"
  },
  cgDialog_1L = {
    sNodeName = "----Dialog_1L----",
    sComponentName = "CanvasGroup"
  },
  cgDialog_1R = {
    sNodeName = "----Dialog_1R----",
    sComponentName = "CanvasGroup"
  },
  cgDialog_2L = {
    sNodeName = "----Dialog_2L----",
    sComponentName = "CanvasGroup"
  },
  cgDialog_2R = {
    sNodeName = "----Dialog_2R----",
    sComponentName = "CanvasGroup"
  },
  cgFilm = {
    sNodeName = "----Film----",
    sComponentName = "CanvasGroup"
  },
  cgCenter = {
    sNodeName = "----Center----",
    sComponentName = "CanvasGroup"
  },
  imgContentBg_Center = {},
  cgCGTalk = {
    sNodeName = "----CGTalk----",
    sComponentName = "CanvasGroup"
  },
  cgFullScreen = {
    sNodeName = "----FullScreen----",
    sComponentName = "CanvasGroup"
  },
  imgTalkNameBg = {sComponentName = "Image"},
  imgTalkNameBg_1L = {sComponentName = "Image"},
  imgTalkNameBg_1R = {sComponentName = "Image"},
  imgTalkNameBg_2L = {sComponentName = "Image"},
  imgTalkNameBg_2R = {sComponentName = "Image"},
  txtName_Talk = {sComponentName = "TMP_Text"},
  txtName_Dialog_1L = {sComponentName = "TMP_Text"},
  txtName_Dialog_1R = {sComponentName = "TMP_Text"},
  txtName_Dialog_2L = {sComponentName = "TMP_Text"},
  txtName_Dialog_2R = {sComponentName = "TMP_Text"},
  txtName_CGTalk = {sComponentName = "TMP_Text"},
  rubyTmp_Talk = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  rubyTmp_SayThink = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  rubyTmp_1L = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  rubyTmp_1R = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  rubyTmp_2L = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  rubyTmp_2R = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  rubyTmp_Film = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  rubyTmp_Center = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  rubyTmp_CGTalk = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  rubyTmp_FS = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  Avg_5_Phone = {},
  txtCalcHeight = {sComponentName = "TMP_Text"},
  rtCalcHeight = {
    sNodeName = "txtCalcHeight",
    sComponentName = "RectTransform"
  },
  layoutCalcHeight = {
    sNodeName = "txtCalcHeight",
    sComponentName = "LayoutElement"
  },
  txtMsgCalcHeight = {sComponentName = "TMP_Text"},
  rtMsgCalcHeight = {
    sNodeName = "txtMsgCalcHeight",
    sComponentName = "RectTransform"
  },
  Viewport_SV = {},
  animMainRole = {
    sNodeName = "----main_role----",
    sComponentName = "Animator"
  },
  rtMainRole = {
    sNodeName = "----main_role----",
    sComponentName = "RectTransform"
  },
  trMainRole = {sNodeName = "goMainRole", sComponentName = "Transform"},
  rtmp_os = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  goMask = {sNodeName = "imgMask", sComponentName = "GameObject"},
  sv = {
    sComponentName = "GamepadScroll"
  },
  goFixedHead = {sComponentName = "Transform"},
  Avg_6_Menu = {},
  txtStoryId = {sComponentName = "TMP_Text"},
  txtStoryTitle = {sComponentName = "TMP_Text"},
  rubyTmpContent = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  txtWindowTitle = {sComponentName = "TMP_Text"},
  txtBtnCancel = {nCount = 2, sComponentName = "TMP_Text"},
  txtBtnConfirm1_ = {nCount = 2, sComponentName = "TMP_Text"},
  txtSkipTips = {sComponentName = "TMP_Text"},
  Avg_7_Choice = {},
  cgMainRoleChoice = {
    sNodeName = "----main_role_choice----",
    sComponentName = "CanvasGroup"
  },
  rubyTmp_Choice_OS = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  goM = {sNodeName = "--M--"},
  tbTMPLayout_M = {
    nCount = 4,
    sNodeName = "rubyTmp_Layout_M_",
    sComponentName = "RubyTextMeshProUGUI"
  },
  tbTMP_M = {
    nCount = 4,
    sNodeName = "rubyTmp_M_",
    sComponentName = "RubyTextMeshProUGUI"
  },
  goR = {sNodeName = "--R--"},
  tbTMPLayout_R = {
    nCount = 4,
    sNodeName = "rubyTmp_Layout_R_",
    sComponentName = "RubyTextMeshProUGUI"
  },
  tbTMP_R = {
    nCount = 4,
    sNodeName = "rubyTmp_R_",
    sComponentName = "RubyTextMeshProUGUI"
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
  tbTMP_L = {
    nCount = 4,
    sNodeName = "rubyTmp_L_",
    sComponentName = "RubyTextMeshProUGUI"
  },
  tbGoSelect_M = {
    nCount = 4,
    sNodeName = "goSelect_M_"
  },
  tbGoSelect_R = {
    nCount = 4,
    sNodeName = "goSelect_R_"
  },
  tbGoSelect_L = {
    nCount = 4,
    sNodeName = "goSelect_L_"
  },
  AvgBubbleUI = {},
  cg1 = {
    sNodeName = "--Style_1--",
    sComponentName = "CanvasGroup"
  },
  TMP = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  rtTMP = {
    sNodeName = "TMP",
    sComponentName = "RectTransform"
  },
  LSV = {
    sComponentName = "LoopScrollView"
  },
  cg2 = {
    sNodeName = "--Style_2--",
    sComponentName = "CanvasGroup"
  },
  txtName = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  tmp_Content = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  cgContent = {
    sNodeName = "tmp_Content",
    sComponentName = "CanvasGroup"
  },
  cg3 = {
    sNodeName = "--Style_3--",
    sComponentName = "CanvasGroup"
  },
  img_head = {sComponentName = "Image"},
  tmp_SpeakerName = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  tmp_Content3 = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  cgContent3 = {
    sNodeName = "tmp_Content3",
    sComponentName = "CanvasGroup"
  },
  trRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Transform"
  },
  trStyleRoot_1 = {
    sNodeName = "--Style_1--",
    sComponentName = "Transform"
  },
  trStyleRoot_2 = {
    sNodeName = "--Style_2--",
    sComponentName = "Transform"
  },
  trStyleRoot_3 = {
    sNodeName = "--Style_3--",
    sComponentName = "Transform"
  },
  SetBGM = {},
  SetAudio = {}
}
AvgEditorQuickPreview._mapEventConfig = {}
local sAutoParagraphSignal = "==A(.+)=="

function AvgEditorQuickPreview:Awake()
  self.nCurLanguageIdx = 1
  self.sPreviewBgmName = ""
  self.sPreviewAudioName = ""
  self.sVoResName = ""
  local n = self._mapNode
  self.tbTalk_CG = {
    [0] = n.cgTalk,
    [1] = n.cgSayThink,
    [2] = n.cgSayThink,
    [3] = n.cgFilm,
    [4] = n.cgDialog_1L,
    [5] = n.cgDialog_1R,
    [6] = n.cgDialog_2L,
    [7] = n.cgDialog_2R,
    [8] = n.cgCenter,
    [9] = n.cgCGTalk,
    [10] = n.cgFullScreen,
    [11] = n.cgCGTalk
  }
  self.tbTalk_NameBG = {
    [0] = n.imgTalkNameBg,
    [1] = nil,
    [2] = nil,
    [3] = nil,
    [4] = n.imgTalkNameBg_1L,
    [5] = n.imgTalkNameBg_1R,
    [6] = n.imgTalkNameBg_2L,
    [7] = n.imgTalkNameBg_2R,
    [8] = nil,
    [9] = nil,
    [10] = nil,
    [11] = nil
  }
  self.tbTalk_TMP_Name = {
    [0] = n.txtName_Talk,
    [1] = nil,
    [2] = nil,
    [3] = nil,
    [4] = n.txtName_Dialog_1L,
    [5] = n.txtName_Dialog_1R,
    [6] = n.txtName_Dialog_2L,
    [7] = n.txtName_Dialog_2R,
    [8] = nil,
    [9] = n.txtName_CGTalk,
    [10] = nil,
    [11] = n.txtName_CGTalk
  }
  self.tbTalk_TMP_Content = {
    [0] = n.rubyTmp_Talk,
    [1] = n.rubyTmp_SayThink,
    [2] = n.rubyTmp_SayThink,
    [3] = n.rubyTmp_Film,
    [4] = n.rubyTmp_1L,
    [5] = n.rubyTmp_1R,
    [6] = n.rubyTmp_2L,
    [7] = n.rubyTmp_2R,
    [8] = n.rubyTmp_Center,
    [9] = n.rubyTmp_CGTalk,
    [10] = n.rubyTmp_FS,
    [11] = n.rubyTmp_CGTalk
  }
  self._mapNode.goFixedHead.gameObject:SetActive(false)
  self._mapNode.Viewport_SV.gameObject:SetActive(false)
  NovaAPI.SetTMPText(self._mapNode.txtWindowTitle, "")
  for i = 1, 3 do
    NovaAPI.SetTMPText(self._mapNode.txtBtnCancel[i], "")
    NovaAPI.SetTMPText(self._mapNode.txtBtnConfirm1_[i], "")
  end
  self.tbChoiceRoot = {
    [0] = n.goM,
    [1] = n.goR,
    [2] = n.goL
  }
  self.tbChoiceTMPLayout = {
    [0] = n.tbTMPLayout_M,
    [1] = n.tbTMPLayout_R,
    [2] = n.tbTMPLayout_L
  }
  self.tbChoiceTMP = {
    [0] = n.tbTMP_M,
    [1] = n.tbTMP_R,
    [2] = n.tbTMP_L
  }
  for i = 1, 4 do
    self._mapNode.tbGoSelect_M[i]:SetActive(false)
    self._mapNode.tbGoSelect_R[i]:SetActive(false)
    self._mapNode.tbGoSelect_L[i]:SetActive(false)
  end
  self.tbRawIndex = {}
  self.tbEachGridHeight = {}
  self.tbEachGridBgWidth = {}
  self.nCurRawDataIndex = 0
end

function AvgEditorQuickPreview:OnEnable()
  self.gameObject:SetActive(false)
end

function AvgEditorQuickPreview:SetQuickPreview(tbCmdData, nLanguageIdx)
  self.nCurLanguageIdx = nLanguageIdx
  local func = AvgEditorQuickPreview["QP_" .. tbCmdData.cmd]
  if type(func) == "function" then
    self.gameObject:SetActive(true)
    func(self, tbCmdData.param)
  end
end

function AvgEditorQuickPreview:CloseQuickPreview(btn)
  if string.len(self.sPreviewBgmName) > 0 then
    WwiseAudioManager.Instance:PostEvent("avg_track1_stop")
    self.sPreviewBgmName = ""
  end
  if 0 < string.len(self.sPreviewAudioName) then
    WwiseAudioManager.Instance:PlaySound(self.sPreviewAudioName .. "_stop")
    self.sPreviewAudioName = ""
  end
  if 0 < string.len(self.sVoResName) then
    WwiseAudioManager.Instance:WwiseVoice_StopInAVG()
    self.sVoResName = ""
  end
  self._mapNode.Avg_4_Talk:SetActive(false)
  self._mapNode.Avg_5_Phone:SetActive(false)
  self._mapNode.Avg_6_Menu:SetActive(false)
  self._mapNode.Avg_7_Choice:SetActive(false)
  self._mapNode.AvgBubbleUI:SetActive(false)
  self._mapNode.SetBGM:SetActive(false)
  self._mapNode.SetAudio:SetActive(false)
  self.gameObject:SetActive(false)
end

function AvgEditorQuickPreview:PreviewContent(sContent)
  sContent = ProcAvgTextContent(sContent, self.nCurLanguageIdx)
  if string.find(sContent, "==W==") ~= nil then
    sContent = string.gsub(sContent, "==W==", "")
  end
  if string.find(sContent, "==B==") ~= nil then
    sContent = string.gsub(sContent, "==B==", "")
  end
  if string.find(sContent, "==P==") ~= nil then
    sContent = string.gsub(sContent, "==P==", "")
  end
  if string.find(sContent, sAutoParagraphSignal) ~= nil then
    sContent = string.gsub(sContent, sAutoParagraphSignal, "")
  end
  return sContent
end

function AvgEditorQuickPreview:QP_SetTalk(tbParam)
  self._mapNode.Avg_4_Talk:SetActive(true)
  local nType = tbParam[1]
  for k, v in pairs(self.tbTalk_CG) do
    NovaAPI.SetCanvasGroupAlpha(v, 0)
    NovaAPI.SetCanvasGroupInteractable(v, false)
    NovaAPI.SetCanvasGroupBlocksRaycasts(v, false)
  end
  NovaAPI.SetCanvasGroupAlpha(self.tbTalk_CG[nType], 1)
  NovaAPI.SetCanvasGroupInteractable(self.tbTalk_CG[nType], true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self.tbTalk_CG[nType], true)
  local sAvgCharId = tbParam[2]
  sAvgCharId = AdjustMainRoleAvgCharId(sAvgCharId)
  local sName, sColor = self._panel:GetAvgCharName(sAvgCharId)
  if sAvgCharId == "0" then
    sName = ""
  else
    if sAvgCharId == "1" then
      sName = PlayerBaseData:GetPlayerNickName()
    else
    end
  end
  if self.tbTalk_TMP_Name[nType] ~= nil then
    NovaAPI.SetTMPText(self.tbTalk_TMP_Name[nType], sName)
    if self.tbTalk_NameBG[nType] ~= nil then
      self.tbTalk_NameBG[nType].gameObject:SetActive(sAvgCharId ~= "0")
      local _b, _color = ColorUtility.TryParseHtmlString(sColor)
      NovaAPI.SetImageColor(self.tbTalk_NameBG[nType], _color)
    end
  end
  local sContent = ProcAvgTextContentFallback(self._panel.sTxtLan, self._panel.sVoLan, self._panel.bIsPlayerMale, tbParam[3], tbParam[7], tbParam[8], tbParam[9])
  if string.find(sContent, sAutoParagraphSignal) ~= nil and nType ~= 8 and nType ~= 10 then
    sContent = "error: AutoParagraphSignal"
  end
  sContent = self:PreviewContent(sContent)
  if string.sub(sContent, 1, 12) == "_NOT_IN_LOG_" then
    sContent = string.gsub(sContent, "_NOT_IN_LOG_", "")
  end
  if nType == 3 and sName ~= "" then
    sContent = string.format("%s：%s", sName, sContent)
  end
  if nType == 8 then
    local bCenterBgActive = string.find(sContent, "==Off==") == nil
    self._mapNode.imgContentBg_Center:SetActive(bCenterBgActive)
    if bCenterBgActive ~= nil then
      sContent = string.gsub(sContent, "==Off==", "")
    end
  end
  NovaAPI.SetText_RubyTMP(self.tbTalk_TMP_Content[nType], sContent)
  if nType == 1 or nType == 2 then
    local sColor = nType == 1 and "#132C47" or "#F1F4F6"
    local sAnimTriggerName = nType == 1 and "tSetToSay" or "tSetToThink"
    NovaAPI.SetTextColor_RubyTMP(self._mapNode.rubyTmp_SayThink, sColor)
    self._mapNode.animSwitchSayThinkBg:SetTrigger(sAnimTriggerName)
  end
end

function AvgEditorQuickPreview:QP_SetPhoneMsg(tbParam)
  self._mapNode.Avg_5_Phone:SetActive(true)
  self:OnRefreshGrid(self._mapNode.sv, tbParam)
end

function AvgEditorQuickPreview:OnRefreshGrid(goSv, tbParam)
  local data = tbParam
  if data == nil then
    return
  end
  local goGrid = goSv.transform:Find("grid")
  goGrid.gameObject:SetActive(true)
  local goChat = goGrid.transform:Find("goChatItem")
  local goMiddle = goGrid.transform:Find("goMiddle")
  local goSelection = goGrid.transform:Find("goSelection")
  goSelection.gameObject:SetActive(false)
  goChat.gameObject:SetActive(data[1] ~= AllEnum.PhoneMsgType.SystemMsg and data[1] ~= AllEnum.PhoneMsgType.InputingMsgLeft and data[1] ~= AllEnum.PhoneMsgType.InputingMsgRight)
  goMiddle.gameObject:SetActive(data[1] == AllEnum.PhoneMsgType.SystemMsg)
  if data[1] == AllEnum.PhoneMsgType.SystemMsg then
    local txtMiddle = goMiddle:Find("txtMiddle"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(txtMiddle, data[3])
    local rtGrid = goGrid:GetComponent("RectTransform")
    local sizeDelta = rtGrid.sizeDelta
    sizeDelta.y = self.tbGridHeight[self.curContactsId][nDataIndex]
    rtGrid.sizeDelta = sizeDelta
  else
    self:OnRefreshCommonGrid(goGrid, tbParam)
  end
end

function AvgEditorQuickPreview:OnRefreshCommonGrid(goGrid, tbParam)
  local nMsgType = tbParam[1]
  local bReply = tbParam[1] ~= AllEnum.PhoneMsgType.ReceiveMsg and tbParam[1] ~= AllEnum.PhoneMsgType.ReceiveImgMsg
  local bImgMsg = tbParam[1] == AllEnum.PhoneMsgType.ReceiveImgMsg or tbParam[1] == AllEnum.PhoneMsgType.ReplyImgMsg
  local sAvgCharId = tbParam[2]
  sAvgCharId = AdjustMainRoleAvgCharId(sAvgCharId)
  local sMsgContent = tbParam[3]
  local nH = 104
  if nMsgType == 0 or nMsgType == 1 or nMsgType == 2 or nMsgType == 5 then
    sMsgContent = ProcAvgTextContentFallback(self._panel.sTxtLan, self._panel.sVoLan, self._panel.bIsPlayerMale, tbParam[3], tbParam[7], tbParam[8], tbParam[9])
    sMsgContent = ProcAvgTextContent(sMsgContent, self._panel.nCurLanguageIdx)
  end
  local rtGrid = goGrid:GetComponent("RectTransform")
  
  local function func_SetGrid(sPart, sPart_Head, bActive)
    local go = rtGrid:Find(sPart).gameObject
    local goHead = goGrid:Find(sPart_Head).gameObject
    if rtGrid:Find(sPart_Head .. "/imgHeadBg/imgHead") == nil then
      return nil
    end
    local rtImgHeadBg = rtGrid:Find(sPart_Head .. "/imgHeadBg"):GetComponent("RectTransform")
    local imgHead = rtGrid:Find(sPart_Head .. "/imgHeadBg/imgHead"):GetComponent("Image")
    local rtMsg = rtGrid:Find(sPart .. "/rtMsg"):GetComponent("RectTransform")
    local btnImg = rtGrid:Find(sPart .. "/rtMsg/imgBg"):GetComponent("Button")
    local txtMsg = rtGrid:Find(sPart .. "/rtMsg/txtContent"):GetComponent("TMP_Text")
    local rtTxtMsg = txtMsg:GetComponent("RectTransform")
    local rtImgMsg = rtGrid:Find(sPart .. "/rtMsg/imgMsg"):GetComponent("RectTransform")
    local imgImgMsg = rtImgMsg:GetComponent("Image")
    btnImg.gameObject:SetActive(not bImgMsg)
    txtMsg.gameObject:SetActive(not bImgMsg)
    imgImgMsg.gameObject:SetActive(bImgMsg)
    rtImgHeadBg.anchoredPosition = Vector2.zero
    if bActive == true then
      go:SetActive(true)
      goHead:SetActive(true)
      self:SetAvgCharHeadIcon(imgHead, sAvgCharId, "002")
      rtImgHeadBg.gameObject:SetActive(true)
      if bImgMsg then
        local imgSize = {}
        local nImgType = tonumber(tbParam[4])
        local path = nImgType == 1 and "Icon/AvgPhoneImageMsg/" .. sMsgContent or "Icon/AvgPhoneEmojiMsg/" .. sMsgContent
        local sprite = self:GetPngSprite(path)
        imgSize[1] = nImgType == 1 and CONST_WIDTH or sprite.rect.width
        imgSize[2] = nImgType == 1 and CONST_WIDTH / sprite.rect.width * sprite.rect.height or sprite.rect.height
        nH = imgSize[2]
        rtMsg.sizeDelta = Vector2(imgSize[1], imgSize[2])
        NovaAPI.SetImageRaycastTarget(imgImgMsg, imgType == 1)
        if nImgType == 1 then
          sMsgContent = "Icon/AvgPhoneImageMsg/" .. sMsgContent
        else
          sMsgContent = "Icon/AvgPhoneEmojiMsg/" .. sMsgContent
        end
        self:SetPngSprite(imgImgMsg, sMsgContent)
        rtImgMsg.localScale = Vector3(1, 1, 1)
      else
        local width = self:_CalcGridWidth(sMsgContent)
        nH = self:_CalcMsgGridHeight(sMsgContent)
        rtTxtMsg.sizeDelta = Vector2(width, rtTxtMsg.sizeDelta.y)
        NovaAPI.SetTMPText(txtMsg, sMsgContent)
        rtMsg.sizeDelta = Vector2(width + 92, nH)
      end
      rtGrid.sizeDelta = Vector2(CONST_GRID_WIDTH, nH)
      local rtGo = go:GetComponent("RectTransform")
      rtGo.sizeDelta = Vector2(CONST_GRID_WIDTH, nH)
    else
      go:SetActive(false)
      goHead:SetActive(false)
      NovaAPI.SetImageSpriteAsset(imgHead, nil)
      NovaAPI.SetTMPText(txtMsg, " ")
      rtMsg.sizeDelta = Vector2(344, 104)
      rtGrid.sizeDelta = Vector2(CONST_GRID_WIDTH, 104)
    end
  end
  
  local sRootNodeName_On, sRootNodeName_Off
  if bReply == true then
    sRootNodeName_On = "goChatItem/goRight"
    sRootNodeHead_On = "goChatItem/goRightHead"
    sRootNodeName_Off = "goChatItem/goLeft"
    sRootNodeHead_Off = "goChatItem/goLeftHead"
  else
    sRootNodeName_On = "goChatItem/goLeft"
    sRootNodeHead_On = "goChatItem/goLeftHead"
    sRootNodeName_Off = "goChatItem/goRight"
    sRootNodeHead_Off = "goChatItem/goRightHead"
  end
  func_SetGrid(sRootNodeName_Off, sRootNodeHead_Off, false)
  func_SetGrid(sRootNodeName_On, sRootNodeHead_On, true)
end

function AvgEditorQuickPreview:_CalcGridWidth(sContent)
  self._mapNode.layoutCalcHeight.enabled = false
  NovaAPI.SetTMPText(self._mapNode.txtCalcHeight, sContent)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtCalcHeight)
  local width = self._mapNode.rtCalcHeight.rect.width
  if width > max_chat_width then
    width = max_chat_width
  end
  return width
end

function AvgEditorQuickPreview:_CalcMsgGridHeight(sContent)
  self._mapNode.layoutCalcHeight.enabled = false
  NovaAPI.SetTMPText(self._mapNode.txtCalcHeight, sContent)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtCalcHeight)
  if self._mapNode.rtCalcHeight.rect.width > max_chat_width then
    self._mapNode.layoutCalcHeight.enabled = true
    self._mapNode.layoutCalcHeight.preferredWidth = max_chat_width
  end
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtCalcHeight)
  local nH = self._mapNode.rtCalcHeight.rect.height + 56
  if nH < 104 then
    nH = 104
  end
  return nH
end

function AvgEditorQuickPreview:QP_SetPhoneThinking(tbParam)
  self._mapNode.Avg_5_Phone:SetActive(true)
  self._mapNode.animMainRole:SetTrigger("tIn")
  self._mapNode.goMask:SetActive(true)
  local sBody = tbParam[1]
  local sFace = tbParam[2]
  local sEmoji = tbParam[3]
  local sContentOS = tbParam[4]
  if self._panel.bIsPlayerMale == true and tbParam[5] ~= nil and tbParam[5] ~= "" then
    sContentOS = tbParam[5]
  end
  sContentOS = ProcAvgTextContent(sContentOS, self._panel.nCurLanguageIdx)
  local nTextAnimDuration = self:_CalcTextAnimDuration(sContentOS)
  local twDOText = NovaAPI.DOText_RubyTMP(self._mapNode.rtmp_os, sContentOS, 2.0)
  twDOText:SetUpdate(true)
  self:AddTimer(1, nTextAnimDuration, "_DelayShowThinkingBtn", true, true, true)
  EventManager.Hit(EventId.AvgChoiceMainRoleOS_In, self._mapNode.trMainRole, sBody, sFace, sEmoji)
end

function AvgEditorQuickPreview:_CalcTextAnimDuration(sContent)
  local nCurLanguageIdx = self._panel.nCurLanguageIdx
  if nCurLanguageIdx == nil then
    nCurLanguageIdx = GetLanguageIndex(Settings.sCurrentTxtLanguage)
  end
  local nDuration = CalcTextAnimDuration(sContent, nCurLanguageIdx)
  nDuration = math.min(DEFAULT_AUTOPLAY_MAX_TIME, nDuration)
  nDuration = math.max(DEFAULT_AUTOPLAY_MIN_TIME, nDuration)
  return nDuration
end

function AvgEditorQuickPreview:QP_SetPhoneMsgChoiceBegin(tbParam)
  self._mapNode.Avg_5_Phone:SetActive(true)
  self:OnRefreshChoiceGrid(self._mapNode.sv, tbParam)
end

function AvgEditorQuickPreview:OnRefreshChoiceGrid(goSv, tbParam)
  local goGrid = goSv.transform:Find("grid")
  goGrid.gameObject:SetActive(true)
  local goChat = goGrid.transform:Find("goChatItem")
  local goMiddle = goGrid.transform:Find("goMiddle")
  local rootRect = goGrid.transform:Find("goSelection")
  rootRect.gameObject:SetActive(true)
  goChat.gameObject:SetActive(false)
  goMiddle.gameObject:SetActive(false)
  local rtRootRect = rootRect:GetComponent("RectTransform")
  local imgHead = rootRect:Find("imgRightBg/imgRightHeadIcon"):GetComponent("Image")
  local sAvgCharId = tbParam[8]
  self:SetAvgCharHeadIcon(imgHead, AdjustMainRoleAvgCharId(sAvgCharId), "002")
  local goTxtSelection = rootRect:Find("goSelectionList/goTxtSelection")
  local goImgSelection = rootRect:Find("goSelectionList/goImgSelection")
  goTxtSelection.gameObject:SetActive(true)
  local goRoot = goTxtSelection
  local nChoiceH = 0
  local pointNumber = 0
  for i = 1, 3 do
    local goSelection = goRoot:Find("goSelection" .. i)
    if tbParam[i + 1] == "" then
      goSelection.gameObject:SetActive(false)
    else
      goSelection.gameObject:SetActive(true)
      pointNumber = pointNumber + 1
      local btnSelection = goSelection:Find("btnSelection"):GetComponent("NaviButton")
      local txtSelection = btnSelection.transform:Find("AnimRoot/txtSelection"):GetComponent("TMP_Text")
      local rtTxtSelection = btnSelection.transform:Find("AnimRoot/txtSelection"):GetComponent("RectTransform")
      local rtImgBg = btnSelection.transform:Find("AnimRoot/imgBg"):GetComponent("RectTransform")
      local rtSelection = goSelection:GetComponent("RectTransform")
      local nOffset = 0
      if PlayerBaseData:GetPlayerSex() == true then
        nOffset = 3
      end
      local sContent = ProcAvgTextContent(tbParam[i + 1 + nOffset], self._panel.nCurLanguageIdx)
      if type(sContent) ~= "string" or sContent == "" then
        sContent = ProcAvgTextContent(tbParam[i + 1], self._panel.nCurLanguageIdx)
      end
      NovaAPI.SetTMPText(txtSelection, sContent)
      local nHeight = self:_CalcChoiceHeight(sContent)
      rtTxtSelection.sizeDelta = Vector2(rtTxtSelection.sizeDelta.x, nHeight)
      rtImgBg.sizeDelta = Vector2(rtImgBg.sizeDelta.x, nHeight + choice_img_diff)
      rtSelection.sizeDelta = Vector2(rtSelection.sizeDelta.x, nHeight + choice_img_diff)
      nChoiceH = nChoiceH + nHeight + choice_img_diff
    end
  end
  local goHead = rootRect:Find("imgRightBg"):GetComponent("RectTransform")
  local headPos = goHead.anchoredPosition
  nChoiceH = nChoiceH + choice_selection_space * (pointNumber - 1) + choice_selection_top + choice_selection_bottom + choice_selection_input + choice_head_offset
  rtRootRect.sizeDelta = Vector2(rtRootRect.sizeDelta.x, nChoiceH)
  headPos.y = 0
  goHead.anchoredPosition = headPos
  self.bStartChoice = true
end

function AvgEditorQuickPreview:_CalcChoiceHeight(sContent)
  self._mapNode.layoutCalcHeight.enabled = false
  NovaAPI.SetTMPText(self._mapNode.txtCalcHeight, sContent)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtCalcHeight)
  if self._mapNode.rtCalcHeight.rect.width > max_choice_width then
    self._mapNode.layoutCalcHeight.enabled = true
    self._mapNode.layoutCalcHeight.preferredWidth = max_choice_width
  end
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtCalcHeight)
  local nH = self._mapNode.rtCalcHeight.rect.height + choice_txt_diff
  if nH < 67.15 then
    nH = 67.15
  end
  return nH
end

function AvgEditorQuickPreview:QP_SetIntro(tbParam)
  self._mapNode.Avg_6_Menu:SetActive(true)
  local sTitle = tbParam[2]
  local sName = tbParam[3]
  local sContent = tbParam[4]
  local bShowTips_BE = tbParam[5] == 1
  sContent = ProcAvgTextContent(sContent, self.nCurLanguageIdx)
  NovaAPI.SetTMPText(self._mapNode.txtStoryId, sTitle)
  NovaAPI.SetTMPText(self._mapNode.txtStoryTitle, sName)
  NovaAPI.SetText_RubyTMP(self._mapNode.rubyTmpContent, sContent)
  local sPath = GetAvgLuaRequireRoot(self.nCurLanguageIdx) .. "Preset/AvgUIText"
  local AvgUIText = require(sPath)
  local sSkipTips = AvgUIText.SkipTips
  if bShowTips_BE == true then
    sSkipTips = AvgUIText.SkipBETips
  end
  NovaAPI.SetTMPText(self._mapNode.txtSkipTips, sSkipTips)
  AvgUIText = nil
end

function AvgEditorQuickPreview:QP_SetChoiceBegin(tbParam)
  self._mapNode.Avg_7_Choice:SetActive(true)
  local nLMR = tbParam[5]
  for k, v in pairs(self.tbChoiceRoot) do
    v:SetActive(k == nLMR)
  end
  local tbContent = tbParam[4]
  local tbTMPLayout = self.tbChoiceTMPLayout[nLMR]
  local tbTMP = self.tbChoiceTMP[nLMR]
  for i, v in ipairs(tbContent) do
    local sContent = self:PreviewContent(v)
    tbTMPLayout[i].gameObject:SetActive(sContent ~= "")
    NovaAPI.SetText_RubyTMP(tbTMPLayout[i], sContent)
    NovaAPI.SetText_RubyTMP(tbTMP[i], sContent)
    if nLMR == 2 then
      local rt = self._mapNode.tbRT_L[i]
      rt.anchoredPosition = Vector2(-72 * (i - 1), 0)
    end
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgMainRoleChoice, tbParam[6] == 1 and 1 or 0)
  NovaAPI.SetText_RubyTMP(self._mapNode.rubyTmp_Choice_OS, self:PreviewContent(tbParam[10] or ""))
end

function AvgEditorQuickPreview:QP_SetBubble(tbParam)
  self._mapNode.AvgBubbleUI:SetActive(true)
  local uiType = 3
  if uiType == 1 then
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cg1, 1)
    self:PopupBubble(tbParam)
  elseif uiType == 2 then
    self._mapNode.cg2:DOFade(1, 0.2):SetUpdate(true)
    self:ShowAvgBubbleInPrologue(tbParam)
  elseif uiType == 3 then
    self:PopupBubble3(tbParam)
  end
end

function AvgEditorQuickPreview:PopupBubble(tbParam)
  local sContent = ProcAvgTextContentFallback(self._panel.sTxtLan, self._panel.sVoLan, self._panel.bIsPlayerMale, tbParam[3], tbParam[6], tbParam[9], tbParam[10])
  sContent = ProcAvgTextContent(sContent, self._panel.nCurLanguageIdx)
  local sVoiceName = tbParam[5]
  local nW, nH = self:_CalcWidthAndHeight(sContent)
  table.insert(self.tbEachGridBgWidth, 1, nW)
  table.insert(self.tbEachGridHeight, 1, nH)
  table.insert(self.tbRawIndex, 1, 1)
  self:RefreshBubbleGrid(tbParam)
  if type(sVoiceName) == "string" and sVoiceName ~= "" then
    WwiseAudioMgr:WwiseVoice_PlayInAVG(sVoiceName)
  else
    self.nTIME = CalcTextAnimDuration(sContent, self._panel.nCurLanguageIdx, true)
    if self.timer ~= nil then
      self.timer:Cancel()
      self.timer = nil
    end
  end
end

function AvgEditorQuickPreview:_CalcWidthAndHeight(sContent)
  local nBgWidth = 0
  local nGridHeight = 0
  NovaAPI.SetText_RubyTMP(self._mapNode.TMP, sContent)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtTMP)
  nBgWidth = self._mapNode.rtTMP.rect.width + 88
  if self._mapNode.rtTMP.rect.height > 100 then
    nGridHeight = self._mapNode.rtTMP.rect.height + 40
  end
  if nBgWidth < 120 then
    nBgWidth = 120
  end
  if nGridHeight < 110 then
    nGridHeight = 110
  end
  return nBgWidth, nGridHeight
end

function AvgEditorQuickPreview:RefreshBubbleGrid(tbParam)
  local goGrid = self._mapNode.LSV.transform:Find("grid")
  goGrid.gameObject:SetActive(true)
  local nLayoutIndex = 0
  if nLayoutIndex == nil then
    return
  end
  nLayoutIndex = nLayoutIndex + 1
  local trScale = goGrid.transform:GetChild(0)
  self:SetAvgCharHeadIcon(trScale:Find("imgSpeaker"):GetComponent("Image"), AdjustMainRoleAvgCharId(tbParam[1]), tbParam[2])
  local trTMP = trScale:Find("rubyTmp")
  local sContent = ProcAvgTextContentFallback(self._panel.sTxtLan, self._panel.sVoLan, self._panel.bIsPlayerMale, tbParam[3], tbParam[6], tbParam[9], tbParam[10])
  sContent = ProcAvgTextContent(sContent, self._panel.nCurLanguageIdx)
  NovaAPI.SetText_RubyTMP(trTMP:GetComponent("RubyTextMeshProUGUI"), ProcAvgTextContent(sContent, self._panel.nCurLanguageIdx))
  local rtTMP = trTMP:GetComponent("RectTransform")
  LayoutRebuilder.ForceRebuildLayoutImmediate(rtTMP)
  local nH = self.tbEachGridHeight[nLayoutIndex]
  trScale:Find("imgBg"):GetComponent("RectTransform").sizeDelta = Vector2(self.tbEachGridBgWidth[nLayoutIndex], nH - 4)
  goGrid:GetComponent("RectTransform").sizeDelta = Vector2(800, nH)
end

function AvgEditorQuickPreview:ShowAvgBubbleInPrologue(tbParam)
  NovaAPI.SetText_RubyTMP(self._mapNode.txtName, self:_GetAvgCharName(tbParam[1]))
  local sContent = ProcAvgTextContentFallback(self._panel.sTxtLan, self._panel.sVoLan, self._panel.bIsPlayerMale, tbParam[3], tbParam[6], tbParam[9], tbParam[10])
  sContent = ProcAvgTextContent(sContent, self._panel.nCurLanguageIdx)
  local sVoiceName = tbParam[5]
  NovaAPI.SetText_RubyTMP(self._mapNode.tmp_Content, sContent)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgContent, 0)
  self._mapNode.cgContent:DOFade(1, 0.3):SetUpdate(true)
  if type(sVoiceName) == "string" and sVoiceName ~= "" then
    WwiseAudioMgr:WwiseVoice_PlayInAVG(sVoiceName)
  else
    self.nTIME = CalcTextAnimDuration(sContent, self._panel.nCurLanguageIdx, true)
    if self.timer ~= nil then
      self.timer:Cancel()
      self.timer = nil
    end
  end
end

function AvgEditorQuickPreview:_ParseBBHeadIcon(sParam1)
  local sIcon = sParam1
  if string.find(sParam1, "_BB_") == nil then
    sIcon = sParam1 .. "_BB_001"
  end
  local tb = string.split(sIcon, "_BB_")
  return tb[1], tb[2]
end

function AvgEditorQuickPreview:PopupBubble3(tbParam)
  if self.timer ~= nil then
    self.timer:Cancel()
    self.timer = nil
  end
  if self.bPause == true then
    return
  end
  local sAvgCharId = tbParam[1]
  local sResName = sAvgCharId
  sAvgCharId, sResName = self:_ParseBBHeadIcon(sAvgCharId)
  sAvgCharId = AdjustMainRoleAvgCharId(sAvgCharId)
  local sContent = ProcAvgTextContentFallback(self._panel.sTxtLan, self._panel.sVoLan, self._panel.bIsPlayerMale, tbParam[3], tbParam[6], tbParam[9], tbParam[10])
  sContent = ProcAvgTextContent(sContent, self._panel.nCurLanguageIdx)
  local sVoiceName = tbParam[5]
  local sSpName = tbParam[7]
  local sName
  if type(sSpName) == "string" and sSpName ~= "" then
    sName = sSpName
  elseif sAvgCharId == "avg3_100" or sAvgCharId == "avg3_101" then
    sName = PlayerData.Base:GetPlayerNickName()
  else
    sName = self:_GetAvgCharName(sAvgCharId)
  end
  local bShadowMask = tbParam[8] == 1
  
  local function func_ReSetBubble()
    local sFullPath = string.format("Icon/AvgHead/%s/%s_BB_%s.png", sAvgCharId, sAvgCharId, sResName)
    local _sprite = GameResourceLoader.LoadAsset(ResType.Any, Settings.AB_ROOT_PATH .. sFullPath, typeof(Sprite), "UI", self._panel._nPanelId)
    NovaAPI.SetImageSpriteAsset(self._mapNode.img_head, _sprite)
    NovaAPI.SetEnable_Gradient2(self._mapNode.img_head.gameObject, bShadowMask)
    NovaAPI.SetText_RubyTMP(self._mapNode.tmp_SpeakerName, sName)
    NovaAPI.SetText_RubyTMP(self._mapNode.tmp_Content3, sContent)
  end
  
  self.sequence = DOTween.Sequence()
  local bSameSpeaker = self.sPreSpeakerAvgCharId == sAvgCharId
  if bSameSpeaker == true then
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cg3, 1)
    self.sequence:Append(self._mapNode.cgContent3:DOFade(0, 0.2):SetUpdate(true))
    self.sequence:AppendCallback(dotween_callback_handler(self, func_ReSetBubble))
    self.sequence:Append(self._mapNode.cgContent3:DOFade(1, 0.2):SetUpdate(true))
  else
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgContent3, 1)
    self.sequence:Append(self._mapNode.cg3:DOFade(0, 0.2):SetUpdate(true))
    self.sequence:AppendCallback(dotween_callback_handler(self, func_ReSetBubble))
    self.sequence:Append(self._mapNode.cg3:DOFade(1, 0.2):SetUpdate(true))
  end
  
  local function cb()
    self.sequence = nil
  end
  
  self.sequence.onComplete = dotween_callback_handler(self, cb)
  self.sequence:SetUpdate(true)
  self.sPreSpeakerAvgCharId = sAvgCharId
  if type(sVoiceName) == "string" and sVoiceName ~= "" then
    WwiseAudioMgr:WwiseVoice_PlayInAVG(sVoiceName)
  else
    self.nTIME = CalcTextAnimDuration(sContent, self._panel.nCurLanguageIdx, true)
  end
end

function AvgEditorQuickPreview:_GetAvgCharName(sAvgCharId)
  if self.tbAvgCharacter == nil then
    self.sAvgCharacterPath = GetAvgLuaRequireRoot(self._panel.nCurLanguageIdx) .. "Preset/AvgCharacter"
    local tbAvgChar = require(self.sAvgCharacterPath)
    self.tbAvgCharacter = {}
    for i, v in ipairs(tbAvgChar) do
      self.tbAvgCharacter[v.id] = v.name
    end
  end
  local sName = self.tbAvgCharacter[sAvgCharId]
  if type(sName) == "string" then
    return sName
  else
    return sAvgCharId
  end
end

function AvgEditorQuickPreview:QP_SetBGM(tbParam)
  self.sPreviewBgmName = tbParam[4] or ""
  if string.len(self.sPreviewBgmName) > 0 then
    WwiseAudioManager.Instance.MusicVolume = 10
    WwiseAudioManager.Instance:PostEvent(tbParam[2])
    WwiseAudioManager.Instance:SetState("avg_track1", self.sPreviewBgmName)
    WwiseAudioManager.Instance:PostEvent("avg_track1")
  end
end

function AvgEditorQuickPreview:QP_SetAudio(tbParam)
  self.sPreviewAudioName = ""
  self.sVoResName = ""
  local nType = tbParam[1]
  local sAudioResName = tbParam[2] or ""
  if string.len(sAudioResName) > 0 then
    if nType == 0 then
      if string.find(sAudioResName, "_stop") ~= nil then
        self:CloseQuickPreview()
        return
      end
      self.sPreviewAudioName = sAudioResName
      WwiseAudioManager.Instance:PlaySound(sAudioResName)
    elseif nType == 1 then
      self.sVoResName = sAudioResName
      WwiseAudioManager.Instance:WwiseVoice_PlayInAVG(sAudioResName)
    end
  end
end

return AvgEditorQuickPreview

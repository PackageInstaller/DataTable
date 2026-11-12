local DiscSkillCtrl = class("DiscSkillCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
DiscSkillCtrl._mapNodeConfig = {
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnCloseDatail = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  window = {},
  aniWindow = {sNodeName = "window", sComponentName = "Animator"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "DiscSkill_Title"
  },
  DiscItem = {nCount = 6},
  goNone = {nCount = 6},
  btnItem = {
    nCount = 6,
    sComponentName = "UIButton",
    callback = "OnBtnClick_DiscItem"
  },
  txtMainDiscTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "DiscFormation_MainTitle"
  },
  txtSubDiscTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "DiscFormation_SubTitle"
  },
  txtMainDiscTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tip_DiscMainTitle"
  },
  txtSubDiscTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tip_DiscSubTitle"
  },
  txtDiscName = {sComponentName = "TMP_Text"},
  goProperty = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplatePropertyCtrl"
  },
  imgDiscEET = {sComponentName = "Image"},
  imgTag = {nCount = 3},
  txtTag = {nCount = 3, sComponentName = "TMP_Text"},
  ScrollView = {sComponentName = "ScrollRect"},
  goMainSkill = {},
  txtMainSkillTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_MainSkill_Title"
  },
  txtMainSkillName = {sComponentName = "TMP_Text"},
  imgMainSkillIcon = {sComponentName = "Image"},
  imgMainSkillIconBg = {sComponentName = "Image"},
  goMainLevel = {sComponentName = "Image"},
  txtMainSkillDesc = {sComponentName = "TMP_Text"},
  TMP_Link1 = {
    sNodeName = "txtMainSkillDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnLinkClick_Word"
  },
  goSubSkill = {},
  txtSubSkillTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_SubSkill_Title"
  },
  rtSubBg = {nCount = 2},
  txtSubSkillName = {nCount = 2, sComponentName = "TMP_Text"},
  imgSubSkillIcon = {nCount = 2, sComponentName = "Image"},
  imgSubSkillIconBg = {nCount = 2, sComponentName = "Image"},
  txtSubSkillDesc = {nCount = 2, sComponentName = "TMP_Text"},
  TMP_Link2 = {
    sNodeName = "txtSubSkillDesc1",
    sComponentName = "TMPHyperLink",
    callback = "OnLinkClick_Word"
  },
  TMP_Link3 = {
    sNodeName = "txtSubSkillDesc2",
    sComponentName = "TMPHyperLink",
    callback = "OnLinkClick_Word"
  },
  txtActiveNeed = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_SubSkill_ActiveConditions"
  },
  txtSubSkillLevel = {nCount = 2, sComponentName = "TMP_Text"},
  btnPrevLevel = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Prev"
  },
  btnNextLevel = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Next"
  },
  imgPrevOn = {nCount = 2},
  imgPrevOff = {nCount = 2},
  imgNextOn = {nCount = 2},
  imgNextOff = {nCount = 2},
  imgNeedNoteBg1_ = {nCount = 3},
  imgNeedNoteIcon1_ = {nCount = 3, sComponentName = "Image"},
  txtNeedNoteName1_ = {nCount = 3, sComponentName = "TMP_Text"},
  txtNoteActiveLv1_ = {nCount = 3, sComponentName = "TMP_Text"},
  imgNeedNoteBg2_ = {nCount = 3},
  imgNeedNoteIcon2_ = {nCount = 3, sComponentName = "Image"},
  txtNeedNoteName2_ = {nCount = 3, sComponentName = "TMP_Text"},
  txtNoteActiveLv2_ = {nCount = 3, sComponentName = "TMP_Text"},
  ActionBar = {
    sCtrlName = "Game.UI.ActionBar.ActionBarCtrl"
  },
  btnShortcutClose = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Close"
  },
  goRightContent = {
    sComponentName = "RectTransform"
  },
  goNoteInfo = {}
}
DiscSkillCtrl._mapEventConfig = {}

function DiscSkillCtrl:Open()
  self._mapNode.blur:SetActive(true)
  self:PlayInAni()
  self:Refresh()
end

function DiscSkillCtrl:PlayInAni()
  self._mapNode.window:SetActive(true)
  self._mapNode.aniWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function DiscSkillCtrl:PlayOutAni()
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.2, "Close", true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function DiscSkillCtrl:Close()
  self._mapNode.window:SetActive(false)
  EventManager.Hit(EventId.ClosePanel, PanelId.DiscSkill)
end

function DiscSkillCtrl:Refresh()
  local nDiscToSelect = 0
  if nil ~= self.tbDisc then
    for i = 1, 6 do
      local nDiscId = self.tbDisc[i]
      if 0 ~= nDiscId then
        if nDiscToSelect == 0 then
          nDiscToSelect = i
        end
        local discData = self.mapDiscData[nDiscId]
        if nil ~= discData then
          local objCtrl = self:BindCtrlByNode(self._mapNode.DiscItem[i], "Game.UI.TemplateEx.TemplateDiscItemCtrl")
          objCtrl:Refresh(discData.nId, discData.nStar, discData.nMaxStar, discData.nLevel, self.mapNote)
          self._mapNode.DiscItem[i]:SetActive(true)
          self._mapNode.goNone[i]:SetActive(false)
        end
      else
        self._mapNode.goNone[i]:SetActive(true)
        self._mapNode.DiscItem[i]:SetActive(false)
      end
    end
  end
  local nTempIdx = table.indexof(self.tbDisc, self.nCurId)
  nDiscToSelect = 0 < nTempIdx and nTempIdx or nDiscToSelect
  if nDiscToSelect ~= 0 then
    self:OnBtnClick_DiscItem(nil, nDiscToSelect)
  end
end

function DiscSkillCtrl:RefreshSkill(mapDisc, nIdx)
  self._mapNode.txtMainDiscTip.gameObject:SetActive(nIdx <= 3)
  self._mapNode.txtSubDiscTip.gameObject:SetActive(3 < nIdx)
  local nMainSkillId = mapDisc.nMainSkillId
  if nIdx <= 3 and nMainSkillId then
    self._mapNode.goMainSkill:SetActive(true)
    for k, v in pairs(self.tbSubNoteItem) do
      v.gameObject:SetActive(false)
    end
    local mapCfg = ConfigTable.GetData("MainSkill", nMainSkillId)
    if mapCfg then
      self:SetPngSprite(self._mapNode.imgMainSkillIcon, mapCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small)
      self:SetPngSprite(self._mapNode.imgMainSkillIconBg, mapCfg.IconBg .. AllEnum.DiscSkillIconSurfix.Small)
      NovaAPI.SetTMPText(self._mapNode.txtMainSkillName, mapCfg.Name)
      self:SetAtlasSprite(self._mapNode.goMainLevel, "12_rare", AllEnum.FrameType_New.DiscLimitS .. AllEnum.FrameColor_New[mapDisc.nRarity] .. "_0" .. mapDisc.nStar + 1)
      NovaAPI.SetImageNativeSize(self._mapNode.goMainLevel)
      local sDesc = UTILS.ParseParamDesc(mapCfg.Desc, mapCfg)
      NovaAPI.SetTMPText(self._mapNode.txtMainSkillDesc, sDesc)
    end
    self.tbSubLayer = {}
    self.tbSubMaxLayer = {}
    self:RefreshSubSkill(mapDisc)
  else
    self._mapNode.goMainSkill:SetActive(false)
    self._mapNode.goSubSkill:SetActive(false)
  end
  if 3 < nIdx and mapDisc.nId then
    for k, v in pairs(self.tbSubNoteItem) do
      self.tbSubNoteItem[k].gameObject:SetActive(false)
    end
    for i, tbNote in pairs(mapDisc.tbSubNoteSkills) do
      if nil ~= self.tbSubNoteItem[i] then
        self.tbSubNoteItem[i].gameObject:SetActive(true)
        self.tbSubNoteItem[i]:SetItem(tbNote.nId, tbNote.nCount)
      else
        local itemObj = instantiate(self._mapNode.goNoteInfo, self._mapNode.goRightContent)
        itemObj:SetActive(true)
        local itemCtrl = self:BindCtrlByNode(itemObj, "Game.UI.DiscSkill.DiscSubSkillItem")
        itemCtrl:SetItem(tbNote.nId, tbNote.nCount)
        table.insert(self.tbSubNoteItem, itemCtrl)
      end
    end
  end
  NovaAPI.SetVerticalNormalizedPosition(self._mapNode.ScrollView, 1)
end

function DiscSkillCtrl:RefreshSubSkill(mapDisc)
  if not self.tbSubLayer then
    self.tbSubLayer = {}
  end
  if not self.tbSubMaxLayer then
    self.tbSubMaxLayer = {}
  end
  local tbSubSkillGroupId = mapDisc.tbSubSkillGroupId
  self._mapNode.goSubSkill:SetActive(next(tbSubSkillGroupId))
  for i = 1, 2 do
    if tbSubSkillGroupId[i] then
      self._mapNode.rtSubBg[i]:SetActive(true)
      local tbGroup = CacheTable.GetData("_SecondarySkill", tbSubSkillGroupId[i])
      if tbGroup then
        if not self.tbSubLayer[i] then
          self.tbSubLayer[i] = 1
          local nMaxLayer = #tbGroup
          for j = nMaxLayer, 1, -1 do
            if tbGroup[j] then
              local bActive = mapDisc:CheckSubSkillActive(self.mapNote, tbGroup[j])
              if bActive then
                self.tbSubLayer[i] = j
                break
              end
            end
          end
        end
        if not self.tbSubMaxLayer[i] then
          self.tbSubMaxLayer[i] = #tbGroup
        end
        NovaAPI.SetTMPText(self._mapNode.txtSubSkillLevel[i], orderedFormat(ConfigTable.GetUIText("Disc_SubSkill_Level"), self.tbSubLayer[i]))
        self._mapNode.imgPrevOn[i]:SetActive(self.tbSubLayer[i] > 1)
        self._mapNode.imgPrevOff[i]:SetActive(self.tbSubLayer[i] == 1)
        self._mapNode.imgNextOn[i]:SetActive(self.tbSubLayer[i] < self.tbSubMaxLayer[i])
        self._mapNode.imgNextOff[i]:SetActive(self.tbSubLayer[i] == self.tbSubMaxLayer[i])
        local mapCfg = tbGroup[self.tbSubLayer[i]]
        if mapCfg then
          self:SetPngSprite(self._mapNode.imgSubSkillIcon[i], mapCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small)
          self:SetPngSprite(self._mapNode.imgSubSkillIconBg[i], mapCfg.IconBg .. AllEnum.DiscSkillIconSurfix.Small)
          NovaAPI.SetTMPText(self._mapNode.txtSubSkillName[i], mapCfg.Name)
          local sDesc = UTILS.ParseParamDesc(mapCfg.Desc, mapCfg)
          NovaAPI.SetTMPText(self._mapNode.txtSubSkillDesc[i], sDesc)
          local tbActiveNote = decodeJson(mapCfg.NeedSubNoteSkills)
          local j = 1
          for nNeed = 1, 3 do
            self._mapNode["imgNeedNoteBg" .. i .. "_"][nNeed]:SetActive(false)
          end
          for k, v in pairs(tbActiveNote) do
            local nNoteId = tonumber(k)
            local nNoteCount = tonumber(v)
            if nNoteId then
              local mapNote = ConfigTable.GetData("SubNoteSkill", nNoteId)
              if mapNote then
                self._mapNode["imgNeedNoteBg" .. i .. "_"][j]:SetActive(true)
                self:SetPngSprite(self._mapNode["imgNeedNoteIcon" .. i .. "_"][j], mapNote.Icon .. AllEnum.DiscSkillIconSurfix.Small)
                NovaAPI.SetTMPText(self._mapNode["txtNeedNoteName" .. i .. "_"][j], mapNote.Name)
                NovaAPI.SetTMPText(self._mapNode["txtNoteActiveLv" .. i .. "_"][j], orderedFormat(ConfigTable.GetUIText("Disc_SubSkill_ActiveLevel"), nNoteCount))
                j = j + 1
              end
            end
          end
        end
      end
    else
      self._mapNode.rtSubBg[i]:SetActive(false)
    end
  end
end

function DiscSkillCtrl:SelectDiscItem(nDiscId, nStar, nMaxStar, nLevel, nIdx)
  local discData = self.mapDiscData[nDiscId]
  if nil == discData then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtDiscName, discData.sName)
  local tbAttr = discData.mapAttrBase
  local nAttrIdx = 1
  for _, mapAttachAttr in pairs(AllEnum.AttachAttr) do
    local mapAttr = tbAttr[mapAttachAttr.sKey]
    if mapAttr.Value > 0 then
      self._mapNode.goProperty[nAttrIdx]:SetItemProperty(mapAttr.Key, mapAttr.Value, nil, true)
      nAttrIdx = nAttrIdx + 1
    end
  end
  for i = 1, 3 do
    local nTag = discData.tbTag[i]
    if nTag then
      self._mapNode.imgTag[i]:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtTag[i], ConfigTable.GetData("DiscTag", nTag).Title)
    else
      self._mapNode.imgTag[i]:SetActive(false)
    end
  end
  local sName = AllEnum.ElementIconType.Icon .. discData.nEET
  self:SetAtlasSprite(self._mapNode.imgDiscEET, "12_rare", sName)
  self:RefreshSkill(discData, nIdx)
end

function DiscSkillCtrl:Awake()
  self._mapNode.window:SetActive(false)
  local tbParam = self:GetPanelParam()
  self.tbDisc = {}
  self.mapNote = {}
  self.mapDiscData = {}
  if type(tbParam) == "table" then
    self.tbDisc = tbParam[1]
    self.mapNote = tbParam[2]
    self.mapDiscData = tbParam[3]
    self.nCurId = tbParam[4] ~= nil and tbParam[4] or self.tbDisc[1]
  end
  self.tbDiscId = {}
  self.tbSubNoteItem = {}
  self._mapNode.btnShortcutClose.gameObject:SetActive(GamepadUIManager.GetInputState())
  if GamepadUIManager.GetInputState() then
    local tbConfig = {
      {
        sAction = "Back",
        sLang = "ActionBar_Back"
      }
    }
    self._mapNode.ActionBar:InitActionBar(tbConfig)
  end
end

function DiscSkillCtrl:OnEnable()
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.EnableGamepadUI("DiscSkillCtrl", self:GetGamepadUINode(), nil, true)
  end
  self:Open()
end

function DiscSkillCtrl:OnDisable()
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.DisableGamepadUI("DiscSkillCtrl")
  end
  for k, v in pairs(self.tbSubNoteItem) do
    self:UnbindCtrlByNode(v)
    self.tbSubNoteItem[k] = nil
  end
  self.tbSubNoteItem = {}
end

function DiscSkillCtrl:OnDestroy()
end

function DiscSkillCtrl:OnBtnClick_Close()
  self:PlayOutAni()
end

function DiscSkillCtrl:OnBtnClick_DiscItem(obj, nIdx)
  if nil == self.tbDisc or 0 == self.tbDisc[nIdx] then
    return
  end
  self.nSelectDiscId = self.tbDisc[nIdx]
  self.nSelectIdx = nIdx
  for i = 1, 6 do
    if 0 ~= self.tbDisc[i] then
      local tr = self._mapNode.btnItem[i]:GetComponent("Transform")
      local goSelect = tr:Find("AnimRoot/tc_disc_item_01/Select").gameObject
      goSelect:SetActive(self.tbDisc[i] == self.nSelectDiscId)
    end
  end
  local discData = self.mapDiscData[self.nSelectDiscId]
  self:SelectDiscItem(self.nSelectDiscId, discData.nStar, discData.nMaxStar, discData.nLevel, self.nSelectIdx)
end

function DiscSkillCtrl:OnBtnClick_Prev(btn, nIndex)
  if self.tbSubLayer and self.tbSubLayer[nIndex] == 1 then
    return
  end
  self.tbSubLayer[nIndex] = self.tbSubLayer[nIndex] - 1
  local discData = self.mapDiscData[self.nSelectDiscId]
  self:RefreshSubSkill(discData)
end

function DiscSkillCtrl:OnBtnClick_Next(btn, nIndex)
  if self.tbSubMaxLayer and self.tbSubLayer and self.tbSubLayer[nIndex] == self.tbSubMaxLayer[nIndex] then
    return
  end
  self.tbSubLayer[nIndex] = self.tbSubLayer[nIndex] + 1
  local discData = self.mapDiscData[self.nSelectDiscId]
  self:RefreshSubSkill(discData)
end

function DiscSkillCtrl:OnLinkClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

return DiscSkillCtrl

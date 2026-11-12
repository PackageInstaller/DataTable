local DiscInfoCtrl = class("DiscInfoCtrl", BaseCtrl)
DiscInfoCtrl._mapNodeConfig = {
  txtName = {sComponentName = "TMP_Text"},
  txtDiscLevel = {sComponentName = "TMP_Text"},
  txtTitleRank = {sComponentName = "TMP_Text", sLanguageId = "Disc_Level"},
  txtLevelMax = {sComponentName = "TMP_Text"},
  goStarAdvance = {
    sNodeName = "tc_star_advance",
    sCtrlName = "Game.UI.TemplateEx.TemplateStarAdvanceCtrl"
  },
  goStar = {
    sCtrlName = "Game.UI.TemplateEx.TemplateStarCtrl"
  },
  txtTitleProperty = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharacterInfo_Property"
  },
  goProperty = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplatePropertyCtrl"
  },
  txtElement = {sComponentName = "TMP_Text"},
  imgElementIcon = {sComponentName = "Image"},
  imgTag = {nCount = 3},
  txtTag = {nCount = 3, sComponentName = "TMP_Text"},
  DiscNote = {},
  DiscSkill = {},
  imgOn = {nCount = 2},
  imgOff = {nCount = 2},
  txtMainSkill = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_Btn_MainSkill"
  },
  txtSubSkill = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_Btn_SubSkill"
  },
  btnSkill = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tab"
  },
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
  txtNoteTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_SubSkill_Tip"
  },
  btnNote = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Note"
  },
  imgNoteCount = {nCount = 3, sComponentName = "Image"},
  imgNoteIcon = {nCount = 3, sComponentName = "Image"},
  txtNoteName = {nCount = 3, sComponentName = "TMP_Text"},
  txtNoteLv = {nCount = 3, sComponentName = "TMP_Text"},
  txtNoteDesc = {nCount = 3, sComponentName = "TMP_Text"},
  btnNotePreview = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NotePreview"
  }
}
DiscInfoCtrl._mapEventConfig = {
  Guide_ShowAllSubSkill = "OnEvent_Guide_ShowAllSubSkill"
}

function DiscInfoCtrl:RefreshContent()
  if self._panel.nCurTog ~= AllEnum.DiscTab.Info then
    return
  end
  self.nCurTab = 1
  for i = 1, 2 do
    self._mapNode.imgOn[i]:SetActive(i == self.nCurTab)
    self._mapNode.imgOff[i]:SetActive(i ~= self.nCurTab)
  end
  if type(self._panel.nId) ~= "number" then
    return
  end
  self:RefreshShow()
end

function DiscInfoCtrl:RefreshShow()
  self.mapDisc = PlayerData.Disc:GetDiscById(self._panel.nId)
  self:RefreshInfo()
  self:RefreshProperty()
  self:RefreshSkill()
  self:SwitchSkill()
end

function DiscInfoCtrl:RefreshSkill()
  local nMainSkillId = self.mapDisc.nMainSkillId
  if nMainSkillId then
    self._mapNode.goMainSkill:SetActive(true)
    local mapCfg = ConfigTable.GetData("MainSkill", nMainSkillId)
    if mapCfg then
      self:SetPngSprite(self._mapNode.imgMainSkillIcon, mapCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small)
      self:SetPngSprite(self._mapNode.imgMainSkillIconBg, mapCfg.IconBg .. AllEnum.DiscSkillIconSurfix.Small)
      NovaAPI.SetTMPText(self._mapNode.txtMainSkillName, mapCfg.Name)
      self:SetAtlasSprite(self._mapNode.goMainLevel, "12_rare", AllEnum.FrameType_New.DiscLimitS .. AllEnum.FrameColor_New[self.mapDisc.nRarity] .. "_0" .. self.mapDisc.nStar + 1)
      NovaAPI.SetImageNativeSize(self._mapNode.goMainLevel)
      local sDesc = UTILS.ParseParamDesc(mapCfg.Desc, mapCfg)
      NovaAPI.SetTMPText(self._mapNode.txtMainSkillDesc, sDesc)
    end
  else
    self._mapNode.goMainSkill:SetActive(false)
  end
  self.tbSubLayer = nil
  self.tbSubMaxLayer = nil
  self:RefreshSubSkill()
  for i = 1, 3 do
    self._mapNode.btnNote[i].gameObject:SetActive(self.mapDisc.tbSubNoteSkills[i])
    if self.mapDisc.tbSubNoteSkills[i] then
      local nImgCount = 2
      self:SetPngSprite(self._mapNode.imgNoteCount[i], "UI/big_sprites/zs_outfit_lv_" .. nImgCount)
      NovaAPI.SetImageNativeSize(self._mapNode.imgNoteCount[i])
      local mapNote = ConfigTable.GetData("SubNoteSkill", self.mapDisc.tbSubNoteSkills[i].nId)
      if mapNote then
        self:SetPngSprite(self._mapNode.imgNoteIcon[i], mapNote.Icon)
        NovaAPI.SetTMPText(self._mapNode.txtNoteName[i], mapNote.Name)
        NovaAPI.SetTMPText(self._mapNode.txtNoteDesc[i], mapNote.BriefDesc)
        NovaAPI.SetTMPText(self._mapNode.txtNoteLv[i], orderedFormat(ConfigTable.GetUIText("Note_Count"), self.mapDisc.tbSubNoteSkills[i].nCount))
      end
    end
  end
  NovaAPI.SetVerticalNormalizedPosition(self._mapNode.ScrollView, 1)
end

function DiscInfoCtrl:RefreshSubSkill()
  if not self.tbSubLayer then
    self.tbSubLayer = {}
  end
  if not self.tbSubMaxLayer then
    self.tbSubMaxLayer = {}
  end
  local tbSubSkillGroupId = self.mapDisc.tbSubSkillGroupId
  self._mapNode.goSubSkill:SetActive(next(tbSubSkillGroupId))
  for i = 1, 2 do
    if tbSubSkillGroupId[i] then
      self._mapNode.rtSubBg[i]:SetActive(true)
      local tbGroup = CacheTable.GetData("_SecondarySkill", tbSubSkillGroupId[i])
      if tbGroup then
        if not self.tbSubLayer[i] then
          self.tbSubLayer[i] = 1
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

function DiscInfoCtrl:RefreshInfo()
  NovaAPI.SetTMPText(self._mapNode.txtName, self.mapDisc.sName)
  self._mapNode.goStar:SetStar(0, 6 - self.mapDisc.nRarity)
  NovaAPI.SetTMPText(self._mapNode.txtDiscLevel, self.mapDisc.nLevel)
  NovaAPI.SetTMPText(self._mapNode.txtLevelMax, "/" .. self.mapDisc.nMaxLv)
  self._mapNode.goStarAdvance:SetStar(self.mapDisc.nPhase, self.mapDisc.nMaxPhase)
  local sName = AllEnum.ElementIconType.Icon .. self.mapDisc.nEET
  self:SetAtlasSprite(self._mapNode.imgElementIcon, "12_rare", sName)
  NovaAPI.SetTMPColor(self._mapNode.txtElement, AllEnum.ElementColor[self.mapDisc.nEET])
  NovaAPI.SetTMPText(self._mapNode.txtElement, ConfigTable.GetUIText("T_Element_Attr_" .. self.mapDisc.nEET))
  for i = 1, 3 do
    local nTag = self.mapDisc.tbTag[i]
    if nTag then
      self._mapNode.imgTag[i]:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtTag[i], ConfigTable.GetData("DiscTag", nTag).Title)
    else
      self._mapNode.imgTag[i]:SetActive(false)
    end
  end
end

function DiscInfoCtrl:RefreshProperty()
  local tbAttr = self.mapDisc.mapAttrBase
  local i = 1
  for _, mapAttachAttr in pairs(AllEnum.AttachAttr) do
    local mapAttr = tbAttr[mapAttachAttr.sKey]
    if mapAttr.Value > 0 then
      self._mapNode.goProperty[i]:SetItemProperty(mapAttr.Key, mapAttr.Value, nil, true)
      i = i + 1
    end
  end
end

function DiscInfoCtrl:SwitchSkill()
  self._mapNode.DiscSkill:SetActive(self.nCurTab == 1)
  self._mapNode.DiscNote:SetActive(self.nCurTab == 2)
end

function DiscInfoCtrl:FadeIn()
end

function DiscInfoCtrl:Awake()
end

function DiscInfoCtrl:OnEnable()
end

function DiscInfoCtrl:OnDisable()
end

function DiscInfoCtrl:OnDestroy()
end

function DiscInfoCtrl:OnBtnClick_Tab(btn, nIndex)
  if nIndex == self.nCurTab then
    return
  end
  for i = 1, 2 do
    self._mapNode.imgOn[i]:SetActive(i == nIndex)
    self._mapNode.imgOff[i]:SetActive(i ~= nIndex)
  end
  self.nCurTab = nIndex
  self:SwitchSkill()
end

function DiscInfoCtrl:OnBtnClick_Prev(btn, nIndex)
  if self.tbSubLayer and self.tbSubLayer[nIndex] == 1 then
    return
  end
  self.tbSubLayer[nIndex] = self.tbSubLayer[nIndex] - 1
  self:RefreshSubSkill()
end

function DiscInfoCtrl:OnBtnClick_Next(btn, nIndex)
  if self.tbSubMaxLayer and self.tbSubLayer and self.tbSubLayer[nIndex] == self.tbSubMaxLayer[nIndex] then
    return
  end
  self.tbSubLayer[nIndex] = self.tbSubLayer[nIndex] + 1
  self:RefreshSubSkill()
end

function DiscInfoCtrl:OnLinkClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

function DiscInfoCtrl:OnBtnClick_Note(btn, nIndex)
  local mapNote = self.mapDisc.tbSubNoteSkills[nIndex]
  if not mapNote then
    return
  end
  local tbNote = {}
  for _, v in ipairs(self.mapDisc.tbSubNoteSkills) do
    tbNote[v.nId] = v.nCount
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.NoteSkill, tbNote, mapNote.nId)
end

function DiscInfoCtrl:OnBtnClick_NotePreview(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.NoteSkillPreview, self.mapDisc.nSubNoteSkillId, self.mapDisc.nPhase, self.mapDisc.nRarity)
end

function DiscInfoCtrl:OnEvent_Guide_ShowAllSubSkill()
  NovaAPI.SetVerticalNormalizedPosition(self._mapNode.ScrollView, 0)
end

return DiscInfoCtrl

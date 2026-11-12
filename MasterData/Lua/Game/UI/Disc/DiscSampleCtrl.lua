local DiscSampleCtrl = class("DiscSampleCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
DiscSampleCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  UIDrag = {
    sComponentName = "UIDrag",
    callback = "OnDrag_Disc"
  },
  imgDiscFrame = {sComponentName = "Image"},
  imgDiscIcon = {sComponentName = "Image"},
  Middle = {
    sNodeName = "---Middle---"
  },
  liveDiscCtrl = {
    sNodeName = "goLiveDisc",
    sCtrlName = "Game.UI.Disc.LiveDiscCtrl"
  },
  FullImage = {
    sNodeName = "----Full----"
  },
  imgFull = {nCount = 2, sComponentName = "Image"},
  rtImgFull2 = {
    sNodeName = "imgFull2",
    sComponentName = "RectTransform"
  },
  imgFullBg = {},
  btnCloseFull = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseFull"
  },
  btnOpenFull2 = {
    sNodeName = "imgDiscFrame",
    sComponentName = "Button",
    callback = "OnBtnClick_OpenFull"
  },
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
  },
  btnSwitch = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Switch"
  },
  goSwitch = {},
  SwitchOn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_Sample_SwithOn"
  },
  SwitchOff = {
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_Sample_SwithOff"
  },
  aniRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  }
}
DiscSampleCtrl._mapEventConfig = {
  [EventId.UIBackConfirm] = "OnEvent_UIBack",
  [EventId.UIHomeConfirm] = "OnEvent_Home",
  ClickLiveDisc = "OnBtnClick_OpenFull"
}

function DiscSampleCtrl:InitData()
  if self.tbId then
    for index, discId in ipairs(self.tbId) do
      if self.nId == discId then
        self.curDiscIndex = index
        break
      end
    end
  end
  self.nCurTab = 1
  for i = 1, 2 do
    self._mapNode.imgOn[i]:SetActive(i == self.nCurTab)
    self._mapNode.imgOff[i]:SetActive(i ~= self.nCurTab)
  end
  self._mapNode.goSwitch:SetActive(not self.bPlayerHad)
  self.bMax = false
  self._mapNode.btnSwitch[1].gameObject:SetActive(true)
  self._mapNode.btnSwitch[2].gameObject:SetActive(false)
end

function DiscSampleCtrl:RefreshData()
  if self.bPlayerHad then
    return
  end
  self.mapMin = PlayerData.Disc:GenerateLocalDiscData(self.nId)
  local nMaxLv = 1
  
  local function foreachPromoteLimit(mapData)
    if mapData.Rarity == self.mapMin.nRarity and tonumber(mapData.Phase) == self.mapMin.nMaxPhase and tonumber(mapData.Phase) == self.mapMin.nMaxPhase then
      nMaxLv = tonumber(mapData.MaxLevel)
    end
  end
  
  ForEachTableLine(DataTable.DiscPromoteLimit, foreachPromoteLimit)
  self.mapMax = PlayerData.Disc:GenerateLocalDiscData(self.nId, 0, nMaxLv, self.mapMin.nMaxPhase, self.mapMin.nMaxStar)
end

function DiscSampleCtrl:GetDiscData()
  if self.bPlayerHad then
    return PlayerData.Disc:GetDiscById(self.nId)
  else
    return self.bMax and self.mapMax or self.mapMin
  end
end

function DiscSampleCtrl:Refresh()
  local mapDisc = self:GetDiscData()
  self:RefreshInfo(mapDisc)
  self:RefreshProperty(mapDisc)
  self:RefreshSkill(mapDisc)
  self:SwitchSkill()
end

function DiscSampleCtrl:RefreshMiddle()
  local mapDisc = self:GetDiscData()
  local mapCfg = ConfigTable.GetData("Disc", self.nId)
  if mapCfg == nil then
    return
  end
  self._mapNode.imgDiscIcon.gameObject:SetActive(false)
  self._mapNode.liveDiscCtrl:SetDiscActive(true, mapCfg.DiscBg ~= "")
  self._mapNode.liveDiscCtrl:SetRawImage(mapCfg.DiscBg, mapDisc.nRarity)
  if mapCfg.DiscBg ~= "" then
    local bSSR = mapDisc.nRarity == GameEnum.itemRarity.SSR
    self._mapNode.imgFull[1].gameObject:SetActive(bSSR)
    self._mapNode.imgFull[2].gameObject:SetActive(not bSSR)
    if bSSR then
      self:SetPngSprite(self._mapNode.imgFull[1], mapCfg.DiscBg .. AllEnum.DiscBgSurfix.Image)
    else
      self:SetPngSprite(self._mapNode.imgFull[2], mapCfg.DiscBg .. AllEnum.DiscBgSurfix.Image)
      local nH = Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT
      self._mapNode.rtImgFull2.sizeDelta = Vector2(nH, nH)
    end
  end
end

function DiscSampleCtrl:RefreshInfo(mapDisc)
  NovaAPI.SetTMPText(self._mapNode.txtName, mapDisc.sName)
  self._mapNode.goStar:SetStar(0, 6 - mapDisc.nRarity)
  NovaAPI.SetTMPText(self._mapNode.txtDiscLevel, mapDisc.nLevel)
  NovaAPI.SetTMPText(self._mapNode.txtLevelMax, "/" .. mapDisc.nMaxLv)
  self._mapNode.goStarAdvance:SetStar(mapDisc.nPhase, mapDisc.nMaxPhase)
  local sName = AllEnum.ElementIconType.Icon .. mapDisc.nEET
  self:SetAtlasSprite(self._mapNode.imgElementIcon, "12_rare", sName)
  NovaAPI.SetTMPColor(self._mapNode.txtElement, AllEnum.ElementColor[mapDisc.nEET])
  NovaAPI.SetTMPText(self._mapNode.txtElement, ConfigTable.GetUIText("T_Element_Attr_" .. mapDisc.nEET))
  for i = 1, 3 do
    local nTag = mapDisc.tbTag[i]
    if nTag then
      self._mapNode.imgTag[i]:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtTag[i], ConfigTable.GetData("DiscTag", nTag).Title)
    else
      self._mapNode.imgTag[i]:SetActive(false)
    end
  end
end

function DiscSampleCtrl:RefreshProperty(mapDisc)
  local tbAttr = mapDisc.mapAttrBase
  local i = 1
  for _, mapAttachAttr in pairs(AllEnum.AttachAttr) do
    local mapAttr = tbAttr[mapAttachAttr.sKey]
    if mapAttr.Value > 0 then
      self._mapNode.goProperty[i]:SetItemProperty(mapAttr.Key, mapAttr.Value, nil, true)
      i = i + 1
    end
  end
end

function DiscSampleCtrl:RefreshSkill(mapDisc)
  local nMainSkillId = mapDisc.nMainSkillId
  if nMainSkillId then
    self._mapNode.goMainSkill:SetActive(true)
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
  else
    self._mapNode.goMainSkill:SetActive(false)
  end
  self.tbSubLayer = nil
  self.tbSubMaxLayer = nil
  self:RefreshSubSkill()
  for i = 1, 3 do
    self._mapNode.btnNote[i].gameObject:SetActive(mapDisc.tbSubNoteSkills[i])
    if mapDisc.tbSubNoteSkills[i] then
      local nImgCount = 2
      self:SetPngSprite(self._mapNode.imgNoteCount[i], "UI/big_sprites/zs_outfit_lv_" .. nImgCount)
      NovaAPI.SetImageNativeSize(self._mapNode.imgNoteCount[i])
      local mapNote = ConfigTable.GetData("SubNoteSkill", mapDisc.tbSubNoteSkills[i].nId)
      if mapNote then
        self:SetPngSprite(self._mapNode.imgNoteIcon[i], mapNote.Icon)
        NovaAPI.SetTMPText(self._mapNode.txtNoteName[i], mapNote.Name)
        NovaAPI.SetTMPText(self._mapNode.txtNoteDesc[i], mapNote.BriefDesc)
        NovaAPI.SetTMPText(self._mapNode.txtNoteLv[i], orderedFormat(ConfigTable.GetUIText("Note_Count"), mapDisc.tbSubNoteSkills[i].nCount))
      end
    end
  end
  NovaAPI.SetVerticalNormalizedPosition(self._mapNode.ScrollView, 1)
end

function DiscSampleCtrl:RefreshSubSkill()
  if not self.tbSubLayer then
    self.tbSubLayer = {}
  end
  if not self.tbSubMaxLayer then
    self.tbSubMaxLayer = {}
  end
  local mapDisc = self:GetDiscData()
  local tbSubSkillGroupId = mapDisc.tbSubSkillGroupId
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

function DiscSampleCtrl:SwitchSkill()
  self._mapNode.DiscSkill:SetActive(self.nCurTab == 1)
  self._mapNode.DiscNote:SetActive(self.nCurTab == 2)
end

function DiscSampleCtrl:PlayBGM(bFirst)
  self.bPrevDisc = WwiseAudioMgr.IsPrevDiscBgm
  local mapCfg = ConfigTable.GetData("DiscIP", self.nId)
  if mapCfg == nil then
    return
  end
  local sState = mapCfg.VoFile
  if not self.bPrevDisc and bFirst then
    WwiseAudioMgr:PostEvent("music_outfit_enter")
  end
  WwiseAudioMgr:SetState("outfit", sState)
  WwiseAudioMgr:SetState("Disc", "discMain")
end

function DiscSampleCtrl:QuitBGM()
  if self.bPrevDisc then
    WwiseAudioMgr:SetState("outfit", WwiseAudioMgr.DiscUIBgm)
    WwiseAudioMgr:SetState("Disc", "discMain")
    WwiseAudioMgr:SeekOnEvent("music_outfit", 0)
  else
    WwiseAudioMgr:StopDiscMusic()
  end
end

function DiscSampleCtrl:FadeIn()
  self._mapNode.aniRoot:Play("DiscPanel_in")
end

function DiscSampleCtrl:Awake()
  self.aniFull = self.gameObject.transform:GetComponent("Animator")
  self.aniFull.enabled = false
  self.nDragStartPosX = nil
  self.nDragThreshold = ConfigTable.GetConfigNumber("DiscDragThreshold")
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nId = tbParam[1]
    self.bPlayerHad = tbParam[2]
    self.tbId = tbParam[3]
  end
  self:InitData()
end

function DiscSampleCtrl:OnEnable()
  PlayerData.Voice:ClearTimer()
  PlayerData.Voice:StopCharVoice()
  self:RefreshData()
  self:Refresh()
  self:RefreshMiddle()
  self:PlayBGM(true)
end

function DiscSampleCtrl:OnDisable()
  self:QuitBGM()
end

function DiscSampleCtrl:OnDestroy()
end

function DiscSampleCtrl:OnBtnClick_Tab(btn, nIndex)
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

function DiscSampleCtrl:OnBtnClick_Switch(btn, nIndex)
  self.bMax = not self.bMax
  self:Refresh()
  self._mapNode.btnSwitch[1].gameObject:SetActive(nIndex == 2)
  self._mapNode.btnSwitch[2].gameObject:SetActive(nIndex == 1)
end

function DiscSampleCtrl:OnBtnClick_OpenFull()
  if self._mapNode.liveDiscCtrl:GetCanOpenFullState() then
    self.aniFull.enabled = true
    self._mapNode.FullImage.gameObject:SetActive(true)
    if self._mapNode.imgFull[2].gameObject.activeSelf then
      self._mapNode.imgFullBg.gameObject:SetActive(true)
    end
    self.aniFull:Play("DiscPanel_Full_in", 0, 0)
  end
end

function DiscSampleCtrl:OnBtnClick_CloseFull()
  self.aniFull:Play("DiscPanel_Full_out")
  
  local function ani_end()
    self.aniFull.enabled = false
    self._mapNode.FullImage.gameObject:SetActive(false)
    self._mapNode.imgFullBg.gameObject:SetActive(false)
  end
  
  self:AddTimer(1, 0.4, ani_end, true, true, true)
end

function DiscSampleCtrl:OnEvent_UIBack(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.DiscSample)
end

function DiscSampleCtrl:OnEvent_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  PanelManager.Home()
end

function DiscSampleCtrl:OnBtnClick_Prev(btn, nIndex)
  if self.tbSubLayer and self.tbSubLayer[nIndex] == 1 then
    return
  end
  self.tbSubLayer[nIndex] = self.tbSubLayer[nIndex] - 1
  self:RefreshSubSkill()
end

function DiscSampleCtrl:OnBtnClick_Next(btn, nIndex)
  if self.tbSubMaxLayer and self.tbSubLayer and self.tbSubLayer[nIndex] == self.tbSubMaxLayer[nIndex] then
    return
  end
  self.tbSubLayer[nIndex] = self.tbSubLayer[nIndex] + 1
  self:RefreshSubSkill()
end

function DiscSampleCtrl:OnLinkClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

function DiscSampleCtrl:OnBtnClick_Note(btn, nIndex)
  local mapDisc = self:GetDiscData()
  local mapNote = mapDisc.tbSubNoteSkills[nIndex]
  if not mapNote then
    return
  end
  local tbNote = {}
  for _, v in ipairs(mapDisc.tbSubNoteSkills) do
    tbNote[v.nId] = v.nCount
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.NoteSkill, tbNote, mapNote.nId)
end

function DiscSampleCtrl:OnBtnClick_NotePreview(btn)
  local mapDisc = self:GetDiscData()
  EventManager.Hit(EventId.OpenPanel, PanelId.NoteSkillPreview, mapDisc.nSubNoteSkillId, mapDisc.nPhase, mapDisc.nRarity)
end

function DiscSampleCtrl:OnDrag_Disc(mDrag)
  if mDrag.DragEventType == AllEnum.UIDragType.DragStart then
    self.nDragStartPosX = mDrag.EventData.position.x
  elseif mDrag.DragEventType == AllEnum.UIDragType.DragEnd then
    local dragEndPosX = mDrag.EventData.position.x
    if dragEndPosX - self.nDragStartPosX > self.nDragThreshold then
      self:OnBtnClick_Left()
    elseif dragEndPosX - self.nDragStartPosX < -self.nDragThreshold then
      self:OnBtnClick_Right()
    end
  end
end

function DiscSampleCtrl:OnBtnClick_Left()
  if not self.tbId or #self.tbId <= 1 then
    return
  end
  self.curDiscIndex = self.curDiscIndex - 1
  if 1 > self.curDiscIndex then
    self.curDiscIndex = #self.tbId
  end
  self.nId = self.tbId[self.curDiscIndex]
  self:RefreshData()
  self:Refresh()
  self:RefreshMiddle()
  self:PlayBGM()
end

function DiscSampleCtrl:OnBtnClick_Right()
  if not self.tbId or #self.tbId <= 1 then
    return
  end
  self.curDiscIndex = self.curDiscIndex + 1
  if self.curDiscIndex > #self.tbId then
    self.curDiscIndex = 1
  end
  self.nId = self.tbId[self.curDiscIndex]
  self:RefreshData()
  self:Refresh()
  self:RefreshMiddle()
  self:PlayBGM()
end

return DiscSampleCtrl

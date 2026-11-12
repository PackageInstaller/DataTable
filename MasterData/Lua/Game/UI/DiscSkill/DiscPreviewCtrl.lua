local DiscPreviewCtrl = class("DiscPreviewCtrl", BaseCtrl)
DiscPreviewCtrl._mapNodeConfig = {
  aniBlur = {sComponentName = "Animator"},
  aniBlur2 = {sComponentName = "Animator"},
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  btnBlur2 = {
    sNodeName = "snapshot2",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnConfirm = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Confirm"
  },
  t_window = {},
  aniWindow = {sNodeName = "t_window", sComponentName = "Animator"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "ItemTip_DiscCYOTitle"
  },
  srDiscList = {
    sComponentName = "LoopScrollView"
  },
  ItemContent = {sComponentName = "Transform"},
  txtDiscName = {sComponentName = "TMP_Text"},
  goProperty = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplatePropertyCtrl"
  },
  btnSample = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Sample"
  },
  imgDiscEET = {sComponentName = "Image"},
  imgTag = {nCount = 3},
  txtTag = {nCount = 3, sComponentName = "TMP_Text"},
  DiscNote = {},
  DiscSkill = {},
  imgOn = {nCount = 2},
  imgOff = {nCount = 2},
  txtCoreSkill = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Disc_Btn_MainSkill"
  },
  txtCommonSkill = {
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
  btnNote = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Note"
  },
  imgNoteCount = {nCount = 3, sComponentName = "Image"},
  imgNoteIcon = {nCount = 3, sComponentName = "Image"},
  txtNoteName = {nCount = 3, sComponentName = "TMP_Text"},
  txtNoteLv = {nCount = 3, sComponentName = "TMP_Text"},
  txtNoteDesc = {nCount = 3, sComponentName = "TMP_Text"}
}
DiscPreviewCtrl._mapEventConfig = {}

function DiscPreviewCtrl:Open()
  self._mapNode.aniBlur.gameObject:SetActive(self.bBlur)
  self._mapNode.aniBlur2.gameObject:SetActive(not self.bBlur)
  self:PlayInAni()
  self:Refresh()
end

function DiscPreviewCtrl:PlayInAni()
  self._mapNode.t_window:SetActive(true)
  self._mapNode.aniWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function DiscPreviewCtrl:PlayOutAni()
  if self.bBlur then
    self._mapNode.aniWindow:Play("t_window_04_t_out")
    self._mapNode.aniBlur:SetTrigger("tOut")
    self:AddTimer(1, 0.2, "Close", true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  else
    self._mapNode.aniBlur2.gameObject:SetActive(false)
    self:Close()
  end
end

function DiscPreviewCtrl:Close()
  self._mapNode.t_window:SetActive(false)
  EventManager.Hit(EventId.ClosePanel, PanelId.DiscPreview)
end

function DiscPreviewCtrl:Refresh()
  self.tbDisc = {}
  local mapItemCfgData = ConfigTable.GetData_Item(self.nCYOId)
  if not mapItemCfgData then
    return
  end
  local mapItemUseCfg = decodeJson(mapItemCfgData.UseArgs)
  for sTid, nCount in pairs(mapItemUseCfg) do
    local nItemTid = tonumber(sTid)
    if nItemTid ~= nil then
      local mapDisc = PlayerData.Disc:GenerateLocalDiscData(nItemTid)
      table.insert(self.tbDisc, mapDisc)
    end
  end
  
  local function sort(a, b)
    return a.nRarity < b.nRarity or a.nRarity == b.nRarity and a.nEET < b.nEET or a.nRarity == b.nRarity and a.nEET == b.nEET and a.nId < b.nId
  end
  
  table.sort(self.tbDisc, sort)
  self.tbGridCtrl = {}
  self.nCurSelectItem = 1
  if #self.tbDisc > 0 then
    self._mapNode.srDiscList:SetAnim(0.05)
    self._mapNode.srDiscList:Init(#self.tbDisc, self, self.OnGridRefresh, self.OnGridBtnClick, true)
  end
  self.nCurTab = 1
  for i = 1, 2 do
    self._mapNode.imgOn[i]:SetActive(i == self.nCurTab)
    self._mapNode.imgOff[i]:SetActive(i ~= self.nCurTab)
  end
  self:RefreshInfo(self.tbDisc[self.nCurSelectItem])
end

function DiscPreviewCtrl:OnGridRefresh(goGrid, gridIndex)
  if self.tbGridCtrl[goGrid] == nil then
    local mapCtrl = self:BindCtrlByNode(goGrid, "Game.UI.TemplateEx.TemplateDiscPreviewItemCtrl")
    self.tbGridCtrl[goGrid] = mapCtrl
  end
  local nIdx = gridIndex
  if nIdx ~= nil then
    nIdx = nIdx + 1
  else
    return
  end
  local nItemTid = self.tbDisc[nIdx].nId
  local mapItemCfgData = ConfigTable.GetData_Item(nItemTid)
  if not mapItemCfgData then
    return
  end
  self.tbGridCtrl[goGrid]:Refresh(nItemTid, self.tbDisc[nIdx].nLevel)
  self.tbGridCtrl[goGrid]:SetSelect(nIdx == self.nCurSelectItem)
end

function DiscPreviewCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIdx = gridIndex
  if nIdx ~= nil then
    nIdx = nIdx + 1
  else
    return
  end
  if nIdx == self.nCurSelectItem then
    return
  end
  local rtItemBefore = self._mapNode.ItemContent:Find(tostring(self.nCurSelectItem - 1))
  if rtItemBefore ~= nil and self.tbGridCtrl[rtItemBefore.gameObject] ~= nil then
    self.tbGridCtrl[rtItemBefore.gameObject]:SetSelect(false)
  end
  if self.tbGridCtrl[goGrid] ~= nil then
    self.tbGridCtrl[goGrid]:SetSelect(true)
  end
  self.nCurSelectItem = nIdx
  self:RefreshInfo(self.tbDisc[nIdx])
end

function DiscPreviewCtrl:SwitchTab()
  self._mapNode.DiscSkill:SetActive(self.nCurTab == 1)
  self._mapNode.DiscNote:SetActive(self.nCurTab == 2)
end

function DiscPreviewCtrl:RefreshInfo(mapDisc)
  self.mapSelectDisc = mapDisc
  NovaAPI.SetTMPText(self._mapNode.txtDiscName, self.mapSelectDisc.sName)
  local sName = AllEnum.ElementIconType.Icon .. self.mapSelectDisc.nEET
  self:SetAtlasSprite(self._mapNode.imgDiscEET, "12_rare", sName)
  for i = 1, 3 do
    local nTag = mapDisc.tbTag[i]
    if nTag then
      self._mapNode.imgTag[i]:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtTag[i], ConfigTable.GetData("DiscTag", nTag).Title)
    else
      self._mapNode.imgTag[i]:SetActive(false)
    end
  end
  local tbAttr = self.mapSelectDisc.mapAttrBase
  local i = 1
  for _, mapAttachAttr in pairs(AllEnum.AttachAttr) do
    local mapAttr = tbAttr[mapAttachAttr.sKey]
    if mapAttr.Value > 0 then
      self._mapNode.goProperty[i]:SetItemProperty(mapAttr.Key, mapAttr.Value, nil, true)
      i = i + 1
    end
  end
  self:RefreshSkill()
  self:SwitchTab()
end

function DiscPreviewCtrl:RefreshSkill()
  local nMainSkillId = self.mapSelectDisc.nMainSkillId
  if nMainSkillId then
    self._mapNode.goMainSkill:SetActive(true)
    local mapCfg = ConfigTable.GetData("MainSkill", nMainSkillId)
    if mapCfg then
      self:SetPngSprite(self._mapNode.imgMainSkillIcon, mapCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small)
      self:SetPngSprite(self._mapNode.imgMainSkillIconBg, mapCfg.IconBg .. AllEnum.DiscSkillIconSurfix.Small)
      NovaAPI.SetTMPText(self._mapNode.txtMainSkillName, mapCfg.Name)
      self:SetAtlasSprite(self._mapNode.goMainLevel, "12_rare", AllEnum.FrameType_New.DiscLimitS .. AllEnum.FrameColor_New[self.mapSelectDisc.nRarity] .. "_0" .. self.mapSelectDisc.nStar + 1)
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
    self._mapNode.btnNote[i].gameObject:SetActive(self.mapSelectDisc.tbSubNoteSkills[i])
    if self.mapSelectDisc.tbSubNoteSkills[i] then
      local nImgCount = 2
      self:SetPngSprite(self._mapNode.imgNoteCount[i], "UI/big_sprites/zs_outfit_lv_" .. nImgCount)
      NovaAPI.SetImageNativeSize(self._mapNode.imgNoteCount[i])
      local mapNote = ConfigTable.GetData("SubNoteSkill", self.mapSelectDisc.tbSubNoteSkills[i].nId)
      if mapNote then
        self:SetPngSprite(self._mapNode.imgNoteIcon[i], mapNote.Icon)
        NovaAPI.SetTMPText(self._mapNode.txtNoteName[i], mapNote.Name)
        NovaAPI.SetTMPText(self._mapNode.txtNoteDesc[i], mapNote.BriefDesc)
        NovaAPI.SetTMPText(self._mapNode.txtNoteLv[i], orderedFormat(ConfigTable.GetUIText("Note_Count"), self.mapSelectDisc.tbSubNoteSkills[i].nCount))
      end
    end
  end
  NovaAPI.SetVerticalNormalizedPosition(self._mapNode.ScrollView, 1)
end

function DiscPreviewCtrl:RefreshSubSkill()
  if not self.tbSubLayer then
    self.tbSubLayer = {}
  end
  if not self.tbSubMaxLayer then
    self.tbSubMaxLayer = {}
  end
  local tbSubSkillGroupId = self.mapSelectDisc.tbSubSkillGroupId
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

function DiscPreviewCtrl:Awake()
  self._mapNode.t_window:SetActive(false)
  self.bBlur = false
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nCYOId = tbParam[1]
    self.bBlur = tbParam[2]
  end
end

function DiscPreviewCtrl:OnEnable()
  self:Open()
end

function DiscPreviewCtrl:OnDisable()
  for k, v in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(v)
    self.tbGridCtrl[k] = nil
  end
  self.tbGridCtrl = {}
end

function DiscPreviewCtrl:OnDestroy()
end

function DiscPreviewCtrl:OnBtnClick_Close()
  self:PlayOutAni()
end

function DiscPreviewCtrl:OnBtnClick_Tab(btn, nIndex)
  if nIndex == self.nCurTab then
    return
  end
  for i = 1, 2 do
    self._mapNode.imgOn[i]:SetActive(i == nIndex)
    self._mapNode.imgOff[i]:SetActive(i ~= nIndex)
  end
  self.nCurTab = nIndex
  self:SwitchTab()
end

function DiscPreviewCtrl:OnBtnClick_Prev(btn, nIndex)
  if self.tbSubLayer and self.tbSubLayer[nIndex] == 1 then
    return
  end
  self.tbSubLayer[nIndex] = self.tbSubLayer[nIndex] - 1
  self:RefreshSubSkill()
end

function DiscPreviewCtrl:OnBtnClick_Next(btn, nIndex)
  if self.tbSubMaxLayer and self.tbSubLayer and self.tbSubLayer[nIndex] == self.tbSubMaxLayer[nIndex] then
    return
  end
  self.tbSubLayer[nIndex] = self.tbSubLayer[nIndex] + 1
  self:RefreshSubSkill()
end

function DiscPreviewCtrl:OnLinkClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

function DiscPreviewCtrl:OnBtnClick_Note(btn, nIndex)
  local mapNote = self.mapSelectDisc.tbSubNoteSkills[nIndex]
  if not mapNote then
    return
  end
  local tbNote = {}
  for _, v in ipairs(self.mapSelectDisc.tbSubNoteSkills) do
    tbNote[v.nId] = v.nCount
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.NoteSkill, tbNote, mapNote.nId, false)
end

function DiscPreviewCtrl:OnBtnClick_Sample(btn)
  local tbId = {}
  for _, v in ipairs(self.tbDisc) do
    table.insert(tbId, v.nId)
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.DiscSample, self.mapSelectDisc.nId, false, tbId)
end

return DiscPreviewCtrl

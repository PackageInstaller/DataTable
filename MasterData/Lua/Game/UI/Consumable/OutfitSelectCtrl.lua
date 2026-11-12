local OutfitSelectCtrl = class("OutfitSelectCtrl", BaseCtrl)
OutfitSelectCtrl._mapNodeConfig = {
  srOutfitList = {
    sComponentName = "LoopScrollView"
  },
  ItemContent = {sComponentName = "Transform"},
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnConfirm1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtTitleOutfitSelect2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "ConsumeableSelectOutfitTitle"
  },
  txtBtnbtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Confirm"
  },
  txtBtnCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Cancel"
  },
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
OutfitSelectCtrl._mapEventConfig = {
  ConsumableCancel = "OnBtnClick_Close"
}
OutfitSelectCtrl._mapRedDotConfig = {}

function OutfitSelectCtrl:Awake()
  self._mapItemCtrl = {}
  self.gameObject:SetActive(false)
  self.animator = self.gameObject:GetComponent("Animator")
end

function OutfitSelectCtrl:FadeIn()
end

function OutfitSelectCtrl:FadeOut()
end

function OutfitSelectCtrl:OnEnable()
end

function OutfitSelectCtrl:OnDisable()
  self:UnbindAllCtrl()
end

function OutfitSelectCtrl:OnDestroy()
end

function OutfitSelectCtrl:OnRelease()
end

function OutfitSelectCtrl:UnbindAllCtrl()
  for go, mapCtrl in pairs(self._mapItemCtrl) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self._mapItemCtrl = {}
end

function OutfitSelectCtrl:OpenPanel(nTid)
  self.gameObject:SetActive(true)
  self.animator:Play("t_window_04_t_in")
  self.nUseItemTid = nTid
  self._tbItem = {}
  local mapItemCfgData = ConfigTable.GetData_Item(nTid)
  if mapItemCfgData ~= nil then
    local mapItemUseCfg = decodeJson(mapItemCfgData.UseArgs)
    for sTid, nCount in pairs(mapItemUseCfg) do
      local nItemTid = tonumber(sTid)
      if nItemTid ~= nil then
        local mapDisc = PlayerData.Disc:GenerateLocalDiscData(nItemTid)
        table.insert(self._tbItem, mapDisc)
      end
    end
  end
  
  local function sort(a, b)
    return a.nRarity < b.nRarity or a.nRarity == b.nRarity and a.nEET < b.nEET or a.nRarity == b.nRarity and a.nEET == b.nEET and a.nId < b.nId
  end
  
  table.sort(self._tbItem, sort)
  self.nCurSelectItem = 1
  if #self._tbItem > 0 then
    self._mapNode.srOutfitList:SetAnim(0.1)
    self._mapNode.srOutfitList:Init(#self._tbItem, self, self.OnGridRefresh, self.OnGridBtnClick, true)
  end
  self.nCurTab = 1
  for i = 1, 2 do
    self._mapNode.imgOn[i]:SetActive(i == self.nCurTab)
    self._mapNode.imgOff[i]:SetActive(i ~= self.nCurTab)
  end
  self:RefreshInfo(self._tbItem[self.nCurSelectItem])
end

function OutfitSelectCtrl:CloseAnim()
  self.animator:Play("t_window_04_t_out")
end

function OutfitSelectCtrl:OnGridRefresh(goGrid, gridIndex)
  if self._mapItemCtrl[goGrid] == nil then
    local mapCtrl = self:BindCtrlByNode(goGrid, "Game.UI.TemplateEx.TemplateDiscPreviewItemCtrl")
    self._mapItemCtrl[goGrid] = mapCtrl
  end
  local nIdx = gridIndex
  if nIdx ~= nil then
    nIdx = nIdx + 1
  else
    return
  end
  local nItemTid = self._tbItem[nIdx].nId
  local mapItemCfgData = ConfigTable.GetData_Item(nItemTid)
  if not mapItemCfgData then
    return
  end
  self._mapItemCtrl[goGrid]:Refresh(nItemTid, self._tbItem[nIdx].nLevel)
  self._mapItemCtrl[goGrid]:SetSelect(nIdx == self.nCurSelectItem)
end

function OutfitSelectCtrl:OnGridBtnClick(goGrid, gridIndex)
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
  if rtItemBefore ~= nil and self._mapItemCtrl[rtItemBefore.gameObject] ~= nil then
    self._mapItemCtrl[rtItemBefore.gameObject]:SetSelect(false)
  end
  if self._mapItemCtrl[goGrid] ~= nil then
    self._mapItemCtrl[goGrid]:SetSelect(true)
  end
  self.nCurSelectItem = nIdx
  self:RefreshInfo(self._tbItem[nIdx])
end

function OutfitSelectCtrl:SwitchTab()
  self._mapNode.DiscSkill:SetActive(self.nCurTab == 1)
  self._mapNode.DiscNote:SetActive(self.nCurTab == 2)
end

function OutfitSelectCtrl:OnBtnClick_Close(btn)
  EventManager.Hit("CancelUseItem")
  self.animator:Play("t_window_04_t_out")
end

function OutfitSelectCtrl:OnBtnClick_Confirm(btn)
  local nItemId = self._tbItem[self.nCurSelectItem].nId
  local nUseName = ConfigTable.GetData_Item(self.nUseItemTid).Title
  local nItemName = ConfigTable.GetData_Item(nItemId).Title
  local msg = {
    nType = AllEnum.MessageBox.Item,
    sContent = orderedFormat(ConfigTable.GetUIText("Consumable_ConfirmTipDisc"), nUseName, nItemName),
    tbItem = {
      [1] = {nTid = nItemId, nCount = 1}
    },
    callbackConfirm = function()
      EventManager.Hit("ConfirmUseItem", self.nUseItemTid, 1, nItemId)
    end,
    bBlur = false
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function OutfitSelectCtrl:OnBtnClick_Tab(btn, nIndex)
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

function OutfitSelectCtrl:OnBtnClick_Prev(btn, nIndex)
  if self.tbSubLayer and self.tbSubLayer[nIndex] == 1 then
    return
  end
  self.tbSubLayer[nIndex] = self.tbSubLayer[nIndex] - 1
  self:RefreshSubSkill()
end

function OutfitSelectCtrl:OnBtnClick_Next(btn, nIndex)
  if self.tbSubMaxLayer and self.tbSubLayer and self.tbSubLayer[nIndex] == self.tbSubMaxLayer[nIndex] then
    return
  end
  self.tbSubLayer[nIndex] = self.tbSubLayer[nIndex] + 1
  self:RefreshSubSkill()
end

function OutfitSelectCtrl:OnLinkClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

function OutfitSelectCtrl:OnBtnClick_Note(btn, nIndex)
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

function OutfitSelectCtrl:OnBtnClick_Sample(btn)
  local tbId = {}
  for _, v in ipairs(self._tbItem) do
    table.insert(tbId, v.nId)
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.DiscSample, self.mapSelectDisc.nId, false, tbId)
end

function OutfitSelectCtrl:RefreshInfo(mapDisc)
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

function OutfitSelectCtrl:RefreshSkill()
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

function OutfitSelectCtrl:RefreshSubSkill()
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

return OutfitSelectCtrl

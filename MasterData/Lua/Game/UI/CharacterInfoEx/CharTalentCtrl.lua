local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local CharTalentCtrl = class("CharTalentCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local WwiseAudioManager = CS.WwiseAudioManager.Instance
local LocalData = require("GameCore.Data.LocalData")
local newDayTime = UTILS.GetDayRefreshTimeOffset()
CharTalentCtrl._mapNodeConfig = {
  root_canvas_group = {
    sComponentName = "CanvasGroup"
  },
  anim = {
    sNodeName = "root_canvas_group",
    sComponentName = "Animator"
  },
  rawImg = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  btn_FullScreen_PlayBtnUIShowAnim = {},
  btnUIShow = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_UIShow"
  },
  btnUIHide = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_UIHide"
  },
  tmpUIShow = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_ShowUI"
  },
  KeyNode = {
    nCount = 5,
    sCtrlName = "Game.UI.CharacterInfoEx.TalentKeyNodeCtrl"
  },
  btnKey = {
    nCount = 5,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Key"
  },
  btnBack = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Back"
  },
  btnBackBlank = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Back"
  },
  btnHome = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Home"
  },
  animRoot = {sNodeName = "root", sComponentName = "Animator"},
  tmpGroupName = {sComponentName = "TMP_Text"},
  tmpGroupDesc = {sComponentName = "TMP_Text"},
  tmpGroupDesc_Link = {
    sNodeName = "tmpGroupDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnBtnClick_Word"
  },
  animGroupNode = {sComponentName = "Animator"},
  imgGroupNode = {sComponentName = "Image"},
  tbImgNode = {
    sNodeName = "imgNode",
    nCount = 10,
    sComponentName = "Image"
  },
  tbAnimNode = {
    sNodeName = "imgNode",
    nCount = 10,
    sComponentName = "Animator"
  },
  btnPrev = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_PrevGroup"
  },
  btnNext = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NextGroup"
  },
  animDetailText = {
    sNodeName = "DetailTextAnim",
    sComponentName = "Animator"
  },
  tmpProgress = {sComponentName = "TMP_Text"},
  goNext = {
    sNodeName = "imgNextDescDb"
  },
  tmpNextDesc = {sComponentName = "TMP_Text"},
  tmpNextDesc_Link = {
    sNodeName = "tmpNextDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnBtnClick_Word"
  },
  btnMoreInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_MoreInfo"
  },
  btnRequireItem = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_RequireItem"
  },
  rtBtnRequireItem = {
    sNodeName = "btnRequireItem",
    sComponentName = "RectTransform"
  },
  imgItemRare = {sComponentName = "Image"},
  imgItemIcon = {sComponentName = "Image"},
  tmpNum_Has_Require = {sComponentName = "TMP_Text"},
  tmpAllDone = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharTalent_Actived"
  },
  rtTmpAllDone = {
    sNodeName = "tmpAllDone",
    sComponentName = "RectTransform"
  },
  btnActivate = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Activate"
  },
  imgActivateDb = {sComponentName = "Image"},
  tmpActivate = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharTalent_Btn_Active"
  },
  tmpWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharTalent_MoreInfoWindowTitle"
  },
  tbBtnTab = {
    nCount = 6,
    sNodeName = "btnTab",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tab"
  },
  tbImgIconDb = {
    nCount = 6,
    sNodeName = "imgIconDb",
    sComponentName = "Image"
  },
  tbTmpTalentGroupName = {
    nCount = 6,
    sNodeName = "tmpTalentGroupName",
    sComponentName = "TMP_Text"
  },
  tbSelect = {
    nCount = 6,
    sNodeName = "select",
    sComponentName = "GameObject"
  },
  canvasGroup_All = {
    sNodeName = "goRight_All",
    sComponentName = "CanvasGroup"
  },
  tmpTitleAll = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharTalentMoreInfo_AllGroupOn"
  },
  grid_all = {},
  trContentAll = {sComponentName = "Transform"},
  canvasGroup_TalentGroup = {
    sNodeName = "goRight_TalentGroup",
    sComponentName = "CanvasGroup"
  },
  tmpTitleGroup = {sComponentName = "TMP_Text"},
  trListOn = {sNodeName = "list_on", sComponentName = "Transform"},
  tmpTitleGroup_On = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharTalentMoreInfo_SingleGroupOn"
  },
  tmpGroupProgress = {sComponentName = "TMP_Text"},
  grid_on = {},
  goSplitLine = {},
  trListOff = {sNodeName = "list_off", sComponentName = "Transform"},
  tmpTitleGroup_Off = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharTalentMoreInfo_SingleGroupOff"
  },
  grid_off = {}
}
CharTalentCtrl._mapEventConfig = {
  [EventId.CharRelatePanelOpen] = "OnEvent_CharRelatePanelOpen",
  [EventId.CharBgRefresh] = "OnEvent_SwitchCurChar"
}

function CharTalentCtrl:Awake()
  self:SetAllVisibale(false)
  self.bUIVisible = true
  self.nCurGroupIndex = 1
  self.nGroupNum = #self._mapNode.KeyNode
end

function CharTalentCtrl:OnEnable()
  if self._panel.nPanelId == PanelId.CharTalent then
    self:SetAllVisibale(true)
    self._mapNode.anim:Play("CharTalent_Root_in")
    self:BuildUIData()
    self:RefreshAll()
  end
end

function CharTalentCtrl:OnDisable()
  Actor2DManager.UnsetActor2D(false, 2, true)
end

function CharTalentCtrl:SetAllVisibale(bVisible)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.root_canvas_group, bVisible == true and 1 or 0)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.root_canvas_group, bVisible == true)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.root_canvas_group, bVisible == true)
end

function CharTalentCtrl:BuildUIData()
  self.nCharId = self._panel.nCharId
  self.tbGroup = PlayerData.Talent:GetSortedTalentGroup(self.nCharId)
  local mapCfgData_Character = ConfigTable.GetData("Character", self.nCharId)
  local mapCfgData_CharGrade = ConfigTable.GetData("CharGrade", mapCfgData_Character.Grade)
  self.nItemId = mapCfgData_Character.FragmentsId
  self.nItemNum = mapCfgData_CharGrade.FragmentsQty
  self.tbAttr = {}
  for i, v in ipairs(self.tbGroup) do
    local nGroupId = v.nId
    local nActivated = v.nNormalCount
    local tbTalent = {}
    local mapTalent = CacheTable.GetData("_Talent", nGroupId)
    for kk, vv in pairs(mapTalent) do
      if vv.Type == GameEnum.talentType.OrdinaryNode then
        table.insert(tbTalent, {
          nId = vv.Id,
          nSort = vv.Sort
        })
      end
    end
    table.sort(tbTalent, function(a, b)
      return a.nSort < b.nSort
    end)
    local tbTalentAttr_On, tbTalentAttr_Off = {}, {}
    local mapTalentAttr_On, mapTalentAttr_Off = {}, {}
    for iii, vvv in ipairs(tbTalent) do
      local tbTalentEffectDesc = PlayerData.Talent:GetTalentAttributeDesc(vvv.nId)
      local mapTalentAttr = nActivated >= iii and mapTalentAttr_On or mapTalentAttr_Off
      for _, mapDesc in ipairs(tbTalentEffectDesc) do
        if mapTalentAttr[mapDesc.nEftDescId] == nil then
          mapTalentAttr[mapDesc.nEftDescId] = {
            nEftDescId = mapDesc.nEftDescId,
            nValueNum = mapDesc.nValueNum
          }
        else
          mapTalentAttr[mapDesc.nEftDescId].nValueNum = mapTalentAttr[mapDesc.nEftDescId].nValueNum + mapDesc.nValueNum
        end
      end
    end
    for nEftDescId, mapAttr in pairs(mapTalentAttr_On) do
      table.insert(tbTalentAttr_On, {
        nEftDescId = mapAttr.nEftDescId,
        nValueNum = mapAttr.nValueNum
      })
    end
    for nEftDescId, mapAttr in pairs(mapTalentAttr_Off) do
      table.insert(tbTalentAttr_Off, {
        nEftDescId = mapAttr.nEftDescId,
        nValueNum = mapAttr.nValueNum
      })
    end
    table.sort(tbTalentAttr_On, function(a, b)
      return a.nEftDescId < b.nEftDescId
    end)
    table.sort(tbTalentAttr_Off, function(a, b)
      return a.nEftDescId < b.nEftDescId
    end)
    table.insert(self.tbAttr, {tbTalentAttr_On, tbTalentAttr_Off})
  end
  self:CheckL2DStatus()
end

function CharTalentCtrl:RefreshAll(nUIState)
  self:SetL2D()
  self:SetBtnUIShowHide()
  self:SetOverview()
  self:SetDetail(nUIState)
  self:SetMoreInfo()
end

function CharTalentCtrl:CheckGroupState(bLock, nNormalCount, nNodeLimit)
  local nState = 1
  if bLock == true then
    nState = 1
  else
    nState = nNodeLimit <= nNormalCount and 3 or 2
  end
  return nState
end

function CharTalentCtrl:GetCurTalentId(nGroupId, nNormalCount)
  local tbTalent = {}
  local mapTalent = CacheTable.GetData("_Talent", nGroupId)
  for k, v in pairs(mapTalent) do
    if v.Type == GameEnum.talentType.OrdinaryNode then
      table.insert(tbTalent, {
        nId = v.Id,
        nSort = v.Sort
      })
    end
  end
  table.sort(tbTalent, function(a, b)
    return a.nSort < b.nSort
  end)
  local mapTempTalentData = tbTalent[nNormalCount + 1]
  if mapTempTalentData ~= nil then
    return mapTempTalentData.nId
  else
    return nil
  end
end

function CharTalentCtrl:CheckL2DStatus()
  self.nL2DStatus = 0
  for i, v in ipairs(self.tbGroup) do
    local mapCfgData_TalentGroup = ConfigTable.GetData("TalentGroup", v.nId)
    if v.nNormalCount == mapCfgData_TalentGroup.NodeLimit then
      self.nL2DStatus = self.nL2DStatus + 1
    end
  end
end

function CharTalentCtrl:OnEvent_CharRelatePanelOpen(nNextPanel, nCharId)
  local bIsThis = nNextPanel == PanelId.CharTalent
  self:SetAllVisibale(bIsThis == true)
  if bIsThis == true then
    self._mapNode.anim:Play(bIsThis == true and "CharTalent_Root_in" or "CharTalent_Root_out")
    self:BuildUIData()
    self:RefreshAll()
  end
end

function CharTalentCtrl:SetL2D()
  Actor2DManager.SetActor2D(self:GetPanelId(), self._mapNode.rawImg, self.nCharId, nil, {
    "TalentL2D",
    self.nL2DStatus
  }, 2)
end

function CharTalentCtrl:OnEvent_SwitchCurChar(nPanelId, nCharId)
  if nPanelId == PanelId.CharTalent then
    self:BuildUIData()
    self:RefreshAll()
  end
end

function CharTalentCtrl:SetBtnUIShowHide()
  self._mapNode.btn_FullScreen_PlayBtnUIShowAnim:SetActive(self.bUIVisible == false)
  self._mapNode.btnUIShow.gameObject:SetActive(self.bUIVisible == false)
  self._mapNode.btnUIHide.gameObject:SetActive(self.bUIVisible == true)
end

function CharTalentCtrl:OnBtnClick_UIShow(btn)
  if self.bUIVisible == false then
    self.bUIVisible = true
    self:SetBtnUIShowHide()
    EventManager.Hit("ChangeCharTopBar", true)
    EventManager.Hit("ChangeCharFgTab", true)
    self._mapNode.anim:Play("CharTalent_Root_show")
    EventManager.Hit(EventId.TemporaryBlockInput, 1)
  end
end

function CharTalentCtrl:OnBtnClick_UIHide(btn)
  if self.bUIVisible == true then
    self.bUIVisible = false
    self:SetBtnUIShowHide()
    EventManager.Hit("ChangeCharTopBar", false)
    EventManager.Hit("ChangeCharFgTab", false)
    self._mapNode.anim:Play("CharTalent_Root_hide")
    EventManager.Hit(EventId.TemporaryBlockInput, 1)
  end
end

function CharTalentCtrl:SetOverview()
  for i = 1, self.nGroupNum do
    local mapGroupData = self.tbGroup[i]
    local mapCfgData_TalentGroup = ConfigTable.GetData("TalentGroup", mapGroupData.nId)
    local objCtrlKeyNode = self._mapNode.KeyNode[i]
    if mapGroupData ~= nil and mapCfgData_TalentGroup ~= nil and objCtrlKeyNode ~= nil then
      local nState = self:CheckGroupState(mapGroupData.bLock, mapGroupData.nNormalCount, mapCfgData_TalentGroup.NodeLimit)
      objCtrlKeyNode:Refresh(mapGroupData.nId, i, nState)
    end
  end
end

function CharTalentCtrl:OnBtnClick_Key(btn, nIndex)
  self.nCurGroupIndex = nIndex
  self:SetDetail()
  EventManager.Hit("ChangeCharFgTab", false)
  EventManager.Hit("ChangeCharTopBar", false)
  self._mapNode.anim:Play("CharTalent_Root_o2d")
end

function CharTalentCtrl:SetDetail(nUIState)
  local mapGroupData = self.tbGroup[self.nCurGroupIndex]
  self.nCurGroupId = mapGroupData.nId
  local mapCfgData_TalentGroup = ConfigTable.GetData("TalentGroup", self.nCurGroupId)
  local nHasNum = PlayerData.Item:GetItemCountByID(self.nItemId)
  self.bEnoughNum = nHasNum >= self.nItemNum
  local _n = math.floor(nHasNum / self.nItemNum)
  if _n > mapCfgData_TalentGroup.NodeLimit - mapGroupData.nNormalCount then
    _n = mapCfgData_TalentGroup.NodeLimit - mapGroupData.nNormalCount
  end
  local nCanActivateNum = self.bEnoughNum == true and _n or 1
  local nAsPossibleAsCan = self.bEnoughNum == true and _n * self.nItemNum or self.nItemNum
  self.nConsumeNum = nAsPossibleAsCan
  if mapGroupData.bLock == true then
    nAsPossibleAsCan = self.nItemNum * mapCfgData_TalentGroup.NodeLimit
  end
  NovaAPI.SetTMPText(self._mapNode.tmpGroupName, string.format("%02d %s", self.nCurGroupIndex, mapCfgData_TalentGroup.Title))
  local nState = self:CheckGroupState(mapGroupData.bLock, mapGroupData.nNormalCount, mapCfgData_TalentGroup.NodeLimit)
  self:SetAtlasSprite(self._mapNode.imgGroupNode, "11_ico", "zs_talent_star_l_" .. tostring(nState))
  if nUIState ~= 1 then
    self._mapNode.animGroupNode:Play("empty")
    self._mapNode.imgGroupNode.transform:GetChild(0).localScale = Vector3.zero
  end
  for i = 1, mapCfgData_TalentGroup.NodeLimit do
    if self._mapNode.tbImgNode[i] ~= nil then
      local _name = "zs_talent_progress_1"
      if mapGroupData.bLock ~= true then
        if i <= mapGroupData.nNormalCount then
          _name = "zs_talent_progress_3"
        elseif nCanActivateNum >= i - mapGroupData.nNormalCount then
          _name = "zs_talent_progress_2"
        end
      end
      self:SetAtlasSprite(self._mapNode.tbImgNode[i], "11_ico", _name)
      if nUIState ~= 1 then
        self._mapNode.tbAnimNode[i]:Play("empty")
        self._mapNode.tbImgNode[i].transform:GetChild(0).localScale = Vector3.zero
      end
    end
  end
  local mapCfgData_Talent = ConfigTable.GetData("Talent", mapGroupData.nKeyTalent)
  NovaAPI.SetTMPText(self._mapNode.tmpGroupDesc, UTILS.ParseDesc(mapCfgData_Talent))
  local s = string.format(" %s/%s", tostring(mapGroupData.nNormalCount), tostring(mapCfgData_TalentGroup.NodeLimit))
  NovaAPI.SetTMPText(self._mapNode.tmpProgress, ConfigTable.GetUIText("CharTalent_ConditionDesc") .. s)
  self._mapNode.goNext:SetActive(nState == 2)
  self._mapNode.btnRequireItem.gameObject:SetActive(nState ~= 3)
  self._mapNode.btnActivate.gameObject:SetActive(nState == 2)
  if nState ~= 3 then
    self.nCurTalentId = self:GetCurTalentId(self.nCurGroupId, mapGroupData.nNormalCount)
    if self.nCurTalentId ~= nil then
      mapCfgData_Talent = ConfigTable.GetData("Talent", self.nCurTalentId)
      NovaAPI.SetTMPText(self._mapNode.tmpNextDesc, ConfigTable.GetUIText("CharTalent_NextNode") .. UTILS.ParseDesc(mapCfgData_Talent))
    end
  end
  local mapCfgData_Item = ConfigTable.GetData("Item", self.nItemId)
  self:SetSprite_FrameColor(self._mapNode.imgItemRare, mapCfgData_Item.Rarity, AllEnum.FrameType_New.Item, false)
  self:SetPngSprite(self._mapNode.imgItemIcon, mapCfgData_Item.Icon)
  if mapGroupData.bLock == true then
    NovaAPI.SetTMPText(self._mapNode.tmpNum_Has_Require, tostring(self.nItemNum * mapCfgData_TalentGroup.NodeLimit))
  else
    local sItemNumFormat = self.bEnoughNum == true and "%s/%s" or "<color=#BD3059>%s</color>/%s"
    NovaAPI.SetTMPText(self._mapNode.tmpNum_Has_Require, string.format(sItemNumFormat, tostring(nHasNum), tostring(self.nItemNum)))
  end
  local sBtnDb = mapGroupData.bLock ~= true and self.bEnoughNum == true and "btn_common_db_m_1" or "btn_common_db_m_2"
  self:SetAtlasSprite(self._mapNode.imgActivateDb, "06_btn", sBtnDb)
  local _, color = ColorUtility.TryParseHtmlString(mapGroupData.bLock ~= true and self.bEnoughNum == true and "#FFFFFF" or "#94AAC0")
  NovaAPI.SetTMPColor(self._mapNode.tmpActivate, color)
  NovaAPI.SetTMPText(self._mapNode.tmpAllDone, ConfigTable.GetUIText(nState == 1 and "CharTalent_PreNodeLocked" or "CharTalent_Actived"))
  self._mapNode.rtTmpAllDone.anchoredPosition = nState == 1 and Vector2(12, -282) or Vector2(0, -438)
  self._mapNode.rtBtnRequireItem.anchoredPosition = nState == 1 and Vector2(0, -406) or Vector2(0, -293)
  self._mapNode.tmpAllDone.transform.localScale = nState ~= 2 and Vector3.one or Vector3.zero
  if nUIState == 1 then
    self._mapNode.animDetailText:Play("CharTalent_Text_in")
  end
  if nUIState == 2 then
    self._mapNode.animRoot:Play("CharTalent_Switch_in")
  end
end

function CharTalentCtrl:PlaySwitchGroupPrevNxtAnim()
  local sequence = DOTween.Sequence()
  sequence:AppendInterval(0.1)
  sequence:AppendCallback(dotween_callback_handler(self, self._PlayFX, self._mapNode.animRoot, 4))
  sequence:AppendInterval(0.1)
  sequence:AppendCallback(dotween_callback_handler(self, self.SetDetail, 2))
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function CharTalentCtrl:OnBtnClick_Back(btn)
  EventManager.Hit("ChangeCharFgTab", true)
  EventManager.Hit("ChangeCharTopBar", true)
  self._mapNode.anim:Play("CharTalent_Root_d2o")
end

function CharTalentCtrl:OnBtnClick_Home(btn)
  PanelManager.Home()
end

function CharTalentCtrl:OnBtnClick_PrevGroup(btn)
  self.nCurGroupIndex = self.nCurGroupIndex - 1
  if self.nCurGroupIndex < 1 then
    self.nCurGroupIndex = self.nGroupNum
  end
  self:PlaySwitchGroupPrevNxtAnim()
end

function CharTalentCtrl:OnBtnClick_NextGroup(btn)
  self.nCurGroupIndex = self.nCurGroupIndex + 1
  if self.nCurGroupIndex > self.nGroupNum then
    self.nCurGroupIndex = 1
  end
  self:PlaySwitchGroupPrevNxtAnim()
end

function CharTalentCtrl:SetMoreInfo()
  for i = 1, 6 do
    if i == 1 then
      NovaAPI.SetTMPText(self._mapNode.tbTmpTalentGroupName[i], ConfigTable.GetUIText("Filter_All"))
    else
      local mapGroupData = self.tbGroup[i - 1]
      local mapCfgData_TalentGroup = ConfigTable.GetData("TalentGroup", mapGroupData.nId)
      self:SetAtlasSprite(self._mapNode.tbImgIconDb[i], "11_ico", mapGroupData.bLock == true and "zs_talent info_title_dis" or "zs_talent info_title")
      NovaAPI.SetTMPText(self._mapNode.tbTmpTalentGroupName[i], mapCfgData_TalentGroup.Title)
    end
  end
  self:OnBtnClick_Tab(nil, 1)
end

function CharTalentCtrl:_DelChildFromTheLast(tr, nEndIdx)
  local nChildCount = tr.childCount - 1
  for i = nChildCount, nEndIdx, -1 do
    destroy(tr:GetChild(i).gameObject)
  end
end

function CharTalentCtrl:_SetGridAttr(goTemplate, trParent, mapAttr)
  local go = instantiate(goTemplate, trParent)
  local tr = go.transform
  tr:SetAsLastSibling()
  local mapCfgData_EffectDesc = ConfigTable.GetData("EffectDesc", mapAttr.nEftDescId)
  local sValue = FormatEffectValue(mapAttr.nValueNum, mapCfgData_EffectDesc.isPercent, mapCfgData_EffectDesc.Format)
  if mapAttr.nValueNum > 0 then
    sValue = "+" .. sValue
  end
  self:SetPngSprite(tr:Find("imgIcon"):GetComponent("Image"), mapCfgData_EffectDesc.Icon)
  NovaAPI.SetTMPText(tr:Find("tmpName"):GetComponent("TMP_Text"), mapCfgData_EffectDesc.Desc)
  NovaAPI.SetTMPText(tr:Find("tmpValue"):GetComponent("TMP_Text"), sValue)
  go:SetActive(true)
end

function CharTalentCtrl:OnBtnClick_MoreInfo(btn)
  self:OnBtnClick_Tab(nil, 1)
end

function CharTalentCtrl:OnBtnClick_Tab(btn, nIndex)
  for i = 1, 6 do
    self._mapNode.tbSelect[i]:SetActive(i == nIndex)
  end
  if self.tw ~= nil then
    self.tw:Kill()
    self.tw = nil
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup_All, 0)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup_TalentGroup, 0)
  self.tw = NovaAPI.SetCanvasGroupDoFade(nIndex == 1 and self._mapNode.canvasGroup_All or self._mapNode.canvasGroup_TalentGroup, 1, 0.5, true)
  local tbAttrOn, tbAttrOff, mapAttrOn, mapAttrOff = {}, {}, {}, {}
  if nIndex == 1 then
    for nGroupIndex, tbOnOff in ipairs(self.tbAttr) do
      local tbTalentAttr_On = tbOnOff[1]
      for nEftIndex, mapEftData in ipairs(tbTalentAttr_On) do
        if mapAttrOn[mapEftData.nEftDescId] == nil then
          mapAttrOn[mapEftData.nEftDescId] = {
            nEftDescId = mapEftData.nEftDescId,
            nValueNum = mapEftData.nValueNum
          }
        else
          mapAttrOn[mapEftData.nEftDescId].nValueNum = mapAttrOn[mapEftData.nEftDescId].nValueNum + mapEftData.nValueNum
        end
      end
      local tbTalentAttr_Off = tbOnOff[2]
      for nEftIndex, mapEftData in ipairs(tbTalentAttr_Off) do
        if mapAttrOn[mapEftData.nEftDescId] == nil then
          mapAttrOff[mapEftData.nEftDescId] = {
            nEftDescId = mapEftData.nEftDescId,
            nValueNum = 0
          }
        end
      end
    end
    for nEftDescId, mapEftData in pairs(mapAttrOn) do
      table.insert(tbAttrOn, mapEftData)
    end
    table.sort(tbAttrOn, function(a, b)
      return a.nEftDescId < b.nEftDescId
    end)
    for nEftDescId, mapEftData in pairs(mapAttrOff) do
      table.insert(tbAttrOff, mapEftData)
    end
    table.sort(tbAttrOff, function(a, b)
      return a.nEftDescId < b.nEftDescId
    end)
    for _nOffIdx, _mapOffData in ipairs(tbAttrOff) do
      table.insert(tbAttrOn, _mapOffData)
    end
    self:_DelChildFromTheLast(self._mapNode.trContentAll, 0)
    for _, mapAttr in ipairs(tbAttrOn) do
      self:_SetGridAttr(self._mapNode.grid_all, self._mapNode.trContentAll, mapAttr)
    end
    LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.trContentAll)
  else
    local mapGroupData = self.tbGroup[nIndex - 1]
    local mapCfgData_TalentGroup = ConfigTable.GetData("TalentGroup", mapGroupData.nId)
    NovaAPI.SetTMPText(self._mapNode.tmpTitleGroup, mapCfgData_TalentGroup.Title)
    local s = string.format(" %s/%s", tostring(mapGroupData.nNormalCount), tostring(mapCfgData_TalentGroup.NodeLimit))
    NovaAPI.SetTMPText(self._mapNode.tmpGroupProgress, ConfigTable.GetUIText("CharTalent_ConditionDesc") .. s)
    tbAttrOn = self.tbAttr[nIndex - 1][1]
    tbAttrOff = self.tbAttr[nIndex - 1][2]
    self:_DelChildFromTheLast(self._mapNode.trListOn, 2)
    self:_DelChildFromTheLast(self._mapNode.trListOff, 2)
    for _, mapAttr in ipairs(tbAttrOn) do
      self:_SetGridAttr(self._mapNode.grid_on, self._mapNode.trListOn, mapAttr)
    end
    for _, mapAttr in ipairs(tbAttrOff) do
      self:_SetGridAttr(self._mapNode.grid_off, self._mapNode.trListOff, mapAttr)
    end
    LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.trListOn)
    LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.trListOff)
    self._mapNode.trListOn.gameObject:SetActive(0 < #tbAttrOn)
    self._mapNode.goSplitLine:SetActive(0 < #tbAttrOn and 0 < #tbAttrOff)
    self._mapNode.trListOff.gameObject:SetActive(0 < #tbAttrOff)
  end
end

function CharTalentCtrl:OnBtnClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

function CharTalentCtrl:OnBtnClick_RequireItem(btn)
  UTILS.ClickItemGridWithTips(self.nItemId, self._mapNode.btnRequireItem.transform, true)
end

function CharTalentCtrl:OnBtnClick_Activate(btn)
  local mapGroupData = self.tbGroup[self.nCurGroupIndex]
  if mapGroupData == nil then
    printLog("Talent group data error.")
    return
  end
  if mapGroupData.bLock == true then
    printLog("This talent group need unlock.")
    return
  end
  local mapCfgData_Item = ConfigTable.GetData("Item", self.nItemId)
  if self.bEnoughNum ~= true then
    WwiseAudioManager:PostEvent("ui_common_button_error")
    EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("CharTalent_NotEnoughItem"), mapCfgData_Item.Title))
    printLog("Not enough item number.")
    return
  end
  local mapCfgData_TalentGroup = ConfigTable.GetData("TalentGroup", self.nCurGroupId)
  WwiseAudioManager:PostEvent("ui_charInfo_talent_click")
  local nPlayFxFrom = mapGroupData.nNormalCount + 1
  
  local function confirmCallback()
    local function callback()
      self:BuildUIData()
      
      self._mapNode.btnActivate.gameObject:SetActive(false)
      local nPlayFxTo = self.tbGroup[self.nCurGroupIndex].nNormalCount
      local nDuration = 0
      local nInterval = 0.1
      local sequence = DOTween.Sequence()
      sequence:AppendInterval(nInterval)
      WwiseAudioManager:PostEvent(nPlayFxTo >= mapCfgData_TalentGroup.NodeLimit and "ui_charInfo_talent_active_large_part1" or "ui_charInfo_talent_active_small")
      for i = nPlayFxFrom, nPlayFxTo do
        sequence:AppendCallback(dotween_callback_handler(self, self._PlayFX, self._mapNode.tbAnimNode[i], 1))
        sequence:AppendInterval(nInterval)
        nDuration = nDuration + nInterval
      end
      sequence:AppendCallback(dotween_callback_handler(self, self._PlayFX, self._mapNode.animDetailText, 3))
      if nPlayFxTo >= mapCfgData_TalentGroup.NodeLimit then
        sequence:AppendCallback(dotween_callback_handler(self, self._PlayFX, self._mapNode.animGroupNode, 2))
      end
      sequence:AppendInterval(0.7)
      nDuration = nDuration + 0.7
      sequence:AppendCallback(dotween_callback_handler(self, self.RefreshAll, 1))
      EventManager.Hit(EventId.TemporaryBlockInput, nDuration)
    end
    
    PlayerData.Talent:SendTalentGroupUnlockSetReq(self.nCharId, mapGroupData.nId, callback)
  end
  
  if self.nConsumeNum == self.nItemNum then
    confirmCallback()
    return
  end
  local TipsTime = LocalData.GetPlayerLocalData("CharTalentActivate")
  local _tipDay = 0
  if TipsTime ~= nil then
    _tipDay = tonumber(TipsTime)
  end
  local curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  local fixedTimeStamp = curTimeStamp + newDayTime * 3600
  local nYear = tonumber(os.date("!%Y", fixedTimeStamp))
  local nMonth = tonumber(os.date("!%m", fixedTimeStamp))
  local nDay = tonumber(os.date("!%d", fixedTimeStamp))
  local nowD = nYear * 366 + nMonth * 31 + nDay
  if nowD == _tipDay then
    confirmCallback()
  else
    local isSelectAgain = false
    
    local function _tempCallback()
      if isSelectAgain then
        local _curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
        local _fixedTimeStamp = _curTimeStamp + newDayTime * 3600
        local _nYear = tonumber(os.date("!%Y", _fixedTimeStamp))
        local _nMonth = tonumber(os.date("!%m", _fixedTimeStamp))
        local _nDay = tonumber(os.date("!%d", _fixedTimeStamp))
        local _nowD = _nYear * 366 + _nMonth * 31 + _nDay
        LocalData.SetPlayerLocalData("CharTalentActivate", tostring(_nowD))
      end
      confirmCallback()
    end
    
    local function againCallback(isSelect)
      isSelectAgain = isSelect
    end
    
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = orderedFormat(ConfigTable.GetUIText("CharTalent_ActivateConfirm"), tostring(self.nConsumeNum), mapCfgData_Item.Title, mapCfgData_TalentGroup.Title),
      callbackConfirm = _tempCallback,
      sAgain = ConfigTable.GetUIText("MessageBox_TodayWarning"),
      callbackAgain = againCallback
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
end

function CharTalentCtrl:_PlayFX(anim, n)
  local tbAnimName = {
    "TalentNode_Unlock",
    "TalentGroupNode_Unlock",
    "CharTalent_Text_out",
    "CharTalent_Switch_out"
  }
  anim:Play(tbAnimName[n])
  if n == 2 then
    WwiseAudioManager:PostEvent("ui_charInfo_talent_active_large_part2")
  end
end

return CharTalentCtrl

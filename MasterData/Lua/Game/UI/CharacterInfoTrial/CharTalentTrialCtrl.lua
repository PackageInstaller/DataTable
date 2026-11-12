local WwiseAudioManager = CS.WwiseAudioManager.Instance
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local CharTalentTrialCtrl = class("CharTalentTrialCtrl", BaseCtrl)
CharTalentTrialCtrl._mapNodeConfig = {
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
  tmpGroupName = {sComponentName = "TMP_Text"},
  tmpGroupDesc = {sComponentName = "TMP_Text"},
  tmpGroupDesc_Link = {
    sNodeName = "tmpGroupDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnBtnClick_Word"
  },
  imgGroupNode = {sComponentName = "Image"},
  imgNode = {nCount = 10, sComponentName = "Image"},
  btnPrev = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_PrevGroup"
  },
  btnNext = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NextGroup"
  },
  animRoot = {sNodeName = "root", sComponentName = "Animator"},
  animGroupNode = {sComponentName = "Animator"},
  tbAnimNode = {
    sNodeName = "imgNode",
    nCount = 10,
    sComponentName = "Animator"
  },
  animDetailText = {
    sNodeName = "DetailTextAnim",
    sComponentName = "Animator"
  }
}
CharTalentTrialCtrl._mapEventConfig = {
  [EventId.CharRelatePanelOpen] = "OnEvent_CharRelatePanelOpen"
}

function CharTalentTrialCtrl:RefreshAll(nUIState)
  self:SetL2D()
  self:SetBtnUIShowHide()
  self:SetOverview()
  self:SetDetail(nUIState)
end

function CharTalentTrialCtrl:BuildUIData()
  self.nCharId = self._panel.nCharId
  self.tbGroup = {}
  local tbTalent, tbGroup = PlayerData.Talent:CreateNewTalentData(self.nCharId)
  local nFirstGroup = tbTalent.nFirstGroup
  local mapCurGroup = tbGroup[nFirstGroup]
  while mapCurGroup do
    table.insert(self.tbGroup, mapCurGroup)
    mapCurGroup = tbGroup[mapCurGroup.nNext]
  end
  local mapCfgData_Character = ConfigTable.GetData("Character", self.nCharId)
  local mapCfgData_CharGrade = ConfigTable.GetData("CharGrade", mapCfgData_Character.Grade)
  self.nItemId = mapCfgData_Character.FragmentsId
  self.nItemNum = mapCfgData_CharGrade.FragmentsQty
  self:CheckL2DStatus()
end

function CharTalentTrialCtrl:CheckL2DStatus()
  self.nL2DStatus = 0
  for i, v in ipairs(self.tbGroup) do
    local mapCfgData_TalentGroup = ConfigTable.GetData("TalentGroup", v.nId)
    if v.nNormalCount == mapCfgData_TalentGroup.NodeLimit then
      self.nL2DStatus = self.nL2DStatus + 1
    end
  end
end

function CharTalentTrialCtrl:SetAllVisibale(bVisible)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.root_canvas_group, bVisible == true and 1 or 0)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.root_canvas_group, bVisible == true)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.root_canvas_group, bVisible == true)
end

function CharTalentTrialCtrl:SetL2D()
  local nCharSkinId = ConfigTable.GetData_Character(self.nCharId).DefaultSkinId
  Actor2DManager.SetActor2D(self:GetPanelId(), self._mapNode.rawImg, self.nCharId, nCharSkinId, {
    "TalentL2D",
    self.nL2DStatus
  }, 2)
end

function CharTalentTrialCtrl:SetBtnUIShowHide()
  self._mapNode.btn_FullScreen_PlayBtnUIShowAnim:SetActive(self.bUIVisible == false)
  self._mapNode.btnUIShow.gameObject:SetActive(self.bUIVisible == false)
  self._mapNode.btnUIHide.gameObject:SetActive(self.bUIVisible == true)
end

function CharTalentTrialCtrl:CheckGroupState(bLock, nNormalCount, nNodeLimit)
  local nState = 1
  if bLock == true then
    nState = 1
  else
    nState = nNodeLimit <= nNormalCount and 3 or 2
  end
  return nState
end

function CharTalentTrialCtrl:GetCurTalentId(nGroupId, nNormalCount)
  local tbTalent = {}
  local mapTalent = CacheTable.GetData("_Talent", nGroupId)
  for k, v in pairs(mapTalent) do
    if v.Type == GameEnum.talentType.OrdinaryNode then
      table.insert(tbTalent, {
        nId = v.Id,
        nSort = v.Sort,
        nIndex = v.Index
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

function CharTalentTrialCtrl:Awake()
  self:SetAllVisibale(false)
  self.bUIVisible = true
  self.nCurGroupIndex = 1
  self.nGroupNum = #self._mapNode.KeyNode
end

function CharTalentTrialCtrl:OnDisable()
  Actor2DManager.UnsetActor2D(false, 2, true)
end

function CharTalentTrialCtrl:OnDestroy()
end

function CharTalentTrialCtrl:OnBtnClick_UIShow(btn)
  if self.bUIVisible == false then
    self.bUIVisible = true
    self:SetBtnUIShowHide()
    EventManager.Hit("ChangeCharTopBar", true)
    EventManager.Hit("ChangeCharFgTab", true)
    self._mapNode.anim:Play("CharTalent_Root_show")
    EventManager.Hit(EventId.TemporaryBlockInput, 1)
  end
end

function CharTalentTrialCtrl:OnBtnClick_UIHide(btn)
  if self.bUIVisible == true then
    self.bUIVisible = false
    self:SetBtnUIShowHide()
    EventManager.Hit("ChangeCharTopBar", false)
    EventManager.Hit("ChangeCharFgTab", false)
    self._mapNode.anim:Play("CharTalent_Root_hide")
    EventManager.Hit(EventId.TemporaryBlockInput, 1)
  end
end

function CharTalentTrialCtrl:SetOverview()
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

function CharTalentTrialCtrl:OnEvent_CharRelatePanelOpen(nNextPanel, nCharId)
  local bIsThis = nNextPanel == PanelId.CharTalentTrial
  self:SetAllVisibale(bIsThis == true)
  self._mapNode.anim:Play(bIsThis == true and "CharTalent_Root_in" or "CharTalent_Root_out")
  self:BuildUIData()
  self:RefreshAll()
end

function CharTalentTrialCtrl:OnBtnClick_Option(btn, nIndex)
  if self.nSelectBgIndex == nIndex then
    return
  end
  
  local function change()
    self._mapNode.imgOptionOn[self.nSelectBgIndex]:SetActive(false)
    self._mapNode.imgOptionOff[self.nSelectBgIndex]:SetActive(true)
    self._mapNode.imgOptionOn[nIndex]:SetActive(true)
    self._mapNode.imgOptionOff[nIndex]:SetActive(false)
    self.nSelectBgIndex = nIndex
  end
  
  if nIndex ~= 1 then
    local mapGroupCfg = ConfigTable.GetData("TalentGroup", self.tbGroup[nIndex - 1].nId)
    if not mapGroupCfg then
      return
    end
    local bMax = self.tbGroup[nIndex - 1].nNormalCount >= mapGroupCfg.NodeLimit
    if bMax then
      change()
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("CharTalent_BackgroundLockTip"))
    end
  else
    change()
  end
end

function CharTalentTrialCtrl:OnBtnClick_Key(btn, nIndex)
  self.nCurGroupIndex = nIndex
  self:SetDetail()
  EventManager.Hit("ChangeCharFgTab", false)
  EventManager.Hit("ChangeCharTopBar", false)
  self._mapNode.anim:Play("CharTalent_Root_o2d")
end

function CharTalentTrialCtrl:SetDetail(nUIState)
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
  NovaAPI.SetTMPText(self._mapNode.tmpGroupName, string.format("%02d %s", self.nCurGroupIndex, mapCfgData_TalentGroup.Title))
  local nState = self:CheckGroupState(mapGroupData.bLock, mapGroupData.nNormalCount, mapCfgData_TalentGroup.NodeLimit)
  self:SetAtlasSprite(self._mapNode.imgGroupNode, "11_ico", "zs_talent_star_l_" .. tostring(nState))
  if nUIState ~= 1 then
    self._mapNode.animGroupNode:Play("empty")
    self._mapNode.imgGroupNode.transform:GetChild(0).localScale = Vector3.zero
  end
  for i = 1, mapCfgData_TalentGroup.NodeLimit do
    if self._mapNode.imgNode[i] ~= nil then
      local _name = "zs_talent_progress_1"
      if mapGroupData.bLock ~= true then
        if i <= mapGroupData.nNormalCount then
          _name = "zs_talent_progress_3"
        elseif nCanActivateNum >= i - mapGroupData.nNormalCount then
          _name = "zs_talent_progress_2"
        end
      end
      self:SetAtlasSprite(self._mapNode.imgNode[i], "11_ico", _name)
    end
  end
  local mapCfgData_Talent = ConfigTable.GetData("Talent", mapGroupData.nKeyTalent)
  NovaAPI.SetTMPText(self._mapNode.tmpGroupDesc, UTILS.ParseDesc(mapCfgData_Talent))
  if nUIState == 1 then
    self._mapNode.animDetailText:Play("CharTalent_Text_in")
  end
  if nUIState == 2 then
    self._mapNode.animRoot:Play("CharTalent_Switch_in")
  end
end

function CharTalentTrialCtrl:_PlayFX(anim, n)
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

function CharTalentTrialCtrl:PlaySwitchGroupPrevNxtAnim()
  local sequence = DOTween.Sequence()
  sequence:AppendInterval(0.1)
  sequence:AppendCallback(dotween_callback_handler(self, self._PlayFX, self._mapNode.animRoot, 4))
  sequence:AppendInterval(0.3)
  sequence:AppendCallback(dotween_callback_handler(self, self.SetDetail, 2))
  EventManager.Hit(EventId.TemporaryBlockInput, 1)
end

function CharTalentTrialCtrl:OnBtnClick_Back(btn)
  EventManager.Hit("ChangeCharFgTab", true)
  EventManager.Hit("ChangeCharTopBar", true)
  self._mapNode.anim:Play("CharTalent_Root_d2o")
end

function CharTalentTrialCtrl:OnBtnClick_PrevGroup(btn)
  self.nCurGroupIndex = self.nCurGroupIndex - 1
  if self.nCurGroupIndex < 1 then
    self.nCurGroupIndex = self.nGroupNum
  end
  self:PlaySwitchGroupPrevNxtAnim()
end

function CharTalentTrialCtrl:OnBtnClick_NextGroup(btn)
  self.nCurGroupIndex = self.nCurGroupIndex + 1
  if self.nCurGroupIndex > self.nGroupNum then
    self.nCurGroupIndex = 1
  end
  self:PlaySwitchGroupPrevNxtAnim()
end

function CharTalentTrialCtrl:OnBtnClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

return CharTalentTrialCtrl

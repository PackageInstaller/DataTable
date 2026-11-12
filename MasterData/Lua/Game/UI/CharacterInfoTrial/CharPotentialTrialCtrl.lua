local CharPotentialTrialCtrl = class("CharPotentialTrialCtrl", BaseCtrl)
CharPotentialTrialCtrl._mapNodeConfig = {
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  rtRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "RectTransform"
  },
  animRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  animCard = {
    sNodeName = "PotentialCardRoot",
    sComponentName = "Animator"
  },
  PotentialCard = {
    sCtrlName = "Game.UI.StarTower.Potential.PotentialCardItemCtrl"
  },
  PotentialCard2 = {
    sCtrlName = "Game.UI.StarTower.Potential.PotentialCardItemCtrl"
  },
  svPotential = {sComponentName = "ScrollRect"},
  btnSwitch = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Switch"
  },
  SwitchOn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_Sample_SwithOn"
  },
  SwitchOff = {
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_Sample_SwithOff"
  },
  tab = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplateTabCtrl"
  },
  btnTab = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tab"
  },
  PotentialList = {nCount = 3},
  rtPotential = {nCount = 3, sComponentName = "Transform"},
  PotentialDepotItem = {},
  txtPotentialTitle = {nCount = 2, sComponentName = "TMP_Text"},
  txtPotentialTitle3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Build_Common"
  },
  txtPotentialDesc = {nCount = 2, sComponentName = "TMP_Text"},
  switch_des = {},
  switch_img_bg = {
    sComponentName = "RectTransform"
  },
  switch_nameRect = {
    sNodeName = "switch_name",
    sComponentName = "RectTransform"
  },
  switch_name = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Change_Desc"
  },
  btnSwitch_on = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SetDes"
  },
  btnSwitch_off = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SetSimpleDes"
  }
}
CharPotentialTrialCtrl._mapEventConfig = {
  [EventId.CharBgRefresh] = "OnEvent_RefreshPanel",
  [EventId.CharRelatePanelAdvance] = "OnEvent_PanelAdvance",
  [EventId.CharRelatePanelBack] = "OnEvent_PanelBack",
  SelectDepotPotential = "OnEvent_Select"
}

function CharPotentialTrialCtrl:ClearData()
  self.bMax = false
  self.nTab = 1
  self.nSelectId = nil
  self.MasterSpecificIds = nil
  self.MasterNormalIds = nil
  self.AssistSpecificIds = nil
  self.AssistNormalIds = nil
end

function CharPotentialTrialCtrl:RefreshData()
  self.nCharId = self._panel.nCharId
  self.bMax = false
  self.nTab = 1
  self.tbPotentialList = PlayerData.Char:GetCharPotentialList(self.nCharId)
  if self.tbBuild1GridCtrl == nil then
    self.tbBuild1GridCtrl = {}
  end
  if self.tbBuild2GridCtrl == nil then
    self.tbBuild2GridCtrl = {}
  end
  if self.tbBuildCommonGirdCtrl == nil then
    self.tbBuildCommonGirdCtrl = {}
  end
  if self.tbPotentialList and self.tbPotentialList.master then
    for type = 1, 3 do
      if self.tbPotentialList.master[type] ~= nil and #self.tbPotentialList.master[type] > 0 then
        self.nSelectId = self.tbPotentialList.master[type][1].nId
        break
      end
    end
  end
end

function CharPotentialTrialCtrl:Reselect()
  NovaAPI.SetVerticalNormalizedPosition(self._mapNode.svPotential, 1)
  if self.nTab == 1 then
    if self.tbPotentialList and self.tbPotentialList.master then
      for type = 1, 3 do
        if self.tbPotentialList.master[type] ~= nil and #self.tbPotentialList.master[type] > 0 then
          self.nSelectId = self.tbPotentialList.master[type][1].nId
          break
        end
      end
    end
  elseif self.tbPotentialList and self.tbPotentialList.assist then
    for type = 1, 3 do
      if self.tbPotentialList.assist[type] ~= nil and 0 < #self.tbPotentialList.assist[type] then
        self.nSelectId = self.tbPotentialList.assist[type][1].nId
        break
      end
    end
  end
end

function CharPotentialTrialCtrl:RefreshContent()
  if self._panel.nPanelId ~= PanelId.CharPotentialTrial then
    return
  end
  self:RefreshData()
  if not self.nSelectId then
    printError("CharPotential表没配这个角色：" .. self.nCharId)
    return
  end
  self:RefreshTab()
  self:RefreshSwitch()
  self:RefreshList()
  self:SetPotentialBuildName()
  self:RefreshMaxLevelSwitch()
end

function CharPotentialTrialCtrl:RefreshTab()
  self._mapNode.tab[1]:SetSelect(1 == self.nTab, 1)
  self._mapNode.tab[2]:SetSelect(2 == self.nTab, 3)
end

function CharPotentialTrialCtrl:SetPotentialBuildName()
  local charDescCfg = ConfigTable.GetData("CharacterDes", self.nCharId)
  if charDescCfg ~= nil then
    for i = 1, 2 do
      NovaAPI.SetTMPText(self._mapNode.txtPotentialTitle[i], self.nTab == 1 and charDescCfg["PotentialMain" .. i] or charDescCfg["PotentialAssistant" .. i])
      local titleLayoutElement = self._mapNode.txtPotentialTitle[i].gameObject:GetComponent("LayoutElement")
      local tr = self._mapNode.txtPotentialTitle[i].gameObject:GetComponent("RectTransform")
      
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        self:SetTitleWidth(titleLayoutElement, tr)
      end
      
      cs_coroutine.start(wait)
      NovaAPI.SetTMPText(self._mapNode.txtPotentialDesc[i], self.nTab == 1 and charDescCfg["PotentialMainContent" .. i] or charDescCfg["PotentialAssistantContent" .. i])
    end
  end
end

function CharPotentialTrialCtrl:SetTitleWidth(nTitleLayout, tr)
  local minWidth = nTitleLayout.minWidth
  local preferredWidth = tr.rect.width
  if minWidth == preferredWidth then
    return
  else
    nTitleLayout.minWidth = preferredWidth
  end
end

function CharPotentialTrialCtrl:RefreshMaxLevelSwitch()
  self._mapNode.btnSwitch[1].gameObject:SetActive(not self.bMax)
  self._mapNode.btnSwitch[2].gameObject:SetActive(self.bMax)
end

function CharPotentialTrialCtrl:RefreshList(bChangeTab)
  local tbPotential = self.nTab == 1 and self.tbPotentialList.master or self.tbPotentialList.assist
  local tbBuild1 = tbPotential[GameEnum.potentialBuild.PotentialBuild1] or {}
  local tbBuild2 = tbPotential[GameEnum.potentialBuild.PotentialBuild2] or {}
  local tbBuildCommon = tbPotential[GameEnum.potentialBuild.PotentialBuildCommon] or {}
  self._mapNode.PotentialList[1]:SetActive(0 < #tbBuild1)
  self._mapNode.PotentialList[2]:SetActive(0 < #tbBuild2)
  self._mapNode.PotentialList[3]:SetActive(0 < #tbBuildCommon)
  
  local function createPotentialItem(tbPotential, tbGrid, rtContent)
    if 0 < #tbPotential then
      for k, v in ipairs(tbPotential) do
        local nMaxLevel = PlayerData.StarTower:GetPotentialMaxLevelWithMaxGrowth(v.nId)
        local nLv = self.bMax and nMaxLevel or 1
        if nil == tbGrid[k] then
          local itemObj = instantiate(self._mapNode.PotentialDepotItem, rtContent)
          itemObj.gameObject:SetActive(true)
          local itemCtrl = self:BindCtrlByNode(itemObj, "Game.UI.StarTower.Depot.DepotPotentialItemCtrl")
          itemCtrl:InitItem(v.nId, nLv, 0, false)
          table.insert(tbGrid, itemCtrl)
        else
          tbGrid[k]:InitItem(v.nId, nLv, 0, false)
        end
        EventManager.Hit("SelectDepotPotential", self.nSelectId)
      end
      if #tbGrid > #tbPotential then
        for i = #tbPotential + 1, #tbGrid do
          tbGrid[i].gameObject:SetActive(false)
        end
      end
    end
  end
  
  createPotentialItem(tbBuild1, self.tbBuild1GridCtrl, self._mapNode.rtPotential[1])
  createPotentialItem(tbBuild2, self.tbBuild2GridCtrl, self._mapNode.rtPotential[2])
  createPotentialItem(tbBuildCommon, self.tbBuildCommonGirdCtrl, self._mapNode.rtPotential[3])
  local nLevel = PlayerData.StarTower:GetPotentialMaxLevelWithMaxGrowth(self.nSelectId)
  local bSimple = PlayerData.StarTower:GetPotentialDescSimple()
  if bChangeTab then
    self._mapNode.animCard:Play("PotentialCardRoot_switch", 0, 0)
    self._mapNode.PotentialCard2:SetPotentialItem(self.nSelectId, self.bMax and nLevel or 1, nil, bSimple)
    self:AddTimer(1, 0.2, function()
      self._mapNode.PotentialCard:SetPotentialItem(self.nSelectId, self.bMax and nLevel or 1, nil, bSimple)
      self._mapNode.PotentialCard:ChangeWordRaycast(true)
    end, true, true, true)
  else
    self._mapNode.PotentialCard:SetPotentialItem(self.nSelectId, self.bMax and nLevel or 1, nil, bSimple)
    self._mapNode.PotentialCard:ChangeWordRaycast(true)
  end
end

function CharPotentialTrialCtrl:SetTabText()
  self._mapNode.tab[1]:SetText(ConfigTable.GetUIText("Build_Leader"))
  self._mapNode.tab[2]:SetText(ConfigTable.GetUIText("Build_Sub"))
end

function CharPotentialTrialCtrl:PlayOpenAnim()
end

function CharPotentialTrialCtrl:PlaySwitchAnim(nClosePanelId, nOpenPanelId, bBack)
  if nClosePanelId == PanelId.CharPotentialTrial then
    NovaAPI.SetVerticalNormalizedPosition(self._mapNode.svPotential, 1)
    self._mapNode.safeAreaRoot.gameObject:SetActive(false)
    self:ClearData()
  end
  if nOpenPanelId == PanelId.CharPotentialTrial then
    self._mapNode.safeAreaRoot.gameObject:SetActive(true)
    self:PlayOpenAnim()
  end
end

function CharPotentialTrialCtrl:InitSwitch()
  local bSimple = PlayerData.StarTower:GetPotentialDescSimple()
  self._mapNode.btnSwitch_on.gameObject:SetActive(bSimple)
  self._mapNode.btnSwitch_off.gameObject:SetActive(not bSimple)
  self:AddTimer(1, 0.5, "RefreshSwitch", true, true, false)
end

function CharPotentialTrialCtrl:RefreshSwitch()
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.switch_nameRect)
  self._mapNode.switch_img_bg.sizeDelta = Vector2(100 + self._mapNode.switch_nameRect.sizeDelta.x + 30, self._mapNode.switch_img_bg.sizeDelta.y)
end

function CharPotentialTrialCtrl:Awake()
  self:ClearData()
  self:SetTabText()
end

function CharPotentialTrialCtrl:OnEnable()
  self._mapNode.safeAreaRoot.gameObject:SetActive(false)
  
  local function callback()
    self:RefreshContent()
    if self._panel.nPanelId == PanelId.CharPotentialTrial then
      self._mapNode.safeAreaRoot.gameObject:SetActive(true)
      self:PlayOpenAnim()
    else
      self._mapNode.safeAreaRoot.gameObject:SetActive(false)
    end
    self:InitSwitch()
    self:RefreshMaxLevelSwitch()
  end
  
  PlayerData.StarTower:SendTowerGrowthDetailReq(callback)
end

function CharPotentialTrialCtrl:OnDisable()
  if self.tbBuildCommonGirdCtrl then
    for k, objCtrl in pairs(self.tbBuildCommonGirdCtrl) do
      local obj = objCtrl.gameObject
      self:UnbindCtrlByNode(objCtrl)
      self.tbBuildCommonGirdCtrl[k] = nil
      destroyImmediate(obj)
    end
    self.tbBuildCommonGirdCtrl = {}
  end
  if self.tbBuild2GridCtrl then
    for k, objCtrl in pairs(self.tbBuild2GridCtrl) do
      local obj = objCtrl.gameObject
      self:UnbindCtrlByNode(objCtrl)
      self.tbBuild2GridCtrl[k] = nil
      destroyImmediate(obj)
    end
    self.tbBuild2GridCtrl = {}
  end
  if self.tbBuild1GridCtrl then
    for k, objCtrl in pairs(self.tbBuild1GridCtrl) do
      local obj = objCtrl.gameObject
      self:UnbindCtrlByNode(objCtrl)
      self.tbBuild1GridCtrl[k] = nil
      destroyImmediate(obj)
    end
    self.tbBuild1GridCtrl = {}
  end
end

function CharPotentialTrialCtrl:OnDestroy()
end

function CharPotentialTrialCtrl:OnBtnClick_Tab(btn, nIndex)
  if nIndex == self.nTab then
    return
  end
  self.nTab = nIndex
  self:RefreshTab()
  self:Reselect()
  self:RefreshList(true)
  self:SetPotentialBuildName()
end

function CharPotentialTrialCtrl:OnBtnClick_Switch(btn, nIndex)
  self.bMax = not self.bMax
  self:RefreshMaxLevelSwitch()
  self:RefreshList()
end

function CharPotentialTrialCtrl:OnBtnClick_SetSimpleDes(...)
  PlayerData.StarTower:SetPotentialDescSimple(true)
  self:RefreshList()
  self._mapNode.btnSwitch_on.gameObject:SetActive(true)
  self._mapNode.btnSwitch_off.gameObject:SetActive(false)
end

function CharPotentialTrialCtrl:OnBtnClick_SetDes(...)
  PlayerData.StarTower:SetPotentialDescSimple(false)
  self:RefreshList()
  self._mapNode.btnSwitch_on.gameObject:SetActive(false)
  self._mapNode.btnSwitch_off.gameObject:SetActive(true)
end

function CharPotentialTrialCtrl:OnEvent_Select(nPotentialId)
  if self.nSelectId == nPotentialId then
    return
  end
  self.nSelectId = nPotentialId
  local nMaxLevel = PlayerData.StarTower:GetPotentialMaxLevelWithMaxGrowth(self.nSelectId)
  local nLevel = self.bMax and nMaxLevel or 1
  self._mapNode.animCard:Play("PotentialCardRoot_switch", 0, 0)
  self._mapNode.switch_des:SetActive(true)
  local bSimple = PlayerData.StarTower:GetPotentialDescSimple()
  self._mapNode.PotentialCard2:SetPotentialItem(nPotentialId, nLevel, nil, bSimple)
  self:AddTimer(1, 0.2, function()
    self._mapNode.PotentialCard:SetPotentialItem(nPotentialId, nLevel, nil, bSimple)
    self._mapNode.PotentialCard:ChangeWordRaycast(true)
  end, true, true, true)
end

function CharPotentialTrialCtrl:OnEvent_RefreshPanel()
  self:RefreshContent()
end

function CharPotentialTrialCtrl:OnEvent_PanelAdvance(nClosePanelId, nOpenPanelId)
  self:PlaySwitchAnim(nClosePanelId, nOpenPanelId, false)
  self:RefreshContent()
end

function CharPotentialTrialCtrl:OnEvent_PanelBack(nClosePanelId, nOpenPanelId)
  self:PlaySwitchAnim(nClosePanelId, nOpenPanelId, true)
  self:RefreshContent()
end

return CharPotentialTrialCtrl

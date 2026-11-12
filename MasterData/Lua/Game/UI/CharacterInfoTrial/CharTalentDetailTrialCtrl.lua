local CharTalentDetailTrialCtrl = class("CharTalentDetailTrialCtrl", BaseCtrl)
CharTalentDetailTrialCtrl._mapNodeConfig = {
  Info = {
    sNodeName = "--Info--",
    sCtrlName = "Game.UI.CharacterInfoTrial.CharTalentInfoTrialCtrl"
  },
  animInfo = {sNodeName = "--Info--", sComponentName = "Animator"},
  goKeyReady = {},
  imgKeyOff = {},
  imgKeyOn = {},
  goKeySelect = {},
  btnKey = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Key"
  },
  Node = {
    nCount = 10,
    sCtrlName = "Game.UI.CharacterInfoEx.TalentNodeCtrl"
  },
  btnNode = {
    nCount = 10,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Node"
  },
  btnBack = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Back"
  }
}
CharTalentDetailTrialCtrl._mapEventConfig = {
  ActiveTalent = "OnEvent_ActiveTalent"
}

function CharTalentDetailTrialCtrl:Refresh(nSelectGroupIndex, nSelectGroupId, bSkipIn)
  self.gameObject:SetActive(true)
  if bSkipIn then
    self._mapNode.animInfo:Play("CharTalent_info_in", 0, 0.7)
  else
    self._mapNode.animInfo:Play("CharTalent_info_in")
  end
  self.nCharId = self._panel.nCharId
  self.nSelectGroupIndex = nSelectGroupIndex
  self.nSelectGroupId = nSelectGroupId
  self:RefreshData()
  self:RefreshNode()
  self:DefaultSelect()
end

function CharTalentDetailTrialCtrl:RefreshData()
  local tbTalent, tbGroup = PlayerData.Talent:CreateNewTalentData(self.nCharId)
  local nFirstGroup = tbTalent.nFirstGroup
  local mapCurGroup = tbGroup[nFirstGroup]
  self.tbGroup = {}
  while mapCurGroup do
    table.insert(self.tbGroup, mapCurGroup)
    mapCurGroup = tbGroup[mapCurGroup.nNext]
  end
  self.mapTalent = tbTalent
  self.nGroupNodeLimit = 0
  local mapGroupCfg = ConfigTable.GetData("TalentGroup", self.nSelectGroupId)
  if mapGroupCfg then
    self.nGroupNodeLimit = mapGroupCfg.NodeLimit
  end
  self.nFragmentsId = 0
  self.nPerFragmentsQty, self.nGeneralFragmentId = 0, 0
  local mapCharCfg = ConfigTable.GetData_Character(self.nCharId)
  if mapCharCfg then
    self.nFragmentsId = mapCharCfg.FragmentsId
    local mapGradeCfg = ConfigTable.GetData("CharGrade", mapCharCfg.Grade)
    if mapGradeCfg then
      self.nPerFragmentsQty = mapGradeCfg.FragmentsQty
      self.nGeneralFragmentId = mapGradeCfg.GeneralFragmentId
    end
  end
end

function CharTalentDetailTrialCtrl:RefreshNode()
  local tbTalent = CacheTable.GetData("_Talent", self.nSelectGroupId)
  if not tbTalent then
    return
  end
  local mapGroup = self.tbGroup[self.nSelectGroupIndex]
  local bMax = mapGroup.nNormalCount >= self.nGroupNodeLimit
  local nFragmentCount = PlayerData.Item:GetItemCountByID(self.nFragmentsId)
  local bUnable = nFragmentCount < self.nPerFragmentsQty
  self.tbTalent = {}
  for _, v in pairs(tbTalent) do
    if v.Type == GameEnum.talentType.OrdinaryNode then
      local nIndex = v.Sort
      local nState = 1
      if self.mapTalent.tbActiveTalent[v.Id] then
        nState = 3
      elseif mapGroup.bLock or bMax or bUnable then
        nState = 1
      elseif not mapGroup.bLock and not bMax then
        nState = 2
      end
      self._mapNode.Node[nIndex]:Refresh(nState)
      self.tbTalent[nIndex] = v.Id
    end
  end
  if not bMax then
    self._mapNode.imgKeyOn:SetActive(false)
    self._mapNode.imgKeyOff:SetActive(true)
  else
    self._mapNode.imgKeyOn:SetActive(true)
    self._mapNode.imgKeyOff:SetActive(false)
  end
end

function CharTalentDetailTrialCtrl:DefaultSelect()
  if self.mapSelectNode ~= nil then
    if self.mapSelectNode.bKey then
      self._mapNode.goKeySelect:SetActive(false)
    else
      self._mapNode.Node[self.mapSelectNode.nIndex]:SetSelect(false)
    end
  end
  
  local function select_key()
    self.mapSelectNode = {bKey = true, nIndex = 0}
    self._mapNode.goKeySelect:SetActive(true)
    self._mapNode.Info:RefreshKey(self.tbGroup[self.nSelectGroupIndex], self.mapTalent)
  end
  
  local function select_normal()
    local nIndex = 1
    for i, v in ipairs(self.tbTalent) do
      local bReady = self._mapNode.Node[i]:CheckReady()
      if bReady then
        nIndex = i
        break
      end
    end
    self.mapSelectNode = {bKey = false, nIndex = nIndex}
    self._mapNode.Node[nIndex]:SetSelect(true)
    self._mapNode.Info:RefreshNormal(self.tbTalent[nIndex], self.tbGroup[self.nSelectGroupIndex], self.mapTalent)
  end
  
  local mapGroup = self.tbGroup[self.nSelectGroupIndex]
  local bMax = mapGroup.nNormalCount >= self.nGroupNodeLimit
  if mapGroup.bLock or bMax then
    select_key()
    return
  end
  local nLeft = self.nGroupNodeLimit - mapGroup.nNormalCount
  local nGeneralCount = PlayerData.Item:GetItemCountByID(self.nGeneralFragmentId)
  local nFragmentCount = PlayerData.Item:GetItemCountByID(self.nFragmentsId)
  local nUse = self.nPerFragmentsQty * nLeft
  if nUse <= nFragmentCount + nGeneralCount or nFragmentCount < self.nPerFragmentsQty then
    select_key()
  else
    select_normal()
  end
end

function CharTalentDetailTrialCtrl:PlayOpenAnim()
end

function CharTalentDetailTrialCtrl:Awake()
  self.gameObject:SetActive(false)
  self.ani = self.gameObject.transform:GetComponent("Animator")
end

function CharTalentDetailTrialCtrl:OnEnable()
end

function CharTalentDetailTrialCtrl:OnDisable()
end

function CharTalentDetailTrialCtrl:OnDestroy()
end

function CharTalentDetailTrialCtrl:OnBtnClick_Key(btn)
  if self.mapSelectNode ~= nil then
    if self.mapSelectNode.bKey == true then
      return
    else
      self._mapNode.Node[self.mapSelectNode.nIndex]:SetSelect(false)
    end
  end
  self.mapSelectNode = {bKey = true, nIndex = 0}
  self._mapNode.goKeySelect:SetActive(true)
  self._mapNode.Info:RefreshKey(self.tbGroup[self.nSelectGroupIndex], self.mapTalent)
end

function CharTalentDetailTrialCtrl:OnBtnClick_Node(btn, nIndex)
  if self.mapSelectNode ~= nil then
    if self.mapSelectNode.bKey == true then
      self._mapNode.goKeySelect:SetActive(false)
    elseif self.mapSelectNode.bKey == false and self.mapSelectNode.nIndex == nIndex then
      return
    elseif self.mapSelectNode.bKey == false and self.mapSelectNode.nIndex ~= nIndex then
      self._mapNode.Node[self.mapSelectNode.nIndex]:SetSelect(false)
    end
  end
  self.mapSelectNode = {bKey = false, nIndex = nIndex}
  self._mapNode.Node[nIndex]:SetSelect(true)
  self._mapNode.Info:RefreshNormal(self.tbTalent[nIndex], self.tbGroup[self.nSelectGroupIndex], self.mapTalent)
end

function CharTalentDetailTrialCtrl:OnBtnClick_Back(btn)
  if self.mapSelectNode.bKey then
    self._mapNode.goKeySelect:SetActive(false)
  else
    self._mapNode.Node[self.mapSelectNode.nIndex]:SetSelect(false)
  end
  self._mapNode.animInfo:Play("CharTalent_info_out")
  EventManager.Hit("CharTalentDetailBack")
  self:AddTimer(1, 0.33, function()
    self.gameObject:SetActive(false)
  end, true, true, true)
end

function CharTalentDetailTrialCtrl:OnEvent_ActiveTalent(bKey, nTalentId)
  if bKey then
    EventManager.Hit(EventId.BlockInput, true)
  end
  local nHas = PlayerData.Item:GetItemCountByID(self.nFragmentsId)
  
  local function callback()
    local bAble = nHas >= self.nPerFragmentsQty
    if not bAble or bKey then
      self:RefreshNode()
    end
    if bKey then
      PlayerData.Voice:PlayCharVoice("exCharUp", self.nCharId)
      CS.WwiseAudioManager.Instance:PostEvent("ui_charInfo_talent_active_large")
      self.ani:Play("TalentKeyNode_unlock", 0, 0)
      self:AddTimer(1, 1.3, function()
        EventManager.Hit(EventId.BlockInput, false)
      end, true, true, true)
    end
  end
  
  if self.mapSelectNode.bKey then
    callback()
  else
    self._mapNode.Node[self.mapSelectNode.nIndex]:PlayActiveAnim(callback)
    local nStart = self.mapSelectNode.nIndex
    local nIndex = 0
    for i, v in ipairs(self.tbTalent) do
      if i > nStart then
        local bActive = self._mapNode.Node[i]:CheckActive()
        if not bActive then
          nIndex = i
          break
        end
      end
    end
    if nIndex == 0 then
      for i, v in ipairs(self.tbTalent) do
        if i < nStart then
          local bActive = self._mapNode.Node[i]:CheckActive()
          if not bActive then
            nIndex = i
            break
          end
        end
      end
    end
    if nIndex ~= 0 then
      self:OnBtnClick_Node(nil, nIndex)
    end
  end
  self:RefreshData()
end

return CharTalentDetailTrialCtrl

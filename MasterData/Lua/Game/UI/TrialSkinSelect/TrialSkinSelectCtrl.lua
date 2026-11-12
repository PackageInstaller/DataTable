local TrialSkinSelectCtrl = class("TrialSkinSelectCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
TrialSkinSelectCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  aniRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  rawImgActor2D = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  imgRecommend = {nCount = 2},
  imgOn = {nCount = 2},
  imgOff = {nCount = 2},
  txtMain = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Trial_MasterGroup"
  },
  txtSub = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Trial_AssistGroup"
  },
  btnTab = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tab"
  },
  txtPotentialTitle = {nCount = 2, sComponentName = "TMP_Text"},
  txtPotentialTip = {nCount = 2, sComponentName = "TMP_Text"},
  btnLevel = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Level"
  },
  txtBtnLevel = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Trial_Btn_TrialFormation"
  },
  sv = {
    nCount = 2,
    sComponentName = "LoopScrollView"
  },
  List_ = {nCount = 2}
}
TrialSkinSelectCtrl._mapEventConfig = {
  SelectDepotPotential = "OnEvent_Select",
  [EventId.UIHomeConfirm] = "OnBtnClick_Home",
  [EventId.UIBackConfirm] = "OnBtnClick_Back"
}

function TrialSkinSelectCtrl:RefreshSelectTrial()
  local nGroupId = PlayerData.Trial:GetSelectTrialGroup()
  local bGroupIdChange = nGroupId ~= self.nGroupId
  if not bGroupIdChange then
    return
  end
  self.nTab = 1
  if bGroupIdChange then
    self.nGroupId = nGroupId
  end
end

function TrialSkinSelectCtrl:RefreshData()
  if self.nTab == nil then
    self.nTab = 1
  end
  self.tbPotentialList = {}
  self.tbPotentialList.master = {}
  self.tbPotentialList.assist = {}
  self.tbBuildGroup = {}
  self.tbBuildGroup.master = {}
  self.tbBuildGroup.assist = {}
  self.tbBuild1GridCtrl = {}
  self.tbBuild2GridCtrl = {}
  local mapGroupCfg = ConfigTable.GetData("TrialGroup", self.nGroupId)
  if not mapGroupCfg then
    return
  end
  PlayerData.Char:CreateTrialChar({
    mapGroupCfg.TrialChar
  })
  
  local function addPotential(tbPotentials, insertTb, nIndex)
    for Tid, Level in pairs(tbPotentials) do
      local mapCfg = ConfigTable.GetData("Potential", Tid)
      local mapItemCfg = ConfigTable.GetData("Item", Tid)
      if mapCfg ~= nil and mapItemCfg ~= nil then
        if insertTb[nIndex] == nil then
          insertTb[nIndex] = {}
        end
        local data = {
          nId = Tid,
          nSpecial = mapItemCfg.Stype == GameEnum.itemStype.SpecificPotential and 1 or 0,
          nRarity = mapItemCfg.Rarity,
          nLevel = Level
        }
        table.insert(insertTb[nIndex], data)
      end
    end
  end
  
  local mapTrial = ConfigTable.GetData("TrialCharacter", mapGroupCfg.TrialChar)
  if not mapTrial then
    return
  end
  self.nCharId = mapTrial.CharId
  local mapDes = ConfigTable.GetData("CharacterDes", self.nCharId)
  if not mapDes then
    return
  end
  for i, v in ipairs(mapGroupCfg.MasterPotential) do
    local mapCfg = ConfigTable.GetData("TrialPotential", v)
    if mapCfg then
      table.insert(self.tbBuildGroup.master, {
        nId = v,
        nFloorId = mapCfg.FloorId,
        sTitle = mapDes[mapCfg.Title],
        sDesc = mapDes[mapCfg.Desc]
      })
      local tbPotentialId = mapCfg.Potential
      local mapId = {}
      for _, nId in ipairs(tbPotentialId) do
        mapId[nId] = 1
      end
      local mapFloor = ConfigTable.GetData("TrialFloor", mapCfg.FloorId)
      if mapFloor then
        local mapBuild = ConfigTable.GetData("TrialBuild", mapFloor.TrialBuild)
        if mapBuild then
          local tbAllPotential = decodeJson(mapBuild.Potential)
          for _, mapPotential in pairs(tbAllPotential) do
            if mapId[mapPotential.Tid] then
              mapId[mapPotential.Tid] = mapPotential.Level
            end
          end
          addPotential(mapId, self.tbPotentialList.master, i)
        end
      end
    end
  end
  for i, v in ipairs(mapGroupCfg.AssistPotential) do
    local mapCfg = ConfigTable.GetData("TrialPotential", v)
    if mapCfg then
      table.insert(self.tbBuildGroup.assist, {
        nId = v,
        nFloorId = mapCfg.FloorId,
        sTitle = mapDes[mapCfg.Title],
        sDesc = mapDes[mapCfg.Desc]
      })
      local tbPotentialId = mapCfg.Potential
      local mapId = {}
      for _, nId in ipairs(tbPotentialId) do
        mapId[nId] = 1
      end
      local mapFloor = ConfigTable.GetData("TrialFloor", mapCfg.FloorId)
      if mapFloor then
        local mapBuild = ConfigTable.GetData("TrialBuild", mapFloor.TrialBuild)
        if mapBuild then
          local tbAllPotential = decodeJson(mapBuild.Potential)
          for _, mapPotential in pairs(tbAllPotential) do
            if mapId[mapPotential.Tid] then
              mapId[mapPotential.Tid] = mapPotential.Level
            end
          end
          addPotential(mapId, self.tbPotentialList.assist, i)
        end
      end
    end
  end
  
  local function sort(a, b)
    if a.nSpecial ~= b.nSpecial then
      return a.nSpecial > b.nSpecial
    else
      return a.nRarity < b.nRarity
    end
  end
  
  for i = 1, #self.tbPotentialList.master do
    table.sort(self.tbPotentialList.master[i], sort)
  end
  for i = 1, #self.tbPotentialList.assist do
    table.sort(self.tbPotentialList.assist[i], sort)
  end
end

function TrialSkinSelectCtrl:RefreshContent()
  self:RefreshData()
  self:RefreshTab()
  self:RefreshList()
  self:RefreshRecommend()
  self:RefreshChar()
end

function TrialSkinSelectCtrl:RefreshChar()
  local mapGroupCfg = ConfigTable.GetData("TrialGroup", self.nGroupId)
  if not mapGroupCfg then
    return
  end
  local nCharSkinId = PlayerData.Char:GetTrialCharById(mapGroupCfg.TrialChar).nSkinId
  Actor2DManager.SetActor2D(self:GetPanelId(), self._mapNode.rawImgActor2D, self.nCharId, nCharSkinId)
end

function TrialSkinSelectCtrl:RefreshTab()
  local tbBuildGroup = self.nTab == 1 and self.tbBuildGroup.master or self.tbBuildGroup.assist
  for i = 1, 2 do
    self._mapNode.imgOn[i]:SetActive(i == self.nTab)
    self._mapNode.imgOff[i]:SetActive(i ~= self.nTab)
    if self._mapNode.txtPotentialTitle[i] ~= nil and tbBuildGroup[i] ~= nil then
      NovaAPI.SetTMPText(self._mapNode.txtPotentialTitle[i], tbBuildGroup[i].sTitle)
    end
    if self._mapNode.txtPotentialTip[i] ~= nil and tbBuildGroup[i] ~= nil then
      NovaAPI.SetTMPText(self._mapNode.txtPotentialTip[i], tbBuildGroup[i].sDesc)
    end
  end
end

function TrialSkinSelectCtrl:RefreshRecommend()
  local mapChar = ConfigTable.GetData_Character(self.nCharId)
  if mapChar == nil then
    return
  end
  self._mapNode.imgRecommend[1]:SetActive(mapChar.Class == GameEnum.characterJobClass.Vanguard)
  self._mapNode.imgRecommend[2]:SetActive(mapChar.Class == GameEnum.characterJobClass.Support)
end

function TrialSkinSelectCtrl:RefreshList()
  for nInstanceId, objCtrl in pairs(self.tbBuild1GridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbBuild1GridCtrl[nInstanceId] = nil
  end
  for nInstanceId, objCtrl in pairs(self.tbBuild2GridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbBuild2GridCtrl[nInstanceId] = nil
  end
  local tbPotentialList = self.nTab == 1 and self.tbPotentialList.master or self.tbPotentialList.assist
  self.tbBuild1 = tbPotentialList[GameEnum.potentialBuild.PotentialBuild1] or {}
  self.tbBuild2 = tbPotentialList[GameEnum.potentialBuild.PotentialBuild2] or {}
  self._mapNode.List_[1]:SetActive(#self.tbBuild1 > 0)
  self._mapNode.sv[1].gameObject:SetActive(#self.tbBuild1 > 0)
  self._mapNode.List_[2]:SetActive(#self.tbBuild2 > 0)
  self._mapNode.sv[2].gameObject:SetActive(#self.tbBuild2 > 0)
  if #self.tbBuild1 > 0 then
    self._mapNode.sv[1]:SetAnim(0.04)
    self._mapNode.sv[1]:Init(#self.tbBuild1, self, self.OnGridRefresh1)
  end
  if #self.tbBuild2 > 0 then
    self._mapNode.sv[2]:SetAnim(0.04)
    self._mapNode.sv[2]:Init(#self.tbBuild2, self, self.OnGridRefresh2)
  end
end

function TrialSkinSelectCtrl:OnGridRefresh1(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbBuild1[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbBuild1GridCtrl[nInstanceID] then
    self.tbBuild1GridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.StarTower.Depot.DepotPotentialItemCtrl")
  end
  self.tbBuild1GridCtrl[nInstanceID]:InitItem(mapData.nId, mapData.nLevel, 0, false, true)
end

function TrialSkinSelectCtrl:OnGridRefresh2(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbBuild2[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbBuild1GridCtrl[nInstanceID] then
    self.tbBuild1GridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.StarTower.Depot.DepotPotentialItemCtrl")
  end
  self.tbBuild1GridCtrl[nInstanceID]:InitItem(mapData.nId, mapData.nLevel, 0, false, true)
end

function TrialSkinSelectCtrl:FadeIn()
end

function TrialSkinSelectCtrl:Awake()
end

function TrialSkinSelectCtrl:OnEnable()
  self:RefreshSelectTrial()
  self:RefreshContent()
end

function TrialSkinSelectCtrl:OnDisable()
  Actor2DManager.UnsetActor2D()
  PlayerData.Char:DeleteTrialChar()
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

function TrialSkinSelectCtrl:OnDestroy()
  PlayerData.Char:DeleteTrialChar()
end

function TrialSkinSelectCtrl:OnBtnClick_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  PanelManager.Home()
end

function TrialSkinSelectCtrl:OnBtnClick_Back(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  
  local function ClosePanel()
    EventManager.Hit(EventId.CloesCurPanel)
  end
  
  EventManager.Hit(EventId.SetTransition, 5, ClosePanel)
end

function TrialSkinSelectCtrl:OnBtnClick_Tab(btn, nIndex)
  if nIndex == self.nTab then
    return
  end
  self.nTab = nIndex
  self:RefreshTab()
  NovaAPI.SetVerticalNormalizedPosition(self._mapNode.svPotential, 1)
  self:RefreshList()
end

function TrialSkinSelectCtrl:OnBtnClick_Level(btn, nIndex)
  local nFloorId, sTitle
  if self.nTab == 1 then
    nFloorId = self.tbBuildGroup.master[nIndex].nFloorId
    sTitle = self.tbBuildGroup.master[nIndex].sTitle
  else
    nFloorId = self.tbBuildGroup.assist[nIndex].nFloorId
    sTitle = self.tbBuildGroup.assist[nIndex].sTitle
  end
  PlayerData.Trial:SetLevelTitle(sTitle)
  
  local function OpenPanel()
    EventManager.Hit(EventId.OpenPanel, PanelId.TrialSkinFormationScenePanel, nFloorId)
  end
  
  EventManager.Hit(EventId.SetTransition, 2, OpenPanel)
end

function TrialSkinSelectCtrl:OnEvent_Select(nPotentialId, nLevel)
  EventManager.Hit(EventId.OpenPanel, PanelId.PotentialDetail, nPotentialId, nLevel, 0)
end

return TrialSkinSelectCtrl

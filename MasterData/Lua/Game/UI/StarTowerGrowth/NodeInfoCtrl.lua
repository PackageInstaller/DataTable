local NodeInfoCtrl = class("NodeInfoCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
NodeInfoCtrl._mapNodeConfig = {
  goKey = {},
  KeyNode = {
    sCtrlName = "Game.UI.StarTowerGrowth.KeyNodeCtrl"
  },
  txtName = {sComponentName = "TMP_Text"},
  txtInfoTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "STGrowth_NodeEffect"
  },
  txtDesc = {sComponentName = "TMP_Text"},
  txtLock = {sComponentName = "TMP_Text"},
  txtActived = {
    sComponentName = "TMP_Text",
    sLanguageId = "STGrowth_Node_Actived"
  },
  btnActiveNode = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Active"
  },
  txtBtnActive = {
    sComponentName = "TMP_Text",
    sLanguageId = "STGrowth_Btn_Active"
  },
  goMat = {
    nCount = 3,
    sCtrlName = "Game.UI.TemplateEx.TemplateMatCtrl"
  },
  matList = {},
  btnAdd = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tips"
  },
  svInfo = {sComponentName = "ScrollRect"},
  TMP_Link = {
    sNodeName = "txtDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnLinkClick_Word"
  }
}
NodeInfoCtrl._mapEventConfig = {}

function NodeInfoCtrl:Refresh(mapNode)
  if mapNode == nil then
    return
  end
  local mapCfg = ConfigTable.GetData("StarTowerGrowthNode", mapNode.nId)
  if not mapCfg then
    return
  end
  self.mapCfg = mapCfg
  self.mapNode = mapNode
  if mapCfg.Type == GameEnum.towerGrowthNodeType.Core then
    self._mapNode.goKey:SetActive(true)
    self._mapNode.KeyNode:Refresh(mapNode.nId, 3, nil, true)
  elseif mapCfg.Type == GameEnum.towerGrowthNodeType.Normal then
    self._mapNode.goKey:SetActive(false)
  end
  NovaAPI.SetTMPText(self._mapNode.txtName, mapCfg.Name)
  NovaAPI.SetTMPText(self._mapNode.txtDesc, mapCfg.Desc)
  NovaAPI.SetVerticalNormalizedPosition(self._mapNode.svInfo, 1)
  self._mapNode.matList:SetActive(not mapNode.bActive)
  if not mapNode.bActive then
    for i = 1, 3 do
      self._mapNode.btnAdd[i].interactable = mapCfg["ItemId" .. i] ~= 0
      if mapCfg["ItemId" .. i] ~= 0 then
        self._mapNode.goMat[i].gameObject:SetActive(true)
        self._mapNode.goMat[i]:SetMat(mapCfg["ItemId" .. i], mapCfg["ItemQty" .. i])
      else
        self._mapNode.goMat[i].gameObject:SetActive(false)
      end
    end
  end
  self._mapNode.txtLock.gameObject:SetActive(not mapNode.bActive and not mapNode.bReady)
  self._mapNode.btnActiveNode.gameObject:SetActive(not mapNode.bActive and mapNode.bReady)
  self._mapNode.txtActived.gameObject:SetActive(mapNode.bActive)
  if not mapNode.bActive and not mapNode.bReady then
    local mapGroup = PlayerData.StarTower:GetGrowthGroup(mapCfg.Group)
    if mapGroup.bLock then
      NovaAPI.SetTMPText(self._mapNode.txtLock, orderedFormat(ConfigTable.GetUIText("STGrowth_NodeLock_Group"), ConfigTable.GetData("StarTowerGrowthGroup", mapGroup.nId).Name))
    else
      NovaAPI.SetTMPText(self._mapNode.txtLock, ConfigTable.GetUIText("STGrowth_NodeLock_Pre"))
    end
  end
end

function NodeInfoCtrl:Awake()
end

function NodeInfoCtrl:OnEnable()
end

function NodeInfoCtrl:OnDisable()
end

function NodeInfoCtrl:OnDestroy()
end

function NodeInfoCtrl:OnBtnClick_Active(btn)
  local bMat = true
  for i = 1, 3 do
    if self.mapCfg["ItemId" .. i] ~= 0 then
      local nHas = PlayerData.Item:GetItemCountByID(self.mapCfg["ItemId" .. i])
      if nHas < self.mapCfg["ItemQty" .. i] then
        bMat = false
        break
      end
    end
  end
  if not bMat then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("STGrowth_NoMat"))
    return
  end
  self._mapNode.btnActiveNode.interactable = false
  
  local function callback()
    self._mapNode.btnActiveNode.interactable = true
    self._mapNode.btnActiveNode.gameObject:SetActive(false)
    self._mapNode.txtActived.gameObject:SetActive(true)
    self._mapNode.matList:SetActive(false)
    if self.mapCfg.Type == GameEnum.towerGrowthNodeType.Core then
      WwiseManger:PlaySound("ui_rogue_research_large_button")
    elseif self.mapCfg.Type == GameEnum.towerGrowthNodeType.Normal then
      WwiseManger:PlaySound("ui_rogue_research_small_button")
    end
    EventManager.Hit("StarTowerGrowthNodeUnlock")
  end
  
  PlayerData.StarTower:SendTowerGrowthNodeUnlockReq(self.mapCfg.Id, self.mapCfg.Group, callback)
end

function NodeInfoCtrl:OnBtnClick_Tips(btn, nIndex)
  local mapData = {
    nTid = self.mapCfg["ItemId" .. nIndex],
    bShowDepot = true,
    bShowJumpto = true
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btn.transform, mapData)
end

function NodeInfoCtrl:OnLinkClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

return NodeInfoCtrl

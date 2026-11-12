local SoldierBossTemplateSelectCtrl = class("SoldierBossTemplateSelectCtrl", BaseCtrl)
SoldierBossTemplateSelectCtrl._mapNodeConfig = {
  txtLabel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Select_BossTemplate_Title"
  },
  sv = {
    sNodeName = "sv_BossTemplate",
    sComponentName = "LoopScrollView"
  },
  btnGuide = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Guide"
  }
}
SoldierBossTemplateSelectCtrl._mapEventConfig = {}
SoldierBossTemplateSelectCtrl._mapRedDotConfig = {}

function SoldierBossTemplateSelectCtrl:Awake()
end

function SoldierBossTemplateSelectCtrl:OnEnable()
  local param = self:GetPanelParam()
  self.nSelectedId = nil
  self.nLastInsId = 0
  self.fnCallback = nil
  if type(param) == "table" then
    self.nSelectedId = param[1]
    self.fnCallback = param[2]
  end
  self.tbItemCtrl = {}
  self:InitList()
  if not PlayerData.Guide:CheckGuideFinishById(503) then
    EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_Solider_503")
  end
end

function SoldierBossTemplateSelectCtrl:OnDisable()
  self:ClearCtrl()
end

function SoldierBossTemplateSelectCtrl:OnDestroy()
  self:ClearCtrl()
end

function SoldierBossTemplateSelectCtrl:ClearCtrl()
  if self.tbItemCtrl ~= nil then
    for k, v in pairs(self.tbItemCtrl) do
      self:UnbindCtrlByNode(v)
      self.tbItemCtrl[k] = nil
    end
    self.tbItemCtrl = {}
  end
end

function SoldierBossTemplateSelectCtrl:InitList()
  self._mapNode.sv.gameObject:SetActive(false)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
  self:AddTimer(1, 0.6, function()
    self._mapNode.sv.gameObject:SetActive(true)
    self.tbTemplateList = PlayerData.SoldierData:GetAllBossTemplates() or {}
    self._mapNode.sv:SetAnim(0.06)
    self._mapNode.sv:Init(#self.tbTemplateList, self, self.OnRefreshGrid, self.OnGridBtnClick, false)
  end, true, true, true)
end

function SoldierBossTemplateSelectCtrl:OnRefreshGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbTemplateList[nIndex]
  if mapData == nil then
    return
  end
  local nInstanceId = goGrid:GetInstanceID()
  local ctrl = self.tbItemCtrl[nInstanceId]
  if ctrl == nil then
    ctrl = self:BindCtrlByNode(goGrid, "Game.UI.Soldier.BossTemplate.SoldierBossTemplateItemCtrl")
    self.tbItemCtrl[nInstanceId] = ctrl
  end
  ctrl:SetItemData(mapData)
  ctrl:SetSelected(false)
end

function SoldierBossTemplateSelectCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbTemplateList[nIndex]
  if mapData == nil or mapData.nUnlock == 0 then
    return
  end
  if self.nSelectedId == mapData.nId then
    return
  end
  self.nSelectedId = mapData.nId
  local nInstanceId = goGrid:GetInstanceID()
  local ctrl = self.tbItemCtrl[nInstanceId]
  if ctrl ~= nil then
    ctrl:SetSelected(true)
  end
  local lastCtrl = self.tbItemCtrl[self.nLastInsId]
  if lastCtrl ~= nil then
    lastCtrl:SetSelected(false)
  end
  self.nLastInsId = nInstanceId
end

function SoldierBossTemplateSelectCtrl:OnBtnClick_Guide()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierRecommendPanel, true)
end

return SoldierBossTemplateSelectCtrl

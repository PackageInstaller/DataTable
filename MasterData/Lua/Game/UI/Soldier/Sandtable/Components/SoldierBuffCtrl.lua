local BaseCtrl = require("GameCore.UI.BaseCtrl")
local SoldierBuffCtrl = class("SoldierBuffCtrl", BaseCtrl)
SoldierBuffCtrl._mapNodeConfig = {
  goBuffItem = {
    nCount = 4,
    sCtrlName = "Game.UI.Soldier.Sandtable.Items.SoldierBuffItemCtrl"
  },
  goBuffMore = {},
  btnBuff = {
    sNodeName = "goBuffRoot",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Buff"
  },
  goBuffRoot = {
    sComponentName = "RectTransform"
  }
}
SoldierBuffCtrl._mapEventConfig = {}
SoldierBuffCtrl._mapRedDotConfig = {}

function SoldierBuffCtrl:Awake()
end

function SoldierBuffCtrl:OnEnable()
end

function SoldierBuffCtrl:OnDisable()
end

function SoldierBuffCtrl:OnDestroy()
end

function SoldierBuffCtrl:RefreshBuff()
  self._tbStrategyCardIds = {}
  self.tbBuffCfgs = {}
  local levelData = PlayerData.SoldierData:GetCurLevelData()
  local tbStrategyCard = levelData:GetCardData()
  if tbStrategyCard == nil or #tbStrategyCard == 0 then
    self._mapNode.goBuffRoot.gameObject:SetActive(false)
    return
  end
  self._mapNode.goBuffRoot.gameObject:SetActive(true)
  self._tbStrategyCardIds = tbStrategyCard
  for k, v in ipairs(self._tbStrategyCardIds) do
    local cfg = ConfigTable.GetData("SoldierStrategyCard", v.nId)
    table.insert(self.tbBuffCfgs, cfg)
  end
  self:_RefreshBuffItems()
end

function SoldierBuffCtrl:_RefreshBuffItems()
  for k, v in ipairs(self._mapNode.goBuffItem) do
    v.gameObject:SetActive(true)
    if self._tbStrategyCardIds[k] ~= nil then
      local cfg = ConfigTable.GetData("SoldierStrategyCard", self._tbStrategyCardIds[k].nId)
      v:SetData(cfg)
    else
      v:SetEmpty()
    end
  end
  self._mapNode.goBuffMore.gameObject:SetActive(#self._tbStrategyCardIds > #self._mapNode.goBuffItem)
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.goBuffRoot)
end

function SoldierBuffCtrl:OnBtnClick_Buff()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierBuffTipsPanel, self.tbBuffCfgs)
end

return SoldierBuffCtrl

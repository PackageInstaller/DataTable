local SoldierNodeItemCtrl = class("SoldierNodeItemCtrl", BaseCtrl)

function SoldierNodeItemCtrl:Awake()
  self.serverData = PlayerData.SoldierData.ServerData
end

function SoldierNodeItemCtrl:OnEnable()
end

function SoldierNodeItemCtrl:OnDisable()
end

function SoldierNodeItemCtrl:OnDestroy()
end

function SoldierNodeItemCtrl:OnRefresh(nodeId)
  local config = ConfigTable.GetData("SoldierNodePlan", nodeId)
  if config then
    self:SetPngSprite(self._mapNode.imgIcon, config.NodeIcon)
  end
  local curNodeId = self.serverData:GetNodeId()
  self._mapNode.imgStatus:SetActive(curNodeId == nodeId)
end

return SoldierNodeItemCtrl

local Instantiate = CS.UnityEngine.GameObject.Instantiate
local GearItemDropTerrain, Super = System.NewClass("GearItemDropTerrain", GearItemBase)

function GearItemDropTerrain:PlayDropAnim()
  local gridX, gridY = self:GetGridPos()
  local terrainMgr = self.manager:GetComponent(MapTerrainManager)
  local terrain = terrainMgr:GetTerrainByPos(gridX, gridY)
  if terrain then
    terrain:PlayDropAnim()
    local data = self:GetData()
    if data then
      data.state = 6
    end
  end
end

function GearItemDropTerrain:OnRemove()
  self:PlayDropAnim()
  Super.OnRemove(self)
end

return GearItemDropTerrain

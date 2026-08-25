local ParticleSystemFrame = {}

function ParticleSystemFrame:Init(obj, nodeInfo)
  obj:SetActive(false)
  self.nodeInfo = nodeInfo
end

function ParticleSystemFrame:Trigger(obj)
  self.player = RoleManager.Instance:GetRole(DataCenter.playerData.DRole.uid)
  local playerPos = self.player:GetPosition()
  local pos = self.nodeInfo.pos
  local hitBoxInfo = self.nodeInfo.hitBoxInfo[1]
  local rect = hitBoxInfo.rect
  local playerZ = playerPos.z
  local startZ = pos[3] - rect[3] * 0.5
  local endZ = pos[3] + rect[3] * 0.5
  local ratio = (playerZ - startZ) / (endZ - startZ)
  if math.abs(ratio - 0) < 0.01 or math.abs(ratio - 1) < 0.01 then
    obj:SetActive(false)
    return
  end
  local ratioDelta = math.abs((self.ratio or 0) - ratio)
  if ratioDelta >= 0.01 then
    self.ratio = ratio
    obj:SetActive(true)
    CS.Framework.ParticleSystemStop.StopAtRatio(obj, ratio)
  end
end

return ParticleSystemFrame

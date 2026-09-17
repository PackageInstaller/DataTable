local this = {}

function this:init()
  this.super.init(self)
  self.data = {mountCdTime = 0, mountSatietyPercent = 1}
end

function this:getMountMap()
  local mountMap = AzurWorld.mountMgr:GetMountRouletteData()
  local res = {}
  for i, v in pairs(mountMap) do
    if not math.isEmpty(v) then
      res[i] = v
    end
  end
  return res
end

function this:getEquipMountId()
  return AzurWorld.mountMgr:GetEquipMountId()
end

function this:getRecordMountSatietyPercent()
  return self.data.mountSatietyPercent
end

return this

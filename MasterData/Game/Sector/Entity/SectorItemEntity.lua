local SectorItemEntity = class("SectorItemEntity")

function SectorItemEntity:InitSectorItemEntity(gameObject, chaptData)
  self.gameObject = gameObject
  self.transform = gameObject.transform
  self._chaptData = chaptData
  self.bind = {}
  UIUtil.LuaUIBindingTable(self.transform, self.bind)
  self:UpdateSectorLock()
end

function SectorItemEntity:UpdateSectorLock()
  local unlock = PlayerDataCenter.sectorStage:IsSectorUnlock(self.id)
  if self._chaptData:IsSectorChapterUnlock() then
    self:SetEmissiveNum(1)
  else
    self:SetEmissiveNum(0)
  end
end

function SectorItemEntity:SetEmissiveNum(num)
  if self.bind.meshRender ~= nil then
    local materials = self.bind.meshRender.materials
    for i = 0, materials.Length - 1 do
      local mat = materials[i]
      mat:SetFloat("_EmissiveSwitch", num)
    end
  end
end

function SectorItemEntity:SctItemEnttUnlockTween(doTweenSequence)
  for index, mat in ipairs(self:_GetMats()) do
    if index == 1 then
      doTweenSequence:Append(mat:DOFloat(1, "_EmissiveSwitch", 0.5))
    else
      doTweenSequence:Join(mat:DOFloat(1, "_EmissiveSwitch", 0.5))
    end
  end
end

function SectorItemEntity:_GetMats()
  local mats = {}
  if self.bind.meshRender ~= nil then
    local materials = self.bind.meshRender.materials
    for i = 0, materials.Length - 1 do
      table.insert(mats, materials[i])
    end
  end
  return mats
end

return SectorItemEntity

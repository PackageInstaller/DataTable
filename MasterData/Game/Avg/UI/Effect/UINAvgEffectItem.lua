local UINAvgEffectItem = class("UINAvgEffectItem", UIBaseNode)
local base = UIBaseNode

function UINAvgEffectItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg)
end

function UINAvgEffectItem:InitAvgEffectItem(id, prefabName, resLoader, position, parent)
  if position == nil then
    self.transform.localPosition = Vector3.zero
  else
    if #position ~= 3 then
      self.avgCtrl:AvgLogError("AvgEffect position config error")
      return
    end
    self.transform.localPosition = Vector3.New(position[1], position[2], position[3])
  end
  self.transform:SetParent(parent)
  local path = PathConsts:GetEffectPath(prefabName)
  resLoader:LoadABAssetAsync(path, function(prefab)
    if IsNull(prefab) or self.__stop then
      return
    end
    local go = prefab:Instantiate(self.transform)
    self.ui.effectGo = go
    self:PlayAvgEffect()
  end)
end

function UINAvgEffectItem:PlayAvgEffect()
  if IsNull(self.ui.effectGo) then
    return
  end
  self:Show()
  self.__stop = false
end

function UINAvgEffectItem:StopAvgEffect()
  self:Hide()
  self.__stop = true
end

function UINAvgEffectItem:OnDelete()
  base.OnDelete(self)
end

return UINAvgEffectItem

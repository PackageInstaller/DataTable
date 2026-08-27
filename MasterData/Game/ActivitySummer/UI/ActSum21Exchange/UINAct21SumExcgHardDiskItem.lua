local UINAct21SumExcgHardDiskItem = class("UINAct21SumExcgHardDiskItem", UIBaseNode)
local base = UIBaseNode
local cs_Material = CS.UnityEngine.Material

function UINAct21SumExcgHardDiskItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.disNoiseMat = cs_Material(self.ui.mat_DisNoise)
  self.ui.img_HDItem.material = self.disNoiseMat
  self:SetHardDiskItemDissolve(0)
end

function UINAct21SumExcgHardDiskItem:InitHardDiskItem(idx, poolId)
  self.idx = idx
  self.poolId = poolId
  self.gameObject.name = tostring(poolId)
end

function UINAct21SumExcgHardDiskItem:SetHardDiskItemDissolve(ratio)
  local radio = ratio * 0.65
  self.ui.img_HDItem.material:SetFloat("_Dissolve", ratio)
end

function UINAct21SumExcgHardDiskItem:PlayFxDOTween(curPickedNum, allRewardNum)
  self:KillTween()
  if allRewardNum == 0 then
    return
  end
  local radio = curPickedNum / allRewardNum * 0.65
  if radio == 0 then
    return
  end
  self:SetHardDiskItemDissolve(0)
  self.ui.img_HDItem.material:DOFloat(radio, "_Dissolve", 1)
end

function UINAct21SumExcgHardDiskItem:KillTween()
  self.ui.img_HDItem.material:DOKill()
end

function UINAct21SumExcgHardDiskItem:OnDelete()
  self:KillTween()
  DestroyUnityObject(self.disNoiseMat)
  base.OnDelete(self)
end

return UINAct21SumExcgHardDiskItem

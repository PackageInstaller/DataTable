local UINLtrSWaveRing = class("UINLtrSWaveRing", UIBaseNode)
local base = UIBaseNode
local cs_Material = CS.UnityEngine.Material

function UINLtrSWaveRing:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINLtrSWaveRing:InitLtrSWaveRing(pos, color)
  self.transform.anchoredPosition = pos
  self.transform.sizeDelta = Vector2.zero
  self.ui.dtAnim:DORestart()
  if self.mat == nil then
    self.mat = cs_Material(self.ui.img.material)
    self.ui.img.material = self.mat
  end
  self.mat:SetColor("_Maincolor", color)
end

function UINLtrSWaveRing:OnDelete()
  DestroyUnityObject(self.mat)
  self.mat = nil
  base.OnDelete(self)
end

return UINLtrSWaveRing

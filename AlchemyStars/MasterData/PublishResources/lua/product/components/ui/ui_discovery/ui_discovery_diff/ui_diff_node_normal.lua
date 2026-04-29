_class("UIDiffNodeNorm", UIDiffNodeBase)
UIDiffNodeNorm = UIDiffNodeNorm

function UIDiffNodeNorm:SetInfo()
  local tips = "str_diff_mission_node_tips_norm"
  local name = self._node:NodeName()
  local cup1, cup2 = self._node:CupNum()
  self._texName:SetText(StringTable.Get(tips))
  self._texTip:SetText(StringTable.Get(name))
  self._cupNum:SetText(cup1 .. "/" .. cup2)
end

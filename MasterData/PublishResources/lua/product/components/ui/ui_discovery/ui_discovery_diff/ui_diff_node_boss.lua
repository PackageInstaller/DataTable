_class("UIDiffNodeBoss", UIDiffNodeBase)
UIDiffNodeBoss = UIDiffNodeBoss

function UIDiffNodeBoss:SetInfo()
  local name = self._node:NodeName()
  local cup1, cup2 = self._node:CupNum()
  local bossCg = self._node:Boss()
  self._monster:LoadImage(bossCg)
  local tips = "str_diff_mission_node_tips_boss"
  self._texName:SetText(StringTable.Get(tips))
  self._texTip:SetText(StringTable.Get(name))
  self._cupNum:SetText(cup1 .. "/" .. cup2)
end

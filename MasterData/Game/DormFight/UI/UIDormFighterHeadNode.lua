local UIDormFighterHeadNode = class("UIDormFighterHeadNode", UIBaseNode)
UIDormFighterHeadNode.StateTextEnum = {
  EnterFight = 0,
  Waiting = 1,
  Retired = 2
}

function UIDormFighterHeadNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.killCount = 0
end

function UIDormFighterHeadNode:InitUIDormFighterHeadNode(headSprite)
  self:UpdateHeadSprite(headSprite)
end

function UIDormFighterHeadNode:UpdateHeadSprite(headSprite)
  self.transform.gameObject:SetActive(true)
  self.ui.spr_head.sprite = headSprite
  self:SetFailMask(false)
end

function UIDormFighterHeadNode:SetFailMask(isEnable)
  self.ui.obj_Fail:SetActive(isEnable)
end

return UIDormFighterHeadNode

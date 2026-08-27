local UIDormFighterInfoNode = class("UIDormFighterInfoNode", UIBaseNode)
local UIDormFighterHeadNode = require("Game.DormFight.UI.UIDormFighterHeadNode")

function UIDormFighterInfoNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.headNodeList = {}
  self.currentFighterHeadNode = UIDormFighterHeadNode.New()
  self.currentFighterHeadNode:Init(self.ui.Mainhero)
  self.ui.fighterHeadNode:SetActive(false)
end

function UIDormFighterInfoNode:InitUIDormFighterInfoNode(headSpriteList, userName)
  self.headSpriteList = headSpriteList
  if headSpriteList == nil then
    return
  end
  for i = 1, #headSpriteList do
    if i == 1 then
      self.currentFighterHeadNode:InitUIDormFighterHeadNode(headSpriteList[i])
      self.headNodeList[i] = self.currentFighterHeadNode
    else
      self.headNodeList[i] = UIDormFighterHeadNode.New()
      self.headNodeList[i]:Init(self.ui.fighterHeadNode:Instantiate(self.transform))
      self.headNodeList[i]:InitUIDormFighterHeadNode(headSpriteList[i])
    end
  end
  self.ui.tex_PlayerName.text = userName
end

function UIDormFighterInfoNode:UpdateHeadList(headSpriteList)
  for i = 1, #self.headNodeList do
    if i == 1 then
      self.currentFighterHeadNode:UpdateHeadSprite(headSpriteList[i])
    elseif headSpriteList[i] ~= nil then
      self.headNodeList[i]:UpdateHeadSprite(headSpriteList[i])
    end
  end
end

function UIDormFighterInfoNode:FighterRetired(index)
  local headCount = #self.headSpriteList
  if index < 1 or index > headCount then
    return
  end
  local newheadSpriteList = {}
  for i = index, index + headCount - 1 do
    local modIndex = i % headCount + 1
    table.insert(newheadSpriteList, self.headSpriteList[modIndex])
  end
  self:UpdateHeadList(newheadSpriteList)
  for i = 1, index do
    self.headNodeList[#self.headSpriteList + 1 - i]:SetFailMask(true)
  end
end

function UIDormFighterInfoNode:CurrentFighterRetired()
  if self.currentFighterHeadNode ~= nil then
    self.currentFighterHeadNode:SetFailMask(true)
  end
end

function UIDormFighterInfoNode:OnDelete()
  self.currentFighterHeadNode:Delete()
  self.currentFighterHeadNode = nil
  for i = 1, #self.headNodeList do
    if self.headNodeList[i] ~= nil then
      self.headNodeList[i]:Delete()
      self.headNodeList[i] = nil
    end
  end
  self.headNodeList = nil
end

return UIDormFighterInfoNode

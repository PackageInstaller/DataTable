local UINCarnival22ChallengeRankItem = class("UINCarnival22ChallengeRankItem", UIBaseNode)
local base = UIBaseNode
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")

function UINCarnival22ChallengeRankItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.userHead = UINUserHead.New()
  self.userHead:Init(self.ui.uINUserHead)
end

function UINCarnival22ChallengeRankItem:InitCarnivalChallengeRankItem(rankElemData, resloader)
  local rankAvatar = rankElemData.entry.avatar
  self.ui.tex_Rank.text = tostring(rankElemData.rankIdx)
  self.ui.tex_PlayerName.text = rankAvatar.name
  self.ui.myRank:SetActive(rankElemData.entry.uid == PlayerDataCenter.inforData:GetUserUID())
  self.userHead:InitUserHeadUI(rankAvatar.avatarId, rankAvatar.avatarFrame, resloader)
  local min = math.floor(rankElemData.second / 60)
  local sec = rankElemData.second % 60
  self.ui.tex_Time:SetIndex(0, string.format("%02d", min), string.format("%.03f", sec))
end

return UINCarnival22ChallengeRankItem

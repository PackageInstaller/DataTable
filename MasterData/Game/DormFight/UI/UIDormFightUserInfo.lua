local UIDormFightUserInfo = class("UIDormFightUserInfo", UIBaseNode)
local base = UIBaseNode
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")

function UIDormFightUserInfo:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.userHead = UINUserHead.New()
  self.userHead:Init(self.ui.uINUserHead)
end

function UIDormFightUserInfo:InitDormFightUserInfo(userInfoData, resLoader)
  self.userHead:InitUserHeadUI(userInfoData:GetAvatarId(), userInfoData:GetAvatarFrameId(), resLoader)
  self.ui.tex_name.text = userInfoData:GetUserName()
  local dormFightRecordData = userInfoData:GetDormFight1v1RecordData()
  if not IsNull(self.ui.tex_winCount) then
    self.ui.tex_winCount.text = dormFightRecordData.winCount
  end
  if not IsNull(self.ui.tex_winningPercentage) then
    self.ui.tex_winningPercentage.text = dormFightRecordData:GetWinRate()
  end
end

function UIDormFightUserInfo:OnDelete()
  self.userHead:Delete()
  self.userHead = nil
end

return UIDormFightUserInfo

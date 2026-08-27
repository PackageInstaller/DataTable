local base = UIBaseNode
local UINWarChessMain_PNTeamDeadItem = class("UINWarChessMain_PNTeamDeadItem", base)

function UINWarChessMain_PNTeamDeadItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWarChessMain_PNTeamDeadItem:InitWCPlayTeamItem(teamData, wcCtrl, resloader)
  self.teamData = teamData
  self.resloader = resloader
  self.wcCtrl = wcCtrl
  local index = self.teamData:GetWCTeamIndex()
  self.gameObject.name = tostring(index)
  self:RefreshTeamLeaderPic()
  self:RefreshTeamPower()
end

function UINWarChessMain_PNTeamDeadItem:RefreshTeamLeaderPic()
  local firstHeroId = self.teamData:GetFirstHeroId()
  local dynHeroData = self.wcCtrl.teamCtrl:GetHeroDynDataById(firstHeroId)
  if dynHeroData == nil then
    error("team leader data not exist")
    return
  end
  self.resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(dynHeroData:GetResPicName()), function(texture)
    if IsNull(self.transform) or IsNull(texture) then
      return
    end
    self.ui.img_TeamHeroPic.texture = texture
  end)
  self.ui.tex_TeamName.text = self.teamData:GetWCTeamName()
end

function UINWarChessMain_PNTeamDeadItem:RefreshTeamPower()
  self.ui.tex_Power.text = tostring(0)
end

function UINWarChessMain_PNTeamDeadItem:OnDelete()
end

return UINWarChessMain_PNTeamDeadItem

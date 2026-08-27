local base = UIBaseNode
local UINWarChessInheritTeamItem = class("UINWarChessInheritTeamItem", UIBaseNode)
local UINWarChessMain_DNTeamItemHeroItem = require("Game.WarChess.UI.Main.UINWarChessMain_DNTeamItemHeroItem")

function UINWarChessInheritTeamItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.heroHeadPool = UIItemPool.New(UINWarChessMain_DNTeamItemHeroItem, self.ui.heroHeadItem)
  self.ui.heroHeadItem:SetActive(false)
end

function UINWarChessInheritTeamItem:InitWCDeployTeamItem(dTeamData, resloader)
  self.dTeamData = dTeamData
  self.resloader = resloader
  self:RefreshTeamItem()
end

function UINWarChessInheritTeamItem:RefreshTeamItem()
  local firstHeroData, teamPower, heroDataList, isDeployed, teamName
  firstHeroData = self.dTeamData:GetFirstHeroData()
  teamPower = self.dTeamData:GetDTeamTeamPower()
  heroDataList = self.dTeamData:GetTeamMemberHeroDataList()
  isDeployed = self.dTeamData:GetIsDeploied()
  teamName = self.dTeamData:GetDTeamName()
  self.__couldDeploy = true
  self.__isHaveHero = firstHeroData ~= nil
  self.ui.realTeam:SetActive(self.__isHaveHero)
  if self.__isHaveHero then
    self.ui.img_HeroPic.texture = self.resloader:LoadABAsset(PathConsts:GetCharacterPicPath(firstHeroData:GetResPicName()))
    self.ui.tex_TeamPow.text = tostring(teamPower)
    self.ui.tex_TeamName.text = teamName
    self.heroHeadPool:HideAll()
    for index, heroData in ipairs(heroDataList) do
      local heroHeadItem = self.heroHeadPool:GetOne()
      heroHeadItem:InitWCHeroHeadItem(heroData, index == 1)
    end
  end
end

return UINWarChessInheritTeamItem

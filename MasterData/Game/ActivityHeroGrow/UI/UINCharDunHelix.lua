local base = require("Game.ActivityHeroGrow.UI.UINCharaDungeonBase")
local UINCharDunHelix = class("UINCharDunHelix", base)
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroLookTargetController = require("Game.Hero.Live2D.HeroLookTargetController")
local HeroData = require("Game.PlayerData.Hero.HeroData")
local cs_MovieManager = CS.MovieManager.Instance

function UINCharDunHelix:OnInit()
  base.OnInit(self)
  self.heroID = 1052
  self:_LoadMovie()
end

function UINCharDunHelix:_LoadMovie()
  self.ui.img_movie.enabled = false
  if self.moviePlayer == nil then
    self.moviePlayer = cs_MovieManager:GetMoviePlayer()
  end
  self.moviePlayer:SetVideoRender(self.ui.img_movie)
  local path = PathConsts:GetCharDunVideoPath(self.heroID)
  self.moviePlayer:PlayVideo(path, nil, 1, true)
  self.ui.img_movie.enabled = true
end

function UINCharDunHelix:OnDelete()
  if self.moviePlayer ~= nil then
    cs_MovieManager:ReturnMoviePlayer(self.moviePlayer)
    self.moviePlayer = nil
  end
  base.OnDelete(self)
end

return UINCharDunHelix

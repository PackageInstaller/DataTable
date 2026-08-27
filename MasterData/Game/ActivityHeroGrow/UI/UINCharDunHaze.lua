local base = require("Game.ActivityHeroGrow.UI.UINCharaDungeonBase")
local UINCharDunHaze = class("UINCharDunKuro", base)
local cs_LeanTouch = CS.Lean.Touch.LeanTouch
local cs_ResLoader = CS.ResLoader
local cs_MovieManager = CS.MovieManager.Instance

function UINCharDunHaze:OnInit()
  base.OnInit(self)
  self._onGesture = BindCallback(self, self._OnGesture)
  self._onFingerDown = BindCallback(self, self._OnFingerDown)
  self.heroID = 1046
  self:_LoadMovie()
end

function UINCharDunHaze:OnShow()
  cs_LeanTouch.OnGesture("+", self._onGesture)
  cs_LeanTouch.OnFingerDown("+", self._onFingerDown)
end

function UINCharDunHaze:OnHide()
  cs_LeanTouch.OnGesture("-", self._onGesture)
  cs_LeanTouch.OnFingerDown("-", self._onFingerDown)
end

function UINCharDunHaze:_OnGesture(fingerList)
  if not self._isValidTouch then
    return
  end
  if fingerList.Count == 1 then
    local touch = fingerList[0]
    self:_CalculateMove(touch)
  end
end

local cd = 0
local photo = 8

function UINCharDunHaze:_CalculateMove(touch)
  local diffPos = touch.ScreenPosition - touch.LastScreenPosition
  cd = cd - diffPos.x * 0.03
  cd = math.clamp(cd, -21, 0)
  self.ui.rect_CD.localRotation = Quaternion.Euler(0, 0, cd)
  photo = photo - diffPos.x * 0.006
  photo = math.clamp(photo, 4, 8)
  self.ui.rect_Photo.localRotation = Quaternion.Euler(0, 0, photo)
end

function UINCharDunHaze:_OnFingerDown(finger)
  self._isValidTouch = self:_CheckIsValidTouch(finger)
end

function UINCharDunHaze:_CheckIsValidTouch(finger)
  local result = cs_LeanTouch.RaycastGui(finger.ScreenPosition)
  if result.Count == 0 then
    return false
  end
  local res = result[0]
  if res.gameObject ~= self.ui.animaNode then
    return false
  end
  return true
end

function UINCharDunHaze:_LoadMovie()
  self.ui.img_Movie.enabled = false
  self.ui.img_PhotoPic.enabled = true
  local fullPath = PathConsts:GetCharDunVideoFullPath(self.heroID)
  local hasMovie = CS.ResManager.Instance:ContainsAsset(fullPath)
  if not hasMovie then
    return
  end
  if self.moviePlayer == nil then
    self.moviePlayer = cs_MovieManager:GetMoviePlayer()
  end
  self.moviePlayer:SetVideoRender(self.ui.img_Movie)
  local path = PathConsts:GetCharDunVideoPath(self.heroID)
  self.moviePlayer:PlayVideo(path, nil, 1, true)
  self.ui.img_Movie.enabled = true
  self.ui.img_PhotoPic.enabled = false
end

function UINCharDunHaze:OnDelete()
  if self.moviePlayer ~= nil then
    cs_MovieManager:ReturnMoviePlayer(self.moviePlayer)
    self.moviePlayer = nil
  end
  base.OnDelete(self)
end

return UINCharDunHaze

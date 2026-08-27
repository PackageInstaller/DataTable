local UIMoviePlayer = class("UIMoviePlayer", UIBaseWindow)
local base = UIBaseWindow
local cs_MovieManager = CS.MovieManager.Instance
local cs_ResLoader = CS.ResLoader
local util = require("XLua.Common.xlua_util")

function UIMoviePlayer:OnInit()
end

function UIMoviePlayer:PlayMovie(moviePath, vedioEndCallback, speed, loop, closeCallback)
  self.moviePlayer = cs_MovieManager:GetMoviePlayer()
  self._moviePath = moviePath
  self._speed = speed
  self._loop = loop
  self._closeCallback = closeCallback
  self.vedioEndCallback = vedioEndCallback
  if self.moviePlayer == nil then
    return
  end
  self.__canPlayCoroutine = GR.StartCoroutine(util.cs_generator(BindCallback(self, self.WaitMovePlayerEnd)))
end

function UIMoviePlayer:WaitMovePlayerEnd()
  while not self.moviePlayer.IsMovieEnd do
    coroutine.yield(nil)
  end
  self.moviePlayer:SetVideoRender(self.ui.img_Vedio)
  self.moviePlayer:PlayVideo(self._moviePath, self.vedioEndCallback, self._speed, self._loop)
  self.__canPlayCoroutine = nil
end

function UIMoviePlayer:AddUIParticle(effectPath, loadCallback)
  if effectPath == nil then
    return
  end
  if self.resLoader == nil then
    self.resLoader = cs_ResLoader.Create()
  end
  self.resLoader:LoadABAssetAsync(effectPath, function(prefab)
    if prefab == nil then
      return
    end
    local effect = prefab:Instantiate(self.ui.UIEffectRoot.transform)
    effect.transform:SetLayer(LayerMask.UI)
    if loadCallback ~= nil then
      loadCallback(effect)
    end
  end)
end

function UIMoviePlayer:SetBgAlpha(alpha)
  if self.ui == nil or IsNull(self.ui.img_Vedio) then
    return
  end
  local tempColor = self.ui.img_BG.color
  tempColor.a = alpha
  self.ui.img_BG.color = tempColor
end

function UIMoviePlayer:SetMovieFade(startTime, keepTime)
  if startTime == nil or keepTime == nil then
    return
  end
  self.ui.img_BG:DOKill(false)
  self.ui.img_BG:DOFade(0, keepTime):SetLink(self.gameObject):SetDelay(startTime):OnComplete(function()
    self:CloseMoviePlayer()
  end)
end

function UIMoviePlayer:SetUIMaskOpen(bool)
  self.ui.uIMask:SetActive(bool)
end

function UIMoviePlayer:CloseMoviePlayer()
  if self._closeCallback ~= nil then
    self._closeCallback()
  end
  if not IsNull(self.moviePlayer) then
    cs_MovieManager:ReturnMoviePlayer(self.moviePlayer)
    self.moviePlayer = nil
  end
  if self.ui ~= nil and not IsNull(self.ui.img_BG) then
    self.ui.img_BG:DOKill(false)
  end
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  if self.__canPlayCoroutine ~= nil then
    GR.StopCoroutine(self.__canPlayCoroutine)
    self.__canPlayCoroutine = nil
  end
  self:Delete()
end

return UIMoviePlayer

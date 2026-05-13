local BattleRes = "ui/battle/"
local uiData = {
  csbFile = "ui/battle/BattlePauseLayer.csb",
  mask = true,
  opacity = 191,
  widgets = {btnResume = "btnResume", btnMusic = "btnMusic"}
}
local BattlePauseLayer = class("BattlePauseLayer", UIBase)

function BattlePauseLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function BattlePauseLayer:init(params)
  self.musicOn = UserData.music > 0 or 0 < UserData.sound or 0 < UserData.cv
  if UIHelper.isiPhoneX() then
    self.btnResume:setPositionX(self.btnResume:getPositionX() - UIHelper.getMoveXForX())
    self.btnMusic:setPositionX(self.btnMusic:getPositionX() - UIHelper.getMoveXForX())
  end
  self.btnResume:setCallback(function()
    self.parent:resume()
    self:close()
  end)
  self.btnMusic:setCallback(function()
    self:switchMusic()
    self:showData()
  end)
  self.battleType = params.battleType
  self.parent = params.parent
end

function BattlePauseLayer:showData()
  if self.musicOn then
    self.btnMusic:setImages(BattleRes, {
      "music_on.png",
      "music_on.png"
    })
  else
    self.btnMusic:setImages(BattleRes, {
      "music_off.png",
      "music_off.png"
    })
  end
end

function BattlePauseLayer:switchMusic()
  self.musicOn = not self.musicOn
  local volume = self.musicOn and 80 or 0
  UserData.music = volume
  UserData.sound = volume
  UserData.cv = volume
  game:setMusicVolume(1, volume)
  game:setMusicVolume(2, volume)
  game:setMusicVolume(3, volume)
end

return BattlePauseLayer

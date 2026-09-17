local this = class("pageGetHero", G_UIPageBase)
local _heroTpl = L_GameTpl:getHeroTpl()
local _professionTpl = L_GameTpl:getProfessionTpl()

function this.bind()
  return {
    txt_heroName = "",
    img_profession = "",
    img_hero = "",
    img_hero_yy = ""
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(options)
  if not options.configId then
    return
  end
  local heroCfg = _heroTpl:getTplById(options.configId)
  self.bind.txt_heroName = _heroTpl:getName(heroCfg)
  local heroClothingTpl = L_GameTpl:getHeroClothingTpl()
  local clothingData = heroClothingTpl:getTplById(options.configId)
  self.bind.img_hero = heroClothingTpl:getAvatarTexture(clothingData, 6)
  self.bind.img_hero_yy = heroClothingTpl:getAvatarTexture(clothingData, 6)
  local position = _heroTpl:getPosition(heroCfg)
  local professionCfg = _professionTpl:getTplById(position)
  self.bind.img_profession = _professionTpl:getIcon(professionCfg, 2)
  self._closeCallback = options.callback
end

function this:open()
  L_AudioUtil.playSound("Play_SFX_System_HUD_General_CHAR_Obtain")
end

function this:close(options)
  this.super.close(self, options)
  if self._closeCallback ~= nil then
    self._closeCallback()
  end
end

return this

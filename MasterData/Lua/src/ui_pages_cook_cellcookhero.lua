local this = class("cellCookHero", G_UIModuleBase)

function this.bind()
  return {
    name = "",
    icon = "",
    quality = "",
    lv = "",
    choice = false
  }
end

function this.methods()
  return {
    onClick_choice = function(self)
      self:emit("selectHero", self.bind.heroId)
    end
  }
end

function this:refresh()
  if self.bind.heroId == L_HeroStore:getDefaultHeroGuid() then
    if self.photoEntity then
      self.photoEntity:bindGameObject(self.bindComponents.heroIcon.gameObject)
    else
      self.photoEntity = L_PhotoManager:bindPhotoEntity(self.bindComponents.heroIcon.gameObject, L_PlayerStore:getPlayerModHeadImgName())
    end
  end
end

function this:close()
  if self.photoEntity then
    self.photoEntity:dispose()
    self.photoEntity = nil
  end
end

return this

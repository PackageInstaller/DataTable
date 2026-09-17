local this = class("cellBattleDialog", G_UIModuleBase)

function this.bind()
  return {
    img_head = "",
    txt_name = "",
    txt_content = "",
    txtColor_name = ""
  }
end

function this.methods()
  return {}
end

function this:toBind(uiBinding)
  self.super.toBind(self, uiBinding)
end

function this:unBind()
  self.super.unBind(self)
  L_PhotoManager:releaseHead(self)
end

function this:refresh()
  if self.bind.heroId == L_HeroStore:getDefaultHeroGuid() and self.bindComponents.icon then
    L_PhotoManager:fillMainHead(self, self.bindComponents.icon.gameObject)
  end
end

return this

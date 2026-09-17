local this = class("heroListBox", G_UIModuleBase)

function this.bind()
  return {
    firstHeroCell = false,
    firstCell = {
      moduleName = "pages/HeroPanel/heroListCell/heroListCell"
    },
    secondHeroCell = false,
    secondCell = {
      moduleName = "pages/HeroPanel/heroListCell/heroListCell"
    },
    arrowImage = false
  }
end

function this.methods()
  return {}
end

function this:refresh()
  if self.bind.firstData ~= nil then
    self.modules.firstCell:tryInitCell(self.bind.firstData, self.bind.selectHeroId, function()
      self.bind.callBack(self.bind.firstData.hero_id)
    end)
  end
  if self.bind.secondData ~= nil then
    self.modules.secondCell:tryInitCell(self.bind.secondData, self.bind.selectHeroId, function()
      self.bind.callBack(self.bind.secondData.hero_id)
    end)
  end
end

return this

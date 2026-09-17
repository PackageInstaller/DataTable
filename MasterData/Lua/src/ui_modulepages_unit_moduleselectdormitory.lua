local this = class("moduleSelectDormitory", G_UIModuleBase)

function this.bind()
  return {
    list_hero_shrink = {
      moduleName = "modulePages/cellIconReplace"
    }
  }
end

function this.methods()
  return {}
end

function this:open()
end

function this:close(options)
end

function this:initModule()
  self:initHeroList()
  self:initListState()
end

function this:initHeroList()
  local allHero = L_HeroStore:getAllHero()
  self._heroTotalDataList = {}
  for i, v in pairs(allHero) do
    local data = {
      itemType = L_Const.resType.hero,
      itemId = L_HeroStore:getHeroConfigId(v),
      guid = L_HeroStore:getHeroGuid(v)
    }
    table.insert(self._heroTotalDataList, data)
  end
end

function this:initListState()
end

return this

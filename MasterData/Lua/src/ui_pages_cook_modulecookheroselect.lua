local this = class("moduleCookHeroSelect", G_UIModuleBase)

function this.bind()
  return {
    cellCookHero = {
      moduleName = "modulePages/cellIconUnit"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      self.closeModule()
    end,
    onClick_confirm = function(self)
      self.confirm(self.heroId)
    end,
    cellCookHero = {
      selectHero = function(self, heroId)
        self.heroId = heroId
        for i = 1, #self.bind.cellCookHero do
          if self.bind.cellCookHero:getValue(i, "heroId") == heroId then
            self.bind.cellCookHero:change(i, {choice = true})
          else
            self.bind.cellCookHero:change(i, {choice = false})
          end
        end
      end
    }
  }
end

function this:initModule(options)
  self.closeModule = options.close
  self.confirm = options.confirm
  self.heroId = L_CookStore:getCookHero()
  local heroList = L_HeroStore:getAllHero()
  
  local function onClickCell(cell)
    local heroId = cell.bind.guid
    self.heroId = heroId
    for i = 1, #self.bind.cellCookHero do
      if self.bind.cellCookHero:getValue(i, "guid") == heroId then
        self.bind.cellCookHero:change(i, {activeSelect = true})
      else
        self.bind.cellCookHero:change(i, {activeSelect = false})
      end
    end
    self.confirm(self.heroId)
  end
  
  local temp = {}
  for i, v in pairs(heroList) do
    local hero_id = L_HeroStore:getHeroGuid(v)
    local choice = false
    if L_HeroStore:getHeroGuid(v) == self.heroId then
      choice = true
    end
    table.insert(temp, {
      itemType = L_Const.resType.hero,
      guid = hero_id,
      index = i,
      callback = onClickCell,
      activeSelect = choice,
      star = L_HeroStore:getHeroStar(v)
    })
  end
  table.sort(temp, function(a, b)
    return a.guid < b.guid
  end)
  self.bind.cellCookHero:clear()
  self.bind.cellCookHero:insert_array(temp)
end

return this

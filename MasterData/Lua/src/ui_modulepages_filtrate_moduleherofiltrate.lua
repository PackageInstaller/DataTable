local page = class("moduleHeroFiltrate", G_UIModuleBase)
local wordsTpl = L_GameTpl:getWordsTpl()
local FILTRATE = {
  {
    L_Const.sortType.lv,
    wordsTpl:getTplById("menu_common_level")
  },
  {
    L_Const.sortType.quality,
    wordsTpl:getTplById("menu_common_rarity")
  },
  {
    L_Const.sortType.star,
    wordsTpl:getTplById("menu_common_star")
  }
}
local PROFESSION = {
  wordsTpl:getTplById("hero_type_1"),
  wordsTpl:getTplById("hero_type_2"),
  wordsTpl:getTplById("hero_type_3"),
  wordsTpl:getTplById("hero_type_4"),
  wordsTpl:getTplById("hero_type_5")
}

function page.bind()
  return {
    sortWayList = {
      moduleName = "modulePages/filtrate/cellFiltrateSortItem"
    },
    professionItemList = {
      moduleName = "modulePages/filtrate/cellFiltrateInfoItem"
    },
    filterText = ""
  }
end

function page.methods()
  return {
    closeOnClick = function(self)
      self:filtrateCondition()
      self.filtrate(self.professionData)
      self.closeModule()
    end,
    affirmOnClick = function(self)
      self:filtrateCondition()
      self.filtrate(self.professionData)
      self.closeModule()
    end,
    resetOnClick = function(self)
      self:resetSet()
    end,
    sortWayList = {
      sortType = function(self, num, type, way)
        for i = 1, #self.bind.sortWayList do
          if i ~= num then
            self.bind.sortWayList:change(i, {
              background = true,
              backgroundCheck = false,
              checkmark = false
            })
          end
        end
        self.sortType = type
        self.sortWay = way
      end
    }
  }
end

function page:initModule(option)
  self.bind.filterText = L_WordsTpl:getValue("ui_hintCamp_01")
  if option.filterText then
    self.bind.filterText = option.filterText
  end
  self.closeModule = option.closeCurModule
  self.filtrate = option.filtrate
  self.professionData = {}
  self.bind.sortWayList:clear()
  local num = 0
  local tempData = {}
  for i, v in pairs(FILTRATE) do
    num = num + 1
    table.insert(tempData, {
      num = num,
      background = true,
      checkmark = false,
      backgroundCheck = false,
      sortType = v[1],
      bgText = v[2],
      checkText = v[2],
      bgCheckText = v[2]
    })
  end
  self.bind.sortWayList:insert_array(tempData)
  self.bind.sortWayList:change(1, {background = false, backgroundCheck = true})
  self.sortType = L_Const.sortType.lv
  self.sortWay = L_Const.sortOrder.DESC
  self.bind.professionItemList:clear()
  tempData = {}
  if option.filterOptions then
    tempData = option.filterOptions
  else
    for k, v in pairs(PROFESSION) do
      table.insert(tempData, {
        name1 = v,
        name2 = v,
        id = k
      })
    end
  end
  self.bind.professionItemList:insert_array(tempData)
end

function page:filtrateCondition()
  self.professionData = {}
  for k = 1, #self.bind.professionItemList do
    if self.bind.professionItemList:getValue(k, "pitchOn") then
      table.insert(self.professionData, k)
    end
  end
end

function page:resetSet()
  self.professionData = {}
  for i = 1, #self.bind.professionItemList do
    self.bind.professionItemList:change(i, {pitchOn = false})
  end
end

return page

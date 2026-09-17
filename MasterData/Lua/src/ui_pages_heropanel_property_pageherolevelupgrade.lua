local this = class("pageHeroLevelUpgrade", G_UIPageBase)
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()

function this.bind()
  return {
    txt_mainAtt_value_new = "",
    scrollList_att = {
      moduleName = "pages/HeroPanel/hero/heroProperty"
    }
  }
end

function this.methods()
  return {
    onClick_mask = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  if options and not math.isEmpty(options.heroId) then
    self:initHeroPage(options)
  end
  if options and not math.isEmpty(options.petId) then
    self:initPetPage(options)
  end
  self._callback = options.callback or nil
end

function this:initPetPage(options)
  local data = options.data or {}
  local tmp = {}
  local pet = L_PetStore:getPetItem(options.petId)
  self.bind.txt_mainAtt_value_new = tostring(pet.lv)
  for i, v in ipairs(data) do
    local tpl = battleInfoTpl:getTplById(v.enumId)
    local isBgShow = math.floor(i % 2) > 0
    local element = {
      toggle_state = isBgShow,
      curAttr = battleInfoTpl:getShowTxtComma(v.enumId, v.oldValue),
      nextAttr = battleInfoTpl:getShowTxtComma(v.enumId, v.newValue),
      name = battleInfoTpl:getName(tpl),
      icon = battleInfoTpl:getIcon(tpl),
      active_icon = true,
      id = v.enumId
    }
    table.insert(tmp, element)
  end
  self.bind.scrollList_att:clear()
  self.bind.scrollList_att:insert_array(tmp)
end

function this:initHeroPage(options)
  local attId = battleInfoTpl:getShowTypeLvUpAttrs()
  local heroId = options.heroId
  local hero = L_HeroStore:getHero(heroId)
  local heroConfigId = L_HeroStore:getHeroConfigId(hero)
  local oldLevel = options.oldLevel or 1
  local newLevel = options.newLevel or 1
  local heroRank = options.heroRank or 1
  local property = {}
  local heroConfigAtt = L_AttributeManager:parseHeroConfigAtt(heroId, oldLevel)
  local runes = L_HeroStore:getHeroRuneIds(hero)
  local heroStarConfigAtt = L_HeroManager:getHeroStarGiftByHeroIdAndRank(heroConfigId, heroRank, runes)
  local mergeAttr = L_AttributeManager:mergeAttDic(heroConfigAtt, heroStarConfigAtt)
  local baseAtt = {}
  for i, v in pairs(attId) do
    local id, value = L_AttributeManager:getHeroAttValue(mergeAttr, v)
    property[v] = value
    baseAtt[v] = true
  end
  for i, v in pairs(heroStarConfigAtt) do
    local group, value = L_AttributeManager:getHeroAttValue(mergeAttr, i)
    if not baseAtt[group] then
      property[group] = value
    end
  end
  local propertyHeroLv = {}
  heroConfigAtt = L_AttributeManager:parseHeroConfigAtt(heroId, newLevel)
  heroStarConfigAtt = L_HeroManager:getHeroStarGiftByHeroIdAndRank(heroConfigId, heroRank, runes)
  mergeAttr = L_AttributeManager:mergeAttDic(heroConfigAtt, heroStarConfigAtt)
  for i, v in pairs(attId) do
    local id, value = L_AttributeManager:getHeroAttValue(mergeAttr, v)
    propertyHeroLv[v] = value
  end
  for i, v in pairs(heroStarConfigAtt) do
    local group, value = L_AttributeManager:getHeroAttValue(mergeAttr, i)
    if not baseAtt[group] then
      propertyHeroLv[group] = value
    end
  end
  self.bind.txt_mainAtt_value_new = tostring(newLevel)
  self:initPage(property, propertyHeroLv)
end

function this:close(options)
  this.super.close(self, options)
  if self._callback then
    self._callback()
  end
end

function this:initPage(oldData, newData)
  local attId = battleInfoTpl:getShowTypeLvUpAttrs()
  local tmp = {}
  local index = 0
  for i, v in pairs(attId) do
    local oldValue = oldData[attId[i]] or 0
    local newValue = newData[attId[i]] or 0
    if oldValue ~= newValue then
      index = index + 1
      local tpl = battleInfoTpl:getTplById(v)
      local isBgShow = 0 < math.floor(index % 2)
      local element = {
        toggle_state = not isBgShow,
        curAttr = battleInfoTpl:getShowTxtComma(attId[i], oldValue),
        nextAttr = battleInfoTpl:getShowTxtComma(attId[i], newValue),
        name = battleInfoTpl:getName(tpl),
        icon = battleInfoTpl:getIcon(tpl),
        active_icon = true,
        id = attId[i]
      }
      table.insert(tmp, element)
    end
  end
  L_HeroManager:sortAttrId(tmp)
  self.bind.scrollList_att:clear()
  self.bind.scrollList_att:insert_array(tmp)
end

return this

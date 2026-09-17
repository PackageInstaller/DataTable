local this = class("pagePetFavorDetail", G_UIPageBase)
local _petFavorabilityTpl = L_GameTpl:getPetFavorabilityTpl()
local _petAttributeinheritanceTpl = L_GameTpl:getPetAttributeinheritanceTpl()
local _battleInfoTpl = L_GameTpl:getBattleInfoTpl()

function this.bind()
  return {
    txt_favorLv = "",
    txt_favorVal = "",
    go_locked = false,
    go_favorTips = false,
    txt_favorTips = "",
    go_currentLvTips = false,
    txt_favorLvDesc = "",
    txt_curSelectFavorLv = "",
    toggle_showAttrs = false,
    list_attr = {
      moduleName = "pages/pet/cellAttrItem"
    },
    favorLevelList = {
      moduleName = "pages/HeroPanel/favorability/cellHeroFavorabilityLevel"
    },
    go_left = false,
    go_right = false
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_close1 = function(self)
      L_UI:close(self.pageName)
    end,
    favorLevelList = {
      selectLevel = function(self, id)
        if self.selectLevel ~= id then
          self:setSelectLevel(id)
        end
      end
    },
    onClick_left = function(self)
      self:setSelectLevel(self.selectLevel - 1, true)
    end,
    onClick_right = function(self)
      self:setSelectLevel(self.selectLevel + 1, true)
    end
  }
end

function this:preOpen(options)
  self.petGuid = options.petGuid
  self.petItem = L_PetStore:getPetItem(self.petGuid)
  self:initPage()
end

function this:initPage()
  self.curLevel = self.petItem:petFavorLv()
  local curExp = self.petItem:petFavorVal()
  self.bind.txt_favorLv = tostring(self.petItem:petFavorLv())
  if _petFavorabilityTpl:getIsMaxLv(self.curLevel) then
    self.bind.txt_favorVal = L_WordsTpl:getValue("notice_pagePetFavorDetail")
  else
    self.bind.txt_favorVal = string.format("%d/%d", curExp, _petFavorabilityTpl:getUpgradeExp(self.curLevel))
  end
  self:setSelectLevel(self.curLevel)
  self:refreshLevelArea()
  self:foucsLevelIndex(true)
end

function this:foucsLevelIndex(bOpen)
  local maxLevel = _petFavorabilityTpl:getMaxLv()
  if self.selectLevel > 2 and self.selectLevel < maxLevel - 2 then
    self.bindComponents.levelTableView:FocusItemIndex(self.selectLevel - 3)
  end
  if self.selectLevel >= maxLevel - 2 then
    self.bindComponents.levelTableView.horizontalNormalizedPosition = 1
    if bOpen then
      Timer.once(0.1, function()
        self.bindComponents.levelTableView.horizontalNormalizedPosition = 1
      end, self, self.gameObject)
    end
  end
end

function this:setSelectLevel(level, isToCell)
  local maxLevel = _petFavorabilityTpl:getMaxLv()
  if level <= 1 then
    level = 1
    self.bind.go_left = false
    self.bind.go_right = true
  end
  if maxLevel <= level then
    level = maxLevel
    self.bind.go_left = true
    self.bind.go_right = false
  end
  if 1 < level and maxLevel > level then
    self.bind.go_left = true
    self.bind.go_right = true
  end
  if self.selectLevel == level then
    return
  end
  self.selectLevel = level
  for i = 1, #self.bind.favorLevelList do
    local favorabilityLevel = self.bind.favorLevelList:getValue(i, "level")
    self.bind.favorLevelList:change(i, {
      selected = favorabilityLevel == self.selectLevel
    })
  end
  if isToCell then
    self.bindComponents.levelScroll:ScrollToCell(self.selectLevel - 3, 500)
  end
  self:refreshDetailArea()
end

function this:refreshDetailArea()
  if self.lastSelectLevel ~= nil then
    self.bindComponents.switchAnimation:Stop()
    if self.lastSelectLevel > self.selectLevel then
      self.bindComponents.switchAnimation:Play("anim_hero_favor_content_show_left")
    end
    if self.lastSelectLevel < self.selectLevel then
      self.bindComponents.switchAnimation:Play("anim_hero_favor_content_show_right")
    end
  end
  self.lastSelectLevel = self.selectLevel
  self.bind.go_currentLvTips = self.curLevel == self.selectLevel
  self.bind.go_locked = self.curLevel < self.selectLevel
  self.bind.txt_curSelectFavorLv = L_GameTpl:getWordsTpl():getTplById("ui_favor_level") .. tostring(self.selectLevel)
  self.bind.txt_favorLvDesc = _petFavorabilityTpl:getDesc(self.selectLevel)
  self.bind.go_favorTips = self.curLevel < self.selectLevel
  if self.curLevel < self.selectLevel then
    self.bind.txt_favorTips = L_WordsTpl:getValue("ui_favor_unsatisified", {
      [0] = _petFavorabilityTpl:getUpgradeExp(self.selectLevel - 1)
    })
  end
  self:refreshPetAttrInherent(self.selectLevel)
end

function this:refreshPetAttrInherent(favorLv)
  local heroId = self.petItem:getHeroId()
  local heroInfo = L_HeroStore:getHero(heroId)
  if heroInfo then
    local inheritAttr = L_PetStore:getAttrInheritFromHero(heroInfo, favorLv)
    local inheritAttrList = {}
    for petAttrId, value in pairs(inheritAttr) do
      if 0 < value then
        local tpl = _battleInfoTpl:getTplById(petAttrId)
        local showValue = _battleInfoTpl:getShowTxt(petAttrId, value)
        table.insert(inheritAttrList, {
          attrIcon = _battleInfoTpl:getIcon(tpl),
          value = string.concat("+", showValue),
          name = _battleInfoTpl:getName(tpl),
          sortId = petAttrId
        })
      end
    end
    table.sort(inheritAttrList, function(a, b)
      return a.sortId < b.sortId
    end)
    self.bind.toggle_showAttrs = 0 < #inheritAttrList
    self.bind.list_attr:clear()
    self.bind.list_attr:insert_array(inheritAttrList)
  end
end

function this:refreshLevelArea()
  self.bind.favorLevelList:clear()
  local levelData = {}
  local maxLevel = _petFavorabilityTpl:getMaxLv()
  for i = 1, maxLevel do
    table.insert(levelData, {
      level = i,
      selected = i == self.selectLevel,
      hideRight = i == maxLevel
    })
  end
  self.bind.favorLevelList:insert_array(levelData)
end

function this:close()
end

return this

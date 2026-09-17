local this = class("pageCook", G_UIPageBase)
local commonItemTpl = L_GameTpl:getCommonItemTpl()
local foodCookTpl = L_GameTpl:getFoodCookTpl()
local foodTypeTpl = L_GameTpl:getFoodTypeTpl()
local foodTpl = L_GameTpl:getFoodTpl()

function this.bind()
  return {
    heroName = "",
    lifeSkill = "",
    headIcon = "",
    foodBg = "",
    recipeNum = "",
    titleIcon = "",
    name = "",
    icon = "",
    type = "",
    proficiency_1 = C_LuaUtility.ParseHtmlStringColor("#C3C3C3"),
    proficiency_2 = C_LuaUtility.ParseHtmlStringColor("#C3C3C3"),
    count = "",
    func = "",
    describe = "",
    confirm = true,
    noConfirm = false,
    likeObj = false,
    moduleCookHeroSelectObj = false,
    cellCookRecipes = {
      moduleName = "pages/Cook/cellCookRecipes"
    },
    propItem = {
      moduleName = "modulePages/cellIcon"
    },
    moduleNumSelect = {
      moduleName = "pages/Cook/moduleNumSelect"
    },
    moduleCookHeroSelect = {
      moduleName = "pages/Cook/moduleCookHeroSelect"
    },
    filtrateName = L_WordsTpl:getValue("notice_pageCook_01"),
    filtrateIcon = "UI/Atlas/Common/tex_common_icon_fyqb",
    filtratePage = false,
    filtrateItemList = {
      moduleName = "pages/Cook/cookFiltrateItem"
    },
    cook = true,
    currentFoodNum = "",
    iconAngle = C_Vector3(0, 0, 90)
  }
end

function this.methods()
  return {
    onClick_confirm = function(self)
      local function func(data)
        local tempData = {
          cook_id = data.id,
          
          cook_count = data.count
        }
        L_CookStore:rsp_cookRequest(tempData, function()
          self:cookNotes()
          self:cookInfo()
        end)
      end
      
      if L_CookStore:getProficiency(self.curCookId) >= foodCookTpl:getProficiency(foodCookTpl:getTplById(self.curCookId)) then
        self.modules.moduleNumSelect:toShow()
        local data = {
          maxValue = self.maxValue,
          cookId = self.curCookId,
          material = self.material,
          closeCurModule = function()
            self.modules.moduleNumSelect:toHide()
          end,
          confirm = function(data)
            func(data)
          end
        }
        self.modules.moduleNumSelect:initModule(data)
      else
        local data = {
          id = self.curCookId,
          count = 1
        }
        func(data)
      end
    end,
    onToggle_like = function(self, value)
      self.filtrate = value
      self:cookNotes()
    end,
    onClick_like = function(self)
      local data = {
        cook_ids = {
          self.curCookId
        },
        like = not self.bind.likeObj
      }
      L_CookStore:rsp_cookLike(data)
      self.bind.likeObj = not self.bind.likeObj
    end,
    onClick_selectHero = function(self)
      self.bind.moduleCookHeroSelectObj = true
    end,
    onClick_openFiltrate = function(self)
      self.bind.filtratePage = not self.bind.filtratePage
      self.bind.iconAngle = self.bind.filtratePage == true and C_Vector3(0, 0, -90) or C_Vector3(0, 0, 90)
    end,
    onToggle_like_sort = function(self, value)
      self.sort = value
      self:cookNotes()
    end,
    cellCookRecipes = {
      curRecipes = function(self, id)
        for i = 1, #self.bind.cellCookRecipes do
          if self.bind.cellCookRecipes:getValue(i, "id") == id then
            self.bind.cellCookRecipes:change(i, {choice = true})
          else
            self.bind.cellCookRecipes:change(i, {choice = false})
          end
        end
        self.curCookId = id
        self:cookInfo()
      end
    },
    filtrateItemList = {
      cookFiltrate = function(self, bind)
        self.bind.filtrateName = bind.name
        self.bind.filtrateIcon = bind.icon
        self.curType = bind.id
        self.bind.filtratePage = false
        self.bind.iconAngle = C_Vector3(0, 0, 90)
        self:cookNotes()
      end
    }
  }
end

function this:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.cook)
  if result then
    result = #L_CookStore:getAllCookRecipes() > 0
    if not result then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pageCook_07"))
    end
  end
  callback(result)
end

function this:created(obj, config)
  this.super.created(self, obj, config)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.curCookId = nil
  self.filtrate = false
  self.curType = 0
  self.sort = false
  self:moduleCookHero()
  self:heroSet(L_CookStore:getCookHero())
  self:moduleFiltrate()
  self:cookNotes()
  self:cookInfo()
end

function this:close(options)
  this.super.close(self, options)
  if self.photoEntity then
    self.photoEntity:dispose()
    self.photoEntity = nil
  end
end

function this:show()
end

function this:heroSet(heroId)
  if heroId == 0 then
    heroId = L_HeroStore:getDefaultHeroGuid()
  end
  local hero = L_HeroStore:getHero(heroId)
  local item_hero = L_ItemManager:parseHeroItem(L_HeroStore:getHeroConfigId(hero))
  local tempName = item_hero.name
  if heroId == L_HeroStore:getDefaultHeroGuid() then
    tempName = L_PlayerStore:getPlayerName()
  end
  self.bind.heroName = tempName
  if heroId == L_HeroStore:getDefaultHeroGuid() then
    if self.photoEntity then
      self.photoEntity:bindGameObject(self.bindComponents.headIcon.gameObject)
    else
      self.photoEntity = L_PhotoManager:bindPhotoEntity(self.bindComponents.headIcon.gameObject, L_PlayerStore:getPlayerModHeadImgName())
    end
  else
    self.bind.headIcon = item_hero.icon
  end
  self.bind.lifeSkill = item_hero.lifeSkill
end

function this:cookNotes()
  self.bind.cellCookRecipes:clear()
  self.cookRecipes = self:cookRecipesFiltrate()
  local tempData = {}
  for i = 1, #self.cookRecipes do
    local foodCookId = foodCookTpl:getNormal(foodCookTpl:getTplById(self.cookRecipes[i].id))[1][2]
    local info = L_ItemManager:parseCommonItem(foodCookId)
    local tpl = foodCookTpl:getTplById(self.cookRecipes[i].id)
    local quality = foodCookTpl:getRarity(tpl)
    local foodId = foodCookTpl:getValueIndex(tpl)[1]
    local type = foodTpl:getFoodType(foodTpl:getTplById(foodId))
    if self.curType == 0 or self.curType == type then
      table.insert(tempData, {
        id = self.cookRecipes[i].id,
        count = self.cookRecipes[i].count,
        name = commonItemTpl:getName(commonItemTpl:getTplById(foodCookId)),
        icon = info.icon,
        bg = string.format("Page/Cook/tex_cooking_bg_pz_%d", quality),
        like = self.cookRecipes[i].like,
        choice = false,
        type = foodTypeTpl:getTypeIcon(foodTypeTpl:getTplById(type))
      })
    end
  end
  self.bind.cellCookRecipes:insert_array(tempData)
  if self.curCookId then
    for i = 1, #self.bind.cellCookRecipes do
      if self.bind.cellCookRecipes:getValue(i, "id") == self.curCookId then
        self.bind.cellCookRecipes:change(i, {choice = true})
        break
      end
    end
  else
    self.curCookId = self.bind.cellCookRecipes:getValue(1, "id")
    self.bind.cellCookRecipes:change(1, {choice = true})
  end
  if self.filtrate then
    self.bind.foodBg = "Page/Cook/tex_cooking_bg_03_s"
  else
    self.bind.foodBg = "Page/Cook/tex_cooking_bg_02_s"
  end
  self.bind.recipeNum = L_WordsTpl:getValue("notice_pageCook_05", {
    [0] = #L_CookStore:getAllCookRecipes()
  })
end

function this:cookRecipesFiltrate()
  local tempData = {}
  if self.filtrate then
    for i, v in pairs(L_CookStore:getAllCookRecipes()) do
      if v.like then
        table.insert(tempData, v)
      end
    end
  else
    tempData = L_CookStore:getAllCookRecipes()
  end
  table.sort(tempData, function(a, b)
    if self.sort then
      return a.id > b.id
    else
      return a.id < b.id
    end
  end)
  return tempData
end

function this:cookInfo()
  self.maxValue = math.huge
  self.material = nil
  if not self.curCookId then
    return
  end
  L_ReddotManager:clearNew(L_ReddotManager.DotDef.CookNew, self.curCookId)
  local foodCookId = foodCookTpl:getNormal(foodCookTpl:getTplById(self.curCookId))[1][2]
  local itemFood = commonItemTpl:getTplById(foodCookId)
  local tpl = foodCookTpl:getTplById(self.curCookId)
  local foodId = foodCookTpl:getValueIndex(tpl)[1]
  local type = foodTpl:getFoodType(foodTpl:getTplById(foodId))
  self.bind.name = commonItemTpl:getName(itemFood)
  self.bind.icon = commonItemTpl:getIcon(itemFood)
  self.bind.type = foodTypeTpl:getTypeIcon(foodTypeTpl:getTplById(type))
  self.bind.currentFoodNum = L_WordsTpl:getValue("notice_pageCook_04") .. C_BagMgr:getItemNumByItemId(foodCookId)
  local quality = foodCookTpl:getRarity(tpl)
  self.bind.titleIcon = "Page/Cook/tex_cooking_bg_bt_" .. quality
  self.bind.likeObj = L_CookStore:getLike(self.curCookId)
  if L_CookStore:getProficiency(self.curCookId) < foodCookTpl:getProficiency(foodCookTpl:getTplById(self.curCookId)) then
    self.bind.count = L_WordsTpl:getValue("notice_pageCook_03", {
      [0] = L_CookStore:getProficiency(self.curCookId),
      [1] = foodCookTpl:getProficiency(foodCookTpl:getTplById(self.curCookId))
    })
    self.bind.proficiency_1 = C_LuaUtility.ParseHtmlStringColor("#4F525D")
    self.bind.proficiency_2 = C_LuaUtility.ParseHtmlStringColor("#4F525D")
  else
    self.bind.count = L_WordsTpl:getValue("notice_pageCook_02", {
      [0] = foodCookTpl:getProficiency(foodCookTpl:getTplById(self.curCookId)),
      [1] = foodCookTpl:getProficiency(foodCookTpl:getTplById(self.curCookId))
    })
    self.bind.proficiency_1 = C_LuaUtility.ParseHtmlStringColor("#3266B4")
    self.bind.proficiency_2 = C_LuaUtility.ParseHtmlStringColor("#3266B4")
  end
  self.bind.func = foodTpl:getFoodDescByFoodCook(self.curCookId)
  self.bind.describe = commonItemTpl:getSpecialDesc(itemFood)
  self.bind.propItem:clear()
  local itemList = foodCookTpl:getMaterial(foodCookTpl:getTplById(self.curCookId))
  local data = {}
  self.bind.confirm = true
  self.bind.noConfirm = false
  self.material = itemList
  for i = 1, #itemList do
    local item = L_ItemManager:parseCommonItem(itemList[i][2])
    local cur_num = ""
    if itemList[i][3] > item.num then
      cur_num = L_GameUtil.fillColor(item.num, L_Const.colorHtml.red001)
      self.bind.confirm = false
      self.bind.noConfirm = true
    else
      if math.floor(item.num / itemList[i][3]) < self.maxValue then
        self.maxValue = math.floor(item.num / itemList[i][3])
      end
      cur_num = tostring(item.num)
    end
    table.insert(data, {
      itemNumTxt = cur_num .. "/" .. tostring(itemList[i][3]),
      itemType = L_Const.resType.commonItem,
      itemId = item.config.id
    })
  end
  self.bind.propItem:insert_array(data)
end

function this:moduleCookHero()
  local data = {
    close = function(heroId)
      self.bind.moduleCookHeroSelectObj = false
    end,
    confirm = function(heroId)
      self.bind.moduleCookHeroSelectObj = false
      if heroId ~= L_CookStore:getCookHero() then
        L_CookStore:rsp_cookSetHero({u32 = heroId}, function()
        end)
        self:heroSet(heroId)
      end
    end
  }
  self.modules.moduleCookHeroSelect:initModule(data)
end

function this:moduleFiltrate()
  local data = foodTypeTpl:getData()
  self.bind.filtrateItemList:clear()
  local temp = {}
  table.insert(temp, {
    name = L_WordsTpl:getValue("notice_pageCook_01"),
    icon = "UI/Atlas/Common/tex_common_icon_fyqb",
    id = 0
  })
  for i = 1, #data - 1 do
    table.insert(temp, {
      name = foodTypeTpl:getTypeName(data[i]),
      icon = foodTypeTpl:getButtonIcon(data[i]),
      id = foodTypeTpl:getId(data[i]),
      show_line = i ~= #data - 1 and true or false
    })
  end
  self.bind.filtrateItemList:insert_array(temp)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.filterTrans)
end

return this

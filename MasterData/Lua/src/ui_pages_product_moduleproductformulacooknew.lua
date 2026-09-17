local this = class("moduleProductFormulaCookNew", G_UIModuleBase)
local _productsTpl = L_GameTpl:getProductsTpl()
local _foodTpl = L_GameTpl:getFoodTpl()
local _foodMaterialTpl = L_GameTpl:getFoodMaterialGroupTpl()
local _foodGroupTpl = L_GameTpl:getFoodGroupTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _productsMultiQualityTpl = L_GameTpl:getProductsMultiQualityTpl()

function this.bind()
  return {
    txt_envName = "",
    txt_name = "",
    img_quality = "",
    img_icon = "",
    img_iconFilter = "",
    list_star = {},
    list_materials = {
      moduleName = "pages/product/cellProductMaterial"
    },
    active_heroIcon = false
  }
end

function this.methods()
  return {}
end

function this:open()
  self:refreshView()
  
  function self._onBagNumChange()
    if not self._foodGroup then
      return
    end
    self:initCookProduct()
  end
  
  self._onBagNumChangeHandle = handler(self, self._onBagNumChange)
  C_BagEvent.instance:Listen(C_EBagEvent.BagChange, self._onBagNumChangeHandle)
end

function this:close()
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self._onBagNumChangeHandle)
end

function this:setFoodGroup(groupId)
  if self._foodGroup == groupId then
    return
  end
  printf("设置食物组" .. groupId)
  self._foodGroup = groupId
  self._isFoodAutoReverse = nil
  local groupTpl = _foodGroupTpl:getTplById(groupId)
  self.bind.petIconActive = _foodGroupTpl:getIsNeedPet(groupTpl)
  self._selectNum = 1
  self:refreshAutoSelect()
end

function this:initCookProduct()
  self.productsMultiQualityTpl = _productsMultiQualityTpl:getCanDoTpl(self._foodGroup, self._curSelectRars)
  self.productId = _productsMultiQualityTpl:getProductIdByConfigId(self.productsMultiQualityTpl.id)
  self.parent:onChangeMaterial(self.productId)
end

function this:getMaxCanDo()
  return _productsMultiQualityTpl:getCanDoMaxNum(self.productsMultiQualityTpl.id, self._curSelectRars)
end

function this:getSelectFoodInfo()
  return self.productsMultiQualityTpl, self._curSelectRars
end

function this:setSelectNum(num)
  self._selectNum = num
  self:refreshView()
end

function this:refreshView()
  if not self.isBind or not self.productId then
    return
  end
  local id = self.productId
  local tpl = _productsTpl:getTplById(id)
  local reward = L_DataUtil.parseRewardConfigItem(_productsTpl:getRewardId(tpl)[1])
  local item = L_ItemTplManager:getItemConfig(reward.itemType, reward.itemId)
  self:refreshCookInfo(reward.itemType, reward.itemId, {
    itemNumTxt = item.name
  })
  self:refreshMaterial()
end

function this:refreshCookInfo(itemType, itemId, params)
  local conf = L_ItemTplManager:getItemConfig(itemType, itemId)
  self.bind.txt_envName = L_WordsTpl:getValue("ui_moduleProductFormulaCookNew")
  local pattern = string.match(conf.name, " %a+.%d+")
  if pattern then
    self.bind.txt_name = string.gsub(conf.name, pattern, "")
  else
    self.bind.txt_name = conf.name
  end
  local commonItemTpl = _commonItemTpl:getTplById(itemId)
  self.bind.img_iconFilter = commonItemTpl and _commonItemTpl:getFilterIcon(commonItemTpl) or ""
  self.bind.img_icon = conf.icon
  self.bind.img_quality = string.format("UI/Atlas/BSCommon/tex_homecommontip_bg_quality_%s.png", tostring(conf.quality))
  local starNum = L_ItemTplManager:getItemShowStarNum(itemType, itemId)
  self:_setStars(starNum)
end

function this:_setStars(num)
  if not self.isBind then
    return
  end
  local stars = {}
  for i = 1, num do
    table.insert(stars, {})
  end
  self.bind.list_star:clear()
  self.bind.list_star:insert_array(stars)
end

function this:refreshMaterial()
  if not self.productsMultiQualityTpl then
    return
  end
  local tmp = L_DataUtil.getEmptyModuleDatas(4)
  local materials = _foodTpl:getNeedMaterial(self.productsMultiQualityTpl)
  for i, material in ipairs(materials) do
    local itemId = _foodMaterialTpl:getItemId(material[1], self._curSelectRars[i])
    local item_tmp = L_ItemTplManager:getCommonItem(itemId)
    local itemIds = _foodMaterialTpl:getGroupItemIds(material[1])
    tmp[i] = {
      hadNum = C_BagMgr:getItemNumByItemId(itemId),
      needNum = material[2] * self._selectNum,
      color = item_tmp.quality,
      itemType = L_Const.resType.commonItem,
      itemId = itemId,
      changeCallback = 1 < #itemIds and function()
        L_UI:open("pageCookSelectMaterial", {
          groupId = material[1],
          callback = function(selectIndex)
            self._curSelectRars[i] = selectIndex
            self:initCookProduct()
          end,
          select = self._curSelectRars[i]
        })
      end or nil
    }
  end
  self.bind.list_materials:clear()
  self.bind.list_materials:insert_array(tmp)
end

function this:checkItemSatisfy()
  for _, module in ipairs(self.modules.list_materials) do
    if not module:isSatisfy() then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_product_lack_material"))
      return false
    end
  end
  return true
end

function this:refreshAutoSelect()
  self._curSelectRars = {
    0,
    0,
    0,
    0
  }
  if not math.isEmpty(self._foodGroup) then
    local foodIdList = _productsMultiQualityTpl:getItemIdListByFoodGroupId(self._foodGroup)
    local foodId = foodIdList[1]
    local materials = _productsMultiQualityTpl:getNeedMaterialByConfigId(foodId)
    for x = 1, 4 do
      local material = materials[x]
      if material then
        local materialGroupId = material[1]
        local needNum = material[2]
        local needRarity = material[3]
        local itemIds = _foodMaterialTpl:getGroupItemIds(materialGroupId)
        self._curSelectRars[x] = material[3]
        if self._isFoodAutoReverse then
          for i = 5, 1, -1 do
            if i >= needRarity and itemIds[i] and needNum < C_BagMgr:getItemNumByItemId(itemIds[i]) then
              self._curSelectRars[x] = i
              break
            end
          end
        else
          for i = 1, 5 do
            if i >= needRarity and itemIds[i] and needNum < C_BagMgr:getItemNumByItemId(itemIds[i]) then
              self._curSelectRars[x] = i
              break
            end
          end
        end
      end
    end
  end
  printf("选择结果", self._curSelectRars)
  self:initCookProduct()
end

function this:onClickFoodAutoSelect()
  self._isFoodAutoReverse = not self._isFoodAutoReverse
  self:refreshAutoSelect()
end

function this:isFoodAutoReverse()
  return self._isFoodAutoReverse
end

return this

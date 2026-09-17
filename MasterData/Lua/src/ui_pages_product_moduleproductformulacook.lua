local this = class("moduleProductFormulaNormal", G_UIModuleBase)
local _productsTpl = L_GameTpl:getProductsTpl()
local _foodTpl = L_GameTpl:getFoodTpl()
local _foodMaterialTpl = L_GameTpl:getFoodMaterialGroupTpl()
local _foodGroupTpl = L_GameTpl:getFoodGroupTpl()

function this.bind()
  return {
    module_targetItem = L_Const.ModuleInfo.CellIconBag,
    active_needPet = false,
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
  self._foodGroup = groupId
  self._isFoodAutoReverse = nil
  local groupTpl = _foodGroupTpl:getTplById(groupId)
  self.bind.petIconActive = _foodGroupTpl:getIsNeedPet(groupTpl)
  self._selectNum = 1
  self._curSelectRars = {
    0,
    0,
    0,
    0
  }
  local foodList = _foodTpl:getTplsByGroup(groupId)
  local foodTpl = foodList[1]
  local materials = _foodTpl:getNeedMaterial(foodTpl)
  for i = 1, 4 do
    local material = materials[i]
    if material then
      self._curSelectRars[i] = material[3]
    end
  end
  self:initCookProduct()
end

function this:initCookProduct()
  self._targetFoodTpl = _foodTpl:getCanDoTpl(self._foodGroup, self._curSelectRars)
  self._productId = _foodTpl:getProductId(self._targetFoodTpl)
  self.parent:onChangeMaterial(self._productId)
end

function this:getMaxCanDo()
  return _foodTpl:getCanDoMaxNum(_foodTpl:getId(self._targetFoodTpl), self._curSelectRars)
end

function this:getSelectFoodInfo()
  return self._targetFoodTpl, self._curSelectRars
end

function this:setSelectNum(num)
  self._selectNum = num
  self:refreshView()
end

function this:refreshView()
  if not self.isBind or not self._productId then
    return
  end
  local id = self._productId
  local tpl = _productsTpl:getTplById(id)
  local reward = L_DataUtil.parseRewardConfigItem(_productsTpl:getRewardId(tpl)[1])
  local item = L_ItemTplManager:getItemConfig(reward.itemType, reward.itemId)
  self.modules.module_targetItem:setGeneralContent(reward.itemType, reward.itemId, {
    itemNumTxt = item.name
  })
  self:refreshMaterial()
end

function this:refreshMaterial()
  if not self._targetFoodTpl then
    return
  end
  local tmp = L_DataUtil.getEmptyModuleDatas(4)
  local materials = _foodTpl:getNeedMaterial(self._targetFoodTpl)
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

function this:onClickFoodAutoSelect()
  self._curSelectRars = {
    0,
    0,
    0,
    0
  }
  if not math.isEmpty(self._foodGroup) then
    local foodList = _foodTpl:getTplsByGroup(self._foodGroup)
    local foodTpl = foodList[1]
    local materials = _foodTpl:getNeedMaterial(foodTpl)
    for x = 1, 4 do
      local material = materials[x]
      if material then
        local itemIds = _foodMaterialTpl:getGroupItemIds(material[1])
        local needNum = material[2]
        self._curSelectRars[x] = material[3]
        if self._isFoodAutoReverse then
          for i = 5, 1, -1 do
            if i >= material[3] and itemIds[i] and needNum < C_BagMgr:getItemNumByItemId(itemIds[i]) then
              self._curSelectRars[x] = i
              break
            end
          end
        else
          for i = 1, 5 do
            if i >= material[3] and itemIds[i] and needNum < C_BagMgr:getItemNumByItemId(itemIds[i]) then
              self._curSelectRars[x] = i
              break
            end
          end
        end
      end
    end
  end
  printf("选择结果", self._curSelectRars)
  self._isFoodAutoReverse = not self._isFoodAutoReverse
  self:initCookProduct()
end

function this:isFoodAutoReverse()
  return self._isFoodAutoReverse
end

return this

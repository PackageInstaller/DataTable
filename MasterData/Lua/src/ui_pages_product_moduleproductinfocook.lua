local this = class("moduleProductInfoCook", G_UIModuleBase)
local _productsTpl = L_GameTpl:getProductsTpl()
local _foodTpl = L_GameTpl:getFoodTpl()
local _foodMaterialTpl = L_GameTpl:getFoodMaterialGroupTpl()
local _foodGroupTpl = L_GameTpl:getFoodGroupTpl()

function this.bind()
  return {
    module_productFormulaCookNew = {
      moduleName = "pages/product/moduleProductFormulaCookNew"
    },
    txt_itemDesc = "",
    txt_longDesc = "",
    active_moduleNum = false,
    module_num = L_Const.ModuleInfo.SelectNum,
    txt_time = "",
    txt_foodAutoSelect = L_WordsTpl:getValue("ui_moduleProduct_01")
  }
end

function this.methods()
  return {
    onClick_start = function(self)
      self:onClickStart()
    end,
    onClick_foodAutoSelect = function(self)
      self.modules.module_productFormulaCookNew:onClickFoodAutoSelect()
      self:refreshAutoBtn()
    end
  }
end

function this:refreshAutoBtn()
  self.bind.txt_foodAutoSelect = self.modules.module_productFormulaCookNew:isFoodAutoReverse() and L_WordsTpl:getValue("ui_moduleProduct_01") or L_WordsTpl:getValue("ui_moduleProduct_02")
end

function this:open()
  function self._refreshSelectNum()
    self:initSelectNum()
  end
  
  L_ProductStore:listenCallFunc(L_ProductStore.event.refreshHomeProduct, self._refreshSelectNum)
end

function this:close()
  L_ProductStore:unListenCallFunc(L_ProductStore.event.refreshHomeProduct, self._refreshSelectNum)
end

function this:setFoodGroup(guid, group)
  self._guid = guid
  self._group = group
  self.modules.module_productFormulaCookNew:setFoodGroup(group)
  self:refreshAutoBtn()
end

function this:onChangeMaterial(id)
  self._productId = id
  local tpl = _productsTpl:getTplById(id)
  local reward = L_DataUtil.parseRewardConfigItem(_productsTpl:getRewardId(tpl)[1])
  local item = L_ItemTplManager:getItemConfig(reward.itemType, reward.itemId)
  local itemTpl = L_GameTpl:getCommonItemTpl():getTplById(reward.itemId)
  self.bind.active_buildTag = false
  self.bind.txt_itemDesc = item.desc
  self.bind.txt_longDesc = L_GameTpl:getCommonItemTpl():getSpecialDesc(itemTpl)
  self:initSelectNum()
end

function this:initSelectNum()
  if not self._guid then
    return
  end
  self._selectNum = self._selectNum or 1
  local tpl = _productsTpl:getTplById(self._productId)
  local limit = _productsTpl:getNumberLimit(tpl)
  self.bind.active_moduleNum = 1 < limit
  self:refreshCostInfo()
  if self.bind.active_moduleNum then
    local maxNum = self.modules.module_productFormulaCookNew:getMaxCanDo()
    if self._lastNumProductId == self._productId and self._lastNumMax == maxNum then
      return
    end
    self._lastNumProductId = self._productId
    self._lastNumMax = maxNum
    
    local function func(num)
      self._selectNum = num
      self:refreshCostInfo()
    end
    
    self.modules.module_num:initModule(func, math.max(maxNum, 1), 1, math.min(maxNum, self._selectNum))
  end
end

function this:refreshCostInfo()
  self.modules.module_productFormulaCookNew:setSelectNum(self._selectNum)
  local onceTime = L_ProductManager:getProduceOnceTime(self._guid, self._productId)
  self.bind.txt_time = string.format("%s", L_TimeUtil.secondToLangString(onceTime * self._selectNum))
end

function this:checkProduct()
  if C_HomeUtil.CheckBuildCanProduct(self._guid, self._productId) then
    return self.modules.module_productFormulaCookNew:checkItemSatisfy()
  end
end

function this:onClickStart()
  if self:checkProduct() then
    self:checkDoCook()
  end
end

function this:checkDoCook()
  local groupTpl = _foodGroupTpl:getTplById(self._group)
  local serverData = L_HomeStore:getHomeBuildingByGuid(self._guid)
  if _foodGroupTpl:getIsNeedPet(groupTpl) and math.isEmpty(serverData.station_pet_guid) then
    L_FlyMsgManager:showNormalMsgByKey("notice_pageHomeCook_01")
    return
  end
  local targetTpl, selectRars = self.modules.module_productFormulaCookNew:getSelectFoodInfo()
  local guid = self._guid
  local cookId = _foodTpl:getId(targetTpl)
  local count = self._selectNum
  local materials = _foodTpl:getNeedMaterial(targetTpl)
  local items = {}
  for i = 1, 4 do
    local material = materials[i]
    if material then
      local itemId = _foodMaterialTpl:getItemId(material[1], selectRars[i])
      local oneNum = material[2]
      table.insert(items, {item_id = itemId, item_num = oneNum})
    end
  end
  L_CookStore:req_cook(guid, cookId, count, items)
end

return this

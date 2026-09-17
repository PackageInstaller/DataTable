local module = class("cellPetExpFruitItem", G_UIModuleBase)
module.importPartialClass(module, require("ui.pages.pet.itemLongPressHandler"))
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _petLevelTpl = L_GameTpl:getPetLevelTpl()
local AttributeBgPath = {}

function module.bind()
  return {
    text_attrFruitName = "",
    text_attrFruitNum = "",
    text_attrFruitDesc = "",
    img_fruitBg = "",
    img_fruitIcon = "",
    list_star = {},
    modulePetAttrFruitSelectNum = {
      moduleName = "pages/pet/modulePetAttrFruitSelectNum"
    },
    active_img_select = false,
    active_img_mask = false,
    active_img_maskBg = true,
    txt_maskState = "",
    active_longPressProgress = false,
    active_longPressProgressMobile = false,
    active_longPressProgressPc = false,
    img_longPressProgressMobile = 0,
    img_longPressProgressPc = 0
  }
end

function module.methods()
  return {
    onDown_btnImgSelect = function(self)
      self:onBtnDown()
    end,
    onUp_btnImgSelect = function(self)
      self:onBtnUp()
    end
  }
end

function module:onBtnClick()
  if self.itemNum <= 0 then
    L_ItemTplManager:showInfoTip(L_Const.resType.commonItem, self.itemId)
    return
  end
  if not self.bind.active_img_select then
    if not self:checkIfCanAddSelectNum(true) then
      return
    end
    self:setSelectNum(1)
    self.onSelectChangeNumChangeCbk()
    self.bind.active_img_select = true
    return
  end
  if 0 < self:getSelectNum() then
    self.modules.modulePetAttrFruitSelectNum:onBtnAdd()
    return
  end
  self.bind.active_img_select = false
end

function module:refresh()
  if not self.bind.itemId then
    return
  end
  self.itemId = self.bind.itemId
  self.itemNum = self.bind.itemNum
  self.itemType = self.bind.itemType
  self.onSelectChangeNumChangeCbk = handler(self, self.onSelectChangeNumChange)
  self:refreshUI()
end

function module:changMask(isShow, content)
  self.bind.active_img_mask = isShow
  if isShow then
    self.bind.txt_maskState = content
  else
    self:refreshFruitData()
    if self.itemNum > 0 then
      self.bind.txt_maskState = string.format("x%d", self.itemNum)
    else
      self.bind.txt_maskState = ""
    end
  end
end

function module:refreshFruitData()
  local commonItemTpl = _commonItemTpl:getTplById(self.itemId)
  self.bind.text_attrFruitName = _commonItemTpl:getName(commonItemTpl)
  self.bind.text_attrFruitNum = ""
  self.bind.text_attrFruitDesc = _commonItemTpl:getDesc(commonItemTpl)
  self.bind.img_fruitIcon = _commonItemTpl:getIcon(commonItemTpl)
  local rarity = _commonItemTpl:getRarity(commonItemTpl)
  self.bind.img_fruitBg = string.format("UI/Atlas/BSCommon/tex_homecommontip_bg_quality_%d.png", rarity)
  local starNum = L_ItemTplManager:getItemShowStarNum(self.itemType, self.itemId)
  local startList = {}
  for i = 1, starNum do
    table.insert(startList, {})
  end
  self.bind.list_star:clear()
  self.bind.list_star:insert_array(startList)
end

function module:refreshMaskState()
  if self.itemNum <= 0 then
    self:refreshFruitData()
    self:changMask(true, L_WordsTpl:getValue("ui_cellPetExpFruitItem"))
    return
  end
  if self.parent:hasAnyExpFruitSelected() then
    self:changMask(false)
    return
  end
  if 0 >= self:getSelectNum() and not self:checkIfCanAddSelectNum(false) then
    self:refreshFruitData()
    self:changMask(true, L_WordsTpl:getValue("ui_kibo_fruit_can_not_feed"))
  else
    self:changMask(false)
  end
end

function module:checkIfCanAddSelectNum(isShowInfo)
  local canAdd = self.parent:checkCanAddExpItem(isShowInfo)
  return canAdd
end

function module:refreshUI()
  local modulePetAttrFruitSelectNum = self.modules.modulePetAttrFruitSelectNum
  modulePetAttrFruitSelectNum:initModule({
    controlItem = self,
    onSelectChangeNumChangeCbk = self.onSelectChangeNumChangeCbk
  })
  
  function modulePetAttrFruitSelectNum.setSelectNumAndDoSelectNumChangeCallback(selectNumModule, num)
    if num == 0 and selectNumModule:getSelectNum() > 1 then
      num = selectNumModule:getSelectNum() - 1
    end
    selectNumModule:setSelectNum(num)
    selectNumModule:onSelectChangeNumChange()
  end
  
  self:refreshMaskState()
end

function module:getItemId()
  return self.itemId
end

function module:getItemNum()
  return self.itemNum
end

function module:getSelectNum()
  local modulePetAttrFruitSelectNum = self.modules and self.modules.modulePetAttrFruitSelectNum
  if not modulePetAttrFruitSelectNum then
    return 0
  end
  local num = modulePetAttrFruitSelectNum:getSelectNum()
  return num and num or 0
end

function module:setSelectNum(num)
  local modulePetAttrFruitSelectNum = self.modules.modulePetAttrFruitSelectNum
  modulePetAttrFruitSelectNum:setSelectNum(num)
end

function module:setSelectState(bSelect)
  self.bind.active_img_select = bSelect
end

function module:resetSelectNum()
  if self.bind.itemId then
    local modulePetAttrFruitSelectNum = self.modules.modulePetAttrFruitSelectNum
    modulePetAttrFruitSelectNum:resetSelectNum()
  end
end

function module:getMaxNumCurCanSelect()
  local curSelectInfo = self.parent:getSelectedExpInfo()
  local tempExpAll = 0
  local selectedNum = 0
  local leftNum = self.itemNum
  local expAddUnit = _commonItemTpl:getUseFunction(_commonItemTpl:getTplById(self.itemId))[1]
  for _, data in ipairs(curSelectInfo) do
    local exp = _commonItemTpl:getUseFunction(_commonItemTpl:getTplById(data.item_id))[1]
    tempExpAll = tempExpAll + data.item_num * exp
    if data.item_id == self.itemId then
      leftNum = self.itemNum - data.item_num
      selectedNum = data.item_num
    end
  end
  local pet = L_PetStore:getPetItem(self.parent.petGuid)
  local tempExp = tempExpAll + pet.exp
  local expNeedToMax = 0
  local maxLv = L_PetStore:getPetMaxLevel(true)
  for i = pet.lv, maxLv - 1 do
    expNeedToMax = expNeedToMax + _petLevelTpl:getExp(_petLevelTpl:getTplById(i))
  end
  if tempExp >= expNeedToMax then
    return 0
  end
  local needNum = math.ceil((expNeedToMax - tempExp) / expAddUnit)
  local maxNumCurCanSelect = leftNum >= needNum and needNum or leftNum
  maxNumCurCanSelect = selectedNum + maxNumCurCanSelect
  return maxNumCurCanSelect
end

function module:onSelectChangeNumChange()
  if self:getSelectNum() <= 0 then
    self.bind.active_img_select = false
  end
  self.bind.onSelectChangeNumChangeCbk()
end

function module:onBtnDown()
  self:onBtnClick()
  self:beginLongPress(true, true)
end

function module:onBtnUp()
  self:endLongPress()
end

function module:close()
  self:endLongPress()
end

return module

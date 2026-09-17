local module = class("cellPetAttributeFruitItem", G_UIModuleBase)
module.importPartialClass(module, require("ui.pages.pet.itemLongPressHandler"))
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _petTalentUpgradeTpl = L_GameTpl:getPetTalentUpgradeTpl()
local _petFeedItemTpl = L_GameTpl:getPetFeedItemTpl()

function module:ctor(...)
  module.super.ctor(self, ...)
end

function module.bind()
  return {
    text_attrFruitName = "",
    text_attrFruitNum = "",
    text_attrFruitDesc = "",
    img_fruitBg = "",
    img_fruitIcon = "",
    list_star = {},
    img_attribute = "",
    modulePetAttrFruitSelectNum = {
      moduleName = "pages/pet/modulePetAttrFruitSelectNum"
    },
    active_img_select = false,
    active_img_mask = false,
    txt_maskState = "",
    active_longPressProgress = false,
    active_longPressProgressMobile = false,
    active_longPressProgressPc = false,
    img_longPressProgressMobile = 0,
    img_longPressProgressPc = 0,
    toggle_isEmpty = false
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
    self.bind.toggle_isEmpty = true
    return
  end
  self.bind.toggle_isEmpty = false
  self.itemId = self.bind.itemId
  self.itemNum = self.bind.itemNum
  self.itemType = self.bind.itemType
  self.onSelectChangeNumChangeCbk = handler(self, self.onSelectChangeNumChange)
  self:refreshUI()
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
  local petFeedItemTpl = _petFeedItemTpl:getTplById(self.itemId)
  self.bind.img_attribute = _petFeedItemTpl:getAttributeBg(petFeedItemTpl)
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
  elseif 0 >= self:getSelectNum() and not self:checkIfCanAddSelectNum(false) then
    self:refreshFruitData()
    self:changMask(true, L_WordsTpl:getValue("ui_kibo_fruit_can_not_feed"))
  else
    self:changMask(false)
  end
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

function module:checkIfCanAddSelectNum(isShowInfo)
  local canAdd = self.parent:checkIfCanAddSelectNumOfTargetFruitItem(self.itemId)
  if not canAdd and isShowInfo ~= false then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_potential_fruit_limit"))
  end
  return canAdd
end

function module:getMaxNumCurCanSelect()
  local addResultComprehensionExpList = self.parent:getAddResultComprehensionExpList()
  local allComprehensionMaxNeedExpList = _petTalentUpgradeTpl:getAllComprehensionMaxNeedExpList()
  local maxNumCurCanAdd = 0
  local itemId = self.itemId
  local petFeedItemTpl = _petFeedItemTpl:getTplById(itemId)
  local effectParamList = _petFeedItemTpl:getEffectParamList(petFeedItemTpl)
  for _, effectParam in pairs(effectParamList) do
    local attrEnumNum = effectParam[1]
    local addResultComprehensionExp = addResultComprehensionExpList[attrEnumNum]
    local maxNeedExpOfOneComprehension = allComprehensionMaxNeedExpList[attrEnumNum]
    local restNeedExpOfOneComprehension = maxNeedExpOfOneComprehension - addResultComprehensionExp
    local expAddNum = effectParam[2]
    local needAddNum = math.ceil(restNeedExpOfOneComprehension / expAddNum)
    maxNumCurCanAdd = maxNumCurCanAdd > needAddNum and maxNumCurCanAdd or needAddNum
  end
  local curSelectNum = self:getSelectNum()
  local maxNumCurCanSelect = curSelectNum + maxNumCurCanAdd <= self:getItemNum() and curSelectNum + maxNumCurCanAdd or self:getItemNum()
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

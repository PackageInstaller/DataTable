local module = class("cellPetGeneFruitItem", G_UIModuleBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
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
    go_none = false,
    go_content = true
  }
end

function module.methods()
  return {
    onclick_btnImgSelect = function(self)
      self:onBtnClick()
    end
  }
end

function module:onBtnClick()
  if not self.itemId then
    return
  end
  if self.itemNum <= 0 then
    L_ItemTplManager:showInfoTip(L_Const.resType.commonItem, self.itemId)
    return
  end
  if not self.bind.active_img_select then
    if not self:checkIfCanAddSelectNum() then
      return
    end
    self:setSelectNum(1)
    self:onSelectChangeNumChange()
    self.bind.active_img_select = true
    return
  end
  self:setSelectNum(0)
  self:onSelectChangeNumChange()
  self.bind.active_img_select = false
end

function module:refresh()
  if not self.bind.itemId then
    self.itemId = nil
    self.itemNum = 0
    self.bind.go_none = true
    self.bind.go_content = false
    return
  end
  self.bind.go_none = false
  self.bind.go_content = true
  self.itemId = self.bind.itemId
  self.itemNum = self.bind.itemNum
  self.itemType = self.bind.itemType
  self.cannotFeed = self.bind.cannotFeed == true
  self.selectNum = 0
  self:refreshUI()
end

function module:refreshUI()
  local modulePetAttrFruitSelectNum = self.modules.modulePetAttrFruitSelectNum
  modulePetAttrFruitSelectNum:initModule({
    controlItem = self,
    onSelectChangeNumChangeCbk = handler(self, self.onSelectChangeNumChange)
  })
  local cell = self
  
  function modulePetAttrFruitSelectNum.setSelectNumAndDoSelectNumChangeCallback(selectNumModule, num)
    cell:setSelectNum(num)
    selectNumModule:setSelectNum(cell:getSelectNum())
    cell:onSelectChangeNumChange()
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
  elseif self.cannotFeed then
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

function module:getCannotFeed()
  return self.cannotFeed
end

function module:getSelectNum()
  return self.selectNum or 0
end

function module:setSelectNum(num)
  if self.itemNum <= 0 then
    self.selectNum = 0
  else
    self.selectNum = 0 < num and 1 or 0
  end
  local modulePetAttrFruitSelectNum = self.modules and self.modules.modulePetAttrFruitSelectNum
  if modulePetAttrFruitSelectNum then
    modulePetAttrFruitSelectNum:setSelectNum(self.selectNum)
  end
end

function module:resetSelectNum()
  if self.bind.itemId then
    self:setSelectNum(0)
    self:setSelectState(false)
  end
end

function module:setSelectState(isSelect)
  if self.bind.itemId then
    self.bind.active_img_select = isSelect
  end
end

function module:checkIfCanAddSelectNum()
  local canAdd = not self.cannotFeed and self:getSelectNum() < self:getMaxNumCurCanSelect()
  if canAdd and self.parent and self.parent.checkIfCanSelectGeneFruitItem then
    canAdd = self.parent:checkIfCanSelectGeneFruitItem()
  end
  if not canAdd then
    if self.cannotFeed then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_kibo_fruit_can_not_feed"))
    elseif self:getSelectNum() >= self:getMaxNumCurCanSelect() then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_fruit_no_more_item"))
    end
  end
  return canAdd
end

function module:getMaxNumCurCanSelect()
  return math.min(self:getItemNum(), 1)
end

function module:onSelectChangeNumChange()
  if self:getSelectNum() <= 0 then
    self.bind.active_img_select = false
  end
  if self.bind.onSelectChangeNumChangeCbk then
    self.bind.onSelectChangeNumChangeCbk(self)
  end
end

function module:close()
end

return module

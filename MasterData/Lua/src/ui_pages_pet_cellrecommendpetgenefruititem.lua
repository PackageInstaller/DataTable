local module = class("cellRecommendPetGeneFruitItem", G_UIModuleBase)
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
    toggle_isEmpty = false,
    go_alreadyHave = false,
    go_selectLight = false
  }
end

function module.methods()
  return {
    onclick_btnImgSelect = function(self)
      self:onBtnClick()
    end,
    onclick_detail = function(self)
      self:onDetailBtnClick()
    end
  }
end

function module:onBtnClick()
  if not self.bind.active_img_select then
    if not self:checkIfCanAddSelectNum() then
      return
    end
    self:setSelectNum(1)
    self:onSelectChangeNumChange()
    self.bind.active_img_select = true
    self.bind.go_selectLight = true
    return
  end
  self:setSelectNum(0)
  self:onSelectChangeNumChange()
  self.bind.active_img_select = false
  self.bind.go_selectLight = false
end

function module:onDetailBtnClick()
  if self.itemId then
    L_ItemTplManager:showInfoTip(L_Const.resType.commonItem, self.itemId)
  end
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
  self.cannotFeed = self.bind.cannotFeed == true
  self.alreadyHave = self.bind.alreadyHave == true
  self.selectNum = self.bind.isSelected and 1 or 0
  self.bind.active_img_select = self.selectNum > 0
  self.bind.go_selectLight = self.selectNum > 0
  self:refreshUI()
end

function module:refreshUI()
  local commonItemTpl = _commonItemTpl:getTplById(self.itemId)
  self.bind.go_alreadyHave = self.alreadyHave == true
  self.bind.text_attrFruitName = _commonItemTpl:getName(commonItemTpl)
  local petFeedItemTpl = _petFeedItemTpl:getTplById(self.itemId)
  self.bind.img_attribute = _petFeedItemTpl:getAttributeBg(petFeedItemTpl)
  if self.itemNum > 0 then
    self.bind.text_attrFruitNum = string.format("x%d", self.itemNum)
  else
    self.bind.text_attrFruitNum = ""
  end
  if self.cannotFeed then
    self:changMask(true, L_WordsTpl:getValue("ui_kibo_fruit_can_not_feed"))
  else
    self:changMask(false)
  end
  self.bind.text_attrFruitDesc = _commonItemTpl:getDesc(commonItemTpl)
  self.bind.img_fruitIcon = _commonItemTpl:getIcon(commonItemTpl)
  local rarity = _commonItemTpl:getRarity(commonItemTpl)
  self.bind.img_fruitBg = string.format("UI/Atlas/BSCommon/tex_homecommontip_bg_quality_%d.png", rarity)
  rarity = rarity + 1
  local starNum = L_ItemTplManager:getItemShowStarNum(self.itemType, self.itemId)
  local startList = {}
  for i = 1, starNum do
    table.insert(startList, {})
  end
  self.bind.list_star:clear()
  self.bind.list_star:insert_array(startList)
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
  self.selectNum = 0 < num and 1 or 0
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
    self.bind.go_selectLight = isSelect
  end
end

function module:changMask(isShow, content)
  self.bind.active_img_mask = isShow
  if isShow then
    self.bind.txt_maskState = content
  end
end

function module:checkIfCanAddSelectNum()
  local canAdd = not self.cannotFeed and self:getSelectNum() < self:getMaxNumCurCanSelect()
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
  return 1
end

function module:onSelectChangeNumChange()
  if self:getSelectNum() <= 0 then
    self.bind.active_img_select = false
    self.bind.go_selectLight = false
  end
  if self.bind.onSelectChangeNumChangeCbk then
    self.bind.onSelectChangeNumChangeCbk(self)
  end
end

function module:close()
end

return module

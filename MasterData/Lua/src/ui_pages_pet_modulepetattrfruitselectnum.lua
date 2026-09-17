local module = class("modulePetAttrFruitSelectNum", G_UIModuleBase)

function module.bind()
  return {text_num = ""}
end

function module.methods()
  return {
    onClickClear = function(self)
      if self.controlItem == nil then
        return
      end
      self:setSelectNumAndDoSelectNumChangeCallback(0)
    end,
    onDownDecrease = function(self)
      self:onDownDecrease()
    end,
    onUpDecrease = function(self)
      self:onUpDecrease()
    end,
    onDownAdd = function(self)
      self:onDownAdd()
    end,
    onUpAdd = function(self)
      self:onUpAdd()
    end,
    onClickMax = function(self)
      if self.controlItem == nil then
        return
      end
      if self:checkIfCanAddSelectNum() then
        local maxNumCurCanSelect = self:getMaxNumCurCanSelect()
        self:setSelectNumAndDoSelectNumChangeCallback(maxNumCurCanSelect)
      end
    end
  }
end

function module:initModule(params)
  self.controlItem = params.controlItem
  self.onSelectChangeNumChangeCbk = params.onSelectChangeNumChangeCbk
  self.selectNum = 0
  self.maxNum = self.controlItem:getItemNum()
  self.bind.text_num = tostring(0)
end

function module:setSelectNumAndDoSelectNumChangeCallback(num)
  self:setSelectNum(num)
  self:onSelectChangeNumChange()
end

function module:setSelectNum(num)
  num = self:clampSelectNum(num)
  self.selectNum = num
  self.bind.text_num = tostring(num)
end

function module:clampSelectNum(inputNum)
  if inputNum > self.maxNum then
    return self.maxNum
  elseif inputNum < 0 then
    return 0
  else
    return inputNum
  end
end

function module:onSelectChangeNumChange()
  self.onSelectChangeNumChangeCbk()
end

function module:checkIfCanAddSelectNum()
  return self.controlItem:checkIfCanAddSelectNum()
end

function module:getMaxNumCurCanSelect()
  return self.controlItem:getMaxNumCurCanSelect()
end

function module:resetSelectNum()
  self:setSelectNum(0)
end

function module:getSelectNum()
  return self.selectNum
end

function module:onDownDecrease()
  self:onBtnDecrease()
  if self.controlItem.beginLongPress then
    self.controlItem:beginLongPress(false)
  end
end

function module:onUpDecrease()
  if self.controlItem.endLongPress then
    self.controlItem:endLongPress()
  end
end

function module:onDownAdd()
  self:onBtnAdd()
  if self.controlItem.beginLongPress then
    self.controlItem:beginLongPress(true)
  end
end

function module:onUpAdd()
  if self.controlItem.endLongPress then
    self.controlItem:endLongPress()
  end
end

function module:onBtnAdd()
  if self.controlItem == nil then
    return
  end
  if self.selectNum >= self.maxNum then
    L_FlyMsgManager:showNormalMsgByKey("notice_kibo_fruit_no_more_item")
    return
  end
  if self:checkIfCanAddSelectNum() then
    self:setSelectNumAndDoSelectNumChangeCallback(self.selectNum + 1)
  end
end

function module:onBtnDecrease()
  if self.controlItem == nil then
    return
  end
  self:setSelectNumAndDoSelectNumChangeCallback(self.selectNum - 1)
  if self.selectNum == 0 and self.controlItem.endLongPress then
    self.controlItem:endLongPress()
  end
end

return module

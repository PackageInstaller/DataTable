local this = class("cellAddItem", G_UIModuleBase)

function this.bind()
  return {
    addBtnActive = false,
    contentActive = false,
    cellIcon = L_Const.ModuleInfo.CellIconBag,
    activeSelect = false,
    activeSelectNum = false,
    activeSelectNumBg = false,
    textSelectNum = "",
    activeReduce = true,
    activeYellowReduce = false
  }
end

function this.methods()
  return {
    onClick_add = function(self)
      if self.bind.onAddClick then
        self.bind.onAddClick()
      end
    end,
    onClickReduce = function(self)
      self:setSelectNum(self._selectedNum - 1)
    end,
    onClickYellowReduce = function(self)
      if self.bind.onYellowReduce then
        self.bind.onYellowReduce(self.bind.guid)
      end
    end
  }
end

function this:refresh()
  self.bind.contentActive = not self.bind.addBtnActive
  if self.bind.contentActive then
    self._itemType = self.bind.itemType
    self._itemId = self.bind.itemId
    self.isSoulEssence = self.bind.itemType == L_Const.resType.soulEssence
    self._selectMode = self.bind.selectMode or self.bind.selectCallback ~= nil
    local _accessory = 0
    if self.bind.itemType == L_Const.resType.accessory then
      local itemData = C_AccessoryMgr:getAccessory(self.bind.guid)
      if itemData ~= nil then
        _accessory = C_AccessoryMgr:getAccessory(self.bind.guid).level
      end
    end
    local accessoryWearData = C_AccessoryMgr:GetAccessoryDataToLua(self.bind.guid)
    self.modules.cellIcon:setGeneralContent(self.bind.itemType, self.bind.itemId, {
      guid = self.bind.guid,
      level = _accessory,
      callback = function()
        self:clickCallback()
      end,
      accessoryWearData = accessoryWearData,
      isBasicItem = self.bind.isBasicItem
    })
    self.bind.SelectNumActive = self.bind.cellIconActive
    self._validateSelectFunc = self.bind.validateSelectFunc
    self._callback = self.bind.callback
    self._selectedNum = self.bind.selectNum or 0
    if self.bind.mutiSelect then
      self:updateSelectView(true)
    end
  end
end

function this:clickCallback()
  if self._selectMode then
    if not self.bind.mutiSelect then
      self:setSelectNum(1 - self._selectedNum)
    else
      self:setSelectNum(self._selectedNum + 1)
    end
  end
  if self._callback then
    self._callback(self)
  end
end

function this:playAnim(animName)
  self.bindComponents.animation:Play(animName)
end

function this:getAnimUpLength(animName)
  return self.bindComponents.animation:get_Item(animName).length
end

function this:setSelectState(state)
  self._selectedNum = state and 1 or 0
  self:updateSelectView()
end

function this:getSelectState()
  return self._selectedNum and self._selectedNum > 0
end

function this:setSelectNum(num, notCall)
  if self._validateSelectFunc and not self._validateSelectFunc(self._selectedNum, num) then
    return
  end
  self._selectedNum = num
  self:updateSelectView(notCall)
end

function this:updateSelectView(notCall)
  if not self.bind.mutiSelect then
    self.bind.activeSelectNum = false
    self._selectedNum = math.min(self._selectedNum, 1)
  else
    self.bind.activeSelectNum = true
    self._selectedNum = math.min(self._selectedNum, self.bind.itemNum or self._selectedNum)
  end
  if self.isSoulEssence then
    self.bind.activeSelect = true
    self.bind.activeSelectNum = false
    self.bind.activeSelectNumBg = false
    self.bind.text_num = ""
  else
    self.bind.activeSelect = self._selectedNum > 0
    self.bind.activeSelectNum = true
    self.bind.activeSelectNumBg = true
    self.bind.textSelectNum = tostring(self._selectedNum)
  end
  if self._selectCallback and not notCall then
    self._selectCallback(self)
  end
end

return this

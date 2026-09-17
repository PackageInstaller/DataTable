local this = class("cellSubmitItem", G_UIModuleBase)
local longPressTime = 0.4
local longPressTime2 = 2.4
local longPressInterval = L_GameConstTpl:getValue("ITEM_NUM_CHANGE_SPEED_01", true, 0.05)
local longPressInterval2 = L_GameConstTpl:getValue("ITEM_NUM_CHANGE_SPEED_02", true, 0.025)

function this.bind()
  return {
    activeEmpty = false,
    activeNumBg = false,
    txtNum = "",
    activeIcon = false,
    cellIcon = L_Const.ModuleInfo.CellIconBag,
    activeSelectNum = false,
    activeSelectNumBg = false,
    activeTxtSelectNum = false,
    txtSelectNum = "",
    activeMask = false,
    activeNeedIcon = false,
    sprNeedIcon = "",
    activeTypeIcon = false,
    sprTypeIcon = "",
    activeAdd = false,
    activeEmptyImg = false,
    activeImgBg = true,
    btn = true,
    content = true,
    activeBottom = true,
    activeOwner = false
  }
end

function this:open()
  if self.bind.isCell then
    self:refreshView()
  end
end

function this.methods()
  return {
    onClick = function(self)
      self:onSelfClick()
    end,
    onLongClick = function(self)
      if self.bind.showInfoTipsEntrance ~= nil and self.bind.showInfoTipsEntrance == L_Const.showInfoTipsEntranceType.longClick and self.bind.itemType and self.bind.itemId then
        local notShowAccess = self:GetSourceLuaPageOptions("failure_jump")
        L_ItemTplManager:showInfoTip(self.bind.itemType, self.bind.itemId, nil, nil, notShowAccess)
      end
    end,
    onLongPress = function(self)
      if self.bind.longPressCallback then
        self.bind.longPressCallback(self)
      end
    end,
    onClickRemove = function(self)
      self:onRemoveClick()
    end,
    onDown = function(self)
      self:beginLongPress(true)
    end,
    onUp = function(self)
      self:endLongPress()
    end,
    onDownRemove = function(self)
      self:beginLongPress(false)
    end,
    onUpRemove = function(self)
      self:endLongPress()
    end,
    OnSelect = function(self)
      self:onSelfSelect()
    end,
    OnDeSelect = function(self)
      self:onSelfDeSelect()
    end
  }
end

function this:beginLongPress(isAdd)
  if self.bind.pressWorking then
    self.isAdd = isAdd
    if not self.timer then
      self.timer = Timer.repeated(0, self.update, self)
    end
    self.curPressTime = 0
    self.curPressCount = 0
  end
end

function this:endLongPress()
  if self.bind.pressWorking and self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
end

function this:update()
  local deltaTime = C_Time.deltaTime
  self.curPressTime = self.curPressTime + deltaTime
  local pressCount = self:getPressCount()
  for _ = 1, pressCount - self.curPressCount do
    if self.isAdd then
      self:onSelfClick()
    elseif self:getSelectNum() > 0 then
      self:onRemoveClick()
    end
  end
  self.curPressCount = pressCount
end

function this:getPressCount()
  local pressCount = 0
  local x = self.curPressTime - longPressTime
  if self.curPressTime > longPressTime2 then
    local x1 = longPressTime2 - longPressTime
    local y1 = x1 / longPressInterval
    local y2 = (x - x1) / longPressInterval2 + y1
    pressCount = math.floor(y2)
  elseif self.curPressTime > longPressTime then
    local y1 = x / longPressInterval
    pressCount = math.floor(y1)
  end
  return pressCount
end

function this:onSelfClick()
  if self.bind.clickCallback then
    self.bind.clickCallback(self)
  end
  if self.bind.showInfoTipsEntrance ~= nil and self.bind.showInfoTipsEntrance == L_Const.showInfoTipsEntranceType.click and self.bind.itemType and self.bind.itemId then
    local notShowAccess = self:GetSourceLuaPageOptions("failure_jump")
    L_ItemTplManager:showInfoTip(self.bind.itemType, self.bind.itemId, nil, nil, notShowAccess)
  end
end

function this:onRemoveClick()
  if self.bind.clickRemoveCallback then
    self.bind.clickRemoveCallback(self)
  end
end

function this:resetData(option)
  self.bind.itemType = option.itemType
  self.bind.itemId = option.itemId
  self.bind.itemNum = option.itemNum
  self.bind.activeMask = option.activeMask
  self.bind.quality = option.quality
  self.bind.curCount = option.curCount
  self.bind.clickCallback = option.clickCallback
  self.bind.longPressCallback = option.longPressCallback
  self.bind.clickRemoveCallback = option.clickRemoveHandle
  self.bind.itemShowType = option.itemShowType
  self.bind.itemSubType = option.itemSubType
  self.bind.guid = option.guid
  self.bind.bagType = option.bagType
  self.bind.decomposes = option.decomposes
  self.bind.cellItemNum = option.cellItemNum
  self.bind.cellItemMaxNum = option.cellItemMaxNum
  self.bind.needCount = option.needCount
  self.bind.showInfoTipsEntrance = option.showInfoTipsEntranceType
  self.bind.lock = option.lock
  self.bind.stackIndex = option.stackIndex
  self.bind.pressWorking = option.pressWorking
  self.bind.selectCallback = option.selectCallback
  self.bind.deSelectCallback = option.deSelectCallback
  self.bind.disableCellIconContent = option.disableCellIconContent or false
end

function this:refresh()
  self.bind.content = true
  if self.bind.itemShowType == L_Const.submitItemShowType.empty then
    self.modules.cellIcon:setContentActive(false)
    self.bind.activeIcon = true
    self.bind.btn = true
  elseif self.bind.itemShowType == L_Const.submitItemShowType.select then
    self.bind.activeNumBg = true
    self.bind.activeNeedIcon = true
    self.modules.cellIcon:setGeneralContent(self.bind.itemType, self.bind.itemId)
    if self.bind.itemNum then
      self.bind.txtNum = tostring(self.bind.itemNum)
    end
    if self.bind.itemType == L_Const.resType.accessory then
      self:updateAccessory()
    else
      self.bind.activeOwner = false
    end
    self.bind.activeIcon = true
    self.bind.btn = true
  elseif self.bind.itemShowType == L_Const.submitItemShowType.submitTarget then
    self.bind.activeNumBg = true
    self.modules.cellIcon:setGeneralContent(self.bind.itemType, self.bind.itemId, {noTip = true})
    self.bind.activeIcon = true
    local conf = L_ItemTplManager:getItemConfig(self.bind.itemType, self.bind.itemId)
    self.bind.sprNeedIcon = conf.icon
    self.bind.activeNeedIcon = true
    self.bind.activeEmpty = false
    self.bind.btn = true
    self:setCurCount(self.bind.curCount)
  elseif self.bind.itemShowType == L_Const.submitItemShowType.submitSubType then
    self.bind.activeNumBg = true
    local commonItemTypeTpl = L_GameTpl:getCommonItemTypeTpl()
    local tpl = commonItemTypeTpl:getTplById(self.bind.itemSubType)
    local typeIcon = tpl and commonItemTypeTpl:getIcon(tpl) or L_GameConstTpl:getData("TASK_SUBMIT_ICON_DEFAULT", L_Const.GameTplType.string)
    self.bind.sprTypeIcon = typeIcon
    self.bind.activeTypeIcon = true
    self.bind.activeEmpty = true
    self.bind.btn = true
    self:setCurCount(self.bind.curCount)
  elseif self.bind.itemShowType == L_Const.submitItemShowType.waitAdd then
    self.modules.cellIcon:setContentActive(false)
    self.bind.activeNumBg = false
    self.bind.activeSelectNum = false
    self.bind.activeTypeIcon = false
    self.bind.activeIcon = true
    self.bind.btn = false
    self.bind.itemId = nil
    self.bind.content = false
    self.select = false
  elseif self.bind.itemShowType == L_Const.submitItemShowType.blackEmpty then
    self.modules.cellIcon:setContentActive(false)
    self.bind.activeIcon = false
    self.bind.btn = false
    self.bind.activeEmpty = true
    self.bind.activeEmptyImg = true
    self.bind.activeImgBg = false
  end
  self.modules.cellIcon:setContentIsDisable(self.bind.disableCellIconContent)
end

function this:setGeneralContent(itemType, itemId, params)
  self.bind.itemType = itemType
  self.bind.itemId = itemId
  self.bind.itemShowType = params.itemShowType
  self.bind.curCount = params.curCount
  self.bind.needCount = params.needCount
  printf("cellSubmitItem", "设置点击值" .. tostring(params.showInfoTipsEntranceType))
  self.bind.showInfoTipsEntrance = params.showInfoTipsEntranceType
  self:refresh()
  self:setSummitItemCount(params.curCount)
  local m_componentNodeList = {
    self.bind.activeEmpty,
    self.bind.activeNumBg,
    self.bind.activeBottom,
    self.bind.activeMask
  }
  if not params.isShowSubmit then
    for k, v in pairs(m_componentNodeList) do
      v = false
    end
  end
end

function this:setCurCount(curCount)
  if self.bind.itemShowType == L_Const.submitItemShowType.select then
    return
  end
  self.bind.curCount = curCount
  if self.bind.needCount then
    if self.bind.curCount < self.bind.needCount then
      self.bind.txtNum = string.format("<color=#ff878f>%s</color>/%s", self.bind.curCount, self.bind.needCount)
    else
      self.bind.txtNum = string.format("%s/%s", self.bind.curCount, self.bind.needCount)
    end
  end
end

function this:setSelectedCount(curSelectedNum, maxNum)
  self.bind.txtNum = string.format("%s/%s", curSelectedNum, maxNum)
  self.bind.cellItemNum = curSelectedNum
  self.bind.cellItemMaxNum = maxNum
  self.bind.txtSelectNum = ""
  self.bind.activeSelectNumBg = curSelectedNum ~= 0
  self.bind.activeSelectNum = curSelectedNum ~= 0
end

function this:setSelect(select, num, needCount)
  self.select = select
  if select then
    if num then
      if self.bind.itemNum then
        num = math.min(self.bind.itemNum, num)
      end
      self.selectNum = num
      if needCount ~= nil and 0 < needCount then
        self.bind.activeTxtSelectNum = false
        self.bind.activeSelectNumBg = false
        self.bind.txtNum = string.format("%s/%s", self.selectNum, self.bind.itemNum)
      else
        self.bind.activeTxtSelectNum = true
        self.bind.txtSelectNum = tostring(num)
        self.bind.activeSelectNumBg = true
      end
    else
      self.bind.activeSelectNumBg = false
    end
    self.bind.activeSelectNum = true
    return num
  else
    if self.bind.itemNum then
      self.bind.txtNum = tostring(self.bind.itemNum)
    end
    self.selectNum = nil
    self.bind.activeSelectNum = false
    return 0
  end
end

function this:getSelectNum()
  if not self.select or not self.selectNum then
    return 0
  end
  return self.selectNum
end

function this:setSummitItemCount(curCount)
  self.bind.curCount = curCount
  if self.bind.needCount then
    if self.bind.curCount < self.bind.needCount then
      self.bind.txtNum = string.format("<color=#ff878f>%s</color>/%s", self.bind.curCount, self.bind.needCount)
    else
      self.bind.txtNum = string.format("%s/%s", self.bind.curCount, self.bind.needCount)
    end
  else
    self.bind.txtNum = tostring(self.bind.curCount)
  end
  if self.bind.itemShowType == L_Const.submitItemShowType.submitTarget then
  elseif self.bind.itemShowType == L_Const.submitItemShowType.waitAdd then
    self.bind.itemId = nil
  end
end

function this:setCount(selectCount, needCount)
  if self.bind.itemShowType == L_Const.submitItemShowType.submitTarget then
    self:setSummitItemCount(selectCount)
  elseif self.bind.itemShowType == L_Const.submitItemShowType.select then
    self:setSelect(selectCount and 0 < selectCount or false, selectCount, needCount)
  end
end

function this:getCount()
  if self.bind.itemShowType == L_Const.submitItemShowType.submitTarget then
    return self:getCurCount()
  elseif self.bind.itemShowType == L_Const.submitItemShowType.select then
    return self.selectNum
  end
end

function this:getCurCount()
  return self.bind.curCount
end

function this:getSelectId()
  return self.bind.guid
end

function this:getRaycastGo()
  if self.isBind then
    return self.bindComponents.go_btn.gameObject
  end
end

function this:getActive()
  return self.bind.activeSelectNum
end

function this:getItemId()
  return self.bind.itemId
end

function this:refreshView()
  self.bind.itemShowType = L_Const.submitItemShowType.select
  self.bind.curCount = self.bind.itemId
  if self.bind.cellGuid ~= nil and self.bind.cellGuid ~= 0 then
    self.bind.guid = self.bind.cellGuid
  end
  self:refresh()
  local itemNum = self.bind.cellItemNum and self.bind.cellItemNum or 0
  local itemMaxNum = self.bind.cellItemMaxNum and self.bind.cellItemMaxNum or 0
  self:setSelectedCount(itemNum, itemMaxNum)
end

function this:setItemBuffState(itemBuffNum)
  if 0 < itemBuffNum then
    self.modules.cellIcon:setBuffActive(1)
  elseif itemBuffNum < 0 then
    self.modules.cellIcon:setBuffActive(2)
  else
    self.modules.cellIcon:setBuffActive(0)
  end
end

function this:updateAccessory()
  local serverData = C_AccessoryMgr:getAccessory(self.bind.guid)
  if serverData then
    self.modules.cellIcon:setAccessoryToLock(serverData.lock)
    if self.bind.cellItemNum ~= nil and self.bind.cellItemMaxNum ~= nil then
      self.bind.txtNum = string.format("%s/%s", self.bind.cellItemNum, self.bind.cellItemMaxNum)
    else
      self.bind.txtNum = string.concat("+", serverData.level)
    end
    local isEquipped = not math.isEmpty(serverData.wearHero)
    self.bind.activeOwner = isEquipped
    self.modules.cellIcon:setAccessoryToStars(serverData.accessoryId, serverData.quality == 5)
    if isEquipped then
      local heroData = L_HeroStore:getHero(serverData.wearHero)
      if heroData then
        local heroConf = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroData))
        self.bindComponents.img_owner:LoadSprite(heroConf.icon_small)
        if heroData.type == L_Const.HeroType.HT_MAIN then
          L_PhotoManager:newOrBindPhotoEntity(self, self.bindComponents.rect_img_owner, L_PlayerStore:getPlayerModHeadImgName())
        else
          L_PhotoManager:clearPhotoEntity(self)
        end
      end
    end
  end
end

function this:getAccessoryIsEquipped()
  local serverData = C_AccessoryMgr:getAccessory(self.bind.guid)
  if serverData then
    local isEquipped = not math.isEmpty(serverData.wearHero)
    return isEquipped
  end
  return false
end

function this:close()
  L_PhotoManager:clearPhotoEntity(self)
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
end

function this:onSelfSelect()
  if self.bind.selectCallback then
    self.bind.selectCallback(self)
  end
end

function this:onSelfDeSelect()
  if self.bind.deSelectCallback then
    self.bind.deSelectCallback(self)
  end
end

return this

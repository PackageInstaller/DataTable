local this = class("cellIconCircle", G_UIModuleBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _homeDropTpl = L_GameTpl:getHomeDropTpl()
local LightBgPath = "Assets/ResourcesAssets/UI/Atlas/CommonItem/tex_common_bg_quality_light_0%s.png"
local DarkBgPath = "Assets/ResourcesAssets/UI/Atlas/CommonItem/tex_common_bg_quality_dark_0%s.png"
local state = {
  normal = 1,
  selected = 2,
  claimable = 3,
  claimed = 4,
  locked = 5,
  empty = 6
}

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {hasFrame = true}
end

function this.bind()
  return {
    img_item = nil,
    img_pet = nil,
    img_hero = nil,
    img_quality = "",
    active_bgFrame = true,
    active_transform = false,
    active_content = true,
    active_item = true,
    active_hero = false,
    active_pet = false,
    active_selected = false,
    active_claimable = false,
    active_claimed = false,
    active_locked = false,
    txt_num = "",
    active_num = false,
    active_goldFrame = false,
    active_goldCropEffect = false
  }
end

function this.methods()
  return {
    onClick = function(self)
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
      self:emit("onClick", self._itemType)
      if not self._selectMode and not self._callback and not self._noTip then
        L_ItemTplManager:showInfoTip(self._itemType, self._itemId, self.bind.guid)
      end
    end,
    onClick_transform = function(self)
      if self._transCallback then
        self._transCallback(self)
      end
      self:emit("onClick_transform", self._itemType)
    end,
    onLongPress = function(self)
      if (self._callback or self._selectMode) and not self._noTip then
        L_ItemTplManager:showInfoTip(self._itemType, self._itemId, self.bind.guid)
      end
    end
  }
end

function this:open()
  this.super.open(self)
  self:refreshView()
end

function this:close()
  L_PhotoManager:clearPhotoEntity(self)
end

function this:refreshView()
  if not self.isBind then
    return
  end
  local itemType = self.bind.itemType
  if not itemType then
    return
  end
  self.bind.itemNum = self.bind.itemNum or 1
  if not math.isEmpty(self.bind.guid) then
    self:setDataContent(itemType, self.bind.guid, self.bind)
  else
    self:setGeneralContent(itemType, self.bind.itemId, self.bind)
  end
  if self._selectMode then
    self._selectedNum = 0
  end
  self:refreshState(self._state or state.normal)
end

function this:refreshState(_state)
  self:setFrame(false, self._isGoldFrame or false)
  self.bind.active_goldFrame = false
  self.bind.active_selected = false
  self.bind.active_claimable = false
  self.bind.active_claimed = false
  self.bind.active_locked = false
  self.bind.active_content = true
  if _state == state.normal then
    self:setFrame(true, self._isGoldFrame or false)
  elseif _state == state.selected then
    self.bind.active_selected = true
  elseif _state == state.claimable then
    self.bind.active_claimable = true
  elseif _state == state.claimed then
    self:setFrame(true, self._isGoldFrame or false)
    self.bind.active_claimed = true
    self.bind.active_num = self._isFixedNum
  elseif _state == state.locked then
    self:setFrame(true, self._isGoldFrame or false)
    self.bind.active_locked = true
    self.bind.active_num = self._isFixedNum
  else
    self:setFrame(true, self._isGoldFrame or false)
    self.bind.active_content = false
    local pathQuality = 5
    if self.bindComponents.isLightMode then
      self.bind.img_quality = string.format(LightBgPath, tostring(pathQuality))
    else
      self.bind.img_quality = string.format(DarkBgPath, tostring(pathQuality))
    end
  end
end

function this:setSelectedState(isSelected)
  self:refreshState(isSelected and state.selected or state.normal)
end

function this:setClaimableState(isClaimable)
  self:refreshState(isClaimable and state.claimable or state.normal)
end

function this:setClaimedState(isClaimed)
  self:refreshState(isClaimed and state.claimed or state.normal)
end

function this:setLockedState(isLocked)
  self:refreshState(isLocked and state.locked or state.normal)
end

function this:setEmptyState(isEmpty)
  self:refreshState(isEmpty and state.empty or state.normal)
end

function this:setGeneralContent(itemType, itemId, params)
  params = params or {}
  self._itemType = itemType
  self._itemId = itemId
  local conf = L_ItemTplManager:getItemConfig(itemType, itemId)
  self.bind.active_item = false
  self.bind.active_hero = false
  self.bind.active_pet = false
  if itemType == L_Const.resType.pet then
    self.bind.active_pet = true
    self.bind.img_pet = conf.icon
  elseif itemType == L_Const.resType.hero then
    self.bind.active_hero = true
    self.bind.img_hero = conf.icon
    if self._guid == L_HeroStore:getDefaultHeroGuid() then
      L_PhotoManager:newOrBindPhotoEntity(self, self.bindComponents.img_hero, L_PlayerStore:getPlayerModHeadImgName())
    else
      L_PhotoManager:clearPhotoEntity(self)
    end
  else
    self.bind.active_item = true
    self.bind.img_item = conf.icon
  end
  local txtNum = ""
  local isHasReduceNum = params.itemNum and params.itemReduceNum
  local isOverReduceNum = isHasReduceNum and params.itemNum > params.itemReduceNum
  if isOverReduceNum then
    if self.bindComponents.isLightMode then
      txtNum = string.format("<color=#f45757>%s</color>/%s", C_DataNumUtil.GetNumString(params.itemReduceNum), C_DataNumUtil.GetNumString(params.itemNum))
    else
      txtNum = string.format("<color=#ff7070>%s</color>/%s", C_DataNumUtil.GetNumString(params.itemReduceNum), C_DataNumUtil.GetNumString(params.itemNum))
    end
  elseif isHasReduceNum then
    txtNum = C_DataNumUtil.GetNumString(params.itemReduceNum) .. "/" .. C_DataNumUtil.GetNumString(params.itemNum)
  else
    txtNum = params.itemNum and C_DataNumUtil.GetNumString(params.itemNum) or ""
  end
  self.bind.txt_num = txtNum
  if params.itemNumTxt then
    self.bind.txt_num = params.itemNumTxt
  end
  self.bind.active_num = self.bind.txt_num ~= "" or params.isFixedNum
  local pathQuality = 1
  if conf.quality then
    pathQuality = conf.quality + 1
  end
  if self.bindComponents.isLightMode then
    self.bind.img_quality = string.format(LightBgPath, tostring(pathQuality))
  else
    self.bind.img_quality = string.format(DarkBgPath, tostring(pathQuality))
  end
  local isSurprise = _homeDropTpl:getIsSurpriseHarvest(itemId)
  self.bind.active_goldCropEffect = isSurprise
  self.bind.active_transform = params.transCallback ~= nil
  self._isGoldFrame = params.isGoldFrame or false
  self._transCallback = params.transCallback
  self._callback = params.callback
  self._noTip = params.noTip
  self._isFixedNum = params.isFixedNum
  self._selectedNum = params.selectNum or 0
  self._selectCallback = params.selectCallback
  self._selectMode = params.selectMode or params.selectCallback ~= nil
  self._validateSelectFunc = params.validateSelectFunc
  if params.mutiSelect then
    self.bind.mutiSelect = params.mutiSelect
    self:updateSelectView(true)
  end
  self:refreshState(params.state or state.normal)
end

function this:setBtnTransActive(isActive)
  self.bind.active_transform = isActive
end

function this:setBtnTransCallback(_callback)
  self._transCallback = _callback
  self.bind.active_transform = _callback ~= nil
end

function this:setFixedNum()
  if self._isFixedNum then
    self._isFixedNum = true
  end
end

function this:setHasFrame(hasFrame)
  self.data.hasFrame = hasFrame
  self.bind.active_bgFrame = false
  self.bind.active_goldFrame = false
end

function this:setFrame(isActive, isGoldFrame)
  self._isGoldFrame = isGoldFrame
  self.bind.active_bgFrame = false
  self.bind.active_goldFrame = false
  if self._isGoldFrame then
    self.bind.active_goldFrame = self.data.hasFrame and isActive
  else
    self.bind.active_bgFrame = self.data.hasFrame and isActive
  end
end

function this:setNoTip(noTip)
  self._noTip = noTip
end

function this:setIconAndQuality(icon, quality)
  self.bind.img_item = icon
  local pathQuality = quality
  if self.bindComponents.isLightMode then
    self.bind.img_quality = string.format(LightBgPath, tostring(pathQuality))
  else
    self.bind.img_quality = string.format(DarkBgPath, tostring(pathQuality))
  end
end

function this:updateSelectView(notCall)
  if not self.bind.mutiSelect then
    self._selectedNum = math.min(self._selectedNum, 1)
  else
    self._selectedNum = math.min(self._selectedNum, self.bind.itemNum or self._selectedNum)
  end
  self.bind.active_selected = self._selectedNum > 0
  if self._selectCallback and not notCall then
    self._selectCallback(self)
  end
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

function this:getSelectNum()
  return self._selectedNum or 0
end

local GuidType2Func = {
  [L_Const.resType.commonItem] = "setCommonItemDataContent",
  [L_Const.resType.hero] = "setHeroDataContent",
  [L_Const.resType.soulEssence] = "setSoulEssenceDataContent",
  [L_Const.resType.accessory] = "setJewelDataContent",
  [L_Const.resType.pet] = "setPetDataContent",
  [L_Const.resType.mount] = "setMountDataContent"
}

function this:setDataContent(itemType, guid, params)
  if self[GuidType2Func[itemType]] then
    self[GuidType2Func[itemType]](self, guid, params)
  else
    errorf("类型" .. itemType .. "不支持数据显示 请不要传入guid")
  end
end

function this:setMountDataContent(guid, params)
end

function this:setCommonItemDataContent(guid, params)
  self._guid = guid
  local itemData = C_BagMgr:getItem(guid)
  if itemData then
    params.itemNum = itemData.itemNum
    self:setGeneralContent(L_Const.resType.commonItem, guid, params)
  end
end

function this:setHeroDataContent(guid, params)
end

function this:setSoulEssenceDataContent(guid, params)
end

function this:setJewelDataContent(guid, params)
end

function this:setPetDataContent(guid, params)
end

return this

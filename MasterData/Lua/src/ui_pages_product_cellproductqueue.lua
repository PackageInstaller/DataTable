local this = class("cellProductQueue", G_UIModuleBase)
local _productsTpl = L_GameTpl:getProductsTpl()
local _accessoryProductTpl = L_GameTpl:getAccessoryProductTpl()
local _accessoryTpl = L_GameTpl:getAccessoryTpl()
local CellMode = {
  NORMAL = 1,
  NONE = 2,
  LOCK = 3
}
local CellMode2AnimationOnBindComponentName = {
  [CellMode.NORMAL] = "animation_normal_on",
  [CellMode.NONE] = "animation_none_on",
  [CellMode.LOCK] = "animation_lock_on"
}
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local QualityPath = "Assets/ResourcesAssets/UI/Atlas/CommonItem/tex_common_bg_quality_dark_0%s.png"

function this.bind()
  return {
    tab_mode = -1,
    img_product = "",
    img_iconFilter = "",
    img_rarityep = nil,
    active_timeImg = false,
    txt_time = "",
    color_time = C_Color(1, 1, 1, 1),
    txt_finishNum = "",
    txt_totalNum = "",
    fill_progress = 0,
    toggle_isEating = false,
    active_pause = false,
    toggle_finish = false,
    img_icon_getIcon = "",
    img_iconFilter_getIcon = "",
    img_rarityep_getIcon = nil,
    finish_FX = false,
    get_FX = false,
    active_time = true,
    active_satietyPause = false
  }
end

function this.methods()
  return {
    onClick_delete = function(self)
      if self._isFastQueue then
        self:onClickDelete_fastProduct()
      else
        self:onClickDelete_normalProduct()
      end
    end,
    onClick_reward = function(self)
      if self._isFastQueue then
        return
      end
      self:emit("onClickPageProductReward", self.bind)
    end,
    onClick_icon = function(self)
      if self._isFastQueue then
        return
      end
      self:emit("onClickPageProductReward", self.bind)
    end,
    onClick_select = function(self)
      if C_InputManager.IsEnableGamePad and self.bind.tab_mode == CellMode.NORMAL then
        if self.bind.toggle_finish then
          self.methods.onClick_reward(self)
        else
          self.methods.onClick_delete(self)
        end
      end
    end
  }
end

function this:close()
  L_TimerManager:clearTimer(self)
end

function this:open()
  self.hasSetNormalProductQueue = false
  self.hasSetFastProductQueue = false
  self.setNormalProductQueueTaskCount = 0
  self.setFastProductQueueTaskCount = 0
  L_TimerManager:newOrResetTimer(self, "setNormalProductQueueTask", function()
    if self.setNormalProductQueueTaskCount == 0 then
      return
    end
    if self:checkIsPlayingAnyAnimationOfNormalProduct() then
      return
    end
    self:setNormalProductQueue()
  end, 0.01, -1)
  L_TimerManager:newOrResetTimer(self, "setFastProductQueueTask", function()
    if self.setFastProductQueueTaskCount == 0 then
      return
    end
    if self:checkIsPlayingAnyAnimationOfFastProduct() then
      return
    end
    self:setFastProductQueue()
  end, 0.01, -1)
end

function this:show()
  self:refreshOnShow()
end

function this:refreshOnShow()
  if self.bind and self.bind.tab_mode ~= nil then
    local animation = CellMode2AnimationOnBindComponentName[self.bind.tab_mode] and self.bindComponents[CellMode2AnimationOnBindComponentName[self.bind.tab_mode]] or nil
    if animation ~= nil and not animation.isPlaying then
      local animName = "anim_product_queue_normal_in"
      local clip = animation:GetClip(animName)
      if clip then
        animation:Play(animName)
        local state = animation.get_Item and animation:get_Item(animName)
        if state then
          state.time = clip.length
        end
      end
    end
  end
end

function this:refresh()
  self._isFastQueue = self.bind.queueData.isFastQueue and true or false
  if self._isFastQueue then
    if self:checkIsPlayingAnimProductQueueCompleteOfNormalProduct() and self.bind.queueData.isEmpty == true then
      self.setFastProductQueueTaskCount = 1
    else
      self:setFastProductQueue()
    end
  elseif self:checkIsCellProductQueueListPlayingAnyAnimationOfNormalProduct() then
    self.setNormalProductQueueTaskCount = 1
  else
    self:setNormalProductQueue()
  end
end

function this:onTimer()
  if self._isFastQueue then
    self:onTimer_fastProductQueue()
  else
    self:onTimer_normalProductQueue()
  end
end

function this:setFastProductQueue()
  L_TimerManager:stopTimer(self, "refresh")
  if not self.isBind then
    return
  end
  self._csFastProductData = self.bind.queueData.csFastProductData
  if self._csFastProductData == nil then
    self:setTabMode(CellMode.NONE)
  else
    self:setTabMode(CellMode.NORMAL)
    local productId = self._csFastProductData.ProductId
    local tpl = _productsTpl:getTplById(productId)
    if tpl == nil then
      return
    end
    local reward = _productsTpl:getRewardId(tpl)
    local itemData = L_DataUtil.parseRewardConfigItem(reward[1])
    local conf = L_ItemTplManager:getItemConfig(itemData.itemType, itemData.itemId)
    self.bind.img_product = conf.icon
    self.bind.img_icon_getIcon = conf.icon
    local commonItemTpl = _commonItemTpl:getTplById(conf.itemId)
    self.bind.img_iconFilter = commonItemTpl and _commonItemTpl:getFilterIcon(commonItemTpl) or ""
    self.bind.img_iconFilter_getIcon = commonItemTpl and _commonItemTpl:getFilterIcon(commonItemTpl) or ""
    self.bind.img_rarityep = string.format(QualityPath, conf.quality + 1)
    self.bind.img_rarityep_getIcon = string.format(QualityPath, conf.quality + 1)
    local startTime = self._csFastProductData.StartTime or 0
    local endTime = self._csFastProductData.FinishTime or 0
    if 0 < startTime and 0 < endTime then
      L_TimerManager:newOrResetTimer(self, "refresh", function()
        self:onTimer()
      end, 0.5, -1)
      self:onTimer()
    else
      self.bind.txt_time = L_WordsTpl:getValue("ui_cellFastProductQueue_01")
      self.bind.color_time = C_Color(1, 1, 1, 0.5)
      self.bind.txt_finishNum = "0"
      self.bind.txt_totalNum = string.format("/%s", self._csFastProductData.TotalCount)
    end
  end
  self.hasSetFastProductQueue = true
  self.setFastProductQueueTaskCount = 0
end

function this:onTimer_fastProductQueue()
  if self._csFastProductData == nil then
    return
  end
  local productId = self._csFastProductData.ProductId
  local totalNum = self._csFastProductData.TotalCount
  local finishNum = 0
  local startTime = self._csFastProductData.StartTime
  local endTime = self._csFastProductData.FinishTime
  if startTime == nil or startTime <= 0 and endTime == nil and endTime <= 0 then
    return
  end
  if self.hasSetFastProductQueue == true and self.isFinish == false and totalNum == 0 then
    self:playAnimProductQueueCompleteOfNormalProduct()
  end
  if totalNum == 0 then
    self.isFinish = true
    self.bind.txt_time = L_WordsTpl:getValue("notice_cellProductQueueNew_03")
    self.bind.color_time = C_Color(1.0, 0.7490196078431373, 0.20392156862745098, 1.0)
  else
    self.isFinish = false
    self.bind.color_time = C_Color(1, 1, 1, 1)
  end
  local nowTime = L_TimeUtil.getServerTimeWithFloor()
  if 1 < totalNum then
    endTime = endTime + (endTime - startTime) * (totalNum - 1)
  end
  local leftTime = math.ceil(endTime - nowTime)
  if leftTime <= 0 then
    leftTime = 0
  end
  self.bind.txt_time = 0 < leftTime and C_TimeUtility.LeftCountdownShow(endTime, CS.Azur.Gameplay.Core.Misc.TimeUtility.LeftCountdownShowType.TWO_UNIT_WORD) or C_TimeUtility.SecondToString(leftTime, CS.Azur.Gameplay.Core.Misc.TimeUtility.LeftCountdownShowType.TWO_UNIT_WORD)
  self.bind.txt_finishNum = string.format("%s", finishNum)
  self.bind.txt_totalNum = string.format("/%s", totalNum)
  self.bind.fill_progress = math.lerp(0, 1, finishNum / totalNum)
end

function this:onClickDelete_fastProduct()
  if self._csFastProductData == nil then
    return
  end
  self:hideFinishFX()
  self.isClose = true
  local guid = self._csFastProductData.ProductGuid
  L_ProductStore:req_CSProtoSimpleProductCancel(guid)
end

function this:checkIsPlayingAnimProductQueueCompleteOfNormalProduct()
  local animation = self.bindComponents.animation_tab1_normal
  if animation and animation.isPlaying then
    return true
  end
  return false
end

function this:checkIsPlayingAnyAnimationOfFastProduct()
  local animation = self.bindComponents.animation_tab1_normal
  if animation and animation.isPlaying then
    return true
  end
  animation = CellMode2AnimationOnBindComponentName[self.bind.tab_mode] and self.bindComponents[CellMode2AnimationOnBindComponentName[self.bind.tab_mode]] or nil
  if animation and animation.isPlaying then
    return true
  end
  return false
end

function this:playAnimProductQueueCompleteOfFastProduct()
  local animation = self.bindComponents.animation_tab1_normal
  if animation == nil then
    return
  end
  if animation.isPlaying then
    animation:Stop()
  end
  if not self.isClose then
    animation:Play("anim_product_queue_complete")
    L_AudioUtil.playSound("Play_System_QuickProduct_Complete")
  end
  self.isClose = false
end

function this:hideFinishFX()
  local animation = self.bindComponents.animation_tab1_normal
  if animation == nil then
    return
  end
  if animation.isPlaying then
    animation:Stop()
  end
  self.bind.finish_FX = false
end

function this:setNormalProductQueue()
  L_TimerManager:stopTimer(self, "refresh")
  local isUnlock = self.bind.queueData.isUnlock
  local unlockLevel = self.bind.queueData.unlockLevel
  local csHomeBuildProductData = self.bind.queueData.csHomeBuildProductData
  local isEmpty = self.bind.queueData.isEmpty
  local buildingGuid = self.bind.queueData.buildingGuid
  if csHomeBuildProductData == nil then
    self._csHomeBuildProductData = nil
  else
    self._csHomeBuildProductData = {
      productId = csHomeBuildProductData.productId,
      startTime = csHomeBuildProductData.startTime,
      totalCount = csHomeBuildProductData.totalCount,
      finishCount = csHomeBuildProductData.finishCount,
      guid = csHomeBuildProductData.guid,
      finishTime = csHomeBuildProductData.finishTime,
      state = csHomeBuildProductData.state,
      totalFinishTime = csHomeBuildProductData.totalFinishTime,
      specialGuid = csHomeBuildProductData.specialGuid,
      designatedItemId = csHomeBuildProductData.designatedItemId
    }
  end
  self._buildingGuid = buildingGuid
  local buildType = C_HomeUtil.GetBuildingType(buildingGuid)
  if not isUnlock then
    self:setTabMode(CellMode.LOCK)
    self.bind.txt_condition = L_WordsTpl:getValue("ui_product_unlock_tip", {
      [0] = unlockLevel
    })
  elseif isEmpty then
    self:setTabMode(CellMode.NONE)
  else
    self:setTabMode(CellMode.NORMAL)
    local productId = self._csHomeBuildProductData.productId
    if buildType == L_Const.WorldMapBuildType.WMBT_HATCH then
      local petEggData = L_PetStore:getPetEggItem(self._csHomeBuildProductData.specialGuid)
      local petEggConf = L_ItemTplManager:getPetEggItem(petEggData.configId, self._csHomeBuildProductData.specialGuid)
      self.bind.img_product = petEggConf.icon
      self.bind.img_icon_getIcon = petEggConf.icon
      self.bind.img_rarityep = string.format(QualityPath, petEggConf.quality + 1)
      self.bind.img_rarityep_getIcon = string.format(QualityPath, petEggConf.quality + 1)
    elseif C_HomeUtil.IsAccessoryProductBuild(buildingGuid) then
      local icon, quality
      local itemId = self._csHomeBuildProductData.designatedItemId
      if itemId and 0 < itemId then
        local itemType = L_Const.resType.customAccessory
        if _accessoryTpl:checkIsAcessoryData(itemId) then
          itemType = L_Const.resType.accessory
        end
        local conf = L_ItemTplManager:getItemConfig(itemType, itemId)
        icon = conf.icon or ""
        quality = conf.quality + 1
      else
        local tpl = _accessoryProductTpl:getTplById(productId)
        icon = _accessoryProductTpl:getIcon(tpl) or ""
        quality = 1
      end
      local rararityIcon = string.format(QualityPath, quality)
      self.bind.img_product = icon
      self.bind.img_icon_getIcon = icon
      self.bind.img_rarityep = rararityIcon
      self.bind.img_rarityep_getIcon = rararityIcon
    else
      local tpl = _productsTpl:getTplById(productId)
      local reward = _productsTpl:getRewardId(tpl)
      local itemData = L_DataUtil.parseRewardConfigItem(reward[1])
      local conf = L_ItemTplManager:getItemConfig(itemData.itemType, itemData.itemId)
      local commonItemTpl = _commonItemTpl:getTplById(conf.itemId)
      self.bind.img_iconFilter = commonItemTpl and _commonItemTpl:getFilterIcon(commonItemTpl) or ""
      self.bind.img_iconFilter_getIcon = commonItemTpl and _commonItemTpl:getFilterIcon(commonItemTpl) or ""
      self.bind.img_product = conf.icon
      self.bind.img_icon_getIcon = conf.icon
      self.bind.img_rarityep = string.format(QualityPath, conf.quality + 1)
      self.bind.img_rarityep_getIcon = string.format(QualityPath, conf.quality + 1)
    end
    L_TimerManager:newOrResetTimer(self, "refresh", function()
      self:onTimer()
    end, 0.5, -1)
    self:onTimer()
  end
  self.hasSetNormalProductQueue = true
  self.setNormalProductQueueTaskCount = 0
end

function this:playCompleteResetAnim()
  local animation = self.bindComponents.animation_tab1_normal
  if animation == nil or animation.isPlaying then
    return
  end
  local completeAnimName = "anim_product_queue_complete"
  animation:Play(completeAnimName)
  local animationState
  for _, state in pairs(animation) do
    if state and state.name == completeAnimName then
      animationState = state
      break
    end
  end
  animationState.time = animationState.length
  animation:Sample()
end

function this:onTimer_normalProductQueue()
  if self._buildingGuid == nil or self._buildingGuid <= 0 or self:checkIsPlayingAnimProductQueueGetOrCompleteOfNormalProduct() or self._csHomeBuildProductData == nil then
    return
  end
  local nowTime = L_TimeUtil.getServerTimeWithFloor()
  local state, petIsEating = L_ProductManager:getProductState(self._buildingGuid, self._csHomeBuildProductData.guid)
  self.bind.active_pause = false
  local isHatch = C_HomeUtil.GetBuildingType(self._buildingGuid) == L_Const.WorldMapBuildType.WMBT_HATCH
  self.bind.active_satietyPause = false
  self.bind.active_time = true
  self.bind.toggle_isEating = false
  self.bind.color_time = C_Color(1, 1, 1, 1)
  if state == L_HomeConst.ProductQueueState.PAUSE then
    local curProductIndex = self.bind.queueData.index
    local isFirst = curProductIndex and self.bind.queueData.index == 1
    local orderFirst = false
    if isFirst then
      orderFirst = true
    elseif curProductIndex and 1 < curProductIndex then
      local queueData = L_ProductManager:getProduceQueueForBuilding(self._buildingGuid)
      local preOrder = queueData[curProductIndex - 1]
      if preOrder and preOrder.csHomeBuildProductData then
        local preState = L_ProductManager:getProductState(self._buildingGuid, preOrder.csHomeBuildProductData.guid)
        if preState == L_HomeConst.ProductQueueState.FINISH then
          orderFirst = true
        end
      end
    end
    if not orderFirst then
      self.bind.active_timeImg = true
      self.bind.txt_time = L_WordsTpl:getValue("ui_cellFastProductQueue_01")
      self.bind.color_time = C_Color(1, 1, 1, 0.5)
    else
      if petIsEating then
        self.bind.active_timeImg = true
        self.bind.txt_time = L_GameUtil.fillColor(L_WordsTpl:getValue("notice_cellProductQueueNew_01"), "#ffffff80")
      else
        self.bind.active_timeImg = false
        self.bind.active_satietyPause = true
        self.bind.active_time = false
      end
      self.bind.toggle_isEating = petIsEating
      self.bind.active_pause = state == L_HomeConst.ProductQueueState.PAUSE
    end
  elseif state == L_HomeConst.ProductQueueState.FINISH then
    self.bind.active_timeImg = false
    self.bind.txt_time = L_GameUtil.fillColor(isHatch and L_WordsTpl:getValue("notice_cellProductQueueNew_02") or L_WordsTpl:getValue("notice_cellProductQueueNew_03"), "#ffbf35")
    self.bind.active_eggFinish = isHatch
  elseif state == L_HomeConst.ProductQueueState.WAITING then
    self.bind.active_timeImg = true
    self.bind.txt_time = L_WordsTpl:getValue("ui_cellFastProductQueue_01")
    self.bind.color_time = C_Color(1, 1, 1, 0.5)
  else
    local leftTime = math.ceil(self._csHomeBuildProductData.totalFinishTime - nowTime)
    leftTime = leftTime <= 0 and 0 or leftTime
    self.bind.active_timeImg = leftTime ~= 0
    self.bind.txt_time = 0 < leftTime and C_TimeUtility.LeftCountdownShow(self._csHomeBuildProductData.totalFinishTime, CS.Azur.Gameplay.Core.Misc.TimeUtility.LeftCountdownShowType.TWO_UNIT_WORD) or C_TimeUtility.SecondToString(leftTime, CS.Azur.Gameplay.Core.Misc.TimeUtility.LeftCountdownShowType.TWO_UNIT_WORD)
  end
  local finishCount = self._csHomeBuildProductData.finishCount
  local totalCount = self._csHomeBuildProductData.totalCount
  local allCount = finishCount + totalCount
  if self.hasSetNormalProductQueue == true and self.bind.toggle_finish == false and totalCount == 0 then
    self:playAnimProductQueueCompleteOfNormalProduct()
  end
  if self.hasSetNormalProductQueue == true and self.bind.toggle_finish == true and totalCount == 0 then
    self:playCompleteResetAnim()
  end
  self.bind.toggle_finish = totalCount == 0
  self.bind.txt_finishNum = string.format("%s", finishCount)
  self.bind.txt_totalNum = string.format("/%s", allCount)
  self.bind.fill_progress = math.lerp(0, 1, finishCount / allCount)
end

function this:onClickDelete_normalProduct()
  local data_tip = {
    txtTitle = L_WordsTpl:getValue("ui_product_cancle"),
    txtContent = L_WordsTpl:getValue("ui_product_cancle_tip"),
    confirmCallback = function()
      L_ProductManager:reqCancelProduct(self._buildingGuid, self._csHomeBuildProductData.guid)
    end
  }
  L_GameUtil.showCommonTip(data_tip)
end

function this:playAnimProductQueueCompleteOfNormalProduct()
  local animation = self.bindComponents.animation_tab1_normal
  if animation == nil then
    return
  end
  if animation.isPlaying then
    animation:Stop()
  end
  animation:Play("anim_product_queue_complete")
  L_AudioUtil.playSound("Play_System_QuickProduct_Complete")
end

function this:playAnimProductQueueGetOfNormalProduct()
  local animation = self.bindComponents.animation_tab1_normal
  if animation == nil then
    return
  end
  if animation.isPlaying then
    animation:Stop()
  end
  animation:Play("anim_product_queue_get")
end

function this:checkIsPlayingAnimProductQueueGetOrCompleteOfNormalProduct()
  local animation = self.bindComponents.animation_tab1_normal
  if animation and animation.isPlaying then
    return true
  end
  return false
end

function this:checkIsPlayingAnyAnimationOfNormalProduct()
  if self.bindComponents == nil then
    return false
  end
  local animation = self.bindComponents.animation_tab1_normal
  if animation and animation.isPlaying then
    return true
  end
  animation = CellMode2AnimationOnBindComponentName[self.bind.tab_mode] and self.bindComponents[CellMode2AnimationOnBindComponentName[self.bind.tab_mode]] or nil
  if animation and animation.isPlaying then
    return true
  end
  return false
end

function this:checkIsCellProductQueueListPlayingAnyAnimationOfNormalProduct()
  local cellProductQueueList
  if self.parent ~= nil and self.parent.getCellProductQueueList ~= nil then
    cellProductQueueList = self.parent:getCellProductQueueList()
  end
  if cellProductQueueList == nil then
    return false
  end
  for i = 1, #cellProductQueueList do
    local cellProductQueue = cellProductQueueList:getItemCls(i)
    if cellProductQueue:checkIsPlayingAnyAnimationOfNormalProduct() then
      return true
    end
  end
  return false
end

function this:getCsHomeBuildProductData()
  return self._csHomeBuildProductData
end

function this:setTabMode(tabMode)
  local oldTabMode = self.bind.tab_mode
  self.bind.tab_mode = tabMode
  if oldTabMode ~= nil and oldTabMode ~= tabMode then
    local animation = CellMode2AnimationOnBindComponentName[self.bind.tab_mode] and self.bindComponents[CellMode2AnimationOnBindComponentName[self.bind.tab_mode]] or nil
    if animation ~= nil then
      if animation.isPlaying then
        animation:Stop()
      end
      animation:Play("anim_product_queue_normal_in")
    end
  end
end

return this

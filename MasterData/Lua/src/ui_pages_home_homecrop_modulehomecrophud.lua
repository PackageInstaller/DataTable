local module = class("moduleHomeCropHud", G_UIModuleBase)
local _seedTpl = L_GameTpl:getHomeSeedsTpl()

function module.bind()
  return {
    active_content = false,
    ani_content = "",
    txt_cropName = "",
    txt_cropStep = "",
    active_water = false,
    value_water = 0,
    txt_water = "",
    active_grow = false,
    txt_cropGrowTime = "",
    value_growTime = 0,
    active_eradicate = false
  }
end

function module.methods()
  return {
    onClick_eradicate = function(self)
      self:onEventBtnEradicate()
    end
  }
end

function module:open()
  self.isShowShortCut = nil
  self._waterCurve = self.bindComponents.curveHolder.curves[0]
  
  function self._refreshFunc()
    self:refreshLookingCrop()
  end
  
  L_HomeManager:addListener(L_HomeManager.event.triggerBuilding, self._refreshFunc)
  C_HomeStoreEvent.instance:Listen(C_EHomeStoreEvent.HomeBuildSync, self._refreshFunc)
  self:refreshLookingCrop()
  self:refreshView()
end

function module:showViewSet()
  self.isShowShortCut = true
  if not self.isShow then
    return
  end
  if L_DeviceTpl:getIsPc() then
    L_ShortCutManager:addListener(L_ShortCutConst.event.KeyCodeR, self.onPressKeyCodeR, self)
    self:showShortCut(6, true)
  end
end

function module:show()
  if L_DeviceTpl:getIsPc() and self.isShowShortCut then
    L_ShortCutManager:addListener(L_ShortCutConst.event.KeyCodeR, self.onPressKeyCodeR, self)
    self:showShortCut(6, true)
  end
end

function module:hide()
  self:hideViewSet()
end

function module:hideViewSet()
  self.isShowShortCut = false
  if L_DeviceTpl:getIsPc() then
    L_ShortCutManager:clearShortKeyFlag(self)
    self:showShortCut(6, false)
  end
end

function module:showShortCut(id, idAdd)
  local args = CS.Lens.Gameplay.UI.ModuleShortcutGuideEventArgs()
  args.isLuaEvent = true
  args.luaTable = {
    tdId = id,
    isAdd = idAdd,
    isGray = false
  }
  C_ExternalManager.DispatchEvent(C_EExternalEventType.ShortcutGuidePcChange, args)
end

function module:refreshView()
  if self._homeBuildCropData == nil then
    return
  end
  local cropState = self._homeBuildCropData:GetStateInt()
  if cropState == L_HomeConst.HomeCropState.NONE then
    self.bind.active_eradicate = false
  else
    local canEradicate = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.eradicatingCrop)
    self.bind.active_eradicate = canEradicate and not L_DeviceTpl:getIsPc()
  end
end

function module:close()
  L_HomeManager:removeListener(L_HomeManager.event.triggerBuilding, self._refreshFunc)
  C_HomeStoreEvent.instance:Cancel(C_EHomeStoreEvent.HomeBuildSync, self._refreshFunc)
  self:clearDataCache()
  self.isShowShortCut = nil
end

function module:refreshLookingCrop()
  local buildGuid = L_HomeManager:getCurrInteractId()
  local buildingEntity = AzurWorld.HomeMgr and AzurWorld.HomeMgr:GetHomeBuild(buildGuid)
  if not (buildingEntity and buildingEntity:GetStoreData()) or buildingEntity:GetStoreData():GetGroupConfig().type ~= 15 then
    self:_hideContent()
  else
    local crop = buildingEntity:GetStoreData().crop
    self:_refreshData(crop)
  end
  self.buildingEntity = buildingEntity
end

function module:_hideContent(callback)
  if self._hiding then
    return
  end
  self._hiding = true
  self:clearDataCache()
  if not callback then
    self.bind.ani_content = "anim_home_crop_close"
    L_TimerManager:newOrResetTimer(self, "hideCrop", function()
      self.bind.active_content = false
      self:hideViewSet()
    end, 0.134)
  else
    callback()
  end
end

function module:_refreshData(homeBuildCropData)
  if self._homeBuildCropData ~= homeBuildCropData then
    self:clearDataCache()
    self._homeBuildCropData = homeBuildCropData
  end
  
  local function refreshUI()
    self:refreshView()
    local cropState = self._homeBuildCropData:GetStateInt()
    if cropState == L_HomeConst.HomeCropState.NONE and self._cropState == L_HomeConst.HomeCropState.NONE then
      self:_hideContent()
      return
    else
      L_TimerManager:stopTimer(self, "hideCrop")
      if self._hiding then
        self.bind.active_content = true
        self:showViewSet()
        self.bind.ani_content = "anim_home_crop_open"
        self._hiding = false
      elseif self._isNew then
        if cropState == L_HomeConst.HomeCropState.SEED then
          self.bindComponents.anim:Play("anim_home_crop_normal")
        else
          self.bindComponents.anim:Play("anim_home_crop_grow_normal")
        end
        self._isNew = false
      else
        self:refreshAnim()
      end
      self._cropState = cropState
    end
    if cropState ~= L_HomeConst.HomeCropState.NONE then
      local confTable = self._homeBuildCropData:GetSeedTable()
      self.bind.txt_cropName = confTable.cropName.value
      if string.isEmpty(L_HomeConst.HomeCropStateName[cropState]) then
        self.bind.txt_cropStep = L_HomeConst.HomeCropStateName[cropState]
      else
        self.bind.txt_cropStep = L_WordsTpl:getValue(L_HomeConst.HomeCropStateName[cropState])
      end
      if cropState == L_HomeConst.HomeCropState.SEED then
        self.bind.active_water = true
        self.bind.active_grow = false
        self:refreshWater()
        self._oldWaterNum = self._homeBuildCropData.waterNum
      else
        self.bind.active_water = false
        self.bind.active_grow = true
        local finishTime = self._homeBuildCropData.finishTime
        if cropState == L_HomeConst.HomeCropState.HARVEST then
          self.bind.txt_cropGrowTime = L_WordsTpl:getValue("ui_moduleHomeCropHud_02")
          self.bind.value_growTime = 1
          self._isPlayLoopHarvest = true
        else
          local timeStr = L_TimeUtil.secondToString(finishTime - L_TimeUtil.getServerTimeWithFloor(), L_TimeUtil.secondToStringShowType.TWO_UNIT)
          self.bind.txt_cropGrowTime = L_WordsTpl:getValue("ui_moduleHomeCropHud_03", {
            [0] = timeStr
          })
          local needTime = self._homeBuildCropData.growTime + self._homeBuildCropData.preTime
          self.bind.value_growTime = 1 - (finishTime - L_TimeUtil.getServerTimeWithFloor()) / needTime
          self._isPlayLoopHarvest = false
        end
        if self._isPlayLoopHarvest then
          self.bindComponents.harvestAnim:Play("anim_home_crop_grow_finish_loop")
        else
          self.bindComponents.harvestAnim:Stop()
        end
      end
    end
  end
  
  L_TimerManager:newOrResetTimer(self, "refreshUI", refreshUI, 0.25, -1)
  refreshUI()
end

function module:clearDataCache()
  self._cWater = nil
  self._oldWaterNum = nil
  self._homeBuildCropData = nil
  self._isNew = true
  self._isPlayLoopHarvest = false
  self._cropState = L_HomeConst.HomeCropState.NONE
  self.buildingEntity = nil
  self:stopWaterLoopAnim()
  L_TimerManager:clearTimer(self)
end

function module:refreshAnim()
  local cropState = self._homeBuildCropData:GetStateInt()
  local oldCropState = self._cropState
  local curWaterNum = self._homeBuildCropData.waterNum
  if cropState == L_HomeConst.HomeCropState.SEED and oldCropState == L_HomeConst.HomeCropState.SEED and not self._cWater and self._oldWaterNum and curWaterNum > self._oldWaterNum then
    self._cWater = curWaterNum
    self.bindComponents.anim:Play("anim_home_crop_water_star")
  end
  if cropState == oldCropState then
    return
  end
  if cropState == L_HomeConst.HomeCropState.GROW1 and oldCropState == L_HomeConst.HomeCropState.SEED then
    self.bindComponents.anim:Play("anim_home_crop_watertogrow")
  elseif cropState == L_HomeConst.HomeCropState.HARVEST and oldCropState == L_HomeConst.HomeCropState.GROW2 then
    self.bindComponents.anim:Play("anim_home_crop_grow_finish")
  elseif cropState == L_HomeConst.HomeCropState.NONE and oldCropState == L_HomeConst.HomeCropState.HARVEST then
    self:_hideContent(function()
      self.bindComponents.anim:Play("anim_home_crop_pick")
      L_TimerManager:newOrResetTimer(self, "hideCrop", function()
        self:_hideContent()
      end, 1)
    end)
  elseif cropState == L_HomeConst.HomeCropState.GROW2 and oldCropState == L_HomeConst.HomeCropState.HARVEST then
    self.bindComponents.anim:Play("anim_home_crop_pick_2")
  end
end

function module:refreshWater()
  local currWater = self._homeBuildCropData.waterNum
  local currWaterMax = self._homeBuildCropData.waterMax
  if self._oldWaterNum and currWater > self._oldWaterNum then
    self._cWater = self._oldWaterNum
  end
  if self._cWater and currWater > self._cWater then
    local function getter()
      return self._cWater
    end
    
    local function setter(v)
      if self._isPlayLoopWater then
        self._cWater = v
        local waterNum = math.ceil(self._cWater)
        self.bind.value_water = waterNum / currWaterMax
        self.bind.txt_water = L_WordsTpl:getValue("ui_moduleHomeCropHud_01", {
          [0] = waterNum,
          currWaterMax
        })
      end
    end
    
    self._waterTween = DOTween.To(getter, setter, currWater, 0.225):SetTarget(self.gameObject):SetEase(self._waterCurve)
    self._waterTween:SetAutoKill(true)
    
    function self._waterTween.onComplete()
      self._waterTween = nil
      self._cWater = nil
    end
  else
    self.bind.value_water = currWater / currWaterMax
    self.bind.txt_water = L_WordsTpl:getValue("ui_moduleHomeCropHud_01", {
      [0] = currWater,
      currWaterMax
    })
  end
  if self._cWater and self._oldWaterNum then
    self:playWaterLoopAnim()
  else
    self:stopWaterLoopAnim()
  end
end

function module:playWaterLoopAnim()
  if not self._isPlayLoopWater then
    self.bindComponents.waterAnim:Play("anim_home_crop_water_loop")
    self._isPlayLoopWater = true
  end
end

function module:stopWaterLoopAnim()
  self.bindComponents.waterAnim:Stop()
  self._isPlayLoopWater = false
  if L_CommonUtil.isValid(self._waterTween) then
    self._waterTween:Kill()
    self._waterTween = nil
  end
end

function module:onPressKeyCodeR()
  self:onEventBtnEradicate()
end

function module:onEventBtnEradicate()
  if self.buildingEntity == nil then
    return
  end
  self.buildingEntity:OnEradicateCrop()
end

return module

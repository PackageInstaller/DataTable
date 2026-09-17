local this = class("moduleHomeCrop", G_UIModuleBase)
local _homeSeedTpl = L_GameTpl:getHomeSeedsTpl()
local _dropTpl = L_GameTpl:getDropTpl()
local _homeDropTpl = L_GameTpl:getHomeDropTpl()

function this.bind()
  return {
    bSeedsTipsActive = false,
    bSeedsTipsControlActive = true,
    txtSeedName = "",
    txtSeedLimit = "",
    activeSeedLimit = false,
    txtSeedTime = "",
    txtSeedReward = "",
    txtSeedWater = "",
    txtSeedStore = ""
  }
end

function this.methods()
  return {}
end

function this:show()
end

function this:open()
  local curModule = L_WorldManager:getCurModule()
  local isHome = curModule == L_Const.worldModule.home
  if not isHome then
    return
  end
  self:initPage(self._beltModule)
end

function this:close(options)
  this.super.close(self, options)
end

function this:initPage(beltModule)
  if not beltModule then
    return
  end
  self._pressingAction = nil
  self._beltModule = beltModule
  beltModule:setBelt(L_Const.HomeShortcutBarType.HSBT_CROP, true, {
    onClickCell = function(id, viewId)
      self._chooseSeedId = id
      self._chooseViewId = viewId
      L_HomeManager.selectedCropItemId = id
    end,
    onChangeEmplty = function()
      L_HomeManager.selectedCropItemId = 0
      self._chooseViewId = 0
    end,
    onPressCell = function(id, viewId)
      if L_DeviceTpl:getIsPc() then
        return
      end
      self._chooseSeedId = id
      self._chooseViewId = viewId
      self:refreshTips(viewId, id)
    end,
    onEnterCell = function(id, viewId)
      if L_DeviceTpl:getIsPc() then
        self:refreshTips(viewId, id)
      end
    end,
    onExitCell = function(id, viewId)
      if L_DeviceTpl:getIsPc() then
        self:hideTip()
      end
    end,
    selectedIndex = self._chooseViewId or 0
  })
end

function this:hideTip()
  self.bind.bSeedsTipsActive = false
end

function this:refreshTips(viewId, itemId)
  if math.isEmpty(itemId) then
    self.bind.bSeedsTipsActive = false
    return
  end
  self.bind.bSeedsTipsActive = true
  local tarRect = self._beltModule:getRaycastGo(viewId).transform
  local itemInfo = L_ItemManager:parseCommonItem(itemId)
  self.bind.txtSeedName = itemInfo.name
  local seedTpl = _homeSeedTpl:getTplBySeedItemId(itemId)
  if not seedTpl then
    errorf("种子缺少配置,物品id:" .. itemId)
    return
  end
  local condition = _homeSeedTpl:getCondition(seedTpl)
  self.bind.activeSeedLimit = not L_ConditionManager:isComplete(condition)
  self.bind.txtSeedLimit = condition[1] and L_ConditionManager:getSingleDesc(condition[1]) or ""
  local buffCondition = L_HomeBuffManager:getCropCondition(_homeSeedTpl:getId(seedTpl))
  local growTime, preHarTime = L_HomeBuffManager:getCropGrowParam(_homeSeedTpl:getId(seedTpl), buffCondition)
  local totalTime = growTime + preHarTime
  self.bind.txtSeedTime = L_TimeUtil.secondToString(totalTime, L_TimeUtil.secondToStringShowType.TWO_UNIT)
  local dropId = _homeSeedTpl:getHomeDropId(seedTpl)
  local dropTpl = _homeDropTpl:getTplById(dropId[1])
  local rewardItemId = _homeDropTpl:getItemId(dropTpl)
  local rewardItemType = _homeDropTpl:getItemType(dropTpl)
  local rewardItemConf = L_ItemTplManager:getItemConfig(rewardItemType, rewardItemId[1])
  local minValue = _homeDropTpl:getMinValue(dropTpl)
  self.bind.txtSeedReward = tostring(minValue)
  local productNum = L_ItemTplManager:getItemNum(rewardItemType, rewardItemId[1])
  local productName = rewardItemConf.name
  self.bind.txtSeedStore = L_WordsTpl:getValue("home_farm_cropstorage", {
    [0] = productName
  }) .. L_GameUtil.fillColor(productNum, "#96F9FF")
  self.bind.txtSeedWater = L_WordsTpl:getValue("ui_moduleHomeCrop") .. L_GameUtil.fillColor(_homeSeedTpl:getNeedWater(seedTpl), "#96F9FF")
  self.recordTipsPosX = tarRect.position.x
  self.bindComponents.panelTips.position = C_Vector3(tarRect.position.x, self.bindComponents.panelTips.position.y, self.bindComponents.panelTips.position.z)
end

return this

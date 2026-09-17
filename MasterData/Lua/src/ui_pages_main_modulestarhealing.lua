local this = class("moduleStarHealing", G_UIModuleBase)
local worldCityTpl = L_GameTpl:getWorldCityTpl()
local heroSatietyTpl = L_GameTpl:getChargeSatietyTpl()
local Color = C_Color
local ColorCache = {
  [1] = Color(0.7764705882352941, 0.24313725490196078, 0.2235294117647059, 1.0),
  [2] = Color(0.8862745098039215, 0.5843137254901961, 0 / 255.0, 1.0),
  [3] = Color(0.1803921568627451, 0.6352941176470588, 0.6078431372549019, 1.0)
}

function this.bind()
  return {
    hintTip_active = false,
    txt_starHealing = "0",
    list_hintTip = {
      moduleName = "pages/main/cellHealingHint"
    },
    go_recovery = false,
    sortingOrder = 11,
    go_healing = true,
    go_progress = true,
    go_clickBg = false,
    go_redTips = false
  }
end

function this.methods()
  return {
    onPointEnter_showTip = function(self)
      if C_AppConfigManager.IsMobilePlatformForUI then
        return
      end
      self.bind.go_clickBg = false
      local sceneId = AzurWorldInstance.CurWorldId
      local cityTpl = worldCityTpl:getTplById(sceneId)
      if worldCityTpl:getCharge(cityTpl) and worldCityTpl:getCharge(cityTpl) > 0 then
        self.bind.hintTip_active = false
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_charge_close") or L_WordsTpl:getValue("notice_charge_close_02"))
        return
      end
      self.bind.hintTip_active = true
    end,
    onPointExit_hideTip = function(self)
      if C_AppConfigManager.IsMobilePlatformForUI then
        return
      end
      self.bind.go_clickBg = false
      self.bind.hintTip_active = false
    end,
    onClick_showTip = function(self)
      if C_AppConfigManager.IsMobilePlatformForUI then
        self.bind.go_clickBg = true
        local sceneId = AzurWorldInstance.CurWorldId
        local cityTpl = worldCityTpl:getTplById(sceneId)
        if worldCityTpl:getCharge(cityTpl) and worldCityTpl:getCharge(cityTpl) > 0 then
          self.bind.hintTip_active = false
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_charge_close") or L_WordsTpl:getValue("notice_charge_close_02"))
          return
        end
        self.bind.hintTip_active = true
      end
    end,
    onClick_hideTip = function(self)
      if C_AppConfigManager.IsMobilePlatformForUI then
        self.bind.go_clickBg = false
        self.bind.hintTip_active = false
      end
    end
  }
end

function this:open()
  self.redTipsNum = L_GameConstTpl:getData("HUD_SATIETY_WARNING_FLOOR_VALUE", L_Const.GameTplType.int) or 29
  L_StarHealingStore:listenCallFunc(L_StarHealingStore.event.starHealingChargeRefresh, self.setCharge, self)
  L_StarHealingStore:listenCallFunc(L_StarHealingStore.event.popModuleStartHealing, self.popModuleStartHealing, self)
  L_StarHealingStore:listenCallFunc(L_StarHealingStore.event.playStarHealingEffect, self.playStarHealingEffect, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.playerFightStateChange, self.onFightStateChange, self)
  self._onCutWorldComplete = handler(self, self.onCutWorldComplete)
  C_GameFlow.flowEvent:Listen(C_EGameFlowEvent.CutWorldComplete, self._onCutWorldComplete)
  self:InitMat()
  self:initSystem()
  self.uiBinding.gameObject:ActiveTrans(not AzurWorld.DungeonMgr:CheckIsInTeaching())
  self.bind.hintTip_active = false
end

function this:show()
  self:showInfo()
end

function this:hide()
  self:hideInfo()
  self.bind.go_clickBg = false
end

function this:close()
  L_StarHealingStore:unListenCallFunc(L_StarHealingStore.event.starHealingChargeRefresh, self.setCharge)
  L_StarHealingStore:unListenCallFunc(L_StarHealingStore.event.popModuleStartHealing, self.popModuleStartHealing, self)
  L_StarHealingStore:unListenCallFunc(L_StarHealingStore.event.playStarHealingEffect, self.playStarHealingEffect, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.playerFightStateChange, self.onFightStateChange, self)
  C_GameFlow.flowEvent:Cancel(C_EGameFlowEvent.CutWorldComplete, self._onCutWorldComplete)
  self:destroyAllLocker()
  if self.matBlock then
    self.matBlock = nil
  end
  if self.matInstance then
    C_UnityObject.Destroy(self.matInstance)
    self.matInstance = nil
  end
  self.pregressState = nil
end

function this:checkForceUpdateAlpha()
  if self.hasForceUpdate == nil and self.isShowingGoProgress then
    self.hasForceUpdate = true
    if self.matBlock ~= nil then
      self.bindComponents.meshRenderer_goProgress:GetPropertyBlock(self.matBlock)
      self.matBlock:SetFloat("_ALPHA", 1)
      self.bindComponents.meshRenderer_goProgress:SetPropertyBlock(self.matBlock)
    end
  end
end

function this:showInfo()
  if not L_BattleDataManager:checkPlayerBattle() then
    self.bind.go_healing = true
    self.bind.go_recovery = false
    self:setCharge()
  end
end

function this:hideInfo()
  self.bind.go_healing = false
  self.bind.go_recovery = false
  self.bind.hintTip_active = false
  if self.bindComponents.ani_recovery then
    self.bindComponents.ani_recovery:Stop()
  end
end

function this:initSystem()
  self.systemToTrans = {
    [L_SystemConst.enum.recover] = {
      self.gameObject.transform
    }
  }
  for systemId, v in pairs(self.systemToTrans) do
    v.locker = C_IntegrateMgr.SystemUnlockModule:tryGenerateLocker(systemId)
    if v.locker then
      self:refreshSystem(systemId, false)
      v.locker:setCallback(self.refreshSystem, self, self.gameObject)
    end
  end
end

function this:refreshSystem(systemId, isUnlock)
  local node = self.systemToTrans[systemId]
  local locker = node.locker
  for _, v in ipairs(node) do
    locker:tryShowOrHide(v, isUnlock)
  end
end

function this:destroyAllLocker()
  for _, v in pairs(self.systemToTrans) do
    local locker = v.locker
    if locker then
      C_IntegrateMgr.SystemUnlockModule:removeLocker(locker)
    end
  end
end

function this:InitMat()
  if not self.matInstance and self.bindComponents.progressMaterialTemp.sharedMaterial then
    self.matInstance = C_UnityObject.Instantiate(self.bindComponents.progressMaterialTemp.sharedMaterial)
    self.bindComponents.meshRenderer_goProgress.material = self.matInstance
  end
  if not self.matBlock then
    self.matBlock = CS.UnityEngine.MaterialPropertyBlock()
  end
  self.bindComponents.ani_goProgress:Stop()
  self.bindComponents.ani_goProgress:Play("anim_maincity_charge_reset")
end

function this:setChargeUI(value)
  self.bind.txt_starHealing = L_WordsTpl:getValue("notice_moduleStarHealing", {
    [0] = value
  })
  self:refreshList(value)
  if self.matInstance ~= nil then
    self.matInstance:SetFloat("_wave_progress", self:mapPercentageToWaveProgress(value))
  end
end

function this:setChargeProgressColor(value)
  local minKey = 1
  local key
  for k, v in pairs(heroSatietyTpl.data) do
    minKey = k < minKey and k or minKey
    local min = v.interval[1]
    local max = v.interval[2]
    if value >= min and value < max + 1 then
      key = k
      break
    end
  end
  key = key or minKey
  if self.matInstance ~= nil and (not self.pregressState or self.pregressState ~= key) then
    print("重新设置饱食度颜色:" .. key)
    self.pregressState = key
    self.matInstance:SetColor("_Color0", ColorCache[self.pregressState])
  end
  if 0 < value then
    self.bind.go_progress = true
  else
    self.bind.go_progress = false
  end
  if value <= self.redTipsNum then
    self.bind.go_redTips = true
  else
    self.bind.go_redTips = false
  end
  self.isShowingGoProgress = 0 < value
  self:checkForceUpdateAlpha()
end

function this:popModuleStartHealing(bIfPop)
  self.bind.sortingOrder = bIfPop and 100 or 11
end

function this:playStarHealingEffect(heroId)
  self.bind.go_recovery = false
  self.bind.go_recovery = true
end

function this:setCharge(isIncrease)
  local chargeData = L_StarHealingStore:getCharge()
  self:setChargeProgressColor(chargeData.cur_value)
  if not isIncrease then
    self:setChargeUI(chargeData.cur_value)
  else
    self:disposeTween()
    local chargeBefore = L_StarHealingStore:getOldChargeValue()
    
    local function getter()
      return chargeBefore
    end
    
    local function setter(r)
      if self.bindComponents and L_CommonUtil.isValid(self.bindComponents.meshRenderer_goProgress) then
        self:setChargeUI(math.floor(r))
      end
    end
    
    self.increaseTween = DOTween.To(getter, setter, chargeData.cur_value, 1)
    self.increaseTween:SetTarget(self.bindComponents.meshRenderer_goProgress)
  end
  if isIncrease then
    self.bindComponents.ani_goProgress:Play("anim_maincity_charge_in_wave")
  elseif chargeData.cur_value == 0 then
    self.bindComponents.ani_goProgress:Play("anim_maincity_charge_empty")
  else
    self.bindComponents.ani_goProgress:Play("anim_maincity_charge_reset")
  end
end

function this:mapPercentageToWaveProgress(percentage)
  if percentage == 0 then
    return 0.061
  elseif percentage <= 99 then
    return percentage / 99 * 0.8 + 0.061
  else
    return 1
  end
end

function this:disposeTween()
  if self.healingTween then
    self.healingTween:Kill()
    self.healingTween = nil
  end
  if self.increaseTween then
    self.increaseTween:Kill()
    self.increaseTween = nil
  end
end

function this:refreshList(value)
  local listData = {}
  for i = 1, 3 do
    local tmp = {
      cellId = i,
      hasSelect = true,
      satietyValue = value
    }
    table.insert(listData, tmp)
  end
  self.bind.list_hintTip:freshAll(listData)
end

function this:onFightStateChange(params)
  if L_BattleDataManager:checkPlayerBattle() then
    self:hideInfo()
  else
    self:showInfo()
  end
end

function this:onCutWorldComplete()
  local sceneId = AzurWorldInstance.CurWorldId
  local cityTpl = worldCityTpl:getTplById(sceneId)
  if L_BattleDataManager:checkPlayerBattle() or AzurWorld.DungeonMgr:CheckIsInTeaching() then
    self:hideInfo()
  else
    self:showInfo()
  end
end

return this

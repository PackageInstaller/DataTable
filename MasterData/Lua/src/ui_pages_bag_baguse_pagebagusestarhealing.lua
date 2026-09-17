local this = class("pageBagUseStarHealing", G_UIPageBase)
local foodTpl = L_GameTpl:getFoodTpl()
local chargeSatietyTpl = L_GameTpl:getChargeSatietyTpl()
local _openAudio = "Play_SFX_System_UI_StarHealing_Menu_Confirm"
local ChargePointValueImgFillValue = {
  [1] = {0.2, 0.466},
  [2] = {0.466, 0.804},
  [3] = {0.804, 1}
}
local ChargeId2Interval = chargeSatietyTpl:getId2IntervalDic()

function this.bind()
  return {
    recoverTipText = "",
    titleText = "",
    go_buffText = false,
    txt_buff = "",
    currentNumText = "",
    addNumText = "",
    limitNumText = "",
    itemDescText = "",
    valueRingAmount = 0,
    addRingAmount = 0,
    itemList = {
      moduleName = "pages/bag/bagUse/cellHealingItem"
    },
    moduleSelectNum = L_Const.ModuleInfo.SelectNum,
    emptyNodeActive = false,
    contentNodeActive = true
  }
end

function this.methods()
  return {
    onClick_closeBtn = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_useBtn = function(self)
      local chargeData = L_StarHealingStore:getCharge()
      local curCharge = chargeData.cur_value
      local maxCharge = L_StarHealingStore:getMaxCharge()
      if curCharge >= maxCharge then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_bag_chargeOver"))
        return
      end
      self.playEffect = true
      C_BagMgr:ReqUseItem(self.selectItemId, self.curNum, {
        L_Const.UseFoodTarget.UFT_HERO,
        0
      }, function()
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_bag_useSuccess"))
        self.curNum = 1
        local num = self:getCurrentItemNum()
        if num < 1 then
          self.selectItemId = nil
          self:initPage()
        end
        self:setSelectItem()
        self:setCharge()
      end)
    end
  }
end

function this:preOpen(options)
  L_StarHealingStore:listenCallFunc(L_StarHealingStore.event.starHealingChargeRefresh, self.onSetCharge, self)
  L_StarHealingStore:call(L_StarHealingStore.event.popModuleStartHealing, true)
  self.curNum = 1
  self.selectItemId = nil
  self.playOpen = true
  C_AudioManager.Play(_openAudio)
end

function this:open(options)
  self:initPage()
  self:setSelectItem()
  self:initHealingInfo()
end

function this:close()
  self:disposeTween()
  L_StarHealingStore:unListenCallFunc(L_StarHealingStore.event.starHealingChargeRefresh, self.onSetCharge, self)
  L_StarHealingStore:call(L_StarHealingStore.event.popModuleStartHealing, false)
end

function this:initSelectNumModule()
  if not self.selectItemId then
    return
  end
  
  local function max()
    return C_BagMgr:GetMaxCanUseNum_food(self.selectItemId, 0)
  end
  
  local function func(num)
    self.curNum = num
    self:initHealingInfo()
  end
  
  self.modules.moduleSelectNum:initModule(func, max)
end

function this:initPage()
  self.bind.recoverTipText = L_WordsTpl:getValue("ui_bag_star_healing_recover_tip")
  self.bind.titleText = L_WordsTpl:getValue("ui_bag_star_healing_title")
  self.bind.itemList:clear()
  local items = L_StarHealingManager:getStarHealingFoods()
  self.bind.emptyNodeActive = #items == 0
  self.bind.contentNodeActive = 0 < #items
  if #items == 0 then
    return
  end
  for _, item in ipairs(items) do
    function item.callback(cell)
      if self.selectItemId == cell._itemId then
        return
      end
      self.selectItemId = cell._itemId
      self.curNum = 1
      self:setSelectItem()
      self:initHealingInfo()
    end
  end
  self.bind.itemList:insert_array(items)
  self.selectItemId = items[1].itemId
end

function this:setSelectItem()
  local num = self:getCurrentItemNum()
  for i = 1, #self.bind.itemList do
    local v = self.bind.itemList:getItemCls(i)
    if self.selectItemId == v:getItemId() then
      self.bind.itemList:change(i, {itemNum = num})
      v:setActive(true)
    else
      v:setActive(false)
    end
  end
  self:setItemInfo()
  self:initSelectNumModule()
end

function this:getCurrentItemNum()
  return C_BagMgr:getItemNumByItemId(self.selectItemId)
end

function this:setItemInfo()
  if not self.selectItemId then
    return
  end
  local item = L_ItemTplManager:getCommonItem(self.selectItemId)
  local nameStr = L_GameUtil.fillColor(item.name, L_Const.colorHtml.grey003)
  self.bind.itemDescText = L_WordsTpl:getValue("ui_bag_star_healing_des", {
    [0] = nameStr,
    item.desc
  })
end

function this:initHealingInfo()
  local chargeData = L_StarHealingStore:getCharge()
  local curCharge = chargeData.cur_value
  local maxCharge = L_StarHealingStore:getMaxCharge()
  self.bind.currentNumText = tostring(curCharge)
  self:refreshBuffText()
  local addNum = self:getAddValue()
  if 0 < addNum then
    self.bind.addNumText = string.format("+%d", addNum)
  else
    self.bind.addNumText = ""
  end
  self.addNumBefore = curCharge + addNum
  self.bind.limitNumText = string.format("/%d", maxCharge)
  local valueTargt = self:calculateTargetValueImgFillAmountByValue(curCharge)
  local addTarget = self:calculateTargetAddImgFillAmountByValue(curCharge + addNum)
  if self.playOpen then
    self:disposeTween()
    Timer.once(0.33, function()
      self:playOpenTween(valueTargt, addTarget)
    end, self)
  else
    self.bind.valueRingAmount = valueTargt
    self.bind.addRingAmount = addTarget
  end
end

function this:playOpenTween(valueTargt, addTarget)
  self.valueTargt = 0
  self.addTarget = 0
  
  local function valueGetter()
    return self.valueTargt
  end
  
  local function addGetter()
    return self.addTarget
  end
  
  local function valueSetter(v)
    self.bind.valueRingAmount = v
  end
  
  local function addSetter(v)
    self.bind.addRingAmount = v
  end
  
  self.valueTweenOpen = DOTween.To(valueGetter, valueSetter, valueTargt, 0.5)
  self.addTweenOpen = DOTween.To(addGetter, addSetter, addTarget, 0.5)
  self.valueTweenOpen:SetEase(Tweening.Ease.OutQuad)
  self.addTweenOpen:SetEase(Tweening.Ease.OutQuad)
  
  function self.addTweenOpen.onComplete()
    self.playOpen = false
  end
end

function this:getAddValue()
  if not self.selectItemId then
    return 0
  end
  local fTpl = foodTpl:getTplById(self.selectItemId)
  local charge = 0
  if fTpl then
    charge = foodTpl:getCharge(fTpl)
  end
  local chargeData = L_StarHealingStore:getCharge()
  local curCharge = chargeData.cur_value
  local maxCharge = L_StarHealingStore:getMaxCharge()
  local addNum = charge * self.curNum
  local limit = maxCharge - curCharge
  return math.min(addNum, limit)
end

function this:onSetCharge()
  if not self.playEffect then
    self:setCharge()
  end
end

function this:setCharge()
  self:disposeTween()
  local chargeData = L_StarHealingStore:getCharge()
  local chargeBefore = L_StarHealingStore:getOldChargeValue()
  local maxCharge = L_StarHealingStore:getMaxCharge()
  self.bind.limitNumText = string.format("/%d", maxCharge)
  if self.chargeBefore == nil then
    self.chargeBefore = chargeBefore
  end
  
  local function getter()
    return self.bind.valueRingAmount
  end
  
  local function setter(r)
    self.bind.valueRingAmount = r
  end
  
  local valueTarget = self:calculateTargetValueImgFillAmountByValue(chargeData.cur_value)
  self.valueTween = DOTween.To(getter, setter, valueTarget, 0.333)
  self.valueTween:SetEase(Tweening.Ease.InOutQuart)
  
  function self.valueTween.onComplete()
    self.bind.currentNumText = tostring(chargeData.cur_value)
    self:refreshBuffText()
    self.playEffect = false
  end
  
  local addNum = self:getAddValue()
  if 0 < addNum then
    self.bind.addNumText = string.format("+%d", addNum)
  else
    self.bind.addNumText = ""
    return
  end
  local addCurrent = addNum + chargeData.cur_value
  
  local function addGetter()
    return self.bind.addRingAmount
  end
  
  local function addSetter(r)
    self.bind.addRingAmount = r
  end
  
  local addTarget = self:calculateTargetAddImgFillAmountByValue(addCurrent)
  self.addTween = DOTween.To(addGetter, addSetter, addTarget, 0.5)
  self.addTween:SetEase(Tweening.Ease.InOutQuart)
end

function this:disposeTween()
  if self.addTween then
    self.addTween:Kill()
    self.addTween = nil
  end
  if self.valueTween then
    self.valueTween:Kill()
    self.valueTween = nil
  end
  if self.valueTweenOpen then
    self.valueTweenOpen:Kill()
    self.valueTweenOpen = nil
  end
  if self.addTweenOpen then
    self.addTweenOpen:Kill()
    self.addTweenOpen = nil
  end
end

function this:calculateTargetValueImgFillAmountByValue(value)
  if value == 0 then
    value = 1
  end
  local targetFillAmount = 0
  for id, interval in pairs(ChargeId2Interval) do
    local left = interval[1]
    local right = interval[2]
    if value >= left and value <= right then
      local startFillAmount = ChargePointValueImgFillValue[id][1]
      local endFillAmount = ChargePointValueImgFillValue[id][2]
      targetFillAmount = (value - left) / (right - left) * (endFillAmount - startFillAmount) + startFillAmount
      return targetFillAmount
    end
  end
end

function this:calculateTargetAddImgFillAmountByValue(value)
  if value == 0 then
    value = 1
  end
  local targetFillAmount = 0
  for id, interval in pairs(ChargeId2Interval) do
    local left = interval[1]
    local right = interval[2]
    if value >= left and value <= right then
      local startFillAmount = ChargePointValueImgFillValue[id][1]
      local endFillAmount = ChargePointValueImgFillValue[id][2]
      targetFillAmount = (value - left) / (right - left) * (endFillAmount - startFillAmount) + startFillAmount
      return targetFillAmount
    end
  end
end

function this:refreshBuffText()
  local curValue = L_StarHealingStore:getCharge().cur_value
  self.bind.go_buffText = curValue ~= 0
  if curValue ~= 0 then
    for id, interval in pairs(ChargeId2Interval) do
      local left = interval[1]
      local right = interval[2]
      if curValue >= left and curValue <= right then
        local firstString = string.format("%d-%d", left, right)
        local secondString = tostring(chargeSatietyTpl:getAmplitudeById(id) / 100) .. "%"
        self.bind.txt_buff = L_WordsTpl:getValue("ui_bag_star_gear_recover_tip") ~= "" and L_WordsTpl:getValue("ui_bag_star_gear_recover_tip", {
          [0] = firstString,
          [1] = secondString
        }) or L_WordsTpl:getValue("ui_pageBagUseStarHealing", {
          [0] = firstString,
          [1] = secondString
        })
        return
      end
    end
  end
end

return this

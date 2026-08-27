local base = UIBaseWindow
local UIDeliverySimulatorMain = class("UIDeliverySimulatorMain", base)
local UIDeliverySimulatorOrderItem = require("Game.ActivityDeliverySimulator.UI.UIDeliverySimulatorOrderItem")
local UIDeliverySimulatorKnapsackItem = require("Game.ActivityDeliverySimulator.UI.UIDeliverySimulatorKnapsackItem")
local UIDeliverySimulatorBuffItem = require("Game.ActivityDeliverySimulator.UI.UIDeliverySimulatorBuffItem")
local UIDeliverySimulatorGoodsSpawnItem = require("Game.ActivityDeliverySimulator.UI.UIDeliverySimulatorGoodsSpawnItem")
local UIDeliverySimulatorWattingOrderItem = require("Game.ActivityDeliverySimulator.UI.UIDeliverySimulatorWattingOrderItem")
local CS_DOTween = CS.DG.Tweening.DOTween
local cs_MessageCommon = CS.MessageCommon

function UIDeliverySimulatorMain:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Run, self, self.OnBtnRunClick)
  UIUtil.AddButtonListener(self.ui.btn_PickUp, self, self.OnBtnPickUpClick)
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self.OnBtnReturnClick)
  UIUtil.AddButtonListener(self.ui.Btn_GiveUp, self, self.OnBtnGiveUpClick)
  UIUtil.AddButtonListener(self.ui.Btn_Continue, self, self.OnBtnContinueClick)
  UIUtil.AddButtonListener(self.ui.Btn_Retry, self, self.OnBtnRetryClick)
  self.ui.tex_AddMoney.gameObject:SetActive(false)
  self.joystick = self.ui.UINJoystick
  self.joystick:onTouchMove("+", BindCallback(self, self._OnJoyStickMove))
  self.joystick:onTouchUp("+", BindCallback(self, self._OnJoyStickUp))
  self.littleHandColor = {}
  UIUtil.LuaUIBindingTable(self.ui.img_littleHand.gameObject, self.littleHandColor)
  self.orderItemPool = UIItemPool.New(UIDeliverySimulatorOrderItem, self.ui.obj_orderItem, false)
  self.wattingOrderItem = UIDeliverySimulatorWattingOrderItem.New()
  self.wattingOrderItem:Init(self.ui.canvas_wattingOrderItem.gameObject)
  self.buffItemPool = UIItemPool.New(UIDeliverySimulatorBuffItem, self.ui.obj_buffItem, false)
  self.goodsSpawnUIItemPool = UIItemPool.New(UIDeliverySimulatorGoodsSpawnItem, self.ui.obj_GoodsSpawnItem, false)
  self.knapsackItem = UIDeliverySimulatorKnapsackItem.New()
  self.knapsackItem:Init(self.ui.obj_Capacity)
  self._addNewOrderDelayTime = 0.15
  self._animOredrItemCount = 0
  self.__OnHideWaittingOrderItemCompeleted = BindCallback(self, self.PlayShowWattingOrderItemAnim)
end

function UIDeliverySimulatorMain:InitDeliverySimulatorMain(resLoader, dsPlayerEntity, dsCtrl)
  self.resLoader = resLoader
  self.dsPlayerEntity = dsPlayerEntity
  self.dsCtrl = dsCtrl
  self.orderItemList = {}
  self.buffItemList = {}
  self:UpdateBtnPickUpStage(nil)
  self:UpdateTotalMoney(0, 0)
  self.knapsackItem:InitDeliverySimulatorKnapsackItem(0, dsPlayerEntity:GetMaxCapacity(), 0)
  self.wattingOrderItem:InitDeliverySimulatorWattingOrderItem(self.dsCtrl)
end

function UIDeliverySimulatorMain:UpdateBtnPickUpStage(goodsSpawnEntity)
  local isTouchGoodsSpawn = goodsSpawnEntity ~= nil
  self.ui.img_GoodsPic.gameObject:SetActive(isTouchGoodsSpawn)
  self.ui.img_littleHand.color = isTouchGoodsSpawn and self.littleHandColor.touchColor or self.littleHandColor.notTouchColor
  self.ui.obj_empty:SetActive(not isTouchGoodsSpawn)
  if isTouchGoodsSpawn then
    self.ui.img_GoodsPic.sprite = goodsSpawnEntity:GetGoodsIconSprite()
    local couldPickUp = goodsSpawnEntity:CouldPickUp()
    local goodsPicColor = self.ui.img_GoodsPic.color
    goodsPicColor.a = couldPickUp and 1 or 0.4
    self.ui.img_GoodsPic.color = goodsPicColor
    self.ui.img_littleHand.color = couldPickUp and self.littleHandColor.touchColor or self.littleHandColor.notTouchColor
    self.couldPickUp = couldPickUp
  end
end

function UIDeliverySimulatorMain:UpdateBtnPickUp()
  local goodsSpawnEntity = self.dsCtrl:GetTouchGoodsSpawnEntity()
  if goodsSpawnEntity ~= nil and goodsSpawnEntity:CouldPickUp() ~= self.couldPickUp then
    self:UpdateBtnPickUpStage(goodsSpawnEntity)
  end
end

function UIDeliverySimulatorMain:CreateGoodsSpawnUIItem()
  return self.goodsSpawnUIItemPool:GetOne()
end

function UIDeliverySimulatorMain:AddBuff(buff)
  local buffItem = self.buffItemPool:GetOne()
  buffItem:InitDeliverySimulatorBuffItem(buff, self.dsCtrl:GetDeliveryAtlas(), self.ui.buffColorList)
  table.insert(self.buffItemList, buffItem)
end

function UIDeliverySimulatorMain:RemoveBuff(buff)
  for key, buffItem in pairs(self.buffItemList) do
    if buffItem.buff == buff then
      self.buffItemPool:HideOne(buffItem)
      self.buffItemList[key] = nil
    end
  end
end

local animEndPosX = 223
local animRelativeX = 500
local animRelativeY = 126

function UIDeliverySimulatorMain:AddNewOrder(order)
  local showOrderItemCount = self:_GetShowOrderItemCount()
  local orderItem = self.orderItemPool:GetOne()
  orderItem.transform.localPosition = Vector3.New(animEndPosX - animRelativeX, -70 - animRelativeY * showOrderItemCount, 0)
  orderItem:InitDeliverySimulatorOrderItem(order)
  orderItem:PlayMoveTween(Vector3.New(animRelativeX, 0, 0), function()
    self._animOredrItemCount = self._animOredrItemCount - 1
  end)
  self._animOredrItemCount = self._animOredrItemCount + 1
  self.orderItemList[order.orderIndex] = orderItem
end

function UIDeliverySimulatorMain:_GetShowOrderItemCount()
  local showOrderItemCount = 0
  for i = 0, self.ui.orderRect.transform.childCount - 1 do
    if self.ui.orderRect.transform:GetChild(i).gameObject.activeInHierarchy then
      showOrderItemCount = showOrderItemCount + 1
    end
  end
  if self.wattingOrderItem.gameObject.activeInHierarchy then
    showOrderItemCount = showOrderItemCount - 1
  end
  return showOrderItemCount
end

function UIDeliverySimulatorMain:OrderFail(order)
  for orderIndex, orderItem in pairs(self.orderItemList) do
    if orderItem.order.orderIndex == order.orderIndex then
      self:PlayFailOrderAnim(orderItem)
      self.orderItemList[orderIndex] = nil
      AudioManager:PlayAudioById(8016)
    end
  end
end

function UIDeliverySimulatorMain:OrderCompleted(order)
  for orderIndex, orderItem in pairs(self.orderItemList) do
    if orderItem.order.orderIndex == order.orderIndex then
      self:PlayHideOrderAnim(orderItem)
      self.orderItemList[orderIndex] = nil
      AudioManager:PlayAudioById(8017)
    end
  end
end

function UIDeliverySimulatorMain:PlayHideOrderAnim(hideOrderItem)
  local hideOrderItemIndex = hideOrderItem.order.orderIndex
  hideOrderItem:PlayMoveTween(Vector3.New(-animRelativeX, 0, 0), function()
    self.orderItemPool:HideOne(hideOrderItem)
    for orderIndex, orderItem in pairs(self.orderItemList) do
      if orderItem.order.orderIndex > hideOrderItemIndex then
        orderItem:PlayMoveTween(Vector3.New(0, animRelativeY, 0))
      end
    end
    self.wattingOrderItem:PlayMoveTween(Vector3.New(0, animRelativeY, 0), 0)
  end)
end

function UIDeliverySimulatorMain:PlayFailOrderAnim(failOrderItem)
  local failOrderItemIndex = failOrderItem.order.orderIndex
  failOrderItem:PlayFailAnim(function()
    self.orderItemPool:HideOne(failOrderItem)
    for orderIndex, orderItem in pairs(self.orderItemList) do
      if orderItem.order.orderIndex > failOrderItemIndex then
        orderItem:PlayMoveTween(Vector3.New(0, animRelativeY, 0))
      end
    end
    self.wattingOrderItem:PlayMoveTween(Vector3.New(0, animRelativeY, 0), 0)
  end)
end

function UIDeliverySimulatorMain:PlayShowWattingOrderItemSwitchAnim()
  if self.wattingOrderItem.isShowInList then
    self:PlayHideWattingOrderItemAnim()
  else
    self:PlayShowWattingOrderItemAnim()
  end
end

function UIDeliverySimulatorMain:PlayShowWattingOrderItemAnim()
  local minY = 56
  for key, orderItem in pairs(self.orderItemList) do
    minY = Mathf.Min(orderItem.transform.localPosition.y, minY)
  end
  local pos = Vector3.New(animEndPosX - animRelativeX, minY - animRelativeY, 0)
  local delayTime = (self._animOredrItemCount + 1) * self._addNewOrderDelayTime
  self.wattingOrderItem:PlayShowWattingOrderItemAnim(pos, Vector3.New(animRelativeX, 0, 0), delayTime)
end

function UIDeliverySimulatorMain:PlayHideWattingOrderItemAnim()
  local pos = Vector3.New(animEndPosX + animRelativeX, 0, 0)
  self.wattingOrderItem:PlayHideWattingOrderItemAnim(pos, self.__OnHideWaittingOrderItemCompeleted)
end

function UIDeliverySimulatorMain:UpdateBuffList(buffList)
  for key, buffItem in pairs(self.buffItemList) do
    buffItem:Refresh(buffList[key])
  end
end

function UIDeliverySimulatorMain:UpdateOrderList(orderList)
  for orderItemIndex, orderItem in pairs(self.orderItemList) do
    for orderIndex, order in pairs(orderList) do
      if orderItem.order.orderIndex == order.orderIndex then
        orderItem:Refresh(orderList[orderIndex])
      end
    end
  end
end

function UIDeliverySimulatorMain:UpdateBuffProgress()
  for key, buffItem in pairs(self.buffItemList) do
    buffItem:UpdateBuffProgress()
  end
end

function UIDeliverySimulatorMain:UpdateOrderProgress()
  for key, orderItem in pairs(self.orderItemList) do
    orderItem:UpdateProgress()
  end
end

function UIDeliverySimulatorMain:UpdateProgress()
  self:UpdateBuffProgress()
  self:UpdateOrderProgress()
  self:UpdateBtnPickUp()
  self:UpdateBtnRunCd()
  self:UpdateTotalMoneyAnim()
  self.wattingOrderItem:UpdateProgress()
end

function UIDeliverySimulatorMain:UpdateTotalMoney(totalMoney, addMoney)
  if self.animTotalMoney == nil then
    self.animTotalMoney = 0
  else
    self.animTotalMoney = tonumber(self.ui.tex_TotalMoney.text)
  end
  self.totalMoney = totalMoney
  self.ui.tex_AddMoney.text = "+" .. tostring(addMoney)
  self.ui.tex_AddMoney.gameObject:SetActive(true)
  if 0 < addMoney then
    self.isAddMoneyAnim = true
    CS_DOTween.Restart(self.ui.tex_AddMoney.gameObject, "AddMoneyLocalMoveIn")
  end
end

function UIDeliverySimulatorMain:UpdateTotalMoneyAnim()
  if self.totalMoney ~= self.animTotalMoney then
    self.animTotalMoney = self.animTotalMoney + (self.totalMoney > self.animTotalMoney and 1 or -1)
    self.ui.tex_TotalMoney.text = tostring(self.animTotalMoney)
  elseif self.isAddMoneyAnim then
    self.isAddMoneyAnim = false
    CS_DOTween.Restart(self.ui.tex_AddMoney.gameObject, "AddMoneyLocalMoveOut")
  end
end

function UIDeliverySimulatorMain:UpdateStartCountDown(timeCount)
  if self.ui.tex_pause.text ~= tostring(timeCount) then
    self.ui.tween_PauseNum:DORestart()
    self.ui.tex_pause.text = timeCount
    AudioManager:PlayAudioById(8018, nil, false)
  end
end

function UIDeliverySimulatorMain:UpdateGameTime(time)
  self.ui.tex_Time:SetIndex(0, tostring(time))
  if time < 5 then
    AudioManager:PlayAudioById(8019, nil, false)
  end
end

function UIDeliverySimulatorMain:UpdateBtnRunCd()
  if self.dsPlayerEntity:IsInRunCD() then
    if not self.ui.img_runCd.gameObject.activeSelf then
      self.ui.img_runCd.gameObject:SetActive(true)
      self.ui.img_runIcon:CrossFadeAlpha(0.3, 0, true)
    end
    local currentCd = self.dsPlayerEntity:GetRunCd()
    self.ui.img_runCd.fillAmount = currentCd / self.dsPlayerEntity.runCd
    self.ui.tex_runCd:SetIndex(0, string.format("%.1f", currentCd))
  elseif self.ui.img_runCd.gameObject.activeSelf then
    self.ui.img_runCd.gameObject:SetActive(false)
    self.ui.img_runIcon:CrossFadeAlpha(1, 0, true)
  end
end

function UIDeliverySimulatorMain:StartTimeWarningAnim()
  self.ui.tween_timeWarning:DOPlay()
end

function UIDeliverySimulatorMain:ShowStartCountDown(time)
  self.ui.StartNode:SetActive(true)
  self:UpdateStartCountDown(time)
end

function UIDeliverySimulatorMain:_OnJoyStickMove(moveData)
  self.dsCtrl:OnMove(moveData)
end

function UIDeliverySimulatorMain:_OnJoyStickUp()
  self.dsCtrl:OnMove(nil)
end

function UIDeliverySimulatorMain:OnBtnRunClick()
  self.dsCtrl:OnRunClick()
end

function UIDeliverySimulatorMain:OnBtnPickUpClick()
  self.dsCtrl:OnPickUpClick()
end

function UIDeliverySimulatorMain:OnBtnReturnClick()
  self.dsCtrl:Pause()
  self.ui.PausetNode:SetActive(true)
end

function UIDeliverySimulatorMain:OnBtnGiveUpClick()
  local msg = string.format(ConfigData:GetTipContent(58007))
  cs_MessageCommon.ShowMessageBox(msg, function()
    if self.dsCtrl ~= nil then
      self.dsCtrl:Continue()
      self.dsCtrl:GameEnd(false)
      self.ui.PausetNode:SetActive(false)
      self.dsCtrl:ShowGameResult()
    end
  end, nil)
end

function UIDeliverySimulatorMain:OnBtnContinueClick()
  self.dsCtrl:CancelPause()
  self.ui.PausetNode:SetActive(false)
  self.ui.StartNode:SetActive(true)
end

function UIDeliverySimulatorMain:Continue()
  self.ui.StartNode:SetActive(false)
end

function UIDeliverySimulatorMain:OnBtnRetryClick()
  local msg = string.format(ConfigData:GetTipContent(58006))
  cs_MessageCommon.ShowMessageBox(msg, function()
    self.dsCtrl:Restart()
  end, nil)
end

function UIDeliverySimulatorMain:Reset()
  self.orderItemList = {}
  self.buffItemList = {}
  self.wattingOrderItem:Reset()
  self:UpdateBtnPickUpStage(nil)
  self.ui.tex_TotalMoney.text = 0
  self.ui.tex_AddMoney.gameObject:SetActive(false)
  self:UpdateTotalMoney(0, 0)
  self:UpdateProgress()
  self.knapsackItem:InitDeliverySimulatorKnapsackItem(0, self.dsPlayerEntity:GetMaxCapacity(), 0)
  self.knapsackItem:ClearGoods()
  self.orderItemPool:HideAll()
  self.buffItemPool:HideAll()
  self.ui.PausetNode:SetActive(false)
  self.ui.StartNode:SetActive(false)
  self.ui.tween_timeWarning:DORewind()
  CS_DOTween.PauseAll()
end

function UIDeliverySimulatorMain:OnDelete()
  self.joystick:onTouchMove("-", BindCallback(self, self._OnJoyStickMove))
  self.joystick:onTouchUp("-", BindCallback(self, self._OnJoyStickUp))
  self.joystick = nil
  self.orderItemPool:DeleteAll()
  self.orderItemPool = nil
  self.buffItemPool:DeleteAll()
  self.buffItemPool = nil
  self.goodsSpawnUIItemPool:DeleteAll()
  self.goodsSpawnUIItemPool = nil
end

return UIDeliverySimulatorMain

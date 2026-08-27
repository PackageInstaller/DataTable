local UIGiftPageDetail = class("UIGiftPageDetail", UIBaseWindow)
local base = UIBaseWindow
local UINGiftPageDetail = require("Game.QuickPurchaseBox.UINGiftPageDetail")
local UINGiftPageDetailListNode = require("Game.QuickPurchaseBox.UINGiftPageDetailListNode")

function UIGiftPageDetail:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickGiftPageClose)
  UIUtil.AddButtonListener(self.ui.background, self, self.OnClickGiftPageClose)
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  self.giftPagePool = UIItemPool.New(UINGiftPageDetail, self.ui.giftPageDetailItem)
  self.ui.giftPageDetailItem:SetActive(false)
end

function UIGiftPageDetail:InitGiftPageDetail(payGiftInfo)
  local flag, giftCfg, allDay = payGiftInfo:TryGetGiftSubscriptionCfg()
  local isRandom, rGiftCfg = payGiftInfo:TryGetGiftRaffleCfg()
  if not flag and not isRandom then
    error("这个礼包不存在订阅项 id is " .. tostring(payGiftInfo.groupCfg.id) .. ".并且这个礼包不是随机礼包")
    return
  end
  self.ui.obj_giftList:SetActive(false)
  self.ui.obj_dayRewardList:SetActive(false)
  if flag then
    if payGiftInfo:IsCheckNextGift() then
      self:InitGiftPageDetailBaseOfCheckNext(payGiftInfo)
    elseif payGiftInfo:IsOrderOfManyTypeGift() then
      self:InitGiftPageDetailBaseOfOrderOfManyType(payGiftInfo, giftCfg, allDay)
    else
      self:InitGiftPageDetailBaseOfOrderOfType(giftCfg, allDay)
    end
    self.ui.tex_Title:SetIndex(0)
  else
    self:InitGiftPageDetailBaseOfCheckNext(payGiftInfo)
    self.ui.tex_Title:SetIndex(1)
  end
end

function UIGiftPageDetail:InitGiftPageDetailBaseOfOrderOfType(giftCfg, allDay)
  self.ui.obj_dayRewardList:SetActive(true)
  local timepassCtr = ControllerManager:GetController(ControllerTypeId.TimePass, true)
  local counterEl = timepassCtr:getCounterElemData(proto_object_CounterModule.CounterModuleGiftReset, giftCfg.id)
  local receivedDay = 0
  local isRuning = false
  if counterEl ~= nil and counterEl.nextExpiredTm > PlayerDataCenter.timestamp then
    isRuning = true
    receivedDay = allDay - math.floor((counterEl.nextExpiredTm - PlayerDataCenter.timestamp) / 86400)
  end
  self.ui.tex_Tips:SetIndex(0, tostring(allDay))
  self.ui.progress:SetActive(isRuning)
  self.ui.tex_progress:SetIndex(0, tostring(receivedDay), tostring(allDay))
  self.giftPagePool:HideAll()
  local itemList = {}
  for i, itemId in ipairs(giftCfg.awardIds) do
    local itemCfg = ConfigData.item[itemId]
    table.insert(itemList, {
      itemCfg = itemCfg,
      count = giftCfg.awardCounts[i]
    })
  end
  for i = 1, allDay do
    local item = self.giftPagePool:GetOne(true)
    item:InitGiftPageItem(i, itemList, receivedDay >= i, isRuning)
  end
end

function UIGiftPageDetail:InitGiftPageDetailBaseOfOrderOfManyType(payGiftInfo, giftCfg, allDay)
  self.ui.obj_dayRewardList:SetActive(true)
  local timepassCtr = ControllerManager:GetController(ControllerTypeId.TimePass, true)
  local counterEl = timepassCtr:getCounterElemData(proto_object_CounterModule.CounterModuleGiftReset, giftCfg.id)
  local receivedDay = 0
  local isRuning = false
  if counterEl ~= nil and counterEl.nextExpiredTm > PlayerDataCenter.timestamp then
    isRuning = true
    receivedDay = allDay - math.floor((counterEl.nextExpiredTm - PlayerDataCenter.timestamp) / 86400)
  end
  self.ui.tex_Tips:SetIndex(1, tostring(allDay))
  self.ui.progress:SetActive(isRuning)
  self.ui.tex_progress:SetIndex(0, tostring(receivedDay), tostring(allDay))
  self.giftPagePool:HideAll()
  local dailyGroup = ConfigData.gift_daily[payGiftInfo.groupCfg.id]
  if dailyGroup == nil then
    return
  end
  for k1, v1 in pairs(dailyGroup) do
    local itemList = {}
    for k2, itemId in pairs(v1.awardIds) do
      local itemCfg = ConfigData.item[itemId]
      table.insert(itemList, {
        itemCfg = itemCfg,
        count = v1.awardCounts[k2]
      })
    end
    local item = self.giftPagePool:GetOne(true)
    item:InitGiftPageItem(k1, itemList, receivedDay >= k1, isRuning)
  end
end

function UIGiftPageDetail:InitGiftPageDetailBaseOfCheckNext(payGiftInfo)
  self.ui.obj_giftList:SetActive(true)
  self.detailListNode = UINGiftPageDetailListNode.New()
  self.detailListNode:Init(self.ui.obj_giftList.transform)
  self.detailListNode:InitGiftPageDetailListNode(payGiftInfo)
end

function UIGiftPageDetail:GenCoverJumpReturnCallback()
  local dataTable = {}
  for key, value in pairs(self) do
    dataTable[key] = value
  end
  UIUtil.PopFromBackStackByUiTab(self)
  return function()
    for key, value in pairs(dataTable) do
      self[key] = value
    end
    UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  end
end

function UIGiftPageDetail:BackAction()
  self:Delete()
end

function UIGiftPageDetail:OnDelete()
  if self.detailListNode then
    self.detailListNode:Delete()
  end
end

function UIGiftPageDetail:OnClickGiftPageClose()
  UIUtil.OnClickBackByUiTab(self)
end

return UIGiftPageDetail

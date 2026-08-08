local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local IU = require("Common/ItemUtil")
local ACU = require("Common/ActivityUtil")
local m_iaphandler = S:Get("IAPHandler")
local m_activityManager = S:Get("ActivityManager")
local m_mallData
local m_viewedGiftActivity = false

function ShowItemReward(rewards)
  local items = {}
  for i, v in ipairs(rewards) do
    if v.type ~= PB.enum.ResourceType.ResMonthCardDays and v.type ~= PB.enum.ResourceType.ResDelayReward then
      items[#items + 1] = v
    end
  end
  WU.ShowHintIcon(items, function()
    OpenManualBox(items)
  end)
end

function OpenManualBox(rewards)
  for _, v in pairs(rewards) do
    if v.type == PB.enum.ResourceType.ResItem then
      local itemInfo = PB.get("ItemInfo", v.id)
      if itemInfo.funcType == PB.enum.ItemFuncType.ManualBox or itemInfo.funcType == PB.enum.ItemFuncType.FinanceBox then
        WU.ShowItemDetail(v.id, false)
        break
      end
    end
  end
end

function IsShow()
  local switch = this:GetData("AccountSwitch")
  return switch and not switch.MallNoPay
end

function SetupWindow()
  m_mallData = PB.all("Mall"):where(function(_, p)
    return p.isMonth == false and p.giftPage == 1
  end):toarray()
  WU.BindButtonEvent(REF.TabGiftActivity, OnTabClick)
  WU.BindButtonEvent(REF.TabVip, OnTabClick)
  WU.BindButtonEvent(REF.TabLvGift, OnTabClick)
  WU.BindButtonEvent(REF.TabMonth, OnTabClick)
  WU.BindButtonEvent(REF.TabDirectPurchaseGift, OnTabClick)
  WU.BindButtonEvent(REF.TabGiftSaku, OnTabClick)
  WU.BindButtonEvent(REF.TabNewbie, OnTabClick)
  this:Bind("PurchasedAllNewbieGift", function(result)
    if result == false then
      return
    end
    WU.SetActive(REF.TabNewbie, not result and IsShow())
    WU.SetActive(REF.GameObjectNewbie, not result and IsShow())
    REF.TabRoot.UIGrid:Reposition()
    if REF.TabNewbie.UIToggle.value then
      REF.TabLvGift.UIToggle.value = true
    end
  end)
  this:RegisterGameEvent("HandlePurchaseGoodsNew", function(purchaseId)
    local reward = m_iaphandler.GetProductsByID(purchaseId)
    if reward == nil then
      warning("no purchase", "no purchase")
      return
    end
    ShowItemReward(reward.purchaseRes)
  end)
end

function OnTabClick()
  if REF.TabLvGift.UIToggle.value then
    this:BroadcastGameEvent("RecordPoint")
    UpdateRedPoint()
  elseif REF.TabGiftActivity.UIToggle.value then
    REF.PurchaseActivityGift["$SetGiftPage"](2)
    this:SetData("RedPointPurchaseGiftActivity", false)
    local mallInfo = this:GetData("fci/mall-info/")
    local dailyIds = mallInfo and mallInfo.mallRecord and mallInfo.mallRecord.dailyMallId
    local now = CS.GameTime.serverUtc
    local refreshTime = mallInfo.mallRecord.dailyMallRefreshTime
    if dailyIds and dailyIds[1] then
      local infos = WU.GetGameDataCache("DailyRandomRefreshe" .. DB:GetData("playerId")) or _ENV["!"]({})
      for i = 1, #dailyIds do
        local id = dailyIds[i]
        local record = infos[id]
        if record == nil or refreshTime > record.refreshTime then
          infos[id] = {showNew = true, refreshTime = refreshTime}
        end
      end
      WU.SetGameDataCache("DailyRandomRefreshe" .. DB:GetData("playerId"), infos)
    end
    this:BroadcastGameEvent("UpdatePointGiftActivity")
    UpdateGiftActivityRedPoint()
    m_viewedGiftActivity = true
  elseif REF.TabDirectPurchaseGift.UIToggle.value then
    REF.PurchaseActivityGift["$SetGiftPage"](3)
    this:SetData("RedPointDirctPurchaseGift", false)
  end
  if not REF.TabGiftActivity.UIToggle.value and m_viewedGiftActivity then
    this:BroadcastGameEvent("UpdateActivityViewed")
  end
  SetMoney()
end

function UpdateRedPoint()
  local b = DB:GetData("RedPointPurchase")
  REF.SpriteRed.gameObject:SetActive(b)
end

function UpdateGiftActivityRedPoint()
  local b = DB:GetData("RedPointPurchaseGiftActivity")
  REF.SpriteRedGiftActivity.gameObject:SetActive(b)
end

function InitWindow()
  this:Bind("fci/resource/ResPlayerMoney_0", SetMoney)
  this:Bind("fci/resource/ResPlayerPayMoney_0", SetMoney)
  this:RegisterGameEvent("POSITION_BUYMONEY", function()
    REF.TabVip.UIToggle.value = true
  end)
  UpdateRedPoint()
  UpdateGiftActivityRedPoint()
  this:Bind("RedPointDirctPurchaseGift", function(red)
    REF.SpriteRedDirectPurchaseGift.gameObject:SetActive(red)
  end)
  this:Bind("AccountSwitch", UpdateUIBySwitch)
  m_viewedGiftActivity = false
  m_activityManager.GetActivityByType(PB.enum.ActivityType.MallDirectPurchase, function(acList)
    local opened = false
    if acList and acList[1] then
      opened = ACU.IsOpenForDoing(acList[1])
    end
    REF.TabDirectPurchaseGift.gameObject:SetActive(opened and IsShow())
  end)
  this:Bind("hasGiftSaku", UpdateGiftSaku)
  local tabName = this:GetData("PurchaseTab")
  if tabName ~= nil then
    local tab = _ENV["$"](REF.TabRoot)["Tab" .. tabName]
    if tab ~= nil then
      tab.UIToggle.value = true
      this:SetData("PurchaseTab", nil)
    end
  end
end

function UninitWindow()
  if m_viewedGiftActivity then
    this:BroadcastGameEvent("UpdateActivityViewed")
  end
end

function UpdateUIBySwitch(switch)
  REF.TabMonth.gameObject:SetActive(switch and switch.OpenMonthCard)
  REF.ButtonPurchaseVipCS.gameObject:SetActive(switch and switch.customService)
  if WU.IsPreCommit() then
    _ENV["$"](REF.TabMonth).LabelButton.UIHtmlLabel.text = WU.GetString("Purchase_GrowthPack")
  end
  local isOpen = IsShow()
  REF.TabNewbie.gameObject:SetActive(isOpen)
  REF.TabMonth.gameObject:SetActive(isOpen)
  REF.TabVip.gameObject:SetActive(isOpen)
  REF.TabGiftActivity.gameObject:SetActive(isOpen)
  REF.TabDirectPurchaseGift.gameObject:SetActive(isOpen)
  REF.TabGiftSaku.gameObject:SetActive(isOpen)
  REF.LabelMoneyDesc.gameObject:SetActive(isOpen)
  if not isOpen then
    REF.GameObjectVip.gameObject:SetActive(false)
    REF.TabLvGift.UIToggle.value = true
    WU.SetWindowTitle("Purchase", "Purchase1")
  end
  REF.TabRoot.UIGrid:Reposition()
end

function UpdateWidget(go, wrapIndex, realIndex)
end

function SetMoney()
  local allMoney = this:GetData("fci/resource/ResPlayerMoney_0") or 0
  local payMoney = this:GetData("fci/resource/ResPlayerPayMoney_0") or 0
  if REF.GameObjectGiftActivity.gameObject.active then
    local text = WU.GetString("Purchase_PayMoney_Display", payMoney)
    REF.LabelMoneyDesc.UIHtmlLabel.text = text
  else
    local text = WU.GetString("Window_Money_Tip2", allMoney - payMoney, payMoney)
    REF.LabelMoneyDesc.UIHtmlLabel.text = text
  end
end

function UpdateGiftSaku(result)
  if result == nil then
    REF.TabGiftSaku.UIToggle.value = false
    REF.TabGiftSaku.gameObject:SetActive(false)
    return
  end
  REF.TabGiftSaku.gameObject:SetActive(result and IsShow())
  if result == false or not IsShow() then
    REF.GameObjectGiftSaku.gameObject:SetActive(result)
  end
end

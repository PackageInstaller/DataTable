local this = class("moduleActivityPTShopButton", G_UIModuleBase)
local _shopGroupTpl = L_GameTpl:getShopGroupTpl()
local _shopTpl = L_GameTpl:getShopTpl()
local _currencyTpl = L_GameTpl:getCurrencyTpl()

function this.bind()
  return {
    active_lock = false,
    active_unlock = true,
    txt_lock_time = "",
    txt_item_num = "",
    img_item = "",
    txt_name = ""
  }
end

function this.methods()
  return {
    btn_ptshop = function(self)
      if not self.data.isOpen then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_shop_pt_locked"))
        return
      end
      L_UI:open("PagePTShop", {
        actId = self.data.actId,
        isReddot = self.data.isReddot
      })
    end
  }
end

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    actId = 0,
    ptShopId = 0,
    currencyId = 0,
    isOpen = false,
    isReddot = false,
    startTime = 0,
    endTime = 0
  }
end

function this:open()
end

function this:setActData(actId, ptShopId, currencyId)
  self.data.actId = actId
  self.data.ptShopId = ptShopId
  self.data.currencyId = currencyId
  self:refreshView()
  self:refreshRedDot()
end

function this:setPtShopTime(startTime, endTime)
  self.data.startTime = startTime
  self.data.endTime = endTime
  self:refreshView()
end

function this:refreshView()
  local shopGroupTplData = _shopGroupTpl:getTplById(self.data.ptShopId)
  local curShopId = _shopGroupTpl:getShopList(shopGroupTplData)[1]
  local tpl = _shopTpl:getTplById(curShopId)
  local startTime = self.data.startTime
  local endTime = self.data.endTime
  self.data.isOpen = true
  if 0 < startTime and 0 < endTime then
    local serverTime = L_TimeUtil.getServerTime()
    if startTime <= serverTime and endTime >= serverTime then
      self.data.isOpen = true
    else
      self.data.isOpen = false
    end
  end
  self.bind.txt_name = L_Lang:get(_shopGroupTpl:getShopGroupName(shopGroupTplData))
  if self.data.isOpen then
    self.bind.active_lock = false
    self.bind.active_unlock = true
    local num = L_PlayerStore:getActCurrencyNum(self.data.actId, self.data.currencyId)
    self.bind.txt_item_num = tostring(num)
    local tpl = _currencyTpl:getTplById(self.data.currencyId)
    self.bind.img_item = _currencyTpl:getIcon(tpl)
  else
    self.bind.active_lock = true
    self.bind.active_unlock = false
    local startDateTime = L_TimeUtil.getServerTimeOfDateTime(startTime)
    local endDateTime = L_TimeUtil.getServerTimeOfDateTime(endTime)
    self.bind.txt_lock_time = string.format("%s.%s-%s.%s %s", startDateTime.Month, startDateTime.Day, endDateTime.Month, endDateTime.Day, L_WordsTpl:getValue("ui_period_02"))
  end
end

function this:refreshRedDot()
  self.data.isReddot = false
  if self.bindComponents == nil or L_CommonUtil.isValid(self.bindComponents.reddotnew) == false then
    return
  end
  local redDot = false
  local gameEvent = L_GameEventStore:getGameEventData(self.data.actId):getGameEvent()
  if gameEvent ~= nil then
    redDot = gameEvent:getPtShopRedState()
  end
  self.data.isReddot = redDot
  self.bindComponents.reddotnew.gameObject:SetActive(redDot)
end

function this:setReddotState(isReddot)
  self.data.isReddot = isReddot
  self.bindComponents.reddotnew.gameObject:SetActive(isReddot)
end

function this:close()
end

return this

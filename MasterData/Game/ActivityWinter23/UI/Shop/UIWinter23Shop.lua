local base = require("Game.ActivitySummer.Year22.Shop.UIActSum22Shop")
local UIWinter23Shop = class("UIWinter23Shop", base)
local UINCommonActivityBG = require("Game.ActivityFrame.UI.UINCommonActivityBG")
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local cs_ResLoader = CS.ResLoader

function UIWinter23Shop:OnInit()
  base.OnInit(self)
  self._actBgNode = UINCommonActivityBG.New()
  self._actBgNode:Init(self.ui.uI_CommonActivityBG)
  self._resloader = cs_ResLoader.Create()
end

function UIWinter23Shop:__SetNewClassNode()
  self.class_ShopGoodsItem = require("Game.ActivityWinter23.UI.Shop.UINWinter23ShopGoodsItem")
  self.class_ShopPage = require("Game.ActivityWinter23.UI.Shop.UINWinter23ShopPage")
  self.isTimeShotTitle = true
end

function UIWinter23Shop:GetIsRemaster()
  return false
end

function UIWinter23Shop:__SetCoin()
end

function UIWinter23Shop:__CancleCoin()
end

function UIWinter23Shop:__CoinRefresh()
end

function UIWinter23Shop:BindRedShopFunc(func)
  self._redFunc = func
end

function UIWinter23Shop:BindSelectShopFunc(func)
  self._selectFunc = func
end

function UIWinter23Shop:InitSum22ShopByShopList(activityBase, shopList, showToken, callback)
  local singleShowToken, showTokens
  if type(showToken) == "table" then
    singleShowToken = showToken[1]
    showTokens = showToken
  else
    singleShowToken = showToken
    showTokens = {showToken}
  end
  base.InitSum22ShopByShopList(self, activityBase, shopList, singleShowToken, callback)
  UIUtil.RefreshTopResId(showTokens, nil, nil, self)
  if self._redFunc ~= nil then
    local count = #self._shopSelectItemPool.listItem
    for i, v in ipairs(self._shopSelectItemPool.listItem) do
      v:SetWinter23ShopRed(self._redFunc(shopList[i]))
      if i == count then
        v:HideWinter23ShopLine()
      end
    end
  end
  self._actBgNode:InitActivityBG(activityBase:GetActFrameId(), self._resloader)
end

function UIWinter23Shop:__OnSelectShop(shopId, item)
  if self._isReqing then
    return
  end
  base.__OnSelectShop(self, shopId, item)
  local pos = self.ui.obj_Selected.transform.anchoredPosition
  pos.y = item.transform.anchoredPosition.y
  self.ui.obj_Selected.transform.anchoredPosition = pos
  if self._selectFunc ~= nil then
    self._selectFunc(shopId)
  end
  if self._redFunc ~= nil then
    item:SetWinter23ShopRed(false)
  end
end

function UIWinter23Shop:__RefreShopTitle()
  if self._shopData.shopCfg.is_recommended then
    self.ui.img_top.color = self.ui.color_recommend
  else
    self.ui.img_top.color = self.ui.color_normal
  end
  self.ui.tex_TitleName.text = self._shopData.shopName
end

function UIWinter23Shop:__RefreshTime()
  if (self._expireTime or 0) == 0 then
    self._expireTime = self._activityBase:GetActivityDestroyTime()
    local date = TimeUtil:TimestampToDate(self._expireTime, false, true)
    self.ui.tex_Time.text = string.format("%02d/%02d %02d:%02d", date.month, date.day, date.hour, date.min)
  end
  local timeStr, time = ActivityFrameUtil.GetCountdownTimeStr(self._expireTime, self.isTimeShotTitle)
  if time <= 0 and self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  self.ui.tex_countdown.text = timeStr
end

function UIWinter23Shop:__RefreShopTitle()
  if self._shopData.shopCfg.is_recommended then
    self.ui.img_top.color = self.ui.color_recommend
    self.ui.tex_TitleName:SetIndex(0)
  else
    self.ui.img_top.color = self.ui.color_normal
    self.ui.tex_TitleName:SetIndex(1, self._shopData.shopName)
  end
end

function UIWinter23Shop:OnDelete()
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  base.OnDelete(self)
end

return UIWinter23Shop

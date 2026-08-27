local UINHomeBanner = class("UICarouselBanner", UIBaseNode)
local base = UIBaseNode
local ImgSelectWidth = 22
local CS_EventTriggerListener = CS.EventTriggerListener
local HomeBannerManager = require("Game.Home.Banner.HomeBannerManager")
local UINHomeBannerLoopList = require("Game.Home.Banner.UINHomeBannerLoopList")
local UINHomeBannerIndexItem = require("Game.Home.Banner.UINHomeBannerIndexItem")

function UINHomeBanner:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.bannerLoopList = UINHomeBannerLoopList.New()
  self.bannerLoopList:Init(self.ui.obj_advList)
  self.bannerLoopList:SetPointerExitSucChecker(function()
    return self.__onPointerCornerStaty == false and UIManager:GetWindow(UIWindowTypeID.BannerSpread) == nil
  end)
  self.__OnPageIndexChanged = BindCallback(self, self.OnPageIndexChanged)
  self.bannerSelectWidth = self.ui.float_bannerSelectWidth or ImgSelectWidth
  UIUtil.AddButtonListener(self.ui.btn_OpenList, self, self.__OnCornerClick)
  self.__HomeBannerIndexItemPool = UIItemPool.New(UINHomeBannerIndexItem, self.ui.obj_indexItem)
  self.ui.obj_indexItem:SetActive(false)
  self.__cornerEventTrigger = CS_EventTriggerListener.Get(self.ui.btn_OpenList)
  TimerManager:StopTimer(self.__cornerPointerExitDelayCheckTimerId)
  self.__cornerPointerExitDelayCheckTimerId = TimerManager:StartTimer(1.5, function()
    if self.bannerLoopList.__isAutoPlay == false and self.bannerLoopList.__onPointerStaty == false and UIManager:GetWindow(UIWindowTypeID.BannerSpread) == nil then
      self.bannerLoopList.__isAutoPlay = true
    end
    TimerManager:PauseTimer(self.__cornerPointerExitDelayCheckTimerId)
  end, self)
  TimerManager:PauseTimer(self.__cornerPointerExitDelayCheckTimerId)
end

function UINHomeBanner:OnShow()
  self.__cornerEventTrigger:onEnter("+", BindCallback(self, self.__OnCornerPointerEnter))
  self.__cornerEventTrigger:onExit("+", BindCallback(self, self.__OnCornerPointerExit))
  self.__onPointerCornerStaty = false
  base.OnShow()
end

function UINHomeBanner:InitialHomeBanner(bannerDataList, oldDataId)
  self.bannerDataList = bannerDataList
  self.pageCount = #bannerDataList
  self.curPageNum = 1
  if self.IndexItems ~= nil then
    for iPageIndex, _ in pairs(self.IndexItems) do
      self:SetPageIndexColor(iPageIndex, 1)
    end
  end
  self.__HomeBannerIndexItemPool:HideAll()
  self.ui.indexItemParent.gameObject:SetActive(true)
  self.IndexItems = {}
  for iIndex = 1, self.pageCount do
    local indexItem = self.__HomeBannerIndexItemPool:GetOne()
    self.IndexItems[iIndex] = indexItem
    indexItem:Show()
  end
  self:SetPageIndexColor(self.curPageNum, 2)
  local initIndex
  for index, value in ipairs(bannerDataList) do
    if value.id == oldDataId then
      initIndex = index
      break
    end
  end
  if initIndex == nil then
    initIndex = 1
  end
  self.bannerLoopList:SetLoopBannerDataList(bannerDataList, initIndex, self.__OnPageIndexChanged)
  self.bannerLoopList:SetInterval(self.bannerDataList[initIndex].delay)
end

function UINHomeBanner:SetPageIndexColor(pageIndex, colorIndex)
  self.IndexItems[pageIndex]:SetBannerIndexItemColor(self.ui.col_IndexItem[colorIndex])
end

function UINHomeBanner:RefreshAllBannerData()
  HomeBannerManager:RefreshBannerDataList(function(bannerDataList)
    if bannerDataList ~= nil and 0 < #bannerDataList then
      local oldCurDataId = self.bannerDataList[self.curPageNum].id
      self:InitialHomeBanner(bannerDataList, oldCurDataId)
      self:Show()
    else
      self:Hide()
    end
  end)
end

function UINHomeBanner:OnPageIndexChanged(pageIndex)
  self:SetPageIndexColor(self.curPageNum, 1)
  local page = pageIndex
  self.curPageNum = page
  self:SetPageIndexColor(self.curPageNum, 2)
  self.ui.trans_indexItem.anchoredPosition3D = Vector3.New(self.bannerSelectWidth * (self.curPageNum - 1))
  self.bannerLoopList:SetInterval(self.bannerDataList[self.curPageNum].delay)
  if self.bannerDataList[self.curPageNum]:GetBannerIsOutOfData() or self.bannerDataList[self.curPageNum]:GetIsLotteryOrShopItemClosed() then
    self:RefreshAllBannerData()
  end
  self:__UpdateBannerLeftTime()
  self:__UpdateBannerDurationTime()
end

function UINHomeBanner:__UpdateBannerLeftTime()
  if not self.bannerDataList[self.curPageNum]:GetBannerIsShowLeftTime() then
    self.ui.obj_Time.gameObject:SetActive(false)
    return
  end
  self.ui.obj_Time.gameObject:SetActive(true)
  local d, h, m, s = TimeUtil:TimestampToTimeInter(self.bannerDataList[self.curPageNum]:GetBannerLeftTime(), nil, true)
  if 0 < d then
    self.ui.tex_Time:SetIndex(0, tostring(d))
  elseif 0 < h then
    self.ui.tex_Time:SetIndex(1, tostring(h))
  else
    self.ui.tex_Time:SetIndex(2, tostring(m))
  end
end

function UINHomeBanner:__UpdateBannerDurationTime()
  local startTime, endTime = self.bannerDataList[self.curPageNum]:GetStartAndEndTime()
  self.ui.tex_AdvContent:SetIndex(0, startTime, endTime)
end

function UINHomeBanner:__OnCornerClick()
  local win = UIManager:ShowWindowAsync(UIWindowTypeID.BannerSpread, function(win)
    win:SetSpreadBannerProperty(self.bannerLoopList, self.bannerDataList)
  end)
  self:Hide()
end

function UINHomeBanner:__OnCornerPointerEnter()
  self.__onPointerCornerStaty = true
  self.bannerLoopList.__isAutoPlay = false
end

function UINHomeBanner:__OnCornerPointerExit()
  self.__onPointerCornerStaty = false
  if self.__cornerPointerExitDelayCheckTimerId ~= nil then
    TimerManager:ResetTimer(self.__cornerPointerExitDelayCheckTimerId)
    TimerManager:ResumeTimer(self.__cornerPointerExitDelayCheckTimerId)
  end
end

function UINHomeBanner:OnHide()
  self.__cornerEventTrigger:onEnter("-", BindCallback(self, self.__OnCornerPointerEnter))
  self.__cornerEventTrigger:onExit("-", BindCallback(self, self.__OnCornerPointerExit))
  base.OnHide()
end

function UINHomeBanner:OnDelete()
  self.bannerLoopList:Delete()
  TimerManager:StopTimer(self.__cornerPointerExitDelayCheckTimerId)
  self.__cornerPointerExitDelayCheckTimerId = nil
  if self.IndexItems ~= nil then
    for _, indexItem in pairs(self.IndexItems) do
      indexItem:Delete()
    end
  end
  base.OnDelete(self)
end

return UINHomeBanner

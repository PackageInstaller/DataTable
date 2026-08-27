local UICarouselContainer = class("UICarouselBanner", UIBaseNode)
local base = UIBaseNode
local ContainerData = require("Game.CommonUI.Container.Model.ContainerData")
local UIPictureItem = require("Game.CommonUI.Container.UI.UIPictureItem")
local ImgSelectWidth = 33

function UICarouselContainer:OnInit()
end

function UICarouselContainer:InitialWithData(dataList, bannerList, uiPictureIns, resLoader, selectWidth)
  self.containerDataList = dataList
  self.pageCount = #dataList
  self.bannerList = bannerList
  if self.picItemPool == nil then
    self.picItemPool = UIItemPool.New(UIPictureItem, uiPictureIns)
  end
  self.bannerList:onPageIndexChanged("+", BindCallback(self, self.OnPageIndexChanged))
  self.curPageNum = 1
  self.resLoader = resLoader
  self.selectWidth = selectWidth
  if ConfigData.game_config.BannerAutoDragInterval ~= nil then
    bannerList:SetInterval(ConfigData.game_config.BannerAutoDragInterval)
  end
  self:InitSelectUI()
  self:__InitPic()
end

function UICarouselContainer:InjectSelectObj(selectCountTrans, selectTrans, bannerSelectWidth)
  self.selectCountTrans = selectCountTrans
  self.selectTrans = selectTrans
  self.bannerSelectWidth = bannerSelectWidth
end

function UICarouselContainer:InitSelectUI()
  local width = self.bannerSelectWidth * self.pageCount
  self.selectCountTrans.anchoredPosition3D = Vector3.New(-width / 2, self.selectCountTrans.anchoredPosition3D.y, self.selectCountTrans.anchoredPosition3D.z)
  self.selectCountTrans.sizeDelta = Vector3.New(width, self.selectCountTrans.sizeDelta.y)
  self.selectTrans.anchoredPosition3D = Vector3.New(self.bannerSelectWidth * (self.curPageNum - 1))
end

function UICarouselContainer:__InitPic()
  if self.pageCount <= 0 then
    return
  end
  if self.resLoader == nil then
    return
  end
  self.picItemPool:HideAll()
  for index = 1, self.pageCount do
    local picData = self.containerDataList[index]
    local resPath = PathConsts:GetBannerPicPath(picData.imgPath)
    local picItem = self.picItemPool:GetOne()
    picItem:InitPictureItem(index, resPath, self.resLoader, picData.urlValue)
  end
  self.bannerList:InitPosList()
  self:OnPageIndexChanged(0)
end

function UICarouselContainer:OnPageIndexChanged(pageIndex)
  local page = pageIndex + 1
  self.curPageNum = page
  self.selectTrans.anchoredPosition3D = Vector3.New(self.bannerSelectWidth * (self.curPageNum - 1))
end

function UICarouselContainer:EnterCurrentPage()
  self.bannerList:SetPageIndex(self.curPageNum - 1)
end

function UICarouselContainer:OnDelete()
  base.OnDelete(self)
end

return UICarouselContainer

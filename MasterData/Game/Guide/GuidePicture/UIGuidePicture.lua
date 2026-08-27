local UIGuidePicture = class("UIGuidePicture", UIBaseWindow)
local base = UIBaseWindow
local UIGuidePictureItem = require("Game.Guide.GuidePicture.UIGuidePictureItem")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")

function UIGuidePicture:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.tips)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnBtnCloseClicked)
  UIUtil.AddButtonListener(self.ui.btn_Last, self, self.OnLastPageClicked)
  UIUtil.AddButtonListener(self.ui.btn_Next, self, self.OnNextPageClicked)
  self.ui.picItem:SetActive(false)
  self.picItemPool = UIItemPool.New(UIGuidePictureItem, self.ui.picItem)
  self.__OnPageIndexChanged = BindCallback(self, self.OnPageIndexChanged)
  self.ui.picList:onPageIndexChanged("+", self.__OnPageIndexChanged)
  self._pointWidthUnit = self.ui.tran_TotalPoint.rect.width
  self._pointHeightUnit = self.ui.tran_TotalPoint.rect.height
end

function UIGuidePicture:InitGuidePicture(guideType, completeAction, finishShowClose)
  local tipsCfg = ConfigData.tips[guideType]
  if tipsCfg == nil then
    error("can't read tipsCfg with guideType:" .. tostring(guideType))
    if completeAction ~= nil then
      completeAction()
    end
    self:Delete()
    return
  end
  self.completeAction = completeAction
  self.__finishShowClose = finishShowClose or false
  self.pageCount = #tipsCfg.content
  self.curPageNum = 1
  local canScroll = self.pageCount > 1
  self.ui.count:SetActive(canScroll)
  self.ui.scroll_picList.horizontal = canScroll
  if self.__finishShowClose then
    self.ui.btn_Close.gameObject:SetActive(false)
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
  end
  self.resloader = CS.ResLoader.Create()
  self.picItemPool:HideAll()
  for index, contentName in ipairs(tipsCfg.content) do
    local resPath = PathConsts:GetGuideTipsPath(tipsCfg.path, contentName)
    local picItem = self.picItemPool:GetOne()
    picItem:InitPictureItem(index, resPath, self.resloader)
  end
  self.ui.picList:InitPosList()
  self:OnPageIndexChanged(0)
  self:_InitPagePointUI(0)
end

function UIGuidePicture:__TryShowCloseButton()
  if self.curPageNum >= self.pageCount and self.__finishShowClose then
    self.__finishShowClose = false
    self.ui.btn_Close.gameObject:SetActive(true)
  end
end

function UIGuidePicture:OnPageIndexChanged(pageIndex)
  local page = pageIndex + 1
  self.curPageNum = page
  self.ui.btn_Last.gameObject:SetActive(1 < page)
  self.ui.btn_Next.gameObject:SetActive(page < self.pageCount)
  self.ui.tex_Page:SetIndex(0, tostring(page), tostring(self.pageCount))
  self:RefreshPagePointUI(pageIndex)
  self:__TryShowCloseButton()
end

function UIGuidePicture:EnterCurrentGuidePage()
  self.ui.picList:SetPageIndex(self.curPageNum - 1)
end

function UIGuidePicture:BackAction()
  if self.completeAction ~= nil then
    self.completeAction()
  end
  self:Delete()
end

function UIGuidePicture:OnBtnCloseClicked()
  UIUtil.OnClickBackByUiTab(self)
end

function UIGuidePicture:OnLastPageClicked()
  if self.curPageNum <= 1 then
    return
  end
  self.curPageNum = self.curPageNum - 1
  self:EnterCurrentGuidePage()
end

function UIGuidePicture:OnNextPageClicked()
  if self.curPageNum >= self.pageCount then
    return
  end
  self.curPageNum = self.curPageNum + 1
  self:EnterCurrentGuidePage()
  self:__TryShowCloseButton()
end

function UIGuidePicture:_InitPagePointUI(pageIndex)
  local totalWidth = self._pointWidthUnit * self.pageCount
  self.ui.tran_TotalPoint.sizeDelta = Vector2.New(totalWidth, self._pointHeightUnit)
  self:RefreshPagePointUI(pageIndex)
end

function UIGuidePicture:RefreshPagePointUI(pageIndex)
  local moveX = pageIndex * self._pointWidthUnit
  self.ui.img_CurPoint.anchoredPosition = Vector2.New(moveX, 0, 0)
end

function UIGuidePicture:OnDelete()
  self.ui.picList:onPageIndexChanged("-", self.__OnPageIndexChanged)
  ConfigData:ReleaseDynCfg(eDynConfigData.tips)
  base.OnDelete(self)
end

function UIGuidePicture:OnDeleteEntity()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDeleteEntity(self)
end

return UIGuidePicture

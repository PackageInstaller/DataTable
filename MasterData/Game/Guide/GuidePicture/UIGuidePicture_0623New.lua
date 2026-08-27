local UIGuidePicture_0623New = class("UIGuidePicture_0623New", UIBaseWindow)
local base = UIBaseWindow
local UINGuidePicture_0623NewItem = require("Game.Guide.GuidePicture.UINGuidePicture_0623NewItem")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local cs_MovieManager = CS.MovieManager.Instance

function UIGuidePicture_0623New:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.guide_describe)
  ConfigData:LoadDynCfg(eDynConfigData.tips)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnBtnCloseClicked)
  UIUtil.AddButtonListener(self.ui.btn_Last, self, self.OnLastPageClicked)
  UIUtil.AddButtonListener(self.ui.btn_Next, self, self.OnNextPageClicked)
  self.ui.picItem:SetActive(false)
  self.picItemPool = UIItemPool.New(UINGuidePicture_0623NewItem, self.ui.picItem)
  self.__OnPageIndexChanged = BindCallback(self, self.OnPageIndexChanged)
  self.ui.picList:onPageIndexChanged("+", self.__OnPageIndexChanged)
  self._pointWidthUnit = self.ui.tran_TotalPoint.rect.width
  self._pointHeightUnit = self.ui.tran_TotalPoint.rect.height
end

function UIGuidePicture_0623New:InitGuidePicture_New(guideType, completeAction, finishShowClose)
  local tipsCfg = ConfigData.tips[guideType]
  local tipsDesCfg = ConfigData.guide_describe[guideType]
  if tipsCfg == nil or tipsDesCfg == nil then
    error("can't read tips with guideType:" .. tostring(guideType))
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
  self._tipsCfg = tipsCfg
  local canScroll = self.pageCount > 1
  self.ui.count:SetActive(canScroll)
  self.ui.scroll_picList.horizontal = false
  if self.__finishShowClose then
    self.ui.btn_Close.gameObject:SetActive(false)
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
  end
  self.resloader = CS.ResLoader.Create()
  self.picItemPool:HideAll()
  for index, contentName in ipairs(tipsCfg.content) do
    local picItem = self.picItemPool:GetOne()
    local deslist = tipsDesCfg[index]
    local title = tipsCfg.title[index]
    if self._tipsCfg.guide_vedio then
      picItem:InitPictureItemBase(deslist, index, title)
    else
      local resPath = PathConsts:GetGuideTipsPath(tipsCfg.path, contentName)
      picItem:InitPictureItem(deslist, index, title, resPath, self.resloader)
    end
  end
  self.ui.picList:InitPosList()
  self:OnPageIndexChanged(0)
  self:_InitPagePointUI(0)
end

function UIGuidePicture_0623New:__TryShowCloseButton()
  if self.curPageNum >= self.pageCount and self.__finishShowClose then
    self.__finishShowClose = false
    self.ui.btn_Close.gameObject:SetActive(true)
  end
end

function UIGuidePicture_0623New:OnPageIndexChanged(pageIndex)
  local page = pageIndex + 1
  if self._prefPage == page then
    return
  end
  self._prefPage = page
  self.curPageNum = page
  self.ui.btn_Last.gameObject:SetActive(1 < page)
  self.ui.btn_Next.gameObject:SetActive(page < self.pageCount)
  self.ui.tex_Page:SetIndex(0, tostring(page), tostring(self.pageCount))
  self:RefreshPagePointUI(pageIndex)
  self:__TryShowCloseButton()
  if self._tipsCfg.guide_vedio then
    if self.moviePlayer ~= nil then
      cs_MovieManager:ReturnMoviePlayer(self.moviePlayer)
    end
    self.moviePlayer = cs_MovieManager:GetMoviePlayer()
    local picItem = self.picItemPool.listItem[page]
    if picItem ~= nil then
      local content = self._tipsCfg.content[page]
      local vedioPath = PathConsts:GetGuideVideoPath(self._tipsCfg.path, content)
      picItem:PlayGuideVedio(vedioPath, self.moviePlayer)
    end
  end
end

function UIGuidePicture_0623New:EnterCurrentGuidePage()
  self.ui.picList:SetPageIndex(self.curPageNum - 1)
end

function UIGuidePicture_0623New:BackAction()
  if self.completeAction ~= nil then
    self.completeAction()
  end
  self:Delete()
end

function UIGuidePicture_0623New:OnBtnCloseClicked()
  UIUtil.OnClickBackByUiTab(self)
end

function UIGuidePicture_0623New:OnLastPageClicked()
  if self.curPageNum <= 1 then
    return
  end
  self.curPageNum = self.curPageNum - 1
  self:EnterCurrentGuidePage()
end

function UIGuidePicture_0623New:OnNextPageClicked()
  if self.curPageNum >= self.pageCount then
    return
  end
  self.curPageNum = self.curPageNum + 1
  self:EnterCurrentGuidePage()
  self:__TryShowCloseButton()
end

function UIGuidePicture_0623New:_InitPagePointUI(pageIndex)
  local totalWidth = self._pointWidthUnit * self.pageCount
  self.ui.tran_TotalPoint.sizeDelta = Vector2.New(totalWidth, self._pointHeightUnit)
  self:RefreshPagePointUI(pageIndex)
end

function UIGuidePicture_0623New:RefreshPagePointUI(pageIndex)
  local moveX = pageIndex * self._pointWidthUnit
  self.ui.img_CurPoint.anchoredPosition = Vector2.New(moveX, 0, 0)
end

function UIGuidePicture_0623New:OnDelete()
  self.ui.picList:onPageIndexChanged("-", self.__OnPageIndexChanged)
  ConfigData:ReleaseDynCfg(eDynConfigData.guide_describe)
  ConfigData:ReleaseDynCfg(eDynConfigData.tips)
  base.OnDelete(self)
end

function UIGuidePicture_0623New:OnDeleteEntity()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.moviePlayer ~= nil then
    cs_MovieManager:ReturnMoviePlayer(self.moviePlayer)
    self.moviePlayer = nil
  end
  base.OnDeleteEntity(self)
end

return UIGuidePicture_0623New

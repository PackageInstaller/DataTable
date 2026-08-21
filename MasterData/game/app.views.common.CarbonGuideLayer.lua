local battleGuideRes = "battle_guide/"
local carbonGuildResPath = "ui/carbon/carbonGuide"
local uiData = {
  csbFile = "ui/carbon/CarbonGuideLayer.csb",
  mask = true,
  order = NEW_GUIDE_LAYER_ORDER,
  widgets = {
    leftBtn = "leftBtn",
    rightBtn = "rightBtn",
    pageView = "clipping/pageView",
    index = "index"
  }
}
local CarbonGuideLayer = class("CarbonGuideLayer", UIBase)

function CarbonGuideLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function CarbonGuideLayer:init(params)
  self.imgs = params.guidePic:toArray(" ")
  self.curPage = 1
  for i = 1, #self.imgs do
    self.pageView:addPage(UIHelper.newImageView(battleGuideRes .. self.imgs[i] .. ".png"))
  end
  self.pageView:setCurrentPageIndex(self.curPage - 1)
  self.pageView:setTouchEnabled(false)
  self.leftBtn:setCallback(function()
    local toPageIdx = self.pageView:getCurrentPageIndex() - 1
    if toPageIdx < 0 then
      toPageIdx = 0
    end
    self.pageView:scrollToPage(toPageIdx)
    self.curPage = toPageIdx + 1
    self:initBtn()
  end)
  self:initBtn()
end

function CarbonGuideLayer:initBtn()
  if self.curPage == 1 then
    self.leftBtn:setVisible(false)
  else
    self.leftBtn:setVisible(true)
  end
  if self.curPage == #self.imgs then
    self.rightBtn:setImages(carbonGuildResPath, {"btn_3.png", "btn_3.png"})
    self.rightBtn:setCallback(function()
      self:close()
    end)
  else
    self.rightBtn:setImages(carbonGuildResPath, {"btn_2.png", "btn_2.png"})
    self.rightBtn:setCallback(function()
      local toPageIdx = self.pageView:getCurrentPageIndex() + 1
      if toPageIdx >= #self.pageView:getItems() then
        toPageIdx = #self.pageView:getItems() - 1
      end
      self.pageView:scrollToPage(toPageIdx)
      self.curPage = toPageIdx + 1
      self:initBtn()
    end)
  end
  self.index:removeAllChildren()
  local interval = 15
  local centerIdx = (#self.imgs + 1) / 2
  for i = 1, #self.imgs do
    local imgPath = carbonGuildResPath .. "/"
    if i == self.curPage then
      imgPath = imgPath .. "point_2.png"
    else
      imgPath = imgPath .. "point_1.png"
    end
    UIHelper.newImageView(imgPath):anch(0.5, 0.5):pos(interval * (i - centerIdx), 0):addTo(self.index)
  end
end

function CarbonGuideLayer:showData(params)
end

return CarbonGuideLayer

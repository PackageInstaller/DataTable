local RouGeMainRes = "ui/rouge/main/"
local uiData = {
  csbFile = "ui/rouge/RouGeDialog.csb",
  mask = true,
  popup = true,
  maskClick = false,
  widgets = {
    infoBg = "infoBg",
    titleBg = "infoBg/titleBg",
    levelNode = "infoBg/levelNode",
    content = "infoBg/content",
    tipText = "infoBg/tipText",
    selectBg = "infoBg/tipText/selectBg",
    cancelBtn = "infoBg/cancelBtn",
    okBtn = "infoBg/okBtn"
  }
}
local RouGeDialog = class("RouGeDialog", UIBase)

function RouGeDialog:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function RouGeDialog:init(params)
  game:playMusic(1022)
  display.newTTFLabel({
    text = params.data.title,
    size = 24,
    color = UIHelper.hex2rgb("#ffffff")
  }):center(self.titleBg):addTo(self.titleBg)
  local level = params.data.passiveLevel or 1
  local xPos, interval = (level - 1) / 2 * -30, 30
  for index = 1, level do
    display.newSprite(RouGeMainRes .. "levelIcon.png"):pos(xPos + (index - 1) * interval, 0):addTo(self.levelNode)
  end
  local text1 = string.format("<div color=#ffffff>确定花费</div><img src='ui/global/icon_pz1.png' scale=0.5 /><div>x%d 刷新 </div><div color=#daa520>%s</div>", globalCsv.RouGeRefreshPrice, params.data.title)
  local text2 = string.format("<div color=#ffffff>确定花费</div><img src='ui/global/icon_pz1.png' scale=0.5 /><div>x%d 购买 </div><div color=#daa520>%s</div>", params.data.cost, params.data.title)
  local text = params.showRefresh and text1 or params.showBuy and text2 or ""
  local richText = MRichText.new({text = text, size = 22})
  richText:anch(0.5, 0.5):center(self.content):addTo(self.content)
  local selected = 1
  self.selectBg:setCallback(function()
    if params.showRefresh then
      self.selectBg:removeAllChildren()
      selected = selected % 2 + 1
      if selected == 2 then
        display.newSprite(RouGeMainRes .. "yes.png"):center(self.selectBg):addTo(self.selectBg)
        UserData.rougeRefreshSkipTime = CommonHelper.date(nil, "Ymd", true)
      else
        UserData.rougeRefreshSkipTime = nil
      end
    end
    if params.showBuy then
      self.selectBg:removeAllChildren()
      selected = selected % 2 + 1
      if selected == 2 then
        display.newSprite(RouGeMainRes .. "yes.png"):center(self.selectBg):addTo(self.selectBg)
        UserData.rougeBuySkipTime = CommonHelper.date(nil, "Ymd", true)
      else
        UserData.rougeBuySkipTime = nil
      end
    end
  end)
  self.cancelBtn:setCallback(function()
    if params.cancelCallback then
      params.cancelCallback()
      self:close()
    end
  end)
  self.okBtn:setCallback(function()
    if params.okCallback then
      params.okCallback()
      self:close()
    end
  end)
end

return RouGeDialog

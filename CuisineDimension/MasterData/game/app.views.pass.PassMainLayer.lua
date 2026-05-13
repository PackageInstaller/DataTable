local PassLayer = require("app.views.pass.PassLayer")
local DiamondFundLayer = require("app.views.pass.DiamondFundLayer")
local RouGeAwardLayer = require("app.views.pass.RouGeAwardLayer")
local passMainRes = "ui/pass/main/"
local uiData = {
  csbFile = "ui/pass/PassMainLayer.csb",
  mask = true,
  widgets = {
    content = "content",
    bg = "content/bg",
    passNode = "content/passLayer",
    diamondNode = "content/diamondLayer",
    rougeNode = "content/rougeLayer",
    btnList = "btnList"
  }
}
local btnsData = {
  [1] = {
    index = 1,
    nodeName = "passNode",
    name = TongXingZhengName,
    func = function(self)
      PassLayer:initView(self)
    end,
    closeFunc = function(self)
      PassLayer:closeTimerHandler()
    end
  },
  [2] = {
    index = 2,
    nodeName = "diamondNode",
    name = "冒险基金",
    func = function(self)
      DiamondFundLayer:initView(self)
    end,
    closeFunc = function(self)
      DiamondFundLayer:closeTimerHandler()
    end
  },
  [3] = {
    index = 3,
    nodeName = "rougeNode",
    name = "混沌塔之旅",
    func = function(self)
      RouGeAwardLayer:initView(self)
    end,
    closeFunc = function(self)
      RouGeAwardLayer:closeTimerHandler()
    end
  }
}
local PassMainLayer = class("PassMainLayer", UIBase)

function PassMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function PassMainLayer:init(params)
  TopBar:show(TopBarType.back)
  TopBar:showAnimation(true)
  game:playMusic(31)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.bg, true)
    self.btnList:setPositionX(self.btnList:getPositionX() + UIHelper.getMoveXForX())
  end
  self.selectIndex = params.select or 1
  self:initLeftList()
end

function PassMainLayer:selectOnce(index)
  if not btnsData[index] then
    return
  end
  for _, data in ipairs(btnsData) do
    if data.index ~= index then
      data.closeFunc(self)
      self[data.nodeName]:removeAllChildren()
    end
  end
  btnsData[index].func(self)
end

function PassMainLayer:initLeftList()
  self.btnList:setDirection(1)
  local group = MRadioGroup:create({
    chooseCb = function(sender)
      local text = sender:getChildByName("name")
      local bg = sender:getChildByName("btnBg")
      bg:setOpacity(255)
      text:setTextColor(UIHelper.hex2rgb("#262626"))
    end,
    unchooseCb = function(sender)
      local text = sender:getChildByName("name")
      local bg = sender:getChildByName("btnBg")
      bg:setOpacity(1)
      text:setTextColor(UIHelper.hex2rgb("#999999"))
    end
  })
  for index, data in ipairs(btnsData) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(150, 64)):addTo(self.btnList)
    local btn = UIHelper.extend(ccui.Button:create()):opacity(0.001)
    btn:setImages(passMainRes, {
      "list_btn_bg.png",
      "list_btn_bg.png"
    })
    btn:center(viewNode):addTo(viewNode):name("btn" .. index)
    display.newSprite(passMainRes .. "list_btn_bg.png"):center(btn):addTo(btn):name("btnBg")
    local name = display.newTTFLabel({
      text = data.name,
      size = 22
    }):center(btn):addTo(btn):name("name")
    UIHelper.setMaxWidth(name, 147)
    btn:setGroup(group)
    if not self.selectIndex then
      self.selectIndex = index
    end
    btn:setCallback(function()
      if self.selectIndex == data.index then
        return
      end
      self.selectIndex = index
      self:selectOnce(self.selectIndex)
    end)
  end
  if self.selectIndex then
    group:chooseByName("btn" .. self.selectIndex)
  end
  self:selectOnce(self.selectIndex)
  self.btnList:doLayout()
end

function PassMainLayer:onExit()
  if DiamondFundLayer.timerHandler then
    scheduler.unscheduleGlobal(DiamondFundLayer.timerHandler)
  end
  if PassLayer.timerHandler then
    scheduler.unscheduleGlobal(PassLayer.timerHandler)
  end
  if RouGeAwardLayer.timerHandler then
    scheduler.unscheduleGlobal(RouGeAwardLayer.timerHandler)
  end
end

return PassMainLayer

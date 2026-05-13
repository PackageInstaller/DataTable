local SupportCsv = require("csvdata.support")
local HeroRes = "ui/hero/"
local QuestionRes = "ui/talk/question/"
local globalRes = "ui/global/"
local battleGuideRes = "battle_guide/"
local carbonGuildResPath = "ui/carbon/carbonGuide"
local uiData = {
  csbFile = "ui/talk/QuestionLayer.csb",
  mask = true,
  widgets = {
    mainBg = "mainBg",
    leftBg = "leftBg",
    up = "up",
    btnBar = "btnBar",
    blackboard = "blackboard",
    type1 = "blackboard/type1",
    body = "blackboard/type1/body",
    questionNode = "blackboard/type1/questionNode",
    answerNode = "blackboard/type1/answerNode",
    type2 = "blackboard/type2",
    btnBar2 = "blackboard/type2/btnBar2",
    leftBtn = "blackboard/type2/leftBtn",
    rightBtn = "blackboard/type2/rightBtn",
    pageView = "blackboard/type2/clipping/pageView",
    index = "blackboard/type2/index"
  }
}
local QuestionLayer = class("QuestionLayer", UIBase)

function QuestionLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function QuestionLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
    self.leftBg:setPositionX(self.leftBg:getPositionX() - 75)
  end
  TopBar:show(TopBarType.full, "薇琪课堂")
  TopBar:showAnimation(true)
  self.blackboard:setCascadeOpacityEnabled(true)
  UIHelper.MoveToDown({
    node = self.up
  })
  UIHelper.MoveToUp({
    node = self.blackboard,
    ease = true
  })
  self.group = MRadioGroup:create()
  local btnSize = UIHelper.newImageView(HeroRes .. "taocan_1.png"):getContentSize()
  for index, data in ipairs(SupportCsv) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(btnSize):addTo(self.btnBar)
    local btn = UIHelper.extend(ccui.Button:create()):center(viewNode):addTo(viewNode)
    btn:setImages(HeroRes, {
      "taocan_1.png",
      "taocan_2.png"
    })
    btn:setName("btn" .. index)
    btn:setGroup(self.group)
    btn:setCallback(function()
      self.selected = index
      self:showData()
    end)
    local label = display.newTTFLabel({
      text = data[1].name1,
      size = 22
    }):pos(58, 25):addTo(btn):enableOutline(UIHelper.hex2rgb("#630c07"), 1)
    UIHelper.setMaxWidth(label, 100)
    UIHelper.MoveToRight({
      node = btn,
      delay = (index - 1) * 0.1,
      time = 0.2
    })
  end
  self.selected = params.selected or 1
end

function QuestionLayer:showData()
  self.group:chooseByName("btn" .. self.selected)
  self.questionNode:removeAllChildren()
  self.btnBar2:removeAllChildren()
  local QASet = SupportCsv[self.selected]
  if QASet[1].type == 1 then
    self.type1:setVisible(true)
    self.type2:setVisible(false)
    local group = MRadioGroup:create({
      chooseCb = function(sender)
        sender:setTitleColor(UIHelper.hex2rgb("#ffffff"))
      end,
      unchooseCb = function(sender)
        sender:setTitleColor(UIHelper.hex2rgb("#80a880"))
      end
    })
    local xPos, yPos, interval = 118, -2, 180
    for index, data in ipairs(QASet) do
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(QuestionRes, {"frame.png", "frame.png"})
      btn:setString({
        text = data.name2,
        size = 26,
        color = UIHelper.hex2rgb("#80a880")
      })
      btn:setName("btn" .. index)
      btn:setGroup(group)
      btn:pos(xPos, yPos):addTo(self.questionNode)
      btn:setCallback(function()
        self:showAnswer(group, data)
      end)
      xPos = xPos + interval
      if index == 5 then
        xPos = 123
        yPos = yPos - 70
      end
    end
    self:showAnswer(group, QASet[1])
  elseif QASet[1].type == 2 then
    self.type1:setVisible(false)
    self.type2:setVisible(true)
    local group = MRadioGroup:create({
      chooseCb = function(sender)
        sender:setTitleColor(UIHelper.hex2rgb("#c24b16"))
      end,
      unchooseCb = function(sender)
        sender:setTitleColor(UIHelper.hex2rgb("#7f6969"))
      end
    })
    local btnSize = UIHelper.newImageView(QuestionRes .. "noClick.png"):getContentSize()
    for index, data in ipairs(QASet) do
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(btnSize):addTo(self.btnBar2)
      local btn = UIHelper.extend(ccui.Button:create()):center(viewNode):addTo(viewNode)
      btn:setImages(QuestionRes, {
        "noClick.png",
        "click.png"
      })
      btn:setString({
        text = data.name2,
        size = 26,
        color = UIHelper.hex2rgb("#7f6969")
      })
      btn:setName("btn" .. index)
      btn:setGroup(group)
      btn:setCallback(function()
        self:showType2(group, data)
      end)
      UIHelper.MoveToRight({
        node = btn,
        delay = (index - 1) * 0.1,
        time = 0.1
      })
    end
    self.btnBar2:runAction(transition.sequence({
      cc.DelayTime:create(0.1),
      cc.CallFunc:create(function()
        self.btnBar2:jumpToTop()
      end)
    }))
    self:showType2(group, QASet[1])
    self.btnBar2:requestDoLayout()
  end
end

function QuestionLayer:showType2(group, answer)
  group:chooseByName("btn" .. answer.index2)
  self.pageView:removeAllChildren()
  self.imgs = answer.desc:toArray(" ")
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
  self.rightBtn:setCallback(function()
    local toPageIdx = self.pageView:getCurrentPageIndex() + 1
    if toPageIdx >= #self.pageView:getItems() then
      toPageIdx = #self.pageView:getItems() - 1
    end
    self.pageView:scrollToPage(toPageIdx)
    self.curPage = toPageIdx + 1
    self:initBtn()
  end)
  self:initBtn()
end

function QuestionLayer:initBtn()
  if self.curPage == 1 then
    self.leftBtn:setVisible(false)
  else
    self.leftBtn:setVisible(true)
  end
  if self.curPage == #self.imgs then
    self.rightBtn:setVisible(false)
  else
    self.rightBtn:setVisible(true)
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

function QuestionLayer:showAnswer(group, answer)
  group:chooseByName("btn" .. answer.index2)
  self.answerNode:removeAllChildren()
  self.body:runAction(cc.JumpTo:create(0.3, cc.p(1016, -123), 10, 1))
  local text = MRichText.new({
    text = answer.desc,
    size = 26,
    maxWidth = 600
  })
  text:addTo(self.answerNode)
  text:playAnimation(60)
end

return QuestionLayer

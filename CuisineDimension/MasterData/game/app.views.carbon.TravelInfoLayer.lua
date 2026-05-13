local TravelInfoCsv = require("csvdata.tour_info")
local uiData = {
  csbFile = "ui/carbon/TravelInfoLayer.csb",
  mask = true,
  maskClick = function()
    BackManager:pop()
  end,
  popup = true,
  widgets = {
    btnWin = "btnWin",
    btnBuild = "btnBuild",
    winLayer = "winLayer",
    scoreLabel = "winLayer/frame1/scoreLabel",
    buildLayer = "buildLayer",
    stage1 = "buildLayer/stage1",
    stage2 = "buildLayer/stage2",
    stage3 = "buildLayer/stage3",
    stage4 = "buildLayer/stage4",
    stage5 = "buildLayer/stage5",
    stage6 = "buildLayer/stage6",
    stage7 = "buildLayer/stage7",
    stage8 = "buildLayer/stage8",
    stage9 = "buildLayer/stage9",
    infoArrow = "buildLayer/infoArrow",
    buildContent = "buildLayer/buildContent"
  }
}
local TravelInfoLayer = class("TravelInfoLayer", UIBase)

function TravelInfoLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

local btns = {"btnWin", "btnBuild"}

function TravelInfoLayer:init(params)
  self.difficult = params.difficult
  self.scoreLabel:setString(globalCsv.tourRewardCost .. "积分")
  self.group = MRadioGroup:create({
    chooseCb = function(sender)
      sender:setPositionY(sender:getPositionY() + 5)
    end,
    unchooseCb = function(sender)
      sender:setPositionY(sender:getPositionY() - 5)
    end
  })
  for index, btnName in ipairs(btns) do
    local btn = self[btnName]
    btn:setGroup(self.group)
    btn:setCallback(function()
      self.selected = index
      self:showData()
    end)
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#000000"), 1)
  end
  for index = 1, 9 do
    local stage = self["stage" .. index]
    stage:setCallback(function()
      self:showBuild(index)
    end)
  end
  self.selected = 1
end

function TravelInfoLayer:showData()
  self.group:chooseByName(btns[self.selected])
  if self.selected == 1 then
    self:showWin()
  else
    self:showBuild(1)
  end
end

function TravelInfoLayer:showWin()
  self.buildLayer:hide()
  self.winLayer:show()
end

function TravelInfoLayer:showBuild(index)
  self.buildLayer:show()
  self.winLayer:hide()
  self.buildContent:removeAllChildren()
  self.infoArrow:setPositionX(35 + (index - 1) * 65)
  local strs = {
    [1] = "没有什么特别力量的点，但是看起来很可靠。",
    [2] = "踏上游历的第一步就是这里啦！",
    [3] = "光是站在上面，就可以感受到源源不断的积分哦~",
    [4] = "可以很好的回复体力，顺带还能喝杯下午茶。",
    [5] = "虽然不知会出现什么道具，但是用了就没错~",
    [6] = "这道传送门究竟会把你送到哪里呢……",
    [7] = "游历时也有黑暗食灵搅局？那就把它们统统揍飞！",
    [8] = "嗯……金斧子还是银斧子？要选哪个呐……",
    [9] = "魔法石可以削弱吞食者的力量"
  }
  MRichText.new({
    text = strs[index],
    size = 20,
    color = UIHelper.hex2rgb("#703802"),
    maxWidth = 500
  }):anch(0.5, 0.5):center(self.buildContent):addTo(self.buildContent)
end

return TravelInfoLayer

local RoleInfo = require("csvdata.role_info")
local UnitCsv = require("csvdata.unit")
local carbonCsv = require("csvdata.chapter_battle")
local battleRes = "ui/carbon/battle/"
local uiData = {
  csbFile = "ui/carbon/CarbonInfoLayer.csb",
  mask = true,
  maskClick = function()
    BackManager:pop()
  end,
  popup = true,
  widgets = {btnNode = "btnNode", node = "node"}
}
local TAG_FLAG = 1
local monsterName = {
  "Boss：",
  "突击怪：",
  "制造者：",
  "渣滓：",
  "吞噬者："
}
local buildName = {
  "普通点：",
  "传送门：",
  "脆弱的传送门：",
  "采集点：",
  "魔法石："
}
local weatherName = {
  "立春：",
  "大暑：",
  "雨水：",
  "霜降："
}
local buildIcon = {
  "t_arrange.png",
  "t_weakarrange.png",
  "t_supply.png",
  "t_power.png",
  "t_box.png",
  "t_cure.png",
  "t_move.png",
  "t_attrUp.png",
  "t_material.png"
}
local btnData = {
  [1] = {
    name = "作战情报",
    callback = function(self)
      self:showWin()
    end
  },
  [2] = {
    name = "建筑情报",
    callback = function(self)
      self:showBuild()
    end
  },
  [3] = {
    name = "天气情报",
    callback = function(self)
      self:showWeather()
    end
  },
  [4] = {
    name = "怪物情报",
    callback = function(self)
      self:showMonster()
    end
  }
}
local CarbonInfoLayer = class("CarbonInfoLayer", UIBase)

function CarbonInfoLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function CarbonInfoLayer:init(params)
  self.battleType = params.battleType
  self.carbonData = params.carbonData
  self.group = MRadioGroup:create()
  self.group = MRadioGroup:create({
    chooseCb = function(sender)
      sender:setPositionY(sender:getPositionY() + 5)
    end,
    unchooseCb = function(sender)
      sender:setPositionY(sender:getPositionY() - 5)
    end
  })
  local xPos = 97
  for idx, data in ipairs(btnData) do
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(battleRes, {
      "ziliao_btn_a.png",
      "ziliao_btn_b.png"
    })
    btn:pos(xPos, 308):addTo(self.btnNode):name("btn" .. idx)
    btn:setGroup(self.group)
    btn:setCallback(function()
      btnData[idx].callback(self)
    end)
    display.newTTFLabel({
      text = data.name,
      color = UIHelper.hex2rgb("#ffffff"),
      size = 24
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(51, 24):addTo(btn)
    xPos = xPos + 110
  end
  self.group:chooseByName("btn1")
  self:showWin()
end

function CarbonInfoLayer:showWin()
  self.node:removeAllChildren()
  local size = self.node:getContentSize()
  local chapterData = self.carbonData
  UIHelper.newImageView(battleRes .. "battle_frame.png"):pos(300, 136):addTo(self.node)
  UIHelper.newImageView(battleRes .. "ziliao_3.png"):pos(300, 136):addTo(self.node)
  local cakeDesc = {
    "无",
    "无",
    "无"
  }
  local cakeDone = {}
  if self.battleType == BattleType.PvE then
    cakeDone = (game.role.carbons[chapterData.id].achievement or ""):toNumMap()
    cakeDesc = {
      chapterData.con1Desc,
      chapterData.con2Desc,
      chapterData.con3Desc
    }
  end
  yPos = 88
  for idx = 1, 3 do
    UIHelper.newImageView("ui/carbon/carbonresult/aim1.png"):pos(75, yPos):addTo(self.node)
    display.newTTFLabel({
      text = cakeDesc[idx],
      size = 16,
      color = UIHelper.hex2rgb("#933a05")
    }):anch(0, 0.5):pos(90, yPos - 2):addTo(self.node)
    if cakeDone[idx] then
      display.newSprite(battleRes .. "ziliao_4.png"):pos(490, yPos):addTo(self.node)
    end
    yPos = yPos - 28
  end
  display.newTTFLabel({
    text = "净化评价：",
    color = UIHelper.hex2rgb("#703802"),
    size = 20
  }):anch(0, 0.5):pos(50, 240):addTo(self.node)
  display.newTTFLabel({
    text = "特殊目标：",
    color = UIHelper.hex2rgb("#703802"),
    size = 20
  }):anch(0, 0.5):pos(50, 115):addTo(self.node)
  if self.battleType == BattleType.Paradise then
    UIHelper.newImageView(battleRes .. "fish.png"):pos(70, 215):addTo(self.node)
    display.newTTFLabel({
      text = chapterData.AssessDesc1,
      size = 16,
      color = UIHelper.hex2rgb("#933a05")
    }):anch(0, 0.5):pos(90, 215):addTo(self.node)
    return
  end
  display.newTTFLabel({
    text = "提示:达成S级通关，谢礼堆奖励更丰富",
    size = 16,
    color = UIHelper.hex2rgb("#933a05")
  }):anch(0, 0.5):pos(60, 153):addTo(self.node)
  local tips = {
    "S级:达成3条",
    "A级:达成2条",
    "B级:达成1条"
  }
  local yPos = 215
  local showTip = false
  local conditions = {
    chapterData.AssessDesc1,
    chapterData.AssessDesc2,
    chapterData.AssessDesc3
  }
  if chapterData.endconditionType == 2 then
    conditions = {
      chapterData.AssessDesc4,
      chapterData.AssessDesc5,
      chapterData.AssessDesc6
    }
    showTip = true
  end
  for idx = 1, 3 do
    UIHelper.newImageView(battleRes .. "fish.png"):pos(70, yPos):addTo(self.node)
    display.newTTFLabel({
      text = conditions[idx],
      size = 16,
      color = UIHelper.hex2rgb("#933a05")
    }):anch(0, 0.5):pos(90, yPos):addTo(self.node)
    if showTip then
      display.newTTFLabel({
        text = tips[idx],
        size = 16,
        color = UIHelper.hex2rgb("#933a05")
      }):anch(0, 0.5):pos(400, yPos):addTo(self.node)
    end
    yPos = yPos - 20
  end
end

function CarbonInfoLayer:showBuild()
  self.node:removeAllChildren()
  local size = self.node:getContentSize()
  local strs = {
    [1] = "同化后可召唤套餐",
    [2] = "同化后可召唤套餐，被敌人同化则变为普通点",
    [3] = "增加1点行动点数，能够多次补给套餐",
    [4] = "每天结束时，每有1个我方同化的魔法石，吞食者饱食度-10；被敌方同化时，吞食者饱食度+10",
    [5] = "一个礼物堆",
    [6] = "可以治疗队伍生命，可使用一次",
    [7] = "增加1点行动点数，能够多次补给套餐",
    [8] = "占领后与怪战斗时提升一定的攻击和防御",
    [9] = "补充队伍携带的资源"
  }
  local list = ccui.ListView:create()
  list:size(size)
  list:setInnerContainerSize(size)
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0, 0):pos(0, 0):addTo(self.node)
  for idx, desc in ipairs(strs) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(size.width, 70)):addTo(list)
    display.newSprite(battleRes .. buildIcon[idx]):pos(50, 35):addTo(viewNode)
    MRichText.new({
      text = desc,
      size = 18,
      color = UIHelper.hex2rgb("#703803"),
      maxWidth = 500
    }):anch(0, 0.5):pos(100, 35):addTo(viewNode)
    UIHelper.newImageView("ui/hero/detail/line.png"):pos(size.width / 2, 3):addTo(viewNode)
  end
  list:requestDoLayout()
end

function CarbonInfoLayer:showWeather()
  self.node:removeAllChildren()
  local size = self.node:getContentSize()
  local strs = {
    [1] = "普通的日子，没有特殊效果",
    [2] = "制造者变成突击者。",
    [3] = "渣滓的攻击力+50%，吞食者饱食度变为0。",
    [4] = "吞食者无法通过吞食提升饱食度"
  }
  local yPos = size.height
  local interval = size.height / 4
  for index = 1, 4 do
    yPos = yPos - interval
    local content = display.newNode():pos(0, yPos):addTo(self.node)
    UIHelper.newImageView(battleRes .. string.format("t_weather_%d.png", index)):pos(50, interval / 2):addTo(content)
    MRichText.new({
      text = strs[index],
      size = 18,
      color = UIHelper.hex2rgb("#703803"),
      maxWidth = 500
    }):anch(0, 0.5):pos(100, interval / 2):addTo(content)
    UIHelper.newImageView("ui/hero/detail/line.png"):pos(size.width / 2, -3):addTo(content)
  end
end

function CarbonInfoLayer:showMonster()
  self.node:removeAllChildren()
  local size = self.node:getContentSize()
  local strs = {
    [1] = "黑暗料理界的杂兵，战力低下却数量众多",
    [2] = "黑暗料理界的突击部队，一回合可移动2次",
    [3] = "精通污染技术，每回合制造1个渣滓",
    [4] = "吞食渣滓将提升10点饱食度，使全属性+10%"
  }
  local yPos = size.height
  local interval = size.height / 4
  for index = 1, 4 do
    yPos = yPos - interval
    local content = display.newNode():pos(0, yPos):addTo(self.node)
    UIHelper.newImageView(battleRes .. string.format("monster_%d.png", index)):pos(50, interval / 2):addTo(content)
    MRichText.new({
      text = strs[index],
      size = 18,
      color = UIHelper.hex2rgb("#703803"),
      maxWidth = 400
    }):anch(0, 0.5):pos(100, interval / 2):addTo(content)
    UIHelper.newImageView("ui/hero/detail/line.png"):pos(size.width / 2, -3):addTo(content)
  end
end

function CarbonInfoLayer:showData()
end

return CarbonInfoLayer

local uiData = {
  csbFile = "ui/global/RuleLayer.csb",
  mask = true,
  popup = true,
  widgets = {
    infoBg = "popAction/infoBg",
    info = "popAction/infoBg/imageInfo",
    closeBtn = "popAction/infoBg/closeBtn"
  }
}
local RuleLayer = class("RuleLayer", UIBase)

function RuleLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

local Csv = {
  carbon = {
    content = "csvdata.carbon_support",
    tables = "csvdata.carbon_support_table"
  },
  lty = {
    content = "csvdata.lty.lty_support",
    tables = "csvdata.lty.lty_support_table"
  },
  score = {
    content = "csvdata.carbon_score_support"
  },
  common = {
    content = "csvdata.common_support"
  },
  secretVickie = {
    content = "csvdata.loop_activity.loop_drawgift_support",
    tables = "csvdata.loop_activity.loop_drawgift_table"
  },
  awaken = {
    content = "csvdata.awaken_drawgift_support",
    tables = "csvdata.awaken_drawgift_table"
  },
  luckyRound = {
    content = "csvdata.activity_drawgift_support",
    tables = "csvdata.activity_drawgift_table"
  },
  union = {
    content = "csvdata.union_support"
  },
  union_tech = {
    content = "csvdata.union_tech_support"
  },
  openbox = {
    content = "csvdata.box_shake_support"
  },
  autoBattle = {
    content = "csvdata.auto_battle_support"
  },
  ptRankRule = {
    content = "csvdata.pt_rank_support"
  },
  newWorldBoss = {
    content = "csvdata.newworldboss_support"
  },
  worldBoss = {
    content = "csvdata.worldboss_carbon_support"
  },
  diner_car = {
    content = "csvdata.dinner_car_drawgift_support",
    tables = "csvdata.dinner_car_drawgift_table"
  },
  diner_box = {
    content = "csvdata.dinner_box_drawgift_support",
    tables = "csvdata.dinner_box_drawgift_table"
  },
  activity_70 = {
    content = "csvdata.activity_70_support"
  },
  activity_71 = {
    content = "csvdata.activity_71_support",
    tables = "csvdata.activity_71_table"
  },
  activity_74 = {
    content = "csvdata.activity_74_support"
  },
  activity_75 = {
    content = "csvdata.activity_75_support",
    tables = "csvdata.activity_75_table"
  },
  activity_76 = {
    content = "csvdata.activity_unlimitgift_support"
  },
  activity_77 = {
    content = "csvdata.activity_77_support",
    tables = "csvdata.activity_77_table"
  },
  activity_78 = {
    content = "csvdata.activity_78_support",
    tables = "csvdata.activity_78_table"
  },
  activity_79 = {
    content = "csvdata.chapter_pass_support"
  },
  activity_80 = {
    content = "csvdata.activity_80_support"
  },
  activity_83 = {
    content = "csvdata.activity_83_support"
  },
  activity_84 = {
    content = "csvdata.activity_84_diamondblindbox_support",
    tables = "csvdata.activity_84_diamondblindbox_table"
  },
  activity_85 = {
    content = "csvdata.activity_85_support"
  },
  activity_35 = {
    content = "csvdata.activity_35_support",
    tables = "csvdata.activity_35_table"
  },
  innate_detail = {
    content = "csvdata.talent_support",
    tables = "csvdata.talent_table"
  },
  dream_draw = {
    content = "csvdata.dream_support",
    tables = "csvdata.dream_table"
  },
  secret_safe = {
    content = "csvdata.secret_safe_support"
  },
  age_tips = {
    content = "csvdata.age_tips_support"
  },
  union_battle = {
    content = "csvdata.union_battle_support"
  },
  shenyuan_carbon = {
    content = "csvdata.shenyuan_support"
  },
  activity92 = {
    content = "csvdata.activity_92_support",
    tables = "csvdata.activity_92_table"
  },
  herojob = {
    content = "csvdata.hero_job_support"
  },
  activity_95 = {
    content = "csvdata.activity_95_support"
  },
  activity_96 = {
    content = "csvdata.activity_96_support",
    tables = "csvdata.activity_96_table"
  },
  activity_101 = {
    content = "csvdata.activity_101_support",
    tables = "csvdata.activity_101_table"
  },
  activity_55 = {
    content = "csvdata.activity_55_support"
  },
  activity_104 = {
    content = "csvdata.activity_104_support"
  },
  activity105 = {
    content = "csvdata.activity_105_support",
    tables = "csvdata.activity_105_table"
  },
  activity106 = {
    content = "csvdata.activity_106_support"
  },
  activity_108 = {
    content = "csvdata.activity_108_support"
  },
  rouge = {
    content = "csvdata.rouge.rouge_support",
    tables = "csvdata.rouge.rouge_table"
  }
}

function RuleLayer:init(params)
  self.info:hide()
  self.defaultColor = "#702803"
  self.tableWidthMin = 130
  self.tableHeightMin = params.tableHeightMin or 26
  self.changeBg = params.changeBg or false
  if self.changeBg then
    self.defaultColor = "#b6bac1"
    self.infoBg:setImage("ui/rouge/main/rule_bg.png")
    self.closeBtn:setImages("ui/rouge/main/", {
      "rule_close.png",
      "rule_close.png"
    })
  end
  if params.okCallback then
    self.okCallback = params.okCallback
  end
  if params.cancelCallback then
    self.cancelCallback = params.cancelCallback
  end
  if params.typeStr then
    self:showTextRule(params.typeStr, params.isFirstSecret)
  else
    self:showImageRule(params.res)
  end
  self.closeBtn:setTouchScale(true)
  self.closeBtn:setCallback(function()
    self:close()
  end)
end

function RuleLayer:showImageRule(res)
  local image = display.newSprite(res)
  local size = image:getContentSize()
  if size.height > 500 then
    self.list = ccui.ListView:create()
    self.list:size(cc.size(926, 484))
    self.list:setInnerContainerSize(cc.size(926, 484))
    self.list:setClippingEnabled(true)
    self.list:setBounceEnabled(true)
    self.list:anch(0.5, 0.5):center(self.infoBg):addTo(self.infoBg)
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(size.width, size.height)):addTo(self.list)
    image:center(viewNode):addTo(viewNode)
  else
    image:center(self.infoBg):addTo(self.infoBg)
  end
end

function RuleLayer:showTextRule(str, isFirstSecret)
  self.list = ccui.ListView:create()
  self.list:size(cc.size(926, 484))
  self.list:setInnerContainerSize(cc.size(926, 484))
  self.list:setClippingEnabled(true)
  self.list:anch(0.5, 0.5):center(self.infoBg):addTo(self.infoBg)
  local MaxHeight = 0
  local data = Csv[str]
  if not data then
    return
  end
  local ContentCsv, TableCsv, ExtraCsv = {}, {}, {}
  if data.content then
    ContentCsv = require(data.content)
  end
  if data.tables then
    TableCsv = require(data.tables)
  end
  if data.extra then
    ExtraCsv = require(data.extra)
  end
  local textCells = self:getTextCells(ContentCsv)
  local tableCells = self:getTableCells(TableCsv)
  local extraCells = self:getTextCells(ExtraCsv)
  for _, cells in ipairs({
    textCells,
    tableCells,
    extraCells
  }) do
    for _, cell in ipairs(cells) do
      cell:addTo(self.list)
      MaxHeight = MaxHeight + cell:getContentSize().height
    end
  end
  self.list:setBounceEnabled(484 < MaxHeight)
  self.list:requestDoLayout()
  if isFirstSecret ~= nil then
    self.closeBtn:hide()
    local okBtn = UIHelper.extend(ccui.Button:create())
    okBtn:setImages("ui/global/", {
      "dialog_ok.png",
      "dialog_ok.png"
    })
    okBtn:pos(694.5, 0):addTo(self.infoBg)
    okBtn:setCallback(function()
      if self.okCallback then
        self.okCallback()
      end
      self:close()
    end)
    okBtn:setString({
      text = "同意",
      size = 22,
      color = UIHelper.hex2rgb("#000000")
    })
    local cancelBtn = UIHelper.extend(ccui.Button:create())
    cancelBtn:setImages("ui/global/", {
      "dialog_cancel.png",
      "dialog_cancel.png"
    })
    cancelBtn:pos(231.5, 0):addTo(self.infoBg)
    cancelBtn:setCallback(function()
      if self.cancelCallback then
        self.cancelCallback()
      end
      self:close()
    end)
    cancelBtn:setString({
      text = "不同意",
      size = 22,
      color = UIHelper.hex2rgb("#000000")
    })
  end
end

function RuleLayer:getTextCells(csv)
  local cells = {}
  for id, data in ipairs(csv) do
    local viewNode = ccui.Widget:create()
    local cellSize = cc.size(926, 15)
    if data.type == 1 then
      cellSize.height = 50
      if self.changeBg then
        display.newSprite("ui/global/rule_title_bg1.png"):anch(0, 0.5):pos(35, 25):addTo(viewNode)
      else
        display.newSprite("ui/global/rule_title_bg.png"):anch(0, 0.5):pos(35, 25):addTo(viewNode)
      end
      display.newTTFLabel({
        text = data.desc,
        size = 20,
        color = UIHelper.hex2rgb(data.color == "" and self.defaultColor or data.color)
      }):anch(0, 0.5):pos(50, 20):addTo(viewNode)
    else
      local lab = display.newTTFLabel({
        text = data.desc,
        size = 18,
        color = UIHelper.hex2rgb(data.color == "" and self.defaultColor or data.color),
        dimensions = cc.size(840, 0)
      })
      lab:anch(0, 0.5):pos(50, lab:getContentSize().height / 2 + 3):addTo(viewNode)
      cellSize.height = math.max(cellSize.height, lab:getContentSize().height)
    end
    viewNode:setContentSize(cellSize)
    cells[id] = viewNode
  end
  return cells
end

function RuleLayer:getTableCells(csv)
  local cells = {}
  local colWidths = {}
  if not next(csv) then
    return cells
  end
  local initData = csv[0]
  for idx = 1, 10 do
    if not initData["col" .. idx] then
      break
    end
    colWidths[idx] = self.tableWidthMin
  end
  local xPos, yPos = initData.xpos or 80, initData.ypos or 0
  for _, data in ipairs(csv) do
    for idx = 1, #colWidths do
      local lab = display.newTTFLabel({
        text = data["col" .. idx],
        size = 22
      })
      if lab:getContentSize().width > colWidths[idx] then
        colWidths[idx] = lab:getContentSize().width + 8
      end
    end
  end
  local widthSum = 0
  for _, value in pairs(colWidths) do
    widthSum = widthSum + value
  end
  if 0 < yPos then
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(926, yPos))
    cells[1] = viewNode
  end
  for id = 0, #csv do
    local data = csv[id]
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(926, self.tableHeightMin))
    local x = xPos
    display.newScale9Sprite("ui/global/rule_line.png", 0, 0, cc.size(widthSum, 2)):anch(0, 1):pos(x, self.tableHeightMin):addTo(viewNode)
    display.newScale9Sprite("ui/global/rule_line.png", 0, 0, cc.size(widthSum, 2)):anch(0, 0):pos(x, -2):addTo(viewNode)
    display.newScale9Sprite("ui/global/rule_line.png", 0, 0, cc.size(self.tableHeightMin, 2)):anch(0, 0.5):pos(x, 0):addTo(viewNode):setRotation(-90)
    for idx = 1, #colWidths do
      display.newTTFLabel({
        text = data["col" .. idx],
        size = 22,
        color = UIHelper.hex2rgb(self.defaultColor)
      }):pos(x + colWidths[idx] / 2, self.tableHeightMin / 2):addTo(viewNode)
      x = x + colWidths[idx]
      display.newScale9Sprite("ui/global/rule_line.png", 0, 0, cc.size(self.tableHeightMin, 2)):anch(0, 0.5):setRotation(-90):pos(x, 0):addTo(viewNode)
    end
    cells[#cells + 1] = viewNode
  end
  return cells
end

return RuleLayer

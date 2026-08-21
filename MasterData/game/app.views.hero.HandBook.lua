local itemCsv = require("csvdata.item")
local unitCsv = require("csvdata.unit")
local bookCsv = require("csvdata.handbook")
local cgBookCsv = require("csvdata.cgbook")
local sauceCsv = require("csvdata.sauce")
local heroRes = "ui/hero/handbook/"
local cgRes = "icon/cg/"
local sauceRes = "ui/sauce/card/"
local uiData = {
  csbFile = "ui/hero/HandBook.csb",
  mask = true,
  widgets = {
    mainBg = "mainBg",
    upBar = "upBar",
    list = "list",
    btnsBg = "btnsBg",
    btnList = "btnsBg/btnList",
    upLine = "upLine",
    num = "upLine/numBg/num"
  }
}
local btnsData = {
  [1] = {
    name = "食灵",
    cellSize = cc.size(200, 220),
    colNum = 5,
    desc = "解锁食灵: %d/%d"
  },
  [2] = {
    name = "升华",
    cellSize = cc.size(332, 220),
    colNum = 3,
    desc = "解锁CG: %d/%d"
  },
  [3] = {
    name = "酱料",
    cellSize = cc.size(164, 190),
    colNum = 6,
    desc = "解锁酱料: %d/%d"
  }
}
local HandBook = class("HandBook", UIBase)

function HandBook:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function HandBook:init(params)
  TopBar:show(TopBarType.full, "菜谱")
  TopBar:showAnimation(true)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
    self.btnsBg:setPositionX(self.btnsBg:getPositionX() - 75)
  end
  UIHelper.MoveToDown({
    node = self.upBar
  })
  UIHelper.MoveToLeft({
    node = self.upLine,
    delay = 0.2,
    time = 0.3
  })
  self.selectType = 1
  local delay = 0.4
  local btnSize = UIHelper.newImageView("ui/hero/taocan_1.png"):getContentSize()
  local group = MRadioGroup:create()
  for index, data in ipairs(btnsData) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(btnSize):addTo(self.btnList)
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages("ui/hero/", {
      "taocan_1.png",
      "taocan_2.png"
    })
    btn:center(viewNode):addTo(viewNode):name("btn" .. index)
    btn:setGroup(group)
    display.newTTFLabel({
      text = data.name,
      size = 22
    }):enableOutline(UIHelper.hex2rgb("#630c07"), 1):pos(59, 26):addTo(btn)
    btn:setCallback(function()
      self.selectType = index
      self:showData()
    end)
    UIHelper.MoveToRight({
      node = btn,
      delay = delay,
      time = 0.2,
      pos = {110, 0}
    })
    delay = delay + 0.1
  end
  group:chooseByName("btn" .. self.selectType)
  self.list:addCCSEventListener(function(sender, eventType)
    if eventType == 9 then
      local widgetb = self.list:getBottommostItemInCurrentView()
      local bottomRow = self.list:getIndex(widgetb)
      local widgett = self.list:getTopmostItemInCurrentView()
      local topRow = self.list:getIndex(widgett)
      local now = socket:gettime()
      if not self.lastTime then
        self.lastTime = now
      end
      if now - self.lastTime > 0.4 then
        self.lastTime = nil
        self.list:stopAutoScroll()
        return
      end
      self.lastTime = now
      self:loadPage(topRow + 1, bottomRow + 1)
    end
  end)
end

function HandBook:showData(params)
  self.list:removeAllChildren()
  self.rowViews = {}
  self.rowLoaded = {}
  self.cellSize = btnsData[self.selectType].cellSize
  self.colNum = btnsData[self.selectType].colNum
  self.DataCsv = self.selectType == 1 and bookCsv or self.selectType == 2 and cgBookCsv or sauceCsv
  local set = game.role.heroBook
  if self.selectType == 2 then
    set = game.role.heroCgBook:toNumMap()
  elseif self.selectType == 3 then
    set = (game.role.sauceBook or ""):toNumMap()
  end
  self.num:setString(string.format(btnsData[self.selectType].desc, table.nums(set), table.nums(self.DataCsv)))
  local nodeSize = cc.size(self.list:getContentSize().width, self.cellSize.height)
  if self.selectType == 3 then
    self.DataCsv = {}
    self.special = {
      [100] = 1,
      [101] = 1,
      [102] = 1,
      [103] = 1,
      [104] = 1,
      [105] = 1,
      [106] = 1,
      [107] = 1,
      [108] = 1
    }
    local temp = {}
    for id, sauce in pairs(sauceCsv) do
      if self.special[id] then
        table.insert(temp, sauce)
      elseif sauce.notShow ~= 1 then
        table.insert(self.DataCsv, sauce)
      end
    end
    table.sort(self.DataCsv, function(a, b)
      return a.id < b.id
    end)
    table.sort(temp, function(a, b)
      return a.id < b.id
    end)
    for _, sauce in ipairs(temp) do
      table.insert(self.DataCsv, sauce)
    end
  end
  for row = 1, math.ceil(table.nums(self.DataCsv) / self.colNum) do
    local viewNode = ccui.Widget:create()
    viewNode:setCascadeOpacityEnabled(true)
    viewNode:size(nodeSize):addTo(self.list)
    self.rowViews[row] = viewNode
  end
  self.list:requestDoLayout()
  self:loadPage(1, 3)
end

function HandBook:loadList(row)
  local viewNode = self.rowViews[row]
  for index = (row - 1) * self.colNum + 1, self.colNum * row do
    local data = self.DataCsv[index]
    if not data then
      break
    end
    local col = index - (row - 1) * self.colNum
    local card
    if self.selectType == 1 then
      card = self:createBookCard(data)
    elseif self.selectType == 2 then
      card = self:createCgBookCard(data)
    elseif self.selectType == 3 then
      card = self:createSauceCard(data)
    end
    card:anch(0, 0):pos((col - 1) * self.cellSize.width, 0):addTo(viewNode)
  end
  self.rowLoaded[row] = true
end

function HandBook:loadPage(topRow, buttomRow)
  topRow = math.max(1, topRow)
  buttomRow = math.min(#self.rowViews, buttomRow)
  if topRow == buttomRow and topRow < #self.rowViews then
    return
  end
  local rows = {}
  for row = topRow, buttomRow do
    if not self.rowLoaded[row] then
      self:loadList(row)
    end
    rows[row] = true
  end
  for row, _ in pairs(self.rowLoaded) do
    if not rows[row] then
      self.rowLoaded[row] = nil
      self.rowViews[row]:removeAllChildren()
    end
  end
end

function HandBook:createBookCard(data)
  local card, size
  if data.open == 1 then
    card = UIHelper.newImageView(heroRes .. "card_bg.png")
    size = card:getContentSize()
    local hero = UIHelper.newImageView(UIHelper.getCardRes("book", data.id)):anch(0.5, 1):scale(0.9):pos(size.width / 2, size.height - 12):addTo(card)
    local unitData = unitCsv[data.id]
    display.newTTFLabel({
      text = unitData.name,
      size = 16,
      color = UIHelper.hex2rgb("#4c2306")
    }):pos(size.width / 2, 50):addTo(card)
    local starBg = UIHelper.newImageView(heroRes .. "floor.png"):pos(size.width / 2, 80):addTo(card)
    local proTag = UIHelper.getProfessionTag(unitData.profession, 6):pos(173, 192):addTo(card)
    local star, xInterval = unitData.star, 20
    local temStar = math.min(star, 5)
    local xBegin = starBg:getContentSize().width / 2 - (temStar - 1) * xInterval / 2 + 1
    local isBlack = globalCsv.blackHeroUnitIds[unitData.type] == 1
    local isMengJing = globalCsv.mengJingHeroUnitIds[unitData.type] == 1
    for index = 1, temStar do
      display.newSprite(isMengJing and "ui/global/star_extra.png" or isBlack and "ui/global/star_black.png" or "ui/global/star.png"):pos(xBegin + (index - 1) * xInterval, 14):addTo(starBg)
    end
    if unitData.timeLimit == 1 then
      UIHelper.newImageView("ui/global/limit_extra.png"):pos(size.width / 2, size.height / 2):addTo(card)
    end
    if not game.role.heroBook[tostring(data.id)] then
      UIHelper.setImageViewGray(hero)
      UIHelper.setImageViewGray(card)
    end
  else
    card = UIHelper.newImageView("ui/hero/small_card_add_bg.png")
    size = card:getContentSize()
    UIHelper.newImageView(heroRes .. "guo.png"):pos(size.width / 2, 150):addTo(card)
    display.newTTFLabel({
      text = "暂未开放",
      size = 16,
      color = UIHelper.hex2rgb("#4c2306")
    }):pos(size.width / 2, 50):addTo(card)
  end
  display.newTTFLabel({
    text = string.format("NO.%03d", data.order),
    size = 16,
    color = UIHelper.hex2rgb("#4c2306")
  }):pos(size.width / 2, 30):addTo(card)
  card:setCallback(function()
    if game.role.heroBook[tostring(data.id)] or data.open ~= 0 then
      local layer = game:createView("hero.HandDetailLayer", {
        heroId = data.id,
        handbook = data.order
      })
      BackManager:push(function()
        layer:close()
        TopBar:show(TopBarType.full, "菜谱")
      end)
    end
  end)
  return card
end

function HandBook:createCgBookCard(data)
  local card
  if game.role.heroCgBook:getv(data.type, 0) == 0 then
    card = display.newSprite(heroRes .. "cg_cell_lock.png"):scale(0.9)
    display.newTTFLabel({
      text = data.desc,
      size = 20,
      color = UIHelper.hex2rgb("#b7aca0")
    }):anch(0, 0.5):pos(5, 18):addTo(card)
  else
    card = UIHelper.newImageView(heroRes .. "cg_cell_open.png"):scale(0.9)
    display.newSprite(cgRes .. string.format("%d_s.png", data.type)):pos(175, 130):addTo(card)
    display.newTTFLabel({
      text = data.desc,
      size = 20,
      color = UIHelper.hex2rgb("#b7aca0")
    }):anch(0, 0.5):pos(5, 18):addTo(card)
    card:setCallback(function()
      local mask = UIHelper.showOnleImgTip(cgRes .. string.format("%d.png", data.type))
      if UIHelper.isiPhoneX() then
        UIHelper.fitForiPhoneX(mask)
      end
    end)
  end
  return card
end

function HandBook:createSauceCard(data)
  local card
  local unitData = itemCsv[data.id + ItemStartId.sauce]
  card = UIHelper.newImageView(sauceRes .. string.format("card_fram_%d.png", unitData.star))
  local str = (data.rare == 3 or self.special[data.id]) and "%s_s.png" or data.rare == 4 and (data.isTanli == 1 and "%s_s_3.png" or "%s_s_2.png") or data.isTanli == 1 and "%s_s_6.png" or "%s_s_3.png"
  if game.role.sauceBook:getv(data.id, 0) == 0 then
    local iconBg = UIHelper.newImageView(sauceRes .. "card_top_bg.png"):pos(74, 76):addTo(card)
    local image = UIHelper.newImageView(string.format(str, data.image)):center(iconBg):addTo(iconBg)
    local frame = UIHelper.newImageView(sauceRes .. "card_top_frame.png"):center(iconBg):addTo(iconBg)
    UIHelper.setImageViewGray(iconBg)
    UIHelper.setImageViewGray(image)
    UIHelper.setImageViewGray(frame)
    iconBg:setCallback(function()
      self:showSauceDetail(data)
    end)
  else
    local iconBg = UIHelper.newImageView(sauceRes .. string.format("card_bg_%d.png", unitData.star)):pos(75, 75):addTo(card, -1)
    display.newSprite(string.format(str, data.image)):center(iconBg):addTo(iconBg)
    iconBg:setCallback(function()
      self:showSauceDetail(data)
    end)
  end
  display.newSprite(string.format("ui/global/profession_%d.png", data.profession)):scale(0.6):pos(16, 168):addTo(card)
  display.newTTFLabel({
    text = unitData.name,
    size = 18,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0.5, 0.5):pos(72, 169):addTo(card)
  if data.id < 100 or data.id > 108 then
    display.newTTFLabel({
      text = string.format("NO.%03d", data.id),
      size = 16,
      color = UIHelper.hex2rgb("#4c2306")
    }):enableOutline(UIHelper.hex2rgb("#ffffff"), 1):pos(75, 20):addTo(card)
  end
  return card
end

function HandBook:showSauceDetail(data)
  local mask, mainBg = UIHelper.showOnleImgTip("ui/sauce/transfer/info_bg.png")
  local detailNode = display.newNode():pos(580, 555):addTo(mainBg)
  local str = self.special[data.id] and "%s_3.png" or "%s.png"
  display.newSprite(string.format(str, data.image)):pos(210, 225):addTo(mainBg)
  local sauce = require("app.models.Sauce"):create({
    type = data.id,
    breakL = 10,
    advanceL = 6
  })
  game:createView("sauce.SauceDetailLayer", {
    scene = detailNode,
    sauceId = -1,
    sauce = sauce,
    skipTitle = true,
    showFrame = true,
    ignore = true
  })
  mainBg:scale(0.4)
  mainBg:runAction(cc.EaseElasticOut:create(cc.ScaleTo:create(0.8, 1)))
end

return HandBook

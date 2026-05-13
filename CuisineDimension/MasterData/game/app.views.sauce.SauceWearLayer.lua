local FilterLogic = import("..sauce.FilterSauceLogic")
local WearRes = "ui/equip/wear/"
local uiData = {
  csbFile = "ui/equip/EquipWearLayer.csb",
  widgets = {
    center = "center",
    up = "up",
    upBar = "upBar",
    num = "upBar/num",
    order1 = "upBar/order1",
    order2 = "upBar/order2",
    order3 = "upBar/order3",
    typeBg = "upBar/typeBg",
    list = "mainBg/list",
    detailNode = "mainBg/detailNode",
    btnOff = "mainBg/btnOff",
    btnsBg = "btnsBg",
    btnsSauceBg = "btnsSauceBg",
    btn1 = "btnsSauceBg/btn1",
    equipBg1 = "btnsSauceBg/equipBg1"
  }
}
local SauceWearLayer = class("SauceWearLayer", UIBase)

function SauceWearLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function SauceWearLayer:init(params)
  self.btnsBg:hide()
  self.btnsSauceBg:show()
  self.order1:show()
  self.typeBg:show()
  TopBar:show(TopBarType.full, "酱料列表")
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.center)
    self.btnsBg:setPositionX(self.btnsBg:getPositionX() + 125)
  end
  self.center:setTouchEnabled(true)
  self.center:setSwallowTouches(true)
  UIHelper.MoveToLeft({
    node = self.btnsSauceBg,
    time = 0.3
  })
  self.rule = params.rule or function()
    return false
  end
  self.heroId = params.heroId
  self.callback = params.callback
  self.curChoose = params.sauceId or 0
  self.hideHero = params.hideHero
  self.showIndex = self.curChoose
  local hero = game.role.heros[self.heroId]
  self.mType = hero:getPrivateSauceMainType()
  self:initRightWear()
  self.btnOff:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
  self.btnOff:setTouchScale()
  local backBtn = TopBar:getBackBtn():getChildByName("heroListBack")
  if backBtn then
    backBtn:hide()
  end
  for i = 2, 3 do
    self["order" .. i]:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#054b6c"), 1)
    self["order" .. i]:setTouchScale()
  end
  self.order1:hide()
  self.typeBg:hide()
  self.professions = {}
  self.ruleFront = 1
  self.ruleAfter = 1
  self.order2:setString({text = "筛选", size = 20})
  self.order3:setString({
    text = RuleAfterDesc[self.ruleAfter],
    size = 20
  })
  local rule = SauceFrontType[self.ruleFront] .. RuleAfterType[self.ruleAfter]
  self.sauceFilter = FilterLogic.new({
    heros = table.values(game.role.sauces),
    mType = self.mType,
    sortRule = rule
  })
  self.sauceFilter:addEventListener("filter", function(event)
    self:refreshContent()
  end)
  self:setFilter()
  self.order2:setCallback(function()
    local temp = {
      showType = 3,
      professions = self.professions,
      ruleFront = self.ruleFront,
      callback = function(param)
        self:setFilter(param)
      end
    }
    local layer = game:createView("hero.FilterConditionLayer", temp)
  end)
  self.order3:setCallback(function(sender)
    self.ruleAfter = self.ruleAfter + 1
    if self.ruleAfter > #RuleAfterType then
      self.ruleAfter = 1
    end
    self.order3:setString({
      text = RuleAfterDesc[self.ruleAfter],
      size = 20
    })
    self:setFilter()
  end)
  self.list:addCCSEventListener(function(sender, eventType)
    if eventType == 9 then
      local widgetb = self.list:getBottommostItemInCurrentView()
      local bottomRow = self.list:getIndex(widgetb)
      local widgett = self.list:getTopmostItemInCurrentView()
      local topRow = self.list:getIndex(widgett)
      self:loadPage(topRow + 1, bottomRow + 1)
    end
  end)
end

function SauceWearLayer:showData(params)
  HeroHead.new({
    heroId = self.heroId
  }):pos(75, 160):addTo(self.btnsSauceBg)
  self.group = MRadioGroup:create({
    chooseCb = function(sender)
      sender:setPositionX(sender:getPositionX() - 15)
    end,
    unchooseCb = function(sender)
      sender:setPositionX(sender:getPositionX() + 15)
    end
  })
  for index = 1, 1 do
    local btn = self["btn" .. index]
    btn:name("btn" .. index)
    btn:setGroup(self.group)
  end
  self.group:chooseByName("btn1")
end

local cellSize = cc.size(150, 190)

function SauceWearLayer:refreshContent()
  self.btnOff:hide()
  self.list:removeAllChildren()
  self.sauces = {}
  self.rowViews = {}
  self.rowLoaded = {}
  for _, sauce in pairs(self.sauceFilter:getResult()) do
    if sauce.csvData.maintype ~= 0 and not self.rule(sauce) then
      if sauce.id == self.curChoose then
        table.insert(self.sauces, 1, sauce)
      else
        table.insert(self.sauces, sauce)
      end
    end
  end
  self.num:setString(string.format("拥有酱料:%d/%d", #self.sauces, game.role:getMaxSauce()))
  if #self.sauces == 0 then
    local size = self.list:getContentSize()
    local viewNode = ccui.Widget:create()
    viewNode:size(size):addTo(self.list)
    display.newTTFLabel({
      text = "主厨您现在还没有满足筛选条件的酱料哦",
      size = 18,
      color = UIHelper.hex2rgb("#b26b31")
    }):center(viewNode):addTo(viewNode)
    self.list:requestDoLayout()
    return
  end
  local nodeSize = cc.size(self.list:getContentSize().width, cellSize.height)
  for row = 1, math.ceil(#self.sauces / 4) do
    local viewNode = ccui.Widget:create()
    viewNode:setCascadeOpacityEnabled(true)
    viewNode:size(nodeSize):addTo(self.list)
    self.rowViews[row] = viewNode
  end
  self.list:requestDoLayout()
  self:loadPage(1, 3)
end

function SauceWearLayer:loadPage(topRow, buttomRow)
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

function SauceWearLayer:loadList(row)
  local viewNode = self.rowViews[row]
  local colCount = 4
  for index = (row - 1) * colCount + 1, colCount * row do
    if index <= #self.sauces then
      local col = index - (row - 1) * colCount
      local sauce = self.sauces[index]
      local card = SauceSmallCard.new({
        sauceId = sauce.id,
        hideHero = self.hideHero
      })
      card:anch(0, 0):pos(2 + (col - 1) * cellSize.width, 0):addTo(viewNode)
      card:setCallback(function()
        self:cleanSelected()
        self.showIndex = sauce.id
        self:showBtnStatus(sauce.id)
        self.select = display.newSprite("ui/sauce/choose/select.png"):center(card):addTo(card)
        self.detailNode:removeAllChildren()
        game:createView("sauce.SauceDetailLayer", {
          scene = self.detailNode,
          sauceId = sauce.id,
          callback = function()
            if card then
              card:refresh()
            end
          end
        })
      end)
      if self.curChoose == sauce.id then
        display.newSprite(WearRes .. "take_on.png"):pos(75, 100):addTo(card)
      end
      if self.mType == sauce.csvData.maintype then
        display.newSprite("ui/sauce/choose/hero_private.png"):anch(0, 0.5):pos(7, 132):addTo(card)
      end
      if self.showIndex == 0 or self.showIndex == sauce.id then
        self:cleanSelected()
        self.showIndex = sauce.id
        self:showBtnStatus(sauce.id)
        self.select = display.newSprite("ui/sauce/choose/select.png"):center(card):addTo(card)
        self.detailNode:removeAllChildren()
        game:createView("sauce.SauceDetailLayer", {
          scene = self.detailNode,
          sauceId = sauce.id,
          callback = function()
            if card then
              card:refresh()
            end
          end
        })
      end
    end
  end
  self.rowLoaded[row] = true
end

function SauceWearLayer:initRightWear()
  self.equipBg1:removeAllChildren()
  local hero = game.role.heros[self.heroId]
  if hero.sauce and hero.sauce ~= 0 then
    SauceIcon.new({
      id = hero.sauce,
      showHero = false
    }):scale(0.8):center(self.equipBg1):addTo(self.equipBg1)
  else
    display.newSprite("ui/sauce/card/image_cook.png"):scale(0.8):center(self.equipBg1):addTo(self.equipBg1)
  end
end

function SauceWearLayer:showBtnStatus(curId)
  self.btnOff:show()
  if self.curChoose == curId then
    self.btnOff:setString({text = "卸下"})
    self.btnOff:setCallback(function()
      self.callback(0, function()
        self.curChoose = 0
        self.showIndex = 0
        self:initRightWear()
        self:refreshContent()
      end)
    end)
  elseif self.curChoose ~= 0 then
    self.btnOff:setString({text = "替换"})
    self.btnOff:setCallback(function()
      local size = {
        display.width,
        display.height
      }
      if UIHelper.isiPhoneX() then
        size = {2000, 2436}
      end
      local mask = UIHelper.newMask({
        size = cc.size(size[1], size[2]),
        color = "#000000",
        opacity = 191
      })
      mask:anch(0.5, 0.5):pos(size[1] / 2, size[2] / 2):addTo(display.getRunningScene(), 100)
      mask:setTouchEnabled(true)
      mask:setSwallowTouches(true)
      mask:setCallback(function()
        mask:removeSelf()
      end)
      local node1 = display.newNode():pos(385, 605):addTo(mask)
      local node2 = display.newNode():pos(761, 605):addTo(mask)
      game:createView("sauce.SauceDetailLayer", {
        scene = node1,
        sauceId = self.curChoose,
        showBg = 1,
        wear = true
      })
      game:createView("sauce.SauceDetailLayer", {
        scene = node2,
        sauceId = curId,
        showBg = 2,
        cancelCallback = function()
          mask:removeSelf()
        end,
        okCallback = function()
          self.callback(curId, function()
            self.curChoose = curId
            self.showIndex = curId
            self:initRightWear()
            self:refreshContent()
            mask:removeSelf()
          end)
        end
      })
    end)
  else
    self.btnOff:setString({text = "穿戴"})
    self.btnOff:setCallback(function()
      self.callback(curId, function()
        self.curChoose = curId
        self.showIndex = curId
        self:initRightWear()
        self:refreshContent()
      end)
    end)
  end
end

function SauceWearLayer:setFilter(params)
  params = params or {}
  self.showIndex = self.curChoose
  self:cleanSelected()
  self.detailNode:removeAllChildren()
  game:createView("sauce.SauceDetailLayer", {
    scene = self.detailNode
  })
  self.professions = params.professions or self.professions
  self.ruleFront = params.ruleFront or self.ruleFront
  self.sauceFilter:orderByCondition({
    professions = self.professions,
    rule = SauceFrontType[self.ruleFront] .. RuleAfterType[self.ruleAfter]
  })
end

function SauceWearLayer:cleanSelected()
  if not tolua.isnull(self.select) then
    self.select:removeSelf()
    self.select = nil
  end
end

return SauceWearLayer

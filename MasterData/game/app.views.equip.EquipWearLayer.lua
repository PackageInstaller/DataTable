local FilterLogic = import("..equip.FilterEquipLogic")
local WearRes = "ui/equip/wear/"
local uiData = {
  csbFile = "ui/equip/EquipWearLayer.csb",
  widgets = {
    center = "center",
    up = "up",
    upBar = "upBar",
    num = "upBar/num",
    order2 = "upBar/order2",
    order3 = "upBar/order3",
    list = "mainBg/list",
    detailNode = "mainBg/detailNode",
    btnOff = "mainBg/btnOff",
    btnsBg = "btnsBg",
    btn1 = "btnsBg/btn1",
    btn2 = "btnsBg/btn2",
    btn3 = "btnsBg/btn3",
    equipBg1 = "btnsBg/equipBg1",
    equipBg2 = "btnsBg/equipBg2",
    equipBg3 = "btnsBg/equipBg3"
  }
}
local EquipWearLayer = class("EquipWearLayer", UIBase)

function EquipWearLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function EquipWearLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.center)
    self.btnsBg:setPositionX(self.btnsBg:getPositionX() + 125)
  end
  self.center:setTouchEnabled(true)
  self.center:setSwallowTouches(true)
  TopBar:show(TopBarType.full, "装备列表")
  UIHelper.MoveToLeft({
    node = self.btnsBg,
    time = 0.3
  })
  self.heroId = params.heroId
  self.equipGroup = params.group
  self.curPart = params.profession
  self.callback = params.callback
  self.rule = params.rule or function()
    return false
  end
  self:showEquip()
  self.type = params.type or 1
  self.change = false
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
  if not UserData.equipFilter or game.role.majorGuideStep <= MAX_MAJOR_STEP then
    UserData.equipFilter = {}
  end
  if not UserData.equipFilter["1"] then
    UserData.equipFilter["1"] = {
      order1 = {},
      order2 = 1,
      order3 = 1
    }
  end
  local orderData = UserData.equipFilter[tostring(self.type)]
  self.professions = {
    [params.profession] = 1
  }
  self.ruleFront = orderData.order2
  self.ruleAfter = orderData.order3
  self.order2:setString({text = "筛选", size = 20})
  self.order3:setString({
    text = RuleAfterDesc[self.ruleAfter],
    size = 20
  })
  local rule = EquipFrontType[self.ruleFront] .. RuleAfterType[self.ruleAfter]
  self.equipFilter = FilterLogic.new({
    heros = table.values(game.role.equips),
    sortRule = rule
  })
  self.equipFilter:addEventListener("filter", function(event)
    self:refreshContent()
  end)
  self:setFilter()
  self.order2:setCallback(function(sender)
    local layer = game:createView("hero.FilterConditionLayer", {
      professions = self.professions,
      showType = 2,
      ruleFront = self.ruleFront,
      callback = function(param)
        self.change = true
        self:setFilter(param)
      end
    })
  end)
  self.order3:setCallback(function(sender)
    self.change = true
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

function EquipWearLayer:showData(params)
  local hero = game.role.heros[params.heroId]
  if hero then
    HeroHead.new({
      heroId = params.heroId
    }):pos(75, 330):addTo(self.btnsBg)
  end
  self.group = MRadioGroup:create({
    chooseCb = function(sender)
      sender:setPositionX(sender:getPositionX() - 15)
    end,
    unchooseCb = function(sender)
      sender:setPositionX(sender:getPositionX() + 15)
    end
  })
  for index = 1, 3 do
    local btn = self["btn" .. index]
    btn:name("btn" .. index)
    btn:setCallback(function()
      self.professions = {
        [index] = 1
      }
      self.curPart = index
      self:setFilter()
    end)
    btn:setGroup(self.group)
  end
  self.group:chooseByName("btn" .. self.curPart)
end

local cellSize = cc.size(150, 190)

function EquipWearLayer:refreshContent()
  self.btnOff:hide()
  self.list:removeAllChildren()
  self.equips = {}
  self.rowViews = {}
  self.rowLoaded = {}
  for _, equip in pairs(self.equipFilter:getResult()) do
    if not self.rule(equip) then
      if equip.id == self.heroEquips[self.curPart] then
        table.insert(self.equips, 1, equip)
      else
        table.insert(self.equips, equip)
      end
    end
  end
  self.num:setString(string.format("拥有装备:%d/%d", #self.equips, game.role.equipMaxNum))
  if #self.equips == 0 then
    local size = self.list:getContentSize()
    local viewNode = ccui.Widget:create()
    viewNode:size(size):addTo(self.list)
    display.newTTFLabel({
      text = "主厨您现在还没有满足筛选条件的装备哦",
      size = 18,
      color = UIHelper.hex2rgb("#b26b31")
    }):center(viewNode):addTo(viewNode)
    self.list:requestDoLayout()
    return
  end
  local nodeSize = cc.size(self.list:getContentSize().width, cellSize.height)
  for row = 1, math.ceil(#self.equips / 4) do
    local viewNode = ccui.Widget:create()
    viewNode:setCascadeOpacityEnabled(true)
    viewNode:size(nodeSize):addTo(self.list)
    self.rowViews[row] = viewNode
  end
  self.list:requestDoLayout()
  self:loadPage(1, 3)
end

function EquipWearLayer:loadPage(topRow, buttomRow)
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

function EquipWearLayer:loadList(row)
  local viewNode = self.rowViews[row]
  local colCount = 4
  for index = (row - 1) * colCount + 1, colCount * row do
    if index <= #self.equips then
      local col = index - (row - 1) * colCount
      local equip = self.equips[index]
      local card = EquipSmallCard.new({
        equipId = equip.id,
        hideHero = false
      }):name("equipChoose" .. index)
      card:anch(0, 0):pos(2 + (col - 1) * cellSize.width, 0):addTo(viewNode)
      card:setCallback(function()
        self:cleanSelected()
        self.showIndex = equip.id
        self.select = display.newSprite("ui/equip/main/select.png"):center(card):addTo(card)
        self.detailNode:removeAllChildren()
        game:createView("equip.EquipDetailLayer", {
          scene = self.detailNode,
          equipId = equip.id,
          callback = function()
            card:refresh()
          end
        })
        self:showBtnStatus(equip.id, card)
      end)
      if self.heroEquips[self.curPart] == equip.id then
        if not self.showIndex then
          self.showIndex = equip.id
        end
        display.newSprite(WearRes .. "take_on.png"):pos(75, 100):addTo(card)
      end
      if not self.showIndex and index == 1 then
        self.showIndex = equip.id
      end
      if self.showIndex == equip.id then
        self.select = display.newSprite("ui/equip/main/select.png"):center(card):addTo(card)
        self.detailNode:removeAllChildren()
        game:createView("equip.EquipDetailLayer", {
          scene = self.detailNode,
          equipId = equip.id,
          callback = function()
            card:refresh()
          end
        })
        self:showBtnStatus(equip.id, card)
      end
    end
  end
  self.rowLoaded[row] = true
end

function EquipWearLayer:showEquip()
  local hero = game.role.heros[self.heroId]
  local wearGroup = json.decode(hero.prefab or "[]")
  local equips = self.equipGroup and (wearGroup[tostring(self.equipGroup)] or "") or hero.equips
  self.Parts = hero:getCanEquip(checkbool(self.equipGroup))
  self.heroEquips = {}
  for part = 1, 3 do
    local root = self["equipBg" .. part]
    root:removeAllChildren()
    local equipId = equips:getv(part, 0)
    equipId = game.role.equips[equipId] and equipId or 0
    if equipId == 0 then
      local add = UIHelper.newImageView(WearRes .. "add.png"):center(root):addTo(root)
      if not self.Parts[part] then
        UIHelper.setImageViewGray(add)
      end
    else
      EquipIcon.new({id = equipId, showHero = false}):scale(0.8):center(root):addTo(root)
      self.heroEquips[part] = equipId
    end
  end
end

function EquipWearLayer:showBtnStatus(curId, parent)
  self.btnOff:show()
  local oriId = self.heroEquips[self.curPart]
  if oriId == curId then
    self.btnOff:setString({text = "卸下"})
    self.btnOff:setCallback(function()
      self.callback(0, self.curPart, function()
        self:showEquip()
        self:refreshContent()
      end)
    end)
  elseif oriId then
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
      game:createView("equip.EquipDetailLayer", {
        scene = node1,
        equipId = oriId,
        showBg = 1,
        wear = true,
        hideLock = true
      })
      game:createView("equip.EquipDetailLayer", {
        scene = node2,
        equipId = curId,
        showBg = 2,
        hideLock = true,
        cancelCallback = function()
          mask:removeSelf()
        end,
        okCallback = function()
          self.callback(curId, self.curPart, function()
            self:showEquip()
            self:refreshContent()
            mask:removeSelf()
          end)
        end
      })
    end)
  else
    self.btnOff:setString({text = "穿戴"})
    self.btnOff:setCallback(function()
      self.callback(curId, self.curPart, function()
        self:showEquip()
        self:refreshContent()
      end)
    end)
  end
end

function EquipWearLayer:setFilter(params)
  params = params or {}
  self:cleanSelected()
  self.detailNode:removeAllChildren()
  game:createView("equip.EquipDetailLayer", {
    scene = self.detailNode,
    equipId = self.showIndex
  })
  self.ruleFront = params.ruleFront or self.ruleFront
  self.equipFilter:filterByConditions({
    professions = self.professions,
    rule = EquipFrontType[self.ruleFront] .. RuleAfterType[self.ruleAfter]
  })
  self.equipFilter:filterByConditions({
    professions = params.profession
  })
end

function EquipWearLayer:cleanSelected()
  self.showIndex = nil
  if not tolua.isnull(self.select) then
    self.select:removeSelf()
    self.select = nil
  end
end

function EquipWearLayer:onExit()
  if self.change then
    local orderData = UserData.equipFilter[tostring(self.type)]
    orderData.order1 = {}
    orderData.order2 = self.ruleFront
    orderData.order3 = self.ruleAfter
    GameState.save(UserData)
  end
end

return EquipWearLayer

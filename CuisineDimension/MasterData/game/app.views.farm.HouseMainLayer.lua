local MedalCsv = require("csvdata.medal")
local houseRes = "ui/farm/house/"
local uiData = {
  csbFile = "ui/farm/HouseMainLayer.csb",
  widgets = {
    center = "center",
    touch = "mask",
    up = "up",
    listBg = "listBg",
    panel = "panel",
    list = "listBg/list",
    cupNode = "panel/cupNode",
    heroNode = "heroNode"
  }
}
local HouseMainLayer = class("HouseMainLayer", UIBase)

function HouseMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function HouseMainLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.center)
    UIHelper.fitForiPhoneX(self.touch, true)
    UIHelper.fitForiPhoneX(self.up, true)
    self.touch:setPositionX(self.touch:getPositionX() - UIHelper.getMoveXForX())
    self.listBg:setPositionX(self.listBg:getPositionX() + UIHelper.getMoveXForX())
    self.panel:setPositionX(self.panel:getPositionX() + UIHelper.getMoveXForX())
  end
  TopBar:show(TopBarType.full, "次元小屋")
  self.click = 1
  self.selectRow = -1
  self.eyeBtn = UIHelper.extend(ccui.Button:create())
  self.eyeBtn:setImages("ui/home/btns/", {"eye_a.png", "eye_a.png"})
  if UIHelper.isiPhoneX() then
    self.eyeBtn:pos(30 - UIHelper.getMoveXForX(), 35):addTo(self)
  else
    self.eyeBtn:pos(30, 35):addTo(self)
  end
  self.eyeBtn:setTouchScale()
  self.eyeBtn:setCallback(function()
    self:changeUI()
  end)
end

function HouseMainLayer:showData()
  local card = HeroBigCard.new({
    heroId = game.role.crown
  })
  card:pos(0, -85):addTo(self.heroNode)
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up,
    time = 0.5
  })
  UIHelper.MoveToLeft({
    node = self.panel,
    time = 0.3
  })
  self:showCups()
  self:showCupList()
end

function HouseMainLayer:showCups()
  self.cupNode:removeAllChildren()
  local showMedals = json.decode(game.role.farmData.medals)
  local sortMedals = {}
  local sum = self:getTotalActiveMedalsNum()
  for style, id in pairs(showMedals) do
    local data = MedalCsv[tonumber(style)]
    if data and data[id] then
      table.insert(sortMedals, data[id])
    end
  end
  table.sort(sortMedals, function(a, b)
    return a.order < b.order
  end)
  for row = 1, 3 do
    local yPos = -(row - 1) * 112
    for col = 1, 3 do
      local index = (row - 1) * 3 + col
      local xPos = (col - 1) * 125
      local cup
      if not sortMedals[index] then
        cup = UIHelper.newImageView(houseRes .. "cup_1.png")
        if index == #sortMedals + 1 and sum > #sortMedals then
          local flash = display.newSprite(houseRes .. "flash.png"):pos(35, 38):addTo(cup)
          flash:runAction(cc.RepeatForever:create(transition.sequence({
            cc.FadeOut:create(1),
            cc.FadeIn:create(1)
          })))
        end
      else
        cup = UIHelper.newImageView(sortMedals[index].res)
      end
      cup:anch(0.5, 1):pos(xPos, yPos):addTo(self.cupNode)
      cup:setCallback(function()
        local panelX1, panelX2, listX1, listX2 = 1360, 840, 558, 1148
        self:showMask()
        self.panel:runAction(transition.sequence({
          cc.MoveTo:create(0.3, cc.p(panelX1, 320)),
          cc.CallFunc:create(function()
            self:removeMask()
          end)
        }))
        self.listBg:runAction(cc.MoveTo:create(0.3, cc.p(listX1, 303)))
        BackManager:push(function()
          self.selectRow = -1
          self.selectId = 0
          self:showCups()
          self:showCupList()
          self.panel:runAction(cc.MoveTo:create(0.3, cc.p(panelX2, 320)))
          self.listBg:runAction(cc.MoveTo:create(0.3, cc.p(listX2, 303)))
        end)
      end)
    end
  end
end

local size = display.newSprite(houseRes .. "detail_bg.png"):getContentSize()

function HouseMainLayer:showCupList()
  self.list:removeAllChildren()
  local showMedals = json.decode(game.role.farmData.medals) or {}
  local sortMedals = {}
  for style, Set in pairs(MedalCsv) do
    local max = #Set
    if max == 1 then
      local data = Set[max]
      if data.show == 0 or game.role.items[data.item] then
        data.max = max
        table.insert(sortMedals, data)
      end
    else
      local curMaxLeve = 1
      for index, data in ipairs(Set) do
        if game.role.items[data.item] then
          curMaxLeve = data.id
        else
          break
        end
      end
      Set[curMaxLeve].max = max
      table.insert(sortMedals, Set[curMaxLeve])
    end
  end
  table.sort(sortMedals, function(a, b)
    local factorA = (game.role.items[a.item] and 100 or 0) - a.order
    local factorB = (game.role.items[b.item] and 100 or 0) - b.order
    return factorA > factorB
  end)
  local all, col = math.ceil(#sortMedals / 2), 2
  for row = 0, all do
    local viewNode = ccui.Widget:create()
    viewNode:size(size):name(tostring(row)):addTo(self.list)
    local temp = 0
    for index = row * col + 1, (row + 1) * col do
      local medalData = sortMedals[index]
      if medalData then
        local long = temp
        local cell = UIHelper.newImageView(houseRes .. "cell.png"):anch(0, 0):pos(5 + temp * 245, 5):setTag(long):addTo(viewNode)
        cell:setCallback(function()
          self:showCupDetail(medalData, index, long)
        end)
        local cup = UIHelper.newImageView(houseRes .. "cup_2.png"):scale(0.76):pos(45, 45):addTo(cell)
        if game.role.items[medalData.item] then
          cup:setImage(medalData.res)
          local isShow = showMedals[tostring(medalData.style)] and true or false
          local image = isShow and "up.png" or "down.png"
          local change = UIHelper.newImageView(houseRes .. image)
          change:pos(165, 25):addTo(cell)
          change:setCallback(function()
            if table.nums(showMedals) == 9 and not showMedals[tostring(medalData.style)] then
              SysError(SYS_ERR_FARM_MEDAL_SHOW_LIMITED)
              return
            end
            game:sendData(actionCodes.Farm_changeShowMedal, MsgPack.pack({
              style = medalData.style,
              id = medalData.id
            }))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Farm_changeShowMedal, function(event)
              UIHelper.removeWaiting()
              showMedals = json.decode(game.role.farmData.medals) or {}
              isShow = not isShow
              change:setImage(houseRes .. (isShow and "up.png" or "down.png"))
            end)
          end)
        else
          display.newSprite(houseRes .. "mask.png"):pos(37, 92):addTo(cup)
        end
        display.newTTFLabel({
          text = medalData.name,
          size = 24,
          color = UIHelper.hex2rgb("#541f18")
        }):anch(1, 0.5):pos(225, 72):addTo(cell)
        temp = temp + 1
      end
    end
  end
  self.list:requestDoLayout()
end

function HouseMainLayer:showCupDetail(data, index, Pos)
  local selectedRow = math.ceil(index / 2)
  local parent = self.list:getChildByName(tostring(selectedRow))
  if self.selectId == data.item then
    self.selectRow = -1
    self.selectId = 0
    local detail = parent:getChildByName("detail")
    detail:removeSelf()
    self:action("up", selectedRow)
    return
  end
  
  local function create()
    self.selectRow = selectedRow
    self.selectId = data.item
    local viewNode = ccui.Widget:create()
    viewNode:name("detail"):size(size):center(parent):addTo(parent)
    local bg = display.newSprite(houseRes .. "detail_bg.png"):anch(0, 0):pos(5, 0):addTo(viewNode)
    display.newSprite(houseRes .. "angle.png"):pos(80 + Pos * 240, 105):addTo(bg)
    display.newTTFLabel({
      text = "No." .. data.order,
      size = 18,
      color = UIHelper.hex2rgb("#b64e08")
    }):anch(1, 1):pos(465, 91):addTo(bg)
    display.newTTFLabel({
      text = "勋章介绍:",
      size = 18,
      color = UIHelper.hex2rgb("#541f18")
    }):anch(0, 0.5):pos(5, 67):addTo(bg)
    display.newTTFLabel({
      text = data.desc,
      size = 18,
      color = UIHelper.hex2rgb("#b64e08"),
      dimensions = cc.size(400, 40)
    }):anch(0, 1):pos(89, 76):addTo(bg):name("desc")
    if game.role.items[data.item] then
      if data.id == data.max then
        display.newTTFLabel({
          text = "该勋章已升级至最高",
          size = 18,
          color = UIHelper.hex2rgb("#267f03")
        }):anch(0, 0.5):pos(5, 35):addTo(bg)
      else
        display.newTTFLabel({
          text = "升级条件:",
          size = 18,
          color = UIHelper.hex2rgb("#541f18")
        }):anch(0, 0.5):pos(5, 35):addTo(bg)
        display.newTTFLabel({
          text = MedalCsv[data.style][data.id + 1].goal,
          size = 18,
          color = UIHelper.hex2rgb("#267f03")
        }):anch(0, 0.5):pos(89, 35):addTo(bg)
      end
    else
      display.newTTFLabel({
        text = "解锁条件:",
        size = 18,
        color = UIHelper.hex2rgb("#541f18")
      }):anch(0, 0.5):pos(5, 35):addTo(bg)
      display.newTTFLabel({
        text = data.goal,
        size = 18,
        color = UIHelper.hex2rgb("#267f03")
      }):anch(0, 0.5):pos(89, 35):addTo(bg)
    end
  end
  
  if self.selectRow == -1 then
    self:action("down", selectedRow, nil, create)
  else
    local node = self.list:getChildByName(tostring(self.selectRow))
    local detail = node:getChildByName("detail")
    detail:removeSelf()
    if self.selectRow == selectedRow then
      create()
    else
      local big = selectedRow > self.selectRow
      local from = big and self.selectRow or selectedRow
      local to = big and selectedRow - 1 or self.selectRow - 1
      local type = big and "up" or "down"
      self:action(type, from, to, create)
    end
  end
end

function HouseMainLayer:action(type, from, to, callback)
  self:showMask()
  local all = 0
  for style, Set in pairs(MedalCsv) do
    local max = #Set
    if max == 1 then
      local data = Set[max]
      if data.show == 0 or game.role.items[data.item] then
        all = all + 1
      end
    else
      all = all + 1
    end
  end
  local final = to or math.ceil(all / 2)
  for row = from, final do
    local viewNode = self.list:getChildByName(tostring(row))
    for index = 0, 1 do
      local cell = viewNode:getChildByTag(index)
      if cell and type == "up" then
        cell:runAction(cc.MoveTo:create(0.2, cc.p(5 + index * 245, 5)))
      elseif cell and type == "down" then
        cell:runAction(cc.MoveTo:create(0.2, cc.p(5 + index * 245, -98)))
      end
    end
  end
  self.list:runAction(transition.sequence({
    cc.DelayTime:create(0.2),
    cc.CallFunc:create(function()
      if callback then
        callback()
      end
      self:removeMask()
    end)
  }))
end

function HouseMainLayer:getTotalActiveMedalsNum()
  local num = 0
  for style, Set in pairs(MedalCsv) do
    for index, data in ipairs(Set) do
      if game.role.items[data.item] then
        num = num + 1
        break
      end
    end
  end
  return num
end

function HouseMainLayer:changeUI()
  self:showMask()
  if self.click == 1 then
    self.touch:runAction(cc.FadeTo:create(0.4, 0))
    TopBar:moveOut()
    self.panel:runAction(cc.MoveTo:create(0.45, cc.p(self.panel:getPositionX() + 500, 320)))
    self.listBg:runAction(cc.MoveTo:create(0.45, cc.p(self.listBg:getPositionX() + 500, 303)))
    self.up:runAction(cc.MoveTo:create(0.45, cc.p(568, display.height + 60)))
    self.eyeBtn:runAction(transition.sequence({
      cc.MoveTo:create(0.45, cc.p(self.eyeBtn:getPositionX() - 60, 35)),
      cc.CallFunc:create(function()
        self.click = 2
        self.touch:setCallback(function()
          self:changeUI()
        end)
        self:removeMask()
      end)
    }))
  else
    self.touch:runAction(cc.FadeTo:create(0.4, 255))
    TopBar:moveIn()
    self.panel:runAction(cc.MoveTo:create(0.45, cc.p(self.panel:getPositionX() - 500, 320)))
    self.listBg:runAction(cc.MoveTo:create(0.45, cc.p(self.listBg:getPositionX() - 500, 303)))
    self.up:runAction(cc.MoveTo:create(0.45, cc.p(568, display.height)))
    self.eyeBtn:runAction(transition.sequence({
      cc.MoveTo:create(0.45, cc.p(self.eyeBtn:getPositionX() + 60, 35)),
      cc.CallFunc:create(function()
        self.click = 1
        self.touch:setCallback(function()
        end)
        self:removeMask()
      end)
    }))
  end
end

function HouseMainLayer:showMask()
  self.mask = UIHelper.newMask({
    size = cc.size(display.width, display.height),
    opacity = 0
  })
  self.mask:anch(0, 0):pos(0, 0):addTo(display.getRunningScene(), 100)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mask, true)
  end
  self.mask:setTouchEnabled(true)
end

function HouseMainLayer:removeMask()
  if self.mask and not tolua.isnull(self.mask) then
    self.mask:removeSelf()
    self.mask = nil
  end
end

return HouseMainLayer

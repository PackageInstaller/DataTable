local FBuildCsv = require("csvdata.farm_building")
local weatherCsv = require("csvdata.farm_terms")
local unionTechCsv = require("csvdata.union_tech")
local FarmRes = "ui/farm/main/"
local CookRes = "ui/kitchen/cook/"
local BattleRes = "ui/carbon/battle/"
local jobRes = "ui/hero/job/"
local uiData = {
  csbFile = "ui/farm/FarmMainLayer.csb",
  widgets = {
    up = "up",
    upBar = "upBar",
    center = "center",
    termsBg = "upBar/termsBg",
    day = "upBar/termsBg/day",
    week = "upBar/termsBg/week",
    term = "upBar/termsBg/term",
    effect1 = "upBar/termsBg/effect1",
    effect2 = "upBar/termsBg/effect2",
    effect3 = "upBar/termsBg/effect3",
    effect4 = "upBar/termsBg/effect4"
  }
}
local layers = {
  [1] = {
    main = "",
    level = "farm.BuildUpLevelLayer"
  },
  [2] = {
    main = "farm.PlantMainLayer",
    level = "farm.BuildUpLevelLayer"
  },
  [3] = {
    main = "farm.HouseMainLayer",
    level = "farm.BuildUpLevelLayer"
  },
  [5] = {
    main = "",
    level = "farm.BuildUpLevelLayer"
  },
  [6] = {
    main = "trade.TradeMainLayer",
    level = "farm.BuildUpLevelLayer"
  },
  [7] = {
    main = "",
    level = "farm.BuildUpLevelLayer"
  },
  [9] = {
    main = "",
    level = "farm.BuildUpLevelLayer"
  }
}
local FarmMainLayer = class("FarmMainLayer", UIBase)

function FarmMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function FarmMainLayer:init(params)
  game:playMusic(9)
  TopBar:show(TopBarType.full)
  TopBar:showAnimation(true)
  if UIHelper.isiPhoneX() then
    self.upBar:setPositionX(self.upBar:getPositionX() - 85)
  end
  UIHelper.MoveToDown({
    node = self.up,
    delay = 0.1,
    time = 0.4
  })
  UIHelper.MoveToDown({
    node = self.upBar,
    delay = 0.1,
    time = 0.4
  })
  game.role:setRedDirty("plant")
  self.buildNode = {}
  self.handlers = {}
  self.farmData = game.role.farmData
  self.timerHandler = scheduler.scheduleGlobal(function()
    self:showSource()
    self:showMaoxianSource()
  end, 40)
end

local fields = {
  "level3",
  "level4",
  "level1",
  "",
  "level2",
  "level5",
  "level6",
  "",
  "level7"
}

function FarmMainLayer:showData(params)
  local scrollView = cc.ScrollView:create()
  scrollView:anch(0.5, 0.5):pos(display.cx, display.cy):addTo(self.center)
  if UIHelper.isiPhoneX() then
    self.center:scale(UIHelper.getScaleForX())
    scrollView:scale(1 / UIHelper.getScaleForX())
    scrollView:setViewSize(cc.size(display.width * UIHelper.getScaleForX(), display.height * UIHelper.getScaleForX()))
  else
    scrollView:setViewSize(cc.size(display.width, display.height))
  end
  scrollView:setContentSize(cc.size(3408, 1920))
  scrollView:setContentOffset(cc.p(-1136, -640))
  scrollView:setBounceable(false)
  scrollView:setMinScale(0.4)
  scrollView:setMaxScale(1.5)
  self.scrollView = scrollView
  local content = scrollView:getContainer()
  local cloud1 = UIHelper.createSpineNodeByRes("spine/ui/farm/yun_hou"):pos(1704, 960):addTo(content)
  cloud1:setAnimation(0, "special", true)
  display.newSprite(FarmRes .. "bg1.png"):anch(0, 0):addTo(content)
  display.newSprite(FarmRes .. "bg2.png"):anch(0, 0):pos(1704, 0):addTo(content)
  local part = display.newSprite(FarmRes .. "bg_part.png"):pos(2612, 1094):addTo(content)
  part:setLocalZOrder(100)
  local fengche = UIHelper.createSpineNodeByRes("spine/ui/farm/fengche"):pos(705, 1595):addTo(content)
  fengche:setAnimation(0, "special", true)
  local hudie = UIHelper.createSpineNodeByRes("spine/ui/farm/hudie"):pos(1835, 1000):addTo(content)
  hudie:setAnimation(0, "special", true)
  local lizi = UIHelper.createSpineNodeByRes("spine/ui/farm/lizi"):pos(1410, 1105):addTo(content)
  lizi:setAnimation(0, "special", true)
  local cloud2 = UIHelper.createSpineNodeByRes("spine/ui/farm/yun_qian"):pos(1704, 960):addTo(content)
  cloud2:setAnimation(0, "special", true)
  local redPos = {
    [1] = {90, 62},
    [2] = {70, 90},
    [3] = {122, 56},
    [4] = {10, 10},
    [5] = {121, 46},
    [6] = {85, 92},
    [7] = {10, 10}
  }
  self.btnDatas = {
    [1] = {
      name = "store",
      redType = "",
      pos1 = {1050, 1300},
      text = "次元仓库 ",
      pos2 = {10, 75},
      callback = handler(self, self.showFuncBtn)
    },
    [2] = {
      name = "plant",
      redType = "plant",
      pos1 = {2005, 1190},
      text = "次元农场 ",
      pos2 = {-60, 80},
      callback = handler(self, self.showFuncBtn)
    },
    [3] = {
      name = "house",
      redType = "",
      pos1 = {1640, 1120},
      text = "次元小屋 ",
      pos2 = {0, 120},
      callback = handler(self, self.showFuncBtn)
    },
    [4] = {
      name = "diner",
      redType = "",
      pos1 = {1250, 915},
      text = "车库",
      pos2 = {10, 120},
      callback = handler(self, self.showDiner)
    },
    [5] = {
      name = "collect",
      redType = "",
      pos1 = {1490, 800},
      text = "资源采集场 ",
      pos2 = {5, 100},
      callback = handler(self, self.showFuncBtn)
    },
    [6] = {
      name = "trade",
      redType = "trade",
      pos1 = {2285, 770},
      text = "交易所 ",
      pos2 = {-20, 90},
      callback = handler(self, self.showFuncBtn)
    },
    [7] = {
      name = "box",
      redType = "",
      pos1 = {970, 760},
      text = "便当盒",
      pos2 = {0, 90},
      callback = handler(self, self.showFuncBtn)
    },
    [8] = {
      name = "feichuan",
      redType = "",
      pos1 = {2725, 1355},
      text = "邮购艇",
      pos2 = {10, 165},
      callback = handler(self, self.showDraw)
    },
    [9] = {
      name = "maoxian",
      redType = "",
      pos1 = {2098, 503},
      text = "冒险",
      pos2 = {0, 60},
      callback = handler(self, self.showFuncBtn)
    }
  }
  for index, data in ipairs(self.btnDatas) do
    local node = display.newNode():pos(data.pos1[1], data.pos1[2]):addTo(scrollView)
    local image
    if data.name == "feichuan" then
      image = UIHelper.createSpineNodeByRes(FarmRes .. data.name)
      image:setAnimation(0, "idle", true)
    else
      image = UIHelper.newImageView(FarmRes .. data.name .. ".png")
    end
    image:name(data.name):addTo(node)
    local btn = UIHelper.extend(ccui.Layout:create()):name(data.name .. "Btn")
    btn:setContentSize(cc.size(210, 185))
    btn:anch(0.5, 0.5):addTo(node)
    if data.callback then
      local function touchEnd(sender)
        image:setColor(cc.c3b(255, 255, 255))
        
        local beginPos = sender:getBeginPos()
        local endPos = sender:getEndPos()
        if math.abs(beginPos.x - endPos.x) < 20 then
          if data.name == "plant" and not CommonHelper.funcOpen("plant") then
            SysError(SYS_ERR_FUNCOPEN_PLANT)
            return
          end
          data.callback(index)
        end
      end
      
      local function touchBegan(sender)
        image:setColor(cc.c3b(140, 140, 140))
      end
      
      local function touchCancel(sender)
        image:setColor(cc.c3b(255, 255, 255))
      end
      
      btn:setCallbackTotal(touchBegan, nil, touchEnd, touchCancel)
      btn:setSwallowTouches(false)
    end
    if index ~= 4 and index ~= 8 then
      display.newTTFLabel({
        text = data.text .. string.format("Lv%d", self.farmData[fields[index]] or 1),
        size = 24
      }):enableOutline(UIHelper.hex2rgb("#000000"), 2):pos(data.pos2[1], data.pos2[2]):name("text"):addTo(node, 10)
    else
      display.newTTFLabel({
        text = data.text,
        size = 24
      }):enableOutline(UIHelper.hex2rgb("#000000"), 2):pos(data.pos2[1], data.pos2[2]):name("text"):addTo(node, 10)
    end
    self.buildNode[index] = node
    if data.redType ~= "" then
      local bShow = checkbool(next(game.role.redPoints[data.redType] or {}))
      UIHelper.showRedPoint(node, bShow, cc.p(redPos[index][1], redPos[index][2]))
    end
  end
  self:showWeather()
  self:showSource()
  self:showMaoxianSource()
  table.insert(self.handlers, game.role:addEventListener("notifyNewMessage", function(event)
    for index, data in ipairs(self.btnDatas) do
      local root = self.buildNode[index]
      if data.redType ~= "" then
        local bShow = checkbool(next(game.role.redPoints[data.redType] or {}))
        UIHelper.showRedPoint(root, bShow, cc.p(redPos[index][1], redPos[index][2]))
      end
    end
  end))
  local guideLayer = display.getRunningScene():getChildByTag(NEW_GUIDE_LAYER_TAG)
  if guideLayer then
    self.guideStep = guideLayer.guideStep
    if self.guideStep == 10014 then
      self.scrollView:setContentOffsetInDuration(cc.p(-1406, -910), 0.3)
    end
  end
end

local Pos = {
  [1] = {-105, 110},
  [2] = {-33, 150},
  [3] = {48, 150},
  [4] = {120, 110}
}

function FarmMainLayer:showSource()
  local collect = self.buildNode[5]
  local storeData = FBuildCsv[3][game.role.farmData.level3]
  local canDraw, isFull = {}, {}
  local unionData = game.role.unionData
  local unionTechCarry = 0
  if unionData.unionTech and unionData.unionTechHaveCost == 1 then
    local unionTechList = unionData.unionTech:toNumMap()
    for id, data in pairs(unionTechList) do
      if unionTechCsv[id].type == 1 and data == 1 then
        unionTechCarry = unionTechCarry + unionTechCsv[id].count
      end
    end
  end
  for type = 1, 4 do
    local num = game.role["material" .. type]
    if num >= storeData.carry + unionTechCarry then
      canDraw[type] = true
    else
      canDraw[type] = false
    end
    isFull[type] = game.role:drawMaterial(type)
  end
  for type, res in ipairs(isFull) do
    local circle = collect:getChildByTag(type)
    if circle then
      circle:removeSelf()
    end
    if res ~= 0 then
      local newCircle = UIHelper.newImageView(FarmRes .. "circle_bg.png"):pos(Pos[type][1], Pos[type][2]):addTo(collect, nil, type)
      display.newSprite(CookRes .. string.format("material%d.png", type)):scale(0.48):center(newCircle):addTo(newCircle, nil, 1)
      newCircle:setCallback(function()
        self:sendRequest(canDraw)
      end)
      if res == 1 then
        display.newSprite(FarmRes .. "text_max.png"):pos(35, 15):addTo(newCircle, nil, 2)
      end
      local offset = type % 2 == 0 and 10 or -10
      newCircle:runAction(cc.Repeat:create(transition.sequence({
        cc.MoveBy:create(5, cc.p(0, offset)),
        cc.MoveBy:create(5, cc.p(0, -offset)),
        cc.MoveBy:create(5, cc.p(0, -offset)),
        cc.MoveBy:create(5, cc.p(0, offset))
      }), 2))
    end
  end
end

local Pos = {
  [1] = {-180, 70},
  [2] = {-125, 110},
  [3] = {-40, 150},
  [4] = {40, 150},
  [5] = {125, 110},
  [6] = {180, 70}
}

function FarmMainLayer:showMaoxianSource()
  if not CommonHelper.funcOpen("maoxian") then
    return
  end
  local collect = self.buildNode[9]
  local storeData = FBuildCsv[7][game.role.farmData.level7]
  local canDraw, isFull = {}, {}
  local rewards = globalCsv.buildingMaoXianRewards
  for type = 1, 6 do
    local num = game.role.items[rewards[type]] or 0
    if num >= storeData.carry then
      canDraw[type] = true
    else
      canDraw[type] = false
    end
    isFull[type] = game.role:drawMaoxianItem(type)
  end
  for type, res in ipairs(isFull) do
    local circle = collect:getChildByTag(type)
    if circle then
      circle:removeSelf()
    end
    if res ~= 0 then
      local newCircle = UIHelper.newImageView(FarmRes .. "circle_bg.png"):pos(Pos[type][1], Pos[type][2]):addTo(collect, nil, type)
      display.newSprite(jobRes .. string.format("expBook_%d.png", type)):scale(0.48):center(newCircle):addTo(newCircle, nil, 1)
      newCircle:setCallback(function()
        self:sendMaoXianRequest(canDraw)
      end)
      if res == 1 then
        display.newSprite(FarmRes .. "text_max.png"):pos(35, 15):addTo(newCircle, nil, 2)
      end
      local offset = type % 2 == 0 and 10 or -10
      newCircle:runAction(cc.Repeat:create(transition.sequence({
        cc.MoveBy:create(5, cc.p(0, offset)),
        cc.MoveBy:create(5, cc.p(0, -offset)),
        cc.MoveBy:create(5, cc.p(0, -offset)),
        cc.MoveBy:create(5, cc.p(0, offset))
      }), 2))
    end
  end
end

function FarmMainLayer:showWeather()
  local nT = CommonHelper.date(nil, nil, true)
  local weekCount = math.floor(game.role.openDays / 7) + 1
  local curWeek = weekCount % table.nums(weatherCsv) + 1
  local weatherSet = weatherCsv[curWeek]
  self.term:setString(weatherSet.name)
  local weeks = {
    "日",
    "一",
    "二",
    "三",
    "四",
    "五",
    "六"
  }
  self.day:setString(nT.day)
  self.week:setString("星期" .. weeks[nT.wday])
  local effects = weatherSet.effect:toNumMap()
  for index = 1, 4 do
    self["effect" .. index]:removeAllChildren()
    if 0 < effects[index] then
      display.newSprite(FarmRes .. "up.png"):addTo(self["effect" .. index])
    elseif effects[index] < 0 then
      display.newSprite(FarmRes .. "down.png"):addTo(self["effect" .. index])
    end
  end
  self.day:runAction(transition.sequence({
    cc.DelayTime:create(0.5),
    cc.CallFunc:create(function()
      local signData = json.decode(game.role.sign)
      if not self.guideStep and (not signData[tostring(nT.day)] or nT.month ~= signData[tostring(nT.day)] or next(game.role.redPoints.sign or {})) then
        game:createView("farm.SignLayer")
      end
    end)
  }))
  self.termsBg:setCallback(function()
    game:createView("farm.SignLayer")
  end)
end

function FarmMainLayer:showSub()
  game:createView("farm.SubMainLayer")
end

function FarmMainLayer:showDiner()
  if game.role.createTime < CommonHelper.toUnixtime("201801040930") then
    if not CommonHelper.funcOpen("dinerCar") then
      SysError(SYS_ERR_FUNCOPEN_DINER_CAR)
      return
    end
  elseif not CommonHelper.funcOpen("dinerCarNew") then
    SysError(SYS_ERR_FUNCOPEN_DINER_CAR_NEW)
    return
  end
  game.role:requestDinerInfo(function()
    local layer = game:createView("diner.DinerMainLayer")
    self:hide()
    BackManager:push(function()
      TopBar:show(TopBarType.full)
      self:show()
      layer:close()
    end)
  end)
end

function FarmMainLayer:showBox()
  game.role:requestDinerInfo(function()
    game:enterScene("DinerScene")
    BackManager:push(function()
      game:enterScene("MainScene", {layer = "farm"})
    end)
  end)
end

function FarmMainLayer:showDraw()
  if not CommonHelper.funcOpen("dinerCar") then
    SysError(SYS_ERR_FUNCOPEN_DINER_DRAW)
    return
  end
  game.role:requestDinerInfo(function()
    local layer = game:createView("diner.DinerDrawLayer")
    self:hide()
    BackManager:push(function()
      TopBar:show(TopBarType.full)
      self:show()
      layer:close()
    end)
  end)
end

function FarmMainLayer:refreshIndexLevel(index)
  local node = self.buildNode[index]
  local text = node:getChildByName("text")
  local xPos, yPos = 0, 0
  if text then
    xPos, yPos = text:getPosition()
    text:removeSelf()
  end
  if index ~= 4 and index ~= 8 then
    display.newTTFLabel({
      text = self.btnDatas[index].text .. string.format("Lv%d", self.farmData[fields[index]] or 1),
      size = 24
    }):enableOutline(UIHelper.hex2rgb("#000000"), 2):pos(xPos, yPos):name("text"):addTo(node, 10)
    return
  end
  display.newTTFLabel({
    text = self.btnDatas[index].text,
    size = 24
  }):enableOutline(UIHelper.hex2rgb("#000000"), 2):pos(xPos, yPos):name("text"):addTo(node, 10)
end

function FarmMainLayer:sendMaoXianRequest(canDraw)
  local collect = self.buildNode[9]
  local xPos = 530
  if UIHelper.isiPhoneX() then
    xPos = xPos + UIHelper.getMoveXForX()
  end
  if not CommonHelper.funcOpen("maoxian") then
    return
  end
  game:sendData(actionCodes.Farm_drawMaoxianItem, MsgPack.pack({}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Farm_drawMaoxianItem, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    local result, isTip = json.decode(msg.num), false
    for type, num in ipairs(result) do
      if canDraw[type] then
        isTip = true
      else
        local circle = collect:getChildByTag(type)
        if not tolua.isnull(circle) then
          circle:stopAllActions()
          local base = circle:getChildByTag(1)
          if base then
            local offset = base:convertToWorldSpace(cc.p(base:getPosition()))
            circle:removeAllChildren()
            local image = display.newSprite(jobRes .. string.format("expBook_%d.png", type)):scale(0.48):pos(offset.x, offset.y + 8):addTo(self)
            circle:runAction(transition.sequence({
              cc.FadeOut:create(0.05),
              cc.RemoveSelf:create()
            }))
            self:jumpSprite(image, num, {
              offset.x,
              offset.y + 8
            })
          end
        end
      end
    end
    if isTip then
      SysError(SYS_ERR_FARM_CARRY_RESOURCE_FULL)
    end
    game.role:setRedDirty("collect")
  end)
end

function FarmMainLayer:sendRequest(canDraw)
  local collect = self.buildNode[5]
  local xPos = 530
  if UIHelper.isiPhoneX() then
    xPos = xPos + UIHelper.getMoveXForX()
  end
  game:sendData(actionCodes.Farm_drawMaterial, MsgPack.pack({}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Farm_drawMaterial, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    local result, isTip = json.decode(msg.num), false
    for type, num in ipairs(result) do
      if canDraw[type] then
        isTip = true
      else
        local circle = collect:getChildByTag(type)
        if not tolua.isnull(circle) then
          circle:stopAllActions()
          local base = circle:getChildByTag(1)
          if base then
            local offset = base:convertToWorldSpace(cc.p(base:getPosition()))
            circle:removeAllChildren()
            local image = display.newSprite(CookRes .. string.format("material%d.png", type)):scale(0.48):pos(offset.x, offset.y + 5):addTo(self)
            circle:runAction(transition.sequence({
              cc.FadeOut:create(0.05),
              cc.RemoveSelf:create()
            }))
            image:runAction(transition.sequence({
              cc.Spawn:create(cc.MoveTo:create(0.3, cc.p(xPos + (type - 1) * 120, 625)), cc.ScaleTo:create(0.3, 0.1)),
              cc.RemoveSelf:create()
            }))
            self:jumpText(num, {
              xPos + 20 + (type - 1) * 120,
              595
            })
          end
        end
      end
    end
    if isTip then
      SysError(SYS_ERR_FARM_CARRY_RESOURCE_FULL)
    end
    game.role:setRedDirty("collect")
  end)
end

function FarmMainLayer:jumpSprite(image, num, pos)
  image:runAction(cc.Sequence:create({
    cc.Spawn:create({
      cc.FadeIn:create(0.3),
      cc.MoveBy:create(0.5, cc.p(0, 5))
    }),
    cc.DelayTime:create(0.9),
    cc.Spawn:create({
      cc.FadeOut:create(0.5),
      cc.MoveBy:create(0.5, cc.p(0, 15))
    }),
    cc.RemoveSelf:create()
  }))
  if num <= 0 then
    return
  end
  local label = display.newTTFLabel({
    text = "+" .. num,
    size = 26,
    color = display.COLOR_GREEN
  }):enableOutline(UIHelper.hex2rgb("#2c0000"), 2):anch(0, 0.5):pos(pos[1] + 20, pos[2]):addTo(self)
  label:runAction(cc.Sequence:create({
    cc.Spawn:create({
      cc.FadeIn:create(0.3),
      cc.MoveBy:create(0.5, cc.p(0, 5))
    }),
    cc.DelayTime:create(0.9),
    cc.Spawn:create({
      cc.FadeOut:create(0.5),
      cc.MoveBy:create(0.5, cc.p(0, 15))
    }),
    cc.RemoveSelf:create()
  }))
end

function FarmMainLayer:jumpText(num, pos)
  if num <= 0 then
    return
  end
  local label = display.newTTFLabel({
    text = "+" .. num,
    size = 26,
    color = display.COLOR_GREEN
  }):enableOutline(UIHelper.hex2rgb("#2c0000"), 2):pos(pos[1], pos[2]):addTo(TopBar)
  label:runAction(cc.Sequence:create({
    cc.Spawn:create({
      cc.FadeIn:create(0.3),
      cc.MoveBy:create(0.5, cc.p(0, 5))
    }),
    cc.DelayTime:create(0.9),
    cc.Spawn:create({
      cc.FadeOut:create(0.5),
      cc.MoveBy:create(0.5, cc.p(0, 15))
    }),
    cc.RemoveSelf:create()
  }))
end

local names = {
  [1] = "level",
  [2] = "enter"
}

function FarmMainLayer:showFuncBtn(index)
  if index == 7 and not CommonHelper.funcOpen("box") then
    SysError(SYS_ERR_FUNCOPEN_DINER_BOX)
    return
  end
  if index == 9 and not CommonHelper.funcOpen("maoxian") then
    SysError(SYS_ERR_FUNCOPEN_MAOXIAN)
    return
  end
  self.lastBtn = self.curBtn
  self.curBtn = self.buildNode[index]
  if self.curBtn == self.lastBtn then
    self:removeBtns(true)
    self.curBtn = nil
    self.lastBtn = nil
    return
  end
  self:removeBtns()
  for type, name in ipairs(names) do
    local btn = UIHelper.newImageView(FarmRes .. name .. ".png"):pos(100, 40 - (type - 1) * 70):name(name .. "Btn"):addTo(self.curBtn)
    btn:setCallback(function()
      self:removeBtns(true)
      if type == 1 then
        _G.touchMaskEnabled = true
        local layer = game:createView(layers[index].level, {index = index})
        BackManager:push(function()
          layer:close()
          _G.touchMaskEnabled = false
          self.farmData = game.role.farmData
          self:refreshIndexLevel(index)
        end)
      elseif index == 7 then
        self:showBox()
      elseif index == 6 then
        game:sendData(actionCodes.Trade_getInfoRpc, MsgPack.pack({}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Trade_getInfoRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          game.role.tradeData = msg
          if next(msg) then
            _G.touchMaskEnabled = true
            local layer = game:createView(layers[index].main)
            self:hide()
            BackManager:push(function()
              self:show()
              layer:close()
              _G.touchMaskEnabled = false
              TopBar:show(TopBarType.full)
            end)
          end
        end)
      else
        _G.touchMaskEnabled = true
        local layer = game:createView(layers[index].main)
        self:hide()
        BackManager:push(function()
          self:show()
          layer:close()
          _G.touchMaskEnabled = false
          TopBar:show(TopBarType.full)
        end)
      end
    end)
    btn:runAction(transition.sequence({
      cc.ScaleTo:create(0.08, 1.1),
      cc.ScaleTo:create(0.05, 1)
    }))
    if index == 1 and type == 2 then
      btn:hide()
    elseif (index == 5 or index == 9) and type == 2 then
      btn:hide()
    end
  end
end

function FarmMainLayer:removeBtns(cur)
  local names = {
    [1] = "levelBtn",
    [2] = "enterBtn"
  }
  local Btn = cur and self.curBtn or self.lastBtn
  if not Btn or tolua.isnull(Btn) then
    return
  end
  for _, name in ipairs(names) do
    local btn = Btn:getChildByName(name)
    if btn and not tolua.isnull(btn) then
      btn:removeSelf()
    end
  end
  if cur then
    self.curBtn = nil
  end
end

function FarmMainLayer:onEnter()
  _G.touchMaskEnabled = false
end

function FarmMainLayer:onExit()
  _G.touchMaskEnabled = true
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
  scheduler.unscheduleGlobal(self.timerHandler)
  self.timerHandler = nil
end

return FarmMainLayer

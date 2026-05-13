local DishTypeCsv = require("csvdata.diner_dish_type")
local CarCsv = require("csvdata.diner_car")
local DishCsv = require("csvdata.diner_dish")
local SellCsv = require("csvdata.diner_sell")
local ChapterInfoCsv = require("csvdata.chapter_info")
local ItemCsv = require("csvdata.item")
local FoodCsv = require("csvdata.food_pic")
local AccessCsv = require("csvdata.diner_accessory")
local ConditionCsv = require("csvdata.diner_sellcondition")
local BuildingCsv = require("csvdata.farm_building")
local SysErrCsv = require("csvdata.sys_codes")
local SellRes = "ui/diner/sell/"
local SpineCarRes = "diner/car/"
local uiData = {
  csbFile = "ui/diner/DinerSellMainLayer.csb",
  widgets = {
    up = "up",
    mainBg = "mainBg",
    touch = "touch",
    panelBg2 = "panelBg2",
    panelBg3 = "panelBg3",
    count = "panelBg1/count",
    mapList = "panelBg1/mapList",
    carNode = "panelBg2/infoBg1/carNode",
    info1 = "panelBg2/infoBg1/info1",
    info2 = "panelBg2/infoBg2/info2",
    info3 = "panelBg2/infoBg3/info3",
    extra = "panelBg2/extra",
    dinerNode = "panelBg2/dinerNode",
    panelBg3 = "panelBg3",
    mask = "panelBg3/mask",
    btnOk = "panelBg3/btnOk",
    list = "panelBg3/list",
    num = "panelBg3/num",
    btnNode = "panelBg3/btnNode"
  }
}
local DinerSellMainLayer = class("DinerSellMainLayer", UIBase)

function DinerSellMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function DinerSellMainLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
    UIHelper.fitForiPhoneX(self.touch)
    self.panelBg2:setPositionX(self.panelBg2:getPositionX() + UIHelper.getMoveXForX())
    self.panelBg3:setPositionX(self.panelBg3:getPositionX() + UIHelper.getMoveXForX())
  end
  TopBar:show(TopBarType.full, "营业")
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up,
    time = 0.5
  })
  self.chooseList = {}
  self.tempList = {}
  self.allDish = {}
  self.dinerStatus = {}
  self.dishType = params.type or 1
  self.chooseMax = 5
  self.dailyLimit = 0
  self.mapId = 0
  self.mapIdLock = true
  self.mapCell = {}
  self.reward = {}
  self.condition = {}
  self.btnOk:setTouchScale()
  self.btnOk:setCallback(function()
    self.chooseList = nil
    self.chooseList = self.tempList
    BackManager:pop()
  end)
  self.mask:setTouchEnabled(true)
  self.mask:setSwallowTouches(true)
  self.touch:setTouchEnabled(true)
  self.touch:setSwallowTouches(true)
  self.touch:setOpacity(0)
  self.touch:hide()
  display.newTTFLabel({text = "完成", size = 20}):enableOutline(UIHelper.hex2rgb("#9c3a13"), 1):center(self.btnOk):addTo(self.btnOk)
  self:initTypeBtns()
  UIHelper.showPageGuide(10019)
end

function DinerSellMainLayer:showData(params)
  self.chooseList = {}
  self.origin = nil
  self.diner = nil
  self:getAllDish()
  self:initPanel1()
end

function DinerSellMainLayer:showSellNoOpenErr(id)
  if mapId == 100 and not game.role:activityIsOpen(99) then
    SysError(SYS_ERR_DINER_SELL_ACTIVITY_NOT_OPEN)
    return
  end
  return true
end

function DinerSellMainLayer:getAllDish()
  self.allDish = {}
  self.dinerStatus = {}
  self.mapIdLock = true
  local usedDish = {}
  local sellInfo = json.decode(game.role.diner.sellInfo) or {}
  for _, data in pairs(sellInfo.sell or {}) do
    for mapId, set in pairs(data.heros) do
      usedDish[set.id] = true
    end
    if data.diner and data.diner ~= 0 then
      self.dinerStatus[data.diner] = 1
    end
  end
  for _, data in pairs(game.role.diner.diners) do
    if data.car and data.car ~= 0 and not self.dinerStatus[data.id] then
      self.dinerStatus[data.id] = 0
      self.mapIdLock = false
    end
  end
  for _, hero in pairs(game.role.heros) do
    if DishCsv[hero.type] and DishCsv[hero.type].open == 1 and 1 <= hero.loveBreak and not usedDish[hero.id] then
      local temp = clone(DishCsv[hero.type])
      temp.heroId = hero.id
      temp.level = self:getDishLevel(hero.loveBreak)
      table.insert(self.allDish, temp)
    end
  end
  table.sort(self.allDish, function(a, b)
    return a.level > b.level
  end)
end

function DinerSellMainLayer:initPanel1()
  self.mapCell = {}
  self.mapList:removeAllChildren()
  local Info = json.decode(game.role.diner.sellInfo) or {}
  self.dailyLimit = Info.limit
  local mapArray = {}
  for mapId, _ in pairs(SellCsv) do
    if mapId ~= 100 or game.role:activityIsOpen(99) then
      mapArray[#mapArray + 1] = mapId
    end
  end
  table.sort(mapArray)
  for _, mapId in ipairs(mapArray) do
    local Set = SellCsv[mapId]
    local info = Info.sell[tostring(mapId)]
    if Set and info then
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(cc.size(626, 124)):addTo(self.mapList)
      local open = game.role.carbons[Set[1].open] and true or false
      local str = open and "map_open_" or "map_lock_"
      local cell = UIHelper.newImageView(SellRes .. string.format("%s%d.png", str, mapId % 100)):center(viewNode):addTo(viewNode)
      local titleBg = display.newSprite(SellRes .. "cell_title_bg.png"):anch(0, 0.5):pos(2, 57):addTo(cell)
      if not open then
        display.newSprite(SellRes .. "image_lock.png"):pos(565, 53):addTo(cell)
        local openChapter = math.floor(Set[1].open / 100) - 1
        local str = string.format("通关%s轻污染%02d区解锁", ChapterInfoCsv[openChapter].name, ChapterInfoCsv[openChapter].dungeonNum)
        display.newTTFLabel({text = str, size = 26}):enableOutline(UIHelper.hex2rgb("#4b2200"), 1):anch(0, 0.5):pos(5, 28):addTo(titleBg)
        cell:setCallback(function()
          SysError(SYS_ERR_STORY_AREA_UNLOCK)
        end)
      else
        local group = info.nowGroup ~= 0 and info.nowGroup or info.aimGroup
        local mapData = Set[group]
        local blocks = {}
        display.newTTFLabel({
          text = mapData.name,
          size = 26
        }):enableOutline(UIHelper.hex2rgb("#4b2200"), 1):anch(0, 0.5):pos(5, 40):addTo(titleBg)
        local image = display.newSprite(SellRes .. "cell_block_w.png"):pos(15, 15):addTo(titleBg)
        local cost = display.newTTFLabel({
          text = "消耗食材: " .. mapData.energy,
          size = 16
        }):enableOutline(UIHelper.hex2rgb("#4b2200"), 1):anch(0, 0.5):pos(25, 17):addTo(titleBg)
        if info.diner and info.diner ~= 0 then
          if self.mapIdLock and self.mapId == 0 then
            self.mapId = mapId
          end
          local btnLook = UIHelper.extend(ccui.Button:create())
          btnLook:setImages("ui/global/", {"look.png", "look.png"})
          btnLook:pos(590, 28):addTo(cell):hide()
          local bg = display.newSprite(SellRes .. "diner_index_bg.png"):anch(0, 1):pos(10, 115):addTo(cell)
          display.newTTFLabel({
            text = "餐车" .. info.diner,
            size = 22
          }):enableOutline(UIHelper.hex2rgb("#881e09"), 1):pos(60, 18):addTo(bg)
          local timeBg = display.newSprite(SellRes .. "state_left.png"):pos(530, 98):addTo(cell)
          local time = display.newTTFLabel({text = "", size = 20}):enableOutline(UIHelper.hex2rgb("#4f3924"), 1):pos(80, 20):addTo(timeBg)
          if info.subUp then
            display.newSprite("ui/farm/sub/image_sub.png"):anch(1, 0.5):pos(14, 20):addTo(timeBg)
          end
          local left = info.time - game:nowTime()
          if 0 < left then
            local function refresh()
              left = info.time - game:nowTime()
              
              if 0 < left then
                time:runAction(transition.sequence({
                  cc.CallFunc:create(function()
                    time:setString("营业中: " .. UIHelper.getTimeStr(left))
                  end),
                  cc.DelayTime:create(1),
                  cc.CallFunc:create(function()
                    refresh()
                  end)
                }))
              else
                time:setString("等待结算")
                btnLook:hide()
                if self.mapId == mapId then
                  self:showExtraInfo()
                end
              end
            end
            
            refresh()
            btnLook:show()
            btnLook:setTouchScale()
            btnLook:setCallback(function()
              local layer = game:createView("diner.DinerSellAnimateLayer", {
                dinerId = info.diner,
                mapId = mapId,
                groupId = group
              })
              self:hide()
              BackManager:push(function()
                self:show()
                layer:close()
                TopBar:show(TopBarType.full, "营业")
              end)
            end)
          else
            time:setString("等待结算")
          end
        else
          display.newSprite(SellRes .. "image_time.png"):pos(15, 17):addTo(cell)
          display.newTTFLabel({
            text = UIHelper.getTimeStr(mapData.time),
            size = 20
          }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0, 0.5):pos(26, 18):addTo(cell)
          local bg = display.newSprite(SellRes .. "cell_desc_bg.png"):pos(529, 59):addTo(cell)
          display.newTTFLabel({
            text = "人群偏好",
            size = 16,
            color = UIHelper.hex2rgb("#ffd34c")
          }):enableOutline(UIHelper.hex2rgb("#4b2200"), 1):anch(0, 0.5):pos(9, 103):addTo(bg)
          display.newTTFLabel({
            text = "银币加成",
            size = 16,
            color = UIHelper.hex2rgb("#ffd34c")
          }):enableOutline(UIHelper.hex2rgb("#4b2200"), 1):anch(0, 0.5):pos(102, 103):addTo(bg)
          local yPos = 84
          for _, conId in ipairs(mapData.require:toArray("=", true)) do
            local conData = ConditionCsv[conId]
            local block = display.newSprite(SellRes .. "cell_block_w.png"):pos(17, yPos - 2):addTo(bg)
            display.newTTFLabel({
              text = conData.desc,
              size = 16
            }):enableOutline(UIHelper.hex2rgb("#4b2200"), 1):anch(0, 0.5):pos(25, yPos):addTo(bg)
            display.newTTFLabel({
              text = string.format("+%d%%", conData.effect),
              size = 16
            }):enableOutline(UIHelper.hex2rgb("#4b2200"), 1):anch(1, 0.5):pos(165, yPos):addTo(bg)
            blocks[conId] = block
            yPos = yPos - 17
          end
          if not self.mapIdLock and self.mapId == 0 then
            self.mapId = mapId
          end
        end
        
        function cell.refresh()
          if self.mapIdLock or info.time and info.time > 0 then
            return
          end
          local num = self.sellInfo.time and 0 < self.sellInfo.time and 0 or self.reward.material
          local min = math.max(mapData.energy + num, 1)
          cost:setString("消耗食材: " .. min)
          if self.diner then
            local temp = min <= (self.diner.material or 0) and "cell_block_g.png" or "cell_block_r.png"
            image:setTexture(SellRes .. temp)
          end
          for conId, block in pairs(blocks) do
            local sprite = self.condition[conId] and "cell_block_g.png" or "cell_block_r.png"
            block:setTexture(SellRes .. sprite)
          end
        end
        
        cell:setCallback(function()
          if self.mapIdLock and (not info.diner or info.diner == 0) then
            SysError(SYS_ERR_DINER_SELL_SLOT_NOT_ENOUGH)
            return
          end
          if info.time and info.time ~= 0 and game:nowTime() >= info.time then
            if not self:showSellNoOpenErr(mapId) then
              return
            end
            game:sendData(actionCodes.Diner_finishSellRpc, MsgPack.pack({chapter = mapId}))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Diner_finishSellRpc, function(event)
              UIHelper.removeWaiting()
              local msg = MsgPack.unpack(event.data)
              if next(msg.reward) then
                MedalRewardLayer.new({
                  items = msg.reward
                })
              end
              self:showData()
            end)
            return
          elseif self.mapId == mapId then
            return
          end
          self.mapId = mapId
          self.sellInfo = info
          self.select:removeSelf()
          self.select = display.newSprite(SellRes .. "image_select_map.png"):center(cell):addTo(cell)
          self:showInfo1()
        end)
        table.insert(self.mapCell, cell)
        if self.mapId == mapId then
          if not tolua.isnull(self.select) then
            self.select:removeSelf()
            self.select = nil
          end
          self.sellInfo = info
          self.select = display.newSprite(SellRes .. "image_select_map.png"):center(cell):addTo(cell)
        end
      end
    end
  end
  if self.mapId == 0 then
    self.mapId = 101
    self.sellInfo = Info.sell["101"]
    self.select = display.newSprite(SellRes .. "image_select_map.png"):center(self.mapCell[1]):addTo(self.mapCell[1])
  end
  self:showInfo1()
  self.count:setString(string.format("今日剩余营业次数: %d/%d", globalCsv.sellDailyLimit - self.dailyLimit, globalCsv.sellDailyLimit))
  self.mapList:requestDoLayout()
end

function DinerSellMainLayer:initDinerBtns()
  self.dinerNode:removeAllChildren()
  self.dinerGroup = nil
  if self.diner and self.diner:getSellState() then
    return
  end
  self.dinerGroup = MRadioGroup:create()
  local yPos = 0
  for index, data in ipairs(game.role.diner.diners) do
    if data.car and 0 < data.car then
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(SellRes, {
        "btn_diner_a.png",
        "btn_diner_b.png"
      })
      btn:anch(1, 0.5):pos(0, yPos):name("btn" .. data.id)
      btn:addTo(self.dinerNode)
      btn:setGroup(self.dinerGroup)
      btn:setCallback(function()
        if data:getSellState() then
          local content = SysErrCsv[SYS_ERR_DINER_SELL_IS_BUSY_INDEX].content
          MFlashMsg:show({
            text = string.format(content, data.id)
          })
          self.dinerGroup:chooseByName("btn" .. self.diner.id)
          return
        end
        self:checkResetChooseList(data.id)
        self:showInfo2()
        self:showInfo3()
        self:showDinerDetail()
      end)
      display.newTTFLabel({
        text = "餐车" .. data.id,
        size = 20
      }):enableOutline(UIHelper.hex2rgb("#9c3a13"), 1):anch(1, 0.5):pos(79, 20):addTo(btn)
      yPos = yPos - 42
    end
  end
end

function DinerSellMainLayer:checkResetChooseList(dinerId)
  local oldId
  if self.origin then
    local busy = self.origin:getSellState()
    if busy then
      self.chooseList = {}
    else
      oldId = self.origin.id
    end
  end
  if self.diner then
    self.origin = self.diner
    local busy = self.diner:getSellState()
    if busy then
      self.origin = nil
      self.chooseList = {}
    else
      oldId = self.origin.id
    end
  end
  local nextId = dinerId and dinerId or self:getDinerId(oldId)
  self.diner = game.role.diner.diners[nextId]
  local busy, mapData = self.diner:getSellState()
  if busy then
    self.chooseList = {}
    for _, data in pairs(mapData.heros or {}) do
      self.chooseList[data.id] = data
    end
  end
end

function DinerSellMainLayer:showInfo1()
  self:checkResetChooseList()
  self:initDinerBtns()
  if not (self.origin and self.diner) or self.origin.id ~= self.diner.id then
    self:showInfo2()
    self:showDinerDetail()
  end
  if self.dinerGroup then
    self.dinerGroup:chooseByName("btn" .. self.diner.id)
  end
  self:showInfo3()
end

function DinerSellMainLayer:showDinerDetail()
  self.carNode:removeAllChildren()
  self.info1:removeAllChildren()
  local carData = CarCsv[self.diner.car]
  display.newTTFLabel({
    text = carData.name,
    size = 18,
    color = UIHelper.hex2rgb("#544633")
  }):pos(82, -21):addTo(self.info1)
  local locat = carData.pos:toTableArray()
  local scaleCar = carData.size == 0 and 0.6 or carData.size
  local car = UIHelper.createSpineNodeByRes(SpineCarRes .. carData.res)
  car:scale(scaleCar):pos(tonumber(locat[1][1]), tonumber(locat[1][2])):addTo(self.carNode)
  car:setAnimation(0, "idle", true)
  local accessStr = self.diner.accessories or ""
  for index, id in pairs(accessStr:toNumMap()) do
    local accessData = AccessCsv[game.role.diner.accessories[id].type]
    if accessData.type == 3 then
      local scaleAcc = accessData.size == 0 and 0.6 or accessData.size
      local locat = accessData.pos ~= "" and accessData.pos:toTableArray() or {
        {0, 0},
        {0, 0}
      }
      local spine = UIHelper.createSpineNodeByRes(accessData.spine):pos(tonumber(locat[1][1] * 0.6 - 80), tonumber(locat[1][2] * 0.6 + 9))
      if index % 100 == 2 then
        spine:pos(tonumber(locat[2][1] * 0.6 + 80), tonumber(locat[2][2] * 0.6 - 6))
      else
        spine:setLocalZOrder(-1)
      end
      spine:scale(scaleAcc):addTo(self.carNode)
      spine:setAnimation(0, "idle", true)
    end
  end
  if self.dinerStatus[self.diner.id] == 1 then
    local stateBg = display.newSprite(SellRes .. "image_busy.png"):pos(360, -220):addTo(self.info1)
  end
  local str = string.format("食材:<div color=#008000>%d</div>", self.diner.material or 0)
  local label = MRichText.new({
    text = str,
    size = 18,
    color = UIHelper.hex2rgb("#544633")
  }):anch(0, 0.5):pos(170, -21):addTo(self.info1)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(SellRes, {
    "btn_supply.png",
    "btn_supply.png"
  })
  btn:pos(255, -23):addTo(self.info1)
  btn:setCallback(function()
    if self.dinerStatus[self.diner.id] == 1 then
      SysError(SYS_ERR_DINER_SELL_IS_BUSY)
      return
    end
    game:createView("diner.DinerSupplyLayer", {
      diner = self.diner.id,
      func = function()
        label:setString(string.format("食材:<div color=#008000>%d</div>", self.diner.material or 0))
        self:updateReward()
      end
    })
  end)
end

function DinerSellMainLayer:showInfo2()
  self.info2:removeAllChildren()
  display.newTTFLabel({
    text = "选择菜品",
    size = 20,
    color = UIHelper.hex2rgb("#765b44")
  }):pos(73, -13):addTo(self.info2)
  local max = #globalCsv.dishLevel:toTableArray()
  
  local function callback(parent)
    if self.dinerStatus[self.diner.id] == 1 then
      SysError(SYS_ERR_DINER_SELL_IS_BUSY)
      return
    end
    parent:setTouchEnabled(false)
    self.touch:show()
    self:showChooseDish()
    self.touch:runAction(cc.FadeTo:create(0.1, 191))
    self.panelBg3:runAction(transition.sequence({
      cc.MoveBy:create(0.2, cc.p(-500, 0)),
      cc.CallFunc:create(function()
        self.touch:setCallback(function()
          BackManager:pop()
        end)
      end)
    }))
    BackManager:push(function()
      self.touch:setCallback(function()
      end)
      self.tempList = {}
      self:showInfo2()
      self:showInfo3()
      self.panelBg3:runAction(cc.MoveBy:create(0.2, cc.p(500, 0)))
      self.touch:runAction(transition.sequence({
        cc.FadeOut:create(0.1),
        cc.CallFunc:create(function()
          self.touch:hide()
        end)
      }))
    end)
  end
  
  local xPos = 46
  local index = 1
  for id, data in pairs(self.chooseList) do
    local bg = UIHelper.newImageView("ui/global/item_bg.png"):scale(0.9):pos(xPos, -70):addTo(self.info2)
    display.newSprite(DishCsv[data.type].res):center(bg):addTo(bg)
    display.newSprite("ui/global/item_frame.png"):center(bg):addTo(bg)
    local image = data.level == max and "level_max.png" or string.format("level_%d.png", data.level)
    display.newSprite(SellRes .. image):anch(0, 0.5):pos(0, 77):addTo(bg)
    bg:setCallback(function()
      callback(bg)
    end)
    index = index + 1
    xPos = xPos + 85
  end
  if index <= 5 then
    for i = index, 5 do
      local bg = UIHelper.newImageView(SellRes .. "image_bg.png"):scale(0.9):pos(xPos, -70):addTo(self.info2)
      display.newSprite(SellRes .. "image_add.png"):center(bg):addTo(bg)
      bg:setCallback(function()
        callback(bg)
      end)
      xPos = xPos + 85
    end
  end
  self.tempList = clone(self.chooseList)
end

function DinerSellMainLayer:showChooseDish()
  self.curShowDish = {}
  if self.refreshHandler then
    scheduler.unscheduleGlobal(self.refreshHandler)
  end
  self.list:removeAllChildren()
  self.row = 0
  for _, data in ipairs(self.allDish) do
    if data.type == self.dishType then
      table.insert(self.curShowDish, clone(data))
    end
  end
  self.refreshHandler = scheduler.scheduleGlobal(function()
    self:refreshListWithDelay()
  end, 0.016666666666666666)
end

function DinerSellMainLayer:refreshListWithDelay()
  if self.row >= math.ceil(table.nums(self.curShowDish) / 4) then
    scheduler.unscheduleGlobal(self.refreshHandler)
    self.refreshHandler = nil
    self:updateChooseCount()
    if table.nums(self.curShowDish) == 0 then
      display.newTTFLabel({
        text = "暂时没有可用的菜品",
        size = 24,
        color = UIHelper.hex2rgb("#ebebeb")
      }):enableOutline(UIHelper.hex2rgb("#2a2727"), 1):center(self.list):addTo(self.list)
    end
    self.list:requestDoLayout()
    return
  end
  local viewNode = ccui.Widget:create()
  viewNode:size(cc.size(478, 148)):addTo(self.list)
  for index = 1, 4 do
    local data = self.curShowDish[self.row * 4 + index]
    if not data then
      break
    end
    local cell = self:createCard(data):pos(58 + (index - 1) * 120, 75):addTo(viewNode)
  end
  self.row = self.row + 1
end

function DinerSellMainLayer:createCard(data)
  local hero = game.role.heros[data.heroId]
  local image = hero.loveBreak >= 5 and "cell_2.png" or "cell_1.png"
  local card = UIHelper.newImageView(SellRes .. image)
  display.newSprite(DishCsv[data.id].res):scale(0.9):pos(60, 98):addTo(card)
  local bg = display.newSprite(SellRes .. "cell_info_bg.png"):center(card):addTo(card)
  local names = {
    "外形:",
    "风味:",
    "营养:",
    "特性:"
  }
  local yPos = 57
  for index, name in ipairs(names) do
    local desc = index == 4 and data.specialDesc or data["taste" .. index]:getv(data.level, 0)
    display.newTTFLabel({
      text = name .. desc,
      size = 14,
      color = UIHelper.hex2rgb("#763636")
    }):anch(0, 0.5):pos(25, yPos):addTo(bg)
    yPos = yPos - 14
  end
  local max = #globalCsv.dishLevel:toTableArray()
  display.newSprite(SellRes .. string.format("level_%s.png", data.level == max and "max" or data.level)):anch(0, 0.5):pos(0, 128):addTo(card)
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(SellRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(105, 130):addTo(card)
  btnInfo:setCallback(function()
    self:showDishDetail(data, hero.loveBreak >= 5)
  end)
  if self.tempList[data.heroId] then
    local select = UIHelper.newImageView(SellRes .. "cell_select.png"):center(card):addTo(card):name("select")
    select:setTouchEnabled(true)
    select:setSwallowTouches(true)
    select:setCallback(function()
      self:addChoose(data, card)
    end)
    self.tempList[data.heroId].card = card
  end
  card:setCallback(function()
    self:addChoose(data, card)
  end)
  return card
end

function DinerSellMainLayer:addChoose(data, card)
  if self.tempList[data.heroId] then
    local select = self.tempList[data.heroId].card:getChildByName("select")
    if select then
      select:removeSelf()
    end
    self.tempList[data.heroId] = nil
    self:updateChooseCount()
    return
  end
  if table.nums(self.tempList) >= self.chooseMax then
    SysError(SYS_ERR_DINER_SELL_DISH_FULL)
    return
  end
  local select = UIHelper.newImageView(SellRes .. "cell_select.png"):center(card):addTo(card):name("select")
  select:setTouchEnabled(true)
  select:setSwallowTouches(true)
  select:setCallback(function()
    self:addChoose(data, card)
  end)
  self.tempList[data.heroId] = {
    card = card,
    level = data.level,
    type = data.id,
    heroId = data.heroId
  }
  self:updateChooseCount()
end

function DinerSellMainLayer:showInfo3()
  self.info3:removeAllChildren()
  self:updateReward()
  self:showExtraInfo()
  display.newTTFLabel({
    text = "营业信息",
    size = 20,
    color = UIHelper.hex2rgb("#765b44")
  }):pos(73, -13):addTo(self.info3)
  local xPos, yPos = 17, -38
  local texts = {
    "餐车评价:+",
    "美观度:",
    "整洁度:",
    "吸引力:",
    "菜品加成:+",
    "外形:",
    "风味:",
    "营养:"
  }
  for i = 1, 8 do
    local value, color = 0, "#765b44"
    if i == 1 then
      color = "#62b90c"
      value = string.format("%0.1f%%", (self.reward.base1 + self.reward.base2 + self.reward.base3) / 100)
    elseif i == 5 then
      color = "#62b90c"
      value = string.format("%0.1f%%", (self.reward.taste[1] + self.reward.taste[2] + self.reward.taste[3]) / 100)
    elseif i < 5 then
      value = self.reward["base" .. i - 1] or 0
    elseif 5 < i then
      value = self.reward.taste[i - 5]
    end
    display.newTTFLabel({
      text = texts[i] .. value,
      size = 16,
      color = UIHelper.hex2rgb(color)
    }):anch(0, 0.5):pos(xPos, yPos):addTo(self.info3)
    yPos = yPos - 18
    if i == 4 then
      xPos = xPos + 135
      yPos = -38
    end
  end
  display.newSprite(SellRes .. "line.png"):pos(136, -73):addTo(self.info3)
  local temp = {}
  for _, data in pairs(self.chooseList) do
    table.insert(temp, data)
  end
  local yPos = -15
  for i = 1, 5 do
    display.newSprite(SellRes .. "desc_block.png"):pos(295, yPos):addTo(self.info3)
    local data = temp[i]
    local desc = data and DishCsv[data.type].specialDesc or "无"
    display.newTTFLabel({
      text = desc,
      size = 16,
      color = UIHelper.hex2rgb("#765b44")
    }):anch(0, 0.5):pos(304, yPos):addTo(self.info3)
    yPos = yPos - 18
  end
end

function DinerSellMainLayer:showExtraInfo()
  self.extra:removeAllChildren()
  display.newTTFLabel({
    text = "预计最低收入: ",
    size = 20,
    color = UIHelper.hex2rgb("#feffe2")
  }):enableOutline(UIHelper.hex2rgb("#765b44"), 1):anch(0, 0.5):pos(5, 0):addTo(self.extra)
  local image = "btn_start.png"
  local text = "出发"
  local outcolor = "#9c3a13"
  if self.sellInfo.time and self.sellInfo.time ~= 0 then
    image = game:nowTime() < self.sellInfo.time and "btn_cancel.png" or "btn_end.png"
    text = game:nowTime() < self.sellInfo.time and "结束" or "结算"
    outcolor = game:nowTime() < self.sellInfo.time and "#23800f" or "#9c3a13"
  end
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(SellRes, {image, image})
  btn:pos(383, 0):addTo(self.extra)
  btn:setCallback(function()
    if self.mapId == 0 then
      SysError(SYS_ERR_DINER_SELL_NOT_SELECT_AREA)
      return
    end
    if not self.sellInfo.time or self.sellInfo.time == 0 then
      if self.dailyLimit >= globalCsv.sellDailyLimit then
        SysError(SYS_ERR_DINER_SELL_COUNT_OUT)
        return
      end
      if self.dinerStatus[self.diner.id] == 1 then
        SysError(SYS_ERR_DINER_SELL_IS_BUSY)
        return
      end
      if SellCsv[self.mapId][self.sellInfo.aimGroup].energy + self.reward.material > (self.diner.material or 0) then
        SysError(SYS_ERR_DINER_SELL_ENERGY_NOT_ENOUGH)
        return
      end
      if not next(self.chooseList) then
        SysError(SYS_ERR_DINER_SELL_NOT_SELECT_DISH)
        return
      end
      local temp = {}
      for _, data in pairs(self.chooseList) do
        table.insert(temp, data.heroId)
      end
      
      local function send()
        if not self:showSellNoOpenErr(self.mapId) then
          return
        end
        game:sendData(actionCodes.Diner_sellRpc, MsgPack.pack({
          chapter = self.mapId,
          diner = self.diner.id,
          heros = temp
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Diner_sellRpc, function(event)
          UIHelper.removeWaiting()
          self:showData()
        end)
      end
      
      if (game.role.items[6] or 0) >= BuildingCsv[3][game.role.storeLevel].silver then
        MDialog:double({
          title = "提示",
          text = "主厨，您的银币已经到达存储上限了\n \n本次营业将无法获得银币",
          okCallback = function()
            send()
            return true
          end,
          cancelCallback = function()
            return true
          end
        })
      else
        send()
      end
    else
      local function send(res)
        if not self:showSellNoOpenErr(self.mapId) then
          return
        end
        game:sendData(actionCodes.Diner_finishSellRpc, MsgPack.pack({
          chapter = self.mapId,
          cancel = res
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Diner_finishSellRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          if next(msg.reward) then
            MedalRewardLayer.new({
              items = msg.reward
            })
          end
          self:showData()
        end)
      end
      
      if game:nowTime() >= self.sellInfo.time then
        send(false)
      else
        MDialog:double({
          title = "提示",
          text = "终止营业将不会获得任何收益，确定要终止本次营业？",
          okCallback = function()
            send(true)
            return true
          end,
          cancelCallback = function()
            return true
          end
        })
      end
    end
  end)
  display.newTTFLabel({text = text, size = 20}):enableOutline(UIHelper.hex2rgb(outcolor), 1):pos(42, 24):addTo(btn)
  local group = self.sellInfo.nowGroup ~= 0 and self.sellInfo.nowGroup or self.sellInfo.aimGroup
  local mapData = SellCsv[self.mapId][group]
  local xPos = 150
  for i = 1, 2 do
    local id, count = mapData["gift" .. i]:match("(%d+)=(%d+)")
    display.newSprite(ItemCsv[tonumber(id)].icon):scale(0.4):pos(xPos, 0):addTo(self.extra)
    display.newTTFLabel({
      text = self.reward[tonumber(id)],
      size = 20,
      color = UIHelper.hex2rgb("#feffe2")
    }):enableOutline(UIHelper.hex2rgb("#765b44"), 1):anch(0, 0.5):pos(xPos + 20, 0):addTo(self.extra)
    xPos = xPos + 90
  end
end

function DinerSellMainLayer:initTypeBtns()
  local group = MRadioGroup:create()
  local xPos = 0
  for _, data in ipairs(DishTypeCsv) do
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(SellRes, {"btn_a.png", "btn_b.png"})
    btn:anch(0.5, 1):pos(xPos, 0):addTo(self.btnNode):name("btn" .. data.id)
    btn:setGroup(group)
    btn:setCallback(function()
      self.dishType = data.id
      self:showChooseDish()
    end)
    display.newTTFLabel({
      text = data.name,
      size = 24
    }):enableOutline(UIHelper.hex2rgb("#9c3a13"), 1):pos(39, 23):addTo(btn)
    xPos = xPos + 80
  end
  group:chooseByName("btn" .. self.dishType)
end

function DinerSellMainLayer:showDishDetail(info, change)
  local mask = UIHelper.extend(ccui.Layout:create())
  mask:size(display.width + 380, display.height)
  mask:setBackGroundColorType(1)
  mask:setBackGroundColor(cc.c3b(0, 0, 0))
  mask:setTouchEnabled(true)
  mask:setSwallowTouches(true)
  mask:setBackGroundColorOpacity(100)
  mask:addTo(display.getRunningScene(), POPUP_LAYER_ORDER)
  mask:setCallback(function()
    mask:removeSelf()
  end)
  local bg = display.newSprite(SellRes .. (change and "detail_bg_2.png" or "detail_bg_1.png")):pos(display.width / 2, display.height / 2):addTo(mask)
  if UIHelper.isiPhoneX() then
    bg:setPositionX(bg:getPositionX() + UIHelper.getMoveXForX())
  end
  display.newSprite(FoodCsv[info.id].res):anch(0.5, 0):scale(0.6):pos(151, 105):addTo(bg)
  display.newSprite(SellRes .. "info_name_bg.png"):pos(27, 292):addTo(bg)
  display.newTTFLabel({
    text = info.name,
    size = 24
  }):enableOutline(UIHelper.hex2rgb("#763636"), 2):pos(151, 357):addTo(bg)
  display.newTTFLabel({
    text = DishTypeCsv[info.type].name .. "料理",
    size = 20,
    dimensions = cc.size(15, 86),
    color = UIHelper.hex2rgb("#763636")
  }):anch(0.5, 1):pos(22, 333):addTo(bg)
  local descBg = display.newSprite(SellRes .. (change and "attr_bg_2.png" or "attr_bg_1.png")):pos(222, 111):addTo(bg)
  local names = {
    "外形:",
    "风味:",
    "营养:"
  }
  local yPos = 49
  for index, name in ipairs(names) do
    display.newTTFLabel({
      text = name .. info["taste" .. index]:getv(info.level, 0),
      size = 18,
      color = UIHelper.hex2rgb("#763636")
    }):anch(0, 0.5):pos(25, yPos):addTo(descBg)
    yPos = yPos - 18
  end
  display.newTTFLabel({
    text = info.specialDesc,
    size = 20,
    color = UIHelper.hex2rgb("#763636")
  }):anch(0, 0.5):pos(27, 101):addTo(bg)
  local levels = globalCsv.dishLevel:toTableArray()
  if info.level < #levels then
    display.newSprite(SellRes .. string.format("level_%d.png", info.level)):anch(1, 0.5):pos(75, 140):addTo(bg)
    display.newTTFLabel({
      text = "菜品升级好感度要求",
      size = 18,
      color = UIHelper.hex2rgb("#ac7c4e")
    }):pos(113, 42):addTo(bg)
    local heart = display.newSprite("ui/global/heart.png"):pos(256, 42):addTo(bg)
    display.newTTFLabel({
      text = globalCsv.dishLevel:getv(info.level + 1, 1),
      size = 24,
      color = UIHelper.hex2rgb("#5b0a15")
    }):enableOutline(UIHelper.hex2rgb("#ffffff"), 2):pos(20, 21):addTo(heart)
  else
    display.newSprite(SellRes .. "level_max.png"):anch(1, 0.5):pos(85, 140):addTo(bg)
    display.newTTFLabel({
      text = "菜品已达到最大等级",
      size = 18,
      color = UIHelper.hex2rgb("#9d9682")
    }):pos(115, 40):addTo(bg)
  end
end

function DinerSellMainLayer:getDinerId(oldId)
  local dinerId
  if oldId and (not self.sellInfo.diner or self.sellInfo.diner == 0) then
    return oldId
  end
  for index, data in ipairs(game.role.diner.diners) do
    if data.car and 0 < data.car and (not (self.sellInfo.diner and self.sellInfo.diner ~= 0 or data:getSellState()) or self.sellInfo.diner == data.id) then
      dinerId = data.id
      break
    end
  end
  return dinerId
end

function DinerSellMainLayer:updateChooseCount()
  self.num:setString(string.format("选择菜品: %d/%d", table.nums(self.tempList), self.chooseMax))
end

function DinerSellMainLayer:updateReward()
  self.reward, self.condition = self.diner:getPresetReward(self.tempList, self.mapId)
  for _, cell in pairs(self.mapCell) do
    cell.refresh()
  end
end

function DinerSellMainLayer:getDishLevel(loveBreak)
  local level = 1
  for _, data in ipairs(globalCsv.dishLevel:toTableArray()) do
    if loveBreak >= tonumber(data[2]) then
      level = tonumber(data[1])
    else
      break
    end
  end
  return level
end

function DinerSellMainLayer:onExit()
  if self.refreshHandler then
    scheduler.unscheduleGlobal(self.refreshHandler)
  end
end

return DinerSellMainLayer

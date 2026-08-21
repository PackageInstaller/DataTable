local AccessCsv = require("csvdata.diner_accessory")
local CarCsv = require("csvdata.diner_car")
local EntryCsv = require("csvdata.diner_entry")
local SysErrCsv = require("csvdata.sys_codes")
local MainRes = "ui/diner/main/"
local InfoRes = "ui/diner/info/"
local SupplyRes = "ui/diner/supply/"
local WearRes = "ui/diner/wear/"
local ChangeRes = "ui/diner/change/"
local SpineCarRes = "diner/car/"
local uiData = {
  csbFile = "ui/diner/DinerMainLayer.csb",
  widgets = {
    mainBg = "mainBg",
    angle = "angle",
    up = "up",
    list = "listBg/list",
    carNode = "carNode",
    countNode = "countNode",
    dinerNode = "dinerNode",
    descBg = "listBg/descBg",
    infoBg = "infoBg",
    infoNode = "infoBg/infoNode",
    btnBox = "btnBox",
    btnDraw = "btnDraw",
    btnShop = "btnShop",
    btnStart = "btnStart",
    btnInfo = "btnInfo",
    btnChange = "btnChange",
    btnForge = "btnForge"
  }
}
local btnData1 = {
  [1] = function(self)
    self:showBox()
  end,
  [2] = function(self)
    self:showDraw()
  end,
  [3] = function(self)
    self:showShop()
  end,
  [4] = function(self)
    self:showStart()
  end
}
local btnData2 = {
  [1] = {
    name = "",
    func = function(self)
      self:changeInfoState()
    end
  },
  [2] = {
    name = "改造",
    func = function(self)
      self:showWear()
    end
  },
  [3] = {
    name = "更换",
    func = function(self)
      self:showChangeCar()
    end
  }
}
local DinerMainLayer = class("DinerMainLayer", UIBase)

function DinerMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function DinerMainLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
    self.dinerNode:setPositionX(self.dinerNode:getPositionX() - 70)
    self.btnBox:setPositionX(self.btnBox:getPositionX() - 85)
    self.btnDraw:setPositionX(self.btnDraw:getPositionX() - 85)
    self.btnShop:setPositionX(self.btnShop:getPositionX() - 85)
    self.angle:setPositionX(self.angle:getPositionX() + UIHelper.getMoveXForX())
    self.btnStart:setPositionX(self.btnStart:getPositionX() + UIHelper.getMoveXForX())
  end
  self:showTopBar()
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up,
    time = 0.5
  })
  game.role:setRedDirty("diner")
  self.curDiner = params.diner or 1
  self.showType = params.type or 2
  self.active = {}
  self.infoHide = true
  self:changeInfoState()
  local btns1 = {
    "btnBox",
    "btnDraw",
    "btnShop",
    "btnStart"
  }
  for index, name in pairs(btns1) do
    self[name]:setTouchScale()
    self[name]:setCallback(function()
      btnData1[index](self)
    end)
  end
  self.list:hide()
  display.newTTFLabel({
    text = "营业",
    size = 32,
    color = UIHelper.hex2rgb("#FFECCB")
  }):enableOutline(UIHelper.hex2rgb("#722c02"), 1):pos(56, 59):addTo(self.btnStart)
  self.group = MRadioGroup:create()
  local btns2 = {
    "btnInfo",
    "btnForge",
    "btnChange"
  }
  for index, name in ipairs(btns2) do
    local btn = self[name]
    if 1 < index then
      btn:name("btn" .. index)
      btn:setGroup(self.group)
      btn:setCallback(function()
        self.showType = index
        self.descBg:removeAllChildren()
        btnData2[self.showType].func(self)
      end)
      display.newTTFLabel({
        text = btnData2[index].name,
        size = 26
      }):enableOutline(UIHelper.hex2rgb("#99400a"), 1):center(btn):addTo(btn)
    else
      btn:setTouchScale()
      btn:setCallback(function()
        btnData2[1].func(self)
      end)
    end
  end
  local bShow = checkbool(next(game.role.redPoints.diner or {}))
  UIHelper.showRedPoint(self.btnStart, bShow, cc.p(7, 7), 1)
  self.handlers = {}
  table.insert(self.handlers, game.role:addEventListener("notifyNewMessage", function(event)
    if event.type == "diner" then
      local bShow = checkbool(next(game.role.redPoints.diner or {}))
      UIHelper.showRedPoint(self.btnStart, bShow, cc.p(-7, 7), 1)
    end
  end))
  self:inintDiners()
  UIHelper.showPageGuide(10018)
end

function DinerMainLayer:autoPopupLayer(params)
  local popupLayers = {
    box = {
      callback = handler(self, self.showBox)
    }
  }
  local layer = popupLayers[params.layer]
  if layer then
    layer.callback()
  end
end

function DinerMainLayer:showData(params)
end

function DinerMainLayer:inintDiners()
  self.dinerNode:removeAllChildren()
  local yPos = 0
  local had = game.role.diner.dinerMaxNum
  local group = MRadioGroup:create()
  for index = 1, globalCsv.dinerNumMax do
    local unlock = index <= had
    local dinerBtn = UIHelper.extend(ccui.Button:create())
    dinerBtn:setImages(MainRes, {
      "diner_a.png",
      "diner_b.png"
    })
    dinerBtn:anch(0, 0.5):name("btn" .. index)
    dinerBtn:setGroup(group)
    dinerBtn:pos(-21, yPos):addTo(self.dinerNode)
    display.newTTFLabel({
      text = "车位" .. index,
      size = 20
    }):anch(0, 0.5):pos(35, 20):addTo(dinerBtn):enableOutline(UIHelper.hex2rgb(unlock and "#9c3a13" or "#6d6969"), 1)
    dinerBtn:setCallback(function()
      if unlock then
        local dinerData = game.role.diner.diners[index]
        if not (dinerData and dinerData.car) or dinerData.car < 1 then
          SysError(SYS_ERR_DINER_CAR_NOT_ENOUGH_CAR)
          group:chooseByName("btn" .. self.curDiner)
          return
        end
        self.curDiner = index
        self.dinerData = game.role.diner.diners[self.curDiner]
        self:showCar()
        self:showInfo()
        self:showSupply()
        self:resetSelect()
      else
        group:chooseByName("btn" .. self.curDiner)
        UIHelper.showSlotExtraTip({
          type = 1,
          callback = function()
            self:inintDiners()
          end
        })
      end
    end)
    if not unlock then
      dinerBtn:setImages(MainRes, {
        "diner_c.png",
        "diner_c.png"
      })
      display.newSprite(MainRes .. "image_lock.png"):pos(86, 20):addTo(dinerBtn)
    end
    yPos = yPos - 42
  end
  group:chooseByName("btn" .. self.curDiner)
  self.dinerData = game.role.diner.diners[self.curDiner]
  self:showCar()
  self:showInfo()
  self:showSupply()
  self:resetSelect()
end

function DinerMainLayer:showBox()
  if not CommonHelper.funcOpen("box") then
    SysError(SYS_ERR_FUNCOPEN_DINER_BOX)
    return
  end
  game:enterScene("DinerScene")
  BackManager:push(function()
    game:enterScene("MainScene", {layer = "diner"})
  end)
end

function DinerMainLayer:showDraw()
  if not CommonHelper.funcOpen("box") then
    SysError(SYS_ERR_FUNCOPEN_DINER_DRAW)
    return
  end
  local layer = game:createView("diner.DinerDrawLayer")
  self:hide()
  BackManager:push(function()
    self:showTopBar()
    self:show()
    if self.showType == 2 then
      self:showAcceType1()
      self:showAcceType2()
      self:showAcceType3()
    end
    layer:close()
  end)
end

function DinerMainLayer:showShop()
  if not CommonHelper.funcOpen("box") then
    SysError(SYS_ERR_FUNCOPEN_DINER_SHOP)
    return
  end
  local layer = game:createView("shop.ShopLayer", {curType = 2, selected = 3})
  BackManager:push(function()
    self:showTopBar()
    layer:close()
  end)
end

function DinerMainLayer:showStart()
  if self:checkAllEnergy() then
    return
  end
  local layer = game:createView("diner.DinerSellMainLayer")
  self:hide()
  BackManager:push(function()
    self:showTopBar()
    self:show()
    self:updateProgress()
    layer:close()
  end)
end

function DinerMainLayer:showCar()
  self.carNode:removeAllChildren()
  if self.dinerData.car and self.dinerData.car > 0 then
    local carData = CarCsv[self.dinerData.car]
    local x, y = carData.pos:match("(%d+)=(%d+)")
    self.car = UIHelper.createSpineNodeByRes(SpineCarRes .. CarCsv[self.dinerData.car].res)
    self.car:anch(0.5, 0):pos(tonumber(x), tonumber(y)):addTo(self.carNode)
    self.car:setAnimation(0, "idle", true)
  end
  local accessStr = self.dinerData.accessories or ""
  for index, id in pairs(accessStr:toNumMap()) do
    local accessData = AccessCsv[game.role.diner.accessories[id].type]
    if accessData.type == 3 then
      local locat = accessData.pos ~= "" and accessData.pos:toTableArray() or {
        {0, 0},
        {0, 0}
      }
      local spine = UIHelper.createSpineNodeByRes(accessData.spine):pos(tonumber(locat[1][1] - 150), tonumber(locat[1][2]) + 15)
      if index % 100 == 2 then
        spine:pos(tonumber(locat[2][1] + 150), tonumber(locat[2][2]) - 10)
      else
        spine:setLocalZOrder(-1)
      end
      spine:addTo(self.carNode)
      spine:setAnimation(0, "idle", true)
    end
  end
end

function DinerMainLayer:showSupply()
  self.countNode:removeAllChildren()
  local mainBg = display.newSprite(MainRes .. "supply_bg.png"):addTo(self.countNode)
  self.count = display.newTTFLabel({text = "", size = 18}):enableOutline(UIHelper.hex2rgb("#3d1e07"), 1):anch(0, 0.5):pos(215, 38):addTo(mainBg)
  local bg = display.newSprite(SupplyRes .. "image_bar_bg.png"):pos(282, 21):addTo(mainBg)
  local barBg = display.newSprite(SupplyRes .. "bar_bg.png"):pos(218, 10):addTo(bg)
  self.progress = display.newProgressTimer(SupplyRes .. "bar.png", 1):center(barBg):addTo(barBg)
  self.progress:setMidpoint(cc.p(0, 0.5))
  self.progress:setBarChangeRate(cc.p(1, 0))
  self.progress:setPercentage(0)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(SupplyRes, {
    "btn_add.png",
    "btn_add.png"
  })
  btn:pos(438, 10):addTo(bg)
  btn:setTouchScale()
  btn:setCallback(function()
    local busy = self.dinerData:getSellState()
    if busy then
      SysError(SYS_ERR_DINER_SELL_IS_BUSY)
      return
    end
    game:createView("diner.DinerSupplyLayer", {
      diner = self.curDiner,
      func = function()
        self:updateProgress()
      end
    })
  end)
  self:updateProgress()
end

function DinerMainLayer:resetSelect()
  self.descBg:removeAllChildren()
  self.group:chooseByName("btn2")
  btnData2[2].func(self)
end

function DinerMainLayer:updateProgress()
  local cur = self.dinerData.material or 0
  self.count:setString(string.format("食材: %d/%d", cur, globalCsv.dinerCarEnergyMax))
  self.progress:setPercentage(cur / globalCsv.dinerCarEnergyMax * 100)
end

function DinerMainLayer:showInfo()
  self.infoNode:removeAllChildren()
  local attrs, active = self.dinerData:getFinalAttrs()
  self.active = active
  local bg1 = display.newSprite(InfoRes .. "desc_bg.png"):anch(0, 0.5):pos(-10, 0):addTo(self.infoNode)
  display.newTTFLabel({
    text = "餐车评价",
    size = 18,
    color = UIHelper.hex2rgb("#ffae00")
  }):anch(0, 0.5):pos(3, 15):addTo(bg1)
  local num = (attrs.base1 + attrs.base2 + attrs.base3) / 100
  display.newTTFLabel({
    text = string.format("%0.1f%%", num),
    size = 18,
    color = UIHelper.hex2rgb("#ffae00")
  }):anch(1, 0.5):pos(250, 15):addTo(bg1)
  local yPos = -30
  local base = {
    "美观度:",
    "整洁度:",
    "吸引力:"
  }
  for index, name in ipairs(base) do
    local value = attrs["base" .. index]
    display.newSprite(MainRes .. "image_block.png"):pos(0, yPos):addTo(self.infoNode)
    display.newTTFLabel({
      text = name .. value,
      size = 18,
      color = UIHelper.hex2rgb("#b3f720")
    }):anch(0, 0.5):pos(15, yPos + 2):addTo(self.infoNode)
    yPos = yPos - 30
  end
  local bg2 = display.newSprite(InfoRes .. "desc_bg.png"):anch(0, 0.5):pos(-10, yPos):addTo(self.infoNode)
  display.newTTFLabel({
    text = "部件加成",
    size = 18,
    color = UIHelper.hex2rgb("#ffae00")
  }):anch(0, 0.5):pos(3, 15):addTo(bg2)
  yPos = yPos - 30
  local detalAttr = {
    {
      des = "贩售获得银币%s%%",
      add = 1,
      dec = 2
    },
    {
      des = "贩售获得银币%s",
      add = 3,
      dec = 4
    },
    {
      des = "消耗食材%s",
      add = 17,
      dec = 18
    },
    {
      des = "地区偏好%s%%",
      add = 19,
      dec = 20
    },
    {
      des = "地区偏好%s",
      add = 21,
      dec = 22
    }
  }
  for _, data in ipairs(detalAttr) do
    local value = (attrs[data.add] or 0) - (attrs[data.dec] or 0)
    if value ~= 0 then
      display.newSprite(MainRes .. "image_block.png"):pos(0, yPos):addTo(self.infoNode)
      display.newTTFLabel({
        text = string.format(data.des, 0 < value and "+" .. value or value),
        size = 18,
        color = UIHelper.hex2rgb("#b3f720")
      }):anch(0, 0.5):pos(15, yPos + 2):addTo(self.infoNode)
      yPos = yPos - 30
    end
  end
end

function DinerMainLayer:showChangeCar()
  local list = ccui.ListView:create()
  list:size(cc.size(355, 490))
  list:setInnerContainerSize(cc.size(355, 490))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0, 0):pos(7, 0):addTo(self.descBg)
  local cellSize = display.newSprite(ChangeRes .. "cell_car.png"):getContentSize()
  for carId, _ in pairs(game.role.diner.item_car) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cellSize):addTo(list)
    local cell = display.newSprite(ChangeRes .. "cell_car.png"):center(viewNode):addTo(viewNode)
    local carData = CarCsv[carId]
    display.newSprite(carData.pic):anch(0.5, 0):pos(112, 60):addTo(cell)
    local xPos = 233
    for i = 1, 5 do
      if i <= carData.limit1 then
        display.newSprite(ChangeRes .. "open_small.png"):pos(xPos, 198):addTo(cell)
      end
      xPos = xPos + 22
    end
    display.newTTFLabel({
      text = string.format("动力炉:%d", carData.limit1),
      size = 14,
      color = UIHelper.hex2rgb("#714a26")
    }):anch(0, 0.5):pos(222, 218):addTo(cell)
    local xPos, yPos = 236, 153
    for i = 1, 8 do
      if i <= carData.limit2 then
        display.newSprite(ChangeRes .. "open_big.png"):pos(xPos, yPos):addTo(cell)
      end
      yPos = yPos - 29
      if i % 2 == 0 then
        xPos = xPos + 28
        yPos = 153
      end
    end
    display.newTTFLabel({
      text = string.format("部件槽:%d", carData.limit2),
      size = 14,
      color = UIHelper.hex2rgb("#714a26")
    }):anch(0, 0.5):pos(222, 173):addTo(cell)
    local xPos = 236
    for i = 1, 4 do
      if i <= carData.limit3 then
        display.newSprite(ChangeRes .. "open_big.png"):pos(xPos, 80):addTo(cell)
      end
      xPos = xPos + 28
    end
    display.newTTFLabel({
      text = string.format("外饰:%d", carData.limit3),
      size = 14,
      color = UIHelper.hex2rgb("#714a26")
    }):anch(0, 0.5):pos(222, 102):addTo(cell)
    display.newTTFLabel({
      text = carData.name,
      size = 16,
      color = UIHelper.hex2rgb("#714a26")
    }):pos(80, 246):addTo(cell)
    display.newTTFLabel({
      text = "美观度: " .. carData.baseAttr1,
      size = 14,
      color = UIHelper.hex2rgb("#a09177")
    }):anch(0, 0.5):pos(42, 55):addTo(cell)
    display.newTTFLabel({
      text = "整洁度: " .. carData.baseAttr2,
      size = 14,
      color = UIHelper.hex2rgb("#a09177")
    }):anch(0, 0.5):pos(42, 39):addTo(cell)
    display.newTTFLabel({
      text = "吸引力: " .. carData.baseAttr3,
      size = 14,
      color = UIHelper.hex2rgb("#a09177")
    }):anch(0, 0.5):pos(42, 23):addTo(cell)
    local slot = self.dinerData:getCarOwner(carId)
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(ChangeRes, {
      "btn_change.png",
      "btn_change.png"
    })
    btn:pos(285, 35):addTo(cell)
    btn:setTouchScale()
    btn:setCallback(function()
      if self:checkDinerState() then
        return
      end
      local dinerId = self.dinerData:getCarOwner(carId)
      if dinerId and self.dinerData:getSellState(dinerId) then
        SysError(SYS_ERR_DINER_SELL_IS_BUSY)
        return
      end
      MDialog:double({
        title = "提示",
        text = "更换餐车将会卸下所有配件。仍然要继续吗？",
        okCallback = function()
          game:sendData(actionCodes.Diner_changeCarRpc, MsgPack.pack({
            slot = self.curDiner,
            carId = carId
          }))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Diner_changeCarRpc, function(event)
            UIHelper.removeWaiting()
            self.descBg:removeAllChildren()
            self:showCar()
            self:showInfo()
            btnData2[self.showType].func(self)
          end)
          return true
        end,
        cancelCallback = function()
          return true
        end
      })
    end)
    display.newTTFLabel({text = "更换", size = 16}):enableOutline(UIHelper.hex2rgb("#886213"), 1):center(btn):addTo(btn)
    if slot == self.curDiner then
      btn:hide()
      display.newSprite(ChangeRes .. "using.png"):pos(278, 35):addTo(cell)
    end
  end
  local viewNode = ccui.Widget:create()
  viewNode:setContentSize(cc.size(350, 58)):addTo(list)
  list:doLayout()
end

function DinerMainLayer:showWear()
  self.bg1 = display.newSprite(WearRes .. "bg_1.png"):anch(0, 0):pos(9, 353):addTo(self.descBg)
  self:showAcceType1()
  self.bg2 = display.newSprite(WearRes .. "bg_2.png"):anch(0, 0):pos(9, 157):addTo(self.descBg)
  self:showAcceType2()
  self.bg3 = display.newSprite(WearRes .. "bg_3.png"):anch(0, 0):pos(9, 40):addTo(self.descBg)
  self:showAcceType3()
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(WearRes, {
    "btn_recycle.png",
    "btn_recycle.png"
  })
  btn:pos(290, 470):addTo(self.descBg)
  btn:setTouchScale()
  btn:setCallback(function()
    local function rule(access)
      if self.dinerData:getAccessOwner(access.id) then
        return true
      end
    end
    
    local layer = game:createView("diner.ChooseAccessoryLayer", {
      multiChoose = true,
      layerType = 2,
      rule = rule,
      desc = "可回收:",
      curDiner = self.curDiner,
      recycle = true,
      callback = function(choose, callback)
        if not next(choose) then
          SysError(SYS_ERR_DINER_CAR_RECYCLR_NOTHING)
          return
        end
        local ids = {}
        local tip = false
        for id, _ in pairs(choose) do
          local access = game.role.diner.accessories[id]
          if not access then
            SysError(SYS_ERR_DINER_CAR_RECYCLR_ACCESSORY_DATA_NULL)
            return
          end
          if not tip and AccessCsv[access.type].quality > 2 or 2 < access.level then
            tip = true
          end
          table.insert(ids, id)
        end
        
        local function send()
          game:sendData(actionCodes.Diner_recycleAccessoryRpc, MsgPack.pack({ids = ids}))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Diner_recycleAccessoryRpc, function(event)
            UIHelper.removeWaiting()
            local msg = MsgPack.unpack(event.data)
            MedalRewardLayer.new({
              items = msg.reward
            })
            self:showAcceType1()
            self:showAcceType2()
            self:showAcceType3()
            callback()
          end)
        end
        
        if tip then
          MDialog:double({
            title = "提示",
            text = "选择回收的部件中有高品质/高等级的部件，仍要进行回收吗？",
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
      end
    })
    BackManager:push(function()
      layer:close()
    end)
  end)
  display.newTTFLabel({
    text = "配件分解",
    size = 16
  }):enableOutline(UIHelper.hex2rgb("#886213"), 1):center(btn):addTo(btn)
end

function DinerMainLayer:showAcceType1()
  local more = self.dinerData:getFreeAccessType(1)
  self.bg1:removeAllChildren()
  display.newTTFLabel({
    text = "动力炉",
    size = 20,
    color = UIHelper.hex2rgb("#765b44")
  }):anch(0, 0.5):pos(35, 86):addTo(self.bg1)
  display.newSprite(MainRes .. "energy_add.png"):anch(1, 0.5):pos(295, 86):addTo(self.bg1)
  display.newTTFLabel({
    text = ":" .. self.dinerData:getEnergyTotal(),
    size = 20,
    color = UIHelper.hex2rgb("#765b44")
  }):anch(0, 0.5):pos(295, 86):addTo(self.bg1)
  local limit = CarCsv[self.dinerData.car or 1].limit1
  local max, xPos, accessories = 5, 36, self.dinerData.accessories or ""
  for index = 1, max do
    local icon
    if index <= limit then
      local id = accessories:getv(100 + index, 0)
      if id ~= 0 then
        icon = AccessIcon.new({id = id})
        if self.active[id] then
          display.newSprite(MainRes .. "image_block.png"):pos(8, 80):addTo(icon)
        end
      else
        icon = UIHelper.newImageView(WearRes .. "image_bg.png")
        display.newSprite(WearRes .. (more and "image_add_2.png" or "image_add_1.png")):scale(1.36986301369863):center(icon):addTo(icon)
      end
      icon:setCallback(function()
        if not self.dinerData.car or self.dinerData.car < 1 then
          SysError(SYS_ERR_DINER_CAR_WEAR_CAR_NULL)
          return
        end
        self:addAccess(1, index, id, function()
          self:showInfo()
          self:showAcceType1()
          self:showAcceType2()
        end)
      end)
    else
      icon = display.newSprite(WearRes .. "image_point.png")
    end
    icon:scale(0.73):pos(xPos, 38):addTo(self.bg1)
    xPos = xPos + 69
  end
end

function DinerMainLayer:showAcceType2()
  local more = self.dinerData:getFreeAccessType(2)
  self.bg2:removeAllChildren()
  display.newTTFLabel({
    text = "部件槽",
    size = 20,
    color = UIHelper.hex2rgb("#765b44")
  }):anch(0, 0.5):pos(35, 182):addTo(self.bg2)
  display.newSprite(MainRes .. "energy_sub.png"):anch(1, 0.5):pos(295, 182):addTo(self.bg2)
  display.newTTFLabel({
    text = ":" .. self.dinerData:getEnergyCost(),
    size = 20,
    color = UIHelper.hex2rgb("#765b44")
  }):anch(0, 0.5):pos(295, 182):addTo(self.bg2)
  local limit = CarCsv[self.dinerData.car or 1].limit2
  local max, xPos, yPos, accessories = 8, 46, 130, self.dinerData.accessories or ""
  for index = 1, max do
    local icon
    if index <= limit then
      local id = accessories:getv(200 + index, 0)
      if id ~= 0 then
        icon = AccessIcon.new({id = id})
        if self.active[id] then
          display.newSprite(MainRes .. "image_block.png"):pos(8, 80):addTo(icon)
        end
      else
        icon = UIHelper.newImageView(WearRes .. "image_bg.png")
        display.newSprite(WearRes .. (more and "image_add_2.png" or "image_add_1.png")):scale(1.1363636363636365):center(icon):addTo(icon)
      end
      icon:setCallback(function()
        if not self.dinerData.car or self.dinerData.car < 1 then
          SysError(SYS_ERR_DINER_CAR_WEAR_CAR_NULL)
          return
        end
        self:addAccess(2, index, id, function()
          self:showInfo()
          self:showAcceType1()
          self:showAcceType2()
        end)
      end)
    else
      icon = display.newSprite(WearRes .. "image_point.png")
    end
    icon:scale(0.88):pos(xPos, yPos):addTo(self.bg2)
    yPos = yPos - 83
    if index % 2 == 0 then
      xPos = xPos + 86
      yPos = 130
    end
  end
end

function DinerMainLayer:showAcceType3()
  local more = self.dinerData:getFreeAccessType(3)
  self.bg3:removeAllChildren()
  display.newTTFLabel({
    text = "外饰",
    size = 20,
    color = UIHelper.hex2rgb("#765b44")
  }):anch(0, 0.5):pos(35, 100):addTo(self.bg3)
  local limit = CarCsv[self.dinerData.car or 1].limit3
  local max, xPos, accessories = 4, 45, self.dinerData.accessories or ""
  for index = 1, max do
    local icon
    if index <= limit then
      local id = accessories:getv(300 + index, 0)
      if id ~= 0 then
        icon = AccessIcon.new({id = id})
      else
        icon = UIHelper.newImageView(WearRes .. "image_bg.png")
        display.newSprite(WearRes .. (more and "image_add_2.png" or "image_add_1.png")):scale(1.1363636363636365):center(icon):addTo(icon)
      end
      icon:setCallback(function()
        if not self.dinerData.car or self.dinerData.car < 1 then
          SysError(SYS_ERR_DINER_CAR_WEAR_CAR_NULL)
          return
        end
        self:addAccess(3, index, id, function()
          self:showCar()
          self:showInfo()
          self:showAcceType3()
        end)
      end)
    else
      icon = display.newSprite(WearRes .. "image_point.png")
    end
    icon:scale(0.88):pos(xPos, 45):addTo(self.bg3)
    xPos = xPos + 86
  end
end

function DinerMainLayer:addAccess(type, index, accId, func)
  if self:checkDinerState() then
    return
  end
  
  local function rule(access)
    local owner = self.dinerData:getAccessOwner(access.id)
    local busy = self.dinerData:getSellState(owner)
    if owner and busy then
      return true
    end
  end
  
  local layer = game:createView("diner.ChooseAccessoryLayer", {
    type = type,
    layerType = 1,
    index = index,
    rule = rule,
    curDiner = self.curDiner,
    curChoose = accId,
    energy = true
  })
  BackManager:push(function()
    func()
    layer:close()
  end)
end

function DinerMainLayer:changeInfoState()
  if self.infoHide then
    self.infoBg:hide()
  else
    self.infoBg:show()
  end
  self.infoHide = not self.infoHide
end

function DinerMainLayer:checkDinerState()
  local res = self.dinerData:getSellState()
  if res then
    SysError(SYS_ERR_DINER_SELL_IS_BUSY)
  end
  return res
end

function DinerMainLayer:onExit()
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
end

function DinerMainLayer:checkAllEnergy()
  for _, diner in pairs(game.role.diner.diners) do
    if diner:getEnergyTotal() < math.abs(diner:getEnergyCost()) then
      local content = SysErrCsv[SYS_ERR_DINER_NO_ENERGY].content
      MFlashMsg:show({
        text = string.format(content, diner.id)
      })
      return true
    end
  end
  return false
end

function DinerMainLayer:showTopBar()
  TopBar:show(TopBarType.full, "车库")
end

return DinerMainLayer

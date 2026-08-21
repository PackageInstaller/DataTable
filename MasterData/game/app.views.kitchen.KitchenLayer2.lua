local heroRes = "ui/hero/"
local kitchenRes = "ui/kitchen/"
local cookRes = "ui/kitchen/cook/"
local uiData = {
  csbFile = "ui/kitchen/KitchenLayer.csb",
  widgets = {
    center = "center",
    root = "root",
    btnsBg = "btnsBg",
    list = "btnsBg/list",
    bottom = "btnsBg/bottom",
    down = "down",
    up = "up",
    mask = "mask"
  }
}
local btnsData = {
  [1] = {
    title = "食灵烹饪",
    name = "",
    callback = function(self)
      self:showBuild()
    end,
    open = function(self)
      return true
    end
  },
  [2] = {
    title = "烹饪制作",
    name = "makeCook",
    callback = function(self)
      self:showCook()
    end,
    open = function(self)
      return true
    end
  },
  [3] = {
    title = "食灵回收",
    name = "recyHero",
    callback = function(self)
      self:showRecycle()
    end,
    hide = true,
    open = function(self)
      return true
    end
  },
  [4] = {
    title = "装备采购",
    name = "makeEquip",
    callback = function(self)
      self:showEquipBuild()
    end,
    err = SYS_ERR_FUNCOPEN_EQUIP,
    open = function(self)
      return CommonHelper.funcOpen("equip")
    end
  },
  [5] = {
    title = "装备回收",
    name = "recyEquip",
    callback = function(self)
      self:showEquipRecycle()
    end,
    hide = true,
    err = SYS_ERR_FUNCOPEN_EQUIP,
    open = function(self)
      return CommonHelper.funcOpen("equip")
    end
  },
  [6] = {
    title = "酱料制作",
    name = "makeSauce",
    callback = function(self)
      self:showSauceBuild()
    end,
    err = SYS_ERR_FUNCOPEN_SAUCE,
    open = function(self)
      return CommonHelper.funcOpen("sauce")
    end
  },
  [7] = {
    title = "酱料回收",
    name = "recySauce",
    callback = function(self)
      self:showSauceRecycle()
    end,
    hide = true,
    err = SYS_ERR_FUNCOPEN_SAUCE,
    open = function(self)
      return CommonHelper.funcOpen("sauce")
    end
  },
  [8] = {
    title = "梦境呼唤",
    name = "extraStar",
    callback = function(self)
      self:showExtraStarBuild()
    end,
    err = SYS_ERR_FUNCOPEN_EXTRASTAR,
    open = function(self)
      return CommonHelper.funcOpen("extraStar")
    end
  }
}
local KitchenLayer = class("KitchenLayer", UIBase)

function KitchenLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function KitchenLayer:init(params)
  TopBar:show(TopBarType.full, "厨房")
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.center)
    UIHelper.fitForiPhoneX(self.down, true)
    self.btnsBg:setPositionX(self.btnsBg:getPositionX() - UIHelper.getMoveXForX() + 50)
    self.root:setPositionX(self.root:getPositionX() - UIHelper.getMoveXForX() + 50)
  end
  self.mask:setOpacity(0)
  self.mask:runAction(cc.FadeIn:create(0.5))
  self.bottom:hide()
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up
  })
  UIHelper.MoveToRight({
    node = self.btnsBg,
    delay = 0.3,
    time = 0.2
  })
  UIHelper.MoveToUp({
    node = self.down,
    time = 0.2
  })
  local angle = display.newSprite(heroRes .. "angle.png"):setFlippedX(true):setFlippedY(true):anch(0, 0):pos(0, 0):addTo(self)
  local clock = display.newSprite(kitchenRes .. "angle_clock.png"):anch(0, 0):pos(0, 0):addTo(self)
  local hourHand = UIHelper.newImageView(kitchenRes .. "hour_hand.png"):anch(0.5, 0.7):pos(53, 58):addTo(clock)
  if UIHelper.isiPhoneX() then
    angle:setPositionX(angle:getPositionX() - UIHelper.getMoveXForX())
    clock:setPositionX(clock:getPositionX() - UIHelper.getMoveXForX())
  end
  hourHand:runAction(cc.RepeatForever:create(cc.RotateBy:create(20, 360)))
  UIHelper.MoveToUp({node = clock, time = 0.2})
  self.handlers = {}
  self.btns = {}
  local btnSize = UIHelper.newImageView(heroRes .. "taocan_1.png"):getContentSize()
  self.group = MRadioGroup:create()
  local delay = 0.4
  for index, data in ipairs(btnsData) do
    if not data.hide then
      local open = data.open()
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(btnSize):addTo(self.list)
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(heroRes, {
        open and "taocan_1.png" or "taocan_3.png",
        open and "taocan_2.png" or "taocan_3.png"
      })
      btn:center(viewNode):addTo(viewNode)
      btn:setString({
        text = btnsData[index].title,
        size = 22,
        color = UIHelper.hex2rgb("#ffffff")
      })
      btn:setCallback(function()
        if not open then
          self.group:chooseByName("btn" .. self.selected)
          SysError(data.err)
          return
        end
        self.selected = index
        self:showData()
      end)
      btn:setName(string.format("btn%d", index))
      btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#630c07"), 1)
      btn:setGroup(self.group)
      UIHelper.MoveToRight({
        node = btn,
        delay = delay,
        time = 0.2
      })
      delay = delay + 0.1
      self.btns[index] = btn
      local bShow = checkbool(game.role.redPoints.kitchen[index])
      UIHelper.showRedPoint(btn, bShow, cc.p(15, 5))
    end
  end
  local viewNode = ccui.Widget:create()
  viewNode:setContentSize(cc.size(btnSize.width, btnSize.height / 2)):addTo(self.list)
  table.insert(self.handlers, game.role:addEventListener("notifyNewMessage", function(event)
    if event.type == "kitchen" then
      for i = 1, #btnsData do
        local bShow = checkbool(game.role.redPoints.kitchen[i])
        UIHelper.showRedPoint(self.btns[i], bShow, cc.p(15, 5))
      end
    end
  end))
  self.selected = params.selected or 1
  self.buildType = params.buildType
end

function KitchenLayer:showData(params)
  self.down:hide()
  self.root:removeAllChildren()
  if game.role.majorGuideStep == 14 then
    local guideData = game.role.buildListJson[1]
    if guideData then
      self.selected = 2
      game.role.minorGuideStep = 10
      if guideData.time <= game:nowTime() then
        game.role.minorGuideStep = 12
      end
    end
    NewGuideLayer.new({step = 14})
  end
  self.group:chooseByName("btn" .. self.selected)
  btnsData[self.selected].callback(self)
end

function KitchenLayer:showBuild()
  self.curLayer = game:createView("kitchen.BuildHerosLayer", {
    scene = self.root,
    parent = self,
    select = self.buildType,
    autoFunc = function()
      self:aotuChooseBtn(2)
    end
  })
end

function KitchenLayer:showCook()
  self.down:show()
  self.curLayer = game:createView("kitchen.CookLayer", {
    scene = self.root
  })
end

function KitchenLayer:showRecycle()
  self.curLayer = game:createView("kitchen.RecycleLayer", {
    scene = self.root
  })
end

function KitchenLayer:showEquipBuild()
  self.curLayer = game:createView("equip.EquipBuildLayer", {
    scene = self.root
  })
end

function KitchenLayer:showEquipRecycle()
  self.curLayer = game:createView("equip.EquipRecycleLayer", {
    scene = self.root
  })
end

function KitchenLayer:showSauceBuild()
  self.curLayer = game:createView("kitchen.SauceBuildLayer", {
    scene = self.root
  })
end

function KitchenLayer:showSauceRecycle()
  self.curLayer = game:createView("kitchen.SauceRecycleLayer", {
    scene = self.root
  })
end

function KitchenLayer:showExtraStarBuild()
  self.curLayer = game:createView("kitchen.ExtraStarBuildLayer", {
    scene = self.root
  })
end

function KitchenLayer:aotuChooseBtn(select)
  self.selected = select
  self:showData()
end

function KitchenLayer:onExit()
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
end

return KitchenLayer

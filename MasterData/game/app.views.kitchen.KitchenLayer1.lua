local heroRes = "ui/hero/"
local kitchenRes = "ui/kitchen/"
local cookRes = "ui/kitchen/cook/"
local uiData = {
  csbFile = "ui/kitchen/KitchenLayer.csb",
  widgets = {
    center = "center",
    down = "down",
    up = "up",
    mask = "center/mask",
    root = "root",
    btnsBg = "btnsBg",
    list = "btnsBg/list"
  }
}
local btnsData = {
  [1] = {
    title = "我的食灵",
    callback = function(self)
      self:showHeros()
    end,
    open = function(self)
      return true
    end
  },
  [2] = {
    title = "食灵强化",
    callback = function(self)
      self:showStrength()
    end,
    err = SYS_ERR_FUNCOPEN_STRENGTH,
    open = function(self)
      return CommonHelper.funcOpen("strength")
    end
  },
  [3] = {
    title = "提升品质",
    callback = function(self)
      self:showQuality()
    end,
    err = SYS_ERR_FUNCOPEN_EVOLUTION,
    open = function(self)
      return CommonHelper.funcOpen("evolution")
    end
  },
  [4] = {
    title = "赠送礼物",
    callback = function(self)
      self:showLove()
    end,
    err = SYS_ERR_FUNCOPEN_GIFT,
    open = function(self)
      return CommonHelper.funcOpen("gift")
    end
  },
  [5] = {
    title = "食灵升华",
    callback = function(self)
      self:showTree()
    end,
    err = SYS_ERR_FUNCOPEN_TREE,
    open = function(self)
      return CommonHelper.funcOpen("tree")
    end
  },
  [6] = {
    title = "觉醒继承",
    callback = function(self)
      self:showAwake()
    end,
    err = SYS_ERR_FUNCOPEN_AWAKE,
    open = function(self)
      return CommonHelper.funcOpen("awake")
    end
  },
  [7] = {
    title = "职业精通",
    callback = function(self)
      self:showJobStrength()
    end,
    err = SYS_ERR_FUNCOPEN_JOB,
    open = function(self)
      return CommonHelper.funcOpen("job")
    end
  },
  [8] = {
    title = "快速觉醒",
    callback = function(self)
      self:showQuickAwake()
    end,
    open = function(self)
      return true
    end
  },
  [9] = {
    title = "",
    callback = function(self)
      self:showRecycle()
    end,
    open = function(self)
      return true
    end
  }
}
local KitchenLayer = class("KitchenLayer", UIBase)

function KitchenLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function KitchenLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.center)
    UIHelper.fitForiPhoneX(self.mask)
    UIHelper.fitForiPhoneX(self.down, true)
    UIHelper.fitForiPhoneX(self.up, true)
    self.btnsBg:setPositionX(self.btnsBg:getPositionX() - 75)
    self.root:setPositionX(self.root:getPositionX() - 75)
  end
  TopBar:show(TopBarType.full, "食灵")
  self.mask:setOpacity(0)
  self.mask:runAction(cc.FadeIn:create(0.5))
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
  local btnSize = UIHelper.newImageView(heroRes .. "taocan_1.png"):getContentSize()
  self.group = MRadioGroup:create()
  local delay = 0.4
  for index, data in ipairs(btnsData) do
    if data.title ~= "" then
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
        text = data.title,
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
    end
  end
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(kitchenRes, {
    "btn_recycle_a.png",
    "btn_recycle_b.png"
  })
  btn:setTouchScale()
  btn:pos(60, 50):addTo(self.btnsBg)
  btn:setName("btn9")
  btn:setGroup(self.group)
  btn:setCallback(function()
    self.selected = 9
    self:showData()
  end)
  UIHelper.MoveToUp({
    node = btn,
    delay = delay,
    time = 0.2,
    pos = {0, 100}
  })
  self.selected = params.selected or 1
end

function KitchenLayer:showData(params)
  if self.curLayer then
    self.curLayer:removeSelf()
    self.curLayer = nil
  end
  self.down:hide()
  self.root:removeAllChildren()
  self.group:chooseByName("btn" .. self.selected)
  btnsData[self.selected].callback(self)
end

function KitchenLayer:showAwake()
  self.curLayer = game:createView("kitchen.AwakeLayer", {
    scene = self.root
  })
end

function KitchenLayer:showQuality()
  self.curLayer = game:createView("kitchen.QualityLayer", {
    scene = self.root
  })
end

function KitchenLayer:showStrength()
  self.curLayer = game:createView("kitchen.StrengthLayer", {
    scene = self.root
  })
end

function KitchenLayer:showHeros()
  self.curLayer = game:createView("kitchen.HerosLayer", {
    scene = self.root
  })
end

function KitchenLayer:showFormation()
  self.curLayer = game:createView("kitchen.FormationLayer", {
    scene = self.root
  })
end

function KitchenLayer:showLove()
  self.curLayer = game:createView("kitchen.LoveLayer", {
    scene = self.root
  })
end

function KitchenLayer:showTree()
  self.curLayer = game:createView("kitchen.TreeMainLayer", {
    scene = self.root,
    parent = self
  })
end

function KitchenLayer:showJobStrength()
  self.curLayer = game:createView("kitchen.JobStrengthLayer", {
    scene = self.root
  })
end

function KitchenLayer:showQuickAwake()
  self.curLayer = game:createView("kitchen.QuickAwakeLayer", {
    scene = self.root
  })
end

function KitchenLayer:showRecycle()
  self.curLayer = game:createView("kitchen.RecycleLayer", {
    scene = self.root
  })
end

function KitchenLayer:onExit()
end

return KitchenLayer

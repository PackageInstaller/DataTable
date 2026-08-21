local heroRes = "ui/hero/"
local uiData = {
  csbFile = "ui/equip/EquipHomeLayer.csb",
  widgets = {
    center = "center",
    root = "root",
    btnsBg = "btnsBg",
    list = "btnsBg/list",
    down = "down",
    up = "up",
    mask = "center/mask"
  }
}
local btnsData = {
  [1] = {
    title = "我的装备",
    callback = function(self)
      self:showEquips()
    end,
    open = function(self)
      return true
    end
  },
  [2] = {
    title = "套餐装备",
    callback = function(self)
      self:showFormat()
    end,
    open = function(self)
      return true
    end
  },
  [3] = {
    title = "潜能改造",
    callback = function(self)
      self:showEntry()
    end,
    err = SYS_ERR_FUNCOPEN_EQUIPPOWER,
    open = function(self)
      return CommonHelper.funcOpen("equipPower")
    end
  },
  [4] = {
    title = "装备强化",
    callback = function(self)
      self:showUp()
    end,
    err = SYS_ERR_FUNCOPEN_EQUIPSTRENGTH,
    open = function(self)
      return CommonHelper.funcOpen("equipStrength")
    end
  },
  [6] = {
    title = "",
    callback = function(self)
      self:showRecycle()
    end,
    open = function(self)
      return true
    end
  }
}
local EquipHomeLayer = class("EquipHomeLayer", UIBase)

function EquipHomeLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function EquipHomeLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.center)
    UIHelper.fitForiPhoneX(self.down, true)
    self.btnsBg:setPositionX(self.btnsBg:getPositionX() - 75)
    self.root:setPositionX(self.root:getPositionX() - 75)
  end
  TopBar:show(TopBarType.full, "装备")
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
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages("ui/kitchen/", {
    "btn_recycle_a.png",
    "btn_recycle_b.png"
  })
  btn:setTouchScale()
  btn:pos(60, 60):addTo(self.btnsBg)
  btn:setName("btn6")
  btn:setGroup(self.group)
  btn:setCallback(function()
    self.selected = 6
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

function EquipHomeLayer:showData(params)
  if self.curLayer then
    self.curLayer:removeSelf()
    self.curLayer = nil
  end
  self.down:hide()
  self.root:removeAllChildren()
  self.group:chooseByName("btn" .. self.selected)
  btnsData[self.selected].callback(self)
end

function EquipHomeLayer:showFormat()
  self.curLayer = game:createView("equip.EquipFormationLayer", {
    scene = self.root
  })
end

function EquipHomeLayer:showEntry()
  self.curLayer = game:createView("equip.EquipEntryLayer", {
    scene = self.root
  })
end

function EquipHomeLayer:showSuit()
  self.curLayer = game:createView("equip.EquipSuitLayer", {
    scene = self.root
  })
end

function EquipHomeLayer:showUp()
  self.curLayer = game:createView("equip.EquipUpLayer", {
    scene = self.root
  })
end

function EquipHomeLayer:showEquips()
  self.curLayer = game:createView("equip.EquipsLayer", {
    scene = self.root
  })
end

function EquipHomeLayer:showRecycle()
  self.curLayer = game:createView("equip.EquipRecycleLayer", {
    scene = self.root
  })
end

return EquipHomeLayer

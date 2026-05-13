local ItemCsv = require("csvdata.item")
local heroRes = "ui/hero/"
local kitchenRes = "ui/kitchen/"
local cookRes = "ui/kitchen/cook/"
local globalRes = "ui/global/"
local uiData = {
  csbFile = "ui/kitchen/PrepareCookLayer.csb",
  widgets = {
    center = "center",
    up = "up",
    down = "down",
    content = "content",
    soup = "content/soup",
    value1 = "key1/value",
    value2 = "key2/value",
    noteBtn = "noteBtn",
    angle_left = "angle_left",
    angle_right = "angle_right",
    bg1 = "key1",
    bg2 = "key2",
    btnInfo = "key2/btnInfo"
  }
}
local PrepareCookLayer = class("PrepareCookLayer", UIBase)

function PrepareCookLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function PrepareCookLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.center)
    UIHelper.fitForiPhoneX(self.down, true)
    UIHelper.fitForiPhoneX(self.up, true)
    self.noteBtn:setPositionX(self.noteBtn:getPositionX() - UIHelper.getMoveXForX())
    self.angle_left:setPositionX(self.angle_left:getPositionX() - UIHelper.getMoveXForX())
    self.angle_right:setPositionX(self.angle_right:getPositionX() + UIHelper.getMoveXForX())
  end
  self.bgMusic = game:playMusic(1400, nil, true)
  self.value2:setString(game.role.items[globalCsv.quickBuild] or 0)
  self.value1:setString(game.role.items[globalCsv.buildDrawing] or 0)
  self.bg1:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = self.bg1,
      itemType = globalCsv.buildDrawing,
      itemData = ItemCsv[globalCsv.buildDrawing]
    })
  end)
  self.bg2:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = self.bg2,
      itemType = globalCsv.quickBuild,
      itemData = ItemCsv[globalCsv.quickBuild]
    })
  end)
  self.btnInfo:setTouchScale()
  self.btnInfo:setCallback(function()
    game:loadView("kitchen.CookInfoLayer").new()
  end)
  local smoke = cc.ParticleSystemQuad:create(cookRes .. "smoke.plist")
  smoke:setScale(1.3):pos(250, 100):addTo(self.soup)
  local guo = sp.SkeletonAnimation:create("spine/ui/kitchen/guo.json", "spine/ui/kitchen/guo.atlas", 1):pos(255, -2):addTo(self.soup)
  cc.Texture2D:setDefaultAlphaPixelFormat(cc.TEXTURE2D_PIXEL_FORMAT_RGBA8888)
  guo:setAnimation(0, "idle", true)
  self.cookBtn = UIHelper.extend(ccui.Button:create())
  self.cookBtn:setImages("ui/kitchen/formation", {
    "start_a.png",
    "start_b.png",
    "start_b.png"
  })
  self.cookBtn:setString({
    text = "确定",
    size = 32,
    color = UIHelper.hex2rgb("#FFECCB")
  })
  self.cookBtn:addTo(self):name("startBtn")
  if UIHelper.isiPhoneX() then
    self.cookBtn:pos(display.width - 65 + UIHelper.getMoveXForX(), 60)
  else
    self.cookBtn:pos(display.width - 65, 60)
  end
  self.cookBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#722c02"), 1)
  self.cookBtn:setTouchScale()
  self.cookBtn:setCallback(function(sender)
    params.callback(self:getMaterials())
    BackManager:pop()
  end)
  if not UserData.materialTable then
    UserData.materialTable = {}
    for i = 1, 4 do
      UserData.materialTable[i] = globalCsv.minBuildCost
    end
  end
  self.circle1 = CircleCard.new({type = 1, rotate = -30}):pos(-300, 85):addTo(self.content)
  self.circle2 = CircleCard.new({type = 2, rotate = -10}):pos(-100, 160):addTo(self.content)
  self.circle3 = CircleCard.new({type = 3, rotate = 15}):pos(100, 160):addTo(self.content)
  self.circle4 = CircleCard.new({type = 4, rotate = 30}):pos(300, 85):addTo(self.content)
  for index = 1, 4 do
    self["circle" .. index]:setCallback(function()
      self:changeCircleColor(index)
    end)
  end
  self.noteBtn:setTouchScale()
  self.noteBtn:setCallback(function()
    local layer = game:createView("kitchen.CookNoteLayer", {
      callback = function(m1, m2, m3, m4)
        self.circle1:setValue(m1)
        self.circle2:setValue(m2)
        self.circle3:setValue(m3)
        self.circle4:setValue(m4)
        self:closeCheng()
        self:changeCircleColor()
      end
    })
  end)
  self.firstClick = true
  if game.role.majorGuideStep == 14 then
    local node = display.newNode():addTo(display.getRunningScene(), NEW_GUIDE_LAYER_ORDER)
    local scaleX = 1
    if UIHelper.isiPhoneX() then
      scaleX = scaleX * UIHelper.getScaleForX()
    end
    local mask = UIHelper.newMask({
      size = cc.size(display.width, 90)
    }):anch(0, 1):pos(0, display.height):addTo(node):setTouchEnabled(true)
    mask:setScaleX(scaleX)
  end
end

function PrepareCookLayer:showData(params)
end

function PrepareCookLayer:getMaterials()
  local materials = {}
  for index = 1, 4 do
    local num = self["circle" .. index]:getValue()
    materials[index] = math.max(math.min(num, 999), 50)
    UserData.materialTable[index] = materials[index]
  end
  return materials
end

function PrepareCookLayer:changeCircleColor(selected)
  for index = 1, 4 do
    if index == selected then
      self["circle" .. index]:setHomeBg(cookRes .. "circle_yellow.png")
    else
      self["circle" .. index]:setHomeBg(cookRes .. "circle_white.png")
    end
  end
  if selected then
    self:createCheng(selected)
  end
end

function PrepareCookLayer:createCheng(selected)
  self:closeCheng()
  self.cheng = game:createView("kitchen.ChengLayer", {
    selected = selected,
    value = self["circle" .. selected]:getValueLabel()
  })
  local tray = self.cheng:getTray()
  
  local function trayAnimation()
    local animation, time, material = {}, 0.3
    table.insert(animation, cc.MoveBy:create(time / 2, cc.p(0, 3)))
    table.insert(animation, cc.MoveBy:create(time / 2, cc.p(0, -4)))
    table.insert(animation, cc.MoveBy:create(0.1, cc.p(0, 1)))
    table.insert(animation, cc.CallFunc:create(function()
      material = display.newSprite(cookRes .. "material" .. tostring(selected) .. ".png"):pos(200, 140):addTo(tray, -1)
      material:runAction(cc.MoveBy:create(time / 2, cc.p(0, -35)))
    end))
    table.insert(animation, cc.MoveBy:create(time / 2, cc.p(0, -5)))
    table.insert(animation, cc.MoveBy:create(time / 3, cc.p(0, 4)))
    table.insert(animation, cc.MoveBy:create(time / 2, cc.p(0, -2)))
    tray:runAction(cc.Sequence:create(animation))
  end
  
  if self.firstClick then
    self.cheng:runAction(transition.sequence({
      cc.MoveBy:create(0.2, cc.p(0, 450)),
      cc.CallFunc:create(function()
        trayAnimation()
      end)
    }))
    self.firstClick = false
  else
    self.cheng:pos(UIHelper.isiPhoneX() and UIHelper.getMoveXForX() or 0, 0)
    self.cheng:runAction(transition.sequence({
      cc.CallFunc:create(function()
        trayAnimation()
      end)
    }))
  end
end

function PrepareCookLayer:closeCheng()
  if not tolua.isnull(self.cheng) then
    self.cheng:removeFromParent()
  end
  self.cheng = nil
end

function PrepareCookLayer:onExit()
  game:stopMusic(self.bgMusic)
end

function PrepareCookLayer:close()
  self:closeCheng()
  self:removeFromParent()
end

return PrepareCookLayer

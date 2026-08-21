local UnionTechBtnCsv = require("csvdata.union_tech")
local UnionTechRes = "ui/union/tech/"
local UnionDetailRes = "ui/union/detail/"
local UnionMainRes = "ui/union/main/"
local UnionTechBtnImageRes = "ui/union/tech/"
local ManageRes = "ui/union/manage/"
local uiData = {
  csbFile = "ui/union/UnionTechLayer.csb",
  widgets = {
    up = "up",
    zoomBg = "zoomBg",
    zoomOut = "zoomBg/zoomOut",
    zoomIn = "zoomBg/zoomIn",
    zoomPoint = "zoomBg/zoomPoint",
    mapNode = "mapNode"
  }
}
local UnionTechLayer = class("UnionTechLayer", UIBase)

function UnionTechLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function UnionTechLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.up, true)
    self.zoomBg:setPositionX(self.zoomBg:getPositionX() - UIHelper.getMoveXForX() + 50)
    self.mapNode:setPositionX(self.mapNode:getPositionX() - UIHelper.getMoveXForX())
  end
  TopBar:show(TopBarType.shop, "公会科技")
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up
  })
  self.union = game.role.unionData
  self.zoom = 1
  self.mapSize = cc.size(tonumber(4000), tonumber(4000))
  self.map = display.newSprite(UnionTechRes .. "tech_bg.png")
  self.map:anch(0.5, 0.5):addTo(self.mapNode, 80)
  local xpos, ypos
  self.dragLayer = UIHelper.extend(ccui.Layout:create())
  self.dragLayer:size(self.map:getContentSize().width, self.map:getContentSize().height):anch(0.5, 0.5):addTo(self.mapNode)
  self.dragLayer:setTouchEnabled(true)
  local oldPos
  self.dragLayer:addTouchEventListener(function(sender, type)
    if not self:mapCanMove() then
      return
    end
    if type == ccui.TouchEventType.began then
      oldPos = sender:getBeginPos()
      xpos, ypos = self.map:getPosition()
    elseif type == ccui.TouchEventType.moved then
      pos = sender:getMovePos()
      local newxpos = xpos + pos.x - oldPos.x
      local newypos = ypos + pos.y - oldPos.y
      newxpos = math.max(newxpos, (display.width - self.mapSize.width * self.zoom) / 2)
      newxpos = math.min(newxpos, (self.mapSize.width * self.zoom - display.width) / 2)
      newypos = math.max(newypos, (display.height - self.zoom * self.mapSize.height) / 2)
      newypos = math.min(newypos, (self.zoom * self.mapSize.height - display.height) / 2)
      self.map:pos(newxpos, newypos)
    elseif type == ccui.TouchEventType.ended then
      local xpos, ypos = self.map:getPosition()
      if touchMove == 0 then
        touchMove = math.randomFloat(-0.5, 0.5)
      else
        touchMove = 0
      end
      self.map:pos(xpos + touchMove, ypos + touchMove)
    end
  end)
  self:refreshMap()
  self:initZoom()
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(ManageRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(display.width / 2 - 68, display.height / 2 - 110):addTo(self.mapNode, 81)
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {typeStr = "union_tech"})
  end)
  local costStatusImg = display.newSprite(UnionTechRes .. (self.union.unionTechHaveCost == 1 and "havecost.png" or "notcost.png"))
  costStatusImg:anch(0.5, 1):scale(0.6):pos(0, display.height / 2 - 60):addTo(self.mapNode, 81)
end

function UnionTechLayer:mapCanMove()
  local size = self.mapSize
  local width = size.width * self.zoom
  local height = size.height * self.zoom
  if width < display.width and height < display.height then
    return false
  else
    return true
  end
end

function UnionTechLayer:initZoom()
  self.zoomOut:setCallback(function()
    self.zoom = self.zoom - 0.1
    self.zoom = math.max(0.5, self.zoom)
    print(self.zoom)
    self:setZoom()
  end)
  self.zoomIn:setCallback(function()
    self.zoom = self.zoom + 0.1
    self.zoom = math.min(1.5, self.zoom)
    print(self.zoom)
    self:setZoom()
  end)
  self.zoomPoint:setPositionY(self.zoomBg:getContentSize().height * 0.5)
end

function UnionTechLayer:setZoom()
  local xpos, ypos = self.map:getPosition()
  xpos = math.max(xpos, (display.width - self.mapSize.width * self.zoom) / 2)
  xpos = math.min(xpos, (self.mapSize.width * self.zoom - display.width) / 2)
  ypos = math.max(ypos, (display.height - self.zoom * self.mapSize.height) / 2)
  ypos = math.min(ypos, (self.zoom * self.mapSize.height - display.height) / 2)
  self.map:pos(xpos, ypos)
  self.map:setScale(self.zoom)
  local percent = (self.zoom - 0.5) / 1
  self.zoomPoint:setPositionY(self.zoomBg:getContentSize().height * percent)
  self.techLine:setLineWidth(5 * self.zoom)
  self.completeLine:setLineWidth(5 * self.zoom)
end

function UnionTechLayer:refreshMap()
  self.map:removeAllChildren()
  self.techLine = display.newDrawNode():addTo(self.map)
  self.techLine:setLineWidth(5 * self.zoom)
  self.completeLine = display.newDrawNode():addTo(self.map)
  self.completeLine:setLineWidth(5 * self.zoom)
  for i, data in pairs(UnionTechBtnCsv) do
    if data.condition ~= 0 then
      local frontData = UnionTechBtnCsv[data.condition]
      local frontPos = frontData.position:toArray("=", true)
      local pos = data.position:toArray("=", true)
      self.techLine:drawLine(cc.p(frontPos[1], frontPos[2]), cc.p(pos[1], pos[2]), cc.c4f(0, 0, 0, 1))
      if self.union.unionTech:getv(data.id, -1) == 1 then
        self.completeLine:drawLine(cc.p(frontPos[1], frontPos[2]), cc.p(pos[1], pos[2]), cc.c4f(1, 1, 1, 1))
      end
    end
  end
  for i, data in pairs(UnionTechBtnCsv) do
    local pos = data.position:toArray("=", true)
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(UnionTechBtnImageRes, {
      data.fileName,
      data.fileName
    })
    btn:anch(0.5, 0.5):pos(pos[1], pos[2]):addTo(self.map):setTouchScale()
    btn:setSwallowTouches(false)
    if self.union.unionTech:getv(data.id, -1) == 1 then
      btn:setCallback(function()
        MDialog:single({
          title = data.name,
          text = data.desc .. "\n \n维护费用为每日" .. data.dailyCost .. "协会财富"
        }, function()
        end)
      end)
    elseif self.union.unionTech:getv(data.condition, -1) ~= 1 and data.condition ~= 0 then
      btn:setEnabled(false)
      btn:setColor(cc.c3b(100, 100, 100))
    else
      btn:setColor(cc.c3b(180, 180, 180))
      btn:addTouchEventListener(function(sender, type)
        if type == ccui.TouchEventType.began then
          self.moved = false
        elseif type == ccui.TouchEventType.moved then
          self.moved = true
          return
        elseif type == ccui.TouchEventType.ended then
          local manageLevel = self.union.managers:getv(game.role.id, 0)
          if manageLevel ~= 0 then
            game:createView("union.UnionTechCountLayer", {
              index = data.id,
              func = function()
                self:refreshMap()
              end
            })
          else
            SysError(SYS_ERR_UNION_NOT_BOSS)
          end
          self.moved = false
        end
      end)
    end
  end
  self.map:setScale(self.zoom)
end

return UnionTechLayer

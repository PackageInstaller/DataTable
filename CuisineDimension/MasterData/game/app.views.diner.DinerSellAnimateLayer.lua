local SellCsv = require("csvdata.diner_sell")
local CarCsv = require("csvdata.diner_car")
local AccessCsv = require("csvdata.diner_accessory")
local LovePlusCsv = require("csvdata.love_plus")
local UnitCsv = require("csvdata.unit")
local SpineCarRes = "diner/car/"
local uiData = {
  csbFile = "ui/diner/DinerSellAnimateLayer.csb",
  widgets = {
    mapNode = "mapNode",
    carNode = "carNode",
    up = "up"
  }
}
local DinerSellAnimateLayer = class("DinerSellAnimateLayer", UIBase)

function DinerSellAnimateLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function DinerSellAnimateLayer:init(params)
  TopBar:show(TopBarType.full, "查看")
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up,
    time = 0.5
  })
  self.roles = {}
  self.speed = 250
  self.show = {}
  self.allTypes = {}
  self.max = 10
  self:initSpine()
end

function DinerSellAnimateLayer:showData(params)
  local map = ccexp.TMXTiledMap:create(SellCsv[params.mapId][params.groupId].mapRes .. "/map.tmx"):anch(0.5, 0.5):addTo(self.mapNode)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(map, true)
  end
  self:initCar(params)
  self:initApply()
  local delay = 0
  
  local function delayFunc()
    self.mapNode:runAction(transition.sequence({
      cc.DelayTime:create(delay),
      cc.CallFunc:create(function()
        delay = math.random(1, 6)
        self:randomRole()
        delayFunc()
      end)
    }))
  end
  
  delayFunc()
end

function DinerSellAnimateLayer:initCar(params)
  local diner = game.role.diner.diners[params.dinerId] or {}
  local carData = CarCsv[diner:getSelfCar()]
  local locat = carData.pos:toTableArray()
  local car = UIHelper.createSpineNodeByRes(SpineCarRes .. carData.res)
  car:pos(tonumber(locat[1][1]), tonumber(locat[1][2])):addTo(self.carNode)
  car:setAnimation(0, "idle", true)
  local accessStr = diner.accessories or ""
  for index, id in pairs(accessStr:toNumMap()) do
    local accessData = AccessCsv[game.role.diner.accessories[id].type]
    if accessData.type == 3 then
      local locat = accessData.pos ~= "" and accessData.pos:toTableArray() or {
        {0, 0},
        {0, 0}
      }
      local spine = UIHelper.createSpineNodeByRes(accessData.spine):pos(tonumber(locat[1][1] - 80), tonumber(locat[1][2] + 9))
      if index % 100 == 2 then
        spine:pos(tonumber(locat[2][1] + 80), tonumber(locat[2][2] - 6))
      else
        spine:setLocalZOrder(-1)
      end
      spine:addTo(self.carNode)
      spine:setAnimation(0, "idle", true)
    end
  end
end

function DinerSellAnimateLayer:initApply()
  game:sendData(actionCodes.Friend_randomRpc, MsgPack.pack({}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Friend_randomRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    self.roles = msg.list
    self:randomRole()
  end)
end

function DinerSellAnimateLayer:randomRole()
  if not next(self.roles) then
    return
  end
  local max = table.nums(self.roles)
  local index = math.random(1, max)
  local role = self.roles[index]
  if not role then
    return
  end
  local spine = UIHelper.createSpineNode(self:getType())
  spine:pos(-800, -20):addTo(self.carNode)
  spine:setAnimation(0, "idle", true)
  if not self.show[role.roleId] or self.show[role.roleId] == 0 then
    self.show[role.roleId] = 1
    display.newTTFLabel({
      text = role.name,
      size = 26
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(0, 190):addTo(spine)
    local touch = UIHelper.newMask({
      size = cc.size(100, 130),
      opacity = 0
    })
    touch:center(spine):addTo(spine)
    touch:setTouchEnabled(true)
    touch:setCallback(function()
      spine:pause()
      game:sendData(actionCodes.Friend_searchRpc, MsgPack.pack({
        roleId = role.roleId
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Friend_searchRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        if msg.result then
          spine:resume()
          SysError(msg.result)
          return
        end
        game:createView("friend.FriendDetailLayer", {
          role = msg.roleInfo,
          showAdd = true,
          callback = function()
            spine:resume()
          end
        })
      end)
    end)
  else
    self.show[role.roleId] = self.show[role.roleId] + 1
  end
  local actions = {}
  endPosX = math.random(-130, 130)
  table.insert(actions, cc.Spawn:create(cc.CallFunc:create(function()
    spine:setAnimation(0, "move", true)
  end), cc.MoveTo:create((800 + endPosX) / self.speed, cc.p(endPosX, -20))))
  table.insert(actions, cc.CallFunc:create(function()
    spine:setAnimation(0, "idle", true)
  end))
  table.insert(actions, cc.CallFunc:create(function()
    local icon = display.newSprite(math.random(1, 100) > 95 and "ui/global/7.png" or "ui/global/6.png"):scale(0.1):pos(spine:getPositionX(), spine:getPositionY() + 70):addTo(self.carNode)
    icon:runAction(transition.sequence({
      cc.Spawn:create(cc.MoveBy:create(1.5, cc.p(0, 170)), cc.ScaleTo:create(1.5, 0.6), transition.sequence({
        cc.OrbitCamera:create(0.5, 1, 0, 0, 10, 360, 0),
        cc.OrbitCamera:create(0.25, 1, 0, 0, 360, 0, 0),
        cc.OrbitCamera:create(0.75, 1, 0, 0, 360, 0, 0)
      })),
      cc.RemoveSelf:create()
    }))
  end))
  table.insert(actions, cc.DelayTime:create(2))
  if math.random(1, 100) < 40 then
    table.insert(actions, cc.CallFunc:create(function()
      spine:setAnimation(0, "cheer", true)
    end))
    table.insert(actions, cc.DelayTime:create(math.random(3, 5)))
  end
  table.insert(actions, cc.Spawn:create(cc.CallFunc:create(function()
    spine:setAnimation(0, "move", true)
  end), cc.MoveTo:create((600 - endPosX) / self.speed, cc.p(600, -20))))
  table.insert(actions, cc.CallFunc:create(function()
    self.show[role.roleId] = self.show[role.roleId] - 1
  end))
  table.insert(actions, cc.RemoveSelf:create())
  spine:runAction(cc.Sequence:create(actions))
end

function DinerSellAnimateLayer:getType()
  return self.allTypes[math.random(1, self.max)]
end

function DinerSellAnimateLayer:initSpine()
  local heros = table.values(LovePlusCsv)
  repeat
    local hero = heros[math.random(1, #heros)]
    if hero.limit > 4 then
      table.insert(self.allTypes, hero.id)
    end
  until #self.allTypes >= self.max
  local cacheRes = {}
  for _, type in pairs(self.allTypes) do
    table.insert(cacheRes, UnitCsv[type].boneRes)
  end
  if 1 < #cacheRes then
    ResourceMgr:clear()
    ResourceMgr:addSpineRes(cacheRes)
  end
end

return DinerSellAnimateLayer

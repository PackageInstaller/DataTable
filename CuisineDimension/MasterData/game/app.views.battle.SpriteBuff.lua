local spineActSet = require("csvdata.spine_act")
local SpriteBuff = class("SpriteBuff")

function SpriteBuff:ctor(params)
  params = params or {}
  self.buff = params.buff
  self.bullet = self.buff.bullet
  self.player = self.buff.player
  self.csvData = self.buff.csvData
  bulletManager:load(self.bullet.id)
end

function SpriteBuff:onBeginEffect()
  if self.csvData.buffShow ~= "" then
    local nodeSize = self.player.nodeSize
    local actions = {}
    actions[#actions + 1] = cc.Spawn:create({
      cc.MoveBy:create(0.1, cc.p(0, 30)),
      cc.ScaleTo:create(0.1, 1.25)
    })
    actions[#actions + 1] = cc.DelayTime:create(0.2)
    actions[#actions + 1] = cc.Spawn:create({
      cc.MoveBy:create(0.1, cc.p(0, 10)),
      cc.ScaleTo:create(0.1, 1)
    })
    actions[#actions + 1] = cc.Spawn:create({
      cc.MoveBy:create(0.5, cc.p(0, 30)),
      cc.FadeOut:create(0.5)
    })
    actions[#actions + 1] = cc.RemoveSelf:create()
    display.newSprite(self.csvData.buffShow):pos(nodeSize.width / 2, 100):addTo(self.player.displayNode):runAction(transition.sequence(actions))
  end
  if not self.buff:effectOnce() then
    self:onEffect()
    self:onHideEffect()
  end
end

function SpriteBuff:onEffect()
  if self.csvData.changeColor ~= "" then
    local equalIdx = string.find(self.csvData.changeColor, "=")
    if equalIdx then
      local color = string.sub(self.csvData.changeColor, equalIdx + 1)
      self.player.armatureNode:setColor(UIHelper.hex2rgb(color))
    else
      UIHelper.setNodeShader(self.player.armatureNode, self.csvData.changeColor)
    end
  end
  if self.bullet.spineAct == 0 then
    self:plistEffect()
  else
    self:spineEffect()
  end
end

function SpriteBuff:onHideEffect()
  if self.csvData.hideTag ~= "" and self.csvData.hideTag == 1 then
    self.player.armatureNode:setOpacity(1)
  end
end

function SpriteBuff:plistEffect()
  if bulletManager:getFrameCount(self.bullet.id, "end") == 0 then
    return
  end
  game:playMusic(bulletManager:getMusicId(self.bullet.id, "end"))
  local scale = self.player.unit.hpBarHeight * self.player.widthScale / 14000
  local zorder = bulletManager:getZorder(self.bullet.id, "end")
  local ratation = self.player.side == SIDE_RIGHT and -1 or 1
  local sprite = display.newSprite(bulletManager:getFrame(self.bullet.id, "end"))
  sprite:setScaleX(scale * self.bullet.xScale / 100)
  sprite:setScaleY(scale * self.bullet.yScale / 100)
  sprite:flipX(self.player.side == SIDE_RIGHT)
  sprite:addTo(self.player.displayNode, 0 <= zorder and 10 + zorder or -10):anch(0.5, 0):pos(self.bullet.endXOffset * ratation, self.bullet.endYOffset)
  if self.buff:effectOnce() then
    sprite:playAnimationOnce(bulletManager:getAnimation(self.bullet.id, "end"), true)
  else
    sprite:playAnimationForever(bulletManager:getAnimation(self.bullet.id, "end"))
    self.effectNode = sprite
  end
end

function SpriteBuff:spineEffect()
  self.actData = spineActSet[self.bullet.spineAct]
  game:playMusic(self.actData.soundId)
  local scale = self.player.unit.hpBarHeight * self.player.widthScale / 14000
  local zorder = self.actData.zorder
  local ratation = self.player.side == SIDE_RIGHT and -1 or 1
  local effectNode = UIHelper.createSpineNode(self.actData.spineId)
  effectNode:setScaleX(effectNode:getScaleX() * scale * self.bullet.xScale / 100)
  effectNode:setScaleY(effectNode:getScaleY() * scale * self.bullet.yScale / 100)
  effectNode:setScaleX(effectNode:getScaleX() * ratation)
  effectNode:addTo(self.player.displayNode, 0 <= zorder and 10 + zorder or -10):anch(0.5, 0)
  effectNode:pos(self.bullet.endXOffset * ratation, self.bullet.endYOffset)
  effectNode:setAnimation(0, "special", true)
  self.effectNode = effectNode
  if self.buff:effectOnce() then
    printError("spine buff not support effectOnce" .. self.csvData.id)
  end
end

function SpriteBuff:onEnd()
  local hasColor = false
  local buffs = self.player.buffIds
  for id, buff in pairs(buffs) do
    if buff.num ~= 0 and id ~= self.buff.id then
      hasColor = buff.buffs[1].csvData.changeColor ~= "" and true or false
      if hasColor then
        break
      end
    end
  end
  if self.csvData.changeColor ~= "" and hasColor == false then
    if string.find(self.csvData.changeColor, "=") then
      self.player.armatureNode:setColor(self.player.nodeColor)
    else
      UIHelper.setNodeShader(self.player.armatureNode, "PositionTextureColor_noMVP")
    end
  end
  if self.effectNode and not tolua.isnull(self.effectNode) then
    self.effectNode:removeSelf()
  end
end

function SpriteBuff:onEndHide()
  local hasHide = false
  local buffs = self.player.buffIds
  for id, buff in pairs(buffs) do
    if buff.num ~= 0 and id ~= self.buff.id then
      hasHide = buff.buffs[1].csvData.hideTag == 1 and true or false
      if hasHide then
        break
      end
    end
  end
  if self.csvData.hideTag == 1 and hasHide == false then
    self.player.armatureNode:setOpacity(255)
  end
end

function SpriteBuff:show()
  if self.effectNode and not tolua.isnull(self.effectNode) then
    self.effectNode:show()
  end
end

function SpriteBuff:hide()
  if self.effectNode and not tolua.isnull(self.effectNode) then
    self.effectNode:hide()
  end
end

function SpriteBuff:dispose()
  if self.effectNode and not tolua.isnull(self.effectNode) then
    self.effectNode:removeSelf()
  end
end

return SpriteBuff

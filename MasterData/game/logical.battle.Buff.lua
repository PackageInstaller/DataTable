local buffDataSet = require("csvdata.buff")
local bulletDataSet = require("csvdata.bullet")
local skillDataSet = require("csvdata.skill")
local SpriteBuff = require("app.views.battle.SpriteBuff")
local BuffFactory = import(".BuffFactory")
local sheildType = {
  32,
  64,
  74,
  78
}
local effectOnceType = {
  136,
  142,
  145,
  146,
  147,
  148,
  162,
  164
}
local Buff = class("Buff")

function Buff:ctor(params)
  params = params or {}
  self.id = params.id or 0
  self.player = params.player
  self.releaser = params.releaser
  self.skillId = params.skillId
  if self.skillId and skillDataSet[self.skillId] then
    self.sumHurt = 0 < skillDataSet[self.skillId].sumHurt
  end
  self.inProgress = false
  self.hasFinished = false
  self.csvData = buffDataSet[self.id]
  self:initAttributes()
  self._attrChange = nil
  self._effect = nil
  self._update = nil
  self._recordValue = nil
  self._end = nil
  self.recordCount = nil
  if BuffFactory[self.csvData.type] then
    BuffFactory[self.csvData.type](self)
  end
  if self._recordValue then
    self:_recordValue(params)
  end
end

function Buff:initAttributes()
  self.bullet = bulletDataSet[self.csvData.bulletId]
  if self.bullet.spineAct ~= 0 then
  end
  self.otherBuffTime = 0
  self.leftTime = self.csvData.keepTime
  self.effectNum = self.csvData.effectNum == 0 and -1 or self.csvData.effectNum
  self.NewUnitTime = self.csvData.unitTime or 0
  self.detectUnit = 0
  self.effectValue = self.csvData.effectValue
  self.effectValue1 = self.csvData.effectValue2
  self.effectValue2 = self.csvData.effectValue3
  if self.csvData.effectValue4 == "" then
    self.effectValue3 = 0
  else
    self.effectValue3 = tonumber(self.csvData.effectValue4) or self.csvData.effectValue4
  end
end

function Buff:ChangeUnitTime(newTime)
  self.NewUnitTime = newTime
end

function Buff:beginEffect()
  if self._attrChange then
    local player = self.player
    player:setAttrDirty()
    if self.csvData.type == 3 then
      player:onChangeAttribute({
        name = BuffAtts[self.effectValue2],
        value = self.recordValue
      })
    end
  end
  if table.keyof(effectOnceType, self.csvData.type) then
    self:effect()
  end
  if table.keyof(sheildType, self.csvData.type) then
    self.player:onChangeShield()
  end
  if self.csvData.Icon ~= "" then
    self.player:setBuffIconDirty()
  end
  self.display = SpriteBuff.new({buff = self})
  self.display:onBeginEffect()
end

function Buff:update(dt)
  if self.hasFinished then
    return
  end
  local FRAME_MSEC = dt * 1000
  if self.otherBuffTime > 0 then
    self.otherBuffTime = self.otherBuffTime - dt
  else
    self.otherBuffTime = 0
  end
  if 0 > self.leftTime then
    self:dispose()
    self:endBuff()
    return
  end
  if 0 < self.detectUnit then
    self.leftTime = self.leftTime - FRAME_MSEC
    self.detectUnit = self.detectUnit - FRAME_MSEC
    return
  end
  if self._update then
    self:_update()
  end
  self.detectUnit = self.NewUnitTime
  self.leftTime = self.leftTime - FRAME_MSEC
  self.detectUnit = self.detectUnit - FRAME_MSEC
end

function Buff:effect(...)
  local result
  if self._effect then
    result = self:_effect(...)
  end
  if self.effectNum ~= -1 then
    self.effectNum = self.effectNum - 1
    if self.effectNum <= 0 then
      self.leftTime = 0
      self:endBuff()
    end
  end
  return result
end

function Buff:attrChange()
  if self._attrChange then
    self:_attrChange()
  end
end

function Buff:sheildChange(...)
  if self._sheildChange then
    self:_sheildChange(...)
  end
end

function Buff:attrValueChange(...)
  if self._attrValueChange then
    self:_attrValueChange(...)
  end
end

function Buff:levelChange(...)
  if self._levelChange then
    self:_levelChange(...)
    if self.csvData.Icon ~= "" then
      self.player:setBuffIconDirty()
    end
  end
end

function Buff:endBuff()
  if self.enterEnd then
    return
  end
  self.enterEnd = true
  if self._end then
    self:_end()
  end
  if self._attrChange then
    self.player:setAttrDirty()
  end
  if self.display then
    self.display:onEnd()
    self.display:onEndHide()
  end
  self.hasFinished = true
  if self.player.buffIds[self.id] then
    self.player.buffIds[self.id].num = self.player.buffIds[self.id].num - 1
    if self.player.buffIds[self.id].num <= 0 then
      self.player.buffIds[self.id] = nil
    end
    self.player:dispatchEvent({
      name = "buffEnd",
      buffId = self.id
    })
    self.player:onBuffEnd(self.id)
    self.player:onBuffEndByType(self.csvData.type)
    self.player:onBuffEndByDebuff(self.csvData.debuff)
    if table.keyof(sheildType, self.csvData.type) then
      self.player:onChangeShield()
    end
  end
  if self.csvData.type ~= 58 and self.player:hasBuff(58) then
    for _, _buff in ipairs(self.player.buffTypes[58]) do
      _buff:effect(self.id)
    end
  end
  if self.csvData.Icon ~= "" then
    self.player:setBuffIconDirty()
  end
end

function Buff:dispose()
  if self.display then
    self.display:dispose()
  end
end

function Buff:isDone()
  return self.leftTime <= 0 or self.hasFinished
end

function Buff:effectOnce()
  if not self.recordCount then
    return false
  end
  return self.recordCount > 0 and self.csvData.type ~= 64
end

function Buff:onEffect()
  self.display:onEffect()
end

function Buff:onBeginEffect()
end

return Buff

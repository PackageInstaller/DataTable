local module = class("moduleAreaLevel", G_UIModuleBase)
local _areaLeveTpl = L_GameTpl:getKiboDuelAreaLevelTpl()
local _areaTypeTpl = L_GameTpl:getKiboDuelAreaTypeTpl()

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {areaType = nil}
end

function module.bind()
  return {
    imgLevelIcon = "",
    txtAreaName = "",
    sliderExp = 0,
    txtExp = "",
    imgTargetLock = false
  }
end

function module.methods()
  return {}
end

function module:initModule(data)
  self.data.areaType = data.areaType
  self._lastLv = data.lastLv
  self._lastExp = data.lastExp
  self._curLv = data.curLv
  self._curExp = data.curExp
  self:refresh()
end

function module:refresh()
  local areaType = self.data.areaType
  if not areaType then
    return
  end
  local _math = math
  local areaInfo = L_PetDuelStore:getAreaInfo(areaType)
  local level = self._curLv or areaInfo:getlvl()
  local maxLevel = _areaLeveTpl:getMaxLevel(areaType)
  local areaTypeTpl = _areaTypeTpl:getTplById(areaType)
  local areaName = _areaTypeTpl:getName(areaTypeTpl)
  self._areaName = L_Lang:get(areaName)
  self.bind.imgLevelIcon = _areaTypeTpl:getUIIcon(areaTypeTpl)
  local lastLv = self._lastLv or areaInfo:getLastlvl()
  local tpl = _areaLeveTpl:getTpl(areaType, lastLv)
  local taskId = _areaLeveTpl:getTaskId(tpl)
  local isLimitTask = false
  self.bind.imgTargetLock = false
  if taskId and taskId ~= 0 then
    isLimitTask = not AzurWorld.TaskMgr:IsFinishTask(taskId)
  end
  self._maxLevel = maxLevel
  if maxLevel <= lastLv then
    self:showMaxLevel()
    self:refreshAreaLevelName(maxLevel)
  else
    local lastExp = self._lastExp or areaInfo:getlastExp()
    local exp = self._curExp or areaInfo:getExp()
    local curMaxExp = _areaLeveTpl:getMaxExp(areaType, level)
    local lastMaxExp = curMaxExp
    if lastLv ~= level then
      lastMaxExp = _areaLeveTpl:getMaxExp(areaType, lastLv)
    end
    local addExp = areaInfo:getExpDelta()
    local fromValue = _math.clamp(lastExp / lastMaxExp, 0, 1)
    local toValue
    if isLimitTask and exp >= lastMaxExp then
      self.bind.txtExp = string.format("%d/%d<color=#96F9FF>(+%d)</color>", exp, lastMaxExp, addExp)
      toValue = 1
      self.bind.imgTargetLock = isLimitTask
    elseif level >= maxLevel then
      self.bind.txtExp = "MAX"
      toValue = 1
    else
      self.bind.txtExp = string.format("%d/%d<color=#96F9FF>(+%d)</color>", exp, curMaxExp, addExp)
      toValue = _math.clamp(exp / curMaxExp, 0, 1)
    end
    self:refreshAreaLevelName(lastLv)
    self:handerExpAnim(fromValue, toValue, lastLv, level, isLimitTask, function()
      if level >= maxLevel then
        self:showMaxLevel()
      end
      self:refreshAreaLevelName(level)
    end)
    self:newOrResetTimer("onTimerShowAreaLevelUp", function()
      C_KiBoDuelLuaWrapper.ToNextAreaLevelUp()
    end, 2.5)
  end
end

function module:isLevelLimitTask(areaType, level)
  local tpl = _areaLeveTpl:getTpl(areaType, level)
  local taskId = _areaLeveTpl:getTaskId(tpl)
  if taskId and taskId ~= 0 then
    return not AzurWorld.TaskMgr:IsFinishTask(taskId)
  else
    return false
  end
end

function module:showMaxLevel()
  self.bind.sliderExp = 1
  self.bind.txtExp = "MAX"
end

function module:handerExpAnim(fromValue, toValue, fromLv, toLv, isLimitTask, complete)
  if toLv == fromLv then
    if fromValue < toValue then
      self:playExpDotween(fromValue, toValue, complete)
    else
      self.bind.sliderExp = toValue
      if complete then
        complete()
      end
    end
  elseif fromLv < toLv then
    self:playExpDotween(fromValue, 1, function()
      self:refreshAreaLevelName(fromLv + 1)
      local isMaxLv = fromLv + 1 >= self._maxLevel
      if isLimitTask and fromLv + 1 == toLv or isMaxLv then
        if complete then
          complete()
        end
        return
      end
      self:handerExpAnim(0, toValue, fromLv + 1, toLv, isLimitTask, complete)
    end)
  elseif complete then
    complete()
  end
end

function module:playExpDotween(fromValue, toValue, complete)
  self:killExpTween()
  self.bind.sliderExp = fromValue
  
  local function getter()
    return self.bind.sliderExp
  end
  
  local function setter(v)
    self.bind.sliderExp = v
  end
  
  local tween = DOTween.To(getter, setter, toValue, 3)
  tween:SetEase(Tweening.Ease.Linear)
  tween:OnComplete(complete)
  self.expTween = tween
end

function module:refreshAreaLevelName(level)
  self.bind.txtAreaName = table.concat({
    self._areaName,
    L_Const.Number2Roma[level]
  })
end

function module:killExpTween()
  if L_CommonUtil.isValid(self.expTween) then
    self.expTween:Kill()
    self.expTween = nil
  end
end

function module:close()
  self.data.areaType = nil
  self:killExpTween()
end

return module

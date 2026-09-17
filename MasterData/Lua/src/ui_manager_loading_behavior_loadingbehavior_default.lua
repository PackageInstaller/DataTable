local this = class("loadingBehavior_default", require("ui.manager.loading.behavior.loadingBehavior"))
local _tipTpl = L_GameTpl:getTipsTpl()
local _tipGroupTpl = L_GameTpl:getTipsGroupTpl()

function this:bind()
  return {
    txtTip = "",
    fillImg = 0,
    colorBg = C_Color(1, 1, 1, 1)
  }
end

function this.methods()
  return {
    onClick_next = function(self)
      self:refreshNext()
    end
  }
end

function this:open(...)
  this.super.open(self, ...)
  self.timeRefresh = L_GameConstTpl:getData("TIPS_REFRESH", L_Const.GameTplType.int)
  self.curTime = 0
end

function this:blend(nextMode, options)
  local canBlend = nextMode == L_Const.loadingMode.scene or nextMode == self:getMode()
  if canBlend then
    options.mode = self:getMode()
    table.merge(self, options)
  end
  return canBlend
end

function this:update()
  self.curTime = self.curTime + C_Time.deltaTime
  if self.curTime >= self.timeRefresh then
    self:refreshNext()
  end
end

function this:updateProgress(progress, options)
  self.bind.fillImg = progress
end

function this:updateProgressMax()
  self.bindComponents.anim:Play("anim_loading_out")
  self.timerDic.max = Timer.once(0.167, self.complete, self, self.gameObject)
end

function this:start()
  self:initConfig()
  self:refreshView(self.gId, self.index)
  self:refreshColor()
end

function this:initConfig()
  local tpl = _tipTpl:getDefaultTpl()
  self.gId = _tipTpl:getGroupId(tpl)
  self.index = 1
end

function this:refreshView(gId, index)
  local list = _tipGroupTpl:getTplListByGroupId(gId)
  local tpl = list[index]
  local des = _tipGroupTpl:getTips(tpl)
  self.bind.txtTip = des
  return tpl
end

function this:refreshNext()
  local list = _tipGroupTpl:getTplListByGroupId(self.gId)
  local index = #list <= self.index and 1 or self.index + 1
  self.curTime = 0
  if index ~= self.index then
    self.index = index
    self:refreshView(self.gId, self.index)
  end
end

function this:refreshColor()
  local isDay = self:getIsDay()
  local color = isDay and C_Color(1, 1, 1, 1) or C_Color(0, 0, 0, 1)
  self.bind.colorBg = color
  return color
end

function this:getIsDay()
  local timeStr = L_GameConstTpl:getData("LOADING_DAYTIME", L_Const.GameTplType.string)
  local list = string.split(timeStr, ",")
  local date = L_TimeUtil.getServerTime()
  local curTime = L_TimeUtil.getDateInfo(date)
  local time = curTime.hour
  local isDay = time >= tonumber(list[1]) and time < tonumber(list[2])
  return isDay
end

return this

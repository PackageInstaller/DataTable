local TinyGameFrameController = class("TinyGameFrameController")
local LOGIC_FRAME_LEN = 33

function TinyGameFrameController:ctor()
  self.__isGameRunning = false
  self.logicFrameNum = 0
  self.__passedTimeSum = 0
  self.logicCallback = nil
  self.renderCallback = nil
  self._OnUpdate = BindCallback(self, self.__OnUpdate)
end

function TinyGameFrameController:StartRunning(logicCallback, renderCallback)
  self.__isGameRunning = true
  self:CleanLogic()
  self.logicCallback = logicCallback
  self.renderCallback = renderCallback
  UpdateManager:AddUpdate(self._OnUpdate)
end

function TinyGameFrameController:StopRunning()
  self.__isGameRunning = false
  self:CleanLogic()
  self.logicCallback = nil
  self.renderCallback = nil
  UpdateManager:RemoveUpdate(self._OnUpdate)
end

function TinyGameFrameController:CleanLogic()
  self.logicFrameNum = 0
  self.__passedTimeSum = 0
end

function TinyGameFrameController:__OnUpdate()
  if not self.__isGameRunning then
    return
  end
  local deltaTime = Time.deltaTime
  self.__passedTimeSum = self.__passedTimeSum + deltaTime * 1000
  while self.__passedTimeSum > LOGIC_FRAME_LEN do
    self.logicFrameNum = self.logicFrameNum + 1
    self.__passedTimeSum = self.__passedTimeSum - LOGIC_FRAME_LEN
    self:__OnUpdateLogic(self.logicFrameNum)
  end
  self:__OnUpdateRender()
end

function TinyGameFrameController:__OnUpdateLogic(logicFrameNum)
  if self.logicCallback ~= nil then
    self.logicCallback(logicFrameNum)
  end
end

function TinyGameFrameController:__OnUpdateRender()
  local timeRate = self.__passedTimeSum / LOGIC_FRAME_LEN
  if self.renderCallback ~= nil then
    self.renderCallback(timeRate)
  end
end

function TinyGameFrameController:GetCurLogicFrameNum()
  return self.logicFrameNum
end

function TinyGameFrameController:GetLogicFrameLen()
  return LOGIC_FRAME_LEN
end

function TinyGameFrameController:GetIsRunning()
  return self.__isGameRunning
end

function TinyGameFrameController:OnDelete()
end

return TinyGameFrameController

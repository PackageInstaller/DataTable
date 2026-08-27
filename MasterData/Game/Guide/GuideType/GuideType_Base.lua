local GuideType_Base = class("GuideType_Base")
local CS_GSceneManager_Ins = CS.GSceneManager.Instance
local CS_GameObject = CS.UnityEngine.GameObject
local fallbackTime = 15

function GuideType_Base:StartGuide()
end

function GuideType_Base:EndGuide(success, isBreak)
end

function GuideType_Base:BreakEndGuide()
end

function GuideType_Base:OnStepFinishAction(stepIndex, action)
  if action ~= nil then
    action()
  end
end

function GuideType_Base:NeedWaitWarn()
  return true
end

function GuideType_Base:BeforeRunCode()
  if self.guideStepCfg == nil then
    return
  end
  if not string.IsNullOrEmpty(self.guideStepCfg.after_code) then
    local afterExeCode = load(self.guideStepCfg.after_code)
    if afterExeCode == nil then
      warn(string.format("guide error id[%d],index[%d],stepId[%d],after code error,interrupt", self.guideCfg.id, self.guideIndex, self.guideStepCfg.id))
      self:EndGuide(false)
      return
    end
    local status, current = xpcall(afterExeCode, debug.traceback)
    if not status then
      error(current)
      return
    end
  end
end

function GuideType_Base:RunNextInternal(guideStepCfg)
  self:BeforeRunCode()
  if guideStepCfg.delay ~= nil and guideStepCfg.delay > 0 then
    self.waitTimerId = TimerManager:StartTimer(guideStepCfg.delay, self.RunCurStep, self, true, false, self:IsTimerUnScale())
  else
    self:RunCurStep()
  end
end

function GuideType_Base:RunCurStep()
  self.waitTimerId = nil
end

function GuideType_Base:NextWaitUIWindow(guideStepCfg)
  local targetWindow = UIManager:GetWindow(guideStepCfg.target_parent)
  if targetWindow ~= nil then
    self:RunNextInternal(guideStepCfg)
    return
  end
  if guideStepCfg.wait_target then
    local waittime = Time.realtimeSinceStartup
    
    local function waitWindowFunc()
      local waitWindow = UIManager:GetWindow(guideStepCfg.target_parent)
      if waitWindow ~= nil then
        TimerManager:StopTimer(self.waitTimerId)
        self.waitTimerId = nil
        self:RunNextInternal(guideStepCfg)
      else
        local time = Time.realtimeSinceStartup - waittime
        if time > fallbackTime then
          TimerManager:StopTimer(self.waitTimerId)
          self.waitTimerId = nil
          if self:NeedWaitWarn() then
            warn(string.format("guide error,%s Id[%d],wait targetWindow overtime", self.__class_type.__cname, guideStepCfg.id))
          end
          self:EndGuide(false)
        end
      end
    end
    
    self.waitTimerId = TimerManager:StartTimer(0.2, waitWindowFunc, nil, false, false, self:IsTimerUnScale())
  else
    if self:NeedWaitWarn() then
      warn(string.format("guide error,%s Id[%d],targetWindow is null,interrupt", self.__class_type.__cname, guideStepCfg.id))
    end
    self:EndGuide(false)
  end
end

function GuideType_Base:NextWaitSceneTarget(guideStepCfg)
  if string.IsNullOrEmpty(guideStepCfg.target_name) then
    self:RunNextInternal(guideStepCfg)
    return
  end
  local targetObj = CS_GameObject.Find(guideStepCfg.target_name)
  if not IsNull(targetObj) then
    self.curTargetTransform = targetObj.transform
    self:RunNextInternal(guideStepCfg)
    return
  end
  if guideStepCfg.wait_target then
    local waittime = Time.realtimeSinceStartup
    
    local function waitTargetFunc()
      local targetObj = CS_GameObject.Find(guideStepCfg.target_name)
      if not IsNull(targetObj) then
        TimerManager:StopTimer(self.waitTimerId)
        self.waitTimerId = nil
        self.curTargetTransform = targetObj.transform
        self:RunNextInternal(guideStepCfg)
      else
        local time = Time.realtimeSinceStartup - waittime
        if time > fallbackTime then
          TimerManager:StopTimer(self.waitTimerId)
          self.waitTimerId = nil
          if self:NeedWaitWarn() then
            warn(string.format("guide error,%s Id[%d],wait scene target overtime", self.__class_type.__cname, guideStepCfg.id))
          end
          self:EndGuide(false)
        end
      end
    end
    
    self.waitTimerId = TimerManager:StartTimer(0.2, waitTargetFunc, nil, false, false, self:IsTimerUnScale())
  else
    if self:NeedWaitWarn() then
      warn(string.format("guide error,%s Id[%d],target is null,interrupt", self.__class_type.__cname, guideStepCfg.id))
    end
    self:EndGuide(false)
  end
end

function GuideType_Base:NextWaitScene(guideStepCfg, nextAction)
  local targetSceneName = guideStepCfg.target_parent
  if string.IsNullOrEmpty(targetSceneName) then
    nextAction(self)
    return
  end
  local scene_Name = CS_GSceneManager_Ins.curSceneName
  if scene_Name == targetSceneName then
    nextAction(self)
  elseif guideStepCfg.wait_target then
    local waittime = Time.realtimeSinceStartup
    
    local function waitTargetFunc()
      local waitScene = CS_GSceneManager_Ins.curSceneName
      if waitScene == targetSceneName then
        TimerManager:StopTimer(self.waitTimerId)
        self.waitTimerId = nil
        nextAction(self)
      else
        local time = Time.realtimeSinceStartup - waittime
        if time > fallbackTime then
          TimerManager:StopTimer(self.waitTimerId)
          self.waitTimerId = nil
          if self:NeedWaitWarn() then
            warn(string.format("guide error,%s Id[%d],wait scene overtime", self.__class_type.__cname, guideStepCfg.id))
          end
          self:EndGuide(false)
        end
      end
    end
    
    self.waitTimerId = TimerManager:StartTimer(0.2, waitTargetFunc, nil, false, false, self:IsTimerUnScale())
  else
    if self:NeedWaitWarn() then
      warn(string.format("guide error,%s Id[%d],scene is null,interrupt", self.__class_type.__cname, guideStepCfg.id))
    end
    self:EndGuide(false)
  end
end

function GuideType_Base:NextWaitScriptTarget(guideStepCfg)
  local configFunc = load(guideStepCfg.target_name)
  if configFunc == nil then
    warn(string.format("guide error,%s Id[%d],load function is null,interrupt", self.__class_type.__cname, guideStepCfg.id))
    self:EndGuide(false)
    return
  end
  local target = configFunc()
  if not IsNull(target) then
    self.curTargetTransform = target.transform
    self:RunNextInternal(guideStepCfg)
    return
  elseif guideStepCfg.wait_target then
    local waittime = Time.realtimeSinceStartup
    
    local function waitTargetFunc()
      local targetObj = configFunc()
      if not IsNull(targetObj) then
        TimerManager:StopTimer(self.waitTimerId)
        self.waitTimerId = nil
        self.curTargetTransform = targetObj.transform
        self:RunNextInternal(guideStepCfg)
      else
        local time = Time.realtimeSinceStartup - waittime
        if time > fallbackTime then
          TimerManager:StopTimer(self.waitTimerId)
          self.waitTimerId = nil
          if self:NeedWaitWarn() then
            warn(string.format("guide error,%s Id[%d],wait script target overtime", self.__class_type.__cname, guideStepCfg.id))
          end
          self:EndGuide(false)
        end
      end
    end
    
    self.waitTimerId = TimerManager:StartTimer(0.2, waitTargetFunc, nil, false, false, self:IsTimerUnScale())
  else
    if self:NeedWaitWarn() then
      warn(string.format("guide error,%s Id[%d],script target is null,interrupt", self.__class_type.__cname, guideStepCfg.id))
    end
    self:EndGuide(false)
  end
end

function GuideType_Base:IsTimerUnScale()
  return not (Time.unity_time.timeScale > 0)
end

return GuideType_Base

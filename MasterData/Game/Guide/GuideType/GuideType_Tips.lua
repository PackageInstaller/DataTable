local GuideType_Base = require("Game.Guide.GuideType.GuideType_Base")
local GuideType_Tips = class("GuideType_Tips", GuideType_Base)
local GuideEnum = require("Game.Guide.GuideEnum")
local GuideConditionChecker = require("Game.Guide.GuideConditionChecker")
local CS_GameObject = CS.UnityEngine.GameObject
local Type_RectTransform = typeof(CS.UnityEngine.RectTransform)
local CS_GSceneManager_Ins = CS.GSceneManager.Instance

function GuideType_Tips:ctor()
  self.isTipsGuideEnd = false
end

function GuideType_Tips:NeedWaitWarn()
  return false
end

function GuideType_Tips:StartGuide(tipsGuideCfg)
  self.tipsGuideCfg = tipsGuideCfg
  self:StartTipsGuide()
end

function GuideType_Tips:EndGuide(success)
  self.curTargetTransform = nil
  self.curBindTransform = nil
  if self.waitTimerId ~= nil then
    TimerManager:StopTimer(self.waitTimerId)
    self.waitTimerId = nil
  end
  self.tipsGuideCfg = nil
  self.isTipsGuideEnd = true
end

function GuideType_Tips:BeforeRunCode()
end

function GuideType_Tips:StartTipsGuide()
  if self.tipsGuideCfg.type == GuideEnum.TipsGuideType.Normal then
    if self.tipsGuideCfg.target_type == 0 then
      self:RunCurStep()
    elseif self.tipsGuideCfg.target_type == 1 then
      self:NextWaitUIWindow(self.tipsGuideCfg)
    elseif self.tipsGuideCfg.target_type == 2 then
      self:NextWaitScene(self.tipsGuideCfg, BindCallback(self, self.NextWaitSceneTarget, self.tipsGuideCfg))
    elseif self.tipsGuideCfg.target_type == 3 then
      self:NextWaitScriptTarget(self.tipsGuideCfg)
    else
      error("tipsGuideCfg target_type error,id:" .. tostring(self.tipsGuideCfg.id))
      self:EndGuide(false)
    end
  elseif self.tipsGuideCfg.type == GuideEnum.TipsGuideType.Code then
    self:RunNextInternal(self.tipsGuideCfg)
  else
    error("tipsGuideCfg type error,id:" .. tostring(self.tipsGuideCfg.id))
    self:EndGuide(false)
  end
end

function GuideType_Tips:RunCurStep()
  GuideType_Base.RunCurStep(self)
  if self.tipsGuideCfg.type == GuideEnum.TipsGuideType.Normal then
    self:__PlayNormalUITipsGuide()
  elseif self.tipsGuideCfg.type == GuideEnum.TipsGuideType.Code then
    local guideCode = load(self.tipsGuideCfg.custom_code)
    local status, current = xpcall(guideCode, debug.traceback)
    if not status then
      error(current)
    else
      self:EndGuide(current)
    end
  end
end

function GuideType_Tips:__PlayNormalUITipsGuide()
  if self.tipsGuideCfg.target_type == 1 then
    local targetWindow = UIManager:GetWindow(self.tipsGuideCfg.target_parent)
    if targetWindow == nil then
      self:EndGuide(false)
      return
    end
    local targetTrans = targetWindow.transform:Find(self.tipsGuideCfg.target_name)
    if IsNull(targetTrans) then
      warn(string.format("guide error,%s Id[%d],target Transform is null", self.__class_type.__cname, self.tipsGuideCfg.id))
      self:EndGuide(false)
      return
    end
    self.curTargetTransform = targetTrans
  end
  self:__PlayTipsGuide()
end

function GuideType_Tips:__PlayTipsGuide()
  if IsNull(self.curTargetTransform) then
    warn(string.format("guide error,%s Id[%d],play target Transform is null", self.__class_type.__cname, self.tipsGuideCfg.id))
    self:EndGuide(false)
    return
  end
  local isRectTrasform = true
  if self.tipsGuideCfg.target_type > 1 then
    isRectTrasform = GR.IsType(self.curTargetTransform, Type_RectTransform)
  end
  if not isRectTrasform then
    if self.tipsGuideCfg.target_type == 2 then
      local bindObj = CS_GameObject.Find(self.tipsGuideCfg.target_name)
      if IsNull(bindObj) then
        warn(string.format("guide error,%s Id[%d],bind transform is null", self.__class_type.__cname, self.tipsGuideCfg.id))
        self:EndGuide(false)
        return
      end
      self.curBindTransform = bindObj.transform
    elseif self.tipsGuideCfg.target_type == 3 then
      local configFunc = load(self.tipsGuideCfg.target_name)
      local targetBindTrans = configFunc()
      if IsNull(targetBindTrans) then
        warn(string.format("guide error,%s Id[%d],bind transform is null", self.__class_type.__cname, self.tipsGuideCfg.id))
        self:EndGuide(false)
        return
      end
      self.curBindTransform = targetBindTrans.transform
    else
      self:EndGuide(false)
      return
    end
  end
  local success = false
  if isRectTrasform then
    GuideManager.resloader:LoadABAssetAsync(PathConsts:GetUIPrefabPath(GuideUtil.TipsGuidePrefabName), function(guidePrefab)
      self:ShowUITipsGuide(guidePrefab)
    end)
  else
  end
end

function GuideType_Tips:ShowUITipsGuide(guidePrefab)
  if self.isTipsGuideEnd then
    return
  end
  if IsNull(self.curTargetTransform) then
    self:EndGuide(false)
    return
  end
  if string.IsNullOrEmpty(self.tipsGuideCfg.custom_code) then
    GuideUtil.ShowTipsGuide(self.curTargetTransform, guidePrefab, self.tipsGuideCfg.show_dir, self.tipsGuideCfg)
  else
    local guideCode = load(self.tipsGuideCfg.custom_code)
    local status, current = xpcall(guideCode, debug.traceback)
    if not status then
      error(current)
    else
      current(self.curTargetTransform, guidePrefab, self.tipsGuideCfg.show_dir)
    end
  end
  self:EndGuide(true)
end

function GuideType_Tips.TryClearTipsGuide(id)
  local tipsGuideCfg = ConfigData.tips_guide[id]
  if tipsGuideCfg == nil then
    error("tips_guide Cfg is null,id:" .. tostring(id))
    return
  end
  if not GuideConditionChecker.CheckGuideCondition(tipsGuideCfg.condition, tipsGuideCfg.condition_arg, GuideManager.extendArg) then
    return
  end
  local curTargetTransform
  if tipsGuideCfg.type == GuideEnum.TipsGuideType.Normal then
    if tipsGuideCfg.target_type == 0 then
    elseif tipsGuideCfg.target_type == 1 then
      local targetWindow = UIManager:GetWindow(tipsGuideCfg.target_parent)
      if targetWindow ~= nil then
        curTargetTransform = targetWindow.transform:Find(tipsGuideCfg.target_name)
      end
    elseif tipsGuideCfg.target_type == 2 then
      if string.IsNullOrEmpty(tipsGuideCfg.target_parent) or CS_GSceneManager_Ins.curSceneName == tipsGuideCfg.target_parent then
        local targetObj = CS_GameObject.Find(tipsGuideCfg.target_name)
        if not IsNull(targetObj) then
          curTargetTransform = targetObj.transform
        end
      end
    elseif tipsGuideCfg.target_type == 3 then
      local configFunc = load(tipsGuideCfg.target_name)
      if configFunc ~= nil then
        local target = configFunc()
        if not IsNull(target) then
          curTargetTransform = target.transform
        end
      end
    end
  elseif tipsGuideCfg.type == GuideEnum.TipsGuideType.Code then
    if not string.IsNullOrEmpty(tipsGuideCfg.custom_code_clear) then
      local guideCode = load(tipsGuideCfg.custom_code_clear)
      if guideCode ~= nil then
        local status, current = xpcall(guideCode, debug.traceback)
        if not status then
          error(current)
        end
      end
    end
    return
  end
  if not IsNull(curTargetTransform) then
    local tipsGuideNodeName = GuideUtil.GetTipsGuideNodeName(curTargetTransform.name)
    local tipsGuideNode = curTargetTransform:Find(tipsGuideNodeName)
    if not IsNull(tipsGuideNode) then
      DestroyUnityObject(tipsGuideNode.gameObject)
    end
  end
end

return GuideType_Tips

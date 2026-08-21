_class("UIHomelandTaskFinishEffect", UIController)
UIHomelandTaskFinishEffect = UIHomelandTaskFinishEffect

function UIHomelandTaskFinishEffect:OnShow(uiParams)
  self._mainCharacter = self:_GetMainCharacterController()
  self._mainCharacter:SetForbiddenMove(true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PlayerControllerUIStatus, false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SetMinimapStatus, false)
  local id = uiParams[1] or 0
  self._mcTransform = self._mainCharacter:Transform()
  self._npcTransform = uiParams[2]
  self._targetPos = uiParams[3]
  self._callback = uiParams[4]
  self._cfg = Cfg.cfg_homeland_task_finish_effect[id]
  if not self._cfg then
    Log.exception("UIHomelandTaskFinishEffect_OnShow cfg_homeland_task_finish_effect[", id("] = nil"))
    self:CloseDialog()
    return
  end
  self:_SetDebug()
  self:_Play()
end

function UIHomelandTaskFinishEffect:OnHide()
  self._effectModel = self:_UnLoadEffect(self._effectModel)
  self._te = UIActivityHelper.CancelTimerEvent(self._te)
end

function UIHomelandTaskFinishEffect:_Play()
  self:_NpcRotateMc()
  self:_McRotatePosition()
  self:StartTask(self._Play_McAnimation, self)
  self:StartTask(self._Play_McEffect, self)
  self:StartTask(self._Close, self)
end

function UIHomelandTaskFinishEffect:_Close(TT)
  self:Lock("UIHomelandTaskFinishEffect_Close")
  local t = self._cfg.CloseTime or 10000
  YIELD(TT, t)
  self._mainCharacter:SetForbiddenMove(false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PlayerControllerUIStatus, true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SetMinimapStatus, true)
  if self._callback then
    self._callback()
  end
  self:CloseDialog()
  self:UnLock("UIHomelandTaskFinishEffect_Close")
end

function UIHomelandTaskFinishEffect:_NpcRotateMc()
  if self._cfg.NpcRotateMc and self._npcTransform then
    self:_Rotate(self._npcTransform, self._mcTransform.position)
  end
end

function UIHomelandTaskFinishEffect:_McRotatePosition()
  if self._cfg.McRotatePosition and self._targetPos then
    self:_Rotate(self._mcTransform, self._targetPos)
  end
end

function UIHomelandTaskFinishEffect:_Rotate(transA, posB)
  local toward = posB - transA.position
  toward.y = 0
  transA:DORotate(Quaternion.LookRotation(toward).eulerAngles, 0.1)
end

function UIHomelandTaskFinishEffect:_Play_McAnimation(TT)
  local name = self._cfg.McAnimation
  if not name or string.isnullorempty(name) then
    return
  end
  local time1 = self._cfg.McAnimationTime[1]
  local time2 = self._cfg.McAnimationTime[2]
  local lockName = "UIHomelandTaskFinishEffect_Play_McAnimation"
  self:Lock(lockName)
  YIELD(TT, time1)
  self._mainCharacter:SetAnimatorBool(name, true)
  YIELD(TT, time2)
  self._mainCharacter:SetAnimatorBool(name, false)
  self:UnLock(lockName)
end

function UIHomelandTaskFinishEffect:_Play_McEffect(TT)
  local name = self._cfg.McEffectPrefab
  if not name or string.isnullorempty(name) then
    return
  end
  local path = self._cfg.McEffectAttachPath
  local time1 = self._cfg.McEffectTime[1]
  local time2 = self._cfg.McEffectTime[2]
  local lockName = "UIHomelandTaskFinishEffect_Play_McEffect"
  self:Lock(lockName)
  YIELD(TT, time1)
  self._effectModel = self:_LoadEffect(name, path)
  YIELD(TT, time2)
  self._effectModel = self:_UnLoadEffect(self._effectModel)
  self:UnLock(lockName)
end

function UIHomelandTaskFinishEffect:_LoadEffect(effName, attachPath)
  local effectModel = ResourceManager:GetInstance():SyncLoadAsset(effName, LoadType.GameObject)
  if effectModel then
    local go = effectModel.Obj
    go:SetActive(true)
    local parent = self._mcTransform:Find(attachPath)
    go.transform:SetParent(parent, false)
  end
  return effectModel
end

function UIHomelandTaskFinishEffect:_UnLoadEffect(effectModel)
  if effectModel then
    effectModel:Dispose()
  end
  return nil
end

function UIHomelandTaskFinishEffect:_GetMainCharacterController()
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local characterController = homelandClient:CharacterManager():MainCharacterController()
  return characterController
end

function UIHomelandTaskFinishEffect:_SetDebug()
  local open = UIActivityHelper.CheckDebugOpen()
  self:GetGameObject("_debug"):SetActive(open)
  if open then
    self._t = 0
    self._te = UIActivityHelper.StartTimerEvent(self._te, function()
      self._t = self._t + 100
      UIWidgetHelper.SetLocalizationText(self, "txtDebug", self._t)
    end, 100)
  end
end

function UIHomelandTaskFinishEffect:DebugBtnOnClick()
  self._te = UIActivityHelper.CancelTimerEvent(self._te)
end

local LbIntrctActionData = class("LbIntrctActionData")
local cs_MessageCommon = CS.MessageCommon

function LbIntrctActionData:InitLbIntrctAction(actionCfg, entity, intrctFunc, eActIntrct)
  self._actionCfg = actionCfg
  self._intrctEntity = entity
  self._intrctFunc = intrctFunc
  self._eActIntrct = eActIntrct
  self._intrctData = entity:GetLbIntrctEntData()
end

function LbIntrctActionData:GetLbIntrctActionName()
  return LanguageUtil.GetLocaleText(self._actionCfg.obj_func_name)
end

function LbIntrctActionData:GetLbIntrctActionIconName()
  return self._actionCfg.func_icon
end

function LbIntrctActionData:GetLbIntrctActionSmallIconName()
  return self._actionCfg.interact_icon
end

function LbIntrctActionData:GetLbInterctActionHighLightColor()
  return self._actionCfg.high_light_color
end

function LbIntrctActionData:GetLbIntrctActionSubName()
  local func = self._eActIntrct.eSubNameFuncs[self._actionCfg.obj_func_id]
  if func then
    return func(self._intrctEntity, self._actionCfg)
  end
  return LanguageUtil.GetLocaleText(self._actionCfg.obj_func_subname)
end

function LbIntrctActionData:GetLbIntrctActionId()
  return self._actionCfg.obj_func_id
end

function LbIntrctActionData:ExternalOpeActionUI(entInfoItem)
  local funcDic = self._eActIntrct.eSpecialOpeEntInfoFunc
  if funcDic == nil then
    return
  end
  local func = funcDic[self._actionCfg.obj_func_id] or funcDic[0]
  if func then
    func(entInfoItem, self._intrctEntity)
  end
end

function LbIntrctActionData:ExternalHideActionUI(entInfoItem)
  local initFunc = self._eActIntrct.NormalInitEntInfoItem
  if initFunc then
    initFunc(entInfoItem, self._intrctEntity)
  end
end

function LbIntrctActionData:IsShowLbIntrctActionBluedot()
  local func = self._eActIntrct.eActIntrctActionShowBlueDotFunc[self._actionCfg.obj_func_id]
  if func then
    return func(self._intrctEntity, self._actionCfg)
  end
  return false
end

function LbIntrctActionData:GetLbIntrctActionLockStateDes()
  local func = self._eActIntrct.eActIntrctActionLockStateDesFunc[self._actionCfg.obj_func_id]
  if func then
    return func(self._intrctEntity, self._actionCfg)
  end
  return 0
end

function LbIntrctActionData:IsLbIntrctEntiUnlock()
  return self._intrctData:IsLbIntrctUnlock()
end

function LbIntrctActionData:GetLbIntrctActionLockClickTip()
  if self._eActIntrct.eActIntrctActionLockClickTipFunc then
    local func = self._eActIntrct.eActIntrctActionLockClickTipFunc[self._actionCfg.obj_func_id]
    if func then
      return func(self._intrctEntity, self._actionCfg)
    end
  end
end

function LbIntrctActionData:InvokeLbIntrctActionUIInit(uiItem)
  local func = self._eActIntrct.eActIntrctActionUIInitFunc[self._actionCfg.obj_func_id]
  if func == nil then
    return
  end
  func(uiItem, self._intrctEntity, self._actionCfg)
end

function LbIntrctActionData:InvokeLbIntrctAction(isQuickEntrance)
  if not self:IsLbIntrctEntiUnlock() then
    local tips = self:GetLbIntrctActionLockClickTip()
    if not string.IsNullOrEmpty(tips) then
      cs_MessageCommon.ShowMessageTips(tips)
    end
    return
  end
  if self._intrctFunc ~= nil then
    self._intrctFunc(self._intrctEntity, {isQuickEntrance = isQuickEntrance})
  end
end

function LbIntrctActionData:GetLbIntrctActionParams()
  return self._actionCfg.func_params
end

return LbIntrctActionData

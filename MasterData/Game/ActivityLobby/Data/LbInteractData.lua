local LbInteractData = class("LbInteractData")
local LbIntrctActionData = require("Game.ActivityLobby.Data.LbIntrctActionData")

function LbInteractData:ctor(interactObjCfg, eActIntrct)
  self._interactObjCfg = interactObjCfg
  self._eActIntrct = eActIntrct
end

function LbInteractData:GetLbIntrctObjType()
  return self._interactObjCfg.obj_type
end

function LbInteractData:GetLbIntrctObjPath()
  return self._interactObjCfg.obj_path
end

function LbInteractData:GetLbIntrctParentObjPath()
  return self._interactObjCfg.parent_obj
end

function LbInteractData:GetLbIntrctObjFxPath()
  return self._interactObjCfg.obj_fx_path
end

function LbInteractData:GetLbIntrctObjActionIdList()
  return self._interactObjCfg.obj_func
end

function LbInteractData:SetLbIntrctObjActions(actionList)
  self._actionList = actionList
end

function LbInteractData:GetLbIntrctObjActions()
  return self._actionList
end

function LbInteractData:GetLbIntrctObjActionFirst()
  return self._actionList[1]
end

function LbInteractData:GetLbIntrctObjHeroId()
  return self._interactObjCfg.hero_id
end

function LbInteractData:IsLbIntrctObjShowQuickEntrance()
  return self._interactObjCfg.is_quick
end

function LbInteractData:GetLbIntrctObjId()
  return self._interactObjCfg.obj_id
end

function LbInteractData:GetLbIntrctObjHide()
  return self._interactObjCfg.obj_hide
end

function LbInteractData:IsLbIntrctUnlock()
  local checkUnlockFunc = self._eActIntrct.eUnlockIntrctFunc[self._interactObjCfg.obj_id]
  if checkUnlockFunc == nil then
    return true
  end
  return checkUnlockFunc(self)
end

function LbInteractData:IsLbActIntrctObjHideHeadUI()
  return self._interactObjCfg.hide_head_ui
end

return LbInteractData

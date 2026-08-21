require("buff_logic_base")
_class("BuffLogicShowHidePetRoot", BuffLogicBase)
BuffLogicShowHidePetRoot = BuffLogicShowHidePetRoot

function BuffLogicShowHidePetRoot:Constructor(buffInstance, logicParam)
  self._state = logicParam.state or 0
  self._showModelAtLinkageEnd = logicParam.showModelAtLinkageEnd or 1
  self._hideEffectID = logicParam.hideEffectID
  self._hideAnimatorTrigger = logicParam.hideAnimatorTrigger
  self._hideTime = logicParam.hideTime
  self._avatarShowAnimatorTrigger = logicParam.avatarShowAnimatorTrigger
  self._avatarShowEffectID = logicParam.avatarShowEffectID
  self._avatarHideAnimatorTrigger = logicParam.avatarHideAnimatorTrigger
  self._avatarHideTime = logicParam.avatarHideTime
end

function BuffLogicShowHidePetRoot:DoLogic(notify)
  local result = {
    state = self._state,
    showModelAtLinkageEnd = self._showModelAtLinkageEnd,
    hideEffectID = self._hideEffectID,
    hideAnimatorTrigger = self._hideAnimatorTrigger,
    hideTime = self._hideTime,
    avatarShowAnimatorTrigger = self._avatarShowAnimatorTrigger,
    avatarShowEffectID = self._avatarShowEffectID,
    avatarHideAnimatorTrigger = self._avatarHideAnimatorTrigger,
    avatarHideTime = self._avatarHideTime
  }
  if notify and notify:GetNotifyType() == NotifyType.Benumbed then
    result.notifyEntityID = notify:GetNotifyEntity():GetID()
  end
  return result
end

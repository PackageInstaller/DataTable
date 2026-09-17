local state = class("petDuelCardDrag.normal")

function state:ctor(parent)
  self.owner = parent
  self.stateName = "normal"
end

function state:enter(lastState)
  self.parentTrans = self.owner.tree.targetListItem.transform
  self:dealEffect()
end

function state:exit(nextState)
  self:closeRefreshTimer()
  if L_CommonUtil.isValid(self.effectGameObject) then
    C_GameObject.DestroyImmediate(self.effectGameObject.gameObject)
  end
end

function state:dealEffect()
  local page = L_UI:getPage("pagePetDuel")
  local scale, dimension
  local offset = C_Vector2.zero
  local targetWorldPosition, targetRotation
  scale, dimension, offset, targetWorldPosition, targetRotation = L_EffectUtil.getEffectParams(self.owner.effectScale, self.owner.dimension, self.owner.offset, self.parentTrans)
  local board = page.gameObject.transform:Find("board") or page.gameObject.transform:Find("Board")
  board = board or page.gameObject.transform
  self.effectGameObject = L_EffectUtil.playEffect(self.owner.effectPath, board, scale, offset, dimension, targetWorldPosition, targetRotation)
  if L_CommonUtil.isValid(self.effectGameObject) and not self.isDestroy then
    local guideFxManager = self.effectGameObject:GetComponentInChildren(typeof(CS.Lens.Framework.UI.LGuideFxManager))
    if guideFxManager then
      self.scrollRect = self.parentTrans.gameObject:GetComponentInParent(typeof(C_LScrollRect))
      self.scrollView = self.parentTrans.gameObject:GetComponentInParent(typeof(CS.UnityEngine.UI.ScrollRect))
      self:setScrollDisable(true)
      self:changeLongPressStatus(false)
      guideFxManager.useMask = true
      guideFxManager.maskNoColor = true
      guideFxManager.useEventTransfer = false
      guideFxManager:InitGuide()
    end
    if self.refreshTimer == nil then
      self.refreshTimer = Timer.repeated(0.1, function()
        self:updateEffect()
      end)
    end
  end
  self.owner:showGuideControlMouse()
end

function state:updateEffect()
  if not (self.parentTrans ~= nil and self.effectGameObject ~= nil and L_CommonUtil.isValid(self.effectGameObject)) or self.isDestroy then
    return
  end
  if not L_CommonUtil.isValid(self.parentTrans) then
    return
  end
  local scale, dimension
  local offset = C_Vector2.zero
  local targetWorldPosition, targetRotation
  scale, dimension, offset, targetWorldPosition, targetRotation = L_EffectUtil.getEffectParams(self.owner.effectScale, self.owner.dimension, self.owner.offset, self.parentTrans)
  L_EffectUtil.setEffectParams(self.effectGameObject, scale, offset, dimension, targetWorldPosition, targetRotation)
  local guideFxManager = self.effectGameObject:GetComponentInChildren(typeof(CS.Lens.Framework.UI.LGuideFxManager))
  if guideFxManager ~= nil then
    guideFxManager:ResetMask()
  end
end

function state:changeLongPressStatus(status)
  C_LButton.GlobalLongInteractable = status
end

function state:setScrollDisable(disable)
  if L_CommonUtil.isValid(self.scrollRect) then
    self.scrollRect.disableScroll = disable
  end
  if L_CommonUtil.isValid(self.scrollView) then
    self.scrollView.enabled = not disable
  end
end

function state:closeRefreshTimer()
  if not self.refreshTimer then
    return
  end
  self.refreshTimer:destroy()
  self.refreshTimer = nil
end

function state:onUpdate()
end

return state

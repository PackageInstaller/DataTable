local UINOasisResItem = class("UINOasisResItem", UIBaseNode)
local base = UIBaseNode

function UINOasisResItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.rootBtn, self, self._OnClickRoot)
  self._loopScaleTweenPlaying = false
end

function UINOasisResItem:InitOasisResItem(itemId, buildingId)
  self.buildingId = buildingId
  self.gameObject.name = tostring(buildingId)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    return
  end
  self.ui.img_ItemIcon.sprite = CRH:GetSpriteByItemConfig(itemCfg)
end

function UINOasisResItem:RefreshOasisResItemPos(position)
  local anchorPos = UIManager:World2UIPosition(position)
  self.transform.anchoredPosition = anchorPos
end

function UINOasisResItem:RefreshOasisResItemState(progress)
  self.ui.img_Fill.fillAmount = progress
  self:PlayOasisResMaxTween(1 <= progress)
end

function UINOasisResItem:RefreshOasisResItemScale(scale)
  self.transform.localScale = Vector3.one * scale
end

function UINOasisResItem:_OnClickRoot()
  local ctrl = ControllerManager:GetController(ControllerTypeId.OasisController)
  if ctrl ~= nil then
    ctrl:CollectOasisRes(self.buildingId)
  end
end

function UINOasisResItem:PlayOasisResItemShowTween()
  self.ui.showTween.transform.localScale = Vector3.one * 0.5
  self.ui.showTween:DORestart()
end

function UINOasisResItem:PlayOasisResMaxTween(play)
  if self._loopScaleTweenPlaying == play then
    return
  end
  self._loopScaleTweenPlaying = play
  if play then
    self.ui.loopScaleTween.transform.localScale = Vector3.one
    self.ui.loopScaleTween:DORestart()
  else
    self.ui.loopScaleTween:DOKill()
  end
end

function UINOasisResItem:OnDelete()
  base.OnDelete(self)
end

return UINOasisResItem

local UINDunTowerSelectItem = class("UINDunTowerSelectItem", UIBaseNode)
local base = UIBaseNode
local cs_TweenLoop = CS.DG.Tweening.LoopType
local cs_Ease = CS.DG.Tweening.Ease

function UINDunTowerSelectItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_towerItem, self, self.OnSelectItemClick)
end

function UINDunTowerSelectItem:InitTowerSelectItem(catId, clickEvent, name)
  self.__catId = catId
  self.__clickEvent = clickEvent
  self.ui.tex_TowerName.text = name
  self.ui.img_Tower:SetIndex(catId)
  self.ui.img_Icon:SetIndex(catId)
  self:SetTowerSelected(false, true)
end

function UINDunTowerSelectItem:SetTowerSelected(selected, isinit)
  local looptime = 9
  local delaytime = selected and 0.02 or 0.04
  local pos = self.transform.localPosition.y
  self.ui.cg_tower.alpha = selected and 1 or 0.6
  if isinit then
    self.ui.img_Select.transform.localPosition = Vector3.New(174, self.transform.localPosition.y, 0)
    return
  end
  self:__ClearTween()
  if selected then
    self.ui.img_Select.transform:DOLocalMoveY(pos, 0.25):SetEase(cs_Ease.OutQuad)
    self.ui.img_Select:DOFade(0.3, 0.04):From():SetLoops(looptime + 2, cs_TweenLoop.Yoyo):SetDelay(delaytime)
  end
  self:__PlayFrameShakeTween(looptime, delaytime)
end

function UINDunTowerSelectItem:SetTowerReddot(active)
  self.ui.redDot_tower:SetActive(active)
end

function UINDunTowerSelectItem:SetTowerBluedot(active)
  self.ui.blueDot_tower:SetActive(active)
end

function UINDunTowerSelectItem:__PlayInitTween(__selectItem)
  local delaytime = (1 + self.__catId) * 0.05
  if self.__catId >= 1 then
    self.ui.img_IconAlpha.transform.parent:DOLocalMoveY(-30, 0.4):From():SetDelay((self.__catId - 1) * 0.1):SetEase(cs_Ease.OutQuad)
    self.ui.img_Select.transform:DOLocalMoveY(__selectItem.transform.localPosition.y - 20, 0.3):From():SetEase(cs_Ease.OutQuad)
    self.ui.img_Select:DOFade(0.3, 0.04):From():SetLoops(7, cs_TweenLoop.Restart):SetDelay(delaytime)
  end
  self.ui.cg_tower:DOFade(0, 0.3):From():SetDelay(self.__catId * 0.1)
  self:__PlayFrameShakeTween(7, delaytime)
end

function UINDunTowerSelectItem:__PlayFrameShakeTween(looptime, delaytime)
  self.ui.img_IconAlpha:DOFade(0.3, 0.03):From():SetLoops(looptime, cs_TweenLoop.Restart):SetDelay(delaytime)
  self.ui.tex_TowerName:DOFade(0.4, 0.03):From():SetLoops(looptime, cs_TweenLoop.Restart):SetDelay(delaytime)
  self.ui.img_Frame:DOFade(0.34, 0.03):From():SetLoops(looptime, cs_TweenLoop.Restart):SetDelay(delaytime)
end

function UINDunTowerSelectItem:OnSelectItemClick()
  if self.__clickEvent ~= nil and not self.ui.anim.isPlaying then
    self.__clickEvent(self.__catId, self)
  end
end

function UINDunTowerSelectItem:OnDelete()
  self.ui.img_IconAlpha.transform.parent:DOKill()
  self.ui.img_Select.transform:DOKill()
  self.ui.img_Select:DOKill()
  self.ui.img_IconAlpha:DOKill()
  self.ui.img_Frame:DOKill()
  self.ui.tex_TowerName:DOKill()
  self.ui.cg_tower:DOKill()
  base.OnDelete(self)
end

function UINDunTowerSelectItem:__ClearTween()
  self.ui.img_IconAlpha.transform.parent:DOComplete()
  self.ui.img_Select.transform:DOComplete()
  self.ui.img_Select:DOComplete()
  self.ui.img_IconAlpha:DOComplete()
  self.ui.img_Frame:DOComplete()
  self.ui.tex_TowerName:DOComplete()
  self.ui.cg_tower:DOComplete()
end

return UINDunTowerSelectItem

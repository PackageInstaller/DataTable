local UINTDProcessViewItem = class("UINTDProcessViewItem", UIBaseNode)
local base = UIBaseNode
local cs_EaseOutBack = CS.DG.Tweening.Ease.OutBack

function UINTDProcessViewItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINTDProcessViewItem:InitTDProcessViewItem(idx, mapData, completed)
  self.roomX = idx
  local col = completed and self.ui.col_orange or self.ui.col_gray
  self.ui.img_cube.color = col
  self.transform.localScale = Vector3.one
  self.ui.img_Room.gameObject:SetActive(false)
  local roomData = mapData:GetOneRoomByX(idx)
  if roomData == nil then
    return
  end
  local cfg = roomData:GetRoomTypeCfg()
  if cfg == nil then
    return
  end
  self.ui.img_Room.gameObject:SetActive(cfg.progress_show_Icon)
  self.ui.img_Room.sprite = CRH:GetSprite(cfg.icon, CommonAtlasType.ExplorationIcon)
end

function UINTDProcessViewItem:PlayScaleTween()
  self.transform.localScale = Vector3.zero
  self.transform:DOScale(Vector3.New(1.2, 1.2, 1), 0.35):SetRecyclable(true):SetLink(self.gameObject):SetEase(cs_EaseOutBack)
  self.ui.img_cube.color = self.ui.col_orange
end

function UINTDProcessViewItem:DOTweenKill()
  self.transform:DOKill()
end

function UINTDProcessViewItem:OnDelete()
  base.OnDelete(self)
end

return UINTDProcessViewItem

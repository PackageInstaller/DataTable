local UINHomeSideResItem = class("UINHomeSideResItem", UIBaseNode)
local base = UIBaseNode
local cs_DOTween = CS.DG.Tweening.DOTween

function UINHomeSideResItem:OnInit()
  self.isCollecting = false
  self.itemId = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINHomeSideResItem:Updatenfo(data)
  if self.isCollecting then
    return
  end
  if self.itemId ~= data.id then
    local itemCfg = ConfigData.item[data.id]
    if itemCfg == nil then
      error("Can't Find ItemCfg By ID:" .. data.id)
      return
    end
    self.ui.img_Icon.sprite = CRH:GetSprite(itemCfg.small_icon)
    self.itemId = data.id
  end
  self.ui.img_Period.fillAmount = data.progress
  self.ui.img_Rate.fillAmount = data.count / data.countMax
end

function UINHomeSideResItem:PlayCollect()
  if self.isCollecting then
    return
  end
  self.isCollecting = true
  local sequence = cs_DOTween.Sequence()
  sequence:Append(self.ui.img_Rate:DOFillAmount(0, self.ui.img_Rate.fillAmount * 2))
  sequence:AppendCallback(function()
    self.isCollecting = false
  end)
end

function UINHomeSideResItem:OnDelete()
  base.OnDelete(self)
end

return UINHomeSideResItem

local UIWCMapPointItem = class("UIWCMapPointItem", UIBaseNode)
local base = UIBaseNode

function UIWCMapPointItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self:HideCareerIcon()
end

function UIWCMapPointItem:GetSizeDelta()
  return self.ui.rect_mapPoint.sizeDelta
end

function UIWCMapPointItem:SetLocalPos(x, y)
  self.ui.rect_mapPoint.localPosition = Vector2.New(x, y)
end

function UIWCMapPointItem:SetImgItemInfo(index)
  self.ui.uiItem_mapPoint:SetIndex(index)
end

function UIWCMapPointItem:SetImgCareer(monsterCfg)
  if not monsterCfg then
    self:HideCareerIcon()
  end
  local careerId = monsterCfg.career
  local careerCfg = ConfigData.career[careerId]
  if careerCfg == nil then
    error("Can't find careerCfg, campId = " .. tostring(careerId))
  else
    self.ui.img_career.sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
    self.ui.img_career.gameObject:SetActive(true)
    self.careerIconActive = true
  end
end

function UIWCMapPointItem:HideCareerIcon()
  if self.careerIconActive == nil or self.careerIconActive then
    self.ui.img_career.gameObject:SetActive(false)
    self.careerIconActive = false
  end
end

function UIWCMapPointItem:OnDelete()
  base.OnDelete(self)
end

return UIWCMapPointItem

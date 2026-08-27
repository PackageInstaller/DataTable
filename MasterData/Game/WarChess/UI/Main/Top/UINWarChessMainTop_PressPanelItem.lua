local UINWarChessMainTop_PressPanelItem = {}
local base = UIBaseNode
local UINWarChessMainTop_PressPanelItem = class("UINWarChessMainTop_PressPanelItem", UIBaseNode)

function UINWarChessMainTop_PressPanelItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWarChessMainTop_PressPanelItem:RefreshWCPressItem(stressPoint, stressCfg, sprite)
  local isReached = stressPoint >= stressCfg.stresspoint
  if isReached then
    self.ui.img_pressureItem:SetIndex(0)
    self.ui.tween_icon:DOPlay()
    self.ui.img_isActive.color = self.ui.color_ActiveImg
  else
    self.ui.img_pressureItem:SetIndex(1)
    self.ui.tween_icon:DOPause()
    self.ui.img_isActive.color = self.ui.color_notActiveImg
  end
  self.ui.obj_isActive:SetActive(isReached)
  self.ui.obj_inactive:SetActive(not isReached)
  if isReached then
  else
    self.ui.slider_inactive.value = stressPoint / stressCfg.stresspoint
    self.ui.tex_Inactive.text = tostring(stressPoint) .. "/" .. tostring(stressCfg.stresspoint)
  end
  if stressCfg.level < 10 then
    self.ui.tex_Lv:SetIndex(0, tostring(stressCfg.level))
  else
    self.ui.tex_Lv:SetIndex(1, tostring(stressCfg.level))
  end
  local index = 0
  self.ui.img_Icon.gameObject:SetActive(sprite ~= nil)
  if sprite ~= nil then
    self.ui.img_Icon.sprite = sprite
    index = 2
  end
  if isReached then
    index = index + 1
  end
  self.ui.img_Type:SetIndex(index)
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(stressCfg.describe)
end

function UINWarChessMainTop_PressPanelItem:PlayPressureItemTween(time)
  self.ui.canvas_PressureItem:DOComplete()
  self.ui.canvas_PressureItem:DOFade(0, 0.3):From():SetDelay(time * 0.03)
end

function UINWarChessMainTop_PressPanelItem:OnDelete()
  self.ui.canvas_PressureItem:DOKill()
  base.OnDelete(self)
end

return UINWarChessMainTop_PressPanelItem

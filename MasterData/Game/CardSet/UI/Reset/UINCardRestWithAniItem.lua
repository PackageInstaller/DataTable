local base = UIBaseNode
local UINCardRestWithAniItem = class("UINCardRestWithAniItem", base)
local color_orange = Color.New(1.0, 0.4745098039215686, 0.050980392156862744)
local color_gray = Color.New(0.35294117647058826, 0.35294117647058826, 0.35294117647058826)

function UINCardRestWithAniItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  base.OnInit(self)
end

function UINCardRestWithAniItem:RefreshCardResrAniItem(roundIndex, cfg, isLastNotLoop, curRound)
  self.ui.img_flagIcon:SetActive(isLastNotLoop)
  self.ui.tex_Num.gameObject:SetActive(not isLastNotLoop)
  self.ui.tex_Num.text = tostring(FormatNum(roundIndex))
  if cfg.icon_id == 0 then
    self.ui.img_Icon.gameObject:SetActive(false)
  else
    self.ui.img_Icon.gameObject:SetActive(true)
    self.ui.img_Icon:SetIndex(cfg.icon_id - 1)
  end
  if roundIndex < curRound then
    self.ui.img_dot.color = color_orange
  else
    self.ui.img_dot.color = color_gray
  end
  if curRound > roundIndex + 1 then
    self.ui.img_Line.color = color_orange
  else
    self.ui.img_Line.color = color_gray
  end
end

function UINCardRestWithAniItem:GetCardResrAniItemLineImg()
  if IsNull(self._completeLine) then
    self._completeLine = self.ui.img_Line:Instantiate()
    self._completeLine.color = color_orange
  end
  return self._completeLine
end

function UINCardRestWithAniItem:SetCardResrAniItemDotComplete()
  self.ui.img_dot.color = color_orange
end

function UINCardRestWithAniItem:OnDelete()
  base.OnDelete(self)
end

return UINCardRestWithAniItem

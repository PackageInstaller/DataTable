local base = UIBaseNode
local UINLtrPoolBaseConvertItem = class("UINLtrPoolBaseConvertItem", base)

function UINLtrPoolBaseConvertItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINLtrPoolBaseConvertItem:InitLtrPoolBaseConvertItem(ltrData, isCurrent)
  local poolCfg = ltrData.ltrCfg
  self.ui.tex_Des2Title.text = LanguageUtil.GetLocaleText(poolCfg.title2)
  self.ui.tex_Des2Rule.text = LanguageUtil.GetLocaleText(poolCfg.des2)
  if #self.ui.tex_Des2Title.text == 0 then
    self.ui.tex_Des2Title.gameObject:SetActive(false)
  end
  for i = 2, #poolCfg.change_rule do
    self.ui.item_nums[i - 1]:SetIndex(0, tostring(poolCfg.change_rule[i]))
  end
  local convertFrag = ltrData:IsLtrHeroConvertFrag()
  local itemId = poolCfg.change_rule[1]
  local num1 = poolCfg.change_rule[2]
  local num2 = poolCfg.change_rule[3]
  local num3 = poolCfg.change_rule[4]
  local itemCfg = ConfigData.item[itemId]
  if convertFrag then
    self.ui.img_Pic:SetIndex(1)
  else
    self.ui.img_Pic.image.sprite = CRH:GetSpriteByItemConfig(itemCfg)
  end
  self.ui.obj_Current:SetActive(isCurrent)
  self.ui.obj_extra:SetActive(convertFrag)
  if convertFrag then
    self.ui.tex_Extra:SetIndex(0, tostring(poolCfg.big_prize_extra_num))
  end
end

function UINLtrPoolBaseConvertItem:OnDelete()
  base.OnDelete(self)
end

return UINLtrPoolBaseConvertItem

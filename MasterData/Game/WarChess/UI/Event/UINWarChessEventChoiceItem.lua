local base = UIBaseNode
local UINWarChessEventChoiceItem = class("UINWarChessEventChoiceItem", base)

function UINWarChessEventChoiceItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_choiceItem, self, self.__OnChoiceItemClick)
end

function UINWarChessEventChoiceItem:InitWCEventChoiceItem(choiceData, onChoiceClick)
  self.choiceData = choiceData
  self.onChoiceClick = onChoiceClick
  self:RefreshChoiceUI()
end

function UINWarChessEventChoiceItem:RefreshChoiceUI()
  local choiceCfg = self.choiceData.choiceCfg
  local couldChoice = self.choiceData.couldChoice
  self:SetItemCanClick(couldChoice)
  self.ui.tex_Describe.text = LanguageUtil.GetLocaleText(choiceCfg.choice_describe_txt)
  self.ui.img_Icon.sprite = CRH:GetSprite(choiceCfg.icon, CommonAtlasType.ExplorationIcon)
  self.ui.tex_Describe.color = choiceCfg.choice_color ~= 0 and Color.white or Color.black
  self.ui.img_IconBg.color = choiceCfg.choice_color ~= 0 and Color.New(1, 1, 1, 0.3) or Color.New(0, 0, 0, 0.7)
  self.ui.img_Buttom:SetIndex(choiceCfg.choice_color ~= 0 and 1 or 0)
end

function UINWarChessEventChoiceItem:SetItemCanClick(isAble)
  self.isAble = isAble
  local color = isAble and Color.white or self.ui.col_CantSelect
  self.ui.img_Buttom.image.color = color
  self.ui.img_Icon.color = color
  self.ui.ani_Select:SetActive(isAble)
end

function UINWarChessEventChoiceItem:__OnChoiceItemClick()
  if self.isAble and self.onChoiceClick ~= nil then
    self.onChoiceClick(self.choiceData)
  end
end

function UINWarChessEventChoiceItem:OnDelete()
  base.OnDelete(self)
end

return UINWarChessEventChoiceItem

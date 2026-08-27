local UINSupportPageBtn = class("UINSupportPageBtn", UIBaseNode)
local base = UIBaseNode

function UINSupportPageBtn:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Page, self, self.OnClickSupportPageBtn)
end

function UINSupportPageBtn:InitSupportPageBtn(index, clickAction, resloader)
  self.index = index
  self.clickAction = clickAction
  if index ~= 0 then
    local careerCfg = ConfigData.career[index]
    self.ui.tex_Name.text = LanguageUtil.GetLocaleText(careerCfg.name)
    self.ui.img_Icon.sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
  end
  self:SetSelectState(false)
end

function UINSupportPageBtn:OnClickSupportPageBtn()
  if self.clickAction ~= nil then
    self.clickAction(self.index)
  end
end

function UINSupportPageBtn:SetSelectState(flag)
  self.ui.img_Buttom.color = flag and self.ui.color_ImgSelected or self.ui.color_ImgUnSelect
  self.ui.tex_Name.color = flag and self.ui.color_TextSelected or self.ui.color_TextUnSelect
end

function UINSupportPageBtn:OnDelete()
  base.OnDelete(self)
end

return UINSupportPageBtn

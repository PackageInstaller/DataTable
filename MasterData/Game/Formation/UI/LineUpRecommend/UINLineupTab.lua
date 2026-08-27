local UINLineupTab = class("UINLineupTab", UIBaseNode)
local base = UIBaseNode

function UINLineupTab:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_tab, self, self.OnClickLineupTab)
end

function UINLineupTab:InitLineupTab(teamCfg, clickAction, isRecommend)
  self.teamCfg = teamCfg
  self.clickAction = clickAction
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(teamCfg.team_name)
  self.ui.obj_img:SetActive(isRecommend)
  self:SetSelectState(false)
end

function UINLineupTab:OnClickLineupTab()
  if self.clickAction ~= nil then
    self.clickAction(self.teamCfg.team_id)
  end
end

function UINLineupTab:SetSelectState(flag)
  self.ui.obj_isSelect:SetActive(flag)
  self.ui.tex_Name.color = flag and self.ui.color_TextSelected or self.ui.color_TextUnSelect
  self.ui.img_Buttom.color = flag and self.ui.color_ImgSelected or self.ui.color_ImgUnSelect
end

function UINLineupTab:OnDelete()
  self.teamCfg = nil
  self.clickAction = nil
  base.OnDelete(self)
end

return UINLineupTab

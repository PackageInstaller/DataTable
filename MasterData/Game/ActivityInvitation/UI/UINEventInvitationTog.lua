local UINEventInvitationTog = class("UINEventInvitationTog", UIBaseNode)
local base = UIBaseNode

function UINEventInvitationTog:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__RefreshInvitationTogReddotState = BindCallback(self, self._RefreshInvitationTogReddotState)
  UIUtil.AddValueChangedListener(self.ui.tog_Root, self, self._OnTogValueChange)
end

function UINEventInvitationTog:InitInvitationTogItem(index, selectTogFunc, togName)
  self.index = index
  self.selectTogFunc = selectTogFunc
  self.ui.tex_Text.text = togName
  self:SetInvitationTogState(false)
  self:_OnTogValueChange(false)
end

function UINEventInvitationTog:SetInvitationTogRed(reddot)
  if reddot == nil then
    return
  end
  self.reddot = reddot
  self:_RefreshInvitationTogReddotState(reddot)
  RedDotController:AddListener(reddot.nodePath, self.__RefreshInvitationTogReddotState)
end

function UINEventInvitationTog:_RefreshInvitationTogReddotState(reddot)
  self.ui.obj_RedDot:SetActive(reddot ~= nil and reddot:GetRedDotCount() > 0)
end

function UINEventInvitationTog:SetInvitationTogState(isOn)
  self.ui.tog_Root.isOn = isOn
end

function UINEventInvitationTog:_OnTogValueChange(isOn)
  if isOn then
    if self.selectTogFunc ~= nil then
      self.selectTogFunc(self.index)
    end
    self.ui.tex_Text.color = self.ui.color_TextSelect
    self.ui.img_Bg.color = self.ui.color_BgSelect
  else
    self.ui.tex_Text.color = self.ui.color_TextDefault
    self.ui.img_Bg.color = self.ui.color_BgDefault
  end
end

function UINEventInvitationTog:OnDelete()
  if self.reddot ~= nil then
    RedDotController:RemoveListener(self.reddot.nodePath, self.__RefreshInvitationTogReddotState)
  end
  base.OnDelete(self)
end

return UINEventInvitationTog

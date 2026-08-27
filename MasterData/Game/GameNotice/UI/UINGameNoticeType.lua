local UINGameNoticeType = class("UINGameNoticeType", UIBaseNode)
local base = UIBaseNode

function UINGameNoticeType:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_Item, self, self._OnValueChange)
end

function UINGameNoticeType:InitGameNoticType(typeId, callback)
  self._typeId = typeId
  self._onClickCallback = callback
  self:SetBlueDotActive(typeId)
end

function UINGameNoticeType:SetNoticeTypeIsOn(isOn)
  self.ui.tog_Item.group:SetAllTogglesOff()
  self.ui.tog_Item.isOn = isOn
end

function UINGameNoticeType:_OnValueChange(bool)
  local rgb = bool and 0 or 1
  local alpha = bool and 0.8 or 0.5
  local col = Color.New(rgb, rgb, rgb, alpha)
  self.ui.tex_State.color = col
  self.ui.tex_State.color = col
  self.ui.img_Icon.color = col
  self.ui.img_Sel.enabled = bool
  if not bool then
    return
  end
  if self._onClickCallback ~= nil then
    self._onClickCallback(self._typeId)
  end
end

function UINGameNoticeType:SetBlueDotActive()
  if self.redDotFunc == nil then
    self.redDotFunc = BindCallback(self, self.OnRedDotCallback)
  end
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.GameNotice, self._typeId)
  if ok then
    self.redDotFunc(node)
    RedDotController:AddListener(node.nodePath, self.redDotFunc)
    self.nodePath = node.nodePath
  end
end

function UINGameNoticeType:OnRedDotCallback(node)
  self:SetBlueDot(node:GetRedDotCount() > 0)
end

function UINGameNoticeType:SetBlueDot(active)
  self.ui.blueDot:SetActive(active)
end

function UINGameNoticeType:OnDelete()
  if self.nodePath ~= nil then
    RedDotController:RemoveListener(self.nodePath, self.redDotFunc)
  end
  base.OnDelete(self)
end

return UINGameNoticeType

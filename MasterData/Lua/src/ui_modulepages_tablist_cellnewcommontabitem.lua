local _TabTpl = L_GameTpl:getCommonTabTpl()
local module = class("cellNewCommonTabItem", G_UIModuleBase)
local _DefSelectColor = C_Color(0.588, 0.976, 1)
local _DefSelectHighColor = C_Color.white

function module.bind()
  return {
    img_offIcon = "",
    img_onIcon = "",
    tabId = -1,
    active_line = false,
    go_limit = false,
    img_limitIcon = "",
    txt_limit = false
  }
end

function module.methods()
  return {}
end

function module:open()
  if self.bind.id < 0 then
    local tpl = _TabTpl:getTplById(201)
    self.bind.img_offIcon = _TabTpl:getIcon(tpl)
    self.bind.img_onIcon = _TabTpl:getIcon(tpl)
    self.bind.tabId = self.bind.id
    self.bind.active_line = not self.bind.isLast
  else
    local tpl = _TabTpl:getTplById(self.bind.id)
    self.bind.img_offIcon = _TabTpl:getIcon(tpl)
    self.bind.img_onIcon = _TabTpl:getIcon(tpl)
    self.bind.tabId = self.bind.id
    self.bind.active_line = not self.bind.isLast
  end
  if not string.isEmpty(self.bind.redKey) and self.bindComponents.transRed then
    self:registerReddot(self.bindComponents.transRed, self.bind.redKey)
  end
  self:refreshLimit(self.bind.Islimit)
end

function module:refreshLimit(isLimit)
  if isLimit then
    self.bind.go_limit = true
    self.bind.img_limitIcon = "Assets/Arts/UI/Page/Common/icon/tex_common_icon_countdown_02.png"
  end
end

return module

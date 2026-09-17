local module = class("cellCommonTab", G_UIModuleBase)

function module.bind()
  return {
    txt_selectName = "",
    txt_unSelectName = "",
    tabId = -1,
    active_lock = false
  }
end

function module:open()
  self.bind.tabId = self.bind.id
  self.bind.txt_selectName = self.bind.name
  self.bind.txt_unSelectName = self.bind.name
  self:RefreshReddot(self.bind.isShow)
  if self.bind.itemCreateCall then
    self.bind.itemCreateCall(self)
  end
  if self.bind.reddotKey then
    L_ReddotManager:registerReddot(self.bindComponents.reddotNormal, self.bind.reddotKey)
  end
end

function module:getReddotObj()
  if self.bindComponents.reddotNormal then
    return self.bindComponents.reddotNormal
  end
  error("顶部页签：红点绑定丢失")
end

function module:RefreshReddot(isShow)
  local reddotObj = self:getReddotObj()
  if reddotObj then
    reddotObj.gameObject:SetActive(isShow)
  end
end

return module

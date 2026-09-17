local module = class("cellPlayerTitle", G_UIModuleBase)

function module.bind()
  return {
    txt_title = "",
    color_title = C_Color(1, 1, 1, 1),
    active_title_e = false,
    txt_desc = "",
    active_desc = false,
    choice = false,
    isLock = false,
    color_isLock = C_Color()
  }
end

function module.methods()
  return {
    onClick = function(self)
      local id = self.bind.id
      L_ReddotManager:clearNew(L_ReddotManager.DotDef.Title, id)
      self:emit("onLoopListClickSelect", self.bind.realId)
      if not self.bind.goSoldOut then
        self:emit("onClickSelect", self.bind.titleId, self.bind.realId)
      end
    end
  }
end

function module:open()
  local id = self.bind.id
  L_ReddotManager:registerReddot(self.bindComponents.reddotNew, string.format(L_ReddotManager.DotDef.Title, id))
  self.parent:setRead(id)
end

function module:refreshInfo(realId)
  if realId == self.bind.realId then
    local _, unlockTitleColor = C_ColorUtility.TryParseHtmlString("#111A22D9")
    self.bind.color_title = unlockTitleColor
    local _, unlockColor = C_ColorUtility.TryParseHtmlString("#888B8D80")
    self.bind.color_isLock = unlockColor
    if self.bind.isLock then
      self.bind.active_desc = true
    else
      self.bind.active_desc = false
    end
    self.bind.active_title_e = true
  else
    local _, unlockTitleColor = C_ColorUtility.TryParseHtmlString("#FFFFFFE6")
    self.bind.color_title = unlockTitleColor
    local _, unlockColor = C_ColorUtility.TryParseHtmlString("#B0A9A780")
    self.bind.color_isLock = unlockColor
    self.bind.active_desc = false
    self.bind.active_title_e = false
  end
end

function module:refreshCurChoice(id)
  self.bind.choice = id == self.bind.id
end

function module:clearReddot()
  if self.isBind and self.bind.id then
    local id = self.bind.id
    L_ReddotManager:clearNew(L_ReddotManager.DotDef.Title, id)
  end
end

return module

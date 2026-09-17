local this = class("moduleCommonTipBase", G_UIModuleBase)

function this.bind()
  return {
    txt_title = "",
    go_btnConfirm = true,
    txt_btnConfirm = "",
    go_btnCancel = true,
    txt_btnCancel = ""
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      self:clickClose()
    end,
    onClick_cancel = function(self)
      self:clickCancel()
    end,
    onClick_confirm = function(self)
      self:clickConfirm()
    end,
    onClick_bg = function(self)
      self:clickBg()
    end
  }
end

function this:clickClose()
  if not self.onClick_close then
    self:emit("onClick_close")
  else
    self.onClick_close()
  end
end

function this:clickCancel()
  if not self.onClick_cancel then
    self:emit("onClick_cancel")
  else
    self.onClick_cancel()
  end
end

function this:clickConfirm()
  if not self.onClick_confirm then
    self:emit("onClick_confirm")
  else
    self.onClick_confirm()
  end
end

function this:clickBg()
  if not self.onClick_bg then
    self:emit("onClick_bg")
  else
    self.onClick_bg()
  end
end

function this:open()
  if self.parent and self.parent.pageName then
    self._parentPageName = self.parent.pageName
    L_UI:addListener(L_UI.pageEvent.closed, self.preClose, self)
  end
  this.super.open(self)
end

function this:preClose(pageName)
  if pageName ~= self._parentPageName then
    return
  end
  self:close()
end

function this:close()
  if self._parentPageName then
    self._parentPageName = nil
    L_UI:removeListener(L_UI.pageEvent.closed, self.preClose, self)
  end
  this.super.close(self)
end

function this:initModule(params)
  params = params or {}
  self.bind.txt_title = params.txtTitle or L_WordsTpl:getValue("notice_title_hint")
  self.bind.txt_btnCancel = params.txtCancel or L_WordsTpl:getValue("common_window_2")
  self.bind.txt_btnConfirm = params.txtConfirm or L_WordsTpl:getValue("common_window_1")
  self.bind.go_btnConfirm = not params.hideConfirm
  self.bind.go_btnCancel = not params.hideCancel
end

function this:setGeneralCallBack(param)
  self.onClick_bg = param.onClick_bg
  self.onClick_confirm = param.onClick_confirm
  self.onClick_close = param.onClick_close
  self.onClick_cancel = param.onClick_cancel
end

return this

local this = class("pageAddItemTip", G_UIPageBase)

function this.bind()
  return {
    txtOK = "",
    txtCancel = "",
    title = "",
    listItems = {
      moduleName = "ModulePages/cellIconBag"
    },
    btnCancel = true,
    btnOK = true,
    btnClose = true,
    module_commonTipBoard = L_Const.ModuleInfo.CommonTipBoard
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
      if self.onClose then
        self.onClose()
      end
    end,
    onClick_close2 = function(self)
    end,
    onClick_cancel = function(self)
      L_UI:close(self.pageName)
      if self.onCancel then
        self.onCancel()
      end
    end,
    onClick_ok = function(self)
      L_UI:close(self.pageName)
      if self.onOK then
        self.onOK()
      end
    end
  }
end

function this:created(...)
  this.super.created(self, ...)
  self.txtContent = self.bindComponents.txtContent
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self:updateOptions(options)
  self:setButtonShow()
end

function this:updateOptions(options)
  options = options or {}
  self.onOK = options.ok
  self.onCancel = options.cancel
  self.onClose = options.close
  self.onExit = options.exit
  self.showType = L_Const.commonTipsShowType.OkCancel
  self.bind.txtOK = options.txtOK or L_WordsTpl:getValue("common_window_1")
  self.bind.txtCancel = options.txtCancel or L_WordsTpl:getValue("common_window_2")
  self.txtContent.gameObject:ActiveTrans(options.content1 ~= nil)
  self.bind.title = options.title or L_WordsTpl:getValue("notice_title_hint")
  if options.items then
    self.bind.listItems:clear()
    self.bind.listItems:insert_array(options.items)
  end
  if options.content1 then
    self.txtContent.richText = options.content1 .. "\n"
  end
  if options.showType then
    self.showType = options.showType
  end
end

function this:setButtonShow()
  if self.showType == L_Const.commonTipsShowType.OkCancel then
    self.bind.btnCancel = true
    self.bind.btnOK = true
    self.bind.btnClose = true
  elseif self.showType == L_Const.commonTipsShowType.OnlyOk then
    self.bind.btnCancel = false
    self.bind.btnOK = true
    self.bind.btnClose = true
  elseif self.showType == L_Const.commonTipsShowType.OnlyCancel then
    self.bind.btnCancel = true
    self.bind.btnOK = false
    self.bind.btnClose = true
  elseif self.showType == L_Const.commonTipsShowType.OnlyClose then
    self.bind.btnCancel = false
    self.bind.btnOK = false
    self.bind.btnClose = true
  end
end

function this:close()
  this.super.close(self)
  if self.onExit then
    self.onExit()
  end
end

function this:escHandle()
  L_UI:close(self.pageName)
  if self.onClose then
    self.onClose()
  end
end

return this

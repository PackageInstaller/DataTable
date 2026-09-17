local module = class("moduleCommonTop", G_UIModuleBase)

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {
    closeCurPage = nil,
    helpBtn = nil,
    mainBtn = nil
  }
end

function module.bind()
  return {
    txtName = "",
    txtNameEn = "",
    helpBtn = false,
    mainBtn = true
  }
end

function module.methods()
  return {
    onClick_closeCurPageBtn = function(self)
      if self.data.closeCurPage then
        self.data.closeCurPage()
      end
    end,
    onClick_helpBtn = function(self)
      if self.data.helpBtn then
        self.data.helpBtn()
      end
    end,
    onClick_mainBtn = function(self)
      if self.data.mainBtn then
        self.data.mainBtn()
      end
    end
  }
end

function module:initModule(data)
  self.bind.txtName = data.name
  self.bind.txtNameEn = data.nameEn or "RET                             URN"
  self.bind.helpBtn = data.helpBtnBool or false
  self.bind.mainBtn = false
  self.data.closeCurPage = data.closeCurPage
  self.data.helpBtn = data.helpBtn
  self.data.mainBtn = data.mainBtn
end

function module:setPageName(txtName)
  self.bind.txtName = txtName
end

function module:close()
  self.data.closeCurPage = nil
  self.data.helpBtn = nil
  self.data.mainBtn = nil
end

return module

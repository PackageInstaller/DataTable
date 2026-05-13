local uiData = {
  csbFile = "ui/global/DeleteAccountSecondLayer.csb",
  mask = true,
  popup = true,
  opacity = 115,
  widgets = {
    center = "center",
    title = "title",
    okBtn = "confirm",
    cancelBtn = "cancel",
    text = "text",
    btn_roleidclick = "btn_roleidclick"
  }
}
local DeleteAccountSecondLayer = class("DeleteAccountSecondLayer", UIBase)

function DeleteAccountSecondLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function DeleteAccountSecondLayer:init(params)
  self.okCallback = params.okCallback
  self.cancelCallback = params.cancelCallback
  self.accountStr = ""
  local text = display.newTTFLabel({
    text = "请输入账号数字id",
    size = 24,
    color = UIHelper.hex2rgb("#b9957a")
  }):center(self.btn_roleidclick):addTo(self.btn_roleidclick)
  self.btn_roleidclick:setCallback(function()
    local layer = game:createView("common.InputLayer", {
      longth = 20,
      content = self.accountStr,
      callback = function(str)
        text:setString(str)
        self.accountStr = str
        BackManager:pop()
      end
    })
    BackManager:push(function()
      layer:close()
    end)
  end)
  self.okBtn:setCallback(function()
    if game.role.id == tonumber(self.accountStr) then
      if self.okCallback then
        self.okCallback()
      else
        print("no okCallback Error")
      end
      self:close()
    else
      SysError(SYS_ERR_INCORRECT_ID)
    end
  end)
  self.cancelBtn:setCallback(function()
    if self.cancelCallback then
      self.cancelCallback()
    else
      print("no cancelCallback Error")
    end
    self:close()
  end)
end

return DeleteAccountSecondLayer

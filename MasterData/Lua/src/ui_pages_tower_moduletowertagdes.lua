local module = class("moduleTowerTagDes", G_UIModuleBase)

function module.bind()
  return {titleText = "", desText = ""}
end

function module.methods()
  return {
    onClick_closeMask = function(self)
      if self.closeCallback then
        self.closeCallback()
      end
    end
  }
end

function module:initView(data)
  self.closeCallback = data.callback
  self.bind.titleText = data.title
  self.bind.desText = data.des
end

return module

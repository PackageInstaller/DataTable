local this = class("modulePhotoGroup_lightParam", require("ui.pages.photo.group.modulePhotoGroup_base"))

function this.bind()
  return {
    paramList = {
      moduleName = "pages/photo/cell/cellPhotoParamSlider"
    }
  }
end

function this.methods()
  return {
    onClick_reset = function(self)
      self:onClick_reset()
    end,
    onClickHideGroup = function(self)
      L_PhotoManager:sendEvent(L_PhotoManager.event.isActiveBg)
      self:hideGroup()
    end
  }
end

function this:open()
  self:initConfig()
end

function this:show()
  self:initList()
  for i, v in pairs(self.modules.paramList) do
    v:show()
  end
end

function this:refresh()
end

function this:hide()
end

function this:close()
end

function this:initConfig()
  local list = self.paramTpl:getListByGroupId(L_Const.photoGroup.lightParam)
  local content = {}
  for index, tpl in ipairs(list) do
    local data = {}
    data.id = self.paramTpl:getId(tpl)
    data.show = self.paramTpl:getShow(tpl)
    data.min = self.paramTpl:getParamMin(tpl)
    data.max = self.paramTpl:getParamMax(tpl)
    data.name = self.paramTpl:getName(tpl)
    data.sort = self.paramTpl:getSequence(tpl)
    content[data.id] = data
  end
  self.paramConfig = content
end

function this:initList()
  local list = {}
  for k, v in pairs(self.paramConfig) do
    if v.show then
      table.insert(list, {data = v})
    end
  end
  table.sort(list, function(a, b)
    return a.data.sort < b.data.sort
  end)
  self.bind.paramList:clear()
  self.bind.paramList:insert_array(list)
end

function this:onClick_reset()
  local mediator = L_PhotoManager.mediator
  local paramController = mediator:getLightParam()
  paramController:reset()
  for i, v in pairs(self.modules.paramList) do
    v:refresh()
  end
end

return this

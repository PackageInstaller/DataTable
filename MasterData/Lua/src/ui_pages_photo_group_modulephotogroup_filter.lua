local this = class("modulePhotoGroup_filter", require("ui.pages.photo.group.modulePhotoGroup_base"))
local KEYMAP = L_PhotoManager.FILTERTOID

function this.bind()
  return {
    goSlider = false,
    selectedId = 0,
    list = {
      moduleName = "pages/photo/cell/cellPhotoFilter"
    },
    txtInfo = "",
    activeInfo = false
  }
end

function this.methods()
  return {
    onValueChanged_selection = function(self, id)
      self:refreshSelection(id)
    end,
    onClick_reset = function(self)
    end,
    onValueChanged_slider = function(self, val)
    end,
    onClickHideGroup = function(self)
      L_PhotoManager:sendEvent(L_PhotoManager.event.isActiveBg)
      self:hideGroup()
    end
  }
end

function this:open()
  self.paramDic = {}
  L_PhotoManager:addListener(L_PhotoManager.event.photoTemplateChange, self.onEvent_photoTemplateChange, self)
end

function this:show()
  self:initGroupList(L_Const.photoGroup.filter)
  if self.settingId == nil then
    self.bind.selectedId = 401
  else
    for i, v in pairs(self.modules.list) do
      v:refreshSelect(v.bind.id == self.settingId)
    end
  end
end

function this:close()
  L_PhotoManager:removeListener(L_PhotoManager.event.photoTemplateChange, self.onEvent_photoTemplateChange, self)
end

function this:onEvent_photoTemplateChange()
  local args = self:getUseArgs(L_Const.photoTemplateSettingParam.filter)
  local val = args and args.val or L_Const.photoParam.filter0
  self.bind.selectedId = math.ceil(val)
end

function this:refreshSelection(id)
  local tpl = self.paramTpl:getTplById(id)
  self.settingId = id
  local filter = L_PhotoManager:getMediator().photoFilter
  filter.filterId = KEYMAP[id]
  local val = self:getDefaultVal(id)
  if val then
    filter.filterIntensity = val
  end
  for i, v in pairs(self.modules.list) do
    v:refreshSelect(v.bind.id == id)
  end
end

function this:setVal(id, val)
  local filter = L_PhotoManager:getMediator().photoFilter
  filter.filterIntensity = val
  self.paramDic[id] = val
end

function this:getDefaultVal(id)
  local val = self.paramDic[id] or this.super.getDefaultVal(self, id)
  return val
end

function this:showInfo(isOn)
  self.bind.activeInfo = isOn
end

function this:setInfo(txt)
  self.bind.txtInfo = txt
end

return this

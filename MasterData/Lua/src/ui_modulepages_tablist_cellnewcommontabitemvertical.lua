local _TabTpl = L_GameTpl:getCommonTabTpl()
local module = class("cellNewCommonTabItemVertical", G_UIModuleBase)
local _taskTypeTpl = L_GameTpl:getTaskTypeTpl()
local _taskTpl = L_GameTpl:getTaskTpl()
local _wordsTpl = L_GameTpl:getWordsTpl()

function module.bind()
  return {
    img_offIcon = "",
    txt_offName = "",
    txt_offName_e = "",
    img_onIcon = "",
    txt_onName = "",
    txt_onName_e = "",
    tabId = -1,
    go_limit = false,
    img_limitIcon = "",
    go_limitTxt = false,
    go_fitRootOn = true,
    go_fitRootOff = true
  }
end

function module.methods()
  return {}
end

function module:open()
  local tpl = _TabTpl:getTplById(self.bind.id)
  local icon = _TabTpl:getIcon(tpl)
  local name = self:getName(tpl)
  self.bind.img_offIcon = icon
  self.bind.txt_offName = name
  self.bind.img_onIcon = icon
  self.bind.txt_onName = name
  self.bind.tabId = self.bind.id
  self.bind.showLine = self.bind.show
  self.bind.go_fitRootOn = name ~= ""
  self.bind.go_fitRootOff = name ~= ""
  if not string.isEmpty(self.bind.redKey) and self.bindComponents.transRed and not self.bind.active_taskNode then
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

function module:refreshTraceTaskNode(traceTaskId)
  local taskTpl = _taskTpl:getTplById(traceTaskId)
  if taskTpl ~= nil then
    self.bind.active_taskNode = true
    local tabType = _taskTpl:getTabType(taskTpl)
    local taskTypeTpl = _taskTypeTpl:getTplById(tabType)
    self.bind.img_taskType = _taskTypeTpl:getMapIcon(taskTypeTpl)
  else
    self.bind.active_taskNode = false
  end
end

function module:hideTraceTaskNode()
  self.bind.active_taskNode = false
end

function module:getTabId()
  return self.bind.tabId
end

function module:getName(tpl)
  if self.bind.CustomData and self.bind.CustomData.HasEquip ~= nil then
    if self.bind.CustomData.HasEquip == true then
      return ""
    else
      return _wordsTpl:getTplById("ui_accessory_not_equiped_text")
    end
  end
  return _TabTpl:getName(tpl)
end

return module

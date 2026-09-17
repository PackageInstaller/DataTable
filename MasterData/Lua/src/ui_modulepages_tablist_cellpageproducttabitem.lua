local module = class("cellPageProductTabItem", G_UIModuleBase)
local _taskTypeTpl = L_GameTpl:getTaskTypeTpl()
local _taskTpl = L_GameTpl:getTaskTpl()
local _TabTpl = L_GameTpl:getCommonTabTpl()

function module.bind()
  return {
    txt_name = "",
    txt_nameEn = "",
    img_icon = "",
    color_icon = nil,
    tabId = -1,
    active_line = false,
    active_taskNode = false,
    img_taskType = nil,
    active_unSelectBg = true
  }
end

function module.methods()
  return {}
end

function module:open()
  self.id = self.bind.id
  local tpl = _TabTpl:getTplById(self.id)
  self.name = _TabTpl:getName(tpl)
  self.nameEn = "ATTRIBUTE"
  self.bind.active_line = not self.bind.isLast
  self.bind.tabId = self.id
  self.bind.txt_name = self.name
  self.bind.txt_nameEn = self.nameEn
  self.bind.img_icon = _TabTpl:getIcon(tpl)
  if not string.isEmpty(self.bind.redKey) and self.bindComponents.transRed and not self.bind.active_taskNode then
    L_ReddotManager:registerReddot(self.bindComponents.transRed, self.bind.redKey)
  end
end

function module:refreshTraceTaskNode(traceTaskId)
  local taskTpl = _taskTpl:getTplById(traceTaskId)
  if taskTpl ~= nil then
    self.bind.active_taskNode = true
    local tabType = _taskTpl:getTabType(taskTpl)
    local taskTypeTpl = _taskTypeTpl:getTplById(tabType)
    self.bind.img_taskType = _taskTypeTpl:getMapIcon(taskTypeTpl)
    if not L_CommonUtil.isValid(self.bindComponents.transRed) then
      return
    end
    local go = self.bindComponents.transRed.gameObject
    go:SetActive(false)
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

function module:onSelect(isSelect, tabParam)
  self.isSelect = isSelect
  local iconColorKey_normal = tabParam.iconColorKey_normal
  local nameColorKey_normal = tabParam.nameColorKey_normal
  local iconColorKey_select = tabParam.iconColorKey_select
  local nameColorKey_select = tabParam.nameColorKey_select
  local txtColor = isSelect and nameColorKey_select or nameColorKey_normal
  local _, iconColor = C_ColorUtility.TryParseHtmlString(isSelect and iconColorKey_select or iconColorKey_normal)
  self.bind.txt_name = L_GameUtil.fillColor(self.name, txtColor)
  self.bind.txt_nameEn = L_GameUtil.fillColor(self.nameEn, txtColor)
  self.bind.color_icon = iconColor
  self.bind.active_unSelectBg = not isSelect
end

return module

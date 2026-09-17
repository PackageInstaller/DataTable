local this = class("uiPriorityShowData", require("ui.manager.priorityShowQueue.priorityShowData"))
local _uiViewTpl = L_GameTpl:getUiViewTpl()

function this:ctor(data)
  this.super.ctor(self, data)
  local params = data.params
  local pageName = params[1]
  local options = params[2]
  local callback = params[3]
  local tpl = _uiViewTpl:getTplByName(pageName)
  if tpl then
    self._priorityDataType = _uiViewTpl:getPanelType(tpl)
    self._priority = _uiViewTpl:getQueue(tpl)
    self._uiCheckShowFunc = _uiViewTpl:getCheckshowfun(tpl)
    self._blockType = _uiViewTpl:getBlockIgnore(tpl)
  else
    printf("priorityShowQueueManager", "pageName not in uiPriorityMap ", pageName)
  end
  self.pageName = pageName
  self.options = options
  self.callback = callback
end

function this:defaultCheckShowFunc()
  if not self._uiCheckShowFunc then
    return true
  end
  return self._uiCheckShowFunc()
end

function this:getDesc()
  local pageName = self.pageName or "nil"
  local desc = "pageName " .. pageName .. this.super.getDesc(self)
  return desc
end

function this:doShow()
  C_UIMgr.SetPriorityPageData(self.pageName, false)
  L_UI:open(self.pageName, self.options, self.callback, true)
  this.super.doShow(self)
end

function this:doHide()
  this.super.doHide(self)
end

function this:checkStopGuide()
  local tpl = _uiViewTpl:getTplByName(self.pageName)
  return _uiViewTpl:checkStopGuide(tpl)
end

function this:checkIsCurDataInter(pageName)
  return pageName == self.pageName
end

return this

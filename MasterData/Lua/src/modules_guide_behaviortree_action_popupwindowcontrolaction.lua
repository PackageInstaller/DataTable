local this = L_BevTree:registClass("guide.popupWindowControlAction", L_BevTree.action)

function this:param()
  self.whiteList = ""
  self.resumePopupWindow = 0
end

function this:parse()
  self.whiteList = self:getParam("whiteList")
  self.resumePopupWindow = self:getParam("resumePopupWindow", true) or 0
end

function this:execute()
  if self.resumePopupWindow == 0 then
    if string.isEmpty(self.whiteList) then
      C_UIMgr.PausePriorityQueue()
    else
      local enabledPages = string.split(self.whiteList, "|")
      C_UIMgr.SetPriorityQueueWhiteList(enabledPages)
    end
  else
    C_UIMgr.ResumePriorityQueue()
  end
  return L_BevTree.taskResult.Success
end

return this

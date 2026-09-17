local this = class("activityTaskStore", G_BaseStore)
this.event = {
  refreshActivityTask = "refreshActivityTask",
  refreshActivityReward = "refreshActivityReward",
  refreshActivityReddot = "refreshActivityReddot"
}
this:importPartialClass(require(L_R.store .. "activityTask.activityTaskState"))
this:importPartialClass(require(L_R.store .. "activityTask.activityTaskAction"))

function this:removeFirstPopup()
  if table.isEmpty(self.data.popupList) then
    return
  end
  table.remove(self.data.popupList, 1)
end

return this

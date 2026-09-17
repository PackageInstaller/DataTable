local this = class("taskStore", G_BaseStore)
this.event = {
  taskRealFinished = "taskRealFinished"
}
this:importPartialClass(require(L_R.store .. "task.taskAction"))
this:importPartialClass(require(L_R.store .. "task.taskState"))
return this

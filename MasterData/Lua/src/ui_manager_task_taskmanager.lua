local this = class("taskManager", G_EventManagerBase)
table.merge(this, require("ui.manager.task.taskManager_control"))
return this

local module = class("cellNoviceTabItem", G_UIModuleBase)

function module.bind()
  return {
    txt_selectName = "",
    txt_unSelectName = "",
    tabId = -1,
    go_lock = false
  }
end

function module:open()
  self.bind.tabId = self.bind.id
  if self.bind.id == 1 then
    self.bind.txt_selectName = L_WordsTpl:getValue("ui_newbie_task_name_02")
    self.bind.txt_unSelectName = L_WordsTpl:getValue("ui_newbie_task_name_02")
    self.bind.go_lock = false
    L_ReddotManager:registerReddot(self.bindComponents.reddotNormal, L_ReddotManager.DotDef.GuideTaskManual)
  else
    self.bind.txt_selectName = L_WordsTpl:getValue("ui_newbie_task_name")
    self.bind.txt_unSelectName = L_WordsTpl:getValue("ui_newbie_task_name")
    self.bind.go_lock = not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.noviceDuelTask)
    L_ReddotManager:registerReddot(self.bindComponents.reddotNormal, L_ReddotManager.DotDef.DuelTaskManual)
  end
end

return module

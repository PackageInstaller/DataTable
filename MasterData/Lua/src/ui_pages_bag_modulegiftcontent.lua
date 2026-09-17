local this = class("moduleGiftContent", G_UIModuleBase)

function this.bind()
  return {
    list_gift = L_Const.ModuleInfo.CellIconBag,
    active_title = false,
    txt_title = ""
  }
end

function this.methods()
  return {}
end

function this:open()
end

function this:close()
end

function this:setUseGiftData(list)
  self.bind.active_title = false
  self.bind.list_gift:clear()
  self.bind.list_gift:insert_array(list)
end

function this:setGiftPreviewData(list, title)
  self.bind.active_title = true
  self.bind.txt_title = title
  self.bind.list_gift:clear()
  self.bind.list_gift:insert_array(list)
end

function this:getCellList()
  return self.modules.list_gift
end

return this

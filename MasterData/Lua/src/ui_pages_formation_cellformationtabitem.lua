local module = class("cellFormationTabItem", G_UIModuleBase)

function module.bind()
  return {
    txt_selectName = "",
    txt_unSelectName = "",
    tabId = -1
  }
end

function module:open()
  self.bind.tabId = self.bind.id
  if self.bind.tabId == 1 then
    self.bind.txt_selectName = L_WordsTpl:getValue("residual_code_cellformationtabitem_01")
    self.bind.txt_unSelectName = L_WordsTpl:getValue("residual_code_cellformationtabitem_01")
  else
    self.bind.txt_selectName = L_WordsTpl:getValue("residual_code_cellformationtabitem_03")
    self.bind.txt_unSelectName = L_WordsTpl:getValue("residual_code_cellformationtabitem_03")
  end
end

return module

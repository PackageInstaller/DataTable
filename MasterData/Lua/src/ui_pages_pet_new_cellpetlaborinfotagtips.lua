local this = class("cellPetLaborInfoTagTips", G_UIModuleBase)

function this.bind()
  return {
    txt_title = "",
    list_content = {
      moduleName = "pages/pet/new/cellPetLaborInfoItem"
    }
  }
end

function this:open()
  self.bind.txt_title = tostring(L_WordsTpl:getValue("ui_text_kibo_labor_title_1"))
  local data = {}
  for i = 1, 4 do
    table.insert(data, {
      txt_content = L_WordsTpl:getValue(string.format("ui_text_kibo_labor_desc_%s", i))
    })
  end
  self.bind.list_content:clear()
  self.bind.list_content:insert_array(data)
end

function this:Init(param)
end

return this

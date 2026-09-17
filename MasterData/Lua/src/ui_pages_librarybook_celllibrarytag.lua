local this = class("cellLibraryTag", G_UIModuleBase)
local _libraryCategoryTpl = L_GameTpl:getLibraryCategoryTpl()

function this.bind()
  return {txt_tag = ""}
end

function this:open()
  self:refreshTag()
end

function this:refreshView()
  self:refreshTag()
end

function this:refreshTag()
  local tpl = _libraryCategoryTpl:getTplById(self.bind.tagId)
  if tpl == nil then
    return
  end
  self.bind.txt_tag = _libraryCategoryTpl:getName(tpl)
end

return this

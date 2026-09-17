local this = class("cellKiBoDuelTag", G_UIModuleBase)
local kiboDuelTagTpl = L_GameTpl:getKiboDuelTagTpl()

function this.bind()
  return {tagNameText = "", tagIcon = ""}
end

function this.methods()
  return {}
end

function this:refresh()
  if not self.isBind then
    return
  end
  local tagTpl = kiboDuelTagTpl:getTplById(self.bind.tagId)
  if tagTpl == nil then
    return
  end
  self.bind.tagNameText = kiboDuelTagTpl:getTagName(tagTpl)
  self.bind.tagIcon = kiboDuelTagTpl:getTagIcon(tagTpl)
end

return this

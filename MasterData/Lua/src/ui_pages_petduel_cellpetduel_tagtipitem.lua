local module = class("cellPetDuel_tagTipItem", G_UIModuleBase)
local kiboDuelTagTpl = L_GameTpl:getKiboDuelTagTpl()

function module.bind()
  return {
    txt_tagName = "",
    tagIcon = "",
    txt_tagDesc = ""
  }
end

function module.methods()
  return {}
end

function module:refresh()
  if not self.isBind then
    return
  end
  local tagTpl = kiboDuelTagTpl:getTplById(self.bind.tagId)
  if tagTpl == nil then
    return
  end
  self.bind.txt_tagName = kiboDuelTagTpl:getTagName(tagTpl)
  self.bind.tagIcon = kiboDuelTagTpl:getTagIcon(tagTpl)
  self.bind.txt_tagDesc = kiboDuelTagTpl:getTagDesc(tagTpl)
end

return module

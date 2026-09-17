local module = class("cellPetDuel_tagTip", G_UIModuleBase)
local petTpl = L_GameTpl:getPetTpl()
local isOpen = false

function module.bind()
  return {
    tagList = {
      moduleName = "pages/petDuel/cellPetDuel_tagTipItem"
    },
    go_parent = false
  }
end

function module:onShowTip(petId)
  if isOpen then
    self.bind.go_parent = false
    isOpen = false
    return
  end
  isOpen = not isOpen
  self.bind.go_parent = true
  local tpl = petTpl:getTplById(petId)
  local tags = petTpl:getKiboDuelTag(tpl)
  local data = {}
  for _, id in ipairs(tags) do
    table.insert(data, {tagId = id})
  end
  self.bind.tagList:clear()
  self.bind.tagList:insert_array(data)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.rect)
end

function module:methods()
  return {
    onClick = function(self)
      self.bind.go_parent = false
    end
  }
end

return module

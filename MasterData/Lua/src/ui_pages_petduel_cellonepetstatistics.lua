local this = class("cellOnePetStatistics", G_UIModuleBase)
local petTpl = L_GameTpl:getPetTpl()
local elementTpl = L_GameTpl:getElementTypeTpl()

function this.bind()
  return {
    img_petIcon = "",
    txt_petName = "",
    img_element = "",
    tagList = {
      moduleName = "pages/petDuel/cellKiBoDuelTag"
    },
    modulePetStatistics = {
      moduleName = "pages/petDuel/modulePetStatistics"
    },
    levelText = ""
  }
end

function this.methods()
  return {}
end

function this:open()
end

function this:close()
end

function this:refreshData(data, isEnemy)
  if not self.isBind or data == nil or math.isEmpty(data.petConfigId) then
    return
  end
  local tpl = petTpl:getTplById(data.petConfigId)
  self.bind.txt_petName = isEnemy and petTpl:getName(tpl) or C_KiboDuelSystemMgr:GetPetNameByGuid(data.guid)
  local elementId = petTpl:getFirstElement(tpl)
  local eTpl = elementTpl:getTplById(elementId)
  local petItem = L_PetStore:getPetItem(data.guid)
  if petItem ~= nil then
    local petIconNew = petTpl:getKiboCardIconNew(tpl, petItem:isSpecialPet())
    if petIconNew and #petIconNew ~= 0 then
      self.bind.img_petIcon = petIconNew
    else
      self.bind.img_petIcon = petTpl:getKiboCardIcon(tpl, petItem:isSpecialPet())
    end
  else
    local petIconNew = petTpl:getKiboCardIconNew(tpl)
    if petIconNew and #petIconNew ~= 0 then
      self.bind.img_petIcon = petIconNew
    else
      self.bind.img_petIcon = petTpl:getKiboCardIcon(tpl, 0)
    end
  end
  self.bind.img_element = elementTpl:getPetElem(eTpl)
  self.modules.modulePetStatistics:refreshData(data)
  self.bind.levelText = "Lv." .. tostring(data.level)
  self:refreshTagList(data.petConfigId)
end

function this:refreshTagList(petId)
  if not self.isBind then
    return
  end
  local tpl = petTpl:getTplById(petId)
  local tags = petTpl:getKiboDuelTag(tpl)
  local data = {}
  for _, id in ipairs(tags) do
    table.insert(data, {tagId = id})
  end
  self.bind.tagList:clear()
  self.bind.tagList:insert_array(data)
end

return this

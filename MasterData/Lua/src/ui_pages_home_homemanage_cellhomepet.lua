local this = class("cellHomePet", G_UIModuleBase)
local _homeLaborCapacityTpl = L_GameTpl:getHomeLaborCapacityTpl()
local WorkShowState = {
  NONE = 0,
  CURR = 1,
  WORK = 2,
  REST = 3
}

function this.bind()
  return {
    img_icon = "",
    txt_name = "",
    active_select = false,
    tab_status = -1,
    img_free = "",
    img_working = "",
    img_curWork = ""
  }
end

function this.methods()
  return {
    onClick = function(self)
      if self.bind.callback then
        self.bind.callback()
      end
    end
  }
end

function this:setSelect(state)
  self.bind.active_select = state
end

function this:refresh()
  local guid = self.bind.guid
  local pet = L_PetStore:getPetItem(guid)
  local configData = L_ItemTplManager:getPetItem(pet.id, pet:isSpecialPet())
  self.bind.img_icon = configData.icon
  self.bind.txt_name = configData.name
  if not math.isEmpty(pet.work_build) then
    local tpl_capacity = _homeLaborCapacityTpl:getTplById(pet.capacity_id)
    local icon = _homeLaborCapacityTpl:getIconLight(tpl_capacity)
    self.bind.img_free = icon
    self.bind.img_working = icon
    self.bind.img_curWork = icon
  end
  local workStatus = WorkShowState.NONE
  if not pet:isWorking() then
    workStatus = WorkShowState.REST
  else
    workStatus = WorkShowState.WORK
  end
  self.bind.tab_status = workStatus
end

return this

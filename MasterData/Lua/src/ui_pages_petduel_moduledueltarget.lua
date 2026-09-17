local this = class("moduleDuelTarget", G_UIModuleBase)
local kiBoDuelTpl = L_GameTpl:getKiboDuelTpl()
local kiBoDuelTaskTpl = L_GameTpl:getKiboDuelTaskTpl()

function this.bind()
  return {}
end

function this.methods()
  return {}
end

function this:toBind(uiBinding)
  self.super.toBind(self, uiBinding)
  local addModuleGeneric = xlua.get_generic_method(self.parent.csharpPage:GetType(), "AddModule", 1)
  local addModule = addModuleGeneric(CS.Lens.Gameplay.UI.PetDuel.ModuleDuelTarget, CS.UnityEngine.GameObject)
  self.transferModule = addModule(self.parent.csharpPage, self.parent.csharpPage, self.gameObject)
end

function this:restartKiBoDuel(e, varList)
  self:resetData()
  self:initTargetData()
end

function this:initTargetData()
  self.duelId = L_PetDuelStore:getCurChallengeLevelId()
  self.targetData = {}
  local tpl = kiBoDuelTpl:getTplById(self.duelId)
  local tasks = kiBoDuelTpl:getTask(tpl)
  for _, id in ipairs(tasks) do
    table.insert(self.targetData, {id = id, value = 0})
  end
  self.bind.contentActive = #self.targetData > 0
  if not self.bind.contentActive then
    return
  end
  self:refreshTargetList()
end

function this:refreshTargetList()
  if #self.targetData > 0 then
    local data
    for _, v in ipairs(self.targetData) do
      local tpl = kiBoDuelTaskTpl:getTplById(v.id)
      if v.value < kiBoDuelTaskTpl:getCompletionTimes(tpl) then
        data = v
        break
      end
    end
    data = data or self.targetData[#self.targetData]
    if 0 < #self.bind.targetList then
      self.bind.targetList:change(1, data)
    else
      self.bind.targetList:insert_array({data})
    end
  end
end

function this:refreshData(e, varList)
  local id = varList:GetInt(0)
  local isFound = false
  for _, v in ipairs(self.targetData) do
    if v.id == id then
      v.value = v.value + 1
      isFound = true
    end
  end
  self:refreshTargetList()
end

function this:resetData()
  self.bind.targetList:clear()
  self.targetData = {}
end

return this

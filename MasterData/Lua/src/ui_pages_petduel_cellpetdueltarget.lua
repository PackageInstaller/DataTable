local this = class("cellPetDuelTarget", G_UIModuleBase)
local kiBoDuelTaskTpl = L_GameTpl:getKiboDuelTaskTpl()

function this.bind()
  return {txt_content = "", conditionToggle = false}
end

function this.methods()
  return {}
end

function this:open(options)
end

function this:close()
  self:disposeTimer()
end

function this:refresh()
  if not self.isBind then
    return
  end
  if self.lastId == nil then
    self.lastId = self.bind.id
    self.bind.conditionToggle = false
  end
  if self.lastId ~= self.bind.id then
    self:disposeTimer()
    self.bind.conditionToggle = true
    local tpl = kiBoDuelTaskTpl:getTplById(self.lastId)
    local txt = kiBoDuelTaskTpl:getTask(tpl)
    local max = kiBoDuelTaskTpl:getCompletionTimes(tpl)
    txt = string.format("%s (%d/%d)", txt, max, max)
    self.bind.txt_content = txt
    self.showTimer = Timer.once(1, function()
      self.bind.conditionToggle = false
      self:refreshView()
    end)
  else
    self:refreshView()
  end
  self.lastId = self.bind.id
end

function this:disposeTimer()
  if self.showTimer ~= nil then
    Timer.remove(self.showTimer)
    self.showTimer = nil
  end
end

function this:refreshView()
  if not self.isBind then
    return
  end
  local tpl = kiBoDuelTaskTpl:getTplById(self.bind.id)
  local txt = kiBoDuelTaskTpl:getTask(tpl)
  local max = kiBoDuelTaskTpl:getCompletionTimes(tpl)
  txt = string.format("%s (%d/%d)", txt, self.bind.value, max)
  self.bind.txt_content = txt
  self.bind.conditionToggle = max <= self.bind.value
end

function this:playCellAnimation(aniName)
  if not self.isBind or not self.bindComponents.cellAnimation then
    return
  end
  self.bindComponents.cellAnimation:Play(aniName)
end

return this

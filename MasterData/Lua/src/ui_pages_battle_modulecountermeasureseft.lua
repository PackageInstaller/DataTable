local this = class("moduleCountermeasuresEft", G_UIModuleBase)
local ESkillTagType = {
  CountermeasuresDefenseSkill = 18,
  CountermeasuresPerfectDefenseSkill = 19,
  CountermeasuresDodge = 20
}

function this.bind()
  return {
    go_justBlock = false,
    go_perfectParry = false,
    go_focusDodge = false
  }
end

function this.methods()
  return {}
end

function this:open()
  L_BattleDataManager:addListener(L_BattleDataManager.event.triggerCountermeasures, self.onEvent_triggerCountermeasures, self)
end

function this:show(options)
  self.bind.go_justBlock = false
  self.bind.go_perfectParry = false
  self.bind.go_focusDodge = false
end

function this:onEvent_triggerCountermeasures(args)
  if args.skillTag == ESkillTagType.CountermeasuresDefenseSkill then
    self.bind.go_justBlock = false
    self.bind.go_justBlock = true
    return
  end
  if args.skillTag == ESkillTagType.CountermeasuresPerfectDefenseSkill then
    self.bind.go_perfectParry = false
    self.bind.go_perfectParry = true
    return
  end
  if args.skillTag == ESkillTagType.CountermeasuresDodge then
    self.bind.go_focusDodge = false
    self.bind.go_focusDodge = true
    return
  end
end

function this:hide(options)
end

function this:close()
  L_BattleDataManager:removeListener(L_BattleDataManager.event.triggerCountermeasures, self.onEvent_triggerCountermeasures, self)
end

return this

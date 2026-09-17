local this = class("moduleBossAreaEnter", G_UIModuleBase)
local _enemyTpl = L_GameTpl:getEnemyTpl()

function this.bind()
  return {active_node = true, txt_tips = ""}
end

function this.methods()
  return {}
end

function this:show(options)
  if options ~= nil then
    local monsterCfg = _enemyTpl:getTplById(options.monsterId)
    self.bind.txt_tips = L_Lang:get(L_WordsTpl:getValue("ui_into_boss_area_tips"), {
      [0] = _enemyTpl:getName(monsterCfg)
    })
  end
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

return this

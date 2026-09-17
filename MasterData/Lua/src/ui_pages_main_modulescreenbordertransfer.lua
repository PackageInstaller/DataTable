local this = class("moduleScreenBorderTransfer", G_UIModuleBase)
local _worldBorthposTpl = L_GameTpl:getWorldBorthposTpl()
local _worldCityTpl = L_GameTpl:getWorldCityTpl()

function this.bind()
  return {go_content = false, txt_countdown = nil}
end

function this.methods()
  return {}
end

function this:open()
  local tpl_pos = _worldBorthposTpl:getTplById(param.posId)
  local sceneId = _worldBorthposTpl:getCityId(tpl_pos)
  self.bind.txt_countdown = L_WordsTpl:getValue("notice_moduleScreenBorderTransfer", {
    [0] = math.ceil(param.countdown),
    [1] = _worldCityTpl:getCity(_worldCityTpl:getTplById(sceneId))
  })
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

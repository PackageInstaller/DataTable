local cls = class("cellEntrustTaskEntranceTimeLimit", G_UIModuleBase)
local _dungeonEntrustTypeTpl = L_GameTpl:getDungeonEntrustTypeTpl()
local _eventEntrustTpl = L_GameTpl:getGameEventsEntrustEnterTpl()
local _dungeonEntrustAreaTpl = L_GameTpl:getDungeonEntrustAreaTpl()
local _gameEventTpl = L_GameTpl:getGameEventsTpl()

function cls.bind()
  return {
    img_icon = "",
    toggle_line = false,
    txt_name = "",
    toggle_unlock = false,
    txt_entrust_a = "",
    bShowRewardUp = false,
    moduleRewardUp = {
      moduleName = "pages/gameAct/doubleDrop/moduleRewardUp"
    },
    timeLimitActive = false
  }
end

function cls.methods()
  return {
    onClick_select = function(self)
      if self.bind.cbk then
        self.bind.cbk(self)
      end
    end
  }
end

function cls:refresh()
  self.bind.timeLimitActive = true
  local typeId = _eventEntrustTpl:getId(self.bind.cfgData)
  self.bind.img_icon = _dungeonEntrustAreaTpl:getBanner(self.bind.areaTpl, typeId)
  self.bind.txt_name = _eventEntrustTpl:getName(self.bind.cfgData)
  local eventId = _eventEntrustTpl:getGameEventId(self.bind.cfgData)
  local eventTpl = _gameEventTpl:getTplById(eventId)
  for k, v in pairs(eventTpl.condition) do
    if C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(v) == false then
      self.bind.toggle_unlock = false
      break
    end
  end
  self.modules.moduleRewardUp:setEntrustType(0)
  self.bind.bShowRewardUp = false
end

return cls

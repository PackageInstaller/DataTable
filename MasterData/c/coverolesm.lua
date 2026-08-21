local statemachine = require('statemachine')
require "class"
local unpack = unpack or table.unpack
---@class CoveRoleSM
local CoveRoleSM = class("CoveRoleSM")



function CoveRoleSM:ctor(pCoveRole)
    self.coveRole = pCoveRole

    --LuaLogger.es('CoveRoleSM:ctor ',pCoveRole)

    self.machine = statemachine.create({
      initial = statemachine.NONE,
      events = {
        { name = 'idle',  from = statemachine.NONE,  to = statemachine.NONE },
        { name = 'gotoRoom',  from = "idle",  to = "gotoRoom" },
        { name = 'tour',  from = {"none","idle","gotoRoom","tour"},  to = "tour" },
        { name = 'leavePort',  from = {"none","idle","gotoRoom"},  to = "leavePort" },
        { name = 'dispatch',  from = {"none","idle","gotoRoom"},  to = "dispatch" },
        { name = 'doremoveScene',  from = {"tour","idle","gotoRoom"},  to = "remove" },
      },
      callbacks = {
        -- onidle =    function(self, event, from, to)      print('red light')         end,
      }

    })

    self.machine.onidle = function(mach, event, from, to)  self:onIdleState(event, from, to) end
    self.machine.ongotoRoom = function(mach, event, from, to)  self:onGoToRoomState(event, from, to) end
    self.machine.ontour = function(mach, event, from, to)  self:onTourState(event, from, to) end
    self.machine.onleavePort = function(mach, event, from, to)  self:onleavePortState(event, from, to) end
    self.machine.ondispatch = function(mach, event, from, to)  self:ondispatchState(event, from, to) end
	self.machine.ondoremoveScene = function(mach, event, from, to)  self:ondoremoveSceneState(event, from, to) end
end


function CoveRoleSM:onIdleState(event, from, to, msg)
  LuaLogger.es('idle! ',event, from, to)
  if (not self.coveRole._model) then
		return
	end
	self.coveRole._model:SetDefaultState(RoleAnimStateType.Idle)
end

function CoveRoleSM:onGoToRoomState(event, from, to, msg)
    LuaLogger.es('onGoToRoomState! ',event, from, to)
    if (not self.coveRole._model or not self.coveRole._room or not self.coveRole._pathInfo) then
      return
    end
    local pointData = self.coveRole._roomMgr:getPointInfo(self.coveRole._pathInfo.way[self._pathIndex])
    if not pointData.target then
      return
    end
    self._pathIndex = self._pathIndex + 1
    self.coveRole._model:SetDefaultState(self.coveRole._pathInfo.moveMode)
    self.coveRole:changeSpeedWithState()
    self.coveRole._roleCont:SetTaregt(pointData.target.position, function()
      self.coveRole:doBehavior('tour')
    end)

end

----玩家状态切换到了走路循环状态
function CoveRoleSM:onTourState(event, from, to, msg)

  LuaLogger.es('onTourState! ',event, from, to)
  LuaLogger.es('self.coveRole == ',self)
  if (not self.coveRole._model or not self.coveRole._room) then
		return
	end
	if self.coveRole.coveRoleType == CoveRoleType.HomeWork then
		self.coveRole.roomStayStamp = -1
	else	
		self.coveRole.roomStayStamp = os.time() + self.coveRole._room:randomStayTime()
	end
	self.coveRole:doTourLogic()
end



function CoveRoleSM:ondoremoveSceneState(event, from, to, msg)

	self.coveRole:doRemoveSceneLogic()
end


function CoveRoleSM:onleavePortState(event, from, to, msg)
	LuaLogger.es('onleavePortState! ',event, from, to)
  	if (not self.coveRole._model) then
		return
	end
	self.coveRole._room:onPathUseEnd(self.coveRole._pathInfo)
	self.coveRole:clearShowTimer()

	local pos = self.coveRole._roleMgr._coveMgr:getEndPoint()
	self.coveRole._model:SetDefaultState(RoleAnimStateType.Run)
	--离开行为开始时即视为房间空出
	self.coveRole._room:removeRole(self)
	self.coveRole._roleCont:SetSpeed(Config.GetConfigInfo("homeRunSpeed"))
	self.coveRole._roleCont:SetTaregt(pos.position, function()
	--角色真正离开港口才从roleMgr的roleList中剔除
		self.coveRole._model:FadeOut()
		DLuaTimer:DoAfter( 0.7, function()
			self.coveRole._roleMgr:removeRole(self)
		end)
	end)

end



function CoveRoleSM:ondispatchState(event, from, to, msg)
LuaLogger.es('ondispatchState! ',event, from, to)
  if (not self.coveRole._model) then
		return
	end
	self.coveRole._room:onPathUseEnd(self.coveRole._pathInfo)
	self:clearShowTimer()

	local pos = self.coveRole._roleMgr._coveMgr:getDisPatchPoint()
	self.coveRole._model:SetDefaultState(RoleAnimStateType.Run)
	--离开行为开始时即视为房间空出
	self.coveRole._room:removeRole(self)
	self.coveRole._roleCont:SetSpeed(Config.GetConfigInfo("homeRunSpeed"))
	self.coveRole._roleCont:SetTaregt(pos.position, function()
	--角色真正离开港口才从roleMgr的roleList中剔除
		self.coveRole._model:FadeOut()
		DLuaTimer:DoAfter( 0.7, function()
			self.coveRole._roleMgr:removeRole(self)
		end)
	end)
end

return CoveRoleSM
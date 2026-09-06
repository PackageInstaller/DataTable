-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bigorange/controller/BigOrangeController.lua

module("logic.extensions.bigorange.controller.BigOrangeController", package.seeall)

local BigOrangeController = class("BigOrangeController", BaseController)

BigOrangeController.NPC = 10011016

function BigOrangeController:ctor()
	BigOrangeController.super.ctor(self)
end

function BigOrangeController:onInit()
	BigOrangeController.super.onInit(self)
	GlobalDispatcher:addListener(GlobalNotify.SelectNPC, self._onSelectNpc, self)
end

function BigOrangeController:goToNPC()
	TaskController.instance:foreceClearState()
	UIStateManager.instance:clear(true)

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		mainPlayer:gotoNpcCrossScene(BigOrangeController.NPC, function(onfinishedObj)
			return
		end)
	end
end

function BigOrangeController:_onSelectNpc(npcId)
	if not npcId then
		return
	end

	if npcId == BigOrangeController.NPC then
		UIStateManager.instance:push(ViewName.BigOrangeView)
	end
end

BigOrangeController.instance = BigOrangeController.New()

return BigOrangeController

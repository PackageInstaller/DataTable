-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/flow/flowcomp/HouseSceneViewMgr.lua

module("logic.extensions.house.scene.flow.flowcomp.HouseSceneViewMgr", package.seeall)

local M = class("HouseSceneViewMgr", ISceneFlowComp)

function M:onEnter()
	HouseMainController.instance:checkInit()

	local lastState = HouseMainStateModel.instance:getState()

	if lastState ~= HouseMainEnum.State.ExploreMode then
		lastState = HouseMainEnum.State.Normal
	end

	HouseMainStateModel.instance:changeState(lastState)
end

function M:onEnterDone()
	local isBackScene = self._flow:getIsBackScene()

	if isBackScene then
		HouseMainRoomModel.instance:setJumpInfo(nil)
		settimer(0, function()
			ViewMgr.instance:_openPreFullUpView()
		end, self, false)
	else
		ViewMgr.instance:open(ViewName.RoomMainView)
		settimer(0, function()
			HouseMainController.instance:onHouseSceneEnterDealJumpInfo(HouseMainRoomModel.instance:getJumpInfo())
		end, self, false)
	end
end

function M:onExitDone()
	HouseMainController.instance:onReset()
end

function M:onSceneLoadDone()
	ViewMgr.instance:preCreate(ViewName.RoomMainView)
end

return M

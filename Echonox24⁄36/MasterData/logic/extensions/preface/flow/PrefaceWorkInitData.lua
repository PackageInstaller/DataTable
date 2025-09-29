-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/preface/flow/PrefaceWorkInitData.lua

module("logic.extensions.preface.flow.PrefaceWorkInitData", package.seeall)

local M = class("PrefaceWorkInitData", WorkBase)

function M:onEnter(context)
	local info = {}
	local stage = PlayerModel.instance:getPrologueStageId()

	if not stage then
		self:onDone(WorkResult.Succeed)

		return
	end

	info.dungeonCode = stage
	info.afflatusBuff = false
	info.isShowPlot = true
	info.multiCount = 1
	info.dungeonIndex = 0
	info.gamePlay = BattleEnum.GamePlayType.NORMAL

	PrefaceController.instance:getPrefaceBattleFlow().model:setInfo(info)
	self:onDone(WorkResult.Succeed)
end

return M

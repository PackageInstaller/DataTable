-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcalculate/resultview/IBattleCustomCalculateView.lua

module("logic.extensions.battle.viewcalculate.resultview.IBattleCustomCalculateView", package.seeall)

local IBattleCustomCalculateView = class("IBattleCustomCalculateView")

function IBattleCustomCalculateView:build(mainGO)
	if BattleLog.enableError then
		BattleLog.error("unimplement method")
	end
end

function IBattleCustomCalculateView:destroy()
	if BattleLog.enableError then
		BattleLog.error("unimplement method")
	end
end

return IBattleCustomCalculateView

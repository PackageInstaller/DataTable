-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulatecharge/view/AccumulateChargeBackupView.lua

module("logic.extensions.accumulatecharge.view.AccumulateChargeBackupView", package.seeall)

local AccumulateChargeBackupView = class("AccumulateChargeBackupView", AccumulateChargeView)

function AccumulateChargeBackupView:_getBgEffectPath()
	return "20211217/cangbaoge/fx_ui_cangbaogexiuer_daiji.prefab"
end

function AccumulateChargeBackupView:_playAnim(activityId)
	local targetActivityId = checknumber(AccumulategiftConfig.instance:getConstValue("TARGETACTIVITYID"))

	if activityId == targetActivityId then
		local name = ViewName.AccumulateChargeBackupView .. targetActivityId
		local isUsed = GameUtil.getUserDayData(name)

		if not isUsed then
			GameUtil.saveUserDayData(name, true)

			local path = AccumulategiftConfig.instance:getConstValue("ANIMPATH")

			AnimationPlayer.play(path)
		end
	end
end

return AccumulateChargeBackupView

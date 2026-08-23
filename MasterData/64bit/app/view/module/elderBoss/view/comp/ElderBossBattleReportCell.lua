local ElderBossBattleReportCell = class("ElderBossBattleReportCell", require("app.fairyGUI.elderBoss.UI_ElderBossBattleReportCell"))

function ElderBossBattleReportCell:ctor()
	return
end

function ElderBossBattleReportCell:updateText(arg_2_1)
	local var_2_0 = ""

	for iter_2_0 = 1, #arg_2_1.lucky_awards do
		local var_2_1 = g.core.common.Goods:convert(arg_2_1.lucky_awards[iter_2_0])

		var_2_0 = iter_2_0 == 1 and var_2_0 .. arg_2_1.lucky_awards[iter_2_0].size .. g.core.lang:get(432514) .. var_2_1.name or var_2_0 .. "、" .. arg_2_1.lucky_awards[iter_2_0].size .. g.core.lang:get(432514) .. var_2_1.name
	end

	local var_2_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.lucky_user)

	if var_2_2 then
		self.m_descTxt:setText(g.core.lang:get(432513, {
			grade = arg_2_1.grade,
			userNum = arg_2_1.challenge_user_num,
			luckyUserName = var_2_2.name,
			serverName = var_2_2.server_name,
			awardText = var_2_0
		}))
	end
end

return ElderBossBattleReportCell

local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("NewWarChessSelectHeroProxy", var_0_0)

function var_0_1.InitCustomParams(arg_1_0, arg_1_1)
	arg_1_0.needPresetReservePanel = false
	arg_1_0.needMimirPanel = false
end

function var_0_1.OnSectionSelectEnter(arg_2_0)
	arg_2_0:CheckNewWarChessTeamRedPoint()
end

function var_0_1.UpdateBar(arg_3_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back()
		manager.NewChessManager:ClearBattleData()
	end)
end

function var_0_1.GetHeroTeamInfoRoute(arg_5_0)
	return "/newWarChessHeroTeamInfoView"
end

function var_0_1.CheckNewWarChessTeamRedPoint(arg_6_0)
	local var_6_0 = arg_6_0:GetHeroIDList()
	local var_6_1 = NewWarChessData:GetHeroInfoList()
	local var_6_2 = {}
	local var_6_3 = false
	local var_6_4 = false

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		if iter_6_1 == 0 then
			var_6_3 = true
		else
			table.insert(var_6_2, iter_6_1)
		end
	end

	if var_6_3 then
		for iter_6_2, iter_6_3 in pairs(var_6_1) do
			if iter_6_3[2] > 0 and table.keyof(var_6_2, NewWarChessHeroCfg[iter_6_3[1]].hero_id) == nil then
				var_6_4 = true
			end
		end
	else
		var_6_4 = false
	end

	if var_6_4 then
		for iter_6_4, iter_6_5 in pairs(var_6_0) do
			if iter_6_5 == 0 then
				manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_HERO_USE .. iter_6_4, 1)
			else
				manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_HERO_USE .. iter_6_4, 0)
			end
		end
	else
		for iter_6_6, iter_6_7 in pairs(var_6_0) do
			manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_HERO_USE .. iter_6_6, 0)
		end
	end
end

function var_0_1.CustomHeroBindRedPoint(arg_7_0, arg_7_1, arg_7_2)
	manager.redPoint:bindUIandKey(arg_7_2.addBtnRedPointContain_, RedPointConst.NEW_WARCHESS_HERO_USE .. arg_7_1)
end

function var_0_1.CustomHeroUnBindRedPoint(arg_8_0, arg_8_1, arg_8_2)
	manager.redPoint:unbindUIandKey(arg_8_2.addBtnRedPointContain_, RedPointConst.NEW_WARCHESS_HERO_USE .. arg_8_1)
end

function var_0_1.CustomGetHeroHP(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = NewWarChessData:GetHeroHp(arg_9_2)
	local var_9_1 = math.ceil(var_9_0 / NewChessConst.HERO_HP_RATE * 100)

	return var_9_0, var_9_1
end

return var_0_1

local NewWarChessSelectHeroProxy = class("NewWarChessSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function NewWarChessSelectHeroProxy:InitCustomParams(arg_1_1)
	self.needPresetReservePanel = false
	self.needMimirPanel = false
end

function NewWarChessSelectHeroProxy:OnSectionSelectEnter()
	self:CheckNewWarChessTeamRedPoint()
end

function NewWarChessSelectHeroProxy:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back()
		manager.NewChessManager:ClearBattleData()
	end)
end

function NewWarChessSelectHeroProxy:GetHeroTeamInfoRoute()
	return "/newWarChessHeroTeamInfoView"
end

function NewWarChessSelectHeroProxy:CheckNewWarChessTeamRedPoint()
	local var_6_0 = self:GetHeroIDList()
	local var_6_1 = {}
	local var_6_2 = false
	local var_6_3 = false

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		if iter_6_1 == 0 then
			var_6_2 = true
		else
			table.insert(var_6_1, iter_6_1)
		end
	end

	if var_6_2 then
		for iter_6_2, iter_6_3 in pairs((NewWarChessData:GetHeroInfoList())) do
			if iter_6_3[2] > 0 and table.keyof(var_6_1, NewWarChessHeroCfg[iter_6_3[1]].hero_id) == nil then
				var_6_3 = true
			end
		end
	else
		var_6_3 = false
	end

	if var_6_3 then
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

function NewWarChessSelectHeroProxy:CustomHeroBindRedPoint(arg_7_1, arg_7_2)
	manager.redPoint:bindUIandKey(arg_7_2.addBtnRedPointContain_, RedPointConst.NEW_WARCHESS_HERO_USE .. arg_7_1)
end

function NewWarChessSelectHeroProxy:CustomHeroUnBindRedPoint(arg_8_1, arg_8_2)
	manager.redPoint:unbindUIandKey(arg_8_2.addBtnRedPointContain_, RedPointConst.NEW_WARCHESS_HERO_USE .. arg_8_1)
end

function NewWarChessSelectHeroProxy:CustomGetHeroHP(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = NewWarChessData:GetHeroHp(arg_9_2)

	return var_9_0, (math.ceil(var_9_0 / NewChessConst.HERO_HP_RATE * 100))
end

return NewWarChessSelectHeroProxy

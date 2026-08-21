local var_0_0 = class("WorldBossInfoAndRankPanel", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "WorldBossInfoAndRankUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.toggleRank = arg_2_0._tf:Find("rank")
	arg_2_0.toggleInfo = arg_2_0._tf:Find("info")
	arg_2_0.myRankTF = arg_2_0._tf:Find("rank_panel/tpl")
	arg_2_0.rankList = UIItemList.New(arg_2_0._tf:Find("rank_panel/list"), arg_2_0.myRankTF)
	arg_2_0.maxRankCnt = pg.gameset.joint_boss_fighter_max.key_value
	arg_2_0.rankCnt1 = arg_2_0._tf:Find("rank_panel/cnt/Text"):GetComponent(typeof(Text))
	arg_2_0.rankTF = arg_2_0._tf:Find("rank_panel")
	arg_2_0.maskTF = arg_2_0._tf:Find("rank_panel/mask")
	arg_2_0.maskTxt = arg_2_0._tf:Find("rank_panel/mask/Text"):GetComponent(typeof(Text))
	arg_2_0.infoTitle = arg_2_0._tf:Find("info_panel/title/Text"):GetComponent(typeof(Text))
	arg_2_0.infoSkillList = UIItemList.New(arg_2_0._tf:Find("info_panel/scrollrect/content"), arg_2_0._tf:Find("info_panel/scrollrect/content/tpl"))

	return
end

function var_0_0.SetCallback(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.callback = arg_3_1
	arg_3_0.flushRankCallback = arg_3_2

	return
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0._tf:SetSiblingIndex(2)
	onToggle(arg_4_0, arg_4_0.toggleInfo, function(arg_5_0)
		if arg_5_0 then
			arg_4_0:ResetInfoLayout()
		end

		return
	end)

	return
end

function var_0_0.Flush(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.boss = arg_6_1
	arg_6_0.proxy = arg_6_2

	arg_6_0:FlushRank()
	arg_6_0:FlushInfo()

	if not arg_6_0.boss:IsFullHp() then
		triggerToggle(arg_6_0.toggleRank, true)
	else
		triggerToggle(arg_6_0.toggleInfo, true)
		arg_6_0:ResetInfoLayout()
	end

	return
end

function var_0_0.FlushInfo(arg_7_0)
	arg_7_0.infoTitle.text = arg_7_0.boss.config.name

	local var_7_0 = arg_7_0.boss.config.description

	arg_7_0.infoSkillList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			GetSpriteFromAtlasAsync("ui/WorldBossUI_atlas", "color_" .. var_7_0[arg_8_1 + 1][2], function(arg_9_0)
				arg_8_2:Find("color"):GetComponent(typeof(Image)).sprite = arg_9_0

				return
			end)
			setText(arg_8_2:Find("color/Text"), var_7_0[arg_8_1 + 1][1])
		end

		return
	end)
	arg_7_0.infoSkillList:align(#arg_7_0.boss.config.description)

	return
end

function var_0_0.ResetInfoLayout(arg_10_0)
	local var_10_0 = 28
	local var_10_1 = arg_10_0.boss.config.description

	onNextTick(function()
		if arg_10_0.exited then
			return
		end

		arg_10_0.infoSkillList:each(function(arg_12_0, arg_12_1)
			local var_12_0 = "　"
			local var_12_1, var_12_2 = math.modf(arg_12_1:Find("color/Text").sizeDelta.x / var_10_0)

			for iter_12_0 = 1, var_12_1 do
				var_12_0 = var_12_0 .. "　"
			end

			if var_12_2 > 0 then
				var_12_0 = var_12_0 .. "<size=" .. math.ceil(var_10_0 * var_12_2) .. ">　</size>"
			end

			setText(arg_12_1:Find("Text"), var_12_0 .. var_10_1[arg_12_0 + 1][3])

			return
		end)

		return
	end)

	return
end

function var_0_0.FlushRank(arg_13_0)
	if not arg_13_0.boss then
		return
	end

	local var_13_0 = arg_13_0.proxy:GetRank(arg_13_0.boss.id)
	local var_13_1 = 0

	if not var_13_0 then
		arg_13_0:emit(WorldBossMediator.ON_RANK_LIST, arg_13_0.boss.id)
	else
		arg_13_0.rankList:make(function(arg_14_0, arg_14_1, arg_14_2)
			if arg_14_0 == UIItemList.EventUpdate then
				arg_13_0:UpdateRankTF(arg_14_2, var_13_0[arg_14_1 + 1], arg_14_1 + 1)
			end

			return
		end)
		arg_13_0.rankList:align(math.min(#var_13_0, 3))
		arg_13_0:UpdateSelfRank(var_13_0)

		var_13_1 = #var_13_0
	end

	arg_13_0.rankCnt1.text = var_13_1 .. "<color=#A2A2A2>/" .. arg_13_0.maxRankCnt .. "</color>"

	if arg_13_0.flushRankCallback then
		arg_13_0.flushRankCallback(var_13_1, arg_13_0.maxRankCnt)
	end

	arg_13_0:AddWaitResultTimer()

	return
end

function var_0_0.AddWaitResultTimer(arg_15_0)
	arg_15_0:RemoveWaitTimer()

	local var_15_0 = arg_15_0.boss:ShouldWaitForResult()

	setActive(arg_15_0.maskTF, var_15_0)

	if var_15_0 then
		local var_15_1 = arg_15_0.boss:GetWaitForResultTime()

		arg_15_0.waitTimer = Timer.New(function()
			local var_16_0 = var_15_1 - pg.TimeMgr.GetInstance():GetServerTime()

			if var_16_0 < 0 then
				arg_15_0:AddWaitResultTimer()

				if arg_15_0.callback then
					arg_15_0.callback(false)
				end
			else
				local var_16_1 = arg_15_0.maskTxt

				var_16_1.text = pg.TimeMgr.GetInstance():DescCDTime(var_16_0)
			end

			return
		end, 1, -1)

		arg_15_0.waitTimer:Start()

		if arg_15_0.callback then
			arg_15_0.callback(true)
		end
	end

	return
end

function var_0_0.RemoveWaitTimer(arg_17_0)
	if arg_17_0.waitTimer then
		arg_17_0.waitTimer:Stop()

		arg_17_0.waitTimer = nil
	end

	return
end

function var_0_0.UpdateRankTF(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	setText(arg_18_1:Find("name"), arg_18_2.name)
	setText(arg_18_1:Find("value/Text"), arg_18_2.damage)

	local var_18_0 = arg_18_2.number or arg_18_3

	setText(arg_18_1:Find("number"), var_18_0)
	setActive(arg_18_1:Find("value/view"), not arg_18_2.isSelf)
	onButton(arg_18_0, arg_18_1:Find("value/view"), function()
		arg_18_0:emit(WorldBossMediator.FETCH_RANK_FORMATION, arg_18_2.id, arg_18_0.boss.id)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateSelfRank(arg_20_0, arg_20_1)
	local var_20_0

	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		if iter_20_1.isSelf then
			var_20_0 = iter_20_1
			var_20_0.number = iter_20_0

			break
		end
	end

	if var_20_0 then
		arg_20_0:UpdateRankTF(arg_20_0.myRankTF, var_20_0)
	end

	return
end

function var_0_0.OnDestroy(arg_21_0)
	arg_21_0:RemoveWaitTimer()

	return
end

return var_0_0

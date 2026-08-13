class = var_0_10000

local var_0_0 = "WorldBossInfoAndRankPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "WorldBossInfoAndRankUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.toggleRank = var_1.Find(var_2_0, "rank")

	local var_2_1 = arg_2_0._tf

	arg_2_0.toggleInfo = var_1.Find(var_2_1, "info")

	local var_2_2 = arg_2_0._tf

	arg_2_0.myRankTF = var_1.Find(var_2_2, "rank_panel/tpl")
	UIItemList = var_1

	local var_2_3 = var_1.New
	local var_2_4 = arg_2_0._tf

	arg_2_0.rankList = var_2_3(var_2.Find(var_2_4, "rank_panel/list"), arg_2_0.myRankTF)
	pg = var_1
	arg_2_0.maxRankCnt = var_1.gameset.joint_boss_fighter_max.key_value

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "rank_panel/cnt/Text")
	local var_2_7 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.rankCnt1 = var_2_7(var_2_6, var_3(var_4))

	local var_2_8 = arg_2_0._tf

	arg_2_0.rankTF = var_1.Find(var_2_8, "rank_panel")

	local var_2_9 = arg_2_0._tf

	arg_2_0.maskTF = var_1.Find(var_2_9, "rank_panel/mask")

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_1.Find(var_2_10, "rank_panel/mask/Text")
	local var_2_12 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.maskTxt = var_2_12(var_2_11, var_3(var_4))

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_1.Find(var_2_13, "info_panel/title/Text")
	local var_2_15 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.infoTitle = var_2_15(var_2_14, var_3(var_4))
	UIItemList = var_1

	local var_2_16 = var_1.New
	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_2.Find(var_2_17, "info_panel/scrollrect/content")
	local var_2_19 = arg_2_0._tf

	arg_2_0.infoSkillList = var_2_16(var_2_18, var_3.Find(var_2_19, "info_panel/scrollrect/content/tpl"))

	return
end

function var_0_1.SetCallback(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.callback = arg_3_1
	arg_3_0.flushRankCallback = arg_3_2

	return
end

function var_0_1.OnInit(arg_4_0)
	local var_4_0 = arg_4_0._tf

	var_1.SetSiblingIndex(var_4_0, 2)

	onToggle = var_1

	var_1(arg_4_0, arg_4_0.toggleInfo, function(arg_5_0)
		if arg_5_0 then
			local var_5_0 = arg_4_0

			var_1.ResetInfoLayout(var_5_0)
		end

		return
	end)

	return
end

function var_0_1.Flush(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.boss = arg_6_1
	arg_6_0.proxy = arg_6_2

	arg_6_0:FlushRank()
	arg_6_0:FlushInfo()

	local var_6_0 = arg_6_0.boss

	if not var_3.IsFullHp(var_6_0) then
		triggerToggle = var_3

		var_3(arg_6_0.toggleRank, true)
	else
		triggerToggle = var_3

		var_3(arg_6_0.toggleInfo, true)
		arg_6_0:ResetInfoLayout()
	end

	return
end

function var_0_1.FlushInfo(arg_7_0)
	arg_7_0.infoTitle.text = arg_7_0.boss.config.name

	local var_7_0 = arg_7_0.boss.config.description
	local var_7_1 = arg_7_0.infoSkillList

	var_2.make(var_7_1, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			local var_8_0 = var_7_0[arg_8_1 + 1][1]
			local var_8_1 = var_3[2]

			GetSpriteFromAtlasAsync = var_2_10006

			var_2_10006("ui/WorldBossUI_atlas", "color_" .. var_8_1, function(arg_9_0)
				local var_9_0 = arg_8_2
				local var_9_1 = var_1.Find(var_9_0, "color")
				local var_9_2 = var_1.GetComponent

				typeof = var_3
				Image = var_3_10004
				var_9_2(var_9_1, var_3(var_3_10004)).sprite = arg_9_0

				return
			end)

			local var_8_2 = arg_8_2
			local var_8_3 = arg_8_2.Find(var_8_2, "color/Text")

			setText = var_8_2

			var_8_2(var_8_3, var_8_0)
		end

		return
	end)

	local var_7_2 = arg_7_0.infoSkillList

	var_2.align(var_7_2, #var_7_0)

	return
end

function var_0_1.ResetInfoLayout(arg_10_0)
	local var_10_0 = 28
	local var_10_1 = arg_10_0.boss.config.description

	onNextTick = var_1_10003

	var_1_10003(function()
		if arg_10_0.exited then
			return
		end

		local var_11_0 = arg_10_0.infoSkillList

		var_0.each(var_11_0, function(arg_12_0, arg_12_1)
			local var_12_0 = var_10_1[arg_12_0 + 1][3]
			local var_12_1 = arg_12_1:Find("color/Text")
			local var_12_2 = "　"

			math = var_6

			local var_12_3, var_12_4 = var_6.modf(var_12_1.sizeDelta.x / var_10_0)

			math = var_8

			local var_12_5 = var_8.ceil(var_10_0 * var_12_4)

			for iter_12_0 = 1, var_12_3 do
				var_12_2 = var_12_2 .. "　"
			end

			if 0 < var_12_4 then
				var_12_2 = var_12_2 .. "<size=" .. var_12_5 .. ">　</size>"
			end

			setText = var_9

			var_9(arg_12_1:Find("Text"), var_12_2 .. var_12_0)

			return
		end)

		return
	end)

	return
end

function var_0_1.FlushRank(arg_13_0)
	if not arg_13_0.boss then
		return
	end

	local var_13_0 = arg_13_0.proxy
	local var_13_1 = var_2.GetRank(var_13_0, var_1.id)
	local var_13_2 = 0

	if not var_13_1 then
		local var_13_3 = arg_13_0
		local var_13_4 = arg_13_0.emit

		WorldBossMediator = var_1_10007

		var_13_4(var_13_3, var_1_10007.ON_RANK_LIST, var_1.id)
	else
		local var_13_5 = arg_13_0.rankList

		var_5.make(var_13_5, function(arg_14_0, arg_14_1, arg_14_2)
			UIItemList = var_2_10003

			if arg_14_0 == var_2_10003.EventUpdate then
				local var_14_0 = var_13_1[arg_14_1 + 1]
				local var_14_1 = arg_13_0

				var_4.UpdateRankTF(var_14_1, arg_14_2, var_14_0, arg_14_1 + 1)
			end

			return
		end)

		local var_13_6 = arg_13_0.rankList
		local var_13_7 = var_5.align

		math = var_7

		var_13_7(var_13_6, var_7.min(#var_13_1, 3))
		arg_13_0:UpdateSelfRank(var_13_1)

		var_13_2 = #var_13_1
	end

	arg_13_0.rankCnt1.text = var_13_2 .. "<color=#A2A2A2>/" .. arg_13_0.maxRankCnt .. "</color>"

	if arg_13_0.flushRankCallback then
		arg_13_0.flushRankCallback(var_13_2, arg_13_0.maxRankCnt)
	end

	arg_13_0:AddWaitResultTimer()

	return
end

function var_0_1.AddWaitResultTimer(arg_15_0)
	arg_15_0:RemoveWaitTimer()

	local var_15_0 = arg_15_0.boss
	local var_15_1 = var_1.ShouldWaitForResult(var_15_0)

	setActive = var_15_0

	var_15_0(arg_15_0.maskTF, var_15_1)

	if var_15_1 then
		local var_15_2 = var_1
		local var_15_3 = var_1.GetWaitForResultTime(var_15_2)

		Timer = var_15_2
		arg_15_0.waitTimer = var_15_2.New(function()
			pg = var_2_10000

			local var_16_0 = var_2_10000.TimeMgr.GetInstance()
			local var_16_1 = var_0.GetServerTime(var_16_0)

			if var_15_3 - var_16_1 < 0 then
				var_2_10003 = arg_15_0

				var_2.AddWaitResultTimer(var_2_10003)

				if arg_15_0.callback then
					arg_15_0.callback(false)
				end
			else
				local var_16_2 = arg_15_0.maskTxt

				pg = var_2_10003

				local var_16_3 = var_2_10003.TimeMgr.GetInstance()

				var_16_2.text = var_3.DescCDTime(var_16_3, var_1)
			end

			return
		end, 1, -1)

		local var_15_4 = arg_15_0.waitTimer

		var_4.Start(var_15_4)

		if arg_15_0.callback then
			arg_15_0.callback(true)
		end
	end

	return
end

function var_0_1.RemoveWaitTimer(arg_17_0)
	if arg_17_0.waitTimer then
		local var_17_0 = arg_17_0.waitTimer

		var_1.Stop(var_17_0)

		arg_17_0.waitTimer = nil
	end

	return
end

function var_0_1.UpdateRankTF(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	setText = var_1_10004

	var_1_10004(arg_18_1:Find("name"), arg_18_2.name)

	setText = var_1_10004

	var_1_10004(arg_18_1:Find("value/Text"), arg_18_2.damage)

	setText = var_1_10004

	local var_18_0 = arg_18_1:Find("number")
	local var_18_1

	if not arg_18_2.number then
		var_18_1 = arg_18_3
	end

	var_1_10004(var_18_0, var_18_1)

	setActive = var_1_10004

	var_1_10004(arg_18_1:Find("value/view"), not arg_18_2.isSelf)

	onButton = var_1_10004

	local var_18_2 = arg_18_0
	local var_18_3 = arg_18_1:Find("value/view")

	local function var_18_4()
		local var_19_0 = arg_18_0.boss
		local var_19_1 = arg_18_0
		local var_19_2 = var_1.emit

		WorldBossMediator = var_2_10003

		var_19_2(var_19_1, var_2_10003.FETCH_RANK_FORMATION, arg_18_2.id, var_19_0.id)

		return
	end

	SFX_PANEL = var_8

	var_1_10004(var_18_2, var_18_3, var_18_4, var_8)

	return
end

function var_0_1.UpdateSelfRank(arg_20_0, arg_20_1)
	local var_20_0

	ipairs = var_1_10003

	for iter_20_0, iter_20_1 in var_1_10003(arg_20_1) do
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

function var_0_1.OnDestroy(arg_21_0)
	arg_21_0:RemoveWaitTimer()

	return
end

return var_0_1

class = var_0_10000

local var_0_0 = "PublicGuildOfficePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "PublicGuildDonateBluePage"
end

function var_0_1.OnLoaded(arg_2_0)
	UIItemList = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "frame/donate_panel/list")
	local var_2_3 = arg_2_0._tf

	arg_2_0.itemList = var_2_0(var_2_2, var_4.Find(var_2_3, "frame/donate_panel/list/tpl"))

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "frame/donate_panel/cnt/Text")
	local var_2_6 = var_1.GetComponent

	typeof = var_4
	Text = var_2_3
	arg_2_0.cntTxt = var_2_6(var_2_5, var_4(var_2_3))

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0.cards = {}

	local var_3_0 = arg_3_0.itemList

	var_1.make(var_3_0, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_3_0

			var_3.UpdateDonateTask(var_4_0, arg_4_2, arg_3_0.displays[arg_4_1 + 1])
		end

		return
	end)

	return
end

function var_0_1.Show(arg_5_0, arg_5_1)
	arg_5_0.guild = arg_5_1

	arg_5_0:Flush()
	var_0_1.super.Show(arg_5_0)

	return
end

function var_0_1.Flush(arg_6_0)
	local var_6_0 = arg_6_0.guild

	arg_6_0.displays = var_1.GetDonateTasks(var_6_0)

	local var_6_1 = arg_6_0.itemList

	var_1.align(var_6_1, #arg_6_0.displays)

	pg = var_1

	local var_6_2 = var_1.GuildPaintingMgr.GetInstance()
	local var_6_3 = var_1.Update
	local var_6_4 = "guild_office_blue"

	Vector3 = var_1_10005

	var_6_3(var_6_2, var_6_4, var_1_10005(-737, -171, 0))

	return
end

function var_0_1.UpdateDonateTask(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.guild
	local var_7_1 = var_3.GetRemainDonateCnt(var_7_0)
	local var_7_2

	if not arg_7_0.cards[arg_7_1] then
		GuildDonateCard = var_7_0
		var_7_2 = var_7_0.New(arg_7_1)
		arg_7_0.cards[arg_7_1] = var_7_2
	end

	var_7_2:update(arg_7_2)

	onButton = var_6

	local var_7_3 = arg_7_0
	local var_7_4 = var_7_2.commitBtn

	local function var_7_5()
		local var_8_0 = var_7_2.dtask
		local var_8_1 = var_0.getCommitItem(var_8_0)

		Drop = var_2_10002

		local var_8_2 = var_2_10002.Create(var_8_1)
		local var_8_3 = var_7_2
		local var_8_4 = var_3.GetResCntByAward(var_8_3, var_8_1) < var_8_1[3] and "#FF5C5CFF" or "#92FC63FF"

		pg = var_8_3

		local var_8_5 = var_8_3.MsgboxMgr.GetInstance()
		local var_8_6 = var_5.ShowMsgBox
		local var_8_7 = {}

		i18n = var_2_10009
		var_8_7.content = var_2_10009("guild_donate_tip", var_8_2:getConfig("name"), var_8_1[3], var_3, var_8_4)

		function var_8_7.onYes()
			local var_9_0 = arg_7_0
			local var_9_1 = var_0.emit

			PublicGuildMainMediator = var_3_10003

			var_9_1(var_9_0, var_3_10003.ON_COMMIT, var_0.id)

			return
		end

		var_8_6(var_8_5, var_8_7)

		return
	end

	SFX_PANEL = var_1_10011

	var_6(var_7_3, var_7_4, var_7_5, var_1_10011)

	setButtonEnabled = var_6

	var_6(var_7_2.commitBtn, var_7_1 > 0)

	local var_7_6 = arg_7_0.cntTxt

	i18n = var_1_10007
	var_7_6.text = var_1_10007("guild_left_donate_cnt", var_7_1)

	return
end

function var_0_1.OnDestroy(arg_10_0)
	return
end

return var_0_1

local var_0_0 = class("PublicGuildOfficePage", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "PublicGuildDonateBluePage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.itemList = UIItemList.New(arg_2_0._tf:Find("frame/donate_panel/list"), arg_2_0._tf:Find("frame/donate_panel/list/tpl"))
	arg_2_0.cntTxt = arg_2_0._tf:Find("frame/donate_panel/cnt/Text"):GetComponent(typeof(Text))

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.cards = {}

	arg_3_0.itemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			arg_3_0:UpdateDonateTask(arg_4_2, arg_3_0.displays[arg_4_1 + 1])
		end

		return
	end)

	return
end

function var_0_0.Show(arg_5_0, arg_5_1)
	arg_5_0.guild = arg_5_1

	arg_5_0:Flush()
	var_0_0.super.Show(arg_5_0)

	return
end

function var_0_0.Flush(arg_6_0)
	arg_6_0.displays = arg_6_0.guild:GetDonateTasks()

	arg_6_0.itemList:align(#arg_6_0.displays)
	pg.GuildPaintingMgr.GetInstance():Update("guild_office_blue", Vector3(-737, -171, 0))

	return
end

function var_0_0.UpdateDonateTask(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.guild:GetRemainDonateCnt()
	local var_7_1 = arg_7_0.cards[arg_7_1]

	if not arg_7_0.cards[arg_7_1] then
		var_7_1 = GuildDonateCard.New(arg_7_1)
		arg_7_0.cards[arg_7_1] = var_7_1
	end

	var_7_1:update(arg_7_2)
	onButton(arg_7_0, var_7_1.commitBtn, function()
		local var_8_0 = var_7_1.dtask:getCommitItem()
		local var_8_1 = Drop.Create(var_8_0)
		local var_8_2 = var_7_1:GetResCntByAward(var_8_0)

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("guild_donate_tip", var_8_1:getConfig("name"), var_8_0[3], var_8_2, var_8_2 < var_8_0[3] and "#FF5C5CFF" or "#92FC63FF"),
			onYes = function()
				arg_7_0:emit(PublicGuildMainMediator.ON_COMMIT, var_0.id)

				return
			end
		})

		return
	end, SFX_PANEL)
	setButtonEnabled(var_7_1.commitBtn, var_7_0 > 0)

	arg_7_0.cntTxt.text = i18n("guild_left_donate_cnt", var_7_0)

	return
end

function var_0_0.OnDestroy(arg_10_0)
	return
end

return var_0_0

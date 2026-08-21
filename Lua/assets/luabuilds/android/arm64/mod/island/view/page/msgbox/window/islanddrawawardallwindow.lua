local var_0_0 = class("IslandDrawAwardAllWindow", import("Mod.Island.View.page.msgbox.window.IslandBaseMsgboxWindow"))

function var_0_0.getUIName(arg_1_0)
	return "IslandDrawAwardAllMsgBox"
end

function var_0_0.OnInit(arg_2_0)
	setText(arg_2_0.rtTitle, i18n("island_draw_reward"))
	onButton(arg_2_0, arg_2_0.btnClose, function()
		arg_2_0:Hide()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.OnShow(arg_4_0)
	var_0_0.super.OnShow(arg_4_0)
	arg_4_0:UpdateActivity(arg_4_0.settings.activity)

	return
end

function var_0_0.UpdateActivity(arg_5_0, arg_5_1)
	arg_5_0.activity = arg_5_1

	eachChild(arg_5_0.rtRarities, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_5_0.activity:GetRankList(arg_6_0.name)

		setText(arg_6_0:Find("title/Text"), i18n("island_draw_" .. arg_6_0.name))
		UIItemList.StaticAlign(arg_6_0:Find("container"), arg_6_0:Find("container/tpl"), #arg_5_0.activity:GetRankList(arg_6_0.name), function(arg_7_0, arg_7_1, arg_7_2)
			arg_7_1 = arg_7_1 + 1

			if arg_7_0 == UIItemList.EventUpdate then
				local var_7_0, var_7_1 = unpack(var_6_0[arg_7_1])
				local var_7_2 = Drop.New({
					type = pg.island_draw_reward[var_7_0].drop_type,
					id = pg.island_draw_reward[var_7_0].drop_id
				})

				IslandShopDrawAwardPage.ShowDropInfo(var_7_2, arg_7_2:Find("mask/Image"))
				setScrollText(arg_7_2:Find("name/Text"), var_7_2:getName())
				setText(arg_7_2:Find("got/got/Text"), i18n("island_draw_get"))
				setActive(arg_7_2:Find("got"), not var_7_1)
			end

			return
		end)

		return
	end)

	return
end

return var_0_0

local var_0_0 = class("GuildAppiontPage", import(".GuildMemberBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "GuildAppiontPage"
end

local var_0_1 = {
	"commander",
	"deputyCommander",
	"picked",
	"normal"
}

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.OnLoaded(arg_2_0)

	arg_2_0.dutyContainer = arg_2_0._tf:Find("frame/duty")
	arg_2_0.print = arg_2_0._tf:Find("frame/prints/print"):GetComponent(typeof(Image))
	arg_2_0.confirmBtn = arg_2_0._tf:Find("frame/confirm_btn")
	arg_2_0.nameTF = arg_2_0._tf:Find("frame/info/name/Text"):GetComponent(typeof(Text))
	arg_2_0.iconTF = arg_2_0._tf:Find("frame/info/shipicon/icon"):GetComponent(typeof(Image))
	arg_2_0.starsTF = arg_2_0._tf:Find("frame/info/shipicon/stars")
	arg_2_0.starTF = arg_2_0._tf:Find("frame/info/shipicon/stars/star")
	arg_2_0.levelTF = arg_2_0._tf:Find("frame/info/level/Text"):GetComponent(typeof(Text))
	arg_2_0.circle = arg_2_0._tf:Find("frame/info/shipicon/frame")
	arg_2_0.toggles = arg_2_0._tf:Find("frame/duty"):GetComponent(typeof(ToggleGroup))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.ShouldShow(arg_5_0)
	return arg_5_0.memberVO.id ~= arg_5_0.playerVO.id
end

function var_0_0.OnShow(arg_6_0)
	local var_6_0 = arg_6_0.memberVO
	local var_6_2 = arg_6_0.guildVO:getDutyByMemberId(arg_6_0.playerVO.id)
	local var_6_3 = arg_6_0.guildVO:getEnableDuty(var_6_2, arg_6_0.memberVO.duty)
	local var_6_4 = arg_6_0.guildVO:getAssistantMaxCount()
	local var_6_5 = arg_6_0.guildVO:getAssistantCount()
	local var_6_6

	for iter_6_0, iter_6_1 in ipairs(var_0_1) do
		local var_6_7 = arg_6_0.dutyContainer:Find(iter_6_1)
		local var_6_8 = var_6_7:Find("Text")
		local var_6_9 = false

		if var_6_0.duty == iter_6_0 then
			setText(var_6_8, i18n("guild_duty_tip_1"))

			var_6_9 = true
		elseif not table.contains(var_6_3, iter_6_0) then
			if var_6_4 <= var_6_5 and iter_6_0 == 2 then
				setText(var_6_8, i18n("guild_deputy_commander_cnt_is_full"))
			else
				setText(var_6_8, i18n("guild_duty_tip_2"))
			end

			var_6_9 = true
		end

		setActive(var_6_8, not table.contains(var_6_3, iter_6_0))

		if var_6_2 == GuildConst.DUTY_COMMANDER and iter_6_0 == 2 and not var_6_9 then
			if var_6_4 <= var_6_5 then
				setText(var_6_8, i18n("guild_deputy_commander_cnt_is_full"))
			else
				setText(var_6_8, i18n("guild_deputy_commander_cnt", var_6_5, var_6_4))
			end

			setActive(var_6_8, true)
		end

		setToggleEnabled(var_6_7, table.contains(var_6_3, iter_6_0))
		onToggle(arg_6_0, var_6_7, function(arg_7_0)
			if arg_7_0 then
				var_6_6 = iter_6_0
				arg_6_0.selectedToggle = var_6_7
			end

			return
		end, SFX_PANEL)
	end

	local var_6_10 = arg_6_0.dutyContainer:Find("commander/Image2")

	if var_6_2 == GuildConst.DUTY_COMMANDER and var_6_0.duty > GuildConst.DUTY_DEPUTY_COMMANDER then
		onButton(arg_6_0, var_6_10, function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_duty_shoule_be_deputy_commander"))

			return
		end, SFX_PANEL)
	else
		local var_6_11 = var_6_10:GetComponent(typeof(Button))

		if not IsNil(var_6_11) then
			Object.Destroy(var_6_11)
		end
	end

	local var_6_12 = var_6_1:getFaction()

	if var_6_12 == GuildConst.FACTION_TYPE_BLHX then
		arg_6_0.print.color = Color.New(0.4235294117647059, 0.6313725490196078, 0.9568627450980393)
	elseif var_6_12 == GuildConst.FACTION_TYPE_CSZZ then
		arg_6_0.print.color = Color.New(0.9568627450980393, 0.44313725490196076, 0.42745098039215684)
	end

	arg_6_0.nameTF.text = var_6_0.name

	local var_6_13 = var_6_0.id == getProxy(PlayerProxy):getRawData().id
	local var_6_14 = AttireFrame.attireFrameRes(var_6_0, var_6_13, AttireConst.TYPE_ICON_FRAME, var_6_0.propose)

	PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_6_14, var_6_14, true, function(arg_9_0)
		if IsNil(arg_6_0._tf) then
			return
		end

		if arg_6_0.circle then
			arg_9_0.name = var_6_14
			findTF(arg_9_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

			setParent(arg_9_0, arg_6_0.circle, false)
		else
			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_6_14, var_6_14, arg_9_0)
		end

		return
	end)

	local var_6_15 = pg.ship_data_statistics[var_6_0.icon]

	LoadSpriteAsync("qicon/" .. Ship.New({
		configId = var_6_0.icon,
		skin_id = var_6_0.skinId
	}):getPainting(), function(arg_10_0)
		if not IsNil(arg_6_0.iconTF) then
			arg_6_0.iconTF.sprite = arg_10_0
		end

		return
	end)

	for iter_6_2 = arg_6_0.starsTF.childCount, var_6_15.star - 1 do
		cloneTplTo(arg_6_0.starTF, arg_6_0.starsTF)
	end

	for iter_6_3 = 1, arg_6_0.starsTF.childCount do
		setActive(arg_6_0.starsTF:GetChild(iter_6_3 - 1), iter_6_3 <= var_6_15.star)
	end

	arg_6_0.levelTF.text = "Lv." .. var_6_0.level

	onButton(arg_6_0, arg_6_0.confirmBtn, function()
		if var_6_2 == GuildConst.DUTY_COMMANDER and var_6_6 == GuildConst.DUTY_COMMANDER then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("guild_transfer_president_confirm", var_6_0.name),
				onYes = function()
					arg_6_0:emit(GuildMemberMediator.SET_DUTY, var_6_0.id, var_6_6)
					arg_6_0:Hide()

					return
				end
			})
		else
			(function()
				arg_6_0:emit(GuildMemberMediator.SET_DUTY, var_6_0.id, var_6_6)
				arg_6_0:Hide()

				return
			end)()
		end

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.Hide(arg_13_0)
	arg_13_0.toggles:SetAllTogglesOff()
	var_0_0.super.Hide(arg_13_0)

	return
end

return var_0_0

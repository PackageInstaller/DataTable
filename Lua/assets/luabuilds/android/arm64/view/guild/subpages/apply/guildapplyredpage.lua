local var_0_0 = class("GuildApplyRedPage", import("....base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "GuildApplyRedUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.iconTF = findTF(arg_2_0._tf, "panel/frame/policy_container/input_frame/shipicon/icon"):GetComponent(typeof(Image))
	arg_2_0.circle = findTF(arg_2_0._tf, "panel/frame/policy_container/input_frame/shipicon/frame")
	arg_2_0.manifesto = findTF(arg_2_0._tf, "panel/frame/policy_container/input_frame/Text"):GetComponent(typeof(Text))
	arg_2_0.starsTF = findTF(arg_2_0._tf, "panel/frame/policy_container/input_frame/shipicon/stars")
	arg_2_0.starTF = findTF(arg_2_0._tf, "panel/frame/policy_container/input_frame/shipicon/stars/star")
	arg_2_0.applyBtn = findTF(arg_2_0._tf, "panel/frame/confirm_btn")
	arg_2_0.cancelBtn = findTF(arg_2_0._tf, "panel/frame/cancel_btn")
	arg_2_0.nameTF = findTF(arg_2_0._tf, "panel/frame/name"):GetComponent(typeof(Text))
	arg_2_0.levelTF = findTF(arg_2_0._tf, "panel/frame/info/level/Text"):GetComponent(typeof(Text))
	arg_2_0.countTF = findTF(arg_2_0._tf, "panel/frame/info/count/Text"):GetComponent(typeof(Text))
	arg_2_0.flagName = findTF(arg_2_0._tf, "panel/frame/policy_container/name/Text"):GetComponent(typeof(Text))
	arg_2_0.policyTF = findTF(arg_2_0._tf, "panel/frame/policy_container/policy/Text"):GetComponent(typeof(Text))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.applyBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			yesText = "text_confirm",
			limit = 20,
			type = MSGBOX_TYPE_INPUT,
			placeholder = i18n("guild_request_msg_placeholder"),
			title = i18n("guild_request_msg_title"),
			onYes = function(arg_5_0)
				arg_3_0:emit(JoinGuildMediator.APPLY, arg_3_0.guildVO.id, arg_5_0)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.cancelBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_7_0, arg_7_1)
	arg_7_0.guildVO = arg_7_1

	arg_7_0:UpdateApplyPanel()
	pg.UIMgr.GetInstance():BlurPanel(arg_7_0._tf)
	var_0_0.super.Show(arg_7_0)

	return
end

function var_0_0.UpdateApplyPanel(arg_8_0)
	local var_8_0 = Ship.New({
		configId = arg_8_0.guildVO:getCommader().icon
	})

	LoadSpriteAsync("QIcon/" .. var_8_0:getPainting(), function(arg_9_0)
		arg_8_0.iconTF.sprite = arg_9_0

		return
	end)

	local var_8_1 = pg.ship_data_statistics[var_8_0.configId]

	arg_8_0.manifesto.text = arg_8_0.guildVO.manifesto

	for iter_8_0 = arg_8_0.starsTF.childCount, var_8_1.star - 1 do
		cloneTplTo(arg_8_0.starTF, arg_8_0.starsTF)
	end

	for iter_8_1 = 1, arg_8_0.starsTF.childCount do
		setActive(arg_8_0.starsTF:GetChild(iter_8_1 - 1), iter_8_1 <= var_8_1.star)
	end

	arg_8_0.nameTF.text = arg_8_0.guildVO.name

	local var_8_2 = arg_8_0.levelTF

	if arg_8_0.guildVO.level < 9 then
		var_8_2.text = "0" .. arg_8_0.guildVO.level or arg_8_0.guildVO.level
		arg_8_0.countTF.text = arg_8_0.guildVO.memberCount .. "/" .. arg_8_0.guildVO:getMaxMember()
		arg_8_0.flagName.text = arg_8_0.guildVO:getCommader().name
		arg_8_0.policyTF.text = arg_8_0.guildVO:getPolicyName()

		local var_8_3 = arg_8_0.guildVO:getCommader()
		local var_8_4 = var_8_3.id == getProxy(PlayerProxy):getRawData().id
		local var_8_5 = AttireFrame.attireFrameRes(var_8_3, var_8_4, AttireConst.TYPE_ICON_FRAME, var_8_3.propose)

		PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_8_5, var_8_5, true, function(arg_10_0)
			if IsNil(arg_8_0._tf) then
				return
			end

			if arg_8_0.circle then
				arg_10_0.name = var_8_5
				findTF(arg_10_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

				setParent(arg_10_0, arg_8_0.circle, false)
			else
				PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_8_5, var_8_5, arg_10_0)
			end

			return
		end)

		return
	end
end

function var_0_0.Hide(arg_11_0)
	var_0_0.super.Hide(arg_11_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_11_0._tf, arg_11_0._parentTf)

	if arg_11_0.circle.childCount > 0 then
		local var_11_0 = arg_11_0.circle:GetChild(0).gameObject

		PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_11_0.name, var_11_0.name, var_11_0)
	end

	return
end

function var_0_0.OnDestroy(arg_12_0)
	if arg_12_0:isShowing() then
		arg_12_0:Hide()
	end

	return
end

return var_0_0

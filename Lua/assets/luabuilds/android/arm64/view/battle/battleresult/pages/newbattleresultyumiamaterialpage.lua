local var_0_0 = class("NewBattleResultYumiaMaterialPage", import("view.base.BaseSubView"))

var_0_0.YUMIA_MATERIAL_DROP_TYPE_LIST = {
	DROP_TYPE_RYZA_DROP
}

function var_0_0.NeedShowYumiaMaterailDrop(arg_1_0)
	if not arg_1_0 then
		return false
	end

	for iter_1_0, iter_1_1 in ipairs(arg_1_0) do
		if table.contains(var_0_0.YUMIA_MATERIAL_DROP_TYPE_LIST, iter_1_1.type) then
			return true
		end
	end

	return false
end

function var_0_0.getUIName(arg_2_0)
	return "NewBattleResultYumiaRewardPages"
end

function var_0_0.OnLoaded(arg_3_0)
	arg_3_0.parentTr = arg_3_0._tf.parent
	arg_3_0.itemContainer = arg_3_0._tf:Find("item/container")
	arg_3_0.itemTpl = arg_3_0._tf:Find("item/tpl")
	arg_3_0.confirmBtn = arg_3_0._tf:Find("confirm_btn")
	arg_3_0.lineTxt = arg_3_0._tf:Find("words/text")

	setText(arg_3_0.confirmBtn:Find("text"), i18n("word_ok"))

	return
end

function var_0_0.SetUp(arg_4_0, arg_4_1)
	arg_4_0:Show()
	seriesAsync({
		function(arg_5_0)
			arg_4_0:playAnima("Anim_NewBattleResultYumiaRewardPages_In")
			arg_4_0:UpdateItem()
			arg_4_0:UpdateLine()
			arg_4_0:RegisterEvent(arg_5_0)

			return
		end
	}, function()
		arg_4_0:Clear()
		arg_4_0:Destroy()
		arg_4_1()

		return
	end)

	return
end

function var_0_0.Show(arg_7_0)
	var_0_0.super.Show(arg_7_0)

	arg_7_0.parentTr:GetComponent(typeof(Image)).enabled = false

	SetActive(arg_7_0.parentTr:Find("Effect"), false)

	return
end

function var_0_0.dropFilter(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0) do
		if table.contains(var_0_0.YUMIA_MATERIAL_DROP_TYPE_LIST, iter_8_1.type) then
			table.insert({}, iter_8_1)
		end
	end

	return {}
end

function var_0_0.playAnima(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._tf:GetComponent(typeof(Animation)):Play(arg_9_1)
	arg_9_0._tf:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		arg_9_2()

		return
	end)

	return
end

function var_0_0.UpdateItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.contextData.drops
	local var_11_1

	if not arg_11_0.contextData.drops then
		var_11_0 = {}
		var_11_1 = {}
	end

	for iter_11_0, iter_11_1 in ipairs((var_0_0.dropFilter(var_11_0))) do
		for iter_11_2 = 1, iter_11_1.count do
			local var_11_2 = Drop.New({
				count = 1,
				type = iter_11_1.type,
				id = iter_11_1.id
			})
			local var_11_3 = cloneTplTo(arg_11_0.itemTpl, arg_11_0.itemContainer)

			setActive(var_11_3, false)
			table.insert({}, var_11_3)
			updateDrop(var_11_3:Find("IconTpl"), var_11_2)
		end
	end

	local var_11_4 = 1

	arg_11_0.timer = Timer.New(function()
		setActive(var_11_1[var_11_4], true)
		var_11_1[var_11_4]:GetComponent(typeof(Animation)):Play("Anim_NewBattleResultYumiaRewardPages_Tpl_In")

		var_11_4 = var_11_4 + 1

		return
	end, 0.08, #{})

	arg_11_0.timer:Start()

	return
end

function var_0_0.UpdateLine(arg_13_0)
	local var_13_0 = arg_13_0.contextData.drops or {}
	local var_13_1 = var_0_0.dropFilter(var_13_0)
	local var_13_2 = AtelierMaterial.New({
		configId = var_13_1[math.random(#var_13_1)].id
	}):GetVoices()

	if var_13_2 and #var_13_2 > 0 then
		local var_13_3 = var_13_2[math.random(#var_13_2)]
		local var_13_4, var_13_5, var_13_6 = ShipWordHelper.GetWordAndCV(var_13_3[1], var_13_3[2], nil, PLATFORM_CODE ~= PLATFORM_US)

		if var_13_5 then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_13_5)
		end

		setText(arg_13_0.lineTxt, var_13_6)
	end

	return
end

function var_0_0.RegisterEvent(arg_14_0, arg_14_1)
	if arg_14_0.exited then
		return
	end

	local function var_14_0()
		arg_14_0:playAnima("Anim_NewBattleResultYumiaRewardPages_Out", arg_14_1)

		return
	end

	onButton(arg_14_0, arg_14_0._tf, function()
		arg_14_0:playAnima("Anim_NewBattleResultYumiaRewardPages_Out", arg_14_1)

		return
	end, SFX_PANEL)
	onButton(arg_14_0, arg_14_0.confirmBtn, var_14_0, SFX_PANEL)

	if arg_14_0.contextData.autoSkipFlag then
		triggerButton(arg_14_0._tf)
	end

	return
end

function var_0_0.Clear(arg_16_0)
	removeOnButton(arg_16_0._tf)
	removeOnButton(arg_16_0.confirmBtn)

	return
end

function var_0_0.OnDestroy(arg_17_0)
	arg_17_0.exited = true

	if arg_17_0:isShowing() then
		arg_17_0:Hide()
	end

	if arg_17_0.timer then
		arg_17_0.timer:Stop()
	end

	arg_17_0.parentTr:GetComponent(typeof(Image)).enabled = true

	SetActive(arg_17_0.parentTr:Find("Effect"), true)

	return
end

return var_0_0

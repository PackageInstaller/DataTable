local var_0_0 = class("MainBuffView", import("...base.MainBaseView"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.buffs = {
		arg_1_1:Find("buff").gameObject
	}
	arg_1_0.skinFreeUsageTag = nil
	arg_1_0.timers = {}
	arg_1_0.buffOffsetX = 20
	arg_1_0.noTagStartPos = 285
	arg_1_0.hasTagStartPos = 390
	arg_1_0.tagPos = Vector3(-169, -18, 0)

	arg_1_0:bind(MiniGameProxy.ON_HUB_DATA_UPDATE, function(arg_2_0)
		arg_1_0:Refresh()

		return
	end)
	arg_1_0:bind(GAME.SEND_MINI_GAME_OP_DONE, function(arg_3_0)
		arg_1_0:Refresh()

		return
	end)

	return
end

function var_0_0.CollectBuffs(arg_4_0)
	local var_4_0 = BuffHelper.GetBuffsForMainUI()
	local var_4_1 = import("GameCfg.activity.MainUIVirtualIconData")

	for iter_4_0, iter_4_1 in ipairs(var_4_1.CurrentIconList) do
		if var_4_1[iter_4_1]:CheckExist() then
			table.insert(var_4_0, var_4_1[iter_4_1])
		end
	end

	return var_4_0
end

function var_0_0.Init(arg_5_0)
	local var_5_0 = arg_5_0:CollectBuffs()
	local var_5_1 = arg_5_0:ShouldFreeUsageSkinTag()
	local var_5_2 = arg_5_0._tf

	if var_5_1 then
		local var_5_4 = arg_5_0.hasTagStartPos or arg_5_0.noTagStartPos

		var_5_2.anchoredPosition = var_5_3(var_5_4, arg_5_0._tf.anchoredPosition.y, 0)

		if var_5_1 then
			arg_5_0:UpdateFreeUsageSkinTag()
		elseif arg_5_0.skinFreeUsageTag then
			setActive(arg_5_0.skinFreeUsageTag, false)
		end

		arg_5_0:ClearTimers()
		arg_5_0:UpdateBuffs(var_5_0)

		arg_5_0.buffList = var_5_0
		arg_5_0.showTag = var_5_1

		return
	end
end

function var_0_0.Refresh(arg_6_0)
	local var_6_0 = arg_6_0:CollectBuffs()
	local var_6_1 = arg_6_0:ShouldFreeUsageSkinTag()

	arg_6_0:Init()

	return
end

function var_0_0.ShouldFreeUsageSkinTag(arg_7_0)
	for iter_7_0, iter_7_1 in pairs((getProxy(ShipSkinProxy):getRawData())) do
		if iter_7_1:isExpireType() and not iter_7_1:isExpired() then
			return true
		end
	end

	return false
end

function var_0_0.UpdateFreeUsageSkinTag(arg_8_0)
	local var_8_0 = arg_8_0.skinFreeUsageTag or Object.Instantiate(arg_8_0.buffs[1], arg_8_0.buffs[1].transform.parent).transform

	arg_8_0.skinFreeUsageTag = var_8_0

	local var_8_1 = var_8_0:GetComponent(typeof(Image))

	var_8_1.sprite = GetSpriteFromAtlas("ui/mainui_atlas", "huanzhuangtiyan")

	var_8_1:SetNativeSize()
	onButton(arg_8_0, var_8_0, function()
		arg_8_0:emit(NewMainScene.ON_SKIN_FREEUSAGE_DESC, (arg_8_0:GetFreeUsageSkins()))

		return
	end, SFX_PANEL)

	var_8_0.anchoredPosition = arg_8_0.tagPos

	setActive(arg_8_0.skinFreeUsageTag, true)

	return
end

function var_0_0.GetFreeUsageSkins(arg_10_0)
	for iter_10_0, iter_10_1 in pairs((getProxy(ShipSkinProxy):getRawData())) do
		if iter_10_1:isExpireType() and not iter_10_1:isExpired() then
			table.insert({}, iter_10_1)
		end
	end

	return {}
end

function var_0_0.GetTpl(arg_11_0, arg_11_1)
	if not arg_11_0.buffs[arg_11_1] then
		local var_11_0 = Object.Instantiate(arg_11_0.buffs[1], arg_11_0.buffs[1].transform.parent)

		var_11_0.transform.anchoredPosition = Vector3(arg_11_0.buffs[1].transform.anchoredPosition.x + (arg_11_1 - 1) * (arg_11_0.buffs[1].transform.sizeDelta.x + arg_11_0.buffOffsetX), arg_11_0.buffs[1].transform.anchoredPosition.y, 0)
		arg_11_0.buffs[arg_11_1] = var_11_0
	end

	return arg_11_0.buffs[arg_11_1]
end

function var_0_0.UpdateBuffs(arg_12_0, arg_12_1)
	for iter_12_0 = #arg_12_0.buffs, #arg_12_1 + 1, -1 do
		if arg_12_0.buffs[iter_12_0] then
			setActive(arg_12_0.buffs[iter_12_0], false)
		end
	end

	for iter_12_1, iter_12_2 in ipairs(arg_12_1) do
		local var_12_0 = arg_12_0:GetTpl(iter_12_1)

		if iter_12_2.IsVirtualIcon then
			arg_12_0:UpdateVirtualBuff(var_12_0, iter_12_2)
		else
			arg_12_0:UpdateBuff(var_12_0, iter_12_2)
			arg_12_0:AddEndTimer(var_12_0, iter_12_2)
		end
	end

	return
end

function var_0_0.UpdateVirtualBuff(arg_13_0, arg_13_1, arg_13_2)
	LoadImageSpriteAtlasAsync("ui/mainui_atlas", arg_13_2.Image, arg_13_1)
	onButton(arg_13_0, arg_13_1, function()
		arg_13_0.buffDesMsgbox = arg_13_0.buffDesMsgbox or MainBuffDesMsgbox.New(pg.UIMgr.GetInstance().UIMain)

		arg_13_0.buffDesMsgbox:ExecuteAction("Show", ActivityConst.DOA_PT_ID)

		return
	end, SFX_PANEL)
	setActive(arg_13_1, true)

	return
end

function var_0_0.UpdateBuff(arg_15_0, arg_15_1, arg_15_2)
	LoadImageSpriteAsync(arg_15_2:getConfig("icon"), arg_15_1)
	onButton(arg_15_0, arg_15_1, function()
		local var_16_0 = pg.UIMgr.GetInstance().UIMain:InverseTransformPoint(arg_15_1.transform.position)

		arg_15_0:emit(NewMainScene.ON_BUFF_DESC, arg_15_2, Vector3(var_16_0.x, var_16_0.y - 55, 0))

		return
	end, SFX_PANEL)
	setActive(arg_15_1, true)

	return
end

function var_0_0.AddEndTimer(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.timers[arg_17_1] = Timer.New(function()
		setActive(arg_17_1, false)

		return
	end, arg_17_2:getLeftTime(), 1)

	arg_17_0.timers[arg_17_1]:Start()

	return
end

function var_0_0.ClearTimers(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0.timers) do
		iter_19_1:Stop()
	end

	arg_19_0.timers = {}

	return
end

function var_0_0.GetDirection(arg_20_0)
	return Vector2(0, 1)
end

function var_0_0.Disable(arg_21_0)
	if arg_21_0.buffDesMsgbox then
		arg_21_0.buffDesMsgbox:Destroy()

		arg_21_0.buffDesMsgbox = nil
	end

	return
end

function var_0_0.Dispose(arg_22_0)
	var_0_0.super.Dispose(arg_22_0)

	if arg_22_0.skinFreeUsageTag then
		Destroy(arg_22_0.skinFreeUsageTag.gameObject)

		arg_22_0.skinFreeUsageTag = nil
	end

	arg_22_0:ClearTimers()

	if arg_22_0.buffDesMsgbox then
		arg_22_0.buffDesMsgbox:Destroy()

		arg_22_0.buffDesMsgbox = nil
	end

	return
end

return var_0_0

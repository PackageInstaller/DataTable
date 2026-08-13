class = var_0_10000

local var_0_0 = "MainBuffView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.MainBaseView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.buffs = {
		arg_1_1:Find("buff").gameObject
	}
	arg_1_0.skinFreeUsageTag = nil
	arg_1_0.timers = {}
	arg_1_0.buffOffsetX = 20
	arg_1_0.noTagStartPos = 285
	arg_1_0.hasTagStartPos = 390
	Vector3 = var_3
	arg_1_0.tagPos = var_3(-169, -18, 0)

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	MiniGameProxy = var_6

	var_1_1(var_1_0, var_6.ON_HUB_DATA_UPDATE, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_1.Refresh(var_2_0)

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bind

	GAME = var_6

	var_1_3(var_1_2, var_6.SEND_MINI_GAME_OP_DONE, function(arg_3_0)
		local var_3_0 = arg_1_0

		var_1.Refresh(var_3_0)

		return
	end)

	return
end

function var_0_1.CollectBuffs(arg_4_0)
	BuffHelper = var_1_10001

	local var_4_0 = var_1_10001.GetBuffsForMainUI()

	import = var_1_10002

	local var_4_1 = var_1_10002("GameCfg.activity.MainUIVirtualIconData")

	ipairs = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10003(var_4_1.CurrentIconList) do
		local var_4_2 = var_4_1[iter_4_1]

		if var_8.CheckExist(var_4_2) then
			table = var_8

			var_8.insert(var_4_0, var_4_1[iter_4_1])
		end
	end

	return var_4_0
end

function var_0_1.Init(arg_5_0)
	local var_5_0 = arg_5_0:CollectBuffs()
	local var_5_1 = arg_5_0
	local var_5_2 = arg_5_0.ShouldFreeUsageSkinTag(var_5_1)
	local var_5_3 = arg_5_0._tf

	Vector3 = var_5_1

	local var_5_4

	if not var_5_2 or not arg_5_0.hasTagStartPos then
		var_5_4 = arg_5_0.noTagStartPos
	end

	var_5_3.anchoredPosition = var_5_1(var_5_4, arg_5_0._tf.anchoredPosition.y, 0)

	if var_5_2 then
		arg_5_0:UpdateFreeUsageSkinTag()
	elseif arg_5_0.skinFreeUsageTag then
		setActive = var_3

		var_3(arg_5_0.skinFreeUsageTag, false)
	end

	arg_5_0:ClearTimers()
	arg_5_0:UpdateBuffs(var_5_0)

	arg_5_0.buffList = var_5_0
	arg_5_0.showTag = var_5_2

	return
end

function var_0_1.Refresh(arg_6_0)
	local var_6_0 = arg_6_0:CollectBuffs()
	local var_6_1 = arg_6_0:ShouldFreeUsageSkinTag()

	arg_6_0:Init()

	return
end

function var_0_1.ShouldFreeUsageSkinTag(arg_7_0)
	getProxy = var_1_10001
	ShipSkinProxy = var_1_10003

	local var_7_0 = var_1_10001(var_1_10003)
	local var_7_1 = var_1.getRawData(var_7_0)

	pairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(var_7_1) do
		if iter_7_1:isExpireType() and not iter_7_1:isExpired() then
			return true
		end
	end

	return false
end

function var_0_1.UpdateFreeUsageSkinTag(arg_8_0)
	local var_8_0

	if not arg_8_0.skinFreeUsageTag then
		Object = var_8_0
		var_8_0 = var_8_0.Instantiate(arg_8_0.buffs[1], arg_8_0.buffs[1].transform.parent).transform
	end

	arg_8_0.skinFreeUsageTag = var_8_0
	GetSpriteFromAtlas = var_1_10002

	local var_8_1 = var_1_10002("ui/mainui_atlas", "huanzhuangtiyan")
	local var_8_2 = var_8_0
	local var_8_3 = var_8_0.GetComponent

	typeof = var_1_10006
	Image = var_1_10008

	local var_8_4 = var_8_3(var_8_2, var_1_10006(var_1_10008))

	var_8_4.sprite = var_8_1

	var_8_4:SetNativeSize()

	onButton = var_4

	local var_8_5 = arg_8_0
	local var_8_6 = var_8_0

	local function var_8_7()
		local var_9_0 = arg_8_0
		local var_9_1 = var_0.GetFreeUsageSkins(var_9_0)
		local var_9_2 = arg_8_0
		local var_9_3 = var_1.emit

		NewMainScene = var_2_10004

		var_9_3(var_9_2, var_2_10004.ON_SKIN_FREEUSAGE_DESC, var_9_1)

		return
	end

	SFX_PANEL = var_1_10009

	var_4(var_8_5, var_8_6, var_8_7, var_1_10009)

	var_8_0.anchoredPosition = arg_8_0.tagPos
	setActive = var_4

	var_4(arg_8_0.skinFreeUsageTag, true)

	return
end

function var_0_1.GetFreeUsageSkins(arg_10_0)
	local var_10_0 = {}

	getProxy = var_1_10002
	ShipSkinProxy = var_1_10004

	local var_10_1 = var_1_10002(var_1_10004)
	local var_10_2 = var_2.getRawData(var_10_1)

	pairs = var_1_10003

	for iter_10_0, iter_10_1 in var_1_10003(var_10_2) do
		if iter_10_1:isExpireType() and not iter_10_1:isExpired() then
			table = var_8

			var_8.insert(var_10_0, iter_10_1)
		end
	end

	return var_10_0
end

function var_0_1.GetTpl(arg_11_0, arg_11_1)
	if not arg_11_0.buffs[arg_11_1] then
		local var_11_0 = arg_11_0.buffs[1]

		Object = var_1_10003

		local var_11_1 = var_1_10003.Instantiate(var_11_0, var_11_0.transform.parent)
		local var_11_2 = var_11_0.transform.anchoredPosition.x + (arg_11_1 - 1) * (var_11_0.transform.sizeDelta.x + arg_11_0.buffOffsetX)
		local var_11_3 = var_11_1.transform

		Vector3 = var_6
		var_11_3.anchoredPosition = var_6(var_11_2, var_11_0.transform.anchoredPosition.y, 0)
		arg_11_0.buffs[arg_11_1] = var_11_1
	end

	return arg_11_0.buffs[arg_11_1]
end

function var_0_1.UpdateBuffs(arg_12_0, arg_12_1)
	for iter_12_0 = #arg_12_0.buffs, #arg_12_1 + 1, -1 do
		if arg_12_0.buffs[iter_12_0] then
			setActive = var_6

			var_6(arg_12_0.buffs[iter_12_0], false)
		end
	end

	ipairs = var_2

	for iter_12_1, iter_12_2 in var_2(arg_12_1) do
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

function var_0_1.UpdateVirtualBuff(arg_13_0, arg_13_1, arg_13_2)
	LoadImageSpriteAtlasAsync = var_1_10003

	var_1_10003("ui/mainui_atlas", arg_13_2.Image, arg_13_1)

	onButton = var_1_10003

	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_1

	local function var_13_2()
		local var_14_0 = arg_13_0
		local var_14_1

		if not arg_13_0.buffDesMsgbox then
			MainBuffDesMsgbox = var_14_1
			var_14_1 = var_14_1.New
			pg = var_2_10003
			var_14_1 = var_14_1(var_2_10003.UIMgr.GetInstance().UIMain)
		end

		var_14_0.buffDesMsgbox = var_14_1

		local var_14_2 = arg_13_0.buffDesMsgbox
		local var_14_3 = var_0.ExecuteAction
		local var_14_4 = "Show"

		ActivityConst = var_2_10004

		var_14_3(var_14_2, var_14_4, var_2_10004.DOA_PT_ID)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_13_0, var_13_1, var_13_2, var_1_10008)

	setActive = var_1_10003

	var_1_10003(arg_13_1, true)

	return
end

function var_0_1.UpdateBuff(arg_15_0, arg_15_1, arg_15_2)
	LoadImageSpriteAsync = var_1_10003

	var_1_10003(arg_15_2:getConfig("icon"), arg_15_1)

	onButton = var_1_10003

	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_1

	local function var_15_2()
		pg = var_2_10000

		local var_16_0 = var_2_10000.UIMgr.GetInstance().UIMain
		local var_16_1 = var_0.InverseTransformPoint(var_16_0, arg_15_1.transform.position)
		local var_16_2 = arg_15_0
		local var_16_3 = var_1.emit

		NewMainScene = var_2_10004

		local var_16_4 = var_2_10004.ON_BUFF_DESC
		local var_16_5 = arg_15_2

		Vector3 = var_2_10006

		var_16_3(var_16_2, var_16_4, var_16_5, var_2_10006(var_16_1.x, var_16_1.y - 55, 0))

		return
	end

	SFX_PANEL = var_8

	var_1_10003(var_15_0, var_15_1, var_15_2, var_8)

	setActive = var_1_10003

	var_1_10003(arg_15_1, true)

	return
end

function var_0_1.AddEndTimer(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_2
	local var_17_1 = arg_17_2.getLeftTime(var_17_0)
	local var_17_2 = arg_17_0.timers

	Timer = var_17_0
	var_17_2[arg_17_1] = var_17_0.New(function()
		setActive = var_2_10000

		var_2_10000(arg_17_1, false)

		return
	end, var_17_1, 1)

	local var_17_3 = arg_17_0.timers[arg_17_1]

	var_4.Start(var_17_3)

	return
end

function var_0_1.ClearTimers(arg_19_0)
	pairs = var_1_10001

	for iter_19_0, iter_19_1 in var_1_10001(arg_19_0.timers) do
		iter_19_1:Stop()
	end

	arg_19_0.timers = {}

	return
end

function var_0_1.GetDirection(arg_20_0)
	Vector2 = var_1_10001

	return var_1_10001(0, 1)
end

function var_0_1.Disable(arg_21_0)
	if arg_21_0.buffDesMsgbox then
		local var_21_0 = arg_21_0.buffDesMsgbox

		var_1.Destroy(var_21_0)

		arg_21_0.buffDesMsgbox = nil
	end

	return
end

function var_0_1.Dispose(arg_22_0)
	var_0_1.super.Dispose(arg_22_0)

	if arg_22_0.skinFreeUsageTag then
		Destroy = var_1

		var_1(arg_22_0.skinFreeUsageTag.gameObject)

		arg_22_0.skinFreeUsageTag = nil
	end

	arg_22_0:ClearTimers()

	if arg_22_0.buffDesMsgbox then
		local var_22_0 = arg_22_0.buffDesMsgbox

		var_1.Destroy(var_22_0)

		arg_22_0.buffDesMsgbox = nil
	end

	return
end

return var_0_1

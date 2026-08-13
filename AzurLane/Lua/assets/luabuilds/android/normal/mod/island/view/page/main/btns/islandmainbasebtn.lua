class = var_0_10000

local var_0_0 = var_0_10000("IslandMainBaseBtn")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	pg = var_1_10004

	var_1_10004.DelegateInfo.New(arg_1_0)

	arg_1_0._tf = arg_1_1
	arg_1_0.event = arg_1_2
	arg_1_0.configId = arg_1_3
	pg = var_4
	arg_1_0.config = var_4.island_main_btns[arg_1_0.configId]
	arg_1_0.iconTF = arg_1_0._tf

	local var_1_0 = arg_1_0._tf

	arg_1_0.tipTF = var_4.Find(var_1_0, "tip")

	arg_1_0:Init()

	return
end

function var_0_0.SetAsLastSibling(arg_2_0)
	local var_2_0 = arg_2_0._tf

	var_1.SetAsLastSibling(var_2_0)

	return
end

function var_0_0.Init(arg_3_0)
	LoadImageSpriteAtlasAsync = var_1_10001

	var_1_10001("island/islandbtnicon", arg_3_0.config.icon, arg_3_0.iconTF, true)

	local var_3_0 = arg_3_0._tf

	var_3_0.name = arg_3_0.config.btn_name
	onButton = var_3_0

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0._tf

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.OnClick(var_4_0)

		return
	end

	SFX_PANEL = var_5

	var_3_0(var_3_1, var_3_2, var_3_3, var_5)

	return
end

function var_0_0.GetAbilityId(arg_5_0)
	return arg_5_0.config.ability_id
end

function var_0_0.OnClick(arg_6_0)
	if arg_6_0.config.open_page ~= "" then
		local var_6_0 = arg_6_0
		local var_6_1 = arg_6_0.emit

		IslandMediator = var_1_10003

		var_6_1(var_6_0, var_1_10003.OPEN_PAGE, arg_6_0.config.open_page, arg_6_0.config.page_param)
	end

	return
end

function var_0_0.Flush(arg_7_0)
	arg_7_0:UnlockCheck()
	arg_7_0:TipCheck()

	return
end

function var_0_0.UnlockCheck(arg_8_0)
	setActive = var_1_10001

	var_1_10001(arg_8_0._tf, arg_8_0:IsUnlock())

	return
end

function var_0_0.IsUnlock(arg_9_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_9_0 = var_1_10001(var_1_10002)
	local var_9_1 = var_1.GetIsland(var_9_0)
	local var_9_2 = var_1.GetAblityAgency(var_9_1)

	return var_1.HasAbility(var_9_2, arg_9_0:GetAbilityId())
end

function var_0_0.TipCheck(arg_10_0)
	setActive = var_1_10001

	local var_10_0 = arg_10_0.tipTF
	local var_10_1

	if arg_10_0:IsUnlock() then
		var_10_1 = arg_10_0:IsTip()
	end

	var_1_10001(var_10_0, var_10_1)

	return
end

function var_0_0.IsTip(arg_11_0)
	IslandMainBtnTipHelper = var_1_10001

	return var_1_10001.IsTip(arg_11_0.config.btn_name)
end

function var_0_0.emit(arg_12_0, ...)
	local var_12_0 = arg_12_0.event

	var_1.emit(var_12_0, ...)

	return
end

function var_0_0.Dispose(arg_13_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_13_0)

	return
end

return var_0_0

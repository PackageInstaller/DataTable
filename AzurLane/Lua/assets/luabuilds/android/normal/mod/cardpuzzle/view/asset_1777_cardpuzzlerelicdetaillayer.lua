class = var_0_10000

local var_0_0 = "CardPuzzleRelicDetailLayer"

BaseUI = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002)

function var_0_1.getUIName(arg_1_0)
	return "CardTowerGiftDetailUI"
end

function var_0_1.init(arg_2_0)
	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_3.Find(var_3_1, "BG")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_3_0, var_3_2, var_3_3, var_5)

	local var_3_4 = arg_3_0.contextData.giftData

	setImageSprite = var_3_0

	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_3.Find(var_3_5, "Gift/Icon")

	LoadSprite = var_3_5

	var_3_0(var_3_6, var_3_5(var_3_4:GetIconPath(), ""))

	setText = var_3_0

	local var_3_7 = arg_3_0._tf

	var_3_0(var_3.Find(var_3_7, "Gift/Name"), var_3_4:GetName())

	setText = var_3_0

	local var_3_8 = arg_3_0._tf

	var_3_0(var_3.Find(var_3_8, "Gift/Desc"), var_3_4:GetDesc())

	pg = var_3_0

	local var_3_9 = var_3_0.UIMgr.GetInstance()

	var_2.BlurPanel(var_3_9, arg_3_0._tf)

	return
end

function var_0_1.willExit(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_5_0, arg_5_0._tf)

	return
end

return var_0_1

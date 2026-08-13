pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.GuildLayerMgr = var_0_10001("GuildLayerMgr")
pg = var_0

local var_0_1 = var_0.GuildLayerMgr

function var_0_1.Ctor(arg_1_0)
	pg = var_1_10001
	arg_1_0.overlayMain = var_1_10001.UIMgr.GetInstance().OverlayMain.transform
	GameObject = var_1
	arg_1_0.originLayer = var_1.Find("UICamera/Canvas")
	GameObject = var_1
	arg_1_0.levelGrid = var_1.Find("LevelCamera/Canvas/UIMain/LevelGrid")

	return
end

function var_0_1.Init(arg_2_0, arg_2_1)
	if arg_2_1 then
		arg_2_1()
	end

	return
end

function var_0_1.BlurTopPanel(arg_3_0, arg_3_1)
	if not arg_3_0.topPanel then
		arg_3_0.topPrevParent = arg_3_1.parent
		arg_3_0.topPanel = arg_3_1
	end

	setParent = var_2

	var_2(arg_3_1, arg_3_0.overlayMain)
	arg_3_1:SetAsFirstSibling()

	return
end

function var_0_1._BlurTopPanel(arg_4_0)
	if arg_4_0.topPanel then
		arg_4_0:BlurTopPanel(arg_4_0.topPanel)
	end

	return
end

function var_0_1.OnShowMsgBox(arg_5_0)
	if arg_5_0.topPanel then
		local var_5_0 = arg_5_0.topPanel

		var_1.SetAsFirstSibling(var_5_0)
	end

	return
end

function var_0_1.UnBlurTopPanel(arg_6_0)
	setParent = var_1_10001

	var_1_10001(arg_6_0.topPanel, arg_6_0.originLayer)

	return
end

function var_0_1.Blur(arg_7_0, arg_7_1)
	arg_7_0:UnBlurTopPanel()

	pg = var_2

	local var_7_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_7_0, arg_7_1)
	arg_7_1:SetAsLastSibling()

	return
end

function var_0_1.UnBlur(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:BlurTopPanel(arg_8_0.topPanel)

	pg = var_3

	local var_8_0 = var_3.UIMgr.GetInstance()

	var_3.UnOverlayPanel(var_8_0, arg_8_1, arg_8_2)

	return
end

function var_0_1.BlurForLevel(arg_9_0, arg_9_1)
	setActive = var_1_10002

	var_1_10002(arg_9_0.levelGrid, false)
	arg_9_0:Blur(arg_9_1)

	return
end

function var_0_1.UnBlurForLevel(arg_10_0, arg_10_1, arg_10_2)
	setActive = var_1_10003

	var_1_10003(arg_10_0.levelGrid, true)
	arg_10_0:UnBlur(arg_10_1, arg_10_2)

	return
end

function var_0_1.SetOverlayParent(arg_11_0, arg_11_1, arg_11_2)
	setParent = var_1_10003

	var_1_10003(arg_11_1, arg_11_2 or arg_11_0.overlayMain)

	return
end

function var_0_1.Clear(arg_12_0)
	setParent = var_1_10001

	var_1_10001(arg_12_0.topPanel, arg_12_0.topPrevParent)

	arg_12_0.topPrevParent = nil
	arg_12_0.topPanel = nil

	return
end

return

class = var_0_10000

local var_0_0 = "NewMainSceneBaseTheme"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.OnLoaded(arg_1_0)
	GetOrAddComponent = var_1_10001

	local var_1_0 = arg_1_0._tf

	typeof = var_1_10003
	CanvasGroup = var_1_10004
	arg_1_0.mainCG = var_1_10001(var_1_0, var_1_10003(var_1_10004))
	arg_1_0.mainCG.alpha = 0
	arg_1_0.panels = {
		arg_1_0:GetTopPanel(),
		arg_1_0:GetRightPanel(),
		arg_1_0:GetLeftPanel(),
		arg_1_0:GetBottomPanel()
	}
	arg_1_0.tagView = arg_1_0:GetTagView()
	arg_1_0.iconView = arg_1_0:GetIconView()
	arg_1_0.chatRoomView = arg_1_0:GetChatRoomView()
	arg_1_0.bannerView = arg_1_0:GetBannerView()
	arg_1_0.actBtnView = arg_1_0:GetActBtnView()
	arg_1_0.buffView = arg_1_0:GetBuffView()
	arg_1_0.wordView = arg_1_0:GetWordView()
	arg_1_0.changeView = arg_1_0:GetChangeSkinView()
	arg_1_0.asmrChatView = arg_1_0:GetAsmrChatView()
	arg_1_0.redDotUIList = arg_1_0:RegisterRedDots()

	return
end

function var_0_1.Show(arg_2_0, arg_2_1)
	arg_2_1()
	var_0_1.super.Show(arg_2_0)

	return
end

function var_0_1.PlayEnterAnimation(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0.bannerView

	var_3.Init(var_3_0)

	local var_3_1 = arg_3_0.actBtnView

	var_3.Init(var_3_1)
	arg_3_0:_FoldPanels(true, 0)

	arg_3_0.mainCG.alpha = 1

	arg_3_0:_FoldPanels(false, 0.5)

	onDelayTick = var_3

	var_3(arg_3_2, 0.51)

	return
end

function var_0_1.init(arg_4_0, arg_4_1)
	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0.panels) do
		iter_4_1:Init()
	end

	local var_4_0 = arg_4_0.iconView

	var_2.Init(var_4_0, arg_4_1)

	local var_4_1 = arg_4_0.chatRoomView

	var_2.Init(var_4_1)

	local var_4_2 = arg_4_0.buffView

	var_2.Init(var_4_2)

	local var_4_3 = arg_4_0.tagView

	var_2.Init(var_4_3)

	local var_4_4 = arg_4_0.changeView

	var_2.Init(var_4_4, arg_4_1)

	local var_4_5 = arg_4_0.asmrChatView

	var_2.Init(var_4_5, arg_4_1)
	arg_4_0:OverlayPanel(arg_4_0._tf, {
		stopTop = true,
		pbList = arg_4_0:GetPbList()
	})

	return
end

function var_0_1._FoldPanels(arg_5_0, arg_5_1, arg_5_2)
	ipairs = var_1_10003

	for iter_5_0, iter_5_1 in var_1_10003(arg_5_0.panels) do
		iter_5_1:Fold(arg_5_1, arg_5_2)
	end

	local var_5_0 = arg_5_0.iconView

	var_3.Fold(var_5_0, arg_5_1, arg_5_2)

	local var_5_1 = arg_5_0.chatRoomView

	var_3.Fold(var_5_1, arg_5_1, arg_5_2)

	local var_5_2 = arg_5_0.bannerView

	var_3.Fold(var_5_2, arg_5_1, arg_5_2)

	local var_5_3 = arg_5_0.actBtnView

	var_3.Fold(var_5_3, arg_5_1, arg_5_2)

	local var_5_4 = arg_5_0.buffView

	var_3.Fold(var_5_4, arg_5_1, arg_5_2)

	local var_5_5 = arg_5_0.wordView

	var_3.Fold(var_5_5, arg_5_1, arg_5_2)

	local var_5_6 = arg_5_0.tagView

	var_3.Fold(var_5_6, arg_5_1, arg_5_2)

	local var_5_7 = arg_5_0.changeView

	var_3.Fold(var_5_7, arg_5_1, arg_5_2)

	local var_5_8 = arg_5_0.asmrChatView

	var_3.Fold(var_5_8, arg_5_1, arg_5_2)

	return
end

function var_0_1.OnFoldPanels(arg_6_0, arg_6_1)
	if arg_6_1 then
		var_1_10002 = arg_6_0.mainCG
		var_1_10002.blocksRaycasts = false
	else
		Timer = var_1_10002

		local var_6_0 = var_1_10002.New(function()
			if arg_6_0.mainCG then
				arg_6_0.mainCG.blocksRaycasts = true
			end

			return
		end, 0.5, 1)

		var_2.Start(var_6_0)
	end

	arg_6_0:_FoldPanels(arg_6_1, 0.5)

	return
end

function var_0_1.OnAsmrTurnning(arg_8_0, arg_8_1)
	arg_8_0._asmrTurnning = arg_8_1
	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.panels) do
		iter_8_1:SetAlpha(arg_8_1 and 0 or 1)
		iter_8_1:SetInteractable(not arg_8_1 and true or false)
		iter_8_1:SetBlocksRaycasts(not arg_8_1 and true or false)
	end

	local var_8_0 = arg_8_0.changeView

	var_2.IgnoreParentGroups(var_8_0, arg_8_1)

	local var_8_1 = arg_8_0.asmrChatView

	var_2.SetVisible(var_8_1, arg_8_1)

	local var_8_2 = arg_8_0.wordView

	var_2.StopAnimation(var_8_2)

	return
end

function var_0_1.SetAsmrChatText(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.asmrChatView

	var_3.ShowChat(var_9_0, arg_9_1, arg_9_2)

	return
end

function var_0_1.OnSwitchToNextShip(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.iconView

	var_2.Refresh(var_10_0, arg_10_1)

	local var_10_1 = arg_10_0.changeView

	var_2.Refresh(var_10_1, arg_10_1)

	ipairs = var_2

	for iter_10_0, iter_10_1 in var_2(arg_10_0.panels) do
		iter_10_1:Refresh()
	end

	return
end

function var_0_1.OnPlayerUpdated(arg_11_0)
	if arg_11_0:GetTopPanel() then
		var_1:Refresh()
	end

	return
end

function var_0_1.Refresh(arg_12_0, arg_12_1)
	ipairs = var_1_10002

	for iter_12_0, iter_12_1 in var_1_10002(arg_12_0.panels) do
		iter_12_1:Refresh()
	end

	local var_12_0 = arg_12_0.iconView

	var_2.Refresh(var_12_0, arg_12_1)

	local var_12_1 = arg_12_0.chatRoomView

	var_2.Refresh(var_12_1)

	local var_12_2 = arg_12_0.buffView

	var_2.Refresh(var_12_2)

	local var_12_3 = arg_12_0.actBtnView

	var_2.Refresh(var_12_3)

	local var_12_4 = arg_12_0.bannerView

	var_2.Refresh(var_12_4)

	local var_12_5 = arg_12_0.tagView

	var_2.Refresh(var_12_5)

	local var_12_6 = arg_12_0.changeView

	var_2.Refresh(var_12_6, arg_12_1)

	setActiveViaLayer = var_2

	var_2(arg_12_0._tf, true)

	return
end

function var_0_1.Disable(arg_13_0)
	ipairs = var_1_10001

	for iter_13_0, iter_13_1 in var_1_10001(arg_13_0.panels) do
		iter_13_1:Disable()
	end

	local var_13_0 = arg_13_0.iconView

	var_1.Disable(var_13_0)

	local var_13_1 = arg_13_0.chatRoomView

	var_1.Disable(var_13_1)

	local var_13_2 = arg_13_0.buffView

	var_1.Disable(var_13_2)

	local var_13_3 = arg_13_0.actBtnView

	var_1.Disable(var_13_3)

	local var_13_4 = arg_13_0.bannerView

	var_1.Disable(var_13_4)

	local var_13_5 = arg_13_0.wordView

	var_1.Disable(var_13_5)

	local var_13_6 = arg_13_0.changeView

	var_1.Disable(var_13_6)

	setActiveViaLayer = var_1

	var_1(arg_13_0._tf, false)

	return
end

function var_0_1.OnDestroy(arg_14_0)
	arg_14_0:UnOverlayPanel(arg_14_0._tf, arg_14_0._parentTf)

	ipairs = var_1

	local var_14_0

	if not arg_14_0.panels then
		var_14_0 = {}
	end

	for iter_14_0, iter_14_1 in var_1(var_14_0) do
		iter_14_1:Dispose()
	end

	arg_14_0.panels = nil

	local var_14_1

	if arg_14_0.iconView then
		var_14_1 = arg_14_0.iconView

		var_1.Dispose(var_14_1)

		arg_14_0.iconView = nil
	end

	if arg_14_0.chatRoomView then
		var_14_1 = arg_14_0.chatRoomView

		var_1.Dispose(var_14_1)

		arg_14_0.chatRoomView = nil
	end

	if arg_14_0.bannerView then
		var_14_1 = arg_14_0.bannerView

		var_1.Dispose(var_14_1)

		arg_14_0.bannerView = nil
	end

	if arg_14_0.actBtnView then
		var_14_1 = arg_14_0.actBtnView

		var_1.Dispose(var_14_1)

		arg_14_0.actBtnView = nil
	end

	if arg_14_0.buffView then
		var_14_1 = arg_14_0.buffView

		var_1.Dispose(var_14_1)

		arg_14_0.buffView = nil
	end

	if arg_14_0.tagView then
		var_14_1 = arg_14_0.tagView

		var_1.Dispose(var_14_1)

		arg_14_0.tagView = nil
	end

	if arg_14_0.wordView then
		var_14_1 = arg_14_0.wordView

		var_1.Dispose(var_14_1)

		arg_14_0.wordView = nil
	end

	if arg_14_0.changeView then
		var_14_1 = arg_14_0.changeView

		var_1.Dispose(var_14_1)

		arg_14_0.changeView = nil
	end

	if arg_14_0.asmrChatView then
		var_14_1 = arg_14_0.asmrChatView

		var_1.Dispose(var_14_1)

		arg_14_0.asmrChatView = nil
	end

	pg = var_1

	local var_14_2 = var_1.EasyRedDotMgr.GetInstance()

	ipairs = var_14_1

	local var_14_3

	if not arg_14_0.redDotUIList then
		var_14_3 = {}
	end

	for iter_14_2, iter_14_3 in var_14_1(var_14_3) do
		var_14_2:UnRegisterRedDot(iter_14_3)
	end

	arg_14_0.redDotUIList = nil

	return
end

function var_0_1.GetPbList(arg_15_0)
	return {}
end

function var_0_1.GetCalibrationBG(arg_16_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetPaintingOffset(arg_17_0, arg_17_1)
	MainPaintingShift = var_1_10002

	return var_1_10002.New({
		0,
		-10,
		0,
		0,
		0,
		0,
		1,
		1,
		1
	})
end

function var_0_1.ApplyDefaultResUI(arg_18_0)
	return true
end

function var_0_1.GetWordView(arg_19_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetTagView(arg_20_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetTopPanel(arg_21_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetRightPanel(arg_22_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetLeftPanel(arg_23_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetBottomPanel(arg_24_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetIconView(arg_25_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetChatRoomView(arg_26_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetBannerView(arg_27_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetActBtnView(arg_28_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetBuffView(arg_29_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetChangeSkinView(arg_30_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.GetAsmrChatView(arg_31_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.RegisterRedDots(arg_32_0)
	return {}
end

return var_0_1

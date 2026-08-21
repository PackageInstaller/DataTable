local var_0_0 = class("NewMainSceneBaseTheme", import("view.base.BaseSubView"))

function var_0_0.OnLoaded(arg_1_0)
	arg_1_0.mainCG = GetOrAddComponent(arg_1_0._tf, typeof(CanvasGroup))
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
	arg_1_0._loaded = true

	return
end

function var_0_0.Show(arg_2_0, arg_2_1)
	arg_2_1()
	var_0_0.super.Show(arg_2_0)

	return
end

function var_0_0.PlayEnterAnimation(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.bannerView:Init()
	arg_3_0.actBtnView:Init()
	arg_3_0:_FoldPanels(true, 0)

	arg_3_0.mainCG.alpha = 1

	arg_3_0:_FoldPanels(false, 0.5)
	onDelayTick(arg_3_2, 0.51)

	return
end

function var_0_0.init(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.panels) do
		iter_4_1:Init()
	end

	arg_4_0.iconView:Init(arg_4_1)
	arg_4_0.chatRoomView:Init()
	arg_4_0.buffView:Init()
	arg_4_0.tagView:Init()
	arg_4_0.changeView:Init(arg_4_1)
	arg_4_0.asmrChatView:Init(arg_4_1)
	arg_4_0:OverlayPanel(arg_4_0._tf, {
		stopTop = true,
		pbList = arg_4_0:GetPbList()
	})

	return
end

function var_0_0._FoldPanels(arg_5_0, arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.panels) do
		iter_5_1:Fold(arg_5_1, arg_5_2)
	end

	arg_5_0.iconView:Fold(arg_5_1, arg_5_2)
	arg_5_0.chatRoomView:Fold(arg_5_1, arg_5_2)
	arg_5_0.bannerView:Fold(arg_5_1, arg_5_2)
	arg_5_0.actBtnView:Fold(arg_5_1, arg_5_2)
	arg_5_0.buffView:Fold(arg_5_1, arg_5_2)
	arg_5_0.wordView:Fold(arg_5_1, arg_5_2)
	arg_5_0.tagView:Fold(arg_5_1, arg_5_2)
	arg_5_0.changeView:Fold(arg_5_1, arg_5_2)
	arg_5_0.asmrChatView:Fold(arg_5_1, arg_5_2)

	return
end

function var_0_0.OnFoldPanels(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.mainCG.blocksRaycasts = false
	else
		Timer.New(function()
			if arg_6_0.mainCG then
				arg_6_0.mainCG.blocksRaycasts = true
			end

			return
		end, 0.5, 1):Start()
	end

	arg_6_0:_FoldPanels(arg_6_1, 0.5)

	return
end

function var_0_0.OnAsmrTurnning(arg_8_0, arg_8_1)
	arg_8_0._asmrTurnning = arg_8_1

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.panels) do
		iter_8_1:SetAlpha(arg_8_1 and 0 or 1)
		iter_8_1:SetInteractable(not arg_8_1 and true or false)
		iter_8_1:SetBlocksRaycasts(not arg_8_1 and true or false)
	end

	arg_8_0.changeView:IgnoreParentGroups(arg_8_1)
	arg_8_0.asmrChatView:SetVisible(arg_8_1)
	arg_8_0.wordView:StopAnimation()

	return
end

function var_0_0.SetAsmrChatText(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.asmrChatView:ShowChat(arg_9_1, arg_9_2)

	return
end

function var_0_0.OnSwitchToNextShip(arg_10_0, arg_10_1)
	arg_10_0.iconView:Refresh(arg_10_1)
	arg_10_0.changeView:Refresh(arg_10_1)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.panels) do
		iter_10_1:Refresh()
	end

	return
end

function var_0_0.OnPlayerUpdated(arg_11_0)
	local var_11_0 = arg_11_0:GetTopPanel()

	if var_11_0 then
		var_11_0:Refresh()
	end

	return
end

function var_0_0.Refresh(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.panels) do
		iter_12_1:Refresh()
	end

	arg_12_0.iconView:Refresh(arg_12_1)
	arg_12_0.chatRoomView:Refresh()
	arg_12_0.buffView:Refresh()
	arg_12_0.actBtnView:Refresh()
	arg_12_0.bannerView:Refresh()
	arg_12_0.tagView:Refresh()
	arg_12_0.changeView:Refresh(arg_12_1)
	setActiveViaLayer(arg_12_0._tf, true)

	return
end

function var_0_0.Disable(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.panels) do
		iter_13_1:Disable()
	end

	arg_13_0.iconView:Disable()
	arg_13_0.chatRoomView:Disable()
	arg_13_0.buffView:Disable()
	arg_13_0.actBtnView:Disable()
	arg_13_0.bannerView:Disable()
	arg_13_0.wordView:Disable()
	arg_13_0.changeView:Disable()
	setActiveViaLayer(arg_13_0._tf, false)

	return
end

function var_0_0.IsLoaded(arg_14_0)
	return arg_14_0._loaded
end

function var_0_0.OnDestroy(arg_15_0)
	arg_15_0:UnOverlayPanel(arg_15_0._tf, arg_15_0._parentTf)

	local var_15_0 = arg_15_0.panels or {}

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		iter_15_1:Dispose()
	end

	arg_15_0.panels = nil

	if arg_15_0.iconView then
		arg_15_0.iconView:Dispose()

		arg_15_0.iconView = nil
	end

	if arg_15_0.chatRoomView then
		arg_15_0.chatRoomView:Dispose()

		arg_15_0.chatRoomView = nil
	end

	if arg_15_0.bannerView then
		arg_15_0.bannerView:Dispose()

		arg_15_0.bannerView = nil
	end

	if arg_15_0.actBtnView then
		arg_15_0.actBtnView:Dispose()

		arg_15_0.actBtnView = nil
	end

	if arg_15_0.buffView then
		arg_15_0.buffView:Dispose()

		arg_15_0.buffView = nil
	end

	if arg_15_0.tagView then
		arg_15_0.tagView:Dispose()

		arg_15_0.tagView = nil
	end

	if arg_15_0.wordView then
		arg_15_0.wordView:Dispose()

		arg_15_0.wordView = nil
	end

	if arg_15_0.changeView then
		arg_15_0.changeView:Dispose()

		arg_15_0.changeView = nil
	end

	if arg_15_0.asmrChatView then
		arg_15_0.asmrChatView:Dispose()

		arg_15_0.asmrChatView = nil
	end

	local var_15_1 = pg.EasyRedDotMgr.GetInstance()
	local var_15_2 = arg_15_0.redDotUIList or {}

	for iter_15_2, iter_15_3 in ipairs(var_15_2) do
		var_15_1:UnRegisterRedDot(iter_15_3)
	end

	arg_15_0.redDotUIList = nil

	return
end

function var_0_0.GetPbList(arg_16_0)
	return {}
end

function var_0_0.GetCalibrationBG(arg_17_0)
	assert(false)

	return
end

function var_0_0.GetPaintingOffset(arg_18_0, arg_18_1)
	return MainPaintingShift.New({
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

function var_0_0.ApplyDefaultResUI(arg_19_0)
	return true
end

function var_0_0.GetWordView(arg_20_0)
	assert(false)

	return
end

function var_0_0.GetTagView(arg_21_0)
	assert(false)

	return
end

function var_0_0.GetTopPanel(arg_22_0)
	assert(false)

	return
end

function var_0_0.GetRightPanel(arg_23_0)
	assert(false)

	return
end

function var_0_0.GetLeftPanel(arg_24_0)
	assert(false)

	return
end

function var_0_0.GetBottomPanel(arg_25_0)
	assert(false)

	return
end

function var_0_0.GetIconView(arg_26_0)
	assert(false)

	return
end

function var_0_0.GetChatRoomView(arg_27_0)
	assert(false)

	return
end

function var_0_0.GetBannerView(arg_28_0)
	assert(false)

	return
end

function var_0_0.GetActBtnView(arg_29_0)
	assert(false)

	return
end

function var_0_0.GetBuffView(arg_30_0)
	assert(false)

	return
end

function var_0_0.GetChangeSkinView(arg_31_0)
	assert(false)

	return
end

function var_0_0.GetAsmrChatView(arg_32_0)
	assert(false)

	return
end

function var_0_0.RegisterRedDots(arg_33_0)
	return {}
end

return var_0_0

class = var_0_10000

local var_0_0 = "IslandBasePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1.event
	local var_1_1 = arg_1_1.contextData

	var_0_1.super.Ctor(arg_1_0, arg_1_2, var_1_0, var_1_1)
	arg_1_0:RegisterView(arg_1_1)

	arg_1_0.islandScene = arg_1_1
	arg_1_0.__callbacks__ = {}
	arg_1_0.isBlur = false

	return
end

function var_0_1.Loaded(arg_2_0, arg_2_1)
	var_0_1.super.Loaded(arg_2_0, arg_2_1)

	GetOrAddComponent = var_2

	local var_2_0 = arg_2_1

	typeof = var_5
	IslandUIController = var_1_10007
	arg_2_0.islandUIController = var_2(var_2_0, var_5(var_1_10007))

	local var_2_1 = arg_2_1
	local var_2_2 = arg_2_1.GetComponent

	typeof = var_5
	CanvasGroup = var_1_10007
	arg_2_0.cg = var_2_2(var_2_1, var_5(var_1_10007))

	return
end

function var_0_1.emit(arg_3_0, ...)
	local var_3_0 = arg_3_0.islandScene

	var_1.emit(var_3_0, ...)

	return
end

function var_0_1.emitCore(arg_4_0, arg_4_1, ...)
	local var_4_0 = arg_4_0.islandScene

	var_2.emitCore(var_4_0, arg_4_1, ...)

	return
end

function var_0_1.emitCoreController(arg_5_0, arg_5_1, ...)
	local var_5_0 = arg_5_0.islandScene

	var_2.emitCoreController(var_5_0, arg_5_1, ...)

	return
end

function var_0_1.CanEsc(arg_6_0)
	return true
end

function var_0_1.NeedCache(arg_7_0)
	return true
end

function var_0_1.GetIsland(arg_8_0)
	local var_8_0 = arg_8_0.islandScene

	return var_1.GetIsland(var_8_0)
end

function var_0_1.GetSelfIsland(arg_9_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_9_0 = var_1_10001(var_1_10003)

	return var_1.GetIsland(var_9_0)
end

function var_0_1.IsSelfIsland(arg_10_0)
	return arg_10_0:GetIsland().id == arg_10_0:GetSelfIsland().id
end

function var_0_1.GetPoolMgr(arg_11_0)
	return arg_11_0.islandScene.poolMgr
end

function var_0_1.GetPage(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.islandScene

	return var_2.GetPage(var_12_0, arg_12_1)
end

function var_0_1.Show(arg_13_0, ...)
	arg_13_0:AddListeners()

	local var_13_0 = arg_13_0.islandUIController

	var_1.Show(var_13_0, true)
	arg_13_0:OnShow(...)

	return
end

function var_0_1.Hide(arg_14_0, arg_14_1, arg_14_2)
	defaultValue = var_1_10003

	local var_14_0 = var_1_10003(arg_14_1, true)
	local var_14_1 = {}

	if var_14_0 then
		table = var_5

		var_5.insert(var_14_1, function(arg_15_0)
			local var_15_0 = arg_14_0.islandUIController

			var_1.Hide(var_15_0, true, arg_15_0)

			return
		end)
	end

	seriesAsync = var_5

	var_5(var_14_1, function()
		local var_16_0 = arg_14_0

		var_0.RemoveListeners(var_16_0)

		local var_16_1 = arg_14_0

		var_0.OnHide(var_16_1)

		local var_16_2 = arg_14_0

		var_0.ClosePage(var_16_2, arg_14_0)

		if not arg_14_2 then
			local var_16_3 = arg_14_0

			var_0.OnExit(var_16_3)
		end

		return
	end)

	return
end

function var_0_1.Enable(arg_17_0)
	local var_17_0 = arg_17_0.islandUIController

	var_1.Show(var_17_0, true)

	arg_17_0.isVisible = true

	arg_17_0:OnEnable()

	return
end

function var_0_1.Disable(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.islandUIController

	var_2.Hide(var_18_0, true, arg_18_1)

	arg_18_0.isVisible = false

	arg_18_0:OnDisable()

	return
end

function var_0_1.BlurPanel(arg_19_0)
	arg_19_0.isBluring = true

	local var_19_0 = arg_19_0.viewComponent

	var_1.BlurPanel(var_19_0, arg_19_0._tf)

	return
end

function var_0_1.UnBlurPanel(arg_20_0)
	if arg_20_0.isBluring then
		local var_20_0 = arg_20_0.viewComponent

		var_1.UnOverlayPanel(var_20_0, arg_20_0._tf, arg_20_0._parentTf)

		arg_20_0.isBluring = false
	end

	return
end

function var_0_1.ShowMsgBox(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.islandScene

	return var_2.ShowMsgbox(var_21_0, arg_21_1)
end

function var_0_1.PlayStory(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.islandScene

	return var_2.PlayStory(var_22_0, arg_22_1)
end

function var_0_1.PlayGetShipTimeline(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0.islandScene

	var_3.PlayGetShipTimeline(var_23_0, arg_23_1, arg_23_2)

	return
end

function var_0_1.OpenPage(arg_24_0, arg_24_1, ...)
	IslandGuideChecker = var_1_10002

	var_1_10002.CheckOnOpenPage(arg_24_1.__cname)

	local var_24_0 = arg_24_0.islandScene.sceneMgr

	return var_2.OpenPage(var_24_0, arg_24_0, arg_24_1, ...)
end

function var_0_1.OpenScenePage(arg_25_0, arg_25_1, ...)
	local var_25_0 = arg_25_0.islandScene

	return var_2.OpenPage(var_25_0, arg_25_1, ...)
end

function var_0_1.ClosePage(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0.islandScene.sceneMgr

	var_2.ClosePage(var_26_0, arg_26_1)

	return
end

function var_0_1.DestorySubPage(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0.islandScene.sceneMgr

	var_2.DestorySubPage(var_27_0, arg_27_1)

	return
end

function var_0_1.AddListener(arg_28_0, arg_28_1, arg_28_2)
	local function var_28_0(arg_29_0, ...)
		arg_28_2(arg_28_0, ...)

		return
	end

	local var_28_1 = arg_28_0:bind(arg_28_1, var_28_0)

	arg_28_0.__callbacks__[arg_28_1] = var_28_1

	local var_28_2 = arg_28_0:GetIsland()

	var_5.AddListener(var_28_2, arg_28_1, var_28_0)

	return
end

function var_0_1.RemoveListener(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_0.__callbacks__[arg_30_1] then
		local var_30_0 = arg_30_0.eventStore[var_3]
		local var_30_1 = arg_30_0:GetIsland()

		var_5.RemoveListener(var_30_1, arg_30_1, var_30_0.callback)
		arg_30_0:disconnect(var_3)

		arg_30_0.__callbacks__[arg_30_1] = nil
	end

	return
end

function var_0_1.Destroy(arg_31_0, arg_31_1)
	if arg_31_0:isShowing() then
		arg_31_0:Hide(false, arg_31_1)
	end

	arg_31_0.__callbacks__ = {}

	var_0_1.super.Destroy(arg_31_0)
	arg_31_0:Reset()

	return
end

function var_0_1.SetVisible(arg_32_0, arg_32_1, arg_32_2)
	GetOrAddComponent = var_1_10003

	local var_32_0 = arg_32_1

	typeof = var_1_10006
	CanvasGroup = var_1_10008

	local var_32_1 = var_1_10003(var_32_0, var_1_10006(var_1_10008))

	var_32_1.alpha = arg_32_2 and 1 or 0
	var_32_1.blocksRaycasts = arg_32_2

	return
end

function var_0_1.ActiveOrDisactive(arg_33_0, arg_33_1)
	IsNil = var_1_10002

	if not var_1_10002(arg_33_0._tf) then
		setActive = var_2

		var_2(arg_33_0._tf, arg_33_1)
	end

	return
end

function var_0_1.AddListeners(arg_34_0)
	return
end

function var_0_1.RemoveListeners(arg_35_0)
	return
end

function var_0_1.Preload(arg_36_0, arg_36_1)
	arg_36_1()

	return
end

function var_0_1.OnShow(arg_37_0)
	return
end

function var_0_1.OnHide(arg_38_0)
	return
end

function var_0_1.OnExit(arg_39_0)
	return
end

function var_0_1.OnEnable(arg_40_0)
	return
end

function var_0_1.OnDisable(arg_41_0)
	return
end

function var_0_1.GetEnterAnimationName(arg_42_0)
	return ""
end

function var_0_1.GetExitAnimationName(arg_43_0)
	return ""
end

return var_0_1

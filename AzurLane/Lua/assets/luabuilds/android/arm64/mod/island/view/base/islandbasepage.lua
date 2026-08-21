local var_0_0 = class("IslandBasePage", import("view.base.BaseSubView"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_2, arg_1_1.event, arg_1_1.contextData)
	arg_1_0:RegisterView(arg_1_1)

	arg_1_0.islandScene = arg_1_1
	arg_1_0.__callbacks__ = {}
	arg_1_0.isBlur = false

	return
end

function var_0_0.Loaded(arg_2_0, arg_2_1)
	var_0_0.super.Loaded(arg_2_0, arg_2_1)

	arg_2_0.islandUIController = GetOrAddComponent(arg_2_1, typeof(IslandUIController))
	arg_2_0.cg = arg_2_1:GetComponent(typeof(CanvasGroup))

	return
end

function var_0_0.emit(arg_3_0, ...)
	arg_3_0.islandScene:emit(...)

	return
end

function var_0_0.emitCore(arg_4_0, arg_4_1, ...)
	arg_4_0.islandScene:emitCore(arg_4_1, ...)

	return
end

function var_0_0.emitCoreController(arg_5_0, arg_5_1, ...)
	arg_5_0.islandScene:emitCoreController(arg_5_1, ...)

	return
end

function var_0_0.CanEsc(arg_6_0)
	return true
end

function var_0_0.NeedCache(arg_7_0)
	return true
end

function var_0_0.GetIsland(arg_8_0)
	return arg_8_0.islandScene:GetIsland()
end

function var_0_0.GetSelfIsland(arg_9_0)
	return getProxy(IslandProxy):GetIsland()
end

function var_0_0.IsSelfIsland(arg_10_0)
	return arg_10_0:GetIsland().id == arg_10_0:GetSelfIsland().id
end

function var_0_0.GetPoolMgr(arg_11_0)
	return arg_11_0.islandScene.poolMgr
end

function var_0_0.GetPage(arg_12_0, arg_12_1)
	return arg_12_0.islandScene:GetPage(arg_12_1)
end

function var_0_0.Show(arg_13_0, ...)
	arg_13_0:AddListeners()
	arg_13_0.islandUIController:Show(true)
	arg_13_0:OnShow(...)

	return
end

function var_0_0.Hide(arg_14_0, arg_14_1, arg_14_2)
	if defaultValue(arg_14_1, true) then
		table.insert({}, function(arg_15_0)
			arg_14_0.islandUIController:Hide(true, arg_15_0)

			return
		end)
	end

	seriesAsync({}, function()
		arg_14_0:RemoveListeners()
		arg_14_0:OnHide()
		arg_14_0.ClosePage(arg_14_0, arg_14_0)

		if not arg_14_2 then
			arg_14_0:OnExit()
		end

		return
	end)

	return
end

function var_0_0.Enable(arg_17_0)
	arg_17_0.islandUIController:Show(true)

	arg_17_0.isVisible = true

	arg_17_0:OnEnable()

	return
end

function var_0_0.Disable(arg_18_0, arg_18_1)
	arg_18_0.islandUIController:Hide(true, arg_18_1)

	arg_18_0.isVisible = false

	arg_18_0:OnDisable()

	return
end

function var_0_0.BlurPanel(arg_19_0)
	arg_19_0.isBluring = true

	arg_19_0.viewComponent:BlurPanel(arg_19_0._tf)

	return
end

function var_0_0.UnBlurPanel(arg_20_0)
	if arg_20_0.isBluring then
		arg_20_0.viewComponent:UnOverlayPanel(arg_20_0._tf, arg_20_0._parentTf)

		arg_20_0.isBluring = false
	end

	return
end

function var_0_0.ShowMsgBox(arg_21_0, arg_21_1)
	return arg_21_0.islandScene:ShowMsgbox(arg_21_1)
end

function var_0_0.PlayStory(arg_22_0, arg_22_1)
	return arg_22_0.islandScene:PlayStory(arg_22_1)
end

function var_0_0.PlayGetShipTimeline(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.islandScene:PlayGetShipTimeline(arg_23_1, arg_23_2)

	return
end

function var_0_0.OpenPage(arg_24_0, arg_24_1, ...)
	IslandGuideChecker.CheckOnOpenPage(arg_24_1.__cname)

	return arg_24_0.islandScene.sceneMgr:OpenPage(arg_24_0, arg_24_1, ...)
end

function var_0_0.OpenScenePage(arg_25_0, arg_25_1, ...)
	return arg_25_0.islandScene:OpenPage(arg_25_1, ...)
end

function var_0_0.ClosePage(arg_26_0, arg_26_1)
	arg_26_0.islandScene.sceneMgr:ClosePage(arg_26_1)

	return
end

function var_0_0.DestorySubPage(arg_27_0, arg_27_1)
	arg_27_0.islandScene.sceneMgr:DestorySubPage(arg_27_1)

	return
end

function var_0_0.AddListener(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0.__callbacks__[arg_28_1] = arg_28_0:bind(arg_28_1, function(arg_29_0, ...)
		arg_28_2(arg_28_0, ...)

		return
	end)

	arg_28_0:GetIsland():AddListener(arg_28_1, function(arg_29_0, ...)
		arg_28_2(arg_28_0, ...)

		return
	end)

	return
end

function var_0_0.RemoveListener(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_0.__callbacks__[arg_30_1] then
		arg_30_0:GetIsland():RemoveListener(arg_30_1, arg_30_0.eventStore[arg_30_0.__callbacks__[arg_30_1]].callback)
		arg_30_0:disconnect(arg_30_0.__callbacks__[arg_30_1])

		arg_30_0.__callbacks__[arg_30_1] = nil
	end

	return
end

function var_0_0.Destroy(arg_31_0, arg_31_1)
	if arg_31_0:isShowing() then
		arg_31_0:Hide(false, arg_31_1)
	end

	arg_31_0.__callbacks__ = {}

	var_0_0.super.Destroy(arg_31_0)
	arg_31_0:Reset()

	return
end

function var_0_0.SetVisible(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = GetOrAddComponent(arg_32_1, typeof(CanvasGroup))

	var_32_0.alpha = arg_32_2 and 1 or 0
	var_32_0.blocksRaycasts = arg_32_2

	return
end

function var_0_0.ActiveOrDisactive(arg_33_0, arg_33_1)
	if not IsNil(arg_33_0._tf) then
		setActive(arg_33_0._tf, arg_33_1)
	end

	return
end

function var_0_0.AddListeners(arg_34_0)
	return
end

function var_0_0.RemoveListeners(arg_35_0)
	return
end

function var_0_0.Preload(arg_36_0, arg_36_1)
	arg_36_1()

	return
end

function var_0_0.OnShow(arg_37_0)
	return
end

function var_0_0.OnHide(arg_38_0)
	return
end

function var_0_0.OnExit(arg_39_0)
	return
end

function var_0_0.OnEnable(arg_40_0)
	return
end

function var_0_0.OnDisable(arg_41_0)
	return
end

function var_0_0.GetEnterAnimationName(arg_42_0)
	return ""
end

function var_0_0.GetExitAnimationName(arg_43_0)
	return ""
end

return var_0_0

module("frameworkext.lmvc.view.ViewPresentor", package.seeall)

local var_0_0 = WindowType.WindowOpenReasonType
local var_0_1 = WindowType.WindowCloseReasonType
local var_0_2 = WindowType.WindowStatusType
local var_0_3 = WindowType.WindowOpType
local var_0_4 = WindowType.WindowAniType
local var_0_5 = Astral.GUITimeLineMode
local var_0_6 = class("ViewPresentor")

var_0_6.kOnEnter = 0
var_0_6.kOnEnterFinished = 1
var_0_6.kOnExit = 2
var_0_6.kOnExitFinished = 3

function var_0_6.ctor(arg_1_0)
	arg_1_0._viewName = nil
	arg_1_0.mainGO = nil
	arg_1_0._resDict = nil
	arg_1_0._openParam = nil
	arg_1_0._isNeedDestory = nil
	arg_1_0._opType = var_0_3.ViewOpNone
	arg_1_0._status = var_0_2.ViewStatusIniting
	arg_1_0._isResLoaded = false
	arg_1_0._resLoader = nil
	arg_1_0._views = nil
	arg_1_0._guiAnimation = nil
	arg_1_0._openReasonType = var_0_0.NormalOpenType
	arg_1_0._viewElementsRegistry = ViewElementsRegistry.New()
	arg_1_0._isBackOpen = nil
end

function var_0_6.setViewName(arg_2_0, arg_2_1)
	arg_2_0._viewName = arg_2_1
end

function var_0_6.getViewName(arg_3_0)
	return arg_3_0._viewName
end

function var_0_6.setMainGO(arg_4_0, arg_4_1)
	arg_4_0.mainGO = arg_4_1

	arg_4_0._viewElementsRegistry:setMainGO(arg_4_0:getMainGO())
end

function var_0_6.getMainGO(arg_5_0)
	return arg_5_0.mainGO
end

function var_0_6.getIsOpenOver(arg_6_0)
	return var_0_2.ViewStatusOpen == arg_6_0._status
end

function var_0_6.findUIElement(arg_7_0, arg_7_1, arg_7_2)
	return arg_7_0._viewElementsRegistry:findUIElement(arg_7_1, arg_7_2)
end

function var_0_6.getViewElementsRegistry(arg_8_0)
	return arg_8_0._viewElementsRegistry
end

function var_0_6.isOpen(arg_9_0)
	if arg_9_0._status == var_0_2.ViewStatusOpen or arg_9_0._status == var_0_2.ViewStatusOpening and arg_9_0._opType ~= var_0_3.ViewOpClose or arg_9_0._opType == var_0_3.ViewOpOpen then
		return true
	end

	return false
end

function var_0_6.loadViewResources(arg_10_0)
	local var_10_0 = arg_10_0:dependWhatResources()

	if var_10_0 and #var_10_0 then
		arg_10_0._resLoader = SequenceLoader.instance:getResLoader()

		SequenceLoader.instance:setResPaths(arg_10_0._resLoader, var_10_0)
		SequenceLoader.instance:load(arg_10_0._resLoader, var_0_6._onViewResourcesLoaded, nil, arg_10_0)
	else
		arg_10_0:_onViewResourcesLoaded(nil)
	end
end

function var_0_6._onViewResourcesLoaded(arg_11_0, arg_11_1)
	arg_11_0._isResLoaded = true

	if arg_11_1 then
		arg_11_0._resDict = {}

		local var_11_0 = arg_11_1:getResources()

		for iter_11_0, iter_11_1 in pairs(var_11_0) do
			arg_11_0._resDict[iter_11_0] = iter_11_1

			iter_11_1:Retain()
		end
	end

	SequenceLoader.instance:returnResLoader(arg_11_0._resLoader)

	arg_11_0._resLoader = nil

	if not arg_11_0.mainGO then
		local var_11_1 = arg_11_0:dependWhatResources()

		if var_11_1 and #var_11_1 > 0 then
			arg_11_0.mainGO = arg_11_0:getResInstance(var_11_1[1])

			arg_11_0._viewElementsRegistry:setMainGO(arg_11_0:getMainGO())
		end
	end

	if arg_11_0.mainGO then
		local var_11_2 = ViewMgr.instance:getRoot(arg_11_0:attachToWhichRoot())

		goutil.addChildToParent(arg_11_0.mainGO, var_11_2)
	end

	arg_11_0._views = arg_11_0:buildViews()

	if arg_11_0._views then
		local var_11_3 = #arg_11_0._views

		for iter_11_2 = 1, var_11_3 do
			local var_11_4 = arg_11_0._views[iter_11_2]

			var_11_4.mainGO = arg_11_0.mainGO

			var_11_4:setViewPresentor(arg_11_0)
			var_11_4:buildUI()
			var_11_4:bindEvents()
		end
	end

	arg_11_0:_bindAnimation()

	if arg_11_0.mainGO then
		arg_11_0:_updateViewVisible(false)
	end

	arg_11_0._status = var_0_2.ViewStatusClose

	if arg_11_0._opType == var_0_3.ViewOpOpen then
		arg_11_0:_doOpen(arg_11_0._openReasonType)
	elseif arg_11_0._opType == var_0_3.ViewOpClose then
		arg_11_0._opType = var_0_3.ViewOpNone
		arg_11_0._status = var_0_2.ViewStatusClose
	end
end

function var_0_6.getGuiAnimation(arg_12_0)
	return arg_12_0._guiAnimation
end

function var_0_6._bindAnimation(arg_13_0)
	if arg_13_0.mainGO then
		arg_13_0._guiAnimation = arg_13_0.mainGO:GetComponent(typeof(Astral.GUITimelineAniLua))

		if arg_13_0._guiAnimation then
			arg_13_0._guiAnimation:AddListener(arg_13_0._animationDoneListener, arg_13_0)
		end
	end
end

function var_0_6._animationDoneListener(arg_14_0, arg_14_1, arg_14_2)
	if var_0_4.OpenAniType == arg_14_1 then
		arg_14_0:_dealPreAnimationDone()
		arg_14_0:_onEnterAnimationDone()
	elseif var_0_4.CloserAniType == arg_14_1 then
		arg_14_0:_dealPreAnimationDone()
		arg_14_0:_onCloseAnimationDone()
	end

	arg_14_0:localNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, arg_14_1, arg_14_2)
end

function var_0_6._dealPreAnimationDone(arg_15_0, arg_15_1)
	arg_15_0._guiAnimation:StopTimelineAni()
end

function var_0_6._onVisualEvent(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_0._views then
		return
	end

	local var_16_0 = #arg_16_0._views

	for iter_16_0 = 1, var_16_0 do
		if var_0_6.kOnEnter == arg_16_1 then
			arg_16_0._views[iter_16_0]:onEnter(arg_16_2)
		elseif var_0_6.kOnEnterFinished == arg_16_1 then
			arg_16_0._views[iter_16_0]:onEnterFinished()
		elseif var_0_6.kOnExit == arg_16_1 then
			arg_16_0._views[iter_16_0]:onExit(arg_16_2)
		elseif var_0_6.kOnExitFinished == arg_16_1 then
			arg_16_0._views[iter_16_0]:onExitFinished()
		end
	end
end

function var_0_6._updateViewVisible(arg_17_0, arg_17_1)
	local var_17_0 = 100000
	local var_17_1 = 0
	local var_17_2 = false

	if arg_17_1 then
		var_17_0 = 0
		var_17_1 = 1
		var_17_2 = true
	end

	Astral.GeometryUtil.SetAnchorPosX(arg_17_0.mainGO.transform, var_17_0)

	local var_17_3 = goutil.addComponentOnce(arg_17_0.mainGO, typeof(UnityEngine.CanvasGroup))

	var_17_3.alpha = var_17_1
	var_17_3.interactable = var_17_2
	var_17_3.blocksRaycasts = var_17_2
end

function var_0_6._doOpen(arg_18_0, arg_18_1)
	arg_18_0._opType = var_0_3.ViewOpNone
	arg_18_0._status = var_0_2.ViewStatusOpening

	arg_18_0:_updateViewVisible(true)
	arg_18_0:_onVisualEvent(var_0_6.kOnEnter, arg_18_1)
	GlobalDispatcher:dispatchEvent(EventType.FW_VIEW_OPENING_EVENT, arg_18_0._viewName, arg_18_0._opType, arg_18_0._isBackOpen)

	if ViewSetting.instance:isPreClose(arg_18_0._viewName) then
		GlobalDispatcher:dispatchEvent(EventType.FW_VIEW_OPEN_OVER_EVENT, arg_18_0._viewName, arg_18_0._opType)
	end

	arg_18_0._isBackOpen = nil

	arg_18_0:playEnterAnimation(arg_18_1)
end

function var_0_6._doClose(arg_19_0, arg_19_1)
	arg_19_0._opType = var_0_3.ViewOpNone
	arg_19_0._status = var_0_2.ViewStatusClosing

	arg_19_0:_onVisualEvent(var_0_6.kOnExit, arg_19_1)
	GlobalDispatcher:dispatchEvent(EventType.FW_VIEW_CLOSING_EVENT, arg_19_0._viewName, arg_19_0._opType, arg_19_1)
	arg_19_0:playCloseAnimation(arg_19_1)
end

function var_0_6.open(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_0._openParam = arg_20_1
	arg_20_0._isBackOpen = arg_20_3
	arg_20_0._openReasonType = arg_20_2

	if not arg_20_0._isResLoaded and arg_20_0._opType ~= var_0_3.ViewOpOpen then
		arg_20_0._opType = var_0_3.ViewOpOpen

		if arg_20_0._resLoader == nil then
			arg_20_0:loadViewResources()
		end

		return
	end

	if arg_20_0._status == var_0_2.ViewStatusClose then
		arg_20_0:_doOpen(arg_20_2)
	elseif arg_20_0._status == var_0_2.ViewStatusClosing then
		arg_20_0._opType = var_0_3.ViewOpOpen

		arg_20_0:playCloseAnimation(var_0_1.QuickCloseType, true)
		arg_20_0:_doOpen(arg_20_2)
	elseif arg_20_0._status == var_0_2.ViewStatusIniting then
		arg_20_0._opType = var_0_3.ViewOpOpen
	else
		arg_20_0._opType = var_0_3.ViewOpNone
	end
end

function var_0_6.getIsBackOpen(arg_21_0)
	return arg_21_0._isBackOpen
end

function var_0_6.close(arg_22_0, arg_22_1)
	if not arg_22_0._isResLoaded then
		arg_22_0._opType = var_0_3.ViewOpClose

		return
	end

	if arg_22_0._status == var_0_2.ViewStatusOpen then
		arg_22_0:_doClose(arg_22_1)
	elseif arg_22_0._status == var_0_2.ViewStatusClosing then
		-- block empty
	elseif arg_22_0._status == var_0_2.ViewStatusOpening then
		arg_22_0._opType = var_0_3.ViewOpClose

		arg_22_0:playEnterAnimation(var_0_0.QuickOpenType, true)
		arg_22_0:_doClose(arg_22_1)
	else
		arg_22_0._opType = var_0_3.ViewOpNone
	end
end

function var_0_6.destroy(arg_23_0, arg_23_1)
	if arg_23_1 or var_0_2.ViewStatusClosing ~= arg_23_0._status then
		if arg_23_0._guiAnimation then
			arg_23_0._guiAnimation:RemoveListener()

			arg_23_0._guiAnimation = nil
		end

		if arg_23_0._views then
			local var_23_0 = #arg_23_0._views

			for iter_23_0 = 1, var_23_0 do
				arg_23_0._views[iter_23_0]:unbindEvents()
				arg_23_0._views[iter_23_0]:destroyUI()
			end

			table.clear(arg_23_0._views)

			arg_23_0._views = nil
		end

		if arg_23_0._resDict then
			for iter_23_1, iter_23_2 in pairs(arg_23_0._resDict) do
				iter_23_2:Release()
			end

			arg_23_0._resDict = nil
		end

		if arg_23_0._resLoader then
			SequenceLoader.instance:returnResLoader(arg_23_0._resLoader)

			arg_23_0._resLoader = nil
		end

		arg_23_0._openReasonType = nil

		arg_23_0._viewElementsRegistry:cleanRegistry()

		arg_23_0._viewElementsRegistry = nil
		arg_23_0._isNeedDestory = nil
		arg_23_0._isBackOpen = nil

		goutil.destroy(arg_23_0.mainGO)
	else
		arg_23_0._isNeedDestory = true
	end
end

function var_0_6._onEnterAnimationDone(arg_24_0, arg_24_1)
	arg_24_0._openReasonType = var_0_0.NormalOpenType

	if arg_24_0._status ~= var_0_2.ViewStatusOpening then
		return
	end

	arg_24_0._status = var_0_2.ViewStatusOpen

	arg_24_0:_onVisualEvent(var_0_6.kOnEnterFinished)

	if not ViewSetting.instance:isPreClose(arg_24_0._viewName) then
		GlobalDispatcher:dispatchEvent(EventType.FW_VIEW_OPEN_OVER_EVENT, arg_24_0._viewName, arg_24_0._opType)
	end
end

function var_0_6._onCloseAnimationDone(arg_25_0)
	if arg_25_0._status == var_0_2.ViewStatusClosing then
		arg_25_0:_onVisualEvent(var_0_6.kOnExitFinished)
		arg_25_0:_updateViewVisible(false)
		GlobalDispatcher:dispatchEvent(EventType.FW_VIEW_CLOSE_EVENT, arg_25_0._viewName, arg_25_0._opType)

		arg_25_0._status = var_0_2.ViewStatusClose

		if arg_25_0._opType ~= var_0_3.ViewOpOpen then
			arg_25_0._openParam = nil
		end

		if arg_25_0._isNeedDestory then
			arg_25_0:destroy()
		end
	end
end

function var_0_6.setSiblingIndex(arg_26_0, arg_26_1)
	if arg_26_0.mainGO then
		arg_26_0.mainGO.transform:SetSiblingIndex(arg_26_1)
	end
end

function var_0_6.getSiblingIndex(arg_27_0)
	local var_27_0 = 0

	if arg_27_0.mainGO then
		var_27_0 = arg_27_0.mainGO.transform:GetSiblingIndex()
	end

	return var_27_0
end

function var_0_6.getOpenParam(arg_28_0)
	return arg_28_0._openParam
end

function var_0_6.getFirstParam(arg_29_0)
	return arg_29_0._openParam and arg_29_0._openParam[1]
end

function var_0_6.getRes(arg_30_0, arg_30_1)
	return arg_30_0._resDict[arg_30_1]
end

function var_0_6.getPrefab(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0._resDict[arg_31_1]

	return var_31_0 and var_31_0:GetMainAsset()
end

function var_0_6.getResInstance(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0._resDict[arg_32_1]
	local var_32_1 = var_32_0 and var_32_0:GetMainAsset()

	return var_32_1 and goutil.clone(var_32_1)
end

function var_0_6.registerLocalNotify(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	GlobalDispatcher:addEventListener(UIDUtil.getUidJoint(arg_33_1, arg_33_0._viewName), arg_33_2, arg_33_3)
end

function var_0_6.unregisterLocalNotify(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	GlobalDispatcher:removeEventListener(UIDUtil.getUidJoint(arg_34_1, arg_34_0._viewName), arg_34_2, arg_34_3)
end

function var_0_6.localNotify(arg_35_0, arg_35_1, ...)
	GlobalDispatcher:dispatchEvent(UIDUtil.getUidJoint(arg_35_1, arg_35_0._viewName), ...)
end

function var_0_6.playEnterAnimation(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_0._guiAnimation then
		local var_36_0 = var_0_0.QuickOpenType == arg_36_1 and var_0_5.TimeToEnd or var_0_5.TimeToStart

		if arg_36_0._guiAnimation:PlayOpenAni(var_36_0) then
			if arg_36_2 then
				arg_36_0._guiAnimation:StopTimelineAni()
			end
		else
			arg_36_0:_onEnterAnimationDone()
		end
	else
		arg_36_0:_onEnterAnimationDone()
	end
end

function var_0_6.playCloseAnimation(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_0._guiAnimation then
		local var_37_0 = var_0_1.QuickCloseType == arg_37_1 and var_0_5.TimeToEnd or var_0_5.TimeToStart

		if arg_37_0._guiAnimation:PlayCloseAni(var_37_0) then
			if arg_37_2 then
				arg_37_0._guiAnimation:StopTimelineAni()
			end
		else
			arg_37_0:_onCloseAnimationDone()
		end
	else
		arg_37_0:_onCloseAnimationDone()
	end
end

function var_0_6.jumpOpenAniToEnd(arg_38_0)
	local var_38_0 = arg_38_0:getGuiAnimation()

	if var_38_0 then
		var_38_0:JumpAniTimeToEnd()
	end
end

function var_0_6.dependWhatResources(arg_39_0)
	return nil
end

function var_0_6.attachToWhichRoot(arg_40_0)
	return ViewRootType.Popup
end

function var_0_6.buildViews(arg_41_0)
	return nil
end

function var_0_6.onClickOutside(arg_42_0)
	ViewMgr.instance:close(arg_42_0:getViewName())
end

return var_0_6

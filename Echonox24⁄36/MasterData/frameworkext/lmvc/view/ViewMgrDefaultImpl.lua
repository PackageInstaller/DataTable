module("frameworkext.lmvc.view.ViewMgrDefaultImpl", package.seeall)

local var_0_0 = 1000
local var_0_1 = 5
local var_0_2 = "#00000096"
local var_0_3 = WindowType.WindowOpenReasonType
local var_0_4 = WindowType.WindowCloseReasonType

local function var_0_5(arg_1_0, arg_1_1)
	return arg_1_0.viewName == arg_1_1
end

local var_0_6 = class("ViewMgrDefaultImpl", ViewMgrBase)

function var_0_6.ctor(arg_2_0)
	var_0_6.super.ctor(arg_2_0)

	arg_2_0._maskColor = nil
	arg_2_0._grayMaskGO = nil
	arg_2_0._grayMaskImg = nil
	arg_2_0._maskGoRootName = ViewRootType.Hud
	arg_2_0._uiRoot = nil
	arg_2_0._curOpenViews = {}
	arg_2_0._curOpenFullScreenViews = {}
	arg_2_0._viewRootNames = {
		"HUD",
		"HUDTOP",
		"FULLSCREEN",
		"POPUP",
		"POPUPTOP",
		"NOTIFY",
		"NOTIFYTOP",
		"TOP",
		"TOPMOST"
	}
	arg_2_0._viewRoots = {}
	arg_2_0._uiCanvas = nil
	arg_2_0._cacheFullNum = 0
	arg_2_0._recordCacheDestoryViews = nil
	arg_2_0._curFullscreenNeedDestoryViewMap = nil
end

function var_0_6.init(arg_3_0, arg_3_1)
	var_0_6.super.init(arg_3_0, arg_3_1)

	arg_3_0._cacheFullNum = arg_3_1 or var_0_1
	arg_3_0._maskColor = arg_3_0:_getDefaultMaskColor()
	arg_3_0._recordCacheDestoryViews = {}
	arg_3_0._isAllBackPath = true
	arg_3_0._curFullscreenNeedDestoryViewMap = {}
	arg_3_0._uiRoot = goutil.find("UIROOT")
	arg_3_0._uiCanvas = arg_3_0._uiRoot:GetComponent("Canvas")
	Astral.UIGlobalTouchTrigger.uiCanvas = arg_3_0._uiCanvas
	Astral.UIGlobalTouchTrigger.uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	local var_3_0 = arg_3_0._uiRoot.transform

	arg_3_0._uiWidth = var_3_0.rect.width
	arg_3_0._uiHeight = var_3_0.rect.height

	local var_3_1 = #arg_3_0._viewRootNames

	for iter_3_0 = 1, var_3_1 do
		local var_3_2 = goutil.findChild(arg_3_0._uiRoot, arg_3_0._viewRootNames[iter_3_0])

		if var_3_2 then
			arg_3_0._viewRoots[iter_3_0] = var_3_2
		end
	end

	GlobalDispatcher:addEventListener(EventType.FW_VIEW_OPENING_EVENT, arg_3_0._openingViewHandler, arg_3_0)
	GlobalDispatcher:addEventListener(EventType.FW_VIEW_OPEN_OVER_EVENT, arg_3_0._openViewOverHandler, arg_3_0)
	GlobalDispatcher:addEventListener(EventType.FW_VIEW_CLOSE_EVENT, arg_3_0._closeViewOverHandler, arg_3_0)
end

function var_0_6.getUICanvas(arg_4_0)
	return arg_4_0._uiCanvas
end

function var_0_6.getUIWidth(arg_5_0)
	return arg_5_0._uiWidth
end

function var_0_6.getUIHeight(arg_6_0)
	return arg_6_0._uiHeight
end

function var_0_6.getRoot(arg_7_0, arg_7_1)
	return arg_7_0._viewRoots[arg_7_1]
end

function var_0_6.getUIRoot(arg_8_0)
	return arg_8_0._uiRoot
end

function var_0_6.isFullScreen(arg_9_0, arg_9_1)
	return ViewSetting.instance:isFullScreen(arg_9_1)
end

function var_0_6.removeTopFullScreenView(arg_10_0, arg_10_1)
	local var_10_0 = false
	local var_10_1 = arg_10_0._backStack:getSize()
	local var_10_2 = false

	for iter_10_0 = var_10_1, 1, -1 do
		local var_10_3 = arg_10_0._backStack:getDataByIndex(iter_10_0)

		if var_10_3.viewName == arg_10_1 then
			var_10_0 = true

			arg_10_0._backStack:removeByIndex(iter_10_0)

			break
		end

		if ViewSetting.instance:isFullScreen(var_10_3.viewName) then
			break
		end
	end

	return var_10_0
end

function var_0_6.clearSomeViewFromBackStack(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0:isOpen(arg_11_1) then
		return
	end

	if ViewSetting.instance:isFullScreen(arg_11_1) then
		arg_11_0:_dealViewBetweenFullscreen(arg_11_1, arg_11_2, arg_11_0._destoryViewBetweenIndex, arg_11_0)
	else
		arg_11_0:removeTopFullScreenView(arg_11_1)
	end
end

function var_0_6.setOpenViewChecker(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._openHandler = arg_12_1
	arg_12_0._openHandlerObj = arg_12_2
end

function var_0_6.clearOpenViewChecker(arg_13_0)
	arg_13_0._openHandler = nil
	arg_13_0._openHandlerObj = nil
end

function var_0_6.openCheck(arg_14_0, arg_14_1, ...)
	if arg_14_0._openHandler == nil then
		return true
	end

	local var_14_0

	if arg_14_0._openHandlerObj then
		var_14_0 = arg_14_0._openHandler(arg_14_0._openHandlerObj, arg_14_1, ...)
	else
		var_14_0 = arg_14_0._openHandler(arg_14_1, ...)
	end

	if var_14_0 == nil then
		return true
	end

	return var_14_0
end

function var_0_6.clear(arg_15_0)
	var_0_6.super.clear(arg_15_0)

	arg_15_0._maskColor = nil
	arg_15_0._grayMaskGO = nil
	arg_15_0._grayMaskImg = nil
	arg_15_0._maskGoRootName = nil
	arg_15_0._uiRoot = nil
	arg_15_0._curOpenViews = nil
	arg_15_0._curOpenFullScreenViews = nil
	arg_15_0._viewRootNames = nil
	arg_15_0._viewRoots = nil
	arg_15_0._uiCanvas = nil
	arg_15_0._cacheFullNum = 0
	arg_15_0._recordCacheDestoryViews = nil
	arg_15_0._curFullscreenNeedDestoryViewMap = nil

	GlobalDispatcher:removeEventListener(EventType.FW_VIEW_OPENING_EVENT, arg_15_0._openingViewHandler, arg_15_0)
	GlobalDispatcher:removeEventListener(EventType.FW_VIEW_OPEN_OVER_EVENT, arg_15_0._openViewOverHandler, arg_15_0)
	GlobalDispatcher:removeEventListener(EventType.FW_VIEW_CLOSE_EVENT, arg_15_0._closeViewOverHandler, arg_15_0)
end

function var_0_6._recordCurFullscreenNeedDestoryViews(arg_16_0, arg_16_1)
	arg_16_0._curFullscreenNeedDestoryViewMap[arg_16_1] = true
end

function var_0_6._dealViewBetweenFullscreen(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = arg_17_0._backStack:getSize()
	local var_17_1 = false
	local var_17_2 = var_17_0

	for iter_17_0 = var_17_0, 1, -1 do
		local var_17_3 = arg_17_0._backStack:getDataByIndex(iter_17_0)

		if arg_17_1 == var_17_3.viewName then
			if var_17_2 <= iter_17_0 then
				var_17_2 = iter_17_0
			end

			if arg_17_3 and arg_17_4 then
				arg_17_3(arg_17_4, iter_17_0, var_17_2)
			else
				arg_17_0._backStack:removeBetweenIndex(iter_17_0, var_17_2)
			end

			if arg_17_2 then
				break
			end

			var_17_2 = iter_17_0 - 1
		elseif arg_17_0:isFullScreen(var_17_3.viewName) then
			var_17_2 = iter_17_0 - 1
		end
	end
end

function var_0_6._destoryFullscreenNeedViews(arg_18_0)
	local var_18_0 = false

	for iter_18_0, iter_18_1 in pairs(arg_18_0._curFullscreenNeedDestoryViewMap) do
		if iter_18_1 then
			if arg_18_0._views[iter_18_0] and not arg_18_0:_isResidentResourceType(iter_18_0) and not arg_18_0._backStack:findByValue(iter_18_0, var_0_5) then
				arg_18_0:destroy(iter_18_0)
			end

			arg_18_0._curFullscreenNeedDestoryViewMap[iter_18_0] = nil
		end
	end
end

function var_0_6._recordNeedDestoryViewsBetween(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = false

	for iter_19_0 = arg_19_2, arg_19_1, -1 do
		local var_19_1 = arg_19_0._backStack:getDataByIndex(iter_19_0)

		arg_19_0:_recordCurFullscreenNeedDestoryViews(var_19_1.viewName)
		arg_19_0._backStack:removeByIndex(iter_19_0)
	end
end

function var_0_6._isImmediateDestoryResourceType(arg_20_0, arg_20_1)
	return ViewSetting.instance:isImmediateDestoryResourceType(arg_20_1)
end

function var_0_6._isResidentResourceType(arg_21_0, arg_21_1)
	return ViewSetting.instance:isResidentResourceType(arg_21_1)
end

function var_0_6._updateMaskGO(arg_22_0, arg_22_1, arg_22_2)
	if ViewSetting.instance:isModal(arg_22_1) then
		local var_22_0 = arg_22_0._views[arg_22_1]

		if var_22_0 then
			local var_22_1 = arg_22_0:_getMaskGO()
			local var_22_2 = var_22_0:attachToWhichRoot()
			local var_22_3 = var_22_0:getSiblingIndex()
			local var_22_4 = arg_22_0:_getMaskGOSiblingIndex()

			if var_22_2 and arg_22_0._maskGoRootName ~= var_22_2 then
				goutil.addChildToParent(var_22_1, arg_22_0:getRoot(var_22_2))

				arg_22_0._maskGoRootName = var_22_2
			else
				var_22_3 = var_22_4 < var_22_3 and var_22_3 - 1 or var_22_3
			end

			local var_22_5 = ViewSetting.instance:getMaskColor(arg_22_1) or arg_22_0:_getDefaultMaskColor()

			if arg_22_0._maskColor ~= var_22_5 then
				arg_22_0._maskColor = var_22_5

				Astral.ColorUtil.SetImageColor(arg_22_0._grayMaskImg, arg_22_0._maskColor)
			end

			goutil.setActive(var_22_1, true)
			arg_22_0:_setMaskGOSiblingIndex(var_22_3)
		end
	end
end

function var_0_6._openingViewHandler(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if arg_23_0:isOpen(arg_23_2) then
		if not arg_23_4 then
			arg_23_0._views[arg_23_2]:setSiblingIndex(var_0_0)
		end

		arg_23_0:_updateMaskGO(arg_23_2, true)
	end
end

function var_0_6._openViewOverHandler(arg_24_0, arg_24_1, arg_24_2)
	if ViewSetting.instance:isFullScreen(arg_24_2) then
		arg_24_0:_closePreFullUpView(arg_24_2)
		arg_24_0:_dealViewStackRemove(arg_24_2)
		arg_24_0:_destoryCacheFullView(arg_24_2)
		GlobalDispatcher:dispatchEvent(EventType.FW_VIEW_OEPN_FULL_SCREEN_EVENT, arg_24_2)
	elseif ViewSetting.instance:isRepel(arg_24_2) then
		local var_24_0 = arg_24_0:_findPreView(arg_24_2)

		if var_24_0 and ViewSetting.instance:isRepel(var_24_0.viewName) then
			arg_24_0:close(var_24_0.viewName, false, var_0_4.QuickCloseType, ViewSetting.instance:isSupportBack(var_24_0.viewName))
		end
	end

	arg_24_0:_dealBlock(arg_24_2, false)
end

function var_0_6._closeViewOverHandler(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0:_dealBlock(arg_25_2, false)
end

function var_0_6._closePreFullUpView(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0._backStack:getSize()
	local var_26_1 = false
	local var_26_2 = false

	for iter_26_0 = var_26_0, 1, -1 do
		local var_26_3 = arg_26_0._backStack:getDataByIndex(iter_26_0)

		if var_26_2 then
			if ViewSetting.instance:isFullScreen(var_26_3.viewName) and not arg_26_0:isOpen(var_26_3.viewName) then
				break
			end

			if var_26_3.viewName ~= arg_26_1 then
				arg_26_0:close(var_26_3.viewName, false, var_0_4.QuickCloseType, true)
			end

			if not ViewSetting.instance:isSupportBack(var_26_3.viewName) then
				arg_26_0._backStack:removeByIndex(iter_26_0)
			end
		end

		if var_26_3.viewName == arg_26_1 then
			var_26_2 = true
		end
	end
end

function var_0_6._dealViewStackRemove(arg_27_0, arg_27_1)
	if not arg_27_0._isAllBackPath then
		if ViewSetting.instance:isFullScreen(arg_27_1) then
			arg_27_0:_dealViewBetweenFullscreen(arg_27_1, true)
		else
			arg_27_0:removeTopFullScreenView(arg_27_1)
		end
	end
end

function var_0_6._destoryCacheFullView(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0._backStack:getSize()

	arg_28_0:printDebugInfo()

	if var_28_0 > arg_28_0._cacheFullNum then
		local var_28_1
		local var_28_2 = 1
		local var_28_3 = true

		for iter_28_0 = var_28_0, 1, -1 do
			local var_28_4 = arg_28_0._backStack:getDataByIndex(iter_28_0)

			if var_28_4 then
				if var_28_2 > arg_28_0._cacheFullNum then
					table.insert(arg_28_0._recordCacheDestoryViews, var_28_4.viewName)

					if arg_28_0:isOpen(var_28_4.viewName) then
						var_28_3 = false
					end

					if ViewSetting.instance:isFullScreen(var_28_4.viewName) then
						if var_28_3 then
							for iter_28_1, iter_28_2 in ipairs(arg_28_0._recordCacheDestoryViews) do
								arg_28_0:destroy(iter_28_2, false, var_0_4.QuickCloseType)
							end
						end

						var_28_3 = true

						table.clear(arg_28_0._recordCacheDestoryViews)
					end
				elseif ViewSetting.instance:isFullScreen(var_28_4.viewName) then
					var_28_2 = var_28_2 + 1
				end
			end
		end
	end
end

function var_0_6._createViewObj(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0._views[arg_29_1]

	if not var_29_0 then
		local var_29_1 = ViewSetting.instance:getPresentorName(arg_29_1)

		if var_29_1 then
			local var_29_2 = _G[var_29_1]

			if var_29_2 then
				var_29_0 = var_29_2.New()

				var_29_0:setViewName(arg_29_1)
				var_29_0:setMainGO(arg_29_2)

				arg_29_0._views[arg_29_1] = var_29_0
			end
		end
	end

	return var_29_0
end

function var_0_6._dealBlock(arg_30_0, arg_30_1, arg_30_2)
	if ViewSetting.instance:isBlock(arg_30_1) then
		ViewBlockMgr.instance:blockClick(arg_30_2, arg_30_1)
	end
end

function var_0_6._beforeOpen(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if not arg_31_3 then
		arg_31_0:_dealBlock(arg_31_1, true)
	end

	GlobalDispatcher:dispatchEvent(EventType.FW_VIEW_WILL_OPEN_EVENT, arg_31_1, arg_31_2, arg_31_3)
end

function var_0_6._findTopFullScreenIndex(arg_32_0)
	local var_32_0 = 0
	local var_32_1 = arg_32_0._backStack:getSize()
	local var_32_2 = false

	for iter_32_0 = var_32_1, 1, -1 do
		local var_32_3 = arg_32_0._backStack:getDataByIndex(iter_32_0)

		if ViewSetting.instance:isFullScreen(var_32_3.viewName) then
			var_32_0 = iter_32_0

			break
		end
	end

	return var_32_0
end

function var_0_6._beforeClose(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	arg_33_0:_dealBlock(arg_33_1, true)
end

function var_0_6._afterClose(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	if arg_34_0:isFullScreen(arg_34_1) then
		if not arg_34_4 then
			arg_34_0:_dealViewBetweenFullscreen(arg_34_1, true, arg_34_0._recordNeedDestoryViewsBetween, arg_34_0)
			arg_34_0:_destoryFullscreenNeedViews()
		end

		if arg_34_2 then
			arg_34_0:_openPreFullUpView()
		end
	else
		local var_34_0

		if arg_34_2 then
			var_34_0 = arg_34_0:_findPreView(arg_34_1)
		end

		if not arg_34_4 and arg_34_0:removeTopFullScreenView(arg_34_1) then
			arg_34_0:_recordCurFullscreenNeedDestoryViews(arg_34_1)
		end

		arg_34_0:_dealModalViewForClose(arg_34_1)

		if var_34_0 and not arg_34_0:isOpen(var_34_0.viewName) and not arg_34_0:isFullScreen(var_34_0.viewName) then
			arg_34_0:backOpen(var_34_0.viewName, unpack(var_34_0.openParam))
		end
	end
end

function var_0_6._openPreFullUpView(arg_35_0)
	local var_35_0 = arg_35_0:_findTopFullScreenIndex()

	if var_35_0 ~= 0 then
		local var_35_1 = arg_35_0._backStack:getSize()
		local var_35_2 = false
		local var_35_3 = arg_35_0._backStack:cloneBetweenData(var_35_0, var_35_1)

		for iter_35_0, iter_35_1 in ipairs(var_35_3) do
			arg_35_0:backOpen(iter_35_1.viewName, unpack(iter_35_1.openParam))
		end
	end
end

function var_0_6._findPreView(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0._backStack:findByValue(arg_36_1, var_0_5)
	local var_36_1

	if var_36_0 then
		var_36_1 = arg_36_0._backStack:getDataByIndex(var_36_0 - 1)
	end

	return var_36_1
end

function var_0_6._findPreModalView(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = false
	local var_37_1 = false

	if ViewSetting.instance:isModal(arg_37_1) then
		local var_37_2 = arg_37_0._backStack:getSize()
		local var_37_3 = false

		for iter_37_0 = var_37_2, 1, -1 do
			local var_37_4 = arg_37_0._backStack:getDataByIndex(iter_37_0)

			if var_37_4.viewName == arg_37_1 then
				var_37_1 = true
				var_37_0 = var_37_4.viewName
			elseif ViewSetting.instance:isModal(var_37_4.viewName) then
				if var_37_1 then
					var_37_0 = var_37_4.viewName

					break
				end

				var_37_0 = false

				break
			end
		end
	end

	return var_37_0
end

function var_0_6._findPreShowModalView(arg_38_0)
	local var_38_0 = arg_38_0._backStack:getSize()
	local var_38_1 = false
	local var_38_2 = false
	local var_38_3 = 0

	for iter_38_0 = var_38_0, 1, -1 do
		local var_38_4 = arg_38_0._backStack:getDataByIndex(iter_38_0)

		if ViewSetting.instance:isFullScreen(var_38_4.viewName) then
			break
		end

		if ViewSetting.instance:isModal(var_38_4.viewName) then
			local var_38_5 = arg_38_0._views[var_38_4.viewName]

			if var_38_5 and var_38_5:isOpen() then
				var_38_2 = var_38_4.viewName
				var_38_3 = iter_38_0

				break
			end
		end
	end

	return var_38_2, var_38_3
end

function var_0_6._dealModalViewForClose(arg_39_0, arg_39_1)
	if ViewSetting.instance:isModal(arg_39_1) then
		local var_39_0, var_39_1 = arg_39_0:_findPreShowModalView()

		if var_39_0 then
			arg_39_0:_updateMaskGO(var_39_0, false)
		else
			goutil.setActive(arg_39_0._grayMaskGO, false)
		end
	end
end

function var_0_6._getMaskGO(arg_40_0)
	if not arg_40_0._grayMaskGO then
		arg_40_0._grayMaskGO = goutil.create("ViewModalMask")

		local var_40_0 = arg_40_0:getRoot(arg_40_0._maskGoRootName)

		goutil.addChildToParent(arg_40_0._grayMaskGO, var_40_0)

		arg_40_0._grayMaskImg = goutil.addComponentOnce(arg_40_0._grayMaskGO, typeof(UnityEngine.UI.Image))

		Astral.ColorUtil.SetImageColor(arg_40_0._grayMaskImg, arg_40_0._maskColor)

		local var_40_1 = arg_40_0._grayMaskGO.transform

		var_40_1.anchorMin = UnityEngine.Vector2.zero
		var_40_1.anchorMax = UnityEngine.Vector2.one
		var_40_1.offsetMin = UnityEngine.Vector2.New(-150, -150)
		var_40_1.offsetMax = UnityEngine.Vector2.New(150, 150)

		Astral.UIClickTrigger.Get(arg_40_0._grayMaskGO):AddClickListener(arg_40_0._onClickGrayMask, arg_40_0, nil)
	end

	return arg_40_0._grayMaskGO
end

function var_0_6._setMaskGOSiblingIndex(arg_41_0, arg_41_1)
	if arg_41_0._grayMaskGO then
		arg_41_0._grayMaskGO.transform:SetSiblingIndex(arg_41_1)
	end
end

function var_0_6._getMaskGOSiblingIndex(arg_42_0)
	local var_42_0 = 0

	if arg_42_0._grayMaskGO then
		var_42_0 = arg_42_0._grayMaskGO.transform:GetSiblingIndex()
	end

	return var_42_0
end

function var_0_6._onClickGrayMask(arg_43_0)
	if not arg_43_0._backStack:isEmpty() then
		local var_43_0 = arg_43_0._backStack:getSize()
		local var_43_1 = false
		local var_43_2 = false

		for iter_43_0 = var_43_0, 1, -1 do
			local var_43_3 = arg_43_0._backStack:getDataByIndex(iter_43_0)
			local var_43_4 = arg_43_0._views[var_43_3.viewName]

			if var_43_4 then
				var_43_4:onClickOutside()

				break
			end
		end
	end
end

function var_0_6._destoryViewBetweenIndex(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = false

	for iter_44_0 = arg_44_2, arg_44_1, -1 do
		local var_44_1 = arg_44_0._backStack:getDataByIndex(iter_44_0)

		if var_44_1 then
			arg_44_0._backStack:removeByIndex(iter_44_0)
			arg_44_0:destroy(var_44_1.viewName, false, var_0_4.QuickCloseType)
		end
	end
end

function var_0_6._getDefaultMaskColor(arg_45_0)
	return var_0_2
end

return var_0_6

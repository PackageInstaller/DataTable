module("logic.common.logic.FrameworkReLogicMgr", package.seeall)

local var_0_0 = _M

function var_0_0.reLogicExtFuc()
	ViewMgr._org_open = ViewMgr.open

	function ViewMgr.setEnterChecker(arg_2_0, arg_2_1, arg_2_2)
		arg_2_0._enterChecker = arg_2_1
		arg_2_0._enterCheckerObj = arg_2_2
	end

	function ViewMgr.clearEnterChecker(arg_3_0)
		arg_3_0._enterChecker = nil
		arg_3_0._enterCheckerObj = nil
	end

	function ViewMgr.openCheck(arg_4_0, arg_4_1)
		local var_4_0 = true

		if arg_4_0._enterChecker then
			if arg_4_0._enterCheckerObj then
				var_4_0 = arg_4_0._enterChecker(arg_4_0._enterCheckerObj, arg_4_1)
			else
				var_4_0 = arg_4_0._enterChecker(arg_4_1)
			end
		end

		return var_4_0
	end

	function ViewMgr.open(arg_5_0, arg_5_1, ...)
		local var_5_0 = arg_5_0:isReadyToOpenSoonFlag(arg_5_1)
		local var_5_1 = arg_5_0:openCheck(arg_5_1)

		if not var_5_0 and var_5_1 ~= nil and var_5_1 == false then
			return
		end

		arg_5_0:_org_open(arg_5_1, ...)
		GlobalDispatcher:dispatch(GlobalNotify.OnOpenViewBegin, arg_5_1)
	end

	function ViewMgr.isOpenFinish(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_0._views[arg_6_1]

		if not var_6_0 then
			return false
		end

		return var_6_0._status == ViewPresentor.kViewStatusOpen
	end

	function ViewComponent.getToggle(arg_7_0, arg_7_1)
		return ToggleAdapterEx.GetFrom(arg_7_0.mainGO, arg_7_1)
	end

	function ViewComponent.getToggleByContainAndPath(arg_8_0, arg_8_1, arg_8_2)
		return ToggleAdapterEx.GetFrom(arg_8_1, arg_8_2)
	end

	function ViewComponent.getToggleByGo(arg_9_0, arg_9_1)
		return ToggleAdapterEx.Get(arg_9_1)
	end

	function ViewComponent.getBigBg(arg_10_0, arg_10_1)
		if arg_10_0._allBigBgRef == nil then
			arg_10_0._allBigBgRef = {}
		end

		local var_10_0 = Framework.ImageBigBG.GetFrom(arg_10_0.mainGO, arg_10_1)

		table.insert(arg_10_0._allBigBgRef, var_10_0)

		return var_10_0
	end

	function ViewComponent.getBigBgByContainAndPath(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0._allBigBgRef == nil then
			arg_11_0._allBigBgRef = {}
		end

		local var_11_0 = Framework.ImageBigBG.GetFrom(arg_11_1, arg_11_2)

		table.insert(arg_11_0._allBigBgRef, var_11_0)

		return var_11_0
	end

	function ViewComponent.getBigBgByGo(arg_12_0, arg_12_1)
		if arg_12_0._allBigBgRef == nil then
			arg_12_0._allBigBgRef = {}
		end

		local var_12_0 = Framework.ImageBigBG.Get(arg_12_1)

		table.insert(arg_12_0._allBigBgRef, var_12_0)

		return var_12_0
	end

	function ViewComponent.getDynIcon(arg_13_0, arg_13_1)
		if arg_13_0._allBigBgRef == nil then
			arg_13_0._allBigBgRef = {}
		end

		local var_13_0 = Framework.ImageDynIcon.GetFrom(arg_13_0.mainGO, arg_13_1)

		table.insert(arg_13_0._allBigBgRef, var_13_0)

		return var_13_0
	end

	function ViewComponent.getDynIconByContainAndPath(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0._allBigBgRef == nil then
			arg_14_0._allBigBgRef = {}
		end

		local var_14_0 = Framework.ImageDynIcon.GetFrom(arg_14_1, arg_14_2)

		table.insert(arg_14_0._allBigBgRef, var_14_0)

		return var_14_0
	end

	function ViewComponent.getDynIconByGo(arg_15_0, arg_15_1)
		if arg_15_0._allBigBgRef == nil then
			arg_15_0._allBigBgRef = {}
		end

		local var_15_0 = Framework.ImageDynIcon.Get(arg_15_1)

		table.insert(arg_15_0._allBigBgRef, var_15_0)

		return var_15_0
	end

	function ViewComponent.getImageWWWByGo(arg_16_0, arg_16_1)
		if arg_16_0._allBigBgRef == nil then
			arg_16_0._allBigBgRef = {}
		end

		local var_16_0 = Framework.ImageWWW.Get(arg_16_1)

		table.insert(arg_16_0._allBigBgRef, var_16_0)

		return var_16_0
	end

	ViewPresentor._org_onEnterAnimationDone = ViewPresentor._onEnterAnimationDone

	function ViewPresentor._onEnterAnimationDone(arg_17_0, arg_17_1)
		if arg_17_0._status ~= ViewPresentor.kViewStatusOpening then
			return
		end

		local var_17_0 = arg_17_0.mainGO:GetComponent(typeof(UnityEngine.Animator))

		if var_17_0 then
			ViewBlockMgr.instance:blockClick(false, ViewBlockKey.ViewOpenAnima)
			Framework.AnimationEventListener.Get(var_17_0.gameObject):RemoveListener()

			if not var_17_0:HasState(0, UnityEngine.Animator.StringToHash("open")) then
				print("<color=yellow>当打开完毕后，有animator情况发现没了 [open] 状态，警告无法保证动画拉回来，viewName======</color>", arg_17_0.viewName)
			else
				local var_17_1 = var_17_0:GetCurrentAnimatorStateInfo(0)

				if var_17_1.normalizedTime < 1 or not var_17_1:IsName("open") then
					var_17_0:Play("open", 0, 1)
					var_17_0:Update(0)
				end
			end
		end

		ViewPresentor._org_onEnterAnimationDone(arg_17_0, arg_17_1)
	end

	function DataBinderView.onExit(arg_18_0)
		DataBinderView.onExitFinished(arg_18_0)
	end

	DataBinderView.org_destroyUI = DataBinderView.destroyUI

	function DataBinderView.destroyUI(arg_19_0)
		DataBinderView.onExit(arg_19_0)
		DataBinderView.org_destroyUI(arg_19_0)

		if arg_19_0._allBigBgRef then
			for iter_19_0 = 1, #arg_19_0._allBigBgRef do
				if arg_19_0._allBigBgRef[iter_19_0] and not goutil.isNil(arg_19_0._allBigBgRef[iter_19_0]) then
					arg_19_0._allBigBgRef[iter_19_0]:ClearImage()
				end
			end

			table.clear(arg_19_0._allBigBgRef)

			arg_19_0._allBigBgRef = nil
		end
	end

	function ViewPresentor.destroy(arg_20_0)
		if arg_20_0._views then
			local var_20_0 = #arg_20_0._views

			for iter_20_0 = 1, var_20_0 do
				if arg_20_0._views[iter_20_0]._allBigBgRef then
					for iter_20_1 = 1, #arg_20_0._views[iter_20_0]._allBigBgRef do
						if arg_20_0._views[iter_20_0]._allBigBgRef[iter_20_1] and not goutil.isNil(arg_20_0._views[iter_20_0]._allBigBgRef[iter_20_1]) then
							arg_20_0._views[iter_20_0]._allBigBgRef[iter_20_1]:ClearImage()
						end
					end

					table.clear(arg_20_0._views[iter_20_0]._allBigBgRef)

					arg_20_0._views[iter_20_0]._allBigBgRef = nil
				end

				arg_20_0._views[iter_20_0]:unbindEvents()
				arg_20_0._views[iter_20_0]:destroyUI()
			end

			arg_20_0._views = nil
		end

		if arg_20_0._resDict then
			for iter_20_2, iter_20_3 in pairs(arg_20_0._resDict) do
				iter_20_3:Release()
			end

			arg_20_0._resDict = nil
		end

		if arg_20_0._resLoader then
			ViewPresentor._loadingBlockNum = ViewPresentor._loadingBlockNum - 1

			arg_20_0._resLoader:clear()

			arg_20_0._resLoader = nil
		end

		goutil.destroy(arg_20_0.mainGO)

		arg_20_0._listBinderViews = nil

		if VideoPlayer.instance:isOnPlayStatus() then
			-- block empty
		elseif SceneMgr.instance:getCurSceneType() ~= SceneType.Battle then
			ResPreLoadMgr.gc()
		elseif PerformanceMgr.MyQuality == PerformanceMgr.Low then
			ResPreLoadMgr.gc()
		end
	end

	ViewPresentor._org_onCloseAnimationDone = ViewPresentor._onCloseAnimationDone

	function ViewPresentor._onCloseAnimationDone(arg_21_0, arg_21_1)
		if arg_21_0._status ~= ViewPresentor.kViewStatusClosing then
			return
		end

		local var_21_0 = arg_21_0.mainGO:GetComponent(typeof(UnityEngine.Animator))

		if var_21_0 then
			ViewBlockMgr.instance:blockClick(false, ViewBlockKey.ViewCloseAnima)
			Framework.AnimationEventListener.Get(var_21_0.gameObject):RemoveListener()

			if not var_21_0:HasState(0, UnityEngine.Animator.StringToHash("close")) then
				print("<color=yellow>当关闭完毕后，有animator情况发现没了 [close] 状态，警告无法保证动画拉回来，viewName======</color>", arg_21_0.viewName)
			else
				local var_21_1 = var_21_0:GetCurrentAnimatorStateInfo(0)

				if var_21_1.normalizedTime < 1 or not var_21_1:IsName("close") then
					var_21_0:Play("close", 0, 1)
					var_21_0:Update(0)
				end
			end
		end

		ViewPresentor._org_onCloseAnimationDone(arg_21_0, arg_21_1)
	end

	function ViewPresentor._onAnimationDoneForEnter(arg_22_0, arg_22_1)
		if arg_22_1.stringParameter == "end" then
			arg_22_0:_onEnterAnimationDone()
		end
	end

	function ViewPresentor._onAnimationDoneForClose(arg_23_0, arg_23_1)
		if arg_23_1.stringParameter == "start" then
			arg_23_0:_onCloseAnimationDone()
		end
	end

	function ViewPresentor.playEnterAnimation(arg_24_0)
		if arg_24_0.mainGO then
			local var_24_0 = arg_24_0.mainGO:GetComponent(typeof(UnityEngine.Animator))

			if var_24_0 then
				ViewBlockMaskContainer.instance:setDelayTime(5)
				ViewBlockMgr.instance:blockClick(true, ViewBlockKey.ViewOpenAnima)
				Framework.AnimationEventListener.Get(var_24_0.gameObject):AddListener(arg_24_0._onAnimationDoneForEnter, arg_24_0)
				var_24_0:Play("open", 0, 0)
				var_24_0:Update(0)
				GameUtils.checkAnimatorCurClipHasEvents(var_24_0, arg_24_0.viewName, true)
			else
				arg_24_0:_onEnterAnimationDone()
			end
		end
	end

	function ViewPresentor.playCloseAnimation(arg_25_0)
		if arg_25_0.mainGO then
			local var_25_0 = arg_25_0.mainGO:GetComponent(typeof(UnityEngine.Animator))

			if var_25_0 then
				ViewBlockMaskContainer.instance:setDelayTime(5)
				ViewBlockMgr.instance:blockClick(true, ViewBlockKey.ViewCloseAnima)
				Framework.AnimationEventListener.Get(var_25_0.gameObject):AddListener(arg_25_0._onAnimationDoneForClose, arg_25_0)
				var_25_0:Play("close", 0, 0)
				var_25_0:Update(0)
				GameUtils.checkAnimatorCurClipHasEvents(var_25_0, arg_25_0.viewName, false)
			else
				arg_25_0:_onCloseAnimationDone()
			end
		end
	end

	function BaseAgent.sendMsg(arg_26_0, arg_26_1, arg_26_2)
		local var_26_0, var_26_1 = NetConnMgr.instance:getCmdInfo(arg_26_1)

		GlobalDispatcher:dispatch(GlobalNotify.OnAllAgentSendMsging, var_26_0, var_26_1, arg_26_1)

		if ReConnectionMgr.instance:isConnecting() then
			arg_26_2 = arg_26_2 or ConnectionType.Logic

			NetConnMgr.instance:sendMsg(arg_26_1, arg_26_2)
		end
	end

	ExtensionMgr.forceIgnoreTimeoutMsg = nil
	ExtensionMgr._org_handleMsg = ExtensionMgr._handleMsg

	function ExtensionMgr._handleMsg(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
		if ExtensionMgr.forceIgnoreTimeoutMsg then
			ExtensionMgr.forceIgnoreTimeoutMsg = nil

			printWarn("[这是警告]ExtensionMgr业务层的收到的消息被丢弃了，大概率是配置了超时接收的数据包处理，请检查======", arg_27_1, arg_27_2, arg_27_3, arg_27_4)

			return
		end

		ExtensionMgr._org_handleMsg(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
	end

	if enableDebug then
		ViewLifetimeMgr.instance._tickInterval = 0.01

		function ViewSetting.getAutoDestroyTime(arg_28_0, arg_28_1)
			local var_28_0 = arg_28_0._setting[arg_28_1]

			if var_28_0 then
				return var_28_0.autoDestroyTime and 1 or 0
			end

			return 0
		end
	end

	ViewMgr._org_closeAllModalViews = ViewMgr.closeAllModalViews

	function ViewMgr.closeAllModalViews(arg_29_0, arg_29_1)
		arg_29_0:_org_closeAllModalViews(arg_29_1)
		ReConnectionMgr.instance:checkIsLostConnectionMsgBox()
	end
end

return var_0_0

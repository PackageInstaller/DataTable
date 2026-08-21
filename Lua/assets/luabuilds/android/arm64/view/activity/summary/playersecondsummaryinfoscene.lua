local var_0_0 = class("PlayerSecondSummaryInfoScene", import("...base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "PlayerSecondSummaryUI"
end

function var_0_0.setActivity(arg_2_0, arg_2_1)
	arg_2_0.activityVO = arg_2_1

	return
end

function var_0_0.setPlayer(arg_3_0, arg_3_1)
	arg_3_0.palyerVO = arg_3_1

	return
end

function var_0_0.setSummaryInfo(arg_4_0, arg_4_1)
	arg_4_0.summaryInfoVO = arg_4_1

	return
end

function var_0_0.init(arg_5_0)
	arg_5_0.backBtn = arg_5_0._tf:Find("bg/back_btn")
	arg_5_0.pageContainer = arg_5_0._tf:Find("bg/main/pages")
	arg_5_0.pageFootContainer = arg_5_0._tf:Find("bg/main/foots")

	GetOrAddComponent(arg_5_0.pageFootContainer, typeof(CanvasGroup))
	setCanvasGroupAlpha(arg_5_0.pageFootContainer, 0)

	return
end

function var_0_0.didEnter(arg_6_0)
	if arg_6_0.summaryInfoVO then
		arg_6_0:initSummaryInfo()
	else
		arg_6_0:emit(PlayerSummaryInfoMediator.GET_PLAYER_SUMMARY_INFO)
	end

	onButton(arg_6_0, arg_6_0.backBtn, function()
		if arg_6_0:inAnim() then
			return
		end

		arg_6_0:closeView()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.inAnim(arg_8_0)
	return arg_8_0.inAniming or arg_8_0.currPage and arg_8_0.pages[arg_8_0.currPage]:inAnim()
end

function var_0_0.initSummaryInfo(arg_9_0)
	arg_9_0.loadingPage = SecondSummaryPage1.New(arg_9_0.pageContainer:Find("page1"))

	arg_9_0.loadingPage:Init(arg_9_0.summaryInfoVO)

	arg_9_0.pages = {}

	;(function(arg_10_0, arg_10_1, arg_10_2)
		setActive(arg_10_0, false)

		local var_10_0 = arg_10_1.New(arg_10_0)

		table.insert(arg_9_0.pages, var_10_0)
		var_10_0:Init(arg_10_2)

		return
	end)(arg_9_0.pageContainer:Find("page2"), SecondSummaryPage2, arg_9_0.summaryInfoVO)
	;(function(arg_10_0, arg_10_1, arg_10_2)
		setActive(arg_10_0, false)

		local var_10_0 = arg_10_1.New(arg_10_0)

		table.insert(arg_9_0.pages, var_10_0)
		var_10_0:Init(arg_10_2)

		return
	end)(arg_9_0.pageContainer:Find("page3"), SecondSummaryPage3, arg_9_0.summaryInfoVO)
	;(function(arg_10_0, arg_10_1, arg_10_2)
		setActive(arg_10_0, false)

		local var_10_0 = arg_10_1.New(arg_10_0)

		table.insert(arg_9_0.pages, var_10_0)
		var_10_0:Init(arg_10_2)

		return
	end)(arg_9_0.pageContainer:Find("page6"), SecondSummaryPage6, arg_9_0.summaryInfoVO)

	local var_9_0 = arg_9_0.pageContainer:Find("page4")

	setActive(var_9_0, false)

	local var_9_1 = 0

	if #arg_9_0.summaryInfoVO.medalList > 0 then
		var_9_1 = math.floor((#arg_9_0.summaryInfoVO.medalList - 1) / SecondSummaryPage4.PerPageCount) + 1
	end

	for iter_9_0 = 1, var_9_1 do
		(function(arg_10_0, arg_10_1, arg_10_2)
			setActive(arg_10_0, false)

			local var_10_0 = arg_10_1.New(arg_10_0)

			table.insert(arg_9_0.pages, var_10_0)
			var_10_0:Init(arg_10_2)

			return
		end)(cloneTplTo(var_9_0, arg_9_0.pageContainer, "page4_1_" .. iter_9_0), SecondSummaryPage4, setmetatable({
			pageType = SecondSummaryPage4.PageTypeFurniture,
			samePage = iter_9_0,
			activityVO = arg_9_0.activityVO
		}, {
			__index = arg_9_0.summaryInfoVO
		}))
	end

	local var_9_2 = 0

	if #arg_9_0.summaryInfoVO.iconFrameList > 0 then
		var_9_2 = math.floor((#arg_9_0.summaryInfoVO.iconFrameList - 1) / SecondSummaryPage4.PerPageCount) + 1
	end

	for iter_9_1 = 1, var_9_2 do
		(function(arg_10_0, arg_10_1, arg_10_2)
			setActive(arg_10_0, false)

			local var_10_0 = arg_10_1.New(arg_10_0)

			table.insert(arg_9_0.pages, var_10_0)
			var_10_0:Init(arg_10_2)

			return
		end)(cloneTplTo(var_9_0, arg_9_0.pageContainer, "page4_2_" .. iter_9_1), SecondSummaryPage4, setmetatable({
			pageType = SecondSummaryPage4.PageTypeIconFrame,
			samePage = iter_9_1,
			activityVO = arg_9_0.activityVO
		}, {
			__index = arg_9_0.summaryInfoVO
		}))
	end

	;(function(arg_10_0, arg_10_1, arg_10_2)
		setActive(arg_10_0, false)

		local var_10_0 = arg_10_1.New(arg_10_0)

		table.insert(arg_9_0.pages, var_10_0)
		var_10_0:Init(arg_10_2)

		return
	end)(arg_9_0.pageContainer:Find("page5"), SecondSummaryPage5, arg_9_0.summaryInfoVO)
	onButton(arg_9_0, arg_9_0.pageContainer:Find("page5/share"), function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeSecondSummary)

		return
	end, SFX_CONFIRM)
	seriesAsync({
		function(arg_12_0)
			arg_9_0.inAniming = true

			arg_9_0.loadingPage:Show(arg_12_0)

			return
		end,
		function(arg_13_0)
			arg_9_0.inAniming = false

			arg_9_0.loadingPage:Hide()
			arg_13_0()

			return
		end
	}, function()
		arg_9_0:registerDrag()
		arg_9_0:registerFootEvent(1)

		return
	end)

	return
end

function var_0_0.registerFootEvent(arg_15_0, arg_15_1)
	local var_15_0 = UIItemList.New(arg_15_0.pageFootContainer, arg_15_0.pageFootContainer:Find("dot"))

	var_15_0:make(function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = arg_16_1 + 1

		if arg_16_0 == UIItemList.EventUpdate then
			onToggle(arg_15_0, arg_16_2, function(arg_17_0)
				if arg_17_0 then
					arg_15_0.pages[var_16_0]:Show()

					arg_15_0.currPage = var_16_0
				else
					arg_15_0.pages[var_16_0]:Hide()
				end

				return
			end)
		end

		return
	end)
	var_15_0:align(#arg_15_0.pages)
	setCanvasGroupAlpha(arg_15_0.pageFootContainer, 1)
	triggerToggle(arg_15_0.pageFootContainer:GetChild(arg_15_1 - 1), true)

	return
end

function var_0_0.registerDrag(arg_18_0)
	arg_18_0:addVerticalDrag(arg_18_0._tf:Find("bg"), function()
		arg_18_0:updatePageFoot(arg_18_0.currPage - 1)

		return
	end, function()
		arg_18_0:updatePageFoot(arg_18_0.currPage + 1)

		return
	end)

	return
end

function var_0_0.updatePageFoot(arg_21_0, arg_21_1)
	if arg_21_0:inAnim() or not arg_21_0.pages[arg_21_1] then
		return
	end

	triggerToggle(arg_21_0.pageFootContainer:GetChild(arg_21_1 - 1), true)

	return
end

function var_0_0.addVerticalDrag(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = GetOrAddComponent(arg_22_1, "EventTriggerListener")
	local var_22_1
	local var_22_2 = 0
	local var_22_3 = 50

	var_22_0:AddBeginDragFunc(function(arg_23_0, arg_23_1)
		var_22_2 = 0
		var_22_1 = arg_23_1.position

		return
	end)
	var_22_0:AddDragFunc(function(arg_24_0, arg_24_1)
		var_22_2 = arg_24_1.position.x - var_22_1.x

		return
	end)
	var_22_0:AddDragEndFunc(function(arg_25_0, arg_25_1)
		if var_22_2 < -var_22_3 then
			if arg_22_3 then
				arg_22_3()
			end
		elseif var_22_2 > var_22_3 and arg_22_2 then
			arg_22_2()
		end

		return
	end)

	return
end

function var_0_0.willExit(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.pages) do
		iter_26_1:Dispose()
	end

	arg_26_0.pages = nil
	arg_26_0.currPage = nil

	return
end

return var_0_0

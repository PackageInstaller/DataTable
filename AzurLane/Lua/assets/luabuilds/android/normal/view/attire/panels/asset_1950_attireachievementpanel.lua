class = var_0_10000

local var_0_0 = "AttireAchievementPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

local function var_0_2(arg_1_0)
	local var_1_0 = {}

	local function var_1_1(arg_2_0)
		arg_2_0._go = arg_1_0
		arg_2_0._tf = arg_2_0._go.transform

		local var_2_0 = arg_2_0._tf

		arg_2_0.info = var_1.Find(var_2_0, "info")

		local var_2_1 = arg_2_0._tf

		arg_2_0.empty = var_1.Find(var_2_1, "empty")

		local var_2_2 = arg_2_0._tf

		arg_2_0.icon = var_1.Find(var_2_2, "info/icon")

		local var_2_3 = arg_2_0._tf

		arg_2_0.now = var_1.Find(var_2_3, "info/now")

		local var_2_4 = arg_2_0._tf

		arg_2_0.selected = var_1.Find(var_2_4, "info/selected")

		local var_2_5 = arg_2_0._tf

		arg_2_0.nameTxt = var_1.Find(var_2_5, "info/label/Text")

		local var_2_6 = {}
		local var_2_7 = arg_2_0._tf

		var_2_6[1] = var_2.Find(var_2_7, "info/tags/new")

		local var_2_8 = arg_2_0._tf

		var_2_6[2] = var_2.Find(var_2_8, "info/tags/e")
		arg_2_0.tags = var_2_6

		local var_2_9 = arg_2_0._tf

		arg_2_0.print5 = var_1.Find(var_2_9, "prints/line5")

		local var_2_10 = arg_2_0._tf

		arg_2_0.print6 = var_1.Find(var_2_10, "prints/line6")

		return
	end

	function var_1_0.Update(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		arg_3_0.trophy = arg_3_1

		local var_3_1

		if arg_3_0.trophy then
			local var_3_0 = arg_3_0.trophy

			var_3_1 = var_3_1.isLoverLetter(var_3_0)
			setActive = var_3_0

			var_3_0(arg_3_0.icon, not var_3_1)

			setActive = var_3_0

			var_3_0(arg_3_0.now, var_3_1)

			if var_3_1 then
				setLoveLetterMedal = var_3_0

				local var_3_2 = arg_3_0.now

				var_3_0(var_6.Find(var_3_2, "medal"), arg_3_0.trophy, {
					hideMark = true
				})

				setText = var_3_0

				var_3_0(arg_3_0.nameTxt, arg_3_1:getName())
			else
				LoadImageSpriteAsync = var_3_0

				var_3_0("medal/" .. arg_3_1:getConfig("icon"), arg_3_0.icon, true)

				setText = var_3_0

				var_3_0(arg_3_0.nameTxt, arg_3_1:getConfig("name"))
			end

			setActive = var_3_0

			var_3_0(arg_3_0.tags[1], arg_3_1:isNew())
			arg_3_0:UpdateSelected(arg_3_2)
		end

		setActive = var_3_1

		var_3_1(arg_3_0.print5, not arg_3_3)

		setActive = var_3_1

		var_3_1(arg_3_0.print6, not arg_3_3)

		setActive = var_3_1

		var_3_1(arg_3_0.info, arg_3_0.trophy)

		setActive = var_3_1

		var_3_1(arg_3_0.empty, not arg_3_0.trophy)

		return
	end

	function var_1_0.UpdateSelected(arg_4_0, arg_4_1)
		setActive = var_2_10002

		var_2_10002(arg_4_0.selected, arg_4_1)

		setActive = var_2_10002

		var_2_10002(arg_4_0.tags[2], arg_4_1)

		return
	end

	function var_1_0.Dispose(arg_5_0)
		local var_5_0 = arg_5_0.now

		if var_1.Find(var_5_0, "medal").childCount > 0 then
			returnLoveLetterMedal = var_1

			local var_5_1 = arg_5_0.now
			local var_5_2 = var_2.Find(var_5_1, "medal")

			var_1(var_2.GetChild(var_5_2, 0))
		end

		return
	end

	var_1_1(var_1_0)

	return var_1_0
end

local function var_0_3(arg_6_0)
	local var_6_0 = {}

	local function var_6_1(arg_7_0)
		arg_7_0._tf = arg_6_0
		UIItemList = var_1

		local var_7_0 = var_1.New
		local var_7_1 = arg_7_0._tf
		local var_7_2 = var_2.Find(var_7_1, "list")
		local var_7_3 = arg_7_0._tf

		arg_7_0.uiList = var_7_0(var_7_2, var_3.Find(var_7_3, "list/tpl"))

		return
	end

	function var_6_0.Update(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_0.uiList

		var_2.make(var_8_0, function(arg_9_0, arg_9_1, arg_9_2)
			UIItemList = var_3_10003

			if arg_9_0 == var_3_10003.EventUpdate then
				local var_9_0 = arg_8_1[arg_9_1 + 1]

				if 0 < var_9_0 then
					LoveLetterTrophy = var_9_1

					local var_9_1

					if not var_9_1.New({
						id = var_9_0
					}) then
						Trophy = var_9_1
						var_9_1 = var_9_1.New({
							id = var_9_0
						})
					end

					findTF = var_3_10005

					local var_9_2 = var_3_10005(arg_9_2, "icon")
					local var_9_3 = arg_9_2:Find("now")
					local var_9_4 = var_9_1
					local var_9_5 = var_9_1.isLoverLetter(var_9_4)

					setActive = var_9_4

					var_9_4(var_9_2, not var_9_5)

					setActive = var_9_4

					var_9_4(var_9_3, var_9_5)

					if var_9_5 then
						setLoveLetterMedal = var_9_4

						var_9_4(var_9_3:Find("medal"), var_9_1, {
							hideMark = true
						})
					else
						LoadImageSpriteAsync = var_9_4

						var_9_4("medal/s_" .. var_9_1:getConfig("icon"), var_9_2, true)
					end

					return
				end
			end
		end)

		local var_8_1 = arg_8_0.uiList

		var_2.align(var_8_1, #arg_8_1)

		return
	end

	function var_6_0.Dispose(arg_10_0)
		local var_10_0 = arg_10_0.uiList

		var_1.each(var_10_0, function(arg_11_0, arg_11_1)
			if arg_11_1:Find("now/medal").childCount > 0 then
				returnLoveLetterMedal = var_2

				local var_11_0 = arg_11_1:Find("now/medal")

				var_2(var_3.GetChild(var_11_0, 0))
			end

			return
		end)

		return
	end

	var_6_1(var_6_0)

	return var_6_0
end

function var_0_1.getUIName(arg_12_0)
	return "AttireAchievementUI"
end

function var_0_1.OnInit(arg_13_0)
	local var_13_0 = arg_13_0._tf

	arg_13_0.listPanel = var_1.Find(var_13_0, "list_panel")

	local var_13_1 = arg_13_0.listPanel
	local var_13_2 = var_1.Find(var_13_1, "scrollrect/content")

	arg_13_0.scolrect = var_1.GetComponent(var_13_2, "LScrollRect")

	local var_13_3 = arg_13_0._tf
	local var_13_4 = var_1.Find(var_13_3, "total_count/Text")
	local var_13_5 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_13_0.totalCount = var_13_5(var_13_4, var_3(var_1_10004))

	local var_13_6 = arg_13_0.listPanel
	local var_13_7 = var_1.Find(var_13_6, "selected_bg/Text")
	local var_13_8 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_13_0.selectedTxt = var_13_8(var_13_7, var_3(var_1_10004))

	local var_13_9 = arg_13_0.listPanel

	arg_13_0.toggle = var_1.Find(var_13_9, "toggle")

	function arg_13_0.scolrect.onInitItem(arg_14_0)
		local var_14_0 = arg_13_0

		var_1.OnInitItem(var_14_0, arg_14_0)

		return
	end

	function arg_13_0.scolrect.onUpdateItem(arg_15_0, arg_15_1)
		local var_15_0 = arg_13_0

		var_2.OnUpdateItem(var_15_0, arg_15_0, arg_15_1)

		return
	end

	local var_13_10 = arg_13_0._tf

	arg_13_0.confirmBtn = var_1.Find(var_13_10, "list_panel/confirm")
	onButton = var_1

	local var_13_11 = arg_13_0
	local var_13_12 = arg_13_0.confirmBtn

	local function var_13_13()
		if #arg_13_0.contextData.selectedMedalList == #arg_13_0.playerVO.displayTrophyList then
			underscore = var_0

			local var_16_0 = var_0.all

			underscore = var_1

			if var_16_0(var_1.keys(arg_13_0.contextData.selectedMedalList), function(arg_17_0)
				return arg_13_0.contextData.selectedMedalList[arg_17_0] == arg_13_0.playerVO.displayTrophyList[arg_17_0]
			end) then
				return
			end
		end

		local var_16_1 = arg_13_0.event
		local var_16_2 = var_0.emit

		AttireMediator = var_2_10002

		var_16_2(var_16_1, var_2_10002.ON_CHANGE_MEDAL_DISPLAY, arg_13_0.contextData.selectedMedalList)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_13_11, var_13_12, var_13_13, var_1_10005)

	local var_13_14 = var_0_3
	local var_13_15 = arg_13_0._tf

	arg_13_0.descPanel = var_13_14(var_2.Find(var_13_15, "desc_panel"))
	arg_13_0.selectMaxLevel = true
	onToggle = var_1

	var_1(arg_13_0, arg_13_0.toggle, function(arg_18_0)
		arg_13_0.selectMaxLevel = arg_18_0

		local var_18_0 = arg_13_0

		var_1.Filter(var_18_0)

		return
	end)

	arg_13_0.cards = {}
	BaseEmptyListPage = var_1
	arg_13_0.emptyPage = var_1.New(arg_13_0.listPanel, arg_13_0.event)

	return
end

function var_0_1.UpdateselectedTxt(arg_19_0)
	local var_19_0

	if not arg_19_0.contextData.selectedMedalList then
		var_19_0 = {}
	end

	arg_19_0.selectedTxt.text = #var_19_0 .. "/5"

	return
end

function var_0_1.OnInitItem(arg_20_0, arg_20_1)
	local var_20_0 = var_0_2(arg_20_1)
	local var_20_1 = arg_20_0.cards

	var_20_1[arg_20_1] = var_20_0
	onButton = var_20_1

	local var_20_2 = arg_20_0
	local var_20_3 = var_20_0._go

	local function var_20_4()
		if not var_20_0.trophy then
			return
		end

		local var_21_0

		if not arg_20_0.contextData.selectedMedalList then
			var_21_0 = {}
		end

		local var_21_1 = var_20_0.trophy.id

		table = var_2_10002

		if var_2_10002.contains(var_21_0, var_21_1) then
			table = var_2

			var_2.removebyvalue(var_21_0, var_21_1)

			local var_21_2 = var_20_0

			var_2.UpdateSelected(var_21_2, false)
		elseif #var_21_0 >= 5 then
			return
		else
			table = var_2

			var_2.insert(var_21_0, var_21_1)

			local var_21_3 = var_20_0

			var_2.UpdateSelected(var_21_3, true)
		end

		arg_20_0.contextData.selectedMedalList = var_21_0

		local var_21_4 = arg_20_0.descPanel

		var_2.Update(var_21_4, arg_20_0.contextData.selectedMedalList)

		local var_21_5 = arg_20_0

		var_2.UpdateselectedTxt(var_21_5)

		return
	end

	SFX_PANEL = var_1_10007

	var_20_1(var_20_2, var_20_3, var_20_4, var_1_10007)

	return
end

function var_0_1.OnUpdateItem(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0

	if not arg_22_0.cards[arg_22_2] then
		arg_22_0:OnInitItem(arg_22_2)

		var_22_0 = arg_22_0.cards[arg_22_2]
	end

	local var_22_1 = arg_22_0.displayVOs[arg_22_1 + 1]
	local var_22_2 = arg_22_0.scolrect.content
	local var_22_3 = var_5.GetComponent

	typeof = var_1_10007
	GridLayoutGroup = var_1_10008

	local var_22_4 = arg_22_1 < var_22_3(var_22_2, var_1_10007(var_1_10008)).constraintCount

	if var_22_1 then
		table = var_7

		local var_22_5 = var_7.contains(arg_22_0.contextData.selectedMedalList, var_22_1.id)

		var_22_0:Update(var_22_1, var_22_5, var_22_4)
	else
		var_22_0:Update(var_22_1, false, var_22_4)
	end

	return
end

function var_0_1.Update(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.playerVO = arg_23_2
	arg_23_0.trophys = arg_23_1.trophys
	ipairs = var_3

	for iter_23_0, iter_23_1 in var_3(arg_23_1.loveTrophys) do
		arg_23_0.trophys[iter_23_1.id] = iter_23_1
	end

	local var_23_0 = arg_23_0.contextData

	Clone = var_4

	local var_23_1

	if not var_4(arg_23_0.playerVO.displayTrophyList) then
		var_23_1 = {}
	end

	var_23_0.selectedMedalList = var_23_1

	local var_23_2 = arg_23_0.descPanel

	var_3.Update(var_23_2, arg_23_0.contextData.selectedMedalList)
	arg_23_0:UpdateselectedTxt()
	arg_23_0:Filter()

	arg_23_0.totalCount.text = arg_23_0:getTotalCnt()

	if arg_23_0:getTotalCnt() <= 0 then
		local var_23_3 = arg_23_0.emptyPage

		var_4.ExecuteAction(var_23_3, "ShowOrHide", true)

		local var_23_4 = arg_23_0.emptyPage
		local var_23_5 = var_4.ExecuteAction
		local var_23_6 = "SetEmptyText"

		i18n = var_7

		var_23_5(var_23_4, var_23_6, var_7("decoration_medal_placeholder"))

		local var_23_7 = arg_23_0.emptyPage

		var_4.ExecuteAction(var_23_7, "SetPosY", {
			x = 0,
			y = 22
		})

		setActive = var_4

		local var_23_8 = arg_23_0.listPanel

		var_4(var_5.Find(var_23_8, "scrollrect"), false)
	elseif var_3 > 0 then
		local var_23_9 = arg_23_0.emptyPage

		if var_4.GetLoaded(var_23_9) then
			local var_23_10 = arg_23_0.emptyPage

			var_4.ExecuteAction(var_23_10, "ShowOrHide", false)

			setActive = var_4

			local var_23_11 = arg_23_0.listPanel

			var_4(var_5.Find(var_23_11, "scrollrect"), true)
		end
	end

	return
end

function var_0_1.getTotalCnt(arg_24_0)
	local var_24_0 = 0

	pairs = var_1_10002

	for iter_24_0, iter_24_1 in var_1_10002(arg_24_0.trophys) do
		if iter_24_1:isClaimed() and not iter_24_1:isHide() then
			var_24_0 = var_24_0 + 1
		end
	end

	return var_24_0
end

function var_0_1.Filter(arg_25_0)
	arg_25_0.displayVOs = {}

	local function var_25_0(arg_26_0)
		local var_26_0

		if arg_25_0.trophys[arg_26_0:getConfig("next")] and var_1:isClaimed() then
			var_26_0 = not var_1:isHide()
		end

		return var_26_0
	end

	pairs = var_1_10002

	for iter_25_0, iter_25_1 in var_1_10002(arg_25_0.trophys) do
		if iter_25_1:isClaimed() and not iter_25_1:isHide() and (not arg_25_0.selectMaxLevel or not var_25_0(iter_25_1)) then
			table = var_7

			var_7.insert(arg_25_0.displayVOs, iter_25_1)
		end
	end

	table = var_2

	local var_25_1 = var_2.sort
	local var_25_2 = arg_25_0.displayVOs

	CompareFuncs = var_4

	var_25_1(var_25_2, var_4({
		function(arg_27_0)
			return arg_27_0.id
		end
	}))

	local var_25_3 = arg_25_0.scolrect.content
	local var_25_4 = var_2.GetComponent

	typeof = var_4
	GridLayoutGroup = var_5

	local var_25_5

	if var_25_4(var_25_3, var_4(var_5)).constraintCount - #arg_25_0.displayVOs % var_3 == var_3 then
		var_25_5 = 0
	end

	if var_3 * arg_25_0:GetColumn() > #arg_25_0.displayVOs then
		var_25_5 = var_5 - #arg_25_0.displayVOs
	end

	for iter_25_2 = 1, var_25_5 do
		table = var_1_10010

		var_1_10010.insert(arg_25_0.displayVOs, false)
	end

	local var_25_6 = arg_25_0.scolrect

	var_6.SetTotalCount(var_25_6, #arg_25_0.displayVOs, -1)

	return
end

function var_0_1.GetColumn(arg_28_0)
	return 2
end

function var_0_1.OnDestroy(arg_29_0)
	local var_29_0 = arg_29_0.descPanel

	var_1.Dispose(var_29_0)

	if arg_29_0.emptyPage then
		local var_29_1 = arg_29_0.emptyPage

		var_1.Destroy(var_29_1)

		arg_29_0.emptyPage = nil
	end

	if arg_29_0.cards then
		pairs = var_1

		for iter_29_0, iter_29_1 in var_1(arg_29_0.cards) do
			iter_29_1:Dispose()
		end

		arg_29_0.cards = nil
	end

	return
end

return var_0_1

local var_0_0 = class("SpringFestival2026ColoringAnshanscene", import("view.base.BaseUI"))
local var_0_1 = 387
local var_0_2 = 467
local var_0_3 = 812.5
local var_0_4 = 1200
local var_0_5 = Vector2(49, -436.12)

function var_0_0.getUIName(arg_1_0)
	return "SpringFestival2026ColoringAnshanUI"
end

function var_0_0.setActivity(arg_2_0, arg_2_1)
	arg_2_0.activity = arg_2_1

	return
end

function var_0_0.setColorItems(arg_3_0, arg_3_1)
	arg_3_0.colorItems = arg_3_1

	return
end

function var_0_0.setColorGroups(arg_4_0, arg_4_1)
	arg_4_0.colorGroups = arg_4_1

	return
end

function var_0_0.init(arg_5_0)
	arg_5_0.rtAdapt = arg_5_0._tf:Find("adapt")
	arg_5_0.topPanel = arg_5_0.rtAdapt:Find("top")
	arg_5_0.btnBack = arg_5_0.rtAdapt:Find("top/btnBack")
	arg_5_0.title = arg_5_0.rtAdapt:Find("center/title_bar/text")
	arg_5_0.bg = arg_5_0.rtAdapt:Find("center/board/container/bg")
	arg_5_0.painting = arg_5_0.rtAdapt:Find("center/painting")
	arg_5_0.paintingCompleted = arg_5_0.rtAdapt:Find("center/painting_completed")
	arg_5_0.zoom = arg_5_0.bg:GetComponent("Zoom")
	arg_5_0.zoom.maxZoom = 3
	arg_5_0.cells = arg_5_0.bg:Find("cells")
	arg_5_0.cell = arg_5_0.bg:Find("cell")
	arg_5_0.lines = arg_5_0.bg:Find("lines")
	arg_5_0.line = arg_5_0.bg:Find("line")
	arg_5_0.btnHelp = arg_5_0.rtAdapt:Find("top/btnHelp")
	arg_5_0.btnShare = arg_5_0.rtAdapt:Find("top/btnShare")
	arg_5_0.colorgroupfront = arg_5_0.rtAdapt:Find("center/colorgroupfront")
	arg_5_0.scrollColor = arg_5_0.rtAdapt:Find("color_bar/scroll")
	arg_5_0.barExtra = arg_5_0.rtAdapt:Find("color_bar/extra")
	arg_5_0.toggleEraser = arg_5_0.barExtra:Find("eraser")
	arg_5_0.btnEraserAll = arg_5_0.barExtra:Find("eraser_all")
	arg_5_0.arrowDown = arg_5_0.barExtra:Find("arrow")

	setActive(arg_5_0.cell, false)
	setActive(arg_5_0.line, false)
	setActive(arg_5_0.barExtra, false)

	return
end

function var_0_0.DidMediatorRegisterDone(arg_6_0)
	arg_6_0.colorPlates = CustomIndexLayer.Clone2Full(arg_6_0.scrollColor:Find("content"), #arg_6_0.colorGroups[1]:getConfig("color_id_list"))
	arg_6_0.coloringUIGroupName = "ColoringUIGroupSize" .. #arg_6_0.colorGroups

	PoolMgr.GetInstance():GetUI(arg_6_0.coloringUIGroupName, false, function(arg_7_0)
		setParent(arg_7_0, arg_6_0.rtAdapt:Find("center"))
		setAnchoredPosition(arg_7_0, var_0_5)
		tf(arg_7_0):SetSiblingIndex(1)
		setActive(arg_7_0, true)

		arg_6_0.colorgroupbehind = tf(arg_7_0)
		arg_6_0.paintsgroup = {}

		for iter_7_0 = arg_6_0.colorgroupbehind.childCount - 1, 0, -1 do
			table.insert(arg_6_0.paintsgroup, (arg_6_0.colorgroupbehind:GetChild(iter_7_0)))
		end

		return
	end)
	setActive(arg_6_0.btnShare, not COLORING_ACTIVITY_CUSTOMIZED_BANNED and _.any(arg_6_0.colorGroups, function(arg_8_0)
		return arg_8_0:canBeCustomised()
	end))

	return
end

function var_0_0.didEnter(arg_9_0)
	onButton(arg_9_0, arg_9_0.btnBack, function()
		if arg_9_0.exited then
			return
		end

		arg_9_0:uiExitAnimating()
		arg_9_0:emit(var_0_0.ON_BACK_PRESSED)

		return
	end, SOUND_BACK)
	onButton(arg_9_0, arg_9_0.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("coloring_help_tip")
		})

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0.btnShare, function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeColoring)

		return
	end, SFX_PANEL)
	onNextTick(function()
		if arg_9_0.exited then
			return
		end

		arg_9_0:uiStartAnimating()

		return
	end)
	arg_9_0:initColoring()
	arg_9_0:updatePage()

	return
end

function var_0_0.uiStartAnimating(arg_14_0)
	arg_14_0.topPanel.anchoredPosition = Vector2(0, arg_14_0.topPanel.rect.height)

	shiftPanel(arg_14_0.topPanel, nil, 0, 0.3, 0, true, true, nil)

	return
end

function var_0_0.uiExitAnimating(arg_15_0)
	shiftPanel(arg_15_0.topPanel, nil, arg_15_0.topPanel.rect.height, 0.3, 0, true, true, nil)

	return
end

function var_0_0.initColoring(arg_16_0)
	onButton(arg_16_0, arg_16_0.btnEraserAll, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("coloring_erase_all_warning"),
			onYes = function()
				if arg_16_0.colorGroups[arg_16_0.selectedIndex]:canBeCustomised() then
					arg_16_0:emit(SpringFestival2026ColoringAnshanMediator.EVENT_COLORING_CLEAR, {
						activityId = arg_16_0.activity.id,
						id = arg_16_0.colorGroups[arg_16_0.selectedIndex].id
					})
				end

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(arg_16_0, arg_16_0.arrowDown, function()
		arg_16_0.scrollColor:GetComponent(typeof(ScrollRect)).verticalNormalizedPosition = 0

		return
	end, SFX_PANEL)

	local var_16_0 = 1

	for iter_16_0 = 1, #arg_16_0.colorGroups do
		if arg_16_0.colorGroups[iter_16_0]:getState() == ColorGroup.StateColoring then
			var_16_0 = iter_16_0

			break
		end
	end

	local var_16_1 = Mathf.Min(var_16_0, #arg_16_0.paintsgroup)

	arg_16_0:initInteractive()

	arg_16_0.selectedIndex = 0
	arg_16_0.selectedColorIndex = 0

	triggerButton(arg_16_0.paintsgroup[var_16_1])

	return
end

function var_0_0.initInteractive(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.paintsgroup) do
		local var_20_0 = arg_20_0.colorGroups[iter_20_0]

		onButton(arg_20_0, iter_20_1, function()
			local var_21_0 = var_20_0:getState()

			if arg_20_0.selectedIndex ~= var_0 and var_21_0 ~= ColorGroup.StateLock then
				if arg_20_0.paintsgroup[arg_20_0.selectedIndex] then
					arg_20_0.paintsgroup[arg_20_0.selectedIndex]:SetParent(arg_20_0.colorgroupbehind)
				end

				arg_20_0.selectedIndex = var_0

				iter_20_1:SetParent(arg_20_0.colorgroupfront)
				arg_20_0:SelectColoBar(0)
				arg_20_0:updateSelectedColoring()
			elseif var_21_0 == ColorGroup.StateLock then
				pg.TipsMgr.GetInstance():ShowTips(i18n("coloring_lock"))
			end

			arg_20_0:updatePage()

			return
		end, SFX_PANEL)
	end

	for iter_20_2 = 0, #arg_20_0.colorPlates - 1 do
		onButton(arg_20_0, arg_20_0.colorPlates[iter_20_2 + 1], function()
			arg_20_0:SelectColoBar(iter_20_2 + 1)

			if arg_20_0.colorGroups[arg_20_0.selectedIndex]:getState() == ColorGroup.StateColoring and not arg_20_0.colorGroups[arg_20_0.selectedIndex]:canBeCustomised() then
				local var_22_0 = arg_20_0.colorItems[arg_20_0.colorGroups[arg_20_0.selectedIndex]:getConfig("color_id_list")[arg_20_0.selectedColorIndex]] or 0

				if var_22_0 ~= 0 then
					local var_22_1 = arg_20_0:SearchValidDiagonalColoringCells(arg_20_0.colorGroups[arg_20_0.selectedIndex], arg_20_0.selectedColorIndex, var_22_0)

					if var_22_1 and #var_22_1 > 0 then
						arg_20_0:emit(SpringFestival2026ColoringAnshanMediator.EVENT_COLORING_CELL, {
							activityId = arg_20_0.activity.id,
							id = arg_20_0.colorGroups[arg_20_0.selectedIndex].id,
							cells = var_22_1
						})
					end
				elseif not arg_20_0.colorGroups[arg_20_0.selectedIndex]:isAllFill(arg_20_0.selectedColorIndex) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("coloring_color_not_enough"))
				end
			end

			return
		end, SFX_PANEL)
	end

	onButton(arg_20_0, arg_20_0.toggleEraser, function()
		arg_20_0:SelectColoBar(0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SelectColoBar(arg_24_0, arg_24_1)
	if arg_24_0.selectedColorIndex ~= 0 and arg_24_0.selectedColorIndex ~= arg_24_1 then
		local var_24_0 = arg_24_0.colorPlates[arg_24_0.selectedColorIndex]:Find("icon")

		var_24_0.sizeDelta.x = var_0_1
		var_24_0.sizeDelta = var_24_0.sizeDelta
	end

	arg_24_0.selectedColorIndex = arg_24_1

	if arg_24_0.selectedColorIndex ~= 0 then
		local var_24_1 = arg_24_0.colorPlates[arg_24_0.selectedColorIndex]:Find("icon")

		var_24_1.sizeDelta.x = var_0_2
		var_24_1.sizeDelta = var_24_1.sizeDelta
	end

	return
end

function var_0_0.updatePage(arg_25_0)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0.paintsgroup) do
		local var_25_0 = arg_25_0.colorGroups[iter_25_0]:getState()

		setActive(iter_25_1:Find("lock"), var_25_0 == ColorGroup.StateLock)
		setActive(iter_25_1:Find("get"), var_25_0 == ColorGroup.StateAchieved)
	end

	for iter_25_2 = #arg_25_0.paintsgroup, 1, -1 do
		local var_25_1

		if iter_25_2 ~= arg_25_0.selectedIndex then
			arg_25_0.paintsgroup[iter_25_2]:SetSiblingIndex(0)

			var_25_1 = 0 + 1
		end
	end

	if getProxy(ColoringProxy):IsALLAchieve() and not IsNil(arg_25_0.paintingCompleted) then
		setActive(arg_25_0.painting, false)
		setActive(arg_25_0.paintingCompleted, true)
	end

	arg_25_0:TryPlayStory()

	return
end

function var_0_0.updateSelectedColoring(arg_26_0)
	local var_26_1 = arg_26_0.colorGroups[arg_26_0.selectedIndex]:getConfig("color_id_list")

	for iter_26_0 = 1, #arg_26_0.colorPlates do
		local var_26_2 = arg_26_0.colorPlates[iter_26_0]:Find("icon/x/nums")
		local var_26_3 = arg_26_0.colorItems[var_26_1[iter_26_0]] or 0

		setText(var_26_2, var_26_3)
	end

	local var_26_4 = var_26_0:getConfig("name")

	setText(arg_26_0.title, var_26_4)
	setActive(arg_26_0.title.parent, var_26_4 ~= nil)
	setActive(arg_26_0.barExtra, var_26_0:canBeCustomised())

	local var_26_5 = arg_26_0.scrollColor.sizeDelta

	if var_26_0:canBeCustomised() then
		var_26_5.y = var_0_3 or var_0_4
		arg_26_0.scrollColor.sizeDelta = var_26_5
		arg_26_0.scrollColor:GetComponent(typeof(ScrollRect)).verticalNormalizedPosition = 1

		setActive(arg_26_0.scrollColor, false)
		setActive(arg_26_0.scrollColor, true)

		arg_26_0.cellSize = arg_26_0:calcCellSize()

		arg_26_0:updateCells()
		arg_26_0:updateLines()

		local var_26_6 = arg_26_0.selectedIndex or 1

		getProxy(ColoringProxy):SetViewedPage(var_26_6)

		return
	end
end

function var_0_0.updateCells(arg_27_0)
	local var_27_0, var_27_1 = unpack(arg_27_0.colorGroups[arg_27_0.selectedIndex]:getConfig("theme"))

	for iter_27_0 = 0, var_27_0 do
		for iter_27_1 = 0, var_27_1 do
			arg_27_0:updateCell(iter_27_0, iter_27_1)
		end
	end

	local var_27_2 = arg_27_0.bg:GetComponent("EventTriggerListener")

	var_27_2:RemovePointClickFunc()
	var_27_2:RemoveBeginDragFunc()
	var_27_2:RemoveDragFunc()
	var_27_2:RemoveDragEndFunc()

	local var_27_3 = false

	var_27_2:AddPointClickFunc(function(arg_28_0, arg_28_1)
		if not var_0:canBeCustomised() then
			return
		end

		if var_27_3 then
			return
		end

		local var_28_0 = LuaHelper.ScreenToLocal(arg_27_0.bg, arg_28_1.position, GameObject.Find("UICamera"):GetComponent(typeof(Camera)))
		local var_28_1 = math.floor(-var_28_0.y / arg_27_0.cellSize.y)
		local var_28_2 = math.floor(var_28_0.x / arg_27_0.cellSize.x)

		if var_0:getState() == ColorGroup.StateColoring then
			if not var_0:canBeCustomised() then
				return
			elseif arg_27_0.selectedColorIndex == 0 and not var_0:hasFill(math.floor(-var_28_0.y / arg_27_0.cellSize.y), (math.floor(var_28_0.x / arg_27_0.cellSize.x))) then
				return
			end

			;(function()
				arg_27_0:emit(SpringFestival2026ColoringAnshanMediator.EVENT_COLORING_CELL, {
					activityId = arg_27_0.activity.id,
					id = var_0.id,
					cells = arg_27_0:searchColoringCells(var_0, var_28_1, var_28_2, arg_27_0.selectedColorIndex)
				})

				return
			end)()
		end

		return
	end)
	var_27_2:AddBeginDragFunc(function()
		var_27_3 = false

		return
	end)

	local var_27_4 = Vector2.New(arg_27_0.bg.rect.width / UnityEngine.Screen.width, arg_27_0.bg.rect.height / UnityEngine.Screen.height)

	var_27_2:AddDragFunc(function(arg_31_0, arg_31_1)
		var_27_3 = true

		if not IsUnityEditor then
			arg_27_0.zoom.enabled = Input.touchCount == 2
		end

		if IsUnityEditor or not arg_27_0.zoom.enabled then
			local var_31_0 = arg_27_0.bg.anchoredPosition

			var_31_0.x = arg_27_0.bg.anchoredPosition.x + arg_31_1.delta.x * var_27_4.x
			var_31_0.x = math.clamp(var_31_0.x, -arg_27_0.bg.rect.width * (arg_27_0.bg.localScale.x - 1), 0)
			var_31_0.y = var_31_0.y + arg_31_1.delta.y * var_27_4.y
			var_31_0.y = math.clamp(var_31_0.y, 0, arg_27_0.bg.rect.height * (arg_27_0.bg.localScale.y - 1))
			arg_27_0.bg.anchoredPosition = var_31_0
		end

		return
	end)
	var_27_2:AddDragEndFunc(function()
		var_27_3 = false

		return
	end)

	return
end

function var_0_0.updateCell(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0.colorGroups[arg_33_0.selectedIndex]
	local var_33_1 = arg_33_0.colorGroups[arg_33_0.selectedIndex]:getCell(arg_33_1, arg_33_2)
	local var_33_2 = arg_33_0.colorGroups[arg_33_0.selectedIndex]:getFill(arg_33_1, arg_33_2)
	local var_33_3 = arg_33_0.colorGroups[arg_33_0.selectedIndex]:getState()

	if var_33_3 == ColorGroup.StateFinish or var_33_3 == ColorGroup.StateAchieved then
		var_33_2 = var_33_1
	end

	local var_33_4 = arg_33_1 .. "_" .. arg_33_2
	local var_33_5 = arg_33_0.cells:Find(arg_33_1 .. "_" .. arg_33_2)

	if var_33_1 or var_33_2 then
		var_33_5 = var_33_5 or cloneTplTo(arg_33_0.cell, arg_33_0.cells, var_33_4)
		var_33_5.sizeDelta = arg_33_0.cellSize
		var_33_5.anchoredPosition = Vector2((var_33_2 or var_33_1).column * arg_33_0.cellSize.x, -((var_33_2 or var_33_1).row * arg_33_0.cellSize.y))

		local var_33_6 = var_33_5:Find("image")
		local var_33_7 = var_33_5:Find("text")

		if var_33_2 then
			setImageColor(var_33_6, var_33_0.colors[var_33_2.type])
		else
			setText(var_33_7, string.char(string.byte("A") + var_33_1.type - 1))
		end

		setActive(var_33_6, var_33_2)
		setActive(var_33_7, not var_33_2)
		setActive(var_33_5, true)
	elseif var_33_5 then
		setActive(var_33_5, false)
	end

	return
end

function var_0_0.calcCellSize(arg_34_0)
	local var_34_0, var_34_1 = unpack(arg_34_0.colorGroups[arg_34_0.selectedIndex]:getConfig("theme"))

	return (Vector2.New(arg_34_0.bg.rect.width / var_34_1, arg_34_0.bg.rect.height / var_34_0))
end

function var_0_0.updateLines(arg_35_0)
	local var_35_0, var_35_1 = unpack(arg_35_0.colorGroups[arg_35_0.selectedIndex]:getConfig("theme"))

	for iter_35_0 = 1, var_35_1 - 1 do
		local var_35_2 = arg_35_0.lines:Find("column_" .. iter_35_0) or cloneTplTo(arg_35_0.line, arg_35_0.lines, "column_" .. iter_35_0)

		var_35_2.sizeDelta = Vector2.New(1, arg_35_0.lines.rect.height)
		var_35_2.anchoredPosition = Vector2.New(iter_35_0 * arg_35_0.cellSize.x - 0.5, 0)
	end

	for iter_35_1 = 1, var_35_0 - 1 do
		local var_35_3 = arg_35_0.lines:Find("row_" .. iter_35_1) or cloneTplTo(arg_35_0.line, arg_35_0.lines, "row_" .. iter_35_1)

		var_35_3.sizeDelta = Vector2.New(arg_35_0.lines.rect.width, 1)
		var_35_3.anchoredPosition = Vector2.New(0, -(iter_35_1 * arg_35_0.cellSize.y - 0.5))
	end

	return
end

function var_0_0.searchColoringCells(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	if arg_36_1:canBeCustomised() then
		return {
			{
				row = arg_36_2,
				column = arg_36_3,
				color = arg_36_4
			}
		}
	else
		local var_36_0 = arg_36_0.colorItems[arg_36_1:getConfig("color_id_list")[arg_36_4]]
		local var_36_1 = {}
		local var_36_2 = {
			{
				row = arg_36_2,
				column = arg_36_3,
				color = arg_36_4
			}
		}

		while #{
			{
				row = arg_36_2,
				column = arg_36_3,
				color = arg_36_4
			}
		} > 0 and var_36_0 > 0 do
			local var_36_3 = table.remove({
				{
					row = arg_36_2,
					column = arg_36_3,
					color = arg_36_4
				}
			}, 1)

			if not arg_36_1:hasFill(var_36_3.row, var_36_3.column) and var_36_3.color == arg_36_4 then
				table.insert({}, var_36_3)

				var_36_0 = var_36_0 - 1

				_.each({
					{
						row = -1,
						column = 0
					},
					{
						row = 1,
						column = 0
					},
					{
						row = 0,
						column = -1
					},
					{
						row = 0,
						column = 1
					},
					{
						row = -1,
						column = -1
					},
					{
						row = -1,
						column = 1
					},
					{
						row = 1,
						column = -1
					},
					{
						row = 1,
						column = 1
					}
				}, function(arg_37_0)
					local var_37_0 = arg_36_1:getCell(arg_37_0.row + var_36_3.row, arg_37_0.column + var_36_3.column)

					if var_37_0 then
						local var_37_1 = _.any(var_36_2, function(arg_38_0)
							return arg_38_0.row == var_37_0.row and arg_38_0.column == var_37_0.column
						end) or _.any(var_36_1, function(arg_39_0)
							return arg_39_0.row == var_37_0.row and arg_39_0.column == var_37_0.column
						end)

						if not var_37_1 then
							table.insert(var_36_2, {
								row = var_37_0.row,
								column = var_37_0.column,
								color = var_37_0.type
							})
						end
					end

					return
				end)
			end

			table.insert({}, var_36_3)
		end

		return {}
	end

	return
end

function var_0_0.SearchValidDiagonalColoringCells(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	assert(arg_40_1)

	local var_40_0 = {}

	if arg_40_1:getState() ~= ColorGroup.StateColoring or arg_40_1:canBeCustomised() or arg_40_3 == 0 then
		return {}
	else
		local var_40_1, var_40_2 = arg_40_1:GetAABB()
		local var_40_3 = var_40_2.x - var_40_1.x
		local var_40_4 = var_40_2.y - var_40_1.y

		;(function()
			for iter_41_0 = 0, var_40_3 + var_40_4 do
				for iter_41_1 = 0, iter_41_0 do
					if iter_41_0 - iter_41_1 <= var_40_3 and iter_41_1 <= var_40_4 then
						local var_41_1 = arg_40_1:getCell(iter_41_1 + var_40_1.y, iter_41_0 - iter_41_1 + var_40_1.x)

						if var_41_1 and var_41_1.type == arg_40_2 and not arg_40_1:getFill(iter_41_1 + var_40_1.y, iter_41_0 - iter_41_1 + var_40_1.x) then
							table.insert(var_40_0, {
								row = iter_41_1 + var_40_1.y,
								column = iter_41_0 - iter_41_1 + var_40_1.x,
								color = arg_40_2
							})

							if #var_40_0 >= arg_40_3 then
								return
							end
						end
					end
				end
			end

			return
		end)()

		return {}
	end

	return
end

function var_0_0.TryPlayStory(arg_42_0)
	local var_42_0 = arg_42_0.selectedIndex

	table.SerialIpairsAsync({}, function(arg_43_0, arg_43_1, arg_43_2)
		if arg_43_0 <= var_42_0 and arg_43_1 then
			pg.NewStoryMgr.GetInstance():Play(arg_43_1, arg_43_2)
		else
			arg_43_2()
		end

		return
	end)

	return
end

function var_0_0.onBackPressed(arg_44_0)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	triggerButton(arg_44_0.btnBack)

	return
end

function var_0_0.willExit(arg_45_0)
	PoolMgr.GetInstance():ReturnUI(arg_45_0.coloringUIGroupName, arg_45_0.colorgroupbehind)

	return
end

return var_0_0

local SpringFestival2026ColoringAnshanscene = class("SpringFestival2026ColoringAnshanscene", import("view.base.BaseUI"))
local var_0_1 = 387
local var_0_2 = 467
local var_0_3 = 812.5
local var_0_4 = 1200
local var_0_5 = Vector2(49, -436.12)

function SpringFestival2026ColoringAnshanscene:getUIName()
	return "SpringFestival2026ColoringAnshanUI"
end

function SpringFestival2026ColoringAnshanscene:setActivity(arg_2_1)
	self.activity = arg_2_1

	return
end

function SpringFestival2026ColoringAnshanscene:setColorItems(arg_3_1)
	self.colorItems = arg_3_1

	return
end

function SpringFestival2026ColoringAnshanscene:setColorGroups(arg_4_1)
	self.colorGroups = arg_4_1

	return
end

function SpringFestival2026ColoringAnshanscene:init()
	self.rtAdapt = self._tf:Find("adapt")
	self.topPanel = self.rtAdapt:Find("top")
	self.btnBack = self.rtAdapt:Find("top/btnBack")
	self.title = self.rtAdapt:Find("center/title_bar/text")
	self.bg = self.rtAdapt:Find("center/board/container/bg")
	self.painting = self.rtAdapt:Find("center/painting")
	self.paintingCompleted = self.rtAdapt:Find("center/painting_completed")
	self.zoom = self.bg:GetComponent("Zoom")
	self.zoom.maxZoom = 3
	self.cells = self.bg:Find("cells")
	self.cell = self.bg:Find("cell")
	self.lines = self.bg:Find("lines")
	self.line = self.bg:Find("line")
	self.btnHelp = self.rtAdapt:Find("top/btnHelp")
	self.btnShare = self.rtAdapt:Find("top/btnShare")
	self.colorgroupfront = self.rtAdapt:Find("center/colorgroupfront")
	self.scrollColor = self.rtAdapt:Find("color_bar/scroll")
	self.barExtra = self.rtAdapt:Find("color_bar/extra")
	self.toggleEraser = self.barExtra:Find("eraser")
	self.btnEraserAll = self.barExtra:Find("eraser_all")
	self.arrowDown = self.barExtra:Find("arrow")

	setActive(self.cell, false)
	setActive(self.line, false)
	setActive(self.barExtra, false)

	return
end

function SpringFestival2026ColoringAnshanscene:DidMediatorRegisterDone()
	self.colorPlates = CustomIndexLayer.Clone2Full(self.scrollColor:Find("content"), #self.colorGroups[1]:getConfig("color_id_list"))
	self.coloringUIGroupName = "ColoringUIGroupSize" .. #self.colorGroups

	PoolMgr.GetInstance():GetUI(self.coloringUIGroupName, false, function(arg_7_0)
		setParent(arg_7_0, self.rtAdapt:Find("center"))
		setAnchoredPosition(arg_7_0, var_0_5)
		tf(arg_7_0):SetSiblingIndex(1)
		setActive(arg_7_0, true)

		self.colorgroupbehind = tf(arg_7_0)
		self.paintsgroup = {}

		for iter_7_0 = self.colorgroupbehind.childCount - 1, 0, -1 do
			table.insert(self.paintsgroup, (self.colorgroupbehind:GetChild(iter_7_0)))
		end

		return
	end)
	setActive(self.btnShare, not COLORING_ACTIVITY_CUSTOMIZED_BANNED and _.any(self.colorGroups, function(arg_8_0)
		return arg_8_0:canBeCustomised()
	end))

	return
end

function SpringFestival2026ColoringAnshanscene:didEnter()
	onButton(self, self.btnBack, function()
		if self.exited then
			return
		end

		self:uiExitAnimating()
		self:emit(SpringFestival2026ColoringAnshanscene.ON_BACK_PRESSED)

		return
	end, SOUND_BACK)
	onButton(self, self.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("coloring_help_tip")
		})

		return
	end, SFX_PANEL)
	onButton(self, self.btnShare, function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeColoring)

		return
	end, SFX_PANEL)
	onNextTick(function()
		if self.exited then
			return
		end

		self:uiStartAnimating()

		return
	end)
	self:initColoring()
	self:updatePage()

	return
end

function SpringFestival2026ColoringAnshanscene:uiStartAnimating()
	self.topPanel.anchoredPosition = Vector2(0, self.topPanel.rect.height)

	shiftPanel(self.topPanel, nil, 0, 0.3, 0, true, true, nil)

	return
end

function SpringFestival2026ColoringAnshanscene:uiExitAnimating()
	shiftPanel(self.topPanel, nil, self.topPanel.rect.height, 0.3, 0, true, true, nil)

	return
end

function SpringFestival2026ColoringAnshanscene:initColoring()
	onButton(self, self.btnEraserAll, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("coloring_erase_all_warning"),
			onYes = function()
				if self.colorGroups[self.selectedIndex]:canBeCustomised() then
					self:emit(SpringFestival2026ColoringAnshanMediator.EVENT_COLORING_CLEAR, {
						activityId = self.activity.id,
						id = self.colorGroups[self.selectedIndex].id
					})
				end

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.arrowDown, function()
		self.scrollColor:GetComponent(typeof(ScrollRect)).verticalNormalizedPosition = 0

		return
	end, SFX_PANEL)

	local var_16_0 = 1

	for iter_16_0 = 1, #self.colorGroups do
		if self.colorGroups[iter_16_0]:getState() == ColorGroup.StateColoring then
			var_16_0 = iter_16_0

			break
		end
	end

	local var_16_1 = Mathf.Min(var_16_0, #self.paintsgroup)

	self:initInteractive()

	self.selectedIndex = 0
	self.selectedColorIndex = 0

	triggerButton(self.paintsgroup[var_16_1])

	return
end

function SpringFestival2026ColoringAnshanscene:initInteractive()
	for iter_20_0, iter_20_1 in pairs(self.paintsgroup) do
		local var_20_0 = iter_20_0
		local var_20_1 = self.colorGroups[iter_20_0]

		onButton(self, iter_20_1, function()
			local var_21_0 = var_20_1:getState()

			if self.selectedIndex ~= var_20_0 and var_21_0 ~= ColorGroup.StateLock then
				if self.paintsgroup[self.selectedIndex] then
					self.paintsgroup[self.selectedIndex]:SetParent(self.colorgroupbehind)
				end

				self.selectedIndex = var_20_0

				iter_20_1:SetParent(self.colorgroupfront)
				self:SelectColoBar(0)
				self:updateSelectedColoring()
			elseif var_21_0 == ColorGroup.StateLock then
				pg.TipsMgr.GetInstance():ShowTips(i18n("coloring_lock"))
			end

			self:updatePage()

			return
		end, SFX_PANEL)
	end

	for iter_20_2 = 0, #self.colorPlates - 1 do
		onButton(self, self.colorPlates[iter_20_2 + 1], function()
			self:SelectColoBar(iter_20_2 + 1)

			if self.colorGroups[self.selectedIndex]:getState() == ColorGroup.StateColoring and not self.colorGroups[self.selectedIndex]:canBeCustomised() then
				local var_22_0 = self.colorItems[self.colorGroups[self.selectedIndex]:getConfig("color_id_list")[self.selectedColorIndex]] or 0

				if var_22_0 ~= 0 then
					local var_22_1 = self:SearchValidDiagonalColoringCells(self.colorGroups[self.selectedIndex], self.selectedColorIndex, var_22_0)

					if var_22_1 and #var_22_1 > 0 then
						self:emit(SpringFestival2026ColoringAnshanMediator.EVENT_COLORING_CELL, {
							activityId = self.activity.id,
							id = self.colorGroups[self.selectedIndex].id,
							cells = var_22_1
						})
					end
				elseif not self.colorGroups[self.selectedIndex]:isAllFill(self.selectedColorIndex) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("coloring_color_not_enough"))
				end
			end

			return
		end, SFX_PANEL)
	end

	onButton(self, self.toggleEraser, function()
		self:SelectColoBar(0)

		return
	end, SFX_PANEL)

	return
end

function SpringFestival2026ColoringAnshanscene:SelectColoBar(arg_24_1)
	if self.selectedColorIndex ~= 0 and self.selectedColorIndex ~= arg_24_1 then
		local var_24_0 = self.colorPlates[self.selectedColorIndex]:Find("icon")

		var_24_0.sizeDelta.x = var_0_1
		var_24_0.sizeDelta = var_24_0.sizeDelta
	end

	self.selectedColorIndex = arg_24_1

	if self.selectedColorIndex ~= 0 then
		local var_24_1 = self.colorPlates[self.selectedColorIndex]:Find("icon")

		var_24_1.sizeDelta.x = var_0_2
		var_24_1.sizeDelta = var_24_1.sizeDelta
	end

	return
end

function SpringFestival2026ColoringAnshanscene:updatePage()
	for iter_25_0, iter_25_1 in ipairs(self.paintsgroup) do
		local var_25_0 = self.colorGroups[iter_25_0]:getState()

		setActive(iter_25_1:Find("lock"), var_25_0 == ColorGroup.StateLock)
		setActive(iter_25_1:Find("get"), var_25_0 == ColorGroup.StateAchieved)
	end

	for iter_25_2 = #self.paintsgroup, 1, -1 do
		if iter_25_2 ~= self.selectedIndex then
			self.paintsgroup[iter_25_2]:SetSiblingIndex(0)
		end
	end

	if getProxy(ColoringProxy):IsALLAchieve() and not IsNil(self.paintingCompleted) then
		setActive(self.painting, false)
		setActive(self.paintingCompleted, true)
	end

	self:TryPlayStory()

	return
end

function SpringFestival2026ColoringAnshanscene:updateSelectedColoring()
	local var_26_0 = self.colorGroups[self.selectedIndex]
	local var_26_1 = self.colorGroups[self.selectedIndex]:getConfig("color_id_list")

	for iter_26_0 = 1, #self.colorPlates do
		setText(self.colorPlates[iter_26_0]:Find("icon/x/nums"), (not self.colorItems[var_26_1[iter_26_0]] or nil) and 0)
	end

	local var_26_3 = var_26_0:getConfig("name")

	setText(self.title, var_26_3)
	setActive(self.title.parent, var_26_3 ~= nil)
	setActive(self.barExtra, var_26_0:canBeCustomised())

	local var_26_4 = self.scrollColor.sizeDelta

	if var_26_0:canBeCustomised() then
		var_26_4.y = var_0_3 or var_0_4
	end

	self.scrollColor.sizeDelta = var_26_4
	self.scrollColor:GetComponent(typeof(ScrollRect)).verticalNormalizedPosition = 1

	setActive(self.scrollColor, false)
	setActive(self.scrollColor, true)

	self.cellSize = self:calcCellSize()

	self:updateCells()
	self:updateLines()
	getProxy(ColoringProxy):SetViewedPage(self.selectedIndex or 1)

	return
end

function SpringFestival2026ColoringAnshanscene:updateCells()
	local var_27_0 = self.colorGroups[self.selectedIndex]
	local var_27_1, var_27_2 = unpack(self.colorGroups[self.selectedIndex]:getConfig("theme"))

	for iter_27_0 = 0, var_27_1 do
		for iter_27_1 = 0, var_27_2 do
			self:updateCell(iter_27_0, iter_27_1)
		end
	end

	local var_27_3 = self.bg:GetComponent("EventTriggerListener")

	var_27_3:RemovePointClickFunc()
	var_27_3:RemoveBeginDragFunc()
	var_27_3:RemoveDragFunc()
	var_27_3:RemoveDragEndFunc()

	local var_27_4 = false

	var_27_3:AddPointClickFunc(function(arg_28_0, arg_28_1)
		if not var_27_0:canBeCustomised() then
			return
		end

		if var_27_4 then
			return
		end

		local var_28_0 = LuaHelper.ScreenToLocal(self.bg, arg_28_1.position, GameObject.Find("UICamera"):GetComponent(typeof(Camera)))
		local var_28_1 = math.floor(-var_28_0.y / self.cellSize.y)
		local var_28_2 = math.floor(var_28_0.x / self.cellSize.x)

		if var_27_0:getState() == ColorGroup.StateColoring then
			if not var_27_0:canBeCustomised() then
				return
			elseif self.selectedColorIndex == 0 and not var_27_0:hasFill(var_28_1, var_28_2) then
				return
			end

			;(function()
				self:emit(SpringFestival2026ColoringAnshanMediator.EVENT_COLORING_CELL, {
					activityId = self.activity.id,
					id = var_27_0.id,
					cells = self:searchColoringCells(var_27_0, var_28_1, var_28_2, self.selectedColorIndex)
				})

				return
			end)()
		end

		return
	end)
	var_27_3:AddBeginDragFunc(function()
		var_27_4 = false

		return
	end)

	local var_27_5 = Vector2.New(self.bg.rect.width / UnityEngine.Screen.width, self.bg.rect.height / UnityEngine.Screen.height)

	var_27_3:AddDragFunc(function(arg_31_0, arg_31_1)
		var_27_4 = true

		if not IsUnityEditor then
			self.zoom.enabled = Input.touchCount == 2
		end

		if IsUnityEditor or not self.zoom.enabled then
			local var_31_0 = self.bg.anchoredPosition

			var_31_0.x = self.bg.anchoredPosition.x + arg_31_1.delta.x * var_27_5.x
			var_31_0.x = math.clamp(var_31_0.x, -self.bg.rect.width * (self.bg.localScale.x - 1), 0)
			var_31_0.y = var_31_0.y + arg_31_1.delta.y * var_27_5.y
			var_31_0.y = math.clamp(var_31_0.y, 0, self.bg.rect.height * (self.bg.localScale.y - 1))
			self.bg.anchoredPosition = var_31_0
		end

		return
	end)
	var_27_3:AddDragEndFunc(function()
		var_27_4 = false

		return
	end)

	return
end

function SpringFestival2026ColoringAnshanscene:updateCell(arg_33_1, arg_33_2)
	local var_33_0 = self.colorGroups[self.selectedIndex]
	local var_33_1 = self.colorGroups[self.selectedIndex]:getCell(arg_33_1, arg_33_2)
	local var_33_2 = self.colorGroups[self.selectedIndex]:getFill(arg_33_1, arg_33_2)
	local var_33_3 = self.colorGroups[self.selectedIndex]:getState()

	if var_33_3 == ColorGroup.StateFinish or var_33_3 == ColorGroup.StateAchieved then
		var_33_2 = var_33_1
	end

	local var_33_4 = arg_33_1 .. "_" .. arg_33_2
	local var_33_5 = self.cells:Find(arg_33_1 .. "_" .. arg_33_2)

	if var_33_1 or var_33_2 then
		var_33_5 = var_33_5 or cloneTplTo(self.cell, self.cells, var_33_4)
		var_33_5.sizeDelta = self.cellSize
		var_33_5.anchoredPosition = Vector2((var_33_2 or var_33_1).column * self.cellSize.x, -((var_33_2 or var_33_1).row * self.cellSize.y))

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

function SpringFestival2026ColoringAnshanscene:calcCellSize()
	local var_34_0, var_34_1 = unpack(self.colorGroups[self.selectedIndex]:getConfig("theme"))

	return (Vector2.New(self.bg.rect.width / var_34_1, self.bg.rect.height / var_34_0))
end

function SpringFestival2026ColoringAnshanscene:updateLines()
	local var_35_0, var_35_1 = unpack(self.colorGroups[self.selectedIndex]:getConfig("theme"))

	for iter_35_0 = 1, var_35_1 - 1 do
		local var_35_2 = self.lines:Find("column_" .. iter_35_0) or cloneTplTo(self.line, self.lines, "column_" .. iter_35_0)

		var_35_2.sizeDelta = Vector2.New(1, self.lines.rect.height)
		var_35_2.anchoredPosition = Vector2.New(iter_35_0 * self.cellSize.x - 0.5, 0)
	end

	for iter_35_1 = 1, var_35_0 - 1 do
		local var_35_3 = self.lines:Find("row_" .. iter_35_1) or cloneTplTo(self.line, self.lines, "row_" .. iter_35_1)

		var_35_3.sizeDelta = Vector2.New(self.lines.rect.width, 1)
		var_35_3.anchoredPosition = Vector2.New(0, -(iter_35_1 * self.cellSize.y - 0.5))
	end

	return
end

function SpringFestival2026ColoringAnshanscene:searchColoringCells(arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	local var_36_0 = {
		row = arg_36_2,
		column = arg_36_3,
		color = arg_36_4
	}

	if arg_36_1:canBeCustomised() then
		return {
			var_36_0
		}
	else
		local var_36_1 = self.colorItems[arg_36_1:getConfig("color_id_list")[arg_36_4]]
		local var_36_2 = {}
		local var_36_3 = {}
		local var_36_4 = {
			var_36_0
		}
		local var_36_5 = {
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
		}

		while #var_36_4 > 0 and var_36_1 > 0 do
			local var_36_6 = table.remove(var_36_4, 1)

			if not arg_36_1:hasFill(var_36_6.row, var_36_6.column) and var_36_6.color == arg_36_4 then
				table.insert(var_36_2, var_36_6)

				var_36_1 = var_36_1 - 1

				_.each(var_36_5, function(arg_37_0)
					local var_37_0 = arg_36_1:getCell(arg_37_0.row + var_36_6.row, arg_37_0.column + var_36_6.column)

					if var_37_0 then
						if not (_.any(var_36_4, function(arg_38_0)
							return arg_38_0.row == var_37_0.row and arg_38_0.column == var_37_0.column
						end) or _.any(var_36_3, function(arg_39_0)
							return arg_39_0.row == var_37_0.row and arg_39_0.column == var_37_0.column
						end)) then
							table.insert(var_36_4, {
								row = var_37_0.row,
								column = var_37_0.column,
								color = var_37_0.type
							})
						end
					end

					return
				end)
			end

			table.insert(var_36_3, var_36_6)
		end

		return var_36_2
	end

	return
end

function SpringFestival2026ColoringAnshanscene:SearchValidDiagonalColoringCells(arg_40_1, arg_40_2, arg_40_3)
	assert(arg_40_1)

	local var_40_0 = {}

	if arg_40_1:getState() ~= ColorGroup.StateColoring or arg_40_1:canBeCustomised() or arg_40_3 == 0 then
		return var_40_0
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

		return var_40_0
	end

	return
end

function SpringFestival2026ColoringAnshanscene:TryPlayStory()
	local var_42_0 = self.selectedIndex

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

function SpringFestival2026ColoringAnshanscene:onBackPressed()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	triggerButton(self.btnBack)

	return
end

function SpringFestival2026ColoringAnshanscene:willExit()
	PoolMgr.GetInstance():ReturnUI(self.coloringUIGroupName, self.colorgroupbehind)

	return
end

return SpringFestival2026ColoringAnshanscene

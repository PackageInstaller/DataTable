local PacGameEditorController = class("PacGameEditorController")

function PacGameEditorController:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._sceneMask = arg_1_1
	self._event = arg_1_2
	self._runningData = arg_1_3
	self._content = findTF(self._sceneMask, "sceneContainer/scene/content/editor")
	self._mapTF = findTF(self._sceneMask, "sceneContainer/scene/content/map")
	self._editorUI = findTF(self._sceneMask, "sceneContainer/scene/content/editor_ui")
	self._editorGrids = {}
	self._editorGridDic = {}
	self._mapCreateGridDic = {}

	return
end

function PacGameEditorController:SetParent()
	return
end

function PacGameEditorController:SetPosition()
	return
end

function PacGameEditorController:SetScale()
	return
end

function PacGameEditorController:SetGridIndex()
	return
end

function PacGameEditorController:Prepare()
	self._editorFlag = self._runningData:GetEditor()
	self._content.anchoredPosition = self._mapTF.anchoredPosition

	return
end

function PacGameEditorController:Start()
	setActive(self._content, self._editorFlag)
	setActive(self._editorUI, self._editorFlag)

	if self._editorFlag then
		self:instanceEditorUI()
		self:createEditorGrid()
	end

	return
end

function PacGameEditorController:Step(arg_8_1)
	if not self._editorFlag then
		return
	end

	self._deltaTime = arg_8_1

	return
end

function PacGameEditorController:updateReflashTime()
	return
end

function PacGameEditorController:Clear()
	self._editorFlag = nil

	for iter_10_0, iter_10_1 in pairs(self._mapCreateGridDic) do
		iter_10_1:Dispose()
	end

	self._mapCreateGridDic = {}

	return
end

function PacGameEditorController:Stop()
	return
end

function PacGameEditorController:Resume()
	return
end

function PacGameEditorController:Dispose()
	for iter_13_0 = 1, #self._editorGrids do
		ClearEventTrigger((GetOrAddComponent(self._editorGrids[iter_13_0], typeof(EventTriggerListener))))
	end

	if self._btnOpenTrigger then
		ClearEventTrigger(self._btnOpenTrigger)

		self._btnOpenTrigger = nil
	end

	if self._btnExportTrigger then
		ClearEventTrigger(self._btnExportTrigger)

		self._btnExportTrigger = nil
	end

	for iter_13_1 = 1, #self._btnChapters do
		ClearEventTrigger(self._btnChapters[iter_13_1])
	end

	for iter_13_2 = 1, #self._gridPanelTFS do
		ClearEventTrigger((GetOrAddComponent(tf, typeof(EventTriggerListener))))
	end

	self._editorGridDic = {}

	return
end

function PacGameEditorController:instanceEditorUI()
	if self._initFlag then
		return
	end

	self._inputPanel = findTF(self._editorUI, "exportPanel")

	setActive(self._inputPanel, false)

	self._inputField = GetOrAddComponent(findTF(self._editorUI, "exportPanel/text"), typeof(InputField))
	self._initFlag = true
	self._gridList = findTF(self._editorUI, "gridList")
	self._gridContent = findTF(self._gridList, "content")
	self._gridPanelTFS = {}

	for iter_14_0, iter_14_1 in pairs(PacGameConst.grid_data) do
		if not iter_14_1.editor_ignore then
			local var_14_0 = self._runningData:GetTplItemFromPool(iter_14_1.prefab, self._gridContent)

			setActive(findTF(var_14_0, "ad/bottom"), true)
			setActive(findTF(var_14_0, "ad/select"), false)
			GetOrAddComponent(var_14_0, typeof(EventTriggerListener)):AddPointDownFunc(function()
				print("grid = " .. iter_14_1.prefab)

				if self._selectGridTF then
					setActive(findTF(self._selectGridTF, "ad/select"), false)
				end

				self._selectGridData = iter_14_1
				self._selectGridTF = var_14_0

				setActive(findTF(self._selectGridTF, "ad/select"), true)

				return
			end)
			table.insert(self._gridPanelTFS, var_14_0)
		end
	end

	self._btnOpenTrigger = GetOrAddComponent(findTF(self._editorUI, "btnOpen"), typeof(EventTriggerListener))

	self._btnOpenTrigger:AddPointDownFunc(function()
		setActive(self._gridList, not isActive(self._gridList) and true or false)

		return
	end)

	self._btnExportTrigger = GetOrAddComponent(findTF(self._editorUI, "btnExport"), typeof(EventTriggerListener))

	self._btnExportTrigger:AddPointDownFunc(function()
		setActive(self._inputPanel, not isActive(self._inputPanel) and true or false)
		setInputText(self._inputField, self:getExportText())
		print("export")

		return
	end)

	self._btnChapters = {}

	for iter_14_2 = 1, 7 do
		local var_14_1 = GetOrAddComponent(findTF(self._editorUI, "btnChapter_" .. iter_14_2), typeof(EventTriggerListener))

		table.insert(self._btnChapters, var_14_1)
		var_14_1:AddPointDownFunc(function()
			self:importChapter(iter_14_2)

			return
		end)
	end

	return
end

function PacGameEditorController:importChapter(arg_19_1)
	for iter_19_0 = 1, #PacGameConst.map_data[PacGameConst.chapter_data[arg_19_1].map].grid_list do
		for iter_19_1 = 1, #PacGameConst.map_data[PacGameConst.chapter_data[arg_19_1].map].grid_list[iter_19_0] do
			self:setCreateGridDic(iter_19_1 + (iter_19_0 - 1) * #PacGameConst.map_data[PacGameConst.chapter_data[arg_19_1].map].grid_list[iter_19_0], PacGameConst.map_data[PacGameConst.chapter_data[arg_19_1].map].grid_list[iter_19_0][iter_19_1])
		end
	end

	return
end

function PacGameEditorController:getExportText()
	local var_20_0 = self._runningData:GetGrids()
	local var_20_1, var_20_2 = self._runningData:GetGridWH()
	local var_20_3 = {}

	for iter_20_0 = 1, #var_20_0 do
		local var_20_4 = math.floor((iter_20_0 - 1) / var_20_2) + 1
		local var_20_6 = self._mapCreateGridDic[var_20_0[iter_20_0]:GetIndex()]
		local var_20_7 = 0

		if var_20_6 then
			var_20_7 = var_20_6:GetId()
		end

		var_20_3[var_20_4] = var_20_3[var_20_4] or {}

		if var_20_7 == PacGameConst.default_grid then
			var_20_7 = 0
		end

		table.insert(var_20_3[var_20_4], var_20_7)
	end

	local var_20_8 = ""

	for iter_20_1 = 1, #var_20_3 do
		var_20_8 = var_20_8 .. "{"

		for iter_20_2 = 1, #var_20_3[iter_20_1] do
			var_20_8 = iter_20_2 == 1 and var_20_8 .. var_20_3[iter_20_1][iter_20_2] or var_20_8 .. "," .. var_20_3[iter_20_1][iter_20_2]
		end

		var_20_8 = iter_20_1 ~= #var_20_3 and var_20_8 .. "},\n" or var_20_8 .. "},"
	end

	return var_20_8
end

function PacGameEditorController:createEditorGrid()
	if not self._editorGrids or #self._editorGrids <= 0 then
		local function var_21_0(arg_22_0, arg_22_1)
			GetOrAddComponent(arg_22_0, typeof(EventTriggerListener)):AddPointDownFunc(function()
				if self._selectGridData then
					self:setCreateGridDic(arg_22_1, self._selectGridData.id)
				else
					self:setCreateGridDic(arg_22_1, PacGameConst.default_grid)
				end

				return
			end)

			return
		end

		for iter_21_0, iter_21_1 in pairs((self._runningData:GetGridDic())) do
			local var_21_1 = iter_21_1:GetIndex()
			local var_21_2 = iter_21_1:GetPosition()
			local var_21_3 = self._runningData:GetTplItemFromPool(PacGameConst.grid_data[PacGameConst.editor_grid].prefab, self._content)

			setActive(findTF(var_21_3, "ad/select"), false)
			setActive(var_21_3, true)

			var_21_3.anchoredPosition = var_21_2

			setText(findTF(var_21_3, "ad/text"), var_21_1)
			setActive(findTF(var_21_3, "ad/red"), false)
			var_21_0(var_21_3, var_21_1)
			table.insert(self._editorGrids, var_21_3)

			self._editorGridDic[var_21_1] = var_21_3
		end
	end

	return
end

function PacGameEditorController:setCreateGridDic(arg_24_1, arg_24_2)
	if self._mapCreateGridDic[arg_24_1] then
		local var_24_0 = self._mapCreateGridDic[arg_24_1]:GetId()

		self._mapCreateGridDic[arg_24_1]:Dispose()

		self._mapCreateGridDic[arg_24_1] = nil

		setActive(findTF(self._editorGridDic[arg_24_1], "ad/red"), false)

		if var_24_0 ~= 0 and var_24_0 ~= PacGameConst.default_grid then
			return
		end
	end

	if arg_24_2 then
		if arg_24_2 == 0 then
			arg_24_2 = PacGameConst.default_grid
		end

		local var_24_1 = PacGameConst.grid_data[arg_24_2]
		local var_24_2 = PacGameGrid.New(self._runningData:GetTplItemFromPool(PacGameConst.grid_data[arg_24_2].prefab, self._mapTF), arg_24_1, arg_24_2)

		var_24_2:SetPosition(self._editorGridDic[arg_24_1].anchoredPosition)
		var_24_2:SetActive(true)
		setActive(findTF(self._editorGridDic[arg_24_1], "ad/red"), not var_24_1.pass)

		self._mapCreateGridDic[arg_24_1] = var_24_2
	end

	return
end

return PacGameEditorController

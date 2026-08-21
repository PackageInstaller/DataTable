local var_0_0 = class("PacGameEditorController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._sceneMask = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._runningData = arg_1_3
	arg_1_0._content = findTF(arg_1_0._sceneMask, "sceneContainer/scene/content/editor")
	arg_1_0._mapTF = findTF(arg_1_0._sceneMask, "sceneContainer/scene/content/map")
	arg_1_0._editorUI = findTF(arg_1_0._sceneMask, "sceneContainer/scene/content/editor_ui")
	arg_1_0._editorGrids = {}
	arg_1_0._editorGridDic = {}
	arg_1_0._mapCreateGridDic = {}

	return
end

function var_0_0.SetParent(arg_2_0)
	return
end

function var_0_0.SetPosition(arg_3_0)
	return
end

function var_0_0.SetScale(arg_4_0)
	return
end

function var_0_0.SetGridIndex(arg_5_0)
	return
end

function var_0_0.Prepare(arg_6_0)
	arg_6_0._editorFlag = arg_6_0._runningData:GetEditor()
	arg_6_0._content.anchoredPosition = arg_6_0._mapTF.anchoredPosition

	return
end

function var_0_0.Start(arg_7_0)
	setActive(arg_7_0._content, arg_7_0._editorFlag)
	setActive(arg_7_0._editorUI, arg_7_0._editorFlag)

	if arg_7_0._editorFlag then
		arg_7_0:instanceEditorUI()
		arg_7_0:createEditorGrid()
	end

	return
end

function var_0_0.Step(arg_8_0, arg_8_1)
	if not arg_8_0._editorFlag then
		return
	end

	arg_8_0._deltaTime = arg_8_1

	return
end

function var_0_0.updateReflashTime(arg_9_0)
	return
end

function var_0_0.Clear(arg_10_0)
	arg_10_0._editorFlag = nil

	for iter_10_0, iter_10_1 in pairs(arg_10_0._mapCreateGridDic) do
		iter_10_1:Dispose()
	end

	arg_10_0._mapCreateGridDic = {}

	return
end

function var_0_0.Stop(arg_11_0)
	return
end

function var_0_0.Resume(arg_12_0)
	return
end

function var_0_0.Dispose(arg_13_0)
	for iter_13_0 = 1, #arg_13_0._editorGrids do
		ClearEventTrigger((GetOrAddComponent(arg_13_0._editorGrids[iter_13_0], typeof(EventTriggerListener))))
	end

	if arg_13_0._btnOpenTrigger then
		ClearEventTrigger(arg_13_0._btnOpenTrigger)

		arg_13_0._btnOpenTrigger = nil
	end

	if arg_13_0._btnExportTrigger then
		ClearEventTrigger(arg_13_0._btnExportTrigger)

		arg_13_0._btnExportTrigger = nil
	end

	for iter_13_1 = 1, #arg_13_0._btnChapters do
		ClearEventTrigger(arg_13_0._btnChapters[iter_13_1])
	end

	for iter_13_2 = 1, #arg_13_0._gridPanelTFS do
		ClearEventTrigger((GetOrAddComponent(tf, typeof(EventTriggerListener))))
	end

	arg_13_0._editorGridDic = {}

	return
end

function var_0_0.instanceEditorUI(arg_14_0)
	if arg_14_0._initFlag then
		return
	end

	arg_14_0._inputPanel = findTF(arg_14_0._editorUI, "exportPanel")

	setActive(arg_14_0._inputPanel, false)

	arg_14_0._inputField = GetOrAddComponent(findTF(arg_14_0._editorUI, "exportPanel/text"), typeof(InputField))
	arg_14_0._initFlag = true
	arg_14_0._gridList = findTF(arg_14_0._editorUI, "gridList")
	arg_14_0._gridContent = findTF(arg_14_0._gridList, "content")
	arg_14_0._gridPanelTFS = {}

	for iter_14_0, iter_14_1 in pairs(PacGameConst.grid_data) do
		if not iter_14_1.editor_ignore then
			local var_14_0 = arg_14_0._runningData:GetTplItemFromPool(iter_14_1.prefab, arg_14_0._gridContent)

			setActive(findTF(var_14_0, "ad/bottom"), true)
			setActive(findTF(var_14_0, "ad/select"), false)
			GetOrAddComponent(var_14_0, typeof(EventTriggerListener)):AddPointDownFunc(function()
				print("grid = " .. iter_14_1.prefab)

				if arg_14_0._selectGridTF then
					setActive(findTF(arg_14_0._selectGridTF, "ad/select"), false)
				end

				arg_14_0._selectGridData = iter_14_1
				arg_14_0._selectGridTF = var_14_0

				setActive(findTF(arg_14_0._selectGridTF, "ad/select"), true)

				return
			end)
			table.insert(arg_14_0._gridPanelTFS, var_14_0)
		end
	end

	arg_14_0._btnOpenTrigger = GetOrAddComponent(findTF(arg_14_0._editorUI, "btnOpen"), typeof(EventTriggerListener))

	arg_14_0._btnOpenTrigger:AddPointDownFunc(function()
		setActive(arg_14_0._gridList, not isActive(arg_14_0._gridList) and true or false)

		return
	end)

	arg_14_0._btnExportTrigger = GetOrAddComponent(findTF(arg_14_0._editorUI, "btnExport"), typeof(EventTriggerListener))

	arg_14_0._btnExportTrigger:AddPointDownFunc(function()
		setActive(arg_14_0._inputPanel, not isActive(arg_14_0._inputPanel) and true or false)
		setInputText(arg_14_0._inputField, arg_14_0:getExportText())
		print("export")

		return
	end)

	arg_14_0._btnChapters = {}

	for iter_14_2 = 1, 7 do
		local var_14_1 = GetOrAddComponent(findTF(arg_14_0._editorUI, "btnChapter_" .. iter_14_2), typeof(EventTriggerListener))

		table.insert(arg_14_0._btnChapters, var_14_1)
		var_14_1:AddPointDownFunc(function()
			arg_14_0:importChapter(iter_14_2)

			return
		end)
	end

	return
end

function var_0_0.importChapter(arg_19_0, arg_19_1)
	for iter_19_0 = 1, #PacGameConst.map_data[PacGameConst.chapter_data[arg_19_1].map].grid_list do
		for iter_19_1 = 1, #PacGameConst.map_data[PacGameConst.chapter_data[arg_19_1].map].grid_list[iter_19_0] do
			arg_19_0:setCreateGridDic(iter_19_1 + (iter_19_0 - 1) * #PacGameConst.map_data[PacGameConst.chapter_data[arg_19_1].map].grid_list[iter_19_0], PacGameConst.map_data[PacGameConst.chapter_data[arg_19_1].map].grid_list[iter_19_0][iter_19_1])
		end
	end

	return
end

function var_0_0.getExportText(arg_20_0)
	local var_20_0 = arg_20_0._runningData:GetGrids()
	local var_20_1, var_20_2 = arg_20_0._runningData:GetGridWH()

	for iter_20_0 = 1, #var_20_0 do
		local var_20_3 = math.floor((iter_20_0 - 1) / var_20_2) + 1
		local var_20_5 = arg_20_0._mapCreateGridDic[var_20_0[iter_20_0]:GetIndex()]
		local var_20_6 = 0

		if var_20_5 then
			var_20_6 = var_20_5:GetId()
		end

		if not ({})[var_20_3] then
			({})[var_20_3] = {}
		end

		if var_20_6 == PacGameConst.default_grid then
			var_20_6 = 0
		end

		table.insert(({})[var_20_3], var_20_6)
	end

	local var_20_7 = ""

	for iter_20_1 = 1, #{} do
		var_20_7 = var_20_7 .. "{"

		for iter_20_2 = 1, #({})[iter_20_1] do
			var_20_7 = iter_20_2 == 1 and var_20_7 .. ({})[iter_20_1][iter_20_2] or var_20_7 .. "," .. ({})[iter_20_1][iter_20_2]
		end

		var_20_7 = iter_20_1 ~= #{} and var_20_7 .. "},\n" or var_20_7 .. "},"
	end

	return var_20_7
end

function var_0_0.createEditorGrid(arg_21_0)
	if not arg_21_0._editorGrids or #arg_21_0._editorGrids <= 0 then
		for iter_21_0, iter_21_1 in pairs((arg_21_0._runningData:GetGridDic())) do
			local var_21_1 = iter_21_1:GetIndex()
			local var_21_2 = iter_21_1:GetPosition()
			local var_21_3 = arg_21_0._runningData:GetTplItemFromPool(PacGameConst.grid_data[PacGameConst.editor_grid].prefab, arg_21_0._content)

			setActive(findTF(var_21_3, "ad/select"), false)
			setActive(var_21_3, true)

			var_21_3.anchoredPosition = var_21_2

			setText(findTF(var_21_3, "ad/text"), var_21_1)
			setActive(findTF(var_21_3, "ad/red"), false)
			var_21_0(var_21_3, var_21_1)
			table.insert(arg_21_0._editorGrids, var_21_3)

			arg_21_0._editorGridDic[var_21_1] = var_21_3
		end
	end

	return
end

function var_0_0.setCreateGridDic(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0._mapCreateGridDic[arg_24_1] then
		local var_24_0 = arg_24_0._mapCreateGridDic[arg_24_1]:GetId()

		arg_24_0._mapCreateGridDic[arg_24_1]:Dispose()

		arg_24_0._mapCreateGridDic[arg_24_1] = nil

		setActive(findTF(arg_24_0._editorGridDic[arg_24_1], "ad/red"), false)

		if var_24_0 ~= 0 and var_24_0 ~= PacGameConst.default_grid then
			return
		end
	end

	if arg_24_2 then
		if arg_24_2 == 0 then
			arg_24_2 = PacGameConst.default_grid
		end

		local var_24_1 = PacGameConst.grid_data[arg_24_2]
		local var_24_2 = PacGameGrid.New(arg_24_0._runningData:GetTplItemFromPool(PacGameConst.grid_data[arg_24_2].prefab, arg_24_0._mapTF), arg_24_1, arg_24_2)

		var_24_2:SetPosition(arg_24_0._editorGridDic[arg_24_1].anchoredPosition)
		var_24_2:SetActive(true)
		setActive(findTF(arg_24_0._editorGridDic[arg_24_1], "ad/red"), not var_24_1.pass)

		arg_24_0._mapCreateGridDic[arg_24_1] = var_24_2
	end

	return
end

return var_0_0

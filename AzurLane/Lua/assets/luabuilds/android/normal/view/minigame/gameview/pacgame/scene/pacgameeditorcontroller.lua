class = var_0_10000

local var_0_0 = var_0_10000("PacGameEditorController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._sceneMask = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._runningData = arg_1_3
	findTF = var_1_10004
	arg_1_0._content = var_1_10004(arg_1_0._sceneMask, "sceneContainer/scene/content/editor")
	findTF = var_4
	arg_1_0._mapTF = var_4(arg_1_0._sceneMask, "sceneContainer/scene/content/map")
	findTF = var_4
	arg_1_0._editorUI = var_4(arg_1_0._sceneMask, "sceneContainer/scene/content/editor_ui")
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
	local var_6_0 = arg_6_0._runningData

	arg_6_0._editorFlag = var_1.GetEditor(var_6_0)
	arg_6_0._content.anchoredPosition = arg_6_0._mapTF.anchoredPosition

	return
end

function var_0_0.Start(arg_7_0)
	setActive = var_1_10001

	var_1_10001(arg_7_0._content, arg_7_0._editorFlag)

	setActive = var_1_10001

	var_1_10001(arg_7_0._editorUI, arg_7_0._editorFlag)

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
	pairs = var_1

	for iter_10_0, iter_10_1 in var_1(arg_10_0._mapCreateGridDic) do
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
		var_1_10005 = arg_13_0._editorGrids[iter_13_0]
		GetOrAddComponent = var_1_10006
		var_1_10007 = var_1_10005
		typeof = var_1_10008
		EventTriggerListener = var_1_10009
		var_1_10006 = var_1_10006(var_1_10007, var_1_10008(var_1_10009))
		ClearEventTrigger = var_1_10007

		var_1_10007(var_1_10006)
	end

	if arg_13_0._btnOpenTrigger then
		ClearEventTrigger = var_1

		var_1(arg_13_0._btnOpenTrigger)

		arg_13_0._btnOpenTrigger = nil
	end

	if arg_13_0._btnExportTrigger then
		ClearEventTrigger = var_1

		var_1(arg_13_0._btnExportTrigger)

		arg_13_0._btnExportTrigger = nil
	end

	for iter_13_1 = 1, #arg_13_0._btnChapters do
		ClearEventTrigger = var_1_10005

		var_1_10005(arg_13_0._btnChapters[iter_13_1])
	end

	for iter_13_2 = 1, #arg_13_0._gridPanelTFS do
		local var_13_0 = arg_13_0._gridPanelTFS[iter_13_2]

		GetOrAddComponent = var_1_10006
		tf = var_1_10007
		typeof = var_1_10008
		EventTriggerListener = var_1_10009
		var_1_10006 = var_1_10006(var_1_10007, var_1_10008(var_1_10009))
		ClearEventTrigger = var_1_10007

		var_1_10007(var_1_10006)
	end

	arg_13_0._editorGridDic = {}

	return
end

function var_0_0.instanceEditorUI(arg_14_0)
	if arg_14_0._initFlag then
		return
	end

	findTF = var_1
	arg_14_0._inputPanel = var_1(arg_14_0._editorUI, "exportPanel")
	setActive = var_1

	var_1(arg_14_0._inputPanel, false)

	GetOrAddComponent = var_1
	findTF = var_2

	local var_14_0 = var_2(arg_14_0._editorUI, "exportPanel/text")

	typeof = var_3
	InputField = var_4
	arg_14_0._inputField = var_1(var_14_0, var_3(var_4))
	arg_14_0._initFlag = true
	findTF = var_1
	arg_14_0._gridList = var_1(arg_14_0._editorUI, "gridList")
	findTF = var_1
	arg_14_0._gridContent = var_1(arg_14_0._gridList, "content")
	arg_14_0._gridPanelTFS = {}
	pairs = var_1
	PacGameConst = var_2

	for iter_14_0, iter_14_1 in var_1(var_2.grid_data) do
		if not iter_14_1.editor_ignore then
			var_1_10006 = iter_14_1.prefab

			local var_14_1 = arg_14_0._runningData
			local var_14_2 = var_7.GetTplItemFromPool(var_14_1, var_1_10006, arg_14_0._gridContent)

			setActive = var_14_1
			findTF = var_9

			var_14_1(var_9(var_14_2, "ad/bottom"), true)

			setActive = var_14_1
			findTF = var_9

			var_14_1(var_9(var_14_2, "ad/select"), false)

			GetOrAddComponent = var_14_1

			local var_14_3 = var_14_2

			typeof = var_10
			EventTriggerListener = var_11

			local var_14_4 = var_14_1(var_14_3, var_10(var_11))

			var_8.AddPointDownFunc(var_14_4, function()
				print = var_2_10000

				var_2_10000("grid = " .. iter_14_1.prefab)

				if arg_14_0._selectGridTF then
					setActive = var_0
					findTF = var_1

					var_0(var_1(arg_14_0._selectGridTF, "ad/select"), false)
				end

				arg_14_0._selectGridData = iter_14_1

				local var_15_0 = arg_14_0

				var_15_0._selectGridTF = var_14_2
				setActive = var_15_0
				findTF = var_1

				var_15_0(var_1(arg_14_0._selectGridTF, "ad/select"), true)

				return
			end)

			table = var_9

			var_9.insert(arg_14_0._gridPanelTFS, var_14_2)
		end
	end

	GetOrAddComponent = var_1
	findTF = var_2

	local var_14_5 = var_2(arg_14_0._editorUI, "btnOpen")

	typeof = var_3
	EventTriggerListener = var_4
	arg_14_0._btnOpenTrigger = var_1(var_14_5, var_3(var_4))

	local var_14_6 = arg_14_0._btnOpenTrigger

	var_1.AddPointDownFunc(var_14_6, function()
		setActive = var_2_10000

		local var_16_0 = arg_14_0._gridList

		isActive = var_2_10002

		var_2_10000(var_16_0, not var_2_10002(arg_14_0._gridList) and true or false)

		return
	end)

	GetOrAddComponent = var_1
	findTF = var_14_6

	local var_14_7 = var_14_6(arg_14_0._editorUI, "btnExport")

	typeof = var_3
	EventTriggerListener = var_4
	arg_14_0._btnExportTrigger = var_1(var_14_7, var_3(var_4))

	local var_14_8 = arg_14_0._btnExportTrigger

	var_1.AddPointDownFunc(var_14_8, function()
		setActive = var_2_10000

		local var_17_0 = arg_14_0._inputPanel

		isActive = var_2_10002

		var_2_10000(var_17_0, not var_2_10002(arg_14_0._inputPanel) and true or false)

		setInputText = var_2_10000

		local var_17_1 = arg_14_0._inputField
		local var_17_2 = arg_14_0

		var_2_10000(var_17_1, var_2.getExportText(var_17_2))

		print = var_2_10000

		var_2_10000("export")

		return
	end)

	arg_14_0._btnChapters = {}

	for iter_14_2 = 1, 7 do
		GetOrAddComponent = iter_14_1
		findTF = var_1_10006
		var_1_10006 = var_1_10006(arg_14_0._editorUI, "btnChapter_" .. iter_14_2)
		typeof = var_7
		EventTriggerListener = var_8
		iter_14_1 = iter_14_1(var_1_10006, var_7(var_8))
		table = var_1_10006

		var_1_10006.insert(arg_14_0._btnChapters, iter_14_1)
		iter_14_1:AddPointDownFunc(function()
			local var_18_0 = arg_14_0

			var_0.importChapter(var_18_0, iter_14_2)

			return
		end)
	end

	return
end

function var_0_0.importChapter(arg_19_0, arg_19_1)
	PacGameConst = var_1_10002

	local var_19_0 = var_1_10002.chapter_data[arg_19_1].map

	PacGameConst = var_1_10003

	local var_19_1 = var_1_10003.map_data[var_19_0].grid_list

	for iter_19_0 = 1, #var_19_1 do
		local var_19_2 = var_19_1[iter_19_0]

		for iter_19_1 = 1, #var_19_2 do
			local var_19_3 = var_19_2[iter_19_1]
			local var_19_4 = iter_19_1 + (iter_19_0 - 1) * #var_19_2

			arg_19_0:setCreateGridDic(var_19_4, var_19_3)
		end
	end

	return
end

function var_0_0.getExportText(arg_20_0)
	local var_20_0 = arg_20_0._runningData
	local var_20_1 = var_1.GetGrids(var_20_0)
	local var_20_2 = arg_20_0._runningData
	local var_20_3, var_20_4 = var_2.GetGridWH(var_20_2)
	local var_20_5 = {}

	for iter_20_0 = 1, #var_20_1 do
		math = var_1_10009
		var_1_10009 = var_1_10009.floor((iter_20_0 - 1) / var_20_4) + 1

		local var_20_6 = (iter_20_0 - 1) % var_20_4
		local var_20_7 = var_20_1[iter_20_0]
		local var_20_8 = var_11.GetIndex(var_20_7)
		local var_20_9 = arg_20_0._mapCreateGridDic[var_20_8]
		local var_20_10 = 0

		if var_20_9 then
			var_20_10 = var_20_9:GetId()
		end

		if not var_20_5[var_1_10009] then
			var_20_5[var_1_10009] = {}
		end

		PacGameConst = var_14

		if var_20_10 == var_14.default_grid then
			var_20_10 = 0
		end

		table = var_14

		var_14.insert(var_20_5[var_1_10009], var_20_10)
	end

	local var_20_11 = ""

	for iter_20_1 = 1, #var_20_5 do
		local var_20_12 = var_20_5[iter_20_1]

		var_20_11 = var_20_11 .. "{"

		for iter_20_2 = 1, #var_20_12 do
			if iter_20_2 == 1 then
				var_20_11 = var_20_11 .. var_20_12[iter_20_2]
			else
				var_20_11 = var_20_11 .. "," .. var_20_12[iter_20_2]
			end
		end

		if iter_20_1 ~= #var_20_5 then
			var_20_11 = var_20_11 .. "},\n"
		else
			var_20_11 = var_20_11 .. "},"
		end
	end

	return var_20_11
end

function var_0_0.createEditorGrid(arg_21_0)
	if not arg_21_0._editorGrids or #arg_21_0._editorGrids <= 0 then
		local function var_21_0(arg_22_0, arg_22_1)
			GetOrAddComponent = var_2_10002

			local var_22_0 = arg_22_0

			typeof = var_2_10004
			EventTriggerListener = var_2_10005

			local var_22_1 = var_2_10002(var_22_0, var_2_10004(var_2_10005))

			var_2.AddPointDownFunc(var_22_1, function()
				if arg_21_0._selectGridData then
					local var_23_0 = arg_21_0

					var_0.setCreateGridDic(var_23_0, arg_22_1, arg_21_0._selectGridData.id)
				else
					local var_23_1 = arg_21_0
					local var_23_2 = var_0.setCreateGridDic
					local var_23_3 = arg_22_1

					PacGameConst = var_3_10003

					var_23_2(var_23_1, var_23_3, var_3_10003.default_grid)
				end

				return
			end)

			return
		end

		local var_21_1 = arg_21_0._runningData
		local var_21_2 = var_2.GetGridDic(var_21_1)

		pairs = var_21_1

		for iter_21_0, iter_21_1 in var_21_1(var_21_2) do
			local var_21_3 = iter_21_1:GetIndex()
			local var_21_4 = iter_21_1
			local var_21_5 = iter_21_1.GetPosition(var_21_4)

			PacGameConst = var_21_4

			local var_21_6 = var_21_4.grid_data

			PacGameConst = var_1_10011

			local var_21_7 = var_21_6[var_1_10011.editor_grid].prefab
			local var_21_8 = arg_21_0._runningData

			var_1_10011 = var_1_10011.GetTplItemFromPool(var_21_8, var_21_7, arg_21_0._content)
			setActive = var_21_8
			findTF = var_13

			var_21_8(var_13(var_1_10011, "ad/select"), false)

			setActive = var_21_8

			var_21_8(var_1_10011, true)

			var_1_10011.anchoredPosition = var_21_5
			setText = var_21_8
			findTF = var_13

			var_21_8(var_13(var_1_10011, "ad/text"), var_21_3)

			setActive = var_21_8
			findTF = var_13

			var_21_8(var_13(var_1_10011, "ad/red"), false)
			var_21_0(var_1_10011, var_21_3)

			table = var_12

			var_12.insert(arg_21_0._editorGrids, var_1_10011)

			arg_21_0._editorGridDic[var_21_3] = var_1_10011
		end
	end

	return
end

function var_0_0.setCreateGridDic(arg_24_0, arg_24_1, arg_24_2)
	local var_24_1

	if arg_24_0._mapCreateGridDic[arg_24_1] then
		local var_24_0 = arg_24_0._mapCreateGridDic[arg_24_1]

		var_24_1 = var_24_1.GetId(var_24_0)

		local var_24_2 = arg_24_0._mapCreateGridDic[arg_24_1]

		var_4.Dispose(var_24_2)

		local var_24_3 = arg_24_0._mapCreateGridDic

		var_24_3[arg_24_1] = nil
		setActive = var_24_3
		findTF = var_5

		var_24_3(var_5(arg_24_0._editorGridDic[arg_24_1], "ad/red"), false)

		if var_24_1 ~= 0 then
			PacGameConst = var_24_3

			if var_24_1 ~= var_24_3.default_grid then
				return
			end
		end
	end

	if arg_24_2 then
		if arg_24_2 == 0 then
			PacGameConst = var_24_1
			arg_24_2 = var_24_1.default_grid
		end

		PacGameConst = var_24_1

		local var_24_4 = var_24_1.grid_data[arg_24_2]
		local var_24_5 = arg_24_0._runningData
		local var_24_6 = var_4.GetTplItemFromPool(var_24_5, var_24_4.prefab, arg_24_0._mapTF)

		PacGameGrid = var_24_5

		local var_24_7 = var_24_5.New(var_24_6, arg_24_1, arg_24_2)
		local var_24_8 = arg_24_0._editorGridDic[arg_24_1].anchoredPosition

		var_24_7:SetPosition(var_24_8)

		local var_24_9 = var_24_7

		var_24_7.SetActive(var_24_9, true)

		setActive = var_7
		findTF = var_24_9

		var_7(var_24_9(arg_24_0._editorGridDic[arg_24_1], "ad/red"), not var_24_4.pass)

		arg_24_0._mapCreateGridDic[arg_24_1] = var_24_7
	end

	return
end

return var_0_0

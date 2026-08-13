class = var_0_10000

local var_0_0 = var_0_10000("RecordableSearchBar")

function var_0_0.CreateData(arg_1_0)
	local var_1_0 = {}

	assert = var_1_10002

	var_1_10002(arg_1_0.key, "key is required")

	assert = var_1_10002

	var_1_10002(arg_1_0.parent, "parent is required")

	local var_1_1

	if not arg_1_0.uiName then
		var_1_1 = "RecordableSearchBarUI"
	end

	var_1_0.uiName = var_1_1
	var_1_0.synPosition = arg_1_0.synPosition

	local var_1_2

	if not arg_1_0.position then
		Vector3 = var_1_2
		var_1_2 = var_1_2.zero
	end

	var_1_0.position = var_1_2

	local var_1_3

	if not arg_1_0.anchoredPosition then
		Vector3 = var_1_3
		var_1_3 = var_1_3.zero
	end

	var_1_0.anchoredPosition = var_1_3

	local var_1_4

	if not arg_1_0.holder then
		var_1_4 = "..."
	end

	var_1_0.holder = var_1_4
	var_1_0.onSearch = arg_1_0.onSearch
	var_1_0.onActive = arg_1_0.onActive
	var_1_0.onInputChanged = arg_1_0.onInputChanged
	var_1_0.enabledFlag = arg_1_0.enabledFlag
	var_1_0.expandParent = arg_1_0.expand_parent
	var_1_0.refreshPosWhenExpand = arg_1_0.refresh_pos_when_expand
	var_1_0.key = arg_1_0.key .. "_SearchBar_"
	var_1_0.parent = arg_1_0.parent

	return var_1_0
end

local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function var_0_0.Ctor(arg_2_0, arg_2_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_2_0)

	arg_2_0.enabledFlag = arg_2_1.enabledFlag
	arg_2_0.state = var_0_1
	arg_2_0.data = arg_2_1

	arg_2_0:Load()

	return
end

function var_0_0.IsEmpty(arg_3_0)
	return arg_3_0.state == var_0_1 or arg_3_0.state == var_0_4
end

function var_0_0.IsLoaded(arg_4_0)
	return arg_4_0.state == var_0_3
end

function var_0_0.IsDestory(arg_5_0)
	return arg_5_0.state == var_0_4
end

function var_0_0.Load(arg_6_0)
	local var_6_0 = arg_6_0

	if not arg_6_0.IsEmpty(var_6_0) then
		return
	end

	arg_6_0.state = var_0_2

	local var_6_1 = arg_6_0.data

	LoadAndInstantiateAsync = var_6_0

	var_6_0("ui", var_6_1.uiName, function(arg_7_0)
		local var_7_0 = arg_6_0

		if var_1.IsDestory(var_7_0) then
			local var_7_1 = arg_6_0

			var_1.Unload(var_7_1, arg_7_0)

			return
		end

		local var_7_2 = arg_6_0

		var_1.Init(var_7_2, arg_7_0)

		return
	end, true, true)

	return
end

function var_0_0.Init(arg_8_0, arg_8_1)
	arg_8_0._go = arg_8_1

	local var_8_0 = arg_8_0.data
	local var_8_1 = arg_8_1.transform

	var_3.SetParent(var_8_1, var_8_0.parent, false)
	arg_8_0:InitToggle()
	arg_8_0:UpdatePosition()
	arg_8_0:UpdateAnchoredPosition()

	if var_8_0.synPosition then
		arg_8_0:SyncPosition()
	end

	if arg_8_0.enabledFlag ~= nil then
		setActive = var_3

		var_3(arg_8_0._go, arg_8_0.enabledFlag)

		arg_8_0.enabledFlag = nil
	end

	arg_8_0.state = var_0_3

	return
end

function var_0_0.InitToggle(arg_9_0)
	local var_9_0 = arg_9_0.data
	local var_9_1 = arg_9_0._go.transform

	arg_9_0.toggle = var_2.Find(var_9_1, "button/Image")

	local var_9_2 = arg_9_0._go.transform

	arg_9_0.onTr = var_2.Find(var_9_2, "button/Image/on")

	local var_9_3 = arg_9_0._go.transform

	arg_9_0.offTr = var_2.Find(var_9_3, "button/Image/off")

	local var_9_4 = arg_9_0._go.transform

	arg_9_0.searchTr = var_2.Find(var_9_4, "button/search")

	local var_9_5 = arg_9_0._go.transform
	local var_9_6 = var_2.Find(var_9_5, "button/search/holder")
	local var_9_7 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_9_0.holder = var_9_7(var_9_6, var_4(var_1_10005))

	local var_9_8 = arg_9_0._go

	arg_9_0.noDrawGraphicCom = var_2.GetComponent(var_9_8, "NoDrawingGraphic")

	local var_9_9 = arg_9_0._go.transform

	arg_9_0.historyTr = var_2.Find(var_9_9, "button/history")
	UIItemList = var_2

	local var_9_10 = var_2.New
	local var_9_11 = arg_9_0.historyTr
	local var_9_12 = arg_9_0.historyTr

	arg_9_0.uiHistoryList = var_9_10(var_9_11, var_4.Find(var_9_12, "Text"))

	local var_9_13 = arg_9_0._go.transform

	arg_9_0.mainBtnTr = var_2.Find(var_9_13, "button")
	arg_9_0.isSelected = false
	onToggle = var_2

	local var_9_14 = arg_9_0
	local var_9_15 = arg_9_0.toggle

	local function var_9_16(arg_10_0)
		setActive = var_2_10001

		var_2_10001(arg_9_0.onTr, arg_10_0)

		setActive = var_2_10001

		var_2_10001(arg_9_0.searchTr, arg_10_0)

		setActive = var_2_10001

		var_2_10001(arg_9_0.offTr, not arg_10_0)

		if var_9_0.onActive then
			var_9_0.onActive(arg_10_0)
		end

		if not arg_10_0 then
			local var_10_0 = arg_9_0

			var_1.OnUnSelectedInputField(var_10_0)
		end

		local var_10_1 = arg_9_0

		var_1.Reparent(var_10_1, arg_10_0)

		return
	end

	SFX_PANEL = var_6

	var_2(var_9_14, var_9_15, var_9_16, var_6)

	triggerToggle = var_2

	var_2(arg_9_0.toggle, false)

	local var_9_17 = arg_9_0.searchTr
	local var_9_18 = var_2.GetComponent

	typeof = var_4
	EventTriggerListener = var_9_16
	arg_9_0.etl = var_9_18(var_9_17, var_4(var_9_16))

	local var_9_19 = arg_9_0.etl

	var_2.AddSelectFunc(var_9_19, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_9_0

		var_2.OnSelectedInputField(var_11_0)

		return
	end)

	onInputEndEdit = var_2

	var_2(arg_9_0, arg_9_0.searchTr, function()
		getInputText = var_2_10000

		local var_12_0 = var_2_10000(arg_9_0.searchTr)
		local var_12_1 = arg_9_0

		var_1.RecordSearch(var_12_1, var_12_0)

		if var_9_0.onSearch then
			var_9_0.onSearch(var_12_0)
		end

		return
	end)

	onInputChanged = var_2

	var_2(arg_9_0, arg_9_0.searchTr, function()
		if var_9_0.onInputChanged then
			local var_13_0 = var_9_0.onInputChanged

			str = var_2_10001

			var_13_0(var_2_10001)
		end

		return
	end)

	onButton = var_2

	local var_9_20 = arg_9_0
	local var_9_21 = arg_9_0._go

	local function var_9_22()
		getInputText = var_2_10000

		local var_14_0 = var_2_10000(arg_9_0.searchTr)
		local var_14_1 = arg_9_0

		var_1.RecordSearch(var_14_1, var_14_0)

		local var_14_2 = arg_9_0

		var_1.OnUnSelectedInputField(var_14_2)

		return
	end

	SFX_PANEL = var_6

	var_2(var_9_20, var_9_21, var_9_22, var_6)
	arg_9_0:UpdateHolder(var_9_0.holder)

	return
end

function var_0_0.Reparent(arg_15_0, arg_15_1)
	if arg_15_0.data.expandParent then
		local var_15_0

		if not arg_15_1 or not var_2.expandParent then
			var_15_0 = var_2.parent
		end

		local var_15_1 = arg_15_0._go.transform

		var_4.SetParent(var_15_1, var_15_0, false)

		if var_2.refreshPosWhenExpand then
			if arg_15_1 then
				arg_15_0.mainBtnTr.position = var_2.parent.position
			else
				arg_15_0:UpdateAnchoredPosition()
			end
		end
	end

	return
end

function var_0_0.UpdatePosition(arg_16_0)
	if not arg_16_0.data.position then
		return
	end

	local var_16_0 = arg_16_0._go.transform
	local var_16_1 = var_2.InverseTransformPoint(var_16_0, var_1.position)
	local var_16_2 = arg_16_0.mainBtnTr

	Vector3 = var_4
	var_16_2.localPosition = var_4(var_16_1.x, var_16_1.y, 0)

	return
end

function var_0_0.UpdateAnchoredPosition(arg_17_0)
	if not arg_17_0.data.anchoredPosition then
		return
	end

	arg_17_0.mainBtnTr.anchoredPosition = var_1.anchoredPosition

	return
end

function var_0_0.SyncPosition(arg_18_0)
	arg_18_0:RemoveSyncPosition()

	Timer = var_1
	arg_18_0.timer = var_1.New(function()
		local var_19_0 = arg_18_0

		var_0.UpdatePosition(var_19_0)

		return
	end, 0.1, -1)

	local var_18_0 = arg_18_0.timer

	var_1.Start(var_18_0)

	return
end

function var_0_0.RemoveSyncPosition(arg_20_0)
	if arg_20_0.timer then
		local var_20_0 = arg_20_0.timer

		var_1.Stop(var_20_0)

		arg_20_0.timer = nil
	end

	return
end

function var_0_0.RecordSearch(arg_21_0, arg_21_1)
	if not arg_21_1 or arg_21_1 == "" then
		return
	end

	local var_21_0 = arg_21_0.data.key
	local var_21_1 = arg_21_0
	local var_21_2 = arg_21_0.GetHistorySearch(var_21_1)

	table = var_21_1

	if var_21_1.contains(var_21_2, arg_21_1) then
		return
	end

	table = var_4

	var_4.insert(var_21_2, 1, arg_21_1)

	local var_21_3 = {}

	math = var_5

	local var_21_4 = var_5.min(#var_21_2, 3)

	for iter_21_0 = 1, var_21_4 do
		table = var_1_10010

		var_1_10010.insert(var_21_3, var_21_2[iter_21_0])
	end

	table = var_6

	local var_21_5 = var_6.concat(var_21_3, "#")

	PlayerPrefs = var_7

	var_7.SetString(var_21_0, var_21_5)

	PlayerPrefs = var_7

	var_7.Save()

	return
end

function var_0_0.GetHistorySearch(arg_22_0)
	local var_22_0 = arg_22_0.data.key

	PlayerPrefs = var_1_10002

	if not var_1_10002.GetString(var_22_0, "") or var_2 == "" then
		return {}
	end

	local var_22_1 = {}

	string = var_4

	local var_22_2 = var_4.split(var_2, "#")

	ipairs = var_5

	for iter_22_0, iter_22_1 in var_5(var_22_2) do
		if iter_22_1 ~= "" then
			table = var_1_10010

			var_1_10010.insert(var_22_1, iter_22_1)
		end
	end

	return var_22_1
end

function var_0_0.OnSelectedInputField(arg_23_0)
	local var_23_0 = arg_23_0:GetHistorySearch()

	if arg_23_0.isSelected or #var_23_0 <= 0 then
		return
	end

	arg_23_0.isSelected = true
	arg_23_0.noDrawGraphicCom.raycastTarget = true

	arg_23_0:InitHistorySearch(var_23_0)

	return
end

function var_0_0.OnUnSelectedInputField(arg_24_0)
	if not arg_24_0.isSelected then
		return
	end

	arg_24_0.isSelected = false
	arg_24_0.noDrawGraphicCom.raycastTarget = false

	arg_24_0:CloseHistorySearch()

	return
end

function var_0_0.InitHistorySearch(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.data

	setActive = var_1_10003

	var_1_10003(arg_25_0.historyTr, true)

	local var_25_1 = arg_25_0:GetHistorySearch()
	local var_25_2 = arg_25_0.uiHistoryList

	var_4.make(var_25_2, function(arg_26_0, arg_26_1, arg_26_2)
		local var_26_0 = arg_26_1 + 1

		UIItemList = var_2_10004

		if arg_26_0 == var_2_10004.EventUpdate then
			setText = var_4

			var_4(arg_26_2, var_25_1[var_26_0])

			onButton = var_4

			local var_26_1 = arg_25_0
			local var_26_2 = arg_26_2

			local function var_26_3()
				setInputText = var_3_10000

				var_3_10000(arg_25_0.searchTr, var_25_1[var_26_0])

				if var_25_0.onSearch then
					var_25_0.onSearch(var_25_1[var_26_0])
				end

				local var_27_0 = arg_25_0

				var_0.OnUnSelectedInputField(var_27_0)

				return
			end

			SFX_PANEL = var_2_10008

			var_4(var_26_1, var_26_2, var_26_3, var_2_10008)

			setActive = var_4

			var_4(arg_26_2:Find("Image"), var_26_0 ~= #var_25_1)
		end

		return
	end)

	local var_25_3 = arg_25_0.uiHistoryList

	var_4.align(var_25_3, #var_25_1)

	return
end

function var_0_0.CloseHistorySearch(arg_28_0)
	setActive = var_1_10001

	var_1_10001(arg_28_0.historyTr, false)

	return
end

function var_0_0.GetInputText(arg_29_0)
	if not arg_29_0:IsLoaded() then
		return ""
	end

	getInputText = var_1

	return var_1(arg_29_0.searchTr)
end

function var_0_0.UpdateHolder(arg_30_0, arg_30_1)
	if not arg_30_0:IsLoaded() then
		return
	end

	setText = var_2

	var_2(arg_30_0.holder, arg_30_1)

	return
end

function var_0_0.ClearInputText(arg_31_0)
	if not arg_31_0:IsLoaded() then
		return
	end

	setInputText = var_1

	var_1(arg_31_0.searchTr, "")

	return
end

function var_0_0.Unload(arg_32_0, arg_32_1)
	Object = var_1_10002

	var_1_10002.Destroy(arg_32_1)

	return
end

function var_0_0.EnableOrDisable(arg_33_0, arg_33_1)
	if arg_33_0:IsLoaded() then
		setActive = var_2

		var_2(arg_33_0._go, arg_33_1)
	else
		arg_33_0.enabledFlag = arg_33_1
	end

	return
end

function var_0_0.Dispose(arg_34_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_34_0)

	if arg_34_0:IsLoaded() then
		arg_34_0:Unload(arg_34_0._go)
		arg_34_0:OnUnSelectedInputField()

		if arg_34_0.etl then
			ClearEventTrigger = var_1

			var_1(arg_34_0.etl)
		end

		setInputText = var_1

		var_1(arg_34_0.searchTr, "")
		arg_34_0:RemoveSyncPosition()
	end

	arg_34_0.state = var_0_4
	arg_34_0.data = nil
	arg_34_0.enabledFlag = nil
	arg_34_0._go = nil

	return
end

return var_0_0

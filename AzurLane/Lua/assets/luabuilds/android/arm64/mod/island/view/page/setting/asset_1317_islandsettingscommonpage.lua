class = var_0_10000

local var_0_0 = "IslandSettingsCommonPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandSettingsCommonPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.panelContainer = var_1.Find(var_2_0, "content")

	local var_2_1 = arg_2_0:GetPanels()

	arg_2_0.panels = {}
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(var_2_1) do
		table = var_1_10007

		var_1_10007.insert(arg_2_0.panels, iter_2_1.New(arg_2_0.panelContainer))
	end

	local var_2_2 = arg_2_0.panelContainer
	local var_2_3 = var_2.GetComponent

	typeof = iter_2_0
	ContentSizeFitter = var_1_10007
	arg_2_0.contentSizeFitter = var_2_3(var_2_2, iter_2_0(var_1_10007))

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_2.GetComponent

	typeof = var_5
	CanvasGroup = var_1_10007
	arg_2_0.cg = var_2_5(var_2_4, var_5(var_1_10007))

	local var_2_6 = arg_2_0.panelContainer
	local var_2_7 = var_2.GetComponent

	typeof = var_5
	ScrollRect = var_1_10007
	arg_2_0.scrollrect = var_2_7(var_2_6, var_5(var_1_10007))

	arg_2_0:InitPanels()

	setActive = var_2

	var_2(arg_2_0._tf, true)

	return
end

function var_0_1.GetPanels(arg_3_0)
	local var_3_0 = {}

	IslandSettingsCardShowPanel = var_1_10002
	var_3_0[1] = var_1_10002
	IslandSettingsEscapePanel = var_1_10002
	var_3_0[2] = var_1_10002

	return var_3_0
end

function var_0_1.GetPanel(arg_4_0, arg_4_1)
	if not arg_4_0.panels then
		return nil
	end

	_ = var_2

	return var_2.detect(arg_4_0.panels, function(arg_5_0)
		isa = var_2_10001

		return var_2_10001(arg_5_0, arg_4_1)
	end)
end

function var_0_1.InitPanels(arg_6_0)
	local var_6_0 = {}

	GetOrAddComponent = var_1_10002

	local var_6_1 = arg_6_0.contentSizeFitter

	typeof = var_1_10005
	CanvasGroup = var_1_10007

	local var_6_2 = var_1_10002(var_6_1, var_1_10005(var_1_10007))
	local var_6_3 = arg_6_0.scrollrect

	var_6_3.enabled = false
	ipairs = var_6_3

	for iter_6_0, iter_6_1 in var_6_3(arg_6_0.panels) do
		table = var_1_10008

		var_1_10008.insert(var_6_0, function(arg_7_0)
			local var_7_0 = iter_6_1

			var_1.Init(var_7_0, arg_7_0)

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_6_0, function()
		arg_6_0.scrollrect.enabled = true

		local var_8_0 = arg_6_0

		var_0.Update(var_8_0)

		return
	end)

	return
end

function var_0_1.Show(arg_9_0)
	arg_9_0.cg.blocksRaycasts = true
	arg_9_0.cg.alpha = 1

	return
end

function var_0_1.Update(arg_10_0)
	ipairs = var_1_10001

	for iter_10_0, iter_10_1 in var_1_10001(arg_10_0.panels) do
		iter_10_1:OnUpdate()
	end

	return
end

function var_0_1.Hide(arg_11_0)
	arg_11_0.cg.blocksRaycasts = false
	arg_11_0.cg.alpha = 0

	return
end

function var_0_1.Save(arg_12_0)
	local var_12_0 = {}

	ipairs = var_1_10002

	for iter_12_0, iter_12_1 in var_1_10002(arg_12_0.panels) do
		local var_12_1 = iter_12_1:GetFlags()

		table = var_1_10008
		var_12_0 = var_1_10008.mergeArray(var_12_0, var_12_1)
	end

	local var_12_2 = arg_12_0
	local var_12_3 = arg_12_0.emit

	IslandMediator = iter_12_0

	var_12_3(var_12_2, iter_12_0.SET_SETTINGS_FLAG, var_12_0)

	return
end

function var_0_1.OnDestroy(arg_13_0)
	ipairs = var_1_10001

	for iter_13_0, iter_13_1 in var_1_10001(arg_13_0.panels) do
		iter_13_1:Dispose()
	end

	arg_13_0.panels = nil

	return
end

return var_0_1

class = var_0_10000

local var_0_0 = "Settings3DPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "SettingsCombinationPage"
end

function var_0_1.OnLoaded(arg_2_0)
	arg_2_0:OnBindEvent()

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

function var_0_1.OnBindEvent(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.bind

	SettingsOtherGraphicsPanle = var_1_10004

	var_3_1(var_3_0, var_1_10004.EVT_UPDTAE, function()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.GetPanel

		SettingsOtherGraphicsPanle = var_2_10003

		if var_4_1(var_4_0, var_2_10003) then
			var_0:RefreshPanelByGraphcLevel()

			local var_4_2 = arg_3_0

			var_1.RebuildLayout(var_4_2, function()
				return
			end)
		end

		return
	end)

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0.bind

	SettingsGraphicsPanle = var_4

	var_3_3(var_3_2, var_4.EVT_UPDTAE, function()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.GetPanel

		SettingsGraphicsPanle = var_2_10003

		if var_6_1(var_6_0, var_2_10003) then
			var_0:OnUpdate()
		end

		return
	end)

	return
end

function var_0_1.GetPanels(arg_7_0)
	local var_7_0 = {}

	SettingsGraphicsPanle = var_1_10002
	var_7_0[1] = var_1_10002
	SettingsOtherGraphicsPanle = var_1_10002
	var_7_0[2] = var_1_10002

	if arg_7_0:NeedAdjustScreen() then
		table = var_2

		local var_7_1 = var_2.insert
		local var_7_2 = var_7_0
		local var_7_3 = 1

		SettingsAdjustScreenPanle = var_1_10006

		var_7_1(var_7_2, var_7_3, var_1_10006)
	end

	return var_7_0
end

function var_0_1.NeedAdjustScreen(arg_8_0)
	Screen = var_1_10001

	local var_8_0 = var_1_10001.width

	Screen = var_1_10002

	local var_8_1 = var_8_0 / var_1_10002.height - 0.001

	ADAPT_NOTICE = var_2

	return var_2 < var_8_1
end

function var_0_1.GetPanel(arg_9_0, arg_9_1)
	if not arg_9_0.panels then
		return nil
	end

	_ = var_2

	return var_2.detect(arg_9_0.panels, function(arg_10_0)
		isa = var_2_10001

		return var_2_10001(arg_10_0, arg_9_1)
	end)
end

function var_0_1.InitPanels(arg_11_0)
	local var_11_0 = {}

	GetOrAddComponent = var_1_10002

	local var_11_1 = arg_11_0.contentSizeFitter

	typeof = var_1_10005
	CanvasGroup = var_1_10007

	local var_11_2 = var_1_10002(var_11_1, var_1_10005(var_1_10007))
	local var_11_3 = arg_11_0.scrollrect

	var_11_3.enabled = false
	ipairs = var_11_3

	for iter_11_0, iter_11_1 in var_11_3(arg_11_0.panels) do
		table = var_1_10008

		var_1_10008.insert(var_11_0, function(arg_12_0)
			local var_12_0 = iter_11_1

			var_1.Init(var_12_0, arg_12_0)

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_11_0, function()
		arg_11_0.scrollrect.enabled = true

		local var_13_0 = arg_11_0

		var_0.OnInitPanle(var_13_0)

		return
	end)

	return
end

function var_0_1.RebuildLayout(arg_14_0, arg_14_1)
	onDelayTick = var_1_10002

	var_1_10002(function()
		arg_14_0.contentSizeFitter.enabled = false
		arg_14_0.contentSizeFitter.enabled = true

		arg_14_1()

		return
	end, 0.05)

	return
end

function var_0_1.OnInitPanle(arg_16_0)
	if arg_16_0.contextData.scroll then
		local var_16_0

		if arg_16_0.contextData.scroll == "world_settings" then
			local var_16_1 = arg_16_0
			local var_16_2 = arg_16_0.GetPanel

			SettingsWorldPanle = var_1_10005

			local var_16_3 = var_16_2(var_16_1, var_1_10005)
		else
			local var_16_4 = arg_16_0:GetPanel(arg_16_0.contextData.scroll)
		end

		if arg_16_0:GetPanel(arg_16_0.contextData.scroll) then
			arg_16_0:ScrollToPanel(var_1)
		end
	end

	return
end

function var_0_1.ScrollToPanel(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.panelContainer
	local var_17_1 = var_2.InverseTransformPoint(var_17_0, arg_17_1._tf.position)

	setAnchoredPosition = var_1_10003

	var_1_10003(arg_17_0.panelContainer, {
		y = -var_17_1.y
	})

	return
end

function var_0_1.OnDestroy(arg_18_0)
	ipairs = var_1_10001

	for iter_18_0, iter_18_1 in var_1_10001(arg_18_0.panels) do
		iter_18_1:Dispose()
	end

	arg_18_0.panels = nil

	return
end

function var_0_1.Show(arg_19_0)
	arg_19_0.cg.blocksRaycasts = true
	arg_19_0.cg.alpha = 1

	return
end

function var_0_1.Hide(arg_20_0)
	arg_20_0.cg.blocksRaycasts = false
	arg_20_0.cg.alpha = 0

	return
end

return var_0_1

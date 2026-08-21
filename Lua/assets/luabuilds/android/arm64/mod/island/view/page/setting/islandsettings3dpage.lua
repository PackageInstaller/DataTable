local var_0_0 = class("IslandSettings3DPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandSettingsCombinationPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0:OnBindEvent()

	arg_2_0.panelContainer = arg_2_0._tf:Find("content")
	arg_2_0.panels = {}

	for iter_2_0, iter_2_1 in ipairs((arg_2_0:GetPanels())) do
		table.insert(arg_2_0.panels, iter_2_1.New(arg_2_0.panelContainer))
	end

	arg_2_0.contentSizeFitter = arg_2_0.panelContainer:GetComponent(typeof(ContentSizeFitter))
	arg_2_0.cg = arg_2_0._tf:GetComponent(typeof(CanvasGroup))
	arg_2_0.scrollrect = arg_2_0.panelContainer:GetComponent(typeof(ScrollRect))

	arg_2_0:InitPanels()
	setActive(arg_2_0._tf, true)

	return
end

function var_0_0.OnBindEvent(arg_3_0)
	arg_3_0:bind(IslandSettingsOtherGraphicsPanle.EVT_UPDTAE, function()
		local var_4_0 = arg_3_0:GetPanel(IslandSettingsOtherGraphicsPanle)

		if var_4_0 then
			var_4_0:RefreshPanelByGraphcLevel()
			arg_3_0:RebuildLayout(function()
				return
			end)
		end

		return
	end)
	arg_3_0:bind(IslandSettingsGraphicsPanle.EVT_UPDTAE, function()
		local var_6_0 = arg_3_0:GetPanel(IslandSettingsGraphicsPanle)

		if var_6_0 then
			var_6_0:OnUpdate()
		end

		return
	end)

	return
end

function var_0_0.GetPanels(arg_7_0)
	if arg_7_0:NeedAdjustScreen() then
		table.insert({
			IslandSettingsGraphicsPanle,
			IslandSettingsOtherGraphicsPanle
		}, 1, IslandSettingsAdjustScreenPanle)
	end

	return {
		IslandSettingsGraphicsPanle,
		IslandSettingsOtherGraphicsPanle
	}
end

function var_0_0.NeedAdjustScreen(arg_8_0)
	return Screen.width / Screen.height - 0.001 > ADAPT_NOTICE
end

function var_0_0.GetPanel(arg_9_0, arg_9_1)
	if not arg_9_0.panels then
		return nil
	end

	return _.detect(arg_9_0.panels, function(arg_10_0)
		return isa(arg_10_0, arg_9_1)
	end)
end

function var_0_0.InitPanels(arg_11_0)
	local var_11_0 = GetOrAddComponent(arg_11_0.contentSizeFitter, typeof(CanvasGroup))

	arg_11_0.scrollrect.enabled = false

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.panels) do
		table.insert({}, function(arg_12_0)
			iter_11_1:Init(arg_12_0)

			return
		end)
	end

	seriesAsync({}, function()
		arg_11_0.scrollrect.enabled = true

		arg_11_0:OnInitPanle()

		return
	end)

	return
end

function var_0_0.RebuildLayout(arg_14_0, arg_14_1)
	onDelayTick(function()
		arg_14_0.contentSizeFitter.enabled = false
		arg_14_0.contentSizeFitter.enabled = true

		arg_14_1()

		return
	end, 0.05)

	return
end

function var_0_0.OnInitPanle(arg_16_0)
	if arg_16_0.contextData.scroll then
		local var_16_1 = arg_16_0.contextData.scroll == "world_settings" and arg_16_0:GetPanel(SettingsWorldPanle) or arg_16_0:GetPanel(arg_16_0.contextData.scroll)
		local var_16_2 = arg_16_0:GetPanel(arg_16_0.contextData.scroll)

		if var_16_2 then
			arg_16_0:ScrollToPanel(var_16_2)
		end
	end

	return
end

function var_0_0.ScrollToPanel(arg_17_0, arg_17_1)
	setAnchoredPosition(arg_17_0.panelContainer, {
		y = -arg_17_0.panelContainer:InverseTransformPoint(arg_17_1._tf.position).y
	})

	return
end

function var_0_0.OnDestroy(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.panels) do
		iter_18_1:Dispose()
	end

	arg_18_0.panels = nil

	return
end

function var_0_0.Show(arg_19_0)
	arg_19_0.cg.blocksRaycasts = true
	arg_19_0.cg.alpha = 1

	return
end

function var_0_0.Hide(arg_20_0)
	arg_20_0.cg.blocksRaycasts = false
	arg_20_0.cg.alpha = 0

	return
end

return var_0_0

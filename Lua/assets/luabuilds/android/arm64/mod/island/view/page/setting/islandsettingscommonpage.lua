local var_0_0 = class("IslandSettingsCommonPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandSettingsCommonPage"
end

function var_0_0.OnLoaded(arg_2_0)
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

function var_0_0.GetPanels(arg_3_0)
	return {
		IslandSettingsCardShowPanel,
		IslandSettingsEscapePanel
	}
end

function var_0_0.GetPanel(arg_4_0, arg_4_1)
	if not arg_4_0.panels then
		return nil
	end

	return _.detect(arg_4_0.panels, function(arg_5_0)
		return isa(arg_5_0, arg_4_1)
	end)
end

function var_0_0.InitPanels(arg_6_0)
	local var_6_0 = GetOrAddComponent(arg_6_0.contentSizeFitter, typeof(CanvasGroup))

	arg_6_0.scrollrect.enabled = false

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.panels) do
		table.insert({}, function(arg_7_0)
			iter_6_1:Init(arg_7_0)

			return
		end)
	end

	seriesAsync({}, function()
		arg_6_0.scrollrect.enabled = true

		arg_6_0:Update()

		return
	end)

	return
end

function var_0_0.Show(arg_9_0)
	arg_9_0.cg.blocksRaycasts = true
	arg_9_0.cg.alpha = 1

	return
end

function var_0_0.Update(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.panels) do
		iter_10_1:OnUpdate()
	end

	return
end

function var_0_0.Hide(arg_11_0)
	arg_11_0.cg.blocksRaycasts = false
	arg_11_0.cg.alpha = 0

	return
end

function var_0_0.Save(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.panels) do
		var_12_0 = table.mergeArray(var_12_0, (iter_12_1:GetFlags()))
	end

	arg_12_0:emit(IslandMediator.SET_SETTINGS_FLAG, var_12_0)

	return
end

function var_0_0.OnDestroy(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.panels) do
		iter_13_1:Dispose()
	end

	arg_13_0.panels = nil

	return
end

return var_0_0

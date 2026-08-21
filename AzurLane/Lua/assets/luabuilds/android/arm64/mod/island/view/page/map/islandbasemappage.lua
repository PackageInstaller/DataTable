local var_0_0 = class("IslandBaseMapPage", import("...base.IslandBasePage"))

var_0_0.HIDE_DESC = "IslandBaseMapPage:HIDE_DESC"
var_0_0.CLOSE = "IslandBaseMapPage:CLOSE"

function var_0_0.getUIName(arg_1_0)
	return "IslandMapUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.maps = {}
	arg_2_0.bg = arg_2_0._tf:Find("bg")

	arg_2_0:InitMaps()
	setText(arg_2_0._tf:Find("adapt/title/Text"), i18n("island_map_title"))

	return
end

function var_0_0.InitMaps(arg_3_0)
	eachChild(arg_3_0.bg, function(arg_4_0)
		if arg_4_0.name:sub(-1) ~= "$" then
			arg_3_0.maps[tonumber(arg_4_0.name)] = arg_4_0
		end

		return
	end)

	return
end

function var_0_0.OnInit(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.maps) do
		onButton(arg_5_0, iter_5_1, function()
			if not arg_5_0:CheckUnlock(iter_5_0) then
				return
			end

			arg_5_0:ShowDesc(iter_5_0)

			return
		end, SFX_PANEL)
	end

	onButton(arg_5_0, arg_5_0._tf:Find("bg"), function()
		if arg_5_0.selectedId then
			arg_5_0:HideSelected()
		end

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0._tf:Find("adapt/back"), function()
		arg_5_0:ClosePage(arg_5_0.class)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0._tf:Find("adapt/home"), function()
		arg_5_0:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)
	arg_5_0:bind(var_0_0.HIDE_DESC, function()
		arg_5_0:HideSelected()

		return
	end)
	arg_5_0:bind(var_0_0.CLOSE, function()
		arg_5_0:ClosePage(arg_5_0.class)

		return
	end)

	return
end

function var_0_0.OnShow(arg_12_0)
	arg_12_0:Flush()

	return
end

function var_0_0.Flush(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.maps) do
		setActive(iter_13_1:Find("selcted"), false)

		local var_13_0 = arg_13_0:CheckUnlock(iter_13_0)

		setActive(iter_13_1:Find("lock"), not var_13_0)
		setActive(iter_13_1:Find("full"), false)
		setActive(iter_13_1:Find("finish"), false)
		setActive(iter_13_1:Find("fetch"), false)
		setActive(iter_13_1:Find("icon"), var_13_0)
	end

	return
end

function var_0_0.CheckUnlock(arg_14_0, arg_14_1)
	return (arg_14_0:GetIsland():GetAblityAgency():IsUnlockMap(arg_14_1))
end

function var_0_0.ShowDesc(arg_15_0, arg_15_1)
	if arg_15_0.selectedId then
		arg_15_0:HideSelected(arg_15_0.selectedId)
	end

	setActive(arg_15_0.maps[arg_15_1]:Find("selcted"), true)
	arg_15_0:GoDesc(arg_15_1)

	arg_15_0.selectedId = arg_15_1

	return
end

function var_0_0.HideSelected(arg_16_0)
	if arg_16_0.maps[arg_16_0.selectedId] == nil then
		return
	end

	local var_16_0 = arg_16_0.maps[arg_16_0.selectedId]:Find("selcted")

	dftAniEvent = var_16_0:GetComponent(typeof(DftAniEvent))

	dftAniEvent:SetEndEvent(function()
		dftAniEvent:SetEndEvent(nil)
		setActive(var_16_0, false)

		return
	end)
	var_16_0:GetComponent(typeof(Animation)):Play("IslandMapUI_selectedout")

	arg_16_0.selectedId = nil

	return
end

function var_0_0.GoDesc(arg_18_0, arg_18_1)
	arg_18_0:OpenPage(IslandBaseMapDescPage, arg_18_1)

	return
end

return var_0_0

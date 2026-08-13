class = var_0_10000

local var_0_0 = "AttireIconFramePanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".AttireFramePanel"))

setmetatable = var_0_10001

local function var_0_2(arg_1_0)
	local var_1_0 = {}

	AttireFramePanel = var_1_10002

	local var_1_1 = var_1_10002.Card(arg_1_0)

	local function var_1_2(arg_2_0)
		return
	end

	local function var_1_3(arg_3_0, arg_3_1, arg_3_2)
		return
	end

	function var_1_0.Update(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		local var_4_0 = var_1_1

		var_4.Update(var_4_0, arg_4_1, arg_4_2, arg_4_3)

		local var_4_1 = arg_4_0
		local var_4_2 = arg_4_0.ReturnIconFrame

		AttireConst = var_7

		var_4_2(var_4_1, var_7.TYPE_ICON_FRAME)

		if arg_4_0:isEmpty() then
			return
		end

		arg_4_0:LoadPrefab(arg_4_1, function(arg_5_0)
			var_1_3(arg_4_0, arg_5_0, arg_4_1)

			return
		end)

		return
	end

	function var_1_0.Dispose(arg_6_0)
		local var_6_0 = arg_6_0
		local var_6_1 = arg_6_0.ReturnIconFrame

		AttireConst = var_2_10004

		var_6_1(var_6_0, var_2_10004.TYPE_ICON_FRAME)

		return
	end

	var_1_2(var_1_0)

	return var_0_10001(var_1_0, {
		__index = var_1_1
	})
end

function var_0_1.getUIName(arg_7_0)
	return "AttireIconFrameUI"
end

function var_0_1.GetData(arg_8_0)
	return arg_8_0.rawAttireVOs.iconFrames
end

function var_0_1.OnInitItem(arg_9_0, arg_9_1)
	local var_9_0 = var_0_2(arg_9_1)
	local var_9_1 = arg_9_0.cards

	var_9_1[arg_9_1] = var_9_0
	onButton = var_9_1

	local var_9_2 = arg_9_0
	local var_9_3 = var_9_0._go

	local function var_9_4()
		local var_10_0 = var_9_0

		if not var_0.isEmpty(var_10_0) then
			if arg_9_0.card then
				local var_10_1 = arg_9_0.card

				var_0.UpdateSelected(var_10_1, false)
			end

			arg_9_0.contextData.iconFrameId = var_9_0.attireFrame.id

			local var_10_2 = arg_9_0

			var_0.UpdateDesc(var_10_2, var_9_0)

			local var_10_3 = var_9_0

			var_0.UpdateSelected(var_10_3, true)

			arg_9_0.card = var_9_0
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_9_1(var_9_2, var_9_3, var_9_4, var_1_10008)

	return
end

function var_0_1.GetColumn(arg_11_0)
	return 2
end

function var_0_1.OnUpdateItem(arg_12_0, arg_12_1, arg_12_2)
	var_0_1.super.OnUpdateItem(arg_12_0, arg_12_1, arg_12_2)

	local var_12_0

	if not arg_12_0.contextData.iconFrameId then
		var_12_0 = arg_12_0.displayVOs[1].id
	end

	if arg_12_0.cards[arg_12_2].attireFrame.id == var_12_0 then
		triggerButton = var_5

		var_5(var_4._go)
		var_4:UpdateSelected(true)
	end

	return
end

return var_0_1

local var_0_0 = class("SummaryPage2", import(".SummaryAnimationPage"))

function var_0_0.OnInit(arg_1_0)
	setText(findTF(arg_1_0._go, "name/Text"), arg_1_0.summaryInfoVO.firstProposeName)

	local var_1_0 = findTF(arg_1_0._go, "texts")

	arg_1_0.textTFs = {}

	for iter_1_0 = 1, var_1_0.childCount do
		local var_1_1 = var_1_0:GetChild(iter_1_0 - 1)
		local var_1_2 = go(var_1_1).name

		if var_1_2 ~= "label" then
			setText(var_1_1:Find("Text"), arg_1_0.summaryInfoVO[var_1_2])
		end

		table.insert(arg_1_0.textTFs, var_1_1)
	end

	setText(findTF(arg_1_0._go, "name/date"), arg_1_0.summaryInfoVO.firstLadyTime)
	setPaintingPrefabAsync(findTF(arg_1_0._go, "painting"):Find("mask/painting"), Ship.New({
		configId = arg_1_0.summaryInfoVO.firstLadyId
	}):getPainting(), "chuanwu")
	setActive(arg_1_0._go, false)

	return
end

function var_0_0.Clear(arg_2_0)
	return
end

return var_0_0

class = var_0_10000

local var_0_0 = "BackYardFormationCard"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.ship.FormationCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0.detailTF

	arg_1_0.propsTr1 = var_2.Find(var_1_0, "info1")

	local var_1_1 = arg_1_0.detailTF

	arg_1_0.nameTr = var_2.Find(var_1_1, "name_mask")

	local var_1_2 = arg_1_0.content

	arg_1_0.startTr = var_2.Find(var_1_2, "front/stars")

	return
end

function var_0_1.updateProps(arg_2_0, arg_2_1)
	for iter_2_0 = 0, 4 do
		local var_2_0 = arg_2_0.propsTr
		local var_2_1 = var_6.GetChild(var_2_0, iter_2_0)

		if iter_2_0 < #arg_2_1 then
			local var_2_2 = var_2_1.gameObject

			var_7.SetActive(var_2_2, true)

			local var_2_3 = var_2_1:GetChild(0)

			var_7.GetComponent(var_2_3, "Text").text = arg_2_1[iter_2_0 + 1][1]

			local var_2_4 = var_2_1:GetChild(1)

			var_7.GetComponent(var_2_4, "Text").text = arg_2_1[iter_2_0 + 1][2]
		else
			local var_2_5 = var_2_1.gameObject

			var_7.SetActive(var_2_5, false)
		end
	end

	setAnchoredPosition = var_2

	var_2(arg_2_0.nameTr, {
		y = 270
	})

	setAnchoredPosition = var_2

	var_2(arg_2_0.shipState, {
		y = 32
	})

	setAnchoredPosition = var_2

	var_2(arg_2_0.startTr, {
		y = -14
	})

	setAnchoredPosition = var_2

	var_2(arg_2_0.proposeMark, {
		y = 3.2
	})

	return
end

function var_0_1.updateProps1(arg_3_0, arg_3_1)
	for iter_3_0 = 0, 2 do
		local var_3_0 = arg_3_0.propsTr1
		local var_3_1 = var_6.GetChild(var_3_0, iter_3_0)

		if iter_3_0 < #arg_3_1 then
			local var_3_2 = var_3_1.gameObject

			var_7.SetActive(var_3_2, true)

			local var_3_3 = var_3_1:GetChild(0)

			var_7.GetComponent(var_3_3, "Text").text = arg_3_1[iter_3_0 + 1][1]

			local var_3_4 = var_3_1:GetChild(1)

			var_7.GetComponent(var_3_4, "Text").text = arg_3_1[iter_3_0 + 1][2]
		else
			local var_3_5 = var_3_1.gameObject

			var_7.SetActive(var_3_5, false)
		end
	end

	setAnchoredPosition = var_2

	var_2(arg_3_0.nameTr, {
		y = 174
	})

	setAnchoredPosition = var_2

	var_2(arg_3_0.shipState, {
		y = -64
	})

	setAnchoredPosition = var_2

	var_2(arg_3_0.startTr, {
		y = -110
	})

	setAnchoredPosition = var_2

	var_2(arg_3_0.proposeMark, {
		y = -92.8
	})

	return
end

return var_0_1

local var_0_0 = class("MatrixRotationDiagram2D", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.particle = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.itemSize = Vector2.New(650, 700)
	arg_3_0.itemOffset = 350
	arg_3_0.itemCount = 6

	arg_3_0:CalulateDataStatic()
	arg_3_0:CreatItem()
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0:Change(arg_4_1, true)
end

function var_0_0.CreatItem(arg_5_0)
	arg_5_0.itemList = {}

	for iter_5_0 = 1, arg_5_0.itemCount do
		local var_5_0 = MatrixRotationDiagramItem.New(arg_5_0.m_ratationItem, arg_5_0.m_ratationContent)

		var_5_0:SetData(iter_5_0)
		table.insert(arg_5_0.itemList, var_5_0)
	end
end

function var_0_0.Change(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = #arg_6_0.itemList

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.itemList) do
		local var_6_1 = (iter_6_1:GetIndex() - arg_6_1 + var_6_0) % var_6_0 + 1

		iter_6_1:SetPosId(var_6_1)
	end

	table.sort(arg_6_0.itemList, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0:GetPosId()
		local var_7_1 = arg_7_1:GetPosId()

		return arg_6_0.itemPosList[var_7_0].order < arg_6_0.itemPosList[var_7_1].order
	end)

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.itemList) do
		local var_6_2 = iter_6_3:GetPosId()
		local var_6_3 = arg_6_0.itemPosList[var_6_2]

		if arg_6_2 then
			SetActive(arg_6_0.particle, true)
			iter_6_3:InitPosData(var_6_3)
		else
			SetActive(arg_6_0.particle, false)
			TimeTools.StartAfterSeconds(0.5, function()
				if arg_6_0.particle then
					SetActive(arg_6_0.particle, true)
				end
			end, {})
			iter_6_3:SetPosData(var_6_3)
		end
	end
end

function var_0_0.Dispose(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.itemList) do
		iter_9_1:Dispose()
	end

	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.CalulateDataStatic(arg_10_0)
	arg_10_0.itemPosList = {
		{
			scale = 1,
			order = 6,
			pos = Vector3.New(0, -100, 0),
			color = Color.New(1, 1, 1)
		},
		{
			scale = 0.7,
			order = 5,
			pos = Vector3.New(500, -30, 0),
			color = Color.New(0.3325, 0.3613, 0.4433)
		},
		{
			scale = 0.53,
			order = 3,
			pos = Vector3.New(325, 40, 0),
			color = Color.New(0.2448, 0.2448, 0.3962)
		},
		{
			scale = 0.375,
			order = 1,
			pos = Vector3.New(0, 100, 0),
			color = Color.New(0.2314, 0.2314, 0.3207)
		},
		{
			scale = 0.53,
			order = 2,
			pos = Vector3.New(-325, 40, 0),
			color = Color.New(0.2448, 0.2448, 0.3962)
		},
		{
			scale = 0.7,
			order = 4,
			pos = Vector3.New(-500, -30, 0),
			color = Color.New(0.3325, 0.3613, 0.4433)
		}
	}
end

return var_0_0

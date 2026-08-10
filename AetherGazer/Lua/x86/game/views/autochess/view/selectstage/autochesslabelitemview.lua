local var_0_0 = class("AutoChessLabelItemView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.labelItemList_ = {}

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.RefreshLabelData(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0, var_3_1 = arg_3_0:GetAllLabel(arg_3_2)
	local var_3_2 = arg_3_0.labelGo_.transform.rect.width
	local var_3_3 = #var_3_0 / 3
	local var_3_4 = 0
	local var_3_5 = 0

	for iter_3_0 = 1, var_3_3 + 1 do
		for iter_3_1 = 1, 3 do
			var_3_4 = var_3_4 + 1

			if arg_3_0.labelItemList_[iter_3_1] == nil then
				arg_3_0.labelItemList_[iter_3_1] = {}
			end

			if arg_3_0.labelItemList_[iter_3_1][iter_3_0] == nil then
				local var_3_6 = var_3_0[var_3_4]

				if var_3_6 then
					local var_3_7 = Object.Instantiate(arg_3_0.labelGo_, arg_3_0.transform_)
					local var_3_8 = 0
					local var_3_9 = arg_3_0.labelItemList_[iter_3_1]

					if var_3_9[iter_3_0 - 1] then
						local var_3_10 = var_3_9[iter_3_0 - 1]
						local var_3_11

						if iter_3_1 > 1 then
							var_3_11 = arg_3_0.labelItemList_[iter_3_1 - 1][iter_3_0]:GetLocalPosX()
						end

						var_3_8 = arg_3_0:RandomPos(var_3_10:GetLocalPosX(), var_3_11, var_3_2)
					else
						local var_3_12

						if iter_3_1 > 1 then
							var_3_12 = arg_3_0.labelItemList_[iter_3_1 - 1][iter_3_0]:GetLocalPosX()
						end

						var_3_8 = arg_3_0:RandomPos(nil, var_3_12, var_3_2)
					end

					var_3_7.transform.localPosition = Vector3.New(var_3_8, var_3_7.transform.localPosition.y + (iter_3_1 - 1) * 80, var_3_7.transform.localPosition.z)

					local var_3_13 = AutoChessSubLabelView.New(var_3_7)

					var_3_13:SetData(var_3_6, var_3_1[var_3_4], arg_3_1, arg_3_0.transform_.rect.width)

					arg_3_0.labelItemList_[iter_3_1][iter_3_0] = var_3_13

					if var_3_5 < var_3_8 then
						var_3_5 = var_3_8
					end
				end
			else
				local var_3_14 = var_3_0[var_3_4]

				if var_3_14 then
					arg_3_0.labelItemList_[iter_3_1][iter_3_0]:SetData(var_3_14, var_3_1[var_3_4], arg_3_1, arg_3_0.transform_.rect.width)
				else
					arg_3_0.labelItemList_[iter_3_1][iter_3_0]:SetActive(false)
				end
			end
		end
	end

	local var_3_15 = math.max(var_3_5 - (arg_3_0.transform_.rect.width / 2 + var_3_2 / 2), arg_3_0.transform_.rect.width + var_3_2 / 2)

	for iter_3_2, iter_3_3 in pairs(arg_3_0.labelItemList_) do
		for iter_3_4, iter_3_5 in pairs(iter_3_3) do
			iter_3_5:SetMaxWidth(var_3_15)
		end
	end
end

function var_0_0.GetAllLabel(arg_4_0, arg_4_1)
	local var_4_0 = AutoChessTools.GetTeamTag(arg_4_1)
	local var_4_1 = 1
	local var_4_2 = {}
	local var_4_3 = {}

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		if iter_4_1 > 1 then
			table.insert(var_4_2, iter_4_1)
			table.insert(var_4_3, iter_4_0)
		end
	end

	return var_4_3, var_4_2
end

function var_0_0.RandomPos(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_0.transform_.rect.width / 2
	local var_5_1 = 0
	local var_5_2 = arg_5_2
	local var_5_3 = arg_5_2

	if arg_5_2 then
		var_5_2 = arg_5_2 - arg_5_3 / 4
		var_5_3 = arg_5_2 + arg_5_3 / 4
	end

	if arg_5_1 then
		var_5_1 = arg_5_1 + arg_5_3
	else
		var_5_1 = var_5_0 + arg_5_3 / 2
	end

	if arg_5_2 then
		local var_5_4 = var_5_1 + arg_5_3 / 4

		if var_5_3 < var_5_4 then
			return math.random(var_5_4, var_5_4 + 300)
		elseif var_5_2 < var_5_4 then
			return math.random(var_5_3, var_5_3 + 300)
		elseif math.random(1, 2) == 1 then
			return math.random(var_5_4, var_5_2)
		else
			return math.random(var_5_3, var_5_3 + 300)
		end
	else
		return math.random(var_5_1 + arg_5_3 / 4, var_5_1 + 300)
	end
end

function var_0_0.OnExit(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.labelItemList_) do
		for iter_6_2, iter_6_3 in pairs(iter_6_1) do
			iter_6_3:OnExit()
		end
	end
end

function var_0_0.Dispose(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.labelItemList_) do
		for iter_7_2, iter_7_3 in pairs(iter_7_1) do
			iter_7_3:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0

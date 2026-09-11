local var_0_0 = singletonClass("EatSnakeData")
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	var_0_1.stageList = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	var_0_1:InitData(arg_2_1)
end

function var_0_0.UpdateStageData(arg_3_0, arg_3_1)
	var_0_1:UpdateStageData(arg_3_1)
end

function var_0_0.GetDataByPara(arg_4_0, arg_4_1)
	return var_0_1[arg_4_1]
end

function var_0_1:InitData(arg_5_1)
	self.activityID = arg_5_1.activity_id
	self.stageList = {}
	self.enterContentPos_ = Vector2(0, 0)

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.stage_list) do
		table.insert(self.stageList, {
			stageID = iter_5_1.stage_id,
			target = iter_5_1.target
		})
	end
end

function var_0_1:UpdateStageData(arg_6_1)
	local var_6_0 = true

	for iter_6_0, iter_6_1 in ipairs(self.stageList) do
		if arg_6_1.stage_id == iter_6_1.stageID then
			var_6_0 = false
			iter_6_1.target = arg_6_1.star

			break
		end
	end

	if var_6_0 then
		table.insert(self.stageList, {
			stageID = arg_6_1.stage_id,
			target = arg_6_1.star
		})
	end

	if #self.stageList < #ActivityEatSnakeCfg.all then
		manager.redPoint:setTip(RedPointConst.EAT_SNAKE_STAGE .. "_" .. #self.stageList + 1, 1)
	end
end

function var_0_0:GetSelectId()
	return self.selectId_
end

function var_0_0.SetSelecId(arg_8_0, arg_8_1)
	arg_8_0.selectId_ = arg_8_1
end

function var_0_0.SetEnterPos(arg_9_0, arg_9_1)
	arg_9_0.enterContentPos_ = arg_9_1
end

function var_0_0:GetEnterPos()
	self.enterContentPos_ = Vector2(0, 0)

	return self.enterContentPos_
end

return var_0_0

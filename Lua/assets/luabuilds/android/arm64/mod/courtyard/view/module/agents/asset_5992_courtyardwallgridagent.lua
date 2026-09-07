local CourtYardWallGridAgent = class("CourtYardWallGridAgent", import(".CourtYardGridAgent"))

function CourtYardWallGridAgent:Reset(arg_1_1)
	table.clear(self.grids)

	for iter_1_0 = 1, #arg_1_1 do
		if iter_1_0 % 2 == 0 then
			local var_1_0 = self:GetPool():Dequeue()

			var_1_0.transform:SetParent(self.gridsTF)

			var_1_0.transform.localScale = Vector3.one

			table.insert(self.grids, var_1_0)
			self:UpdatePositionAndColor(var_1_0, {
				arg_1_1[iter_1_0 - 1],
				arg_1_1[iter_1_0]
			})
		end
	end

	return
end

function CourtYardWallGridAgent:Flush(arg_2_1)
	for iter_2_0 = 1, #arg_2_1 do
		if iter_2_0 % 2 == 0 then
			assert(self.grids[iter_2_0 * 0.5])
			self:UpdatePositionAndColor(self.grids[iter_2_0 * 0.5], {
				arg_2_1[iter_2_0 - 1],
				arg_2_1[iter_2_0]
			})
		end
	end

	return
end

function CourtYardWallGridAgent:UpdatePositionAndColor(arg_3_1, arg_3_2)
	table.sort(arg_3_2, function(arg_4_0, arg_4_1)
		return arg_4_0.position.x + arg_4_0.position.y < arg_4_1.position.x + arg_4_1.position.y
	end)

	local var_3_0 = arg_3_2[1]

	arg_3_1.transform.localPosition = CourtYardCalcUtil.Map2Local(arg_3_2[1].position)
	arg_3_1:GetComponent(typeof(Image)).color = self:GetColor(_.all(arg_3_2, function(arg_5_0)
		return arg_5_0.flag == 1
	end) and 1 or 2)
	arg_3_1.transform.localScale = var_3_0.position.y - var_3_0.position.x >= 1 and Vector3(-1, 1, 1) or Vector3(1, 1, 1)

	return
end

function CourtYardWallGridAgent:GetPool()
	return self:GetView().poolMgr:GetWallGridPool()
end

return CourtYardWallGridAgent

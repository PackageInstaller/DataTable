local BaseRankIndexComp = class("BaseRankIndexComp", require("app.fairyGUI.base_new.UI_BaseRankIndexComp"))

function BaseRankIndexComp:updateRankIndex(arg_1_1)
	local var_1_0

	if arg_1_1 then
		var_1_0 = arg_1_1.rank or 0

		if var_1_0 < 0 then
			return
		end

		if var_1_0 == 0 then
			self:setCtrlState("rank", {
				index = 0
			})
			self:setTitle(g.core.lang:get(1156))
		elseif var_1_0 < 4 then
			self:setCtrlState("rank", {
				index = var_1_0
			})
		end
	end

	self:setCtrlState("rank", {
		index = 0
	})
	self:setTitle(var_1_0)
end

function BaseRankIndexComp:updateRangeRankIndex(arg_2_1)
	self:setCtrlState("rank", {
		index = 0
	})

	if arg_2_1.max ~= arg_2_1.min then
		self:setTitle(table.concat({
			arg_2_1.min,
			arg_2_1.max
		}, "-"))
	elseif arg_2_1.max < 4 then
		self:setCtrlState("rank", {
			index = arg_2_1.max
		})
	else
		self:setTitle(arg_2_1.max)
	end
end

return BaseRankIndexComp

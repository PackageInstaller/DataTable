local CastStep = class("CastStep", import(".StoryStep"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4

function CastStep:Ctor(arg_1_1)
	CastStep.super.Ctor(self, arg_1_1)

	self.layout = arg_1_1.layout
	self.time = arg_1_1.time or 5
	self.spacing = arg_1_1.spacing or 35

	return
end

function CastStep:GetMode()
	return Story.MODE_CAST
end

function CastStep:DataToLayout(arg_3_1)
	if arg_3_1[1] == var_0_1 then
		return {
			type = var_0_1,
			text = arg_3_1[2]
		}
	elseif arg_3_1[1] == var_0_2 then
		local var_3_1 = arg_3_1[4]
		local var_3_2

		if not arg_3_1[4] then
			var_3_1 = 0
			var_3_2 = {
				type = var_0_2,
				path = arg_3_1[2]
			}
		end

		var_3_2.size = Vector2(arg_3_1[3] or 0, var_3_1)

		return var_3_2
	elseif arg_3_1[1] == var_0_3 then
		local var_3_3 = {}
		local var_3_4 = self:ShouldReplacePlayer()

		for iter_3_0 = 1, #arg_3_1[2] do
			local var_3_5 = arg_3_1[2][iter_3_0]

			if var_3_4 then
				var_3_5 = self:ReplacePlayerName(var_3_5)
			end

			if self:ShouldReplaceCar2026() then
				var_3_5 = self:ReplaceCar2026Name(var_3_5)
			end

			table.insert(var_3_3, (HXSet.hxLan(var_3_5)))
		end

		local var_3_7 = {
			type = var_0_3,
			names = var_3_3
		}

		var_3_7.column = arg_3_1[3] or 2
		var_3_7.evenColumnColor = arg_3_1[4] or "#c2c2c2"

		return var_3_7
	elseif arg_3_1[1] == var_0_4 then
		return {
			type = var_0_4
		}
	end

	return
end

function CastStep:GetLayout()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(self.layout or {}) do
		table.insert(var_4_0, (self:DataToLayout(iter_4_1)))
	end

	return var_4_0
end

function CastStep:GetSpacing()
	return self.spacing
end

function CastStep:GetPlayTime()
	return self.time
end

return CastStep

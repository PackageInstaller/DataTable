local PuzzleData = class("PuzzleData")

function PuzzleData:ctor()
	self:initData()
end

function PuzzleData:initData()
	self._levelCfgs = {}

	self:initAllCfgs()
end

function PuzzleData:initAllCfgs()
	for iter_3_0 = 1, g.core.config.game_level_info.getLength() do
		local var_3_0 = g.core.config.game_level_info.indexOf(iter_3_0)

		self:_initLevelCfg(var_3_0.id, var_3_0)
	end
end

function PuzzleData:_translateValue(arg_4_1, arg_4_2)
	if type(arg_4_1) == "number" then
		if arg_4_1 == -9527 then
			return nil
		end

		if arg_4_2 then
			return arg_4_1 == 1
		end
	elseif type(arg_4_1) == "string" then
		if arg_4_1 == "nil" then
			return nil
		end

		local var_4_0 = string.find(arg_4_1, "(luanumber)")

		if var_4_0 then
			arg_4_1 = tonumber(string.sub(arg_4_1, 1, var_4_0 - 2))
		end
	end

	return arg_4_1
end

function PuzzleData:_getCfgsByStringData(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = {}

	if #arg_5_1 < 1 then
		return var_5_0
	end

	local var_5_1, var_5_2

	if #arg_5_2 < 1 then
		do return arg_5_1 end

		var_5_1 = table.remove(arg_5_2, 1)
		var_5_2 = table.remove(arg_5_3, 1)
	end

	for iter_5_0, iter_5_1 in ipairs((arg_5_1:split(","))) do
		iter_5_1 = tonumber(iter_5_1)

		if not var_5_1.fetch(iter_5_1) then
			return arg_5_1
		end

		local var_5_3 = var_5_1.get(iter_5_1)
		local var_5_4 = {}

		for iter_5_2, iter_5_3 in ipairs(var_5_2) do
			local var_5_5 = iter_5_3
			local var_5_6 = iter_5_3:find("b|")

			if var_5_6 then
				var_5_5 = string.sub(iter_5_3, var_5_6 + 2)
			end

			local var_5_7 = self:_translateValue(var_5_3[var_5_5], var_5_6)

			if type(var_5_7) == "string" and var_5_5 ~= "content" and #string.split(var_5_7, ",") > 0 then
				var_5_7 = self:_getCfgsByStringData(var_5_7, clone(arg_5_2), clone(arg_5_3))
			end

			var_5_4[var_5_5] = var_5_7
		end

		var_5_0[iter_5_0] = var_5_4
	end

	return var_5_0
end

function PuzzleData:_initLevelCfg(arg_6_1, arg_6_2)
	self._levelCfgs[arg_6_1] = {
		elems = {},
		dests = {},
		bgFileName = self:_translateValue(arg_6_2.bgFileName),
		screenState = self:_translateValue(arg_6_2.screenState),
		moveTime = self:_translateValue(arg_6_2.moveTime),
		stayTime = self:_translateValue(arg_6_2.stayTime),
		gapTime = self:_translateValue(arg_6_2.gapTime),
		guidTime = self:_translateValue(arg_6_2.guidTime),
		judgeType = self:_translateValue(arg_6_2.judgeType),
		elems = self:_getCfgsByStringData(arg_6_2.elems, {
			g.core.config.game_object_info
		}, {
			{
				"zOrder",
				"uniqueName",
				"orgPosY",
				"orgPosX",
				"elemType",
				"resId",
				"width",
				"rota",
				"height",
				"content",
				"fontStyle",
				"fontSize",
				"guid",
				"b|reverse",
				"b|canClick",
				"distance",
				"relate",
				"resFace",
				"arrowState",
				"relatedName",
				"distanceY",
				"subAngle",
				"scaley"
			}
		}),
		dests = self:_getCfgsByStringData(arg_6_2.dests, {
			g.core.config.game_condition_info,
			g.core.config.game_change_info
		}, {
			{
				"destType",
				"fromName",
				"toName",
				"changes"
			},
			{
				"changeType",
				"watchName",
				"b|reverse",
				"width",
				"height",
				"orgPosY",
				"orgPosX",
				"waitName"
			}
		})
	}
end

function PuzzleData:getLevelData(arg_7_1)
	return self._levelCfgs[arg_7_1]
end

return PuzzleData

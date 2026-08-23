local KnightTable = class("KnightTable")
local KnightStruct = import(".KnightStruct")
local var_0_2 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_3 = g.core.config.knight_info
local var_0_4 = g.core.const.ConstMgr.QUALITY_TYPE

function KnightTable:ctor()
	self._knights = {}
	self._knightsIndex = {}
	self._professionKnights = {}
	self._curKnights = {}
	self._knightsIdIndex = {}
	self._knightCount = 0
	self._formation = {}

	for iter_1_0 = 1, var_0_2.LINEUP_MAX do
		self._formation[iter_1_0] = 0
	end

	self._lineUpAndHelpKnights = {}
	self._positions = {}
	self._mainId = 0
	self._newUnlockAss = {}

	self:initCfg()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CHANGE_KNIGHT, self._changeKnight, self)
end

function KnightTable:getCurList()
	return self._curKnights
end

function KnightTable:getList()
	return self._knights
end

function KnightTable:getAllKnightCount()
	return self._knightCount - 1
end

function KnightTable:getFormation()
	return self._formation
end

function KnightTable:hasLineUpSSR()
	for iter_6_0, iter_6_1 in pairs(self._formation) do
		if iter_6_1 > 0 then
			if self:getKnight({
				id = iter_6_1
			}):getQuality() >= var_0_4.SSR then
				return true
			end
		end
	end

	return false
end

function KnightTable:getFormationKnights()
	return self._lineUpAndHelpKnights
end

function KnightTable:getMainKnight()
	return self._knightsIdIndex[self._mainId]
end

function KnightTable:getFormationKnightsCount()
	for iter_9_0 = 1, #self._lineUpAndHelpKnights do
		if self._lineUpAndHelpKnights[iter_9_0] == 0 then
			return iter_9_0 - 1
		end
	end

	return #self._lineUpAndHelpKnights
end

function KnightTable:getLineupKnightCount()
	for iter_10_0 = 1, var_0_2.LINEUP_MAX do
		if self._lineUpAndHelpKnights[iter_10_0] == 0 then
			return iter_10_0 - 1
		end
	end

	return var_0_2.LINEUP_MAX
end

function KnightTable:getPositions()
	return self._positions
end

function KnightTable:getSpList(arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(self._knights) do
		if arg_12_1(iter_12_1) then
			var_12_0[#var_12_0 + 1] = iter_12_1
		end
	end

	if not arg_12_3 then
		self:sortList(var_12_0, arg_12_2)
	end

	return var_12_0
end

function KnightTable:getLineupSpList(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(self._knights) do
		if arg_13_1(iter_13_1) then
			var_13_0[#var_13_0 + 1] = iter_13_1
		end
	end

	self:sortLineupList(var_13_0, arg_13_2, arg_13_3)

	return var_13_0
end

function KnightTable:getProfessionSpList(arg_14_1)
	return self._professionKnights[arg_14_1] or {}
end

function KnightTable:getKnight(arg_15_1)
	if arg_15_1.id then
		return self._knightsIdIndex[arg_15_1.id]
	elseif arg_15_1.base_id then
		return self._knightsIndex[var_0_3.get(arg_15_1.base_id).advance_id]
	elseif arg_15_1.advance_id then
		return self._knightsIndex[arg_15_1.advance_id]
	elseif arg_15_1.pos then
		if self._lineUpAndHelpKnights[arg_15_1.pos] then
			return self._knightsIdIndex[self._lineUpAndHelpKnights[arg_15_1.pos]]
		end
	end
end

function KnightTable:sortList(arg_16_1, arg_16_2)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		iter_16_1:calcSortList(arg_16_2)
	end

	table.sort(arg_16_1, function(arg_17_0, arg_17_1)
		local var_17_0 = arg_17_0:getSortList()
		local var_17_1 = arg_17_1:getSortList()

		for iter_17_0 = 1, #var_17_0 do
			if var_17_0[iter_17_0] ~= var_17_1[iter_17_0] then
				return var_17_0[iter_17_0] > var_17_1[iter_17_0]
			end
		end

		return false
	end)
end

function KnightTable:sortLineupList(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = self:getKnight({
		advance_id = arg_18_2
	})
	local var_18_1 = 0

	if var_18_0 then
		var_18_1 = var_18_0:getInfo().position
	elseif arg_18_3 then
		var_18_1 = arg_18_3
	else
		for iter_18_0, iter_18_1 in pairs(self._lineUpAndHelpKnights) do
			if iter_18_1 == 0 then
				var_18_1 = iter_18_0

				break
			end
		end
	end

	for iter_18_2, iter_18_3 in ipairs(arg_18_1) do
		iter_18_3:calcLineupSortList(arg_18_2, var_18_1)
	end

	table.sort(arg_18_1, function(arg_19_0, arg_19_1)
		local var_19_0 = arg_19_0:getSortList()
		local var_19_1 = arg_19_1:getSortList()

		for iter_19_0 = 1, #var_19_0 do
			if var_19_0[iter_19_0] ~= var_19_1[iter_19_0] then
				return var_19_0[iter_19_0] > var_19_1[iter_19_0]
			end
		end

		return false
	end)
end

function KnightTable:initCfg()
	for iter_20_0 = 1, var_0_3.getLength() do
		local var_20_0 = var_0_3.indexOf(iter_20_0)

		if var_20_0.type ~= 3 then
			if self._knightsIndex[var_20_0.advance_id] then
				self._knightsIndex[var_20_0.advance_id]:addCfgInfo(var_20_0)
			else
				local var_20_1 = KnightStruct.new(var_20_0.advance_id)

				var_20_1:addCfgInfo(var_20_0)

				self._knightsIndex[var_20_0.advance_id] = var_20_1
				self._knights[#self._knights + 1] = var_20_1

				if var_20_0.put ~= 0 then
					self._knightCount = self._knightCount + 1
				end

				if var_20_0.put == 1 then
					if self._professionKnights[var_20_0.profession] then
						table.insert(self._professionKnights[var_20_0.profession], var_20_0.advance_id)
					else
						self._professionKnights[var_20_0.profession] = {
							var_20_0.advance_id
						}
					end
				end
			end
		end
	end
end

function KnightTable:updateKnightInfo()
	self._curKnights = {}
	self._knightsIdIndex = {}

	local var_21_0 = g.core.model.User.bagData:getList(g.core.const.ConstMgr.BAG_TYPE.KNIGHT)

	for iter_21_0 = 1, #var_21_0 do
		local var_21_1 = var_0_3.get(var_21_0[iter_21_0].base_id)

		self._knightsIndex[var_21_1.advance_id]:setInfo(var_21_0[iter_21_0])

		self._curKnights[#self._curKnights + 1] = self._knightsIndex[var_21_1.advance_id]
		self._knightsIdIndex[var_21_0[iter_21_0].id] = self._knightsIndex[var_21_1.advance_id]

		if var_21_1.type == 1 then
			self._mainId = var_21_0[iter_21_0].id

			g.core.model.User.skinData:initSkinData()
		end
	end

	g.core.model.User.knightFavoData:refreshData()
end

function KnightTable:updateKnightPos(arg_22_1)
	for iter_22_0 = 1, #self._knights do
		if self._knights[iter_22_0]:getInfo() then
			self._knights[iter_22_0]:updatePos(0)
		end
	end

	for iter_22_1 = 1, #self._formation do
		self._formation[iter_22_1] = 0
	end

	self._lineUpAndHelpKnights = {}
	self._positions = {}

	local var_22_0 = arg_22_1.knight_id or {}
	local var_22_1 = arg_22_1.position or {}

	for iter_22_2 = 1, #var_22_0 do
		if var_22_1[iter_22_2] then
			self._formation[var_22_1[iter_22_2]] = var_22_0[iter_22_2]
		end

		self._lineUpAndHelpKnights[iter_22_2] = var_22_0[iter_22_2]
		self._positions[iter_22_2] = var_22_1[iter_22_2]

		if self._knightsIdIndex[var_22_0[iter_22_2]] then
			self._knightsIdIndex[var_22_0[iter_22_2]]:updatePos(iter_22_2)
		end

		g.core.model.User.rebornData:clearIgnoreKnight(var_22_0[iter_22_2])
	end
end

function KnightTable:_changeKnight(arg_23_1, arg_23_2, arg_23_3)
	if arg_23_3.insert then
		self:updateKnightInfo()

		local var_23_0 = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.ASSISTANT_KNIGHT_ID).parameter
		local var_23_1 = g.core.model.User:getAssistantId()

		for iter_23_0, iter_23_1 in pairs(arg_23_3.insert) do
			if var_23_0 == iter_23_1.base_id and var_23_1 ~= var_23_0 and not self._hadSetAssistant then
				g.core.network.GameNetProxy:send_C2S_ModifyUserInfo({
					sk_dress = 0,
					type = 5,
					frame = var_23_0
				})

				self._hadSetAssistant = true

				break
			end
		end
	end

	if arg_23_3.update then
		local var_23_2 = {}

		for iter_23_2, iter_23_3 in ipairs(arg_23_3.update) do
			var_23_2[iter_23_3.id] = iter_23_3
		end

		for iter_23_4, iter_23_5 in pairs(var_23_2) do
			local var_23_3 = self:getKnight({
				id = iter_23_5.id
			})

			if not var_23_3 then
				self:updateKnightInfo()

				return
			end

			var_23_3:updateTrainLevel()
			var_23_3:updateAttrs()
			var_23_3:updateAdvStage()
			var_23_3:updateMrStruct(iter_23_5)
		end
	end
end

return KnightTable

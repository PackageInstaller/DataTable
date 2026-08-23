local var_0_0 = g.core.common.Goods
local NewSlgSkillTreePointCell = class("NewSlgSkillTreePointCell", require("app.fairyGUI.newSlg.UI_NewSlgSkillTreePointCell"))

function NewSlgSkillTreePointCell:ctor()
	self._detailInfo = nil

	self.m_detailList:setVirtual()
	self.m_detailList:setItemRenderer(handler(self, self._onRenderer))
end

function NewSlgSkillTreePointCell:updatePointDetail(arg_2_1, arg_2_2)
	self.m_isEmptyController:setSelectedIndex(1)

	self._detailInfo = {}

	self.m_detailList:setNumItems(#self._detailInfo)
	self.m_detailList:resizeToFit(#self._detailInfo)

	return (self:updateByType(arg_2_1, arg_2_2))
end

function NewSlgSkillTreePointCell:setItemNull()
	self.m_isEmptyController:setSelectedIndex(0)
	self.m_detailList:setHeight(20)
end

function NewSlgSkillTreePointCell:_onRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateSkillTreePoint(self._detailInfo[arg_4_1 + 1], arg_4_1 + 1)
end

function NewSlgSkillTreePointCell:updateByType(arg_5_1, arg_5_2)
	local var_5_0 = 0
	local var_5_1
	local var_5_2 = "advance_id"

	if var_0_0.TYPE_KNIGHT == arg_5_2 then
		var_5_1 = g.core.config.knight_info

		self.m_limitStr:setText(g.core.lang:get(429753, {
			num = g.core.model.User.newSlgData:getNewSlgParamsValueById(1022)
		}))
	elseif var_0_0.TYPE_UNITETOKEN == arg_5_2 then
		self.m_limitStr:setText(g.core.lang:get(429753, {
			num = g.core.model.User.newSlgData:getNewSlgParamsValueById(1023)
		}))

		var_5_1 = g.core.config.unite_token_info
	elseif var_0_0.TYPE_ARTIFACT == arg_5_2 then
		self.m_limitStr:setText(g.core.lang:get(429753, {
			num = g.core.model.User.newSlgData:getNewSlgParamsValueById(1024)
		}))

		var_5_1 = g.core.config.artifact_info
		var_5_2 = "advance_code"
	elseif var_0_0.TYPE_SUCCUBA == arg_5_2 then
		self.m_limitStr:setText(g.core.lang:get(429753, {
			num = g.core.model.User.newSlgData:getNewSlgParamsValueById(1026)
		}))

		var_5_1 = g.core.config.succuba_info
	elseif var_0_0.TYPE_PET == arg_5_2 then
		self.m_limitStr:setText(g.core.lang:get(429753, {
			num = g.core.model.User.newSlgData:getNewSlgParamsValueById(1025)
		}))

		var_5_1 = g.core.config.pet_info
	end

	if var_5_1 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_1 or {}) do
			local var_5_3 = var_5_1.get(iter_5_1.id)

			var_5_0 = var_5_0 + iter_5_1.num

			table.insert(self._detailInfo, {
				star = var_5_3.star,
				name = var_5_3.name,
				point = iter_5_1.num,
				advId = var_5_3[var_5_2],
				index = iter_5_0 + 1
			})
		end
	end

	table.sort(self._detailInfo, function(arg_6_0, arg_6_1)
		if arg_6_0.point ~= arg_6_1.point then
			return arg_6_0.point > arg_6_1.point
		end

		if arg_6_0.advId ~= arg_6_1.advId then
			return arg_6_0.advId < arg_6_1.advId
		end

		return false
	end)

	return var_5_0
end

return NewSlgSkillTreePointCell

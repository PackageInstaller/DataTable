local var_0_0 = g.core.model.User.elderBossData
local ElderTaskCell = class("ElderTaskCell", require("app.fairyGUI.elderBoss.UI_ElderTaskCell"))

function ElderTaskCell:ctor()
	self._awardList = {}
	self._awardId = 0

	self:_initView()
end

function ElderTaskCell:_initView()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListRenderer))
	self.m_getBtn:addClickListener(handler(self, self._onGetClick))
end

function ElderTaskCell:_onAwardListRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateIcon((g.core.common.Goods:convert(self._awardList[arg_3_1 + 1])))
end

function ElderTaskCell:_onGetClick()
	self:dispatchCompEvent("EVENT_ELDER_BOSS_AWARD_GET", self._awardId)
end

function ElderTaskCell:updateView(arg_5_1)
	self._awardId = arg_5_1.info.id
	self._awardList = {}

	for iter_5_0 = 1, 4 do
		if arg_5_1.info["reward_type_" .. iter_5_0] ~= 0 then
			table.insert(self._awardList, {
				type = arg_5_1.info["reward_type_" .. iter_5_0],
				value = arg_5_1.info["reward_value_" .. iter_5_0],
				size = arg_5_1.info["reward_size_" .. iter_5_0]
			})
		end
	end

	self.m_awardList:setNumItems(#self._awardList)

	local var_5_0 = g.core.lang:getByString(arg_5_1.info.name, {
		numL = arg_5_1.info.require_value
	})
	local var_5_1 = 0
	local var_5_2 = arg_5_1.info.require_value

	if arg_5_1.info.require_type == 1 then
		var_5_1 = var_0_0:getChallengeTimes()
	elseif arg_5_1.info.require_type == 2 then
		var_5_1 = var_0_0:getKillBossLevel()
	end

	self.m_descTxt:setText(g.core.lang:get(432519, {
		descText = var_5_0,
		cur = var_5_1,
		require = var_5_2
	}))

	if arg_5_1.got then
		self.m_stateController:setSelectedIndex(2)
	elseif arg_5_1.canGet and not arg_5_1.got then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

return ElderTaskCell

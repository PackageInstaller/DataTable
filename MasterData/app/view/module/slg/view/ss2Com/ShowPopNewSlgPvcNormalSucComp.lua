local ShowPopNewSlgPvcNormalSucComp = class("ShowPopNewSlgPvcNormalSucComp")
local var_0_1 = g.core.const.ConstMgr.NewSlgConst

function ShowPopNewSlgPvcNormalSucComp:ctor()
	self._txtDesc = self:getChild("Txt_desc")
	self._fullAwards = {}
	self._compBuildingInfo = self:getChild("Comp_buildingInfo")
	self._listAward = self:getChild("List_award")

	self._listAward:setVirtual(self)
	self._listAward:setItemRenderer(handler(self, self._onRenderListAwardCell))
end

function ShowPopNewSlgPvcNormalSucComp:update(arg_2_1)
	self._compBuildingInfo:updateView((g.core.model.User.newSlgData:getCityComponentById(arg_2_1.result.city_battle_result.city_id)))

	local var_2_0 = arg_2_1.result.city_battle_result.rank
	local var_2_1

	if not arg_2_1.result.city_battle_result.rank then
		var_2_0 = 0
		var_2_1 = {}
	end

	var_2_1.rank = var_2_0

	self._txtDesc:setText(g.core.lang:get(429017, var_2_1))

	self._awards = arg_2_1.result.awards or {}

	self:_getAllAwards(arg_2_1.result.city_battle_result.city_id)
	self._listAward:setNumItems(#self._fullAwards)
end

function ShowPopNewSlgPvcNormalSucComp:_getAllAwards(arg_3_1)
	self._fullAwards = {}

	local var_3_0 = g.core.model.User.newSlgData:getCityInfoById(arg_3_1)

	if var_3_0.capture_points > 0 then
		table.insert(self._fullAwards, {
			award = {
				value = 112,
				type = 1,
				size = var_3_0.capture_points
			},
			tp = var_0_1.Slg2AwardType.ALLIANCE
		})
	end

	for iter_3_0, iter_3_1 in ipairs(self._awards) do
		table.insert(self._fullAwards, {
			award = iter_3_1,
			tp = var_0_1.Slg2AwardType.PERSON
		})
	end
end

function ShowPopNewSlgPvcNormalSucComp:_onRenderListAwardCell(arg_4_1, arg_4_2)
	arg_4_2:getChild("baseIcon"):updateIcon(self._fullAwards[arg_4_1 + 1].award)
	arg_4_2:setCtrlState("tp", {
		index = self._fullAwards[arg_4_1 + 1].tp
	})
end

return ShowPopNewSlgPvcNormalSucComp

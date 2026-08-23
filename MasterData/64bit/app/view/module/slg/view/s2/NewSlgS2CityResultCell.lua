local NewSlgS2CityResultCell = class("NewSlgS2CityResultCell", require("app.fairyGUI.newSlg.UI_NewSlgS2CityResultCell"))
local var_0_1 = g.core.const.ConstMgr.NewSlgConst
local var_0_2 = g.core.common.Path
local var_0_3 = g.core.model.User.newSlgData

function NewSlgS2CityResultCell:ctor()
	self.m_checkBtn:addClickListener(handler(self, self._onClickBtnCheck))
	self.m_checkUserBtn:addClickListener(handler(self, self._onClickBtnCheckUser))
end

function NewSlgS2CityResultCell:updateCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._cellData = arg_2_1

	self:_updateCity()
	self.m_result_stateController:setSelectedIndex(arg_2_1.is_def and (arg_2_1.is_win and var_0_1.Slg2CityResultState.DEFEND_WIN or var_0_1.Slg2CityResultState.DEFEND_FAIL) or arg_2_1.is_win and var_0_1.Slg2CityResultState.ATTACK_WIN or var_0_1.Slg2CityResultState.ATTACK_FAIL)
	self:_updateScore()
end

function NewSlgS2CityResultCell:updateQuitCell(arg_3_1)
	self:_updateCity(arg_3_1)
	self.m_result_stateController:setSelectedIndex(4)
end

function NewSlgS2CityResultCell:_updateCity(arg_4_1)
	local var_4_0 = self._cellData.city_element_base_id
	local var_4_1 = var_0_3:getCityInfoById(arg_4_1 or self._cellData.city_id)

	self.m_cityPic:setURL(var_0_2:getNewSlgSiegeCity(var_4_1.res))
	self.m_Txt_level:setText(g.core.lang:get(2052, {
		level = var_4_1.level
	}))
	self.m_Txt_name:setText(var_4_1.name)
	self.m_isLessFourLvController:setSelectedIndex(var_4_1.level < 4 and 1 or 0)

	if var_4_0 and var_4_0 ~= 0 then
		local var_4_2 = g.core.config.new_slg_city_element_random_info.get(var_4_0)

		self.m_elemIcon:setURL((g.core.common.Path:getKnightElementIcon(var_4_2.element)))
		self.m_elemTipTypeIcon:setURL(table.concat({
			"ui://newSlg_mapUI/pic_hzts_ysjt",
			var_4_2.type
		}))
		self.m_hasElemController:setSelectedIndex(1)
		self.m_elemTypeController:setSelectedIndex(var_4_2.type - 1)
	else
		self.m_hasElemController:setSelectedIndex(0)
	end
end

function NewSlgS2CityResultCell:_updateScore()
	local var_5_0 = 0

	for iter_5_0, iter_5_1 in ipairs(self._cellData.users or {}) do
		if iter_5_1.team.user_id == g.core.model.User:getId() then
			var_5_0 = (iter_5_1.kill_score or 0) + (iter_5_1.gather_score or 0)

			break
		end
	end

	self.m_scoreTxt:setText(g.core.lang:get(429649, {
		num = var_5_0
	}))
end

function NewSlgS2CityResultCell:_onClickBtnCheck()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_S2_CITY_RESULT_DETAIL, {
		cellData = self._cellData
	})
end

function NewSlgS2CityResultCell:_onClickBtnCheckUser()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_S2_CITY_RESULT_USER, {
		data = self._cellData
	})
end

return NewSlgS2CityResultCell

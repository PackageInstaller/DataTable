local AncientsCoopCreateTeamPop = class("AncientsCoopCreateTeamPop", require("app.fairyGUI.ancients.UI_AncientsCoopCreateTeamPop"), function()
	return fgui.GComponent:create({
		pkgName = "ancients",
		resName = "AncientsCoopCreateTeamPop",
		pkgPath = "ui/ancients/ancients"
	}, ...)
end)

function var_0_1:ctor(arg_2_1)
	self:getView():center(true)

	if arg_2_1 then
		self._isSetting = arg_2_1.isSetting or false
	end

	self._limitLevel = 1
	self._maxLevel = g.core.config.role_info.indexOf(g.core.config.role_info.getLength()).level

	self.m_Btn_checkWithout:addClickListener(handler(self, self._onClickBtnCheckWithout))
	self.m_Btn_check:addClickListener(handler(self, self._onClickBtnCheck))
	self.m_Btn_target1:addClickListener(handler(self, self._onClickBtnTarget1))
	self.m_Btn_target2:addClickListener(handler(self, self._onClickBtnTarget2))
	self.m_Btn_target3:addClickListener(handler(self, self._onClickBtnTarget3))
	self.m_Btn_target4:addClickListener(handler(self, self._onClickBtnTarget4))
	self.m_Btn_create:addClickListener(handler(self, self._onClickBtnCreate))
	self.m_Btn_setting:addClickListener(handler(self, self._onClickBtnSetting))

	self._settingSoulTypeCtrl = self:getController("setting_soulType")

	self.m_ComPopPanel:setHelpId(g.core.const.ConstMgr.HelpConst.HELP_TYPE.ANCIENTS_COOP_CREATE)

	if self._isSetting then
		self.m_ComPopPanel:setTitle(g.core.lang:get(433376))
	end

	self._petInfoArr = g.core.model.User.ancientsData:getPetInfoArr()
end

function var_0_1:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_SETTING, handler(self, self._onRevSetting), self)
	self:_updateView()
end

function var_0_1._onRevSetting(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	g.core.utils.Tools.ancientsFunc.openAncientsMainLayer(true)
end

function var_0_1:_updateView()
	local var_5_0 = g.core.model.User.ancientsData

	self.m_is_settingController:setSelectedIndex(self._isSetting and 1 or 0)

	if self._isSetting then
		self.m_Txt_settingName:setText(g.core.lang:get(433332, {
			name = var_5_0:getTeam().name
		}))

		self._limitLevel = var_5_0:getTeam().apply_level

		self.m_need_checkController:setSelectedIndex(var_5_0:getTeam().confirm and 1 or 0)
		self.m_target_typeController:setSelectedIndex(var_5_0:getTeam().label - 1)
	else
		self.m_Txt_name:setText(g.core.lang:get(433332, {
			name = g.core.model.User:getName()
		}))
	end

	self.m_Btn_target1:updateView(1)
	self.m_Btn_target2:updateView(2)
	self.m_Btn_target3:updateView(3)
	self.m_Btn_target4:updateView(4)
	self.m_subAddNumComp:initMinMaxNum({
		min = 1,
		max = self._maxLevel,
		cur = self._limitLevel,
		callback = function(arg_6_0)
			self._limitLevel = arg_6_0
		end
	})
end

function var_0_1._onClickBtnCheckWithout(arg_7_0)
	return
end

function var_0_1._onClickBtnCheck(arg_8_0)
	return
end

function var_0_1._onClickBtnTarget1(arg_9_0)
	return
end

function var_0_1._onClickBtnTarget2(arg_10_0)
	return
end

function var_0_1._onClickBtnTarget3(arg_11_0)
	return
end

function var_0_1._onClickBtnTarget4(arg_12_0)
	return
end

function var_0_1:_onClickBtnCreate()
	local var_13_0

	if g.core.model.User.ancientsData:isForbiddenJoinTeam() then
		g.core.module.ModuleManager:tip(g.core.lang:get(433355, {
			time = g.core.model.User.ancientsData:getForbiddenJoinTeamCDStr()
		}))

		do return end

		var_13_0 = g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_GOLD, 0)
	end

	local var_13_1, var_13_2, var_13_3

	if var_13_0 < g.core.config.ancients_parameter_info.get(1).parameter then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			value = 0,
			type = g.core.common.Goods.TYPE_GOLD,
			size = var_13_0
		})

		do return end

		var_13_1 = self.m_target_typeController:getSelectedIndex()
		var_13_2 = self.m_soul_typeController:getSelectedIndex()
		var_13_3 = {}
	end

	var_13_3.confirm = self.m_need_checkController:getSelectedIndex() ~= 0
	var_13_3.level = self._limitLevel
	var_13_3.label = var_13_1 + 1
	var_13_3.ancient_pet_id = self._petInfoArr[var_13_2 + 1].id

	g.core.network.GameNetProxy:send_C2S_Ancient_CreateTeam(var_13_3)
end

function var_0_1:_onClickBtnSetting()
	local var_14_0 = self.m_need_checkController:getSelectedIndex() ~= 0
	local var_14_1 = self.m_target_typeController:getSelectedIndex()
	local var_14_2 = ""

	var_14_2 = var_14_1 + 1 ~= g.core.model.User.ancientsData:getTeam().label and var_14_2 .. "1" or var_14_2 .. "0"
	var_14_2 = self._limitLevel ~= g.core.model.User.ancientsData:getTeam().level and var_14_2 .. "1" or var_14_2 .. "0"
	var_14_2 = var_14_0 ~= g.core.model.User.ancientsData:getTeam().confirm and var_14_2 .. "1" or var_14_2 .. "0"

	g.core.network.GameNetProxy:send_C2S_Ancient_Setting({
		operate_type = tonumber(var_14_2, 2),
		is_confirm = var_14_0,
		apply_level = self._limitLevel,
		label = var_14_1 + 1
	})
end

return var_0_1

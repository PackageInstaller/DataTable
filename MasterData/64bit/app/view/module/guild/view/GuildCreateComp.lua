local var_0_0 = g.core.const.ConstMgr.GuildCommonConst
local GuildCreateComp = class("GuildCreateComp", require("app.fairyGUI.guild.UI_GuildCreateComp"))

function GuildCreateComp:ctor(arg_1_1)
	self._signId = nil

	g.core.utils.Black:filterBlackOnInput(self.m_inputText)
	g.core.utils.Tools.setInputTextFont(self.m_inputText)
	self.m_operationBtn:addClickListener(handler(self, self._createGuild))
	self.m_operationHighBtn:addClickListener(handler(self, self._createGuildHigh))
	self.m_changeSettingBtn:addClickListener(handler(self, self._changeSettingBtnClicked))
end

function GuildCreateComp:updateView(arg_2_1)
	self._createType = arg_2_1 or var_0_0.createType.CREATE_GUILD

	local var_2_0

	if self._createType == var_0_0.createType.CREATE_GUILD then
		self:_updateCreateGuildView()
	else
		self.m_isShowDemandController:setSelectedIndex(0)
		self.m_isShowVipController:setSelectedIndex(0)

		local var_2_1 = g.core.model.User.guildData:getGuildData()

		if var_2_1.confirm then
			self.m_checkController:setSelectedIndex(1)
		else
			self.m_checkController:setSelectedIndex(0)
		end

		var_2_0 = var_2_1.apply_level

		self.m_inputText:setText(var_2_1.name)
	end

	local var_2_2 = 120
	local var_2_3 = {
		min = 1,
		cur = 1
	}

	var_2_3.max = 120

	function var_2_3.callback(arg_3_0, arg_3_1)
		if arg_3_1 and arg_3_1.isAdd and arg_3_0 == var_2_2 then
			g.core.module.ModuleManager:tip(g.core.lang:get(109525, {
				num = var_2_2
			}))
		end
	end

	self.m_chooseNumComp:initMinMaxNum(var_2_3)

	local var_2_4

	if var_2_0 then
		self.m_chooseNumComp:setCurNum(var_2_0)

		var_2_4 = {}
	end

	var_2_4.lv = g.core.common.ModuleUnlock:getModuleUnlockLevel(g.core.const.ConstMgr.FUNCTION_TYPE.GUILD_CREATE_HIGH)

	self.m_highLimitText:setText(g.core.lang:get(109640, var_2_4))
	self.m_isUnlockController:setSelectedIndex(g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.GUILD_CREATE_HIGH) and 1 or 0)
end

function GuildCreateComp:_createGuild()
	if not var_0_0.isIgnoreVipLimit and g.core.model.User:getVipLevel() < self._createVipLimit then
		g.core.module.ModuleManager:tip(g.core.lang:get(109518, {
			vip = self._createVipLimit
		}))

		return
	end

	if not self:_checkLegitimate() then
		return
	end

	local var_4_0 = self.m_checkController:getSelectedIndex()
	local var_4_1 = self.m_inputText:getText()

	if tonumber(var_4_1) then
		g.core.module.ModuleManager:tip(g.core.lang:get(109560))

		return
	end

	local var_4_2 = g.core.model.User:getUserData().join_guild_limit or 0

	if not math.uint64_lt(var_4_2, g.core.common.ServerTime:getTime(), true) then
		g.core.module.ModuleManager:tip(g.core.lang:get(109512, {
			time = g.core.common.ServerTime:getLeftDHMSFormat(var_4_2)
		}))

		return
	end

	if tonumber(self._goldCost) > g.core.model.User:getGold() then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = 999,
			value = 1,
			needSize = tonumber(self._goldCost),
			curSize = g.core.model.User:getGold(),
			func = function(arg_5_0)
				g.core.network.GameNetProxy:send_C2S_Guild_Create(arg_5_0)
			end,
			funcParams = {
				is_high = false,
				name = var_4_1,
				icon = self._signId,
				confirm = var_4_0 == 1,
				level = self.m_chooseNumComp:getCurNum()
			}
		})
	else
		local var_4_3 = {
			is_high = false,
			name = var_4_1,
			icon = self._signId,
			confirm = var_4_0 == 1
		}

		var_4_3.level = self.m_chooseNumComp:getCurNum()

		g.core.network.GameNetProxy:send_C2S_Guild_Create(var_4_3)
	end
end

function GuildCreateComp:_createGuildHigh()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.GUILD_CREATE_HIGH) then
		g.core.module.ModuleManager:tip(g.core.common.ModuleUnlock:getUnlockTxt(g.core.const.ConstMgr.FUNCTION_TYPE.GUILD_CREATE_HIGH))

		return
	end

	if not var_0_0.isIgnoreVipLimit and g.core.model.User:getVipLevel() < self._createVipLimit then
		g.core.module.ModuleManager:tip(g.core.lang:get(109518, {
			vip = self._createVipLimit
		}))

		return
	end

	if not self:_checkLegitimate() then
		return
	end

	local var_6_0 = self.m_checkController:getSelectedIndex()
	local var_6_1 = self.m_inputText:getText()

	if tonumber(var_6_1) then
		g.core.module.ModuleManager:tip(g.core.lang:get(109560))

		return
	end

	local var_6_2 = g.core.model.User:getUserData().join_guild_limit or 0

	if not math.uint64_lt(var_6_2, g.core.common.ServerTime:getTime(), true) then
		g.core.module.ModuleManager:tip(g.core.lang:get(109512, {
			time = g.core.common.ServerTime:getLeftDHMSFormat(var_6_2)
		}))

		return
	end

	if tonumber(self._goldFreeCost) > g.core.model.User:getFreeGold() then
		local var_6_3 = self.m_chooseNumComp:getCurNum()

		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = 999,
			value = 0,
			needSize = tonumber(self._goldFreeCost),
			curSize = g.core.model.User:getFreeGold()
		})
	else
		local var_6_4 = {
			is_high = true,
			name = var_6_1,
			icon = self._signId,
			confirm = var_6_0 == 1
		}

		var_6_4.level = self.m_chooseNumComp:getCurNum()

		g.core.network.GameNetProxy:send_C2S_Guild_Create(var_6_4)
	end
end

function GuildCreateComp:_checkLegitimate()
	local var_7_0 = self.m_inputText:getText()

	if g.core.utils.Black:isMatchText(var_7_0) or string.find(var_7_0, "*") then
		self.m_inputText:setText("")
		g.core.module.ModuleManager:tip(g.core.lang:get(100201))

		return false
	end

	local var_7_1, var_7_2 = g.core.utils.String.checkChannelStr(var_7_0)

	if var_7_1 then
		self.m_inputText:setText("")
		g.core.module.ModuleManager:tip(var_7_1)

		return
	end

	if string.find(var_7_0, "^%s+$") or var_7_0 == "" or string.find(var_7_0, "　") then
		g.core.module.ModuleManager:tip(g.core.lang:get(109520))

		return false
	end

	local var_7_3 = #string.gsub(var_7_0, "[\x80-\xBF]", "") - var_7_2

	if var_7_3 < 2 then
		g.core.module.ModuleManager:tip(g.core.lang:get(109521))

		return false
	elseif var_7_3 > 6 then
		g.core.module.ModuleManager:tip(g.core.lang:get(109516))

		return false
	end

	return true
end

function GuildCreateComp:_changeSettingBtnClicked()
	if not self:_checkLegitimate() then
		return
	end

	local var_8_0 = self.m_checkController:getSelectedIndex()
	local var_8_1 = self.m_inputText:getText()
	local var_8_2 = self.m_chooseNumComp:getCurNum()
	local var_8_3 = {
		name = 1,
		confirm = 64,
		icon = 2,
		apply_level = 8
	}
	local var_8_4 = 0
	local var_8_5 = g.core.model.User.guildData:getGuildData()
	local var_8_6 = {}

	if var_8_5.name ~= var_8_1 then
		var_8_4 = var_8_4 + var_8_3.name
		var_8_6.name = var_8_1
	end

	if var_8_5.apply_level ~= var_8_2 then
		var_8_4 = var_8_4 + var_8_3.apply_level
		var_8_6.apply_level = var_8_2
	end

	if (var_8_5.confirm and 1 or 2) ~= (var_8_0 == 0 and 2 or 1) then
		var_8_4 = var_8_4 + var_8_3.confirm
		var_8_6.confirm = var_8_0 == 0 and 2 or 1
	end

	if var_8_5.icon ~= self._signId then
		var_8_4 = var_8_4 + var_8_3.icon
		var_8_6.icon = self._signId
	end

	if var_8_4 == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(109565))

		return
	end

	var_8_6.type = var_8_4

	g.core.network.GameNetProxy:send_C2S_Guild_ModifyInfo(var_8_6)
end

function GuildCreateComp:setSignId(arg_9_1)
	self._signId = arg_9_1
end

function GuildCreateComp:_updateCreateGuildView()
	self.m_isShowVipController:setSelectedIndex(var_0_0.isIgnoreVipLimit and 0 or 1)
	self.m_isShowDemandController:setSelectedIndex(1)

	local var_10_0 = g.core.config.parameter_info.get(var_0_0.vipCreateFuncId).parameter

	self._createVipLimit = var_10_0

	self.m_createDemandText:setText(g.core.lang:get(109519, {
		vip = var_10_0
	}))

	if g.core.model.User:getVipLevel() < self._createVipLimit then
		self.m_createDemandText:setColor(cc.c3b(229, 46, 46))
	end

	self._goldCost = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.GUILD_CREATE_COST).parameter

	self.m_resNeedComp:updateByTVS({
		value = 1,
		type = g.core.common.Goods.TYPE_GOLD,
		size = tonumber(self._goldCost)
	})

	self._goldFreeCost = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.GUILD_CREATE_HIGH_COST).parameter

	self.m_resNeedComp2:updateByTVS({
		value = 0,
		type = g.core.common.Goods.TYPE_GOLD,
		size = tonumber(self._goldFreeCost)
	})
end

return GuildCreateComp

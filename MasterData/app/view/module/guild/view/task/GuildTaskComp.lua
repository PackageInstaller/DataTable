local var_0_0 = g.core.config.guild_worship_mission_info
local var_0_1 = g.core.const.ConstMgr.GuildCommonConst
local var_0_2 = g.core.model.User.guildWorshipData
local var_0_3 = g.core.common.Goods
local GuildTaskComp = class("GuildTaskComp", require("app.fairyGUI.guild.UI_GuildTaskComp"))

function GuildTaskComp:ctor(arg_1_1)
	self._worshipInfo = {}
	self._worshipId = 0
	self._ownNum = 0
	self._price = 0
	self._rewardData = {}

	self.m_worshipBtn:addClickListener(handler(self, self._onClickWorship))
	self.m_goToBtn:addClickListener(handler(self, self._onClickGoto))
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardListRenderer))
end

function GuildTaskComp:updateTask(arg_2_1)
	local var_2_0 = arg_2_1.data.id or 1

	self._worshipId = var_2_0

	local var_2_1 = var_0_0.get(var_2_0)

	self.m_isSpecialController:setSelectedIndex(var_2_1.type == 1 and 1 or 2)
	self.m_title:setText(var_2_1.name)
	self.m_taskDesc:setText(var_2_1.des)

	self._worshipInfo = var_2_1

	local var_2_2 = var_0_2:getWorshipNumById(var_2_0)
	local var_2_3, var_2_4, var_2_5 = var_0_2:getTaskStateById(var_2_0)

	self.m_isShowResNeedController:setSelectedIndex(0)

	if var_2_1.type == 1 then
		if var_2_2 then
			self._price = g.core.model.User.shopData:getBuyPrice(var_0_1.priceId, var_2_2 + 1)
		end

		local var_2_6 = not checkbool(var_2_2)

		self.m_isFreeController:setSelectedIndex(var_2_6 and 1 or 0)

		if not var_2_6 then
			self.m_isShowResNeedController:setSelectedIndex(1)
			self.m_resComp:updateByTVS({
				value = 0,
				type = g.core.common.Goods.TYPE_GOLD,
				size = self._price
			})
		end

		if var_2_4 == (var_2_2 or 0) then
			self.m_isShowResNeedController:setSelectedIndex(0)
		end
	else
		if (var_2_1.type == 2 or var_2_1.type == 3) and var_2_3 == 1 then
			self.m_worshipBtn:setTitle(g.core.lang:get(109625))
		end

		self.m_taskNum:setText(g.core.lang:get(109612, {
			num1 = math.min(arg_2_1.data.num, var_2_1.mission_value),
			num2 = var_2_1.mission_value
		}))
	end

	self.m_taskStateController:setSelectedIndex(var_2_3)
	self:_updateDropAward()
end

function GuildTaskComp:_updateDropAward()
	self._rewardData = {}

	local var_3_0 = g.core.common.Drops:getGoodsArray(self._worshipInfo.award) or {}
	local var_3_1 = g.core.common.Goods:convert({
		value = 45,
		type = g.core.common.Goods.TYPE_RESOURCE,
		size = self._worshipInfo.worship_value
	})
	local var_3_2 = g.core.common.Goods:convert({
		value = 46,
		type = g.core.common.Goods.TYPE_RESOURCE,
		size = self._worshipInfo.guild_exp
	})

	if var_3_1 then
		table.insert(self._rewardData, var_3_1)
	end

	if var_3_2 then
		table.insert(self._rewardData, var_3_2)
	end

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		table.insert(self._rewardData, iter_3_1)
	end

	self.m_rewardList:setNumItems(#self._rewardData)
end

function GuildTaskComp:_onRewardListRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateIcon(self._rewardData[arg_4_1 + 1])
end

function GuildTaskComp:_doWorship()
	g.core.network.GameNetProxy:send_C2S_GuildWorship_FinishMission({
		num = 1,
		id = self._worshipId
	})
end

function GuildTaskComp:_onClickWorship()
	if self._worshipInfo.type == 1 then
		if g.core.model.User:getFreeGold() >= self._price then
			if self._price > 0 then
				g.core.module.ModuleManager:pushPopup(require("app.view.module.guild.view.task.GuildContributeBuyPop").new({
					id = self._worshipId
				}))
			else
				self:_doWorship()
			end
		else
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				value = 0,
				type = var_0_3.TYPE_GOLD
			})
		end
	else
		self:_doWorship()
	end
end

function GuildTaskComp:_onClickGoto()
	if self._worshipInfo.type == 2 then
		local GuildContributePop = require("app.view.module.guild.view.task.GuildContributePop")

		if GuildContributePop then
			g.core.module.ModuleManager:pushPopup(GuildContributePop.new())
		end
	elseif self._worshipInfo.type == 3 and clone(self._worshipInfo).route and g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.GUILD_STATUE) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.GUILD_STATUE)
	end
end

return GuildTaskComp

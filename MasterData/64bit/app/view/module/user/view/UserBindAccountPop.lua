local UserBindAccountConst = require("app.view.module.user.const.UserBindAccountConst")
local UserBindAccountPop = class("UserBindAccountPop", require("app.fairyGUI.user.UI_UserBindAccountPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/user/user",
		resName = "UserBindAccountPop",
		pkgName = "user"
	}, ...)
end)

function UserBindAccountPop:ctor()
	self:_initView()
	self:showAtCenter()
end

function UserBindAccountPop:_initView()
	self.m_otherAccountList:setVirtual(self)
	self.m_otherAccountList:setItemRenderer(handler(self, self._onOtherAccountItemRender))
	self.m_otherAccountList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onOtherAccountItemClick))
end

function UserBindAccountPop:onLoad()
	self:updateView()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BIND_ACCOUNT_SUCCESS, self.updateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_ACCOUNT_AUTHE_SUCC, self.updateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ACCOUNT_BIND_AWARD, self._onRewardAccount, self)
end

function UserBindAccountPop:updateView()
	self.m_AccountGtaComp:updateView(UserBindAccountConst.defaultRegion[config.PUBLISH_REGION] or UserBindAccountConst.default)

	local var_5_1 = UserBindAccountConst.btnConfig[config.PUBLISH_REGION]

	if config.PUBLISH_REGION == 0 then
		var_5_1 = UserBindAccountConst.btnConfig[2]
	end

	self._otherCfg = {}

	local var_5_2 = var_5_1[device.platform] or var_5_1.android

	self:_checkChannelKey(var_5_2)

	for iter_5_0, iter_5_1 in ipairs(var_5_2) do
		if (iter_5_1.showCondition or nil) and iter_5_1.showCondition(g.core.platform.PlatformProxy:getOpId(), (g.core.platform.PlatformProxy:getOpGameId())) then
			table.insert(self._otherCfg, iter_5_1)
		end
	end

	self.m_otherAccountList:setNumItems(#self._otherCfg)

	local var_5_4 = g.core.common.Drops:getGoodsArray(g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.GTA_BIND_AWARD).parameter)

	self._gtaAward = var_5_4

	self.m_gtaAwardComp:updateAward(var_5_4)

	local var_5_5 = g.core.common.Drops:getGoodsArray(g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.OTHER_BIND_AWARD).parameter)

	self._otherAward = var_5_5

	self.m_otherAwardComp:updateAward(var_5_5)
	self:updateBindAwardState()

	local var_5_6, var_5_7 = g.core.model.User.UserTitleData:isCanBindAccountAward()

	if var_5_6 then
		for iter_5_2, iter_5_3 in pairs(var_5_7) do
			g.core.network.GameNetProxy:send_C2S_AccountBind_Award({
				account_type = iter_5_3
			})
		end
	end
end

function UserBindAccountPop:_checkChannelKey(arg_6_1)
	local var_6_0 = g.core.platform.PlatformProxy:getChannelKey()

	if var_6_0 == "3223_2971" or var_6_0 == "3223_2972" then
		for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
			if iter_6_1.SDKName == "Facebook" then
				table.remove(arg_6_1, iter_6_0)

				break
			end
		end
	end
end

function UserBindAccountPop:updateBindAwardState()
	self.m_gtaAwardComp:updateState(g.core.model.User.UserTitleData:hasGetGtaAward())
	self.m_otherAwardComp:updateState(g.core.model.User.UserTitleData:hasGetOtherAward())
end

function UserBindAccountPop:_onOtherAccountItemRender(arg_8_1, arg_8_2)
	arg_8_2:updateView(self._otherCfg[arg_8_1 + 1])
end

function UserBindAccountPop:_onOtherAccountItemClick(arg_9_1)
	local var_9_0 = self._otherCfg[arg_9_1:getDataValue() + 1]

	if var_9_0.bindFunc then
		var_9_0.bindFunc()
	else
		g.core.platform.PlatformProxy:showAccountLinkJson(var_9_0.SDKName)
	end
end

function UserBindAccountPop:_onGtaRewardRenderer(arg_10_1, arg_10_2)
	arg_10_2:updateIcon(self._gtaAward[arg_10_1 + 1])
end

function UserBindAccountPop:_onOtherRewardRenderer(arg_11_1, arg_11_2)
	arg_11_2:updateIcon(self._otherAward[arg_11_1 + 1])
end

function UserBindAccountPop:_onRewardAccount(arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3.awards then
		g.core.module.ModuleManager:awardSummary(arg_12_3.awards, true)
	end

	self:updateView()
end

return UserBindAccountPop

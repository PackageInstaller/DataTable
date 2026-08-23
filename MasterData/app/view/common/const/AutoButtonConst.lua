local var_0_0 = {
	ButtonConstCfg = {
		BLACK_LIST = 4,
		ADD_FRIEND = 3,
		FIGHT = 5,
		LINE_UP = 2,
		PERSON_INFO = 1
	}
}

var_0_0.ButtonConst = {
	[var_0_0.ButtonConstCfg.PERSON_INFO] = var_0_0.ButtonConstCfg.PERSON_INFO,
	[var_0_0.ButtonConstCfg.LINE_UP] = var_0_0.ButtonConstCfg.LINE_UP,
	[var_0_0.ButtonConstCfg.ADD_FRIEND] = var_0_0.ButtonConstCfg.ADD_FRIEND,
	[var_0_0.ButtonConstCfg.BLACK_LIST] = var_0_0.ButtonConstCfg.BLACK_LIST,
	[var_0_0.ButtonConstCfg.FIGHT] = var_0_0.ButtonConstCfg.FIGHT
}
var_0_0.btnCfg = {
	[var_0_0.ButtonConstCfg.PERSON_INFO] = {
		icon = "ui://infoPop/icon_zhenrong",
		title = g.core.lang:get(2074),
		callback = function(self)
			if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.PLAYER_INFO, nil) then
				return
			end

			g.core.module.ModuleManager:popModule()
			g.core.module.ModuleManager:pushModule(g.view.entrance.PLAYER_INFO, {
				uid = self.user.id
			})
		end
	},
	[var_0_0.ButtonConstCfg.LINE_UP] = {
		icon = "ui://infoPop/icon_zhenrong",
		title = g.core.lang:get(109579),
		callback = function(self, arg_2_1)
			if not (self.user and (not self.user.robot_type or self.user.robot_type == 0)) then
				g.core.module.ModuleManager:tip(g.core.lang:get(102538))

				return
			end

			if self.user.id == g.core.model.User:getId() then
				g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)

				return
			end

			local var_2_1 = g.core.model.User.friendData:getPlayerInfo()
			local var_2_2

			if next(var_2_1) and var_2_1.user.id == self.user.id then
				var_2_2 = var_2_1.formationData
			end

			g.core.module.ModuleManager:popModule()
			g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION_OTHER, {
				title = self.user.name,
				data = var_2_2,
				id = self.user.id,
				preFormationParam = arg_2_1
			})
		end
	},
	[var_0_0.ButtonConstCfg.ADD_FRIEND] = {
		icon = "ui://base_new/icon_jiaweihaoyou",
		title = g.core.lang:get(109578),
		callback = function(self)
			self = self.user

			if not self then
				return
			end

			local var_3_0 = g.core.model.User.friendData
			local var_3_1 = g.core.model.User.friendData:isInFriendList(self.id)

			if not self.isFriend then
				if self.isBlack then
					var_3_0:onDelBlackSuc({
						id = self.id
					})
				end

				if var_3_1 then
					g.core.module.ModuleManager:tip(g.core.lang:get(102533))

					return
				end

				var_3_0:notifyAddFriendBySelf(self)
				g.core.network.GameNetProxy:send_C2S_Friend_AddFriend({
					user_id = self.id
				})
			else
				local var_3_2

				if not var_3_1 then
					g.core.module.ModuleManager:tip(g.core.lang:get(102534))
					g.core.module.ModuleManager:popComponent()

					do return end

					var_3_2 = require("app.view.base.pop.BaseConfirmPop").new
				end

				g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
					title = g.core.lang:get(107050),
					desc = g.core.lang:get(102514, {
						name = self.name
					}),
					confirmText = g.core.lang:get(1160),
					cancelText = g.core.lang:get(1037),
					onConfirm = function()
						g.core.network.GameNetProxy:send_C2S_Friend_DelFriend({
							id = self.id
						})
					end
				})))
			end
		end
	},
	[var_0_0.ButtonConstCfg.BLACK_LIST] = {
		icon = "ui://base_new/icon_heimingdan",
		title = g.core.lang:get(109577),
		callback = function(self)
			self = self.user

			if not self then
				return
			end

			local var_5_0 = g.core.model.User.friendData:getBlackList()

			if table.nums(var_5_0) == g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.FRIEND_BLACK_LIMIT).parameter then
				g.core.module.ModuleManager:tip(g.core.lang:get(102515))

				return
			end

			for iter_5_0, iter_5_1 in pairs(var_5_0) do
				if iter_5_1:getFriendId() == self.id then
					g.core.module.ModuleManager:tip(g.core.lang:get(102519))

					return
				end
			end

			g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(107050),
				desc = g.core.lang:get(102516, {
					name = self.name
				}),
				confirmText = g.core.lang:get(1160),
				cancelText = g.core.lang:get(1037),
				onConfirm = function()
					g.core.network.GameNetProxy:send_C2S_Friend_AddBlackList({
						id = self.id
					})
				end
			})))
		end
	},
	[var_0_0.ButtonConstCfg.FIGHT] = {
		icon = "ui://infoPop/icon_qiecuo",
		title = g.core.lang:get(109576),
		callback = function(self)
			self = self.user

			if not self then
				return
			end

			if g.core.battle.BattleProxy:isInBattle() then
				g.core.module.ModuleManager:tip(g.core.lang:get(1043))

				return
			end

			g.core.network.GameNetProxy:send_C2S_Friend_Duel({
				id = self.id
			})
		end
	}
}

function var_0_0.getButtonConst()
	return var_0_0.ButtonConst
end

function var_0_0.getButtonCfg(arg_9_0)
	return var_0_0.btnCfg[arg_9_0]
end

function var_0_0.getButtonConstCfg()
	return var_0_0.ButtonConstCfg
end

return var_0_0

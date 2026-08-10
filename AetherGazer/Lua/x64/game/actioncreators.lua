ActionConst = import("game.ActionConst")

local var_0_0 = {
	import("game.actions.AchievementActionCreators"),
	import("game.actions.BattleFieldActionCreators"),
	import("game.actions.BulletinActionCreators"),
	import("game.actions.ChatActionCreators"),
	import("game.actions.CommonActionCreators"),
	import("game.actions.CurrencyActionCreators"),
	import("game.actions.EquipActionCreators"),
	import("game.actions.EnchantmentActionCreators"),
	import("game.actions.FriendActionCreators"),
	import("game.actions.HeroActionCreators"),
	import("game.actions.LoginActionCreators"),
	import("game.actions.MailActionCreators"),
	import("game.actions.MaterialActionCreators"),
	import("game.actions.PlayerInfoActionCreators"),
	import("game.actions.SettingActionCreators"),
	import("game.actions.ShopActionCreators"),
	import("game.actions.SignActionCreators"),
	import("game.actions.TeamActionCreators"),
	import("game.actions.HeroChatActionCreators"),
	import("game.actions.TineActionCreators")
}

local function var_0_1(arg_1_0)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0) do
		for iter_1_2, iter_1_3 in pairs(iter_1_1) do
			var_1_0[iter_1_2] = iter_1_3
		end
	end

	return var_1_0
end

return bindActionCreators(var_0_1(var_0_0), gameStore.dispatch)

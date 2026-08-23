local var_0_0 = g.core.const.ConstMgr.PubgConst.map
local PubgMapAttackUsersComp = class("PubgMapAttackUsersComp", require("app.fairyGUI.pubg.UI_PubgMapAttackUsersComp"))
local var_0_2 = 310

function PubgMapAttackUsersComp:ctor()
	self._userCompList = {}
end

function PubgMapAttackUsersComp:updateUsersComp(arg_2_1)
	table.sort(arg_2_1, function(arg_3_0, arg_3_1)
		return arg_3_0:getLastSee() < arg_3_1:getLastSee()
	end)

	local var_2_0 = {}
	local var_2_1 = 90 / (math.min(#arg_2_1, var_0_0.MAX_SHOW_ATTACK_NUM) + 1)

	for iter_2_0 = 1, var_0_0.MAX_SHOW_ATTACK_NUM do
		local var_2_2 = self._userCompList[iter_2_0]

		if not self._userCompList[iter_2_0] then
			var_2_2 = fgui.UIPackage:createObject("pubg", "PubgMapAttackUserComp")

			self.m_rootComp:addChild(var_2_2)

			self._userCompList[iter_2_0] = var_2_2
		end

		local var_2_3 = arg_2_1[iter_2_0]

		if arg_2_1[iter_2_0] then
			var_2_2:setVisible(true)
			var_2_2:setData(var_2_3)
			var_2_2:setPosition(var_0_2 * math.cos(math.rad(90 + iter_2_0 * var_2_1)), -(var_0_2 * math.sin(math.rad(90 + iter_2_0 * var_2_1))))
			table.insert(var_2_0, var_2_3)
		else
			var_2_2:setVisible(false)
		end
	end

	return var_2_0
end

function PubgMapAttackUsersComp:refreshUsersComp()
	for iter_4_0, iter_4_1 in pairs(self._userCompList) do
		if iter_4_1:isVisible() then
			iter_4_1:refreshComp()
		end
	end
end

return PubgMapAttackUsersComp

local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostRecoverBuildUpComp = class("OutpostRecoverBuildUpComp", require("app.fairyGUI.outpost.UI_OutpostRecoverBuildUpComp"))

function OutpostRecoverBuildUpComp:updateUpComp(arg_1_1, arg_1_2)
	local var_1_0 = false
	local var_1_1 = false

	if arg_1_2 then
		var_1_0 = arg_1_2.needShake
		var_1_1 = arg_1_2.isTotalTime
	end

	local var_1_2
	local var_1_3 = ""
	local var_1_4 = 1
	local var_1_5 = 0

	if var_0_0.BONUS_TYPE.COIN_TYPE == arg_1_1.type then
		var_1_2 = g.core.lang:get(432604, {
			ratio = arg_1_1.value / 100
		})
		var_1_4 = 0
		var_1_5 = 1
		var_1_3 = g.core.common.Path:getIconByTypeValue(var_0_0.EXCHANGE_ITEM_TYPE, var_0_0.KNIGHT_COIN_ID, true)
	elseif var_0_0.BONUS_TYPE.TIME_TYPE == arg_1_1.type then
		var_1_2 = not var_1_1 and g.core.lang:get(432605, {
			time = arg_1_1.value
		}) or g.core.lang:get(432672, {
			time = arg_1_1.value
		})
		var_1_3 = "ui://outpost/pic_hxsz_shalou"
		var_1_5 = 1
	elseif var_0_0.BONUS_TYPE.KNIGHT_NUM == arg_1_1.type then
		var_1_2 = arg_1_1.value
		var_1_3 = "ui://outpost/pic_hxsz_jgrw"
		var_1_5 = 1
	end

	self:setIcon(var_1_3)
	self:setTitle(var_1_2)
	self.m_scaleController:setSelectedIndex(var_1_5)
	self.m_showUpController:setSelectedIndex(var_1_4)

	if var_1_0 then
		self.m_shakeTransition:play()
	end
end

return OutpostRecoverBuildUpComp

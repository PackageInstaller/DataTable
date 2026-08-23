local var_0_0 = g.core.common.Goods
local RechargeCell = class("RechargeCell", require("app.fairyGUI.pushGift.UI_PushGiftAwardIcon"))

function RechargeCell:ctor()
	self._awardType = nil
	self._awardValue = nil

	self:addClickListener(handler(self, self._onClick))
end

function RechargeCell:updateAwardCell(arg_2_1, arg_2_2, arg_2_3)
	self._awardType = arg_2_1.type
	self._awardValue = arg_2_1.value

	local var_2_0 = arg_2_1.size
	local var_2_1 = arg_2_1.effect == 1
	local var_2_2 = var_0_0:convert({
		type = self._awardType,
		value = self._awardValue
	})

	if var_2_2 then
		self.m_iconLoader:setURL(var_2_2.icon)
	end

	self.m_countTxt:setText("×" .. var_2_0)

	if var_2_1 and arg_2_3 then
		self.m_effUpComp:removeAllEffect()
		self.m_effUpComp:addEffectSpine({
			isLoop = true,
			name = "eff_ui_pushGift_icon",
			anim = "play" .. arg_2_2 .. "_up"
		})
		self.m_effDownComp:removeAllEffect()
		self.m_effDownComp:addEffectSpine({
			isLoop = true,
			name = "eff_ui_pushGift_icon",
			anim = "play" .. arg_2_2 .. "_down"
		})
	end
end

function RechargeCell:_onClick()
	local var_3_0 = var_0_0:convert({
		type = self._awardType,
		value = self._awardValue
	})

	if var_3_0 then
		g.core.common.GlobalFunc.pushInfoPop(var_3_0)
	end
end

return RechargeCell

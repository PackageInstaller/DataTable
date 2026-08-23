local PrimaryLimitWishMiniComp = class("PrimaryLimitWishMiniComp", require("app.fairyGUI.recruitKnight.UI_PrimaryLimitWishMiniComp"))

function PrimaryLimitWishMiniComp:ctor()
	self._recruitId = 0

	self:addClickListener(handler(self, self._onClickAddLoader))
end

function PrimaryLimitWishMiniComp:updateComp(arg_2_1, arg_2_2, arg_2_3)
	self._openTimes = g.core.model.User.recruitData:getWishOpenTimes(arg_2_2, arg_2_3)
	self._recruitId = arg_2_3

	local var_2_0 = g.core.model.User.recruitData:getDrawInfo(arg_2_3, arg_2_2)
	local var_2_1 = 0

	if var_2_0 then
		var_2_1 = var_2_0:getTotalCount()
	end

	self._drawInfo = var_2_0

	local var_2_2 = "play"

	if var_2_1 < self._openTimes then
		self._leftTime = self._openTimes - var_2_1

		self.m_stateController:setSelectedIndex(0)
		self.m_lockTipTxt:setText((g.core.lang:get(108488, {
			num = self._leftTime
		})))
	else
		if arg_2_1 and #arg_2_1 == 0 then
			self.m_stateController:setSelectedIndex(1)
			self.m_nameTxt:setText(g.core.lang:get(108489))
		else
			self.m_stateController:setSelectedIndex(2)

			local var_2_3 = g.core.common.Goods:convert({
				type = arg_2_1[1].r_type,
				value = arg_2_1[1].r_value
			})

			if var_2_3 then
				self.m_iconComp:setIcon(var_2_3.icon)
				self.m_nameTxt:setText(var_2_3.name)
			end
		end

		var_2_2 = "play2"
	end

	self.m_eff:removeAllEffect()
	self.m_eff:addEffectSpine({
		name = "eff_ui_recruitKnight_primaryLimitBtn",
		isLoop = true,
		anim = var_2_2
	})
end

function PrimaryLimitWishMiniComp:_onClickAddLoader()
	if self.m_stateController:getSelectedIndex() ~= 0 then
		self:addPopup((require("app.view.module.recruit.view.pop.PrimaryLimitWishPop").new(self._drawInfo:getId())))
	end
end

return PrimaryLimitWishMiniComp

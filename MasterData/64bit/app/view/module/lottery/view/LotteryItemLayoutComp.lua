local LotteryItemLayoutComp = class("LotteryItemLayoutComp", require("app.fairyGUI.lottery.UI_LotteryItemLayoutComp"))

function LotteryItemLayoutComp:ctor()
	self._layoutInfo = nil
end

function LotteryItemLayoutComp:updateComp(arg_2_1, arg_2_2)
	self._layoutInfo = arg_2_1

	for iter_2_0 = 1, 20 do
		self["m_item" .. iter_2_0]:updateComp(self._layoutInfo[iter_2_0], arg_2_2)
	end
end

function LotteryItemLayoutComp:playRewardEffect(arg_3_1, arg_3_2)
	for iter_3_0 = 1, 20 do
		if self._layoutInfo[iter_3_0].id == arg_3_1 then
			self["m_item" .. iter_3_0]:playRewardEffect(arg_3_2)

			break
		end
	end
end

function LotteryItemLayoutComp:playCellEnterAction()
	self.m_cellEnter1:removeAllEffect()
	self.m_cellEnter1:addEffectSpine({
		remove = true,
		isLoop = false,
		anim = "cellEnter1",
		name = "eff_ui_lottery_enter"
	})
	self.m_cellEnter2:removeAllEffect()
	self.m_cellEnter2:addEffectSpine({
		remove = true,
		isLoop = false,
		anim = "cellEnter2",
		name = "eff_ui_lottery_enter"
	})
	self.m_cellEnter3:removeAllEffect()
	self.m_cellEnter3:addEffectSpine({
		remove = true,
		isLoop = false,
		anim = "cellEnter3",
		name = "eff_ui_lottery_enter"
	})
	self.m_cellEnter4:removeAllEffect()
	self.m_cellEnter4:addEffectSpine({
		remove = true,
		isLoop = false,
		anim = "cellEnter4",
		name = "eff_ui_lottery_enter"
	})
end

return LotteryItemLayoutComp

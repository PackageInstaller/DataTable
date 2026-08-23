local var_0_0 = g.core.module.ModuleManager
local var_0_1 = g.core.model.User
local var_0_2 = g.core.model.User.peakArenaData
local CommonKnight = require("app.view.common.CommonKnight")
local PeakArenaBettingPop = require("app.view.module.peakArena.view.PeakArenaBettingPop")
local PABettingListCell = class("PABettingListCell", require("app.fairyGUI.peakArena.UI_PABettingListCell"))

function PABettingListCell:ctor()
	self._userId = 0
	self._resId = 0
	self._userStruct = nil

	self.m_betBtn:addClickListener(handler(self, self._onClickBetBtn))
end

function PABettingListCell:_updateUserSnapshotView()
	if self._userStruct then
		local var_2_0 = self._userStruct:getUserSnapshot()

		if var_2_0 then
			local var_2_1 = g.core.common.GlobalFunc.getRoleSkinParamsBySnapShot(var_2_0)

			if self._resId ~= var_2_1.resId then
				self._resId = var_2_1.resId
				var_2_1.scale = 1

				self.m_knightSpineDad:removeChildren()
				self.m_knightSpineDad:addChild((CommonKnight.new(var_2_1)))
			end

			self.m_nameTxt:setText(var_2_0.name or "")
			self.m_powerTxt:setText(self._userStruct:getFightValue())
		end
	end
end

function PABettingListCell:updateCell(arg_3_1, arg_3_2)
	self._userId = arg_3_1

	local var_3_0 = var_0_2:getPeakStageUserStructWithId(arg_3_1)

	self._userStruct = var_3_0

	self:_updateUserSnapshotView()
	self.m_myselfController:setSelectedIndex(arg_3_1 == var_0_1:getId() and 1 or 0)
	self.m_oddsTxt:setText((g.core.lang:get(307039, {
		num = string.format("%.2f", math.floor(var_3_0:getChampionOdds() / 10) / 100)
	})))
	self.m_supportNumTxt:setText((g.core.lang:get(307037, {
		num = var_3_0:getSupportNum()
	})))
	self.m_bettingNumTxt:setText((g.core.lang:get(307038, {
		num = var_0_2:getMyBetNum(arg_3_1)
	})))

	if arg_3_2 == 0 then
		self.m_gameOverController:setSelectedIndex(0)
	else
		self.m_gameOverController:setSelectedIndex(1)
		self.m_championController:setSelectedIndex(arg_3_1 == arg_3_2 and 1 or 0)
		self.m_honorTitleComp:updateComp(var_3_0:getHonorTitleType())
	end
end

function PABettingListCell:_onClickBetBtn()
	if self._userId == 0 then
		return
	end

	var_0_0:pushPopup(PeakArenaBettingPop.new(self._userId), {
		touchDisappear = false,
		ignoreTouch = false
	})
end

return PABettingListCell

local CarWashEndPage = class("CarWashEndPage", import("view.dorm3d.Game.Dorm3dGameBaseSubView"))

function CarWashEndPage:Init()
	self:InitUI()
	self:BindEvent()
	self:Hide()

	return
end

function CarWashEndPage:InitUI()
	onButton(self, self._tf:Find("btn_again"), function()
		self:emit(CarWashGameFlowSystem.REQUEST_RESTART_GAME)

		return
	end)
	onButton(self, self._tf:Find("btn_exit"), function()
		self:emit(BaseUI.ON_BACK)

		return
	end)

	self.cleanRank = self._tf:Find("rank")

	setText(self._tf:Find("btn_again/text"), i18n("dorm3d_carwash_retry"))
	setText(self._tf:Find("btn_exit/text"), i18n("dorm3d_carwash_exit"))

	return
end

function CarWashEndPage:BindEvent()
	self:bind(CarWashGameFlowSystem.UPDATE_GAME_STATE, function(arg_6_0, arg_6_1)
		if arg_6_1.newValue == CarWashConst.GAME_STATE.END then
			self:Show()
			self:FlushCleanPersent()
		else
			self:Hide()
		end

		return
	end)

	return
end

function CarWashEndPage:Flush()
	return
end

function CarWashEndPage:FlushCleanPersent()
	local var_8_0 = self:GetRank((self:GetCleanPersent()))

	eachChild(self.cleanRank, function(arg_9_0)
		setActive(arg_9_0, arg_9_0.name == var_8_0)

		return
	end)

	return
end

function CarWashEndPage:GetCleanPersent()
	if self.contextData.gameStatus.stainsCountMax == 0 then
		return 0
	end

	return (math.floor((1 - self.contextData.gameStatus.stainsCount / self.contextData.gameStatus.stainsCountMax) * 100))
end

function CarWashEndPage:GetRank(arg_11_1)
	return CarWashConst.GetScoreRank(arg_11_1)
end

return CarWashEndPage

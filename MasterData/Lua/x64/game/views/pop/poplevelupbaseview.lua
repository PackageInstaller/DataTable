local PopLevelUpBaseView = class("PopLevelUpBaseView", ReduxView)

function PopLevelUpBaseView:CheckBack()
	if not manager.guide:IsPlaying() then
		if self.backTimer_ then
			self.backTimer_:Stop()

			self.backTimer_ = nil
		end

		self.btnBack_.enabled = false
		self.backTimer_ = Timer.New(function()
			self.btnBack_.enabled = true
		end, GameSetting.normal_pop_view_time.value[1], 1)

		self.backTimer_:Start()
	end
end

function PopLevelUpBaseView:Dispose()
	if self.backTimer_ then
		self.backTimer_:Stop()

		self.backTimer_ = nil
	end

	PopLevelUpBaseView.super.Dispose(self)
end

return PopLevelUpBaseView

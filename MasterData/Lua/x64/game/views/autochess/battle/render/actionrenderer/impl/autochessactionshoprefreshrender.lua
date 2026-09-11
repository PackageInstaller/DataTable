local AutoChessActionShopRefreshRender = class("AutoChessActionShopRefreshRender", AutoChessActionBaseRenderer)

function AutoChessActionShopRefreshRender:OnPlay()
	if #self.actionData.refreshShopItemList > 0 then
		for iter_1_0, iter_1_1 in ipairs(self.actionData.refreshShopItemList) do
			local var_1_0 = AutoChessBattleRenderer.GetInstance():GetShopItemByUniqueId(iter_1_1.uniqueId)

			if var_1_0 then
				if iter_1_1.attackChange then
					var_1_0:UpdateAttackChange(iter_1_1.attackChange)
				end

				if iter_1_1.hpChange then
					var_1_0:UpdateHPChange(iter_1_1.hpChange)
				end

				if iter_1_1.expChange then
					var_1_0:UpdateExpChange(iter_1_1.expChange)
				end

				var_1_0:PlayGetEffectAnim(iter_1_1.buffId)
			end
		end

		self:OnShopRefreshAnimFinish()

		return
	end

	if self.actionData.updateType_ == AutoChessConst.SHOP_UPDATE_TYPE.REFRESH then
		manager.notify:Invoke("AUTO_CHESS_REFRESH_SHOP_SHOW")

		self.timer = Timer.New(function()
			self:OnShopRefreshAnimFinish()
		end, 0.2, 1)

		self.timer:Start()
	else
		self:OnShopRefreshAnimFinish()
	end
end

function AutoChessActionShopRefreshRender:OnShopRefreshAnimFinish()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self:Finish()
end

return AutoChessActionShopRefreshRender

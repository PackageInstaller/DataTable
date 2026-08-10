local var_0_0 = class("AutoChessActionShopRefreshRender", AutoChessActionBaseRenderer)

function var_0_0.OnPlay(arg_1_0)
	if #arg_1_0.actionData.refreshShopItemList > 0 then
		for iter_1_0, iter_1_1 in ipairs(arg_1_0.actionData.refreshShopItemList) do
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

		arg_1_0:OnShopRefreshAnimFinish()

		return
	end

	if arg_1_0.actionData.updateType_ == AutoChessConst.SHOP_UPDATE_TYPE.REFRESH then
		manager.notify:Invoke("AUTO_CHESS_REFRESH_SHOP_SHOW")

		arg_1_0.timer = Timer.New(function()
			arg_1_0:OnShopRefreshAnimFinish()
		end, 0.2, 1)

		arg_1_0.timer:Start()
	else
		arg_1_0:OnShopRefreshAnimFinish()
	end
end

function var_0_0.OnShopRefreshAnimFinish(arg_3_0)
	if arg_3_0.timer then
		arg_3_0.timer:Stop()

		arg_3_0.timer = nil
	end

	arg_3_0:Finish()
end

return var_0_0

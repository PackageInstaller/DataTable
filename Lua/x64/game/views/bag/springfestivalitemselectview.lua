local var_0_0 = class("SpringFestivalItemSelectView", OptionalItemSelectView)

function var_0_0.AddUIListener(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.okBtn_, nil, function()
		local var_2_0 = ItemCfg[arg_1_0.itemInfo_[1]]

		if arg_1_0.selectInfo_ then
			if var_2_0.type == ItemConst.ITEM_TYPE.HERO_SKIN then
				if HeroTools.IsSkinUnlock(itemID) then
					ShowTips("SKIN_HAD_UNLOCKED")

					return
				end

				local var_2_1 = getTicketIDBySkinID(itemID)
				local var_2_2 = MaterialData:GetMaterialListById(var_2_1)

				if var_2_2 then
					for iter_2_0, iter_2_1 in pairs(var_2_2) do
						if iter_2_1 > 0 then
							ShowTips("SKIN_HAD_UNLOCKED")

							return
						end
					end
				end
			end

			local var_2_3 = ActivityPointRewardCfg[arg_1_0.cfgID_]

			SpringFestivalShopAciton.ReceivePointReward(arg_1_0.params_.cfgID, arg_1_0.trueIndex_, arg_1_0.useNum_)
		end

		JumpTools.Back()
	end)
	arg_1_0:AddBtnListener(arg_1_0.lockBtn_, nil, function()
		ShowTips("ITEM_SELECTED")
	end)
	arg_1_0:AddBtnListener(arg_1_0.cancelBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_1_0:AddBtnListener(arg_1_0.maskBtn_, nil, function()
		JumpTools.Back()
	end)
end

return var_0_0

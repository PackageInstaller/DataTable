local SpringFestivalItemSelectView = class("SpringFestivalItemSelectView", OptionalItemSelectView)

function SpringFestivalItemSelectView:AddUIListener()
	self:AddBtnListener(self.okBtn_, nil, function()
		if self.selectInfo_ then
			if ItemCfg[self.itemInfo_[1]].type == ItemConst.ITEM_TYPE.HERO_SKIN then
				if HeroTools.IsSkinUnlock(itemID) then
					ShowTips("SKIN_HAD_UNLOCKED")

					return
				end

				local var_2_0 = MaterialData:GetMaterialListById((getTicketIDBySkinID(itemID)))

				if var_2_0 then
					for iter_2_0, iter_2_1 in pairs(var_2_0) do
						if iter_2_1 > 0 then
							ShowTips("SKIN_HAD_UNLOCKED")

							return
						end
					end
				end
			end

			SpringFestivalShopAciton.ReceivePointReward(self.params_.cfgID, self.trueIndex_, self.useNum_)
		end

		JumpTools.Back()
	end)
	self:AddBtnListener(self.lockBtn_, nil, function()
		ShowTips("ITEM_SELECTED")
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		JumpTools.Back()
	end)
end

return SpringFestivalItemSelectView

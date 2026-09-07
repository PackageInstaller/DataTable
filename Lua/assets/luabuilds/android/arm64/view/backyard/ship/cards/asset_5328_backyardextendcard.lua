local BackYardExtendCard = class("BackYardExtendCard", import(".BackYardBaseCard"))

function BackYardExtendCard:OnInit()
	onButton(self, self._content, function()
		self:Unlock()

		return
	end, SFX_PANEL)

	return
end

function BackYardExtendCard:Unlock()
	local var_3_0 = getProxy(DormProxy):getRawData():getExtendTrainPosShopId()

	if var_3_0 then
		local var_3_1 = pg.shop_template[var_3_0].resource_num

		_BackyardMsgBoxMgr:Show({
			content = i18n("backyard_backyardShipInfoLayer_quest_openPos", pg.shop_template[var_3_0].resource_num),
			onYes = function()
				local var_4_0 = getProxy(PlayerProxy):getRawData()

				if var_4_0 and var_4_0:getTotalGem() < var_3_1 then
					GoShoppingMsgBox(i18n("switch_to_shop_tip_3", i18n("word_gem")), ChargeScene.TYPE_DIAMOND)
				else
					self:emit(NewBackYardShipInfoMediator.EXTEND, var_3_0, 1)
				end

				return
			end
		})
	end

	return
end

return BackYardExtendCard

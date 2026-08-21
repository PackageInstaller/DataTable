local var_0_0 = class("BackYardExtendCard", import(".BackYardBaseCard"))

function var_0_0.OnInit(arg_1_0)
	onButton(arg_1_0, arg_1_0._content, function()
		arg_1_0:Unlock()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Unlock(arg_3_0)
	local var_3_0 = getProxy(DormProxy):getRawData():getExtendTrainPosShopId()

	if var_3_0 then
		_BackyardMsgBoxMgr:Show({
			content = i18n("backyard_backyardShipInfoLayer_quest_openPos", pg.shop_template[var_3_0].resource_num),
			onYes = function()
				local var_4_0 = getProxy(PlayerProxy):getRawData()

				if var_4_0 and var_4_0:getTotalGem() < var_0 then
					GoShoppingMsgBox(i18n("switch_to_shop_tip_3", i18n("word_gem")), ChargeScene.TYPE_DIAMOND)
				else
					arg_3_0:emit(NewBackYardShipInfoMediator.EXTEND, var_3_0, 1)
				end

				return
			end
		})
	end

	return
end

return var_0_0

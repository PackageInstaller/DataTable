local ExtendCommand = class("ExtendCommand", pm.SimpleCommand)

function ExtendCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(PlayerProxy)
	local var_1_2 = var_1_1:getData()

	if pg.shop_template[var_1_0.id].effect_args == ShopArgs.EffecetEquipBagSize then
		var_1_2:addEquipmentBagCount(pg.shop_template[var_1_0.id].num * var_1_0.count)
	elseif pg.shop_template[var_1_0.id].effect_args == ShopArgs.EffecetShipBagSize then
		var_1_2:addShipBagCount(pg.shop_template[var_1_0.id].num * var_1_0.count)
	elseif pg.shop_template[var_1_0.id].effect_args == ShopArgs.EffectDromExpPos then
		local var_1_3 = getProxy(DormProxy)
		local var_1_4 = var_1_3:getData()

		var_1_4:increaseTrainPos()
		var_1_4:increaseRestPos()
		var_1_3:updateDrom(var_1_4, BackYardConst.DORM_UPDATE_TYPE_SHIP)
		self:sendNotification(GAME.EXTEND_BACKYARD_DONE)
	elseif pg.shop_template[var_1_0.id].effect_args == ShopArgs.EffectDromFoodMax then
		local var_1_5 = getProxy(DormProxy)
		local var_1_6 = var_1_5:getData()

		var_1_6:extendFoodCapacity(pg.shop_template[var_1_0.id].num)
		var_1_6:increaseFoodExtendCount()
		var_1_5:updateDrom(var_1_6, BackYardConst.DORM_UPDATE_TYPE_EXTENDFOOD)
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_extendCapacity_ok", pg.shop_template[var_1_0.id].num))
	elseif pg.shop_template[var_1_0.id].effect_args == ShopArgs.EffectShopStreetFlash then
		pg.TipsMgr.GetInstance():ShowTips(i18n("refresh_shopStreet_ok"))
	elseif pg.shop_template[var_1_0.id].effect_args == ShopArgs.EffectTradingPortLevel or pg.shop_template[var_1_0.id].effect_args == ShopArgs.EffectOilFieldLevel or pg.shop_template[var_1_0.id].effect_args == ShopArgs.EffectClassLevel then
		local var_1_7
		local var_1_8 = getProxy(NavalAcademyProxy)

		if pg.shop_template[var_1_0.id].effect_args == ShopArgs.EffectTradingPortLevel then
			var_1_7 = var_1_8._goldVO
		elseif pg.shop_template[var_1_0.id].effect_args == ShopArgs.EffectOilFieldLevel then
			var_1_7 = var_1_8._oilVO
		elseif pg.shop_template[var_1_0.id].effect_args == ShopArgs.EffectClassLevel then
			var_1_7 = var_1_8._classVO

			local var_1_9 = var_1_8._classVO:GetLevel()

			if var_1_9 == 7 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_CLASS_LEVEL_UP_8)
			elseif var_1_9 == 8 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_CLASS_LEVEL_UP_9)
			elseif var_1_9 == 9 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_CLASS_LEVEL_UP_10)
			end
		end

		var_1_8:StartUpGradeSuccess(var_1_7)

		if PLATFORM_CODE == PLATFORM_US then
			pg.TipsMgr.GetInstance():ShowTips(i18n("word_start") .. " " .. i18n("word_levelup"))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("word_start") .. i18n("word_levelup"))
		end
	elseif pg.shop_template[var_1_0.id].effect_args == ShopArgs.EffectGuildFlash then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_shop_flash_success"))
	elseif pg.shop_template[var_1_0.id].effect_args == ShopArgs.EffectDormFloor then
		local var_1_10 = getProxy(DormProxy)
		local var_1_11 = var_1_10:getData()

		var_1_11:setFloorNum(var_1_11.floorNum + 1)
		var_1_10:updateDrom(var_1_11, BackYardConst.DORM_UPDATE_TYPE_FLOOR)
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_buy_success"))
	elseif pg.shop_template[var_1_0.id].effect_args == ShopArgs.EffectSkillPos then
		getProxy(NavalAcademyProxy):inCreaseKillClassNum()
		pg.TipsMgr.GetInstance():ShowTips(i18n("open_skill_class_success"))
	elseif pg.shop_template[var_1_0.id].effect_args == ShopArgs.EffectCommanderBagSize then
		var_1_2:updateCommanderBagMax(pg.shop_template[var_1_0.id].num)
	elseif pg.shop_template[var_1_0.id].effect_args == ShopArgs.EffectSpWeaponBagSize then
		getProxy(EquipmentProxy):AddSpWeaponCapacity(pg.shop_template[var_1_0.id].num)
	else
		assert(false, "未处理类型")
	end

	var_1_1:updatePlayer(var_1_2)

	return
end

return ExtendCommand

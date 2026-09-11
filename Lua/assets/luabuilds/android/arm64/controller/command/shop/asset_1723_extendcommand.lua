local ExtendCommand = class("ExtendCommand", pm.SimpleCommand)

function ExtendCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(PlayerProxy)
	local var_1_2 = var_1_1:getData()
	local var_1_3 = ShopConst.GetShopConfig(var_1_0.id)

	if var_1_3.effect_args == ShopArgs.EffecetEquipBagSize then
		var_1_2:addEquipmentBagCount(var_1_3.num * var_1_0.count)
	elseif var_1_3.effect_args == ShopArgs.EffecetShipBagSize then
		var_1_2:addShipBagCount(var_1_3.num * var_1_0.count)
	elseif var_1_3.effect_args == ShopArgs.EffectDromExpPos then
		local var_1_4 = getProxy(DormProxy)
		local var_1_5 = var_1_4:getData()

		var_1_5:increaseTrainPos()
		var_1_5:increaseRestPos()
		var_1_4:updateDrom(var_1_5, BackYardConst.DORM_UPDATE_TYPE_SHIP)
		self:sendNotification(GAME.EXTEND_BACKYARD_DONE)
	elseif var_1_3.effect_args == ShopArgs.EffectDromFoodMax then
		local var_1_6 = getProxy(DormProxy)
		local var_1_7 = var_1_6:getData()

		var_1_7:extendFoodCapacity(var_1_3.num)
		var_1_7:increaseFoodExtendCount()
		var_1_6:updateDrom(var_1_7, BackYardConst.DORM_UPDATE_TYPE_EXTENDFOOD)
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_extendCapacity_ok", var_1_3.num))
	elseif var_1_3.effect_args == ShopArgs.EffectShopStreetFlash then
		pg.TipsMgr.GetInstance():ShowTips(i18n("refresh_shopStreet_ok"))
	elseif var_1_3.effect_args == ShopArgs.EffectTradingPortLevel or var_1_3.effect_args == ShopArgs.EffectOilFieldLevel or var_1_3.effect_args == ShopArgs.EffectClassLevel then
		local var_1_8
		local var_1_9 = getProxy(NavalAcademyProxy)

		if var_1_3.effect_args == ShopArgs.EffectTradingPortLevel then
			var_1_8 = var_1_9._goldVO
		elseif var_1_3.effect_args == ShopArgs.EffectOilFieldLevel then
			var_1_8 = var_1_9._oilVO
		elseif var_1_3.effect_args == ShopArgs.EffectClassLevel then
			var_1_8 = var_1_9._classVO

			local var_1_10 = var_1_9._classVO:GetLevel()

			if var_1_10 == 7 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_CLASS_LEVEL_UP_8)
			elseif var_1_10 == 8 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_CLASS_LEVEL_UP_9)
			elseif var_1_10 == 9 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_CLASS_LEVEL_UP_10)
			end
		end

		var_1_9:StartUpGradeSuccess(var_1_8)

		if PLATFORM_CODE == PLATFORM_US then
			pg.TipsMgr.GetInstance():ShowTips(i18n("word_start") .. " " .. i18n("word_levelup"))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("word_start") .. i18n("word_levelup"))
		end
	elseif var_1_3.effect_args == ShopArgs.EffectGuildFlash then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_shop_flash_success"))
	elseif var_1_3.effect_args == ShopArgs.EffectDormFloor then
		local var_1_11 = getProxy(DormProxy)
		local var_1_12 = var_1_11:getData()

		var_1_12:setFloorNum(var_1_12.floorNum + 1)
		var_1_11:updateDrom(var_1_12, BackYardConst.DORM_UPDATE_TYPE_FLOOR)
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_buy_success"))
	elseif var_1_3.effect_args == ShopArgs.EffectSkillPos then
		getProxy(NavalAcademyProxy):inCreaseKillClassNum()
		pg.TipsMgr.GetInstance():ShowTips(i18n("open_skill_class_success"))
	elseif var_1_3.effect_args == ShopArgs.EffectCommanderBagSize then
		var_1_2:updateCommanderBagMax(var_1_3.num)
	elseif var_1_3.effect_args == ShopArgs.EffectSpWeaponBagSize then
		getProxy(EquipmentProxy):AddSpWeaponCapacity(var_1_3.num)
	else
		assert(false, "未处理类型")
	end

	var_1_1:updatePlayer(var_1_2)

	return
end

return ExtendCommand

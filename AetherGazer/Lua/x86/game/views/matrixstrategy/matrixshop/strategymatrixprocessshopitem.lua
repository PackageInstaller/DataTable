local var_0_0 = class("StrategyMatrixProcessShopItem", MatrixProcessShopItem)

function var_0_0.initUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.rewardItem = StrategyMatrixProcessRewardItem.New(arg_1_0.m_reward)
	arg_1_0.discountController = ControllerUtil.GetController(arg_1_0.transform_, "discount")
end

function var_0_0.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.m_priceBtn, nil, function()
		if StrategyMatrixData:GetMatrixCoint(arg_2_0.matrix_activity_id) < arg_2_0.priceNum then
			ShowTips("LACK_CURRENCY")

			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("MATRIX_SHOP_BUY_CONFIRM"),
			OkCallback = function()
				arg_2_0:OnRewardAction()
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function var_0_0.SetMatrixActivityId(arg_6_0, arg_6_1)
	arg_6_0.rewardItem:SetMatrixActivityId(arg_6_1)

	arg_6_0.matrix_activity_id = arg_6_1
end

function var_0_0.OnRewardAction(arg_7_0)
	local var_7_0 = arg_7_0.id
	local var_7_1 = MatrixItemCfg[var_7_0]

	if not var_7_1 then
		print("MatrixItemCfg cant find item by id :" .. var_7_0)

		return
	end

	local var_7_2 = var_7_1.matrix_item_type

	if MatrixConst.ITEM_TYPE.ASTROLABE == var_7_2 then
		local var_7_3 = math.floor(var_7_1.params[1] / 1000)
		local var_7_4 = arg_7_0:GetHeroData(var_7_3)
		local var_7_5 = var_7_4:GetAstrolabeList()

		if var_7_4:GetAstrolabeNum(var_7_1.params[1]) >= 3 then
			ShowTips(GetTips("MATRIX_NOT_GET_ASTROLABEL"))

			return
		end

		if arg_7_0:GetAstrolabeMaxCount() <= #var_7_5 then
			JumpTools.OpenPageByJump("strategyMatrixProcessAstrolabeReplace", {
				matrix_activity_id = arg_7_0.matrix_activity_id,
				heroId = var_7_3,
				astrolabeId = var_7_0,
				callback = function(arg_8_0)
					StrategyMatrixAction.BuyShopItem(arg_7_0.matrix_activity_id, arg_7_0.shopIndex, var_7_4:GetStandardId(), arg_8_0)
				end
			})
		else
			StrategyMatrixAction.BuyShopItem(arg_7_0.matrix_activity_id, arg_7_0.shopIndex, var_7_4:GetStandardId(), 0)
		end
	elseif MatrixConst.ITEM_TYPE.EQUIP == var_7_2 then
		JumpTools.OpenPageByJump("strategyMatrixProcessShopSelectHero", {
			matrix_activity_id = arg_7_0.matrix_activity_id,
			index = arg_7_0.shopIndex,
			id = var_7_0
		})
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == var_7_2 then
		local var_7_6 = MatrixTools.GetWeaponSpecHero(var_7_1.params[1])

		if var_7_6 == 0 then
			JumpTools.OpenPageByJump("strategyMatrixProcessShopSelectHero", {
				matrix_activity_id = arg_7_0.matrix_activity_id,
				index = arg_7_0.shopIndex,
				id = var_7_0
			})
		else
			local var_7_7 = arg_7_0:GetHeroData(var_7_6)
			local var_7_8 = var_7_7:GetWeaponServant()

			if var_7_8 ~= 0 then
				JumpTools.OpenPageByJump("strategyMatrixProcessWeaponReplace", {
					matrix_activity_id = arg_7_0.matrix_activity_id,
					heroId = var_7_6,
					weaponId = var_7_0,
					callback = function()
						StrategyMatrixAction.BuyShopItem(arg_7_0.matrix_activity_id, arg_7_0.shopIndex, var_7_7:GetStandardId(), var_7_8)
					end
				})
			else
				StrategyMatrixAction.BuyShopItem(arg_7_0.matrix_activity_id, arg_7_0.shopIndex, var_7_7:GetStandardId(), 0)
			end
		end
	else
		StrategyMatrixAction.BuyShopItem(arg_7_0.matrix_activity_id, arg_7_0.shopIndex, 0, 0)
	end
end

function var_0_0.GetHeroData(arg_10_0, arg_10_1)
	return StrategyMatrixData:GetHeroDataNew(arg_10_1)
end

function var_0_0.GetAstrolabeMaxCount(arg_11_0)
	return StrategyMatrixData:GetAstrolabeMaxCount(arg_11_0.matrix_activity_id)
end

function var_0_0.GetSwitchItemIcon(arg_12_0, arg_12_1)
	if arg_12_1 == 26 then
		return StrategyMatrixTools.GetCoinItem(arg_12_0.matrix_activity_id)
	end

	return arg_12_1
end

return var_0_0

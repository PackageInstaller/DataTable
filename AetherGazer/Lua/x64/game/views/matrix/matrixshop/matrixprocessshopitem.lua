local var_0_0 = class("MatrixProcessShopItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
	arg_1_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.m_priceBtn, nil, function()
		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN) < arg_2_0.priceNum then
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

function var_0_0.initUI(arg_6_0)
	arg_6_0:BindCfgUI()

	arg_6_0.rewardItem = MatrixProcessRewardItem.New(arg_6_0.m_reward)
	arg_6_0.discountController = ControllerUtil.GetController(arg_6_0.transform_, "discount")
end

function var_0_0.Refresh(arg_7_0, arg_7_1)
	arg_7_0.id = arg_7_1.id
	arg_7_0.shopIndex = arg_7_1.index
	arg_7_0.discount = arg_7_1.discount
	arg_7_0.priceId = arg_7_1.priceId
	arg_7_0.priceNum = arg_7_1.priceNum
	arg_7_0.m_priceIcon.sprite = ItemTools.getItemLittleSprite(arg_7_0:GetSwitchItemIcon(arg_7_0.priceId))
	arg_7_0.m_priceText.text = arg_7_1.priceNum

	if arg_7_1.discount ~= 1 then
		arg_7_0.m_originalText.text = arg_7_1.priceOriginal

		arg_7_0.discountController:SetSelectedIndex(1)
	else
		arg_7_0.discountController:SetSelectedIndex(0)
	end

	arg_7_0.rewardItem:Refresh(arg_7_0.id)

	arg_7_0.rewardItem.selected_ = true

	arg_7_0.rewardItem:UpdateAstrolabePreview()
end

function var_0_0.OnRewardAction(arg_8_0)
	local var_8_0 = arg_8_0.id
	local var_8_1 = MatrixItemCfg[var_8_0]

	if not var_8_1 then
		print("MatrixItemCfg cant find item by id :" .. var_8_0)

		return
	end

	local var_8_2 = var_8_1.matrix_item_type

	if MatrixConst.ITEM_TYPE.ASTROLABE == var_8_2 then
		local var_8_3 = math.floor(var_8_1.params[1] / 1000)
		local var_8_4 = arg_8_0:GetHeroData(var_8_3)
		local var_8_5 = var_8_4:GetAstrolabeList()

		if var_8_4:GetAstrolabeNum(var_8_1.params[1]) >= 3 then
			ShowTips(GetTips("MATRIX_NOT_GET_ASTROLABEL"))

			return
		end

		if arg_8_0:GetAstrolabeMaxCount() <= #var_8_5 then
			JumpTools.OpenPageByJump("matrixProcessAstrolabeReplace", {
				heroId = var_8_3,
				astrolabeId = var_8_0,
				callback = function(arg_9_0)
					MatrixAction.BuyShopItem(arg_8_0.shopIndex, var_8_4:GetStandardId(), arg_9_0)
				end
			})
		else
			MatrixAction.BuyShopItem(arg_8_0.shopIndex, var_8_4:GetStandardId(), 0)
		end
	elseif MatrixConst.ITEM_TYPE.EQUIP == var_8_2 then
		JumpTools.OpenPageByJump("matrixProcessShopSelectHero", {
			index = arg_8_0.shopIndex,
			id = var_8_0
		})
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == var_8_2 then
		local var_8_6 = MatrixTools.GetWeaponSpecHero(var_8_1.params[1])

		if var_8_6 == 0 then
			JumpTools.OpenPageByJump("matrixProcessShopSelectHero", {
				index = arg_8_0.shopIndex,
				id = var_8_0
			})
		else
			local var_8_7 = arg_8_0:GetHeroData(var_8_6)
			local var_8_8 = var_8_7:GetWeaponServant()

			if var_8_8 ~= 0 then
				JumpTools.OpenPageByJump("matrixProcessWeaponReplace", {
					heroId = var_8_6,
					weaponId = var_8_0,
					callback = function()
						MatrixAction.BuyShopItem(arg_8_0.shopIndex, var_8_7:GetStandardId(), var_8_8)
					end
				})
			else
				MatrixAction.BuyShopItem(arg_8_0.shopIndex, var_8_7:GetStandardId(), 0)
			end
		end
	else
		MatrixAction.BuyShopItem(arg_8_0.shopIndex, 0, 0)
	end
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.rewardItem:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.GetHeroData(arg_12_0, arg_12_1)
	return MatrixData:GetHeroData(arg_12_1)
end

function var_0_0.GetAstrolabeMaxCount(arg_13_0)
	return MatrixData:GetAstrolabeMaxCount()
end

function var_0_0.GetSwitchItemIcon(arg_14_0, arg_14_1)
	return arg_14_1
end

return var_0_0

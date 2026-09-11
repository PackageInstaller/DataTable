local MatrixProcessShopItem = class("MatrixProcessShopItem", ReduxView)

function MatrixProcessShopItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
	self:AddUIListener()
end

function MatrixProcessShopItem:AddUIListener()
	self:AddBtnListener(self.m_priceBtn, nil, function()
		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN) < self.priceNum then
			ShowTips("LACK_CURRENCY")

			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("MATRIX_SHOP_BUY_CONFIRM"),
			OkCallback = function()
				self:OnRewardAction()
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function MatrixProcessShopItem:initUI()
	self:BindCfgUI()

	self.rewardItem = MatrixProcessRewardItem.New(self.m_reward)
	self.discountController = ControllerUtil.GetController(self.transform_, "discount")
end

function MatrixProcessShopItem:Refresh(arg_7_1)
	self.id = arg_7_1.id
	self.shopIndex = arg_7_1.index
	self.discount = arg_7_1.discount
	self.priceId = arg_7_1.priceId
	self.priceNum = arg_7_1.priceNum
	self.m_priceIcon.sprite = ItemTools.getItemLittleSprite(self:GetSwitchItemIcon(self.priceId))
	self.m_priceText.text = arg_7_1.priceNum

	if arg_7_1.discount ~= 1 then
		self.m_originalText.text = arg_7_1.priceOriginal

		self.discountController:SetSelectedIndex(1)
	else
		self.discountController:SetSelectedIndex(0)
	end

	self.rewardItem:Refresh(self.id)

	self.rewardItem.selected_ = true

	self.rewardItem:UpdateAstrolabePreview()
end

function MatrixProcessShopItem:OnRewardAction()
	if not MatrixItemCfg[self.id] then
		print("MatrixItemCfg cant find item by id :" .. self.id)

		return
	end

	local var_8_0 = MatrixItemCfg[self.id].matrix_item_type

	if MatrixConst.ITEM_TYPE.ASTROLABE == MatrixItemCfg[self.id].matrix_item_type then
		local var_8_1 = math.floor(MatrixItemCfg[self.id].params[1] / 1000)
		local var_8_2 = self:GetHeroData(var_8_1)

		if var_8_2:GetAstrolabeNum(MatrixItemCfg[self.id].params[1]) >= 3 then
			ShowTips(GetTips("MATRIX_NOT_GET_ASTROLABEL"))

			return
		end

		if self:GetAstrolabeMaxCount() <= #var_8_2:GetAstrolabeList() then
			JumpTools.OpenPageByJump("matrixProcessAstrolabeReplace", {
				heroId = var_8_1,
				astrolabeId = self.id,
				callback = function(arg_9_0)
					MatrixAction.BuyShopItem(self.shopIndex, var_8_2:GetStandardId(), arg_9_0)
				end
			})
		else
			MatrixAction.BuyShopItem(self.shopIndex, var_8_2:GetStandardId(), 0)
		end
	elseif MatrixConst.ITEM_TYPE.EQUIP == var_8_0 then
		JumpTools.OpenPageByJump("matrixProcessShopSelectHero", {
			index = self.shopIndex,
			id = self.id
		})
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == var_8_0 then
		local var_8_3 = MatrixTools.GetWeaponSpecHero(MatrixItemCfg[self.id].params[1])

		if var_8_3 == 0 then
			JumpTools.OpenPageByJump("matrixProcessShopSelectHero", {
				index = self.shopIndex,
				id = self.id
			})
		else
			local var_8_4 = self:GetHeroData(var_8_3)
			local var_8_5 = var_8_4:GetWeaponServant()

			if var_8_5 ~= 0 then
				JumpTools.OpenPageByJump("matrixProcessWeaponReplace", {
					heroId = var_8_3,
					weaponId = self.id,
					callback = function()
						MatrixAction.BuyShopItem(self.shopIndex, var_8_4:GetStandardId(), var_8_5)
					end
				})
			else
				MatrixAction.BuyShopItem(self.shopIndex, var_8_4:GetStandardId(), 0)
			end
		end
	else
		MatrixAction.BuyShopItem(self.shopIndex, 0, 0)
	end
end

function MatrixProcessShopItem:Dispose()
	self.rewardItem:Dispose()
	MatrixProcessShopItem.super.Dispose(self)
end

function MatrixProcessShopItem:GetHeroData(arg_12_1)
	return MatrixData:GetHeroData(arg_12_1)
end

function MatrixProcessShopItem:GetAstrolabeMaxCount()
	return MatrixData:GetAstrolabeMaxCount()
end

function MatrixProcessShopItem:GetSwitchItemIcon(arg_14_1)
	return arg_14_1
end

return MatrixProcessShopItem

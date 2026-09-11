local ActivityMatrixProcessShopItem = class("ActivityMatrixProcessShopItem", MatrixProcessShopItem)

function ActivityMatrixProcessShopItem:initUI()
	self:BindCfgUI()

	self.rewardItem = ActivityMatrixProcessRewardItem.New(self.m_reward)
	self.discountController = ControllerUtil.GetController(self.transform_, "discount")
end

function ActivityMatrixProcessShopItem:AddUIListener()
	self:AddBtnListener(self.m_priceBtn, nil, function()
		if ActivityMatrixData:GetMatrixCoint(self.matrix_activity_id) < self.priceNum then
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

function ActivityMatrixProcessShopItem:SetMatrixActivityId(arg_6_1)
	self.rewardItem:SetMatrixActivityId(arg_6_1)

	self.matrix_activity_id = arg_6_1
end

function ActivityMatrixProcessShopItem:OnRewardAction()
	if not MatrixItemCfg[self.id] then
		print("MatrixItemCfg cant find item by id :" .. self.id)

		return
	end

	local var_7_0 = MatrixItemCfg[self.id].matrix_item_type

	if MatrixConst.ITEM_TYPE.ASTROLABE == MatrixItemCfg[self.id].matrix_item_type then
		local var_7_1 = math.floor(MatrixItemCfg[self.id].params[1] / 1000)
		local var_7_2 = self:GetHeroData(var_7_1)

		if var_7_2:GetAstrolabeNum(MatrixItemCfg[self.id].params[1]) >= 3 then
			ShowTips(GetTips("MATRIX_NOT_GET_ASTROLABEL"))

			return
		end

		if self:GetAstrolabeMaxCount() <= #var_7_2:GetAstrolabeList() then
			JumpTools.OpenPageByJump("activityMatrixProcessAstrolabeReplace", {
				matrix_activity_id = self.matrix_activity_id,
				heroId = var_7_1,
				astrolabeId = self.id,
				callback = function(arg_8_0)
					ActivityMatrixAction.BuyShopItem(self.matrix_activity_id, self.shopIndex, var_7_2:GetStandardId(), arg_8_0)
				end
			})
		else
			ActivityMatrixAction.BuyShopItem(self.matrix_activity_id, self.shopIndex, var_7_2:GetStandardId(), 0)
		end
	elseif MatrixConst.ITEM_TYPE.EQUIP == var_7_0 then
		JumpTools.OpenPageByJump("activityMatrixProcessShopSelectHero", {
			matrix_activity_id = self.matrix_activity_id,
			index = self.shopIndex,
			id = self.id
		})
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == var_7_0 then
		local var_7_3 = MatrixTools.GetWeaponSpecHero(MatrixItemCfg[self.id].params[1])

		if var_7_3 == 0 then
			JumpTools.OpenPageByJump("activityMatrixProcessShopSelectHero", {
				matrix_activity_id = self.matrix_activity_id,
				index = self.shopIndex,
				id = self.id
			})
		else
			local var_7_4 = self:GetHeroData(var_7_3)
			local var_7_5 = var_7_4:GetWeaponServant()

			if var_7_5 ~= 0 then
				JumpTools.OpenPageByJump("activityMatrixProcessWeaponReplace", {
					matrix_activity_id = self.matrix_activity_id,
					heroId = var_7_3,
					weaponId = self.id,
					callback = function()
						ActivityMatrixAction.BuyShopItem(self.matrix_activity_id, self.shopIndex, var_7_4:GetStandardId(), var_7_5)
					end
				})
			else
				ActivityMatrixAction.BuyShopItem(self.matrix_activity_id, self.shopIndex, var_7_4:GetStandardId(), 0)
			end
		end
	else
		ActivityMatrixAction.BuyShopItem(self.matrix_activity_id, self.shopIndex, 0, 0)
	end
end

function ActivityMatrixProcessShopItem:GetHeroData(arg_10_1)
	return ActivityMatrixData:GetHeroData(self.matrix_activity_id, arg_10_1)
end

function ActivityMatrixProcessShopItem:GetAstrolabeMaxCount()
	return ActivityMatrixData:GetAstrolabeMaxCount(self.matrix_activity_id)
end

function ActivityMatrixProcessShopItem:GetSwitchItemIcon(arg_12_1)
	if arg_12_1 == 26 then
		return ActivityMatrixTools.GetCoinItem(self.matrix_activity_id)
	end

	return arg_12_1
end

return ActivityMatrixProcessShopItem

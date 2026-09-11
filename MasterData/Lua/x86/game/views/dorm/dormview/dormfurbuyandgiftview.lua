local DormFurBuyAndGiftView = class("DormFurBuyAndGiftView", ReduxView)

function DormFurBuyAndGiftView:UIName()
	return "Widget/BackHouseUI/Dorm/DormFurnitureInfoPopUI"
end

function DormFurBuyAndGiftView:UIParent()
	return manager.ui.uiPop.transform
end

function DormFurBuyAndGiftView:Init()
	self:InitUI()
	self:AddUIListener()

	self.heroScroll = LuaList.New(handler(self, self.indexHeroList), self.uilistGo_, DormCharacterItem)
	self.canBuyController = self.btn_okControllerexcollection_:GetController("default0")
	self.stateController = ControllerUtil.GetController(self.transform_, "state")
	self.giveController = ControllerUtil.GetController(self.transform_, "given")
	self.commonItem_ = CommonItemView.New(self.commonitemGo_1)
end

function DormFurBuyAndGiftView:InitUI()
	self:BindCfgUI()
end

function DormFurBuyAndGiftView:OnEnter()
	if self.params_.isBack then
		self:RegisterEvents()

		return
	end

	self.furID = self.params_.furID
	self.furCfg = BackHomeFurniture[self.furID]
	self.state = self.params_.state
	self.params_.state = nil
	self.needNum = self.params_.needNum or 100
	self.params_.needNum = nil
	self.num = self.params_.defaultNum
	self.roomID = DormData:GetCurrectSceneID()

	self:RegisterEvents()
end

function DormFurBuyAndGiftView:OnExit()
	manager.windowBar:HideBar()
end

function DormFurBuyAndGiftView:OnTop()
	self:RefreshView()
	self:RefreshBar()
end

function DormFurBuyAndGiftView:RefreshBar()
	if self.state == "gift" then
		manager.windowBar:HideBar()
	elseif self.state == "buy" then
		manager.windowBar:SwitchBar({
			CurrencyConst.CURRENCY_TYPE_DORM_GOLD,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
		manager.windowBar:SetAsLastSibling()
	end
end

function DormFurBuyAndGiftView:RefreshView()
	self:RefreshFurInfo()

	local var_9_0 = BackHomeFurniture[self.furID]

	if self.state == "gift" then
		self.giveController:SetSelectedState("false")
		self.stateController:SetSelectedState("gift")

		self.buyDesc.text = GetTips("DORM_CAN_GITF_NUM")
	elseif self.state == "buy" then
		self.stateController:SetSelectedState("buy")

		if var_9_0.is_give ~= DormConst.BACKHOME_FUR_GIVE_TYPE.GIFT then
			self.giveController:SetSelectedState("true")

			self.buyDesc.text = GetTips("DORM_CAN_BUY_NUM")
		else
			self.giveController:SetSelectedState("false")

			self.buyDesc.text = GetTips("DORM_CAN_BUY_AND_GITF_NUM")
		end
	end

	if var_9_0.is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.GIFT then
		self:RefreshHeroList()
		self:RefreshGiftDesc()
	end

	self:RefreshBuyNum()

	if self.state == "gift" then
		-- block empty
	elseif self.state == "buy" then
		if var_9_0.is_give ~= DormConst.BACKHOME_FUR_GIVE_TYPE.GIFT then
			self:RefreshCantGiftFurInfo()
		end

		self:RefreshCurrencyItemList()
		self:SelectCurrencyItemList(DormitoryData:GetBuyFurCurrencyID() == DormConst.DORM_CURRENCY_ID and 1 or 2)
	end
end

function DormFurBuyAndGiftView:RegisterEvents()
	self:RegistEventListener(DORM_REFRESH_GIFT_FUR_LIST, function()
		JumpTools.Back()
	end)
	self:RegistEventListener(SHOP_BUY_SUCCESS, function()
		DormitoryData:SetBuyFurCurrencyID(self.curItmeID)

		if self.furCfg.is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.GIFT then
			if HeroRecordCfg.get_id_list_by_hero_id[self.selHeroID][1] then
				DormAction:GiftFurToHero(HeroRecordCfg.get_id_list_by_hero_id[self.selHeroID][1], {
					[self.furID] = self.progressSlr_.value
				})
			end
		else
			JumpTools.Back()
		end
	end)
end

function DormFurBuyAndGiftView:RefreshFurInfo()
	self.commonItem_:SetData({
		id = self.furID
	})

	self.holdNum.text = tostring(DormData:GetFurNumInfo(self.furID).num)
	self.titletextText_.text = ItemTools.getItemName(self.furID)
end

function DormFurBuyAndGiftView:SelectCurrencyItemList(arg_14_1)
	self["item" .. arg_14_1].isOn = true

	if arg_14_1 == 1 then
		self.curItmeID = DormConst.DORM_CURRENCY_ID
	elseif arg_14_1 == 2 then
		self.curItmeID = 1
	end

	self.singleCost, self.goodID = self:GetLowPriceByFurID(self.furID, self.curItmeID)
	self.chooseIconImg_.sprite = ItemTools.getItemSprite(self.curItmeID)

	self:SetfurNum(self.num or 1)
	self:RefreshCost()
end

function DormFurBuyAndGiftView:RefreshHeroList()
	self.heroList = {}

	local var_15_0 = DormData:GetCurrectSceneID()

	if BackHomeCfg[var_15_0].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		table.insert(self.heroList, (DormData:GetHeroInfo(DormitoryData:GetArchiveIDViaRoomID(var_15_0)[1]):GetHeroId()))
	else
		for iter_15_0, iter_15_1 in pairs((DormData:GetHeroInfoList())) do
			table.insert(self.heroList, (DormData:GetHeroInfo(iter_15_0):GetHeroId()))
		end
	end

	CommonTools.UniversalSortEx(self.heroList, {
		ascend = true,
		map = function(arg_16_0)
			if self.state == "gift" then
				if DormRoomTools:GetDormIDViaArchive((DormData:GetHeroArchiveID(arg_16_0))) then
					if DormData:GetHeroTemplateInfo(arg_16_0):GetCanGiftNum(self.furID) > 0 then
						return 1
					else
						return 2
					end
				else
					return 3
				end
			elseif self.state == "buy" then
				if DormRoomTools:GetDormIDViaArchive((DormData:GetHeroArchiveID(arg_16_0))) then
					if DormData:GetHeroTemplateInfo(arg_16_0):GetCanBuyAndGiftNum(self.furID) > 0 then
						return 1
					else
						return 2
					end
				else
					return 3
				end
			end
		end
	})

	self.selHeroID = self.heroList[1]

	self.heroScroll:StartScroll(#self.heroList)

	if #self.heroList > 0 then
		self.heroScroll:ScrollToIndex(1, false, false)
	end
end

function DormFurBuyAndGiftView:RefreshCurrencyItemList()
	self.cur1Text.text = ItemTools.getItemName(DormConst.DORM_CURRENCY_ID)
	self.cur1icon.sprite = ItemTools.getItemSprite(DormConst.DORM_CURRENCY_ID)
	self.cur2Text.text = ItemTools.getItemName(1)
	self.cur2icon.sprite = ItemTools.getItemSprite(1)
end

function DormFurBuyAndGiftView:RefreshBuyNum()
	if self.selHeroID then
		local var_18_0 = DormData:GetHeroTemplateInfo(self.selHeroID)
		local var_18_1 = var_18_0:GetRoomID()

		if self.state == "gift" then
			if var_18_1 then
				self.furNumMax = math.min(self.needNum, (var_18_0:GetCanGiftNum(self.furID)))
				self.progressSlr_.maxValue = self.furNumMax

				self:SetfurNum(self.furNumMax)
			else
				self.furNumMax = 0
				self.progressSlr_.maxValue = self.furNumMax

				self:SetfurNum(0)
			end
		elseif self.state == "buy" then
			if var_18_1 then
				self.furNumMax = math.min(self.needNum, BackHomeFurniture[self.furID].give_max - var_18_0:GetGiftNum(self.furID))
				self.progressSlr_.maxValue = self.furNumMax

				self:SetfurNum(self.furNumMax)
			else
				self.furNumMax = 0
				self.progressSlr_.maxValue = self.furNumMax

				self:SetfurNum(self.furNumMax)
			end
		end
	else
		self.furNumMax = self.state == "buy" and self.furCfg.is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.NO_GIFT and self.needNum or 0
		self.progressSlr_.maxValue = self.furNumMax

		self:SetfurNum(self.furNumMax)
	end
end

function DormFurBuyAndGiftView:RefreshGiftDesc()
	self.descText.text = string.format(GetTips("DORM_FURNITURE_GIFT_CONFIRM"), ItemTools.getItemName(self.furID), GetI18NText(HeroRecordCfg[DormData:GetHeroArchiveID(self.selHeroID)].name))
end

function DormFurBuyAndGiftView:RefreshCantGiftFurInfo()
	self.furTypeDesc.text = DormTools:GetFurGiftTypeDesc(self.furID)

	local var_20_0 = ""

	for iter_20_0, iter_20_1 in ipairs(BackHomeFurniture[self.furID].scene_id) do
		var_20_0 = var_20_0 .. DormTools:GetRoomTypeName(iter_20_1) .. " "
	end

	self.sceneDesc.text = var_20_0
	self.giftMaxText.text = ""
	self.comfortDesc.text = tostring(BackHomeFurniture[self.furID].dorm_exp)
	self.furDesc.text = ItemTools.getItemDesc(self.furID)
end

function DormFurBuyAndGiftView:SetfurNum(arg_21_1)
	arg_21_1 = math.min(arg_21_1, self.furNumMax)
	self.num = arg_21_1
	self.numText_.text = arg_21_1 .. "/" .. self.furNumMax
	self.progressSlr_.value = arg_21_1

	local var_21_0 = DormRoomTools:GetDormIDViaArchive((DormData:GetHeroArchiveID(self.selHeroID)))

	self.comfortText_.text = var_21_0 and GetTips("DORM_FATIGUE_INFO") .. DormitoryData:GetDormExp(var_21_0) .. string.format("<color=#0089E2>+%d</color>", arg_21_1 * BackHomeFurniture[self.furID].dorm_exp) or GetTips("DORM_FATIGUE_INFO") .. string.format("<color=#0089E2>+%d</color>", arg_21_1 * BackHomeFurniture[self.furID].dorm_exp)

	if self.state == "buy" then
		self:RefreshCost()
	elseif self.state == "gift" then
		if (self.selHeroID and DormRoomTools:GetDormIDViaArchive((DormData:GetHeroArchiveID(self.selHeroID))) or self.furCfg.is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.NO_GIFT) and self.num and self.num > 0 and self.furNumMax > 0 then
			self.canBuyController:SetSelectedState("on")
		else
			self.canBuyController:SetSelectedState("off")
		end
	end
end

function DormFurBuyAndGiftView:RefreshCost()
	local var_22_0 = 0

	if self.singleCost then
		var_22_0 = self.singleCost * (self.num or 0)
	end

	if (self.selHeroID and DormRoomTools:GetDormIDViaArchive((DormData:GetHeroArchiveID(self.selHeroID))) or self.furCfg.is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.NO_GIFT) and var_22_0 <= ((self.curItmeID or nil) and ItemTools.getItemNum(self.curItmeID)) and self.num and self.num > 0 and self.furNumMax > 0 then
		self.canBuyController:SetSelectedState("on")

		self.curNumText_.text = tostring(var_22_0)
	else
		self.canBuyController:SetSelectedState("off")

		self.curNumText_.text = "<color=#FF0000>" .. var_22_0 .. "</color>"
	end
end

function DormFurBuyAndGiftView:GetLowPriceByFurID(arg_23_1, arg_23_2)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in ipairs((getGoodListByGiveID(arg_23_1))) do
		if getShopCfg(iter_23_1).cost_id == arg_23_2 then
			table.insert(var_23_0, iter_23_1)
		end
	end

	local var_23_1
	local var_23_2

	for iter_23_2, iter_23_3 in ipairs(var_23_0) do
		local var_23_3 = getShopCfg(iter_23_3).shop_id

		var_23_2 = var_23_2 or ShopTools.GetPrice(iter_23_3, var_23_3)

		if var_23_2 >= ShopTools.GetPrice(iter_23_3, var_23_3) then
			var_23_1 = iter_23_3
		end

		math.min(ShopTools.GetPrice(iter_23_3, var_23_3), var_23_2)
	end

	return var_23_2, var_23_1
end

function DormFurBuyAndGiftView:OnExit()
	self.selHeroID = nil

	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function DormFurBuyAndGiftView:AddUIListener()
	self:AddPressingByTimeListener(self.reduceNumBtn_.gameObject, 3, 0.5, 0.5, function()
		if self.furID and self.progressSlr_.value > 0 then
			self:SetfurNum(self.progressSlr_.value - 1)

			return true
		end

		return false
	end)
	self:AddPressingByTimeListener(self.addNumBtn_.gameObject, 3, 0.5, 0.5, function()
		if self.furID and self.progressSlr_.value < self.furNumMax then
			self:SetfurNum(self.progressSlr_.value + 1)

			return true
		end

		return false
	end)
	self:AddToggleListener(self.progressSlr_, function()
		if self.furID then
			self:SetfurNum(self.progressSlr_.value)
		end
	end)
	self:AddBtnListener(self.confirmBtn_, nil, function()
		self:ClickShowTips()

		if self.state == "buy" then
			if self.furCfg.is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.NO_GIFT then
				if self.progressSlr_.value > 0 and self.goodID then
					if self.curItmeID == 1 then
						ShowMessageBox({
							isTop = true,
							content = GetTips("DORM_BUY_FURNITURE_BY_DIAMOND"),
							OkCallback = function()
								ShopAction.BuyItem({
									{
										goodID = self.goodID,
										buyNum = self.progressSlr_.value
									}
								})
							end,
							CancelCallback = function()
								return
							end
						})
					else
						ShopAction.BuyItem({
							{
								goodID = self.goodID,
								buyNum = self.progressSlr_.value
							}
						})
					end
				end
			elseif self.selHeroID and self.progressSlr_.value > 0 and self.goodID and DormRoomTools:GetDormIDViaArchive((DormData:GetHeroArchiveID(self.selHeroID))) then
				if self.curItmeID == 1 then
					ShowMessageBox({
						isTop = true,
						content = GetTips("DORM_BUY_FURNITURE_BY_DIAMOND"),
						OkCallback = function()
							ShopAction.BuyItem({
								{
									goodID = self.goodID,
									buyNum = self.progressSlr_.value
								}
							})
						end,
						CancelCallback = function()
							return
						end
					})
				else
					ShopAction.BuyItem({
						{
							goodID = self.goodID,
							buyNum = self.progressSlr_.value
						}
					})
				end
			end
		elseif self.state == "gift" and self.selHeroID and self.progressSlr_.value > 0 and self.furID then
			if HeroRecordCfg.get_id_list_by_hero_id[self.selHeroID][1] then
				DormAction:GiftFurToHero(HeroRecordCfg.get_id_list_by_hero_id[self.selHeroID][1], {
					[self.furID] = self.progressSlr_.value
				})
			end
		end
	end)
	self:AddBtnListener(self.bgMaskBtn_, nil, function()
		JumpTools.Back()
	end)

	for iter_25_0 = 1, 2 do
		self:AddToggleListener(self["item" .. iter_25_0], function(arg_35_0)
			if arg_35_0 then
				self:SelectCurrencyItemList(iter_25_0)
			end
		end)
	end

	self:AddBtnListener(self.btnviewBtn_, nil, function()
		if BackHomeDataManager:IsInDormSystem() then
			local var_36_0 = manager.ui.mainCamera:GetComponent("CinemachineBrain")

			if not var_36_0 then
				manager.ui:SetMainCameraCom("CinemachineBrain", true)

				var_36_0 = manager.ui.mainCamera:GetComponent("CinemachineBrain")
			end

			local var_36_1 = var_36_0.m_DefaultBlend

			var_36_0.m_DefaultBlend = DanceGameController.cut

			JumpTools.OpenPageByJump("/furniturePreview", {
				furID = self.furID,
				cacheBlend = var_36_1
			})
		else
			JumpTools.OpenPageByJump("/furniturePreviewWithEntity", {
				furID = self.furID
			})
		end
	end)
end

function DormFurBuyAndGiftView:indexHeroList(arg_37_1, arg_37_2)
	arg_37_2:SetCanClickAndState(true, nil)
	arg_37_2:ShowMaskCallBack(function(arg_38_0)
		if not DormRoomTools:GetDormIDViaArchive((DormData:GetHeroArchiveID(arg_38_0))) then
			return true
		else
			if DormData:GetHeroTemplateInfo(arg_38_0):GetGiftNum(self.furID) >= BackHomeFurniture[self.furID].give_max then
				return true
			end

			return false
		end
	end)
	arg_37_2:SetOnPointerDown(function(arg_39_0)
		if arg_39_0 and BackHomeHeroCfg[arg_39_0] then
			self.selHeroID = arg_39_0

			self.heroScroll:Refresh()
			self:RefreshBuyNum()
			self:RefreshGiftDesc()

			if not DormRoomTools:GetDormIDViaArchive((DormData:GetHeroArchiveID(arg_39_0))) then
				ShowTips(GetTips("DORM_HERO_ROOM_LOCKED"))

				return
			elseif DormData:GetHeroTemplateInfo(arg_39_0):GetGiftNum(self.furID) >= BackHomeFurniture[self.furID].give_max then
				ShowTips(GetTips("DORM_GIFT_MAX_TIPS"))
			end
		end
	end)
	arg_37_2:SelCallBack(function(arg_40_0, arg_40_1, arg_40_2)
		if arg_40_0 == arg_40_1 then
			arg_40_2:SetSelectedState("select")
		else
			arg_40_2:SetSelectedState("normal")
		end
	end)
	arg_37_2:RefreshUI(self.heroList[arg_37_1], self.selHeroID)
end

function DormFurBuyAndGiftView:ClickShowTips()
	if self.selHeroID then
		if not DormRoomTools:GetDormIDViaArchive((DormData:GetHeroArchiveID(self.selHeroID))) then
			ShowTips(GetTips("DORM_HERO_ROOM_LOCKED"))

			return false
		elseif DormData:GetHeroTemplateInfo(self.selHeroID):GetGiftNum(self.furID) >= BackHomeFurniture[self.furID].give_max then
			ShowTips(GetTips("DORM_GIFT_MAX_TIPS"))

			return false
		end

		return true
	end
end

function DormFurBuyAndGiftView:OnBeginDragHeroItem(arg_42_1)
	self.scrollex:OnBeginDrag(arg_42_1)
end

function DormFurBuyAndGiftView:OnDragHeroItem(arg_43_1)
	self.scrollex:OnDrag(arg_43_1)
end

function DormFurBuyAndGiftView:OnEndDragHeroItem(arg_44_1)
	self.scrollex:OnEndDrag(arg_44_1)
end

function DormFurBuyAndGiftView:Dispose()
	if self.heroScroll then
		self.heroScroll:Dispose()
	end

	if self.commonItem_ then
		self.commonItem_:Dispose()
	end

	DormFurBuyAndGiftView.super.Dispose(self)
end

return DormFurBuyAndGiftView

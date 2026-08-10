local var_0_0 = class("CustomCenterHeroSkinPanel", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.skinIdList_ = {}
	arg_1_0.skinItemList_ = {}

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	arg_2_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)

	for iter_2_0, iter_2_1 in pairs(arg_2_0.skinItemList_) do
		iter_2_1:Dispose()
	end

	arg_2_0.skinItemList_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_3_0, arg_3_0.BeginDragFun)))
	arg_3_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_3_0, arg_3_0.EndDragFun)))
	arg_3_0.scrollView_.onValueChanged:AddListener(function()
		arg_3_0:RefreshItemScale()
	end)
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1)
	arg_5_0.heroID_ = arg_5_1
	arg_5_0.skinID_ = PlayerData:GetCacheHeroSkinID(arg_5_1)

	arg_5_0:RefreshItemData()
	arg_5_0:RefreshSkinItemList()
end

function var_0_0.RefreshItemData(arg_6_0)
	arg_6_0.skinIdList_ = {}

	for iter_6_0, iter_6_1 in ipairs(SkinCfg.get_id_list_by_hero[arg_6_0.heroID_]) do
		if not HeroTools.GetIsSkinHide(iter_6_1) then
			if HeroTools.GetHasOwnedSkin(iter_6_1) then
				table.insert(arg_6_0.skinIdList_, iter_6_1)
			elseif HeroTools.CanChangeSkin(iter_6_1) then
				-- block empty
			elseif CustomCenterTools.IsValidHeroSkin(arg_6_0.heroID_, iter_6_1) then
				table.insert(arg_6_0.skinIdList_, iter_6_1)
			end
		end
	end
end

function var_0_0.RefreshSkinItemList(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.skinItemList_) do
		iter_7_1:SetActive(false)
	end

	for iter_7_2, iter_7_3 in ipairs(arg_7_0.skinIdList_) do
		local var_7_0

		if arg_7_0.skinItemList_[iter_7_2] then
			var_7_0 = arg_7_0.skinItemList_[iter_7_2]
		else
			var_7_0 = arg_7_0:GetSkinItem()

			table.insert(arg_7_0.skinItemList_, var_7_0)
			var_7_0:SetDelegate(handler(arg_7_0, arg_7_0.RefreshButton))
		end

		var_7_0:Show(arg_7_0.skinIdList_[iter_7_2], iter_7_2)
		var_7_0:ShowSelect(arg_7_0.selectIndex_ == iter_7_2)
		var_7_0:SetActive(true)
	end

	arg_7_0:Scroll2SelectItem(5)
end

function var_0_0.UpdateSkinItem(arg_8_0)
	arg_8_0:RefreshItemData()
	arg_8_0:RefreshSkinItemList()
end

function var_0_0.RefreshItemBattleSkin(arg_9_0, arg_9_1)
	if not arg_9_0.skinItemList_ then
		return
	end

	if arg_9_1 == 0 then
		arg_9_1 = arg_9_0.heroID_
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.skinItemList_) do
		iter_9_1:ShowBattleSkin(arg_9_1 == iter_9_1.skinID_)
	end
end

function var_0_0.RefreshButton(arg_10_0, arg_10_1)
	arg_10_0.selectIndex_ = arg_10_1.index_

	local var_10_0 = arg_10_1.skinID_
	local var_10_1 = SkinCfg[var_10_0].hero

	if var_10_0 == arg_10_0.skinID_ then
		arg_10_0:Scroll2SelectItem(5)

		return
	end

	arg_10_0.skinID_ = var_10_0

	PlayerData:SetCacheHeroSkinID(var_10_1, var_10_0)
	arg_10_0:RefreshUI(arg_10_0.heroID_)
	arg_10_0:Scroll2SelectItem(5)
	manager.notify:Invoke(CUSTOM_CENTER_SWITCH_HERO_SKIN)
end

function var_0_0.GetSkinItem(arg_11_0)
	return CustomCenterHeroSkinItem.New(arg_11_0.itemGo_, arg_11_0.contentTf_)
end

function var_0_0.BeginDragFun(arg_12_0, arg_12_1, arg_12_2)
	if manager.ui.uiCanvasGroup.blocksRaycasts == false then
		arg_12_0.scrollView_.enabled = false

		return
	end

	arg_12_0:StopMoveTimer()
	arg_12_0:StopScrollTimer()

	arg_12_0.scrollView_.enabled = true

	arg_12_0.scrollView_:OnBeginDrag(arg_12_2)
end

function var_0_0.Scroll2SelectItem(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.skinItemList_) do
		if iter_13_1.isActive then
			local var_13_0 = iter_13_1:GetSkinID() == arg_13_0.skinID_

			if var_13_0 then
				arg_13_0:AddMoveTimer(iter_13_1, arg_13_1)
			end

			iter_13_1:ShowSelect(var_13_0)
		end
	end
end

function var_0_0.GetNearestItem(arg_14_0)
	local var_14_0 = 9999
	local var_14_1
	local var_14_2 = arg_14_0.scrollTf_.rect.width / 2

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.skinItemList_) do
		if iter_14_1.isActive then
			local var_14_3 = math.abs(arg_14_0.contentTf_.localPosition.x + iter_14_1:GetLocalPosition().x - var_14_2)

			if var_14_3 < var_14_0 then
				var_14_0 = var_14_3
				var_14_1 = iter_14_1
			end
		end
	end

	return var_14_1
end

function var_0_0.EndDragFun(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.scrollView_:OnEndDrag(arg_15_2)
	arg_15_0:AddScrollTimer()
end

function var_0_0.AddScrollTimer(arg_16_0)
	arg_16_0:StopScrollTimer()

	arg_16_0.scrollTimer_ = nil
	arg_16_0.scrollTimer_ = FrameTimer.New(function()
		if math.abs(arg_16_0.scrollView_.velocity.x) <= 100 then
			arg_16_0.scrollTimer_:Stop()
			arg_16_0:AdjustItem()
		end
	end, 1, -1)

	arg_16_0.scrollTimer_:Start()
end

function var_0_0.StopScrollTimer(arg_18_0)
	if arg_18_0.scrollTimer_ then
		arg_18_0.scrollTimer_:Stop()

		arg_18_0.scrollTimer_ = nil
	end
end

function var_0_0.AdjustItem(arg_19_0)
	local var_19_0 = arg_19_0:GetNearestItem()

	arg_19_0:RefreshButton(var_19_0)
end

function var_0_0.RefreshItemScale(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.skinItemList_) do
		if iter_20_1.isActive then
			iter_20_1:RefreshShow()
		end
	end
end

function var_0_0.AddMoveTimer(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0:StopMoveTimer()

	arg_21_0.moveTimer_ = FrameTimer.New(function()
		local var_22_0 = arg_21_0.contentTf_.rect.width / 2
		local var_22_1 = arg_21_0.scrollTf_.rect.width / 2
		local var_22_2 = arg_21_0.contentTf_.localPosition
		local var_22_3 = arg_21_1:GetLocalPosition().x * -1 + var_22_1
		local var_22_4 = arg_21_2 * math.pow(arg_21_0.scrollView_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime

		arg_21_0.contentTf_.localPosition = Vector3.Lerp(var_22_2, Vector3.New(var_22_3, var_22_2.y, var_22_2.z), var_22_4)

		if math.abs(var_22_2.x - var_22_3) <= 1 then
			arg_21_0.contentTf_.localPosition = Vector3(var_22_3, var_22_2.y, var_22_2.z)

			arg_21_0:StopMoveTimer()
		end
	end, 1, -1)

	arg_21_0.moveTimer_:Start()
end

function var_0_0.StopMoveTimer(arg_23_0)
	if arg_23_0.moveTimer_ then
		arg_23_0.moveTimer_:Stop()

		arg_23_0.moveTimer_ = nil
	end
end

return var_0_0

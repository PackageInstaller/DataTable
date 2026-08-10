local var_0_0 = class("TeachStageHeroView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.switchType_ = arg_1_2

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI(arg_2_0.gameObject_)

	arg_2_0.curIndex_ = 0
	arg_2_0.inited_ = false
	arg_2_0.isScroll_ = false
	arg_2_0.list_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.listGo_, TeachStageHeroItem)

	arg_2_0.list_:SetHeadTailChangeHandler(handler(arg_2_0, arg_2_0.OnListInit))

	arg_2_0.selectStageItemHandler_ = handler(arg_2_0, arg_2_0.OnSelectStageItem)
end

function var_0_0.OnEnter(arg_3_0)
	arg_3_0:InitHeroList()
	arg_3_0:RefreshUI()
	manager.windowBar:RegistBackCallBack(function()
		if arg_3_0:IsOpenSectionView() then
			arg_3_0.inited_ = true

			local var_4_0 = arg_3_0.list_:GetItemList()

			for iter_4_0, iter_4_1 in pairs(var_4_0) do
				iter_4_1:RefreshSelect(0)
			end

			arg_3_0.m_scrollCom.horizontal = true
		end

		JumpTools.Back()
	end)
end

function var_0_0.RefreshUI(arg_5_0)
	if arg_5_0.heroID_ then
		if arg_5_0.inited_ then
			if arg_5_0.herolist_ == nil then
				arg_5_0:InitHeroList()
			end

			local var_5_0 = table.indexof(arg_5_0.herolist_, arg_5_0.heroID_)

			arg_5_0.list_:StartScroll(arg_5_0:GetHeroNum(), var_5_0)
			arg_5_0:RefreshSelectStageItem(var_5_0)

			local var_5_1 = arg_5_0.list_:GetItemList()[var_5_0]

			if var_5_1 then
				local var_5_2 = -var_5_1.transform_.localPosition.x + arg_5_0.m_scrollViewTrans.rect.width / 3 - var_5_1.transform_.rect.width / 2

				arg_5_0:RemoveTween()

				arg_5_0.tween_ = LeanTween.value(arg_5_0.m_scrollContent, arg_5_0.m_scrollContent.transform.localPosition.x, var_5_2, 0):setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_5_0.m_scrollContent.transform.localPosition = Vector3(arg_6_0, 0, 0)
				end))
				arg_5_0.m_scrollCom.horizontal = false
			else
				arg_5_0.m_scrollCom.horizontal = true
			end

			arg_5_0.heroID_ = nil
		else
			if arg_5_0.herolist_ == nil then
				arg_5_0:InitHeroList()
			end

			arg_5_0.curIndex_ = table.indexof(arg_5_0.herolist_, arg_5_0.heroID_)

			if not arg_5_0.isScroll_ then
				arg_5_0.list_:StartScroll(arg_5_0:GetHeroNum())

				arg_5_0.isScroll_ = true
			end

			arg_5_0:ScrollToCurIndex()
		end
	elseif arg_5_0.curIndex_ > 0 then
		local var_5_3 = arg_5_0.list_:GetItemList()[arg_5_0.curIndex_]

		if var_5_3 then
			local var_5_4 = -var_5_3.transform_.localPosition.x + arg_5_0.m_scrollViewTrans.rect.width / 3 - var_5_3.transform_.rect.width / 2

			arg_5_0:RemoveTween()

			arg_5_0.tween_ = LeanTween.value(arg_5_0.m_scrollContent, arg_5_0.m_scrollContent.transform.localPosition.x, var_5_4, 0):setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
				arg_5_0.m_scrollContent.transform.localPosition = Vector3(arg_7_0, 0, 0)
			end))
		end

		if arg_5_0:IsOpenSectionInfo() then
			local var_5_5 = arg_5_0.list_:GetItemList()

			for iter_5_0, iter_5_1 in pairs(var_5_5) do
				iter_5_1:RefreshSelect(arg_5_0.curIndex_)
			end

			arg_5_0.m_scrollCom.horizontal = false
		else
			local var_5_6 = arg_5_0.list_:GetItemList()

			for iter_5_2, iter_5_3 in pairs(var_5_6) do
				iter_5_3:RefreshSelect(0)
			end

			arg_5_0.m_scrollCom.horizontal = true
		end
	else
		arg_5_0.list_:StartScroll(arg_5_0:GetHeroNum())
	end
end

function var_0_0.OnListInit(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0.inited_ and arg_8_0.heroID_ then
		if arg_8_0.herolist_ == nil then
			arg_8_0:InitHeroList()
		end

		local var_8_0 = table.indexof(arg_8_0.herolist_, arg_8_0.heroID_)

		arg_8_0.curIndex_ = table.indexof(arg_8_0.herolist_, arg_8_0.heroID_)

		local var_8_1 = -(303 * arg_8_0.curIndex_ - arg_8_0.m_scrollViewTrans.rect.width / 3)

		arg_8_0.m_scrollCom.horizontal = false
		arg_8_0.m_scrollContent.transform.localPosition = Vector3(var_8_1, 0, 0)
	end
end

function var_0_0.OnSelectStageItem(arg_9_0, arg_9_1)
	arg_9_0.inited_ = true

	arg_9_0:RefreshSelectStageItem(arg_9_1)

	local var_9_0 = arg_9_0.list_:GetItemList()[arg_9_1]

	if var_9_0 then
		local var_9_1 = -var_9_0.transform_.localPosition.x + arg_9_0.m_scrollViewTrans.rect.width / 3 - var_9_0.transform_.rect.width / 2

		arg_9_0:RemoveTween()

		arg_9_0.tween_ = LeanTween.value(arg_9_0.m_scrollContent, arg_9_0.m_scrollContent.transform.localPosition.x, var_9_1, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_10_0)
			arg_9_0.m_scrollContent.transform.localPosition = Vector3(arg_10_0, 0, 0)
		end))
		arg_9_0.m_scrollCom.horizontal = false
	else
		arg_9_0.m_scrollCom.horizontal = true
	end
end

function var_0_0.TryToCloseSectionView(arg_11_0)
	if arg_11_0:IsOpenSectionView() then
		arg_11_0.inited_ = true

		local var_11_0 = arg_11_0.list_:GetItemList()

		for iter_11_0, iter_11_1 in pairs(var_11_0) do
			iter_11_1:RefreshSelect(0)
		end

		arg_11_0.m_scrollCom.horizontal = true

		JumpTools.Back()
	end
end

function var_0_0.RefreshSelectStageItem(arg_12_0, arg_12_1)
	arg_12_0.curIndex_ = arg_12_1

	local var_12_0 = arg_12_0.list_:GetItemList()

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		iter_12_1:RefreshSelect(arg_12_1)
	end
end

function var_0_0.RemoveTween(arg_13_0)
	if arg_13_0.tween_ then
		arg_13_0.tween_:setOnUpdate(nil)
		LeanTween.cancel(arg_13_0.m_scrollContent)

		arg_13_0.tween_ = nil
	end
end

function var_0_0.IsOpenSectionView(arg_14_0)
	return arg_14_0:IsOpenRoute("teachSectionInfo")
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0:RemoveTween()

	arg_15_0.inited_ = true

	if not arg_15_0:IsOpenSectionInfo() then
		local var_15_0 = arg_15_0.list_:GetItemList()

		for iter_15_0, iter_15_1 in pairs(var_15_0) do
			iter_15_1:RefreshSelect(0)
		end

		arg_15_0.m_scrollCom.horizontal = true
	end
end

function var_0_0.OnClickTeachViewBtn(arg_16_0)
	local var_16_0 = arg_16_0.list_:GetItemList()

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		iter_16_1:RefreshSelect(0)
	end

	arg_16_0.m_scrollCom.horizontal = true
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0.m_scrollEvent:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerDown)
	arg_17_0.m_scrollEvent:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	var_0_0.super.Dispose(arg_17_0)

	if arg_17_0.list_ then
		arg_17_0.list_:Dispose()

		arg_17_0.list_ = nil
	end
end

function var_0_0.IndexItem(arg_18_0, arg_18_1, arg_18_2)
	arg_18_2:SetData(arg_18_1, arg_18_0.curIndex_, arg_18_0.inited_)
	arg_18_2:SetHeroID(arg_18_0.herolist_[arg_18_1])
	arg_18_2:SetSelectCallBack(arg_18_0.selectStageItemHandler_)
end

function var_0_0.AddListeners(arg_19_0)
	arg_19_0:AddBtnListener(arg_19_0.bgbtn_, nil, function()
		arg_19_0:TryToCloseSectionView()
	end)
	arg_19_0.m_scrollEvent:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_21_0, arg_21_1)
		arg_19_0:TryToCloseSectionView()
	end))
	arg_19_0.m_scrollEvent:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_22_0, arg_22_1)
		arg_19_0:TryToCloseSectionView()
	end))
end

function var_0_0.RemoveListeners(arg_23_0)
	return
end

function var_0_0.SwitchPageUI(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0.switchType_ == arg_24_1

	SetActive(arg_24_0.gameObject_, var_24_0)

	if var_24_0 then
		arg_24_0.heroID_ = arg_24_2

		arg_24_0:ScrollToCurIndex()
		BattleTeachAction.CancelHeroTeachRedPoint()
	end
end

function var_0_0.ScrollToCurIndex(arg_25_0)
	if arg_25_0.curIndex_ > 0 then
		local var_25_0 = arg_25_0.curIndex_ * 303 - 200

		arg_25_0.list_:SetScrolledPosition(Vector2.New(var_25_0 / arg_25_0.m_scrollContent.transform.rect.width, 0))
	end
end

function var_0_0.InitHeroList(arg_26_0)
	local var_26_0 = {}
	local var_26_1 = {}
	local var_26_2 = {}
	local var_26_3 = {}

	for iter_26_0, iter_26_1 in pairs(HeroData:GetHeroList()) do
		if not HeroTools.GetIsHide(iter_26_1.id) then
			table.insert(var_26_3, iter_26_1)
		end
	end

	table.sort(var_26_3, function(arg_27_0, arg_27_1)
		if arg_27_0.id < arg_27_1.id then
			return true
		end

		return false
	end)

	for iter_26_2, iter_26_3 in pairs(var_26_3) do
		if iter_26_3.unlock == 1 then
			local var_26_4 = HeroCfg[iter_26_3.id].study_stage[1]

			if BattleTeachData:GetHeroTeachInfo(iter_26_3.id, var_26_4) > 0 then
				table.insert(var_26_1, iter_26_3.id)
			else
				table.insert(var_26_0, iter_26_3.id)
			end
		else
			table.insert(var_26_2, iter_26_3.id)
		end
	end

	table.insertto(var_26_0, var_26_1)
	table.insertto(var_26_0, var_26_2)

	arg_26_0.herolist_ = var_26_0
end

function var_0_0.GetHeroNum(arg_28_0)
	local var_28_0 = 0

	for iter_28_0, iter_28_1 in ipairs(HeroCfg.get_id_list_by_private[0]) do
		if not HeroTools.GetIsHide(iter_28_1) then
			var_28_0 = var_28_0 + 1
		end
	end

	return var_28_0
end

function var_0_0.IsOpenSectionInfo(arg_29_0)
	return arg_29_0:IsOpenRoute("teachSectionInfo")
end

return var_0_0

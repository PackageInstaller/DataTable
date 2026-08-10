local var_0_0 = class("EnterBattleSelectHeroPage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.charaItem_ = {}

	arg_2_0:BindCfgUI(arg_2_0.changeCharaGo_, arg_2_0.charaItem_)

	arg_2_0.infoPage_ = IdolTraineeTrainInfoPage.New(arg_2_0.heroInfoSubView_)
	arg_2_0.heroList_ = {}
	arg_2_0.curHeroID_ = 0
	arg_2_0.curHeroIndex_ = 0
	arg_2_0.heroUIList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.heroListGo_, IdolTraineeHeadItem)
	arg_2_0.detailController_ = arg_2_0.mainControllerEx_:GetController("showDetail")
	arg_2_0.curAtkController_ = arg_2_0.mainControllerEx_:GetController("curAtk")
	arg_2_0.curDefController_ = arg_2_0.mainControllerEx_:GetController("curDef")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.setAttackCharaBtn_, nil, function()
		IdolTraineeAction.RequestSetAttackHero(arg_3_0.curHeroID_, function()
			arg_3_0:RefreshUI()
			IdolTraineeCampBridge.GenerateAttackHero(arg_3_0.curHeroID_)
		end)
	end)
	arg_3_0:AddBtnListener(arg_3_0.setDefendCharaBtn_, nil, function()
		IdolTraineeAction.RequestSetDefendHero(arg_3_0.curHeroID_, function()
			arg_3_0:RefreshUI()
		end)
	end)
end

function var_0_0.ShowPage(arg_8_0, arg_8_1)
	if arg_8_0.showFlag == arg_8_1 then
		return
	end

	arg_8_0.showFlag = arg_8_1

	if arg_8_1 then
		arg_8_0.detailController_:SetSelectedState("true")
		arg_8_0:OnEnter()

		if arg_8_0.showCallBack then
			arg_8_0.showCallBack()
		end
	else
		arg_8_0.detailController_:SetSelectedState("false")
		arg_8_0:OnExit()

		if arg_8_0.closeCallBack then
			arg_8_0.closeCallBack()
		end
	end
end

function var_0_0.SetShowCallBack(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 then
		arg_9_0.showCallBack = arg_9_1
	end

	if arg_9_2 then
		arg_9_0.closeCallBack = arg_9_2
	end
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.infoPage_:RegisterEvents()

	if arg_10_0.showFlag then
		arg_10_0:RefreshUI()
	end
end

function var_0_0.OnExit(arg_11_0)
	if arg_11_0.showFlag then
		-- block empty
	end

	arg_11_0.infoPage_:RemoveAllEventListener()
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0.heroList_ = IdolTraineeData:GetIdolHeroList() or {}

	DormTools.SortBattleHeroList(arg_12_0.heroList_)

	local var_12_0 = IdolTraineeData:GetCurAttackHero()

	if not arg_12_0.curHeroID_ or arg_12_0.curHeroID_ == 0 then
		for iter_12_0, iter_12_1 in pairs(var_12_0) do
			if iter_12_1 == true then
				arg_12_0.curHeroID_ = iter_12_0
			end
		end
	end

	if arg_12_0.curHeroID_ then
		arg_12_0.curHeroIndex_ = table.keyof(arg_12_0.heroList_, arg_12_0.curHeroID_)
		arg_12_0.charaItem_.headIcon_.sprite = DormHeroTools.GetBackHomeHeadSprite(arg_12_0.curHeroID_)
	end

	IdolTraineeCampBridge.GenerateAttackHero(arg_12_0.curHeroID_)
	arg_12_0:UpdateView(arg_12_0.curHeroID_)
	arg_12_0.heroUIList_:StartScroll(#arg_12_0.heroList_)
end

function var_0_0.UpdateView(arg_13_0, arg_13_1)
	arg_13_0.curHeroID_ = arg_13_1

	local var_13_0 = IdolTraineeTools:GetHeroBattleInfoTemplate(arg_13_0.curHeroID_)

	arg_13_0.curDefController_:SetSelectedState(IdolTraineeTools:CheckHeroIsDefine(arg_13_0.curHeroID_) and "true" or "false")
	arg_13_0.curAtkController_:SetSelectedState(IdolTraineeTools:CheckHeroIsAttack(arg_13_0.curHeroID_) and "true" or "false")
	arg_13_0.infoPage_:RefreshUI(var_13_0)
end

function var_0_0.IndexItem(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2:SetData(arg_14_0.heroList_[arg_14_1], arg_14_0.curHeroID_, function()
		if arg_14_0.curHeroID_ ~= 0 and arg_14_0.curHeroIndex_ ~= 0 then
			local var_15_0 = arg_14_0.heroUIList_:GetItemByIndex(arg_14_0.curHeroIndex_)

			if var_15_0 then
				var_15_0:SelectOff()
			end
		end

		arg_14_0.curHeroIndex_ = arg_14_1

		arg_14_2:SelectOn()
		arg_14_0:UpdateView(arg_14_0.heroList_[arg_14_1])
	end)
end

function var_0_0.Dispose(arg_16_0)
	if arg_16_0.heroUIList_ then
		arg_16_0.heroUIList_:Dispose()

		arg_16_0.heroUIList_ = nil
	end

	if arg_16_0.infoPage_ then
		arg_16_0.infoPage_:Dispose()

		arg_16_0.infoPage_ = nil
	end

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0

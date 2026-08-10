local var_0_0 = class("StoryTimeLineItemBaseView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.tempVector3_ = Vector3.New(0, 0, 0)
	arg_1_0.parent_ = arg_1_2

	arg_1_0:InitUI()
	arg_1_0:Show(true)
end

function var_0_0.OnEnter(arg_2_0)
	return
end

function var_0_0.OnExit(arg_3_0)
	return
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0:RemoveListeners()
	var_0_0.super.Dispose(arg_4_0)
	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.gameObject_ = nil
	arg_4_0.transform_ = nil
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.stateController_ = arg_5_0.controller_:GetController("state")
	arg_5_0.categoryController_ = arg_5_0.controller_:GetController("category")
	arg_5_0.illShowController_ = arg_5_0.controller_:GetController("illShow")
	arg_5_0.lockController_ = arg_5_0.controller_:GetController("lock")

	arg_5_0:AddListeners()
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btn_, nil, function()
		if arg_6_0.clickCallBack_ then
			arg_6_0.clickCallBack_(arg_6_0.id_, arg_6_0)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.branchBtn_, nil, function()
		if arg_6_0.clickCallBack_ then
			arg_6_0.clickCallBack_(arg_6_0.id_, arg_6_0)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.branchBtn2_, nil, function()
		if arg_6_0.clickCallBack_ then
			arg_6_0.clickCallBack_(arg_6_0.id_, arg_6_0)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.bigBtn_, nil, function()
		if arg_6_0.clickCallBack_ then
			arg_6_0.clickCallBack_(arg_6_0.id_, arg_6_0)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.lockBtn_, nil, function()
		if arg_6_0.lockClickCallBack_ then
			arg_6_0.lockClickCallBack_(arg_6_0.id_, arg_6_0)
		end
	end)
end

function var_0_0.RemoveListeners(arg_12_0)
	return
end

function var_0_0.RefreshData(arg_13_0)
	arg_13_0.isIllu_ = false
end

function var_0_0.RefreshUI(arg_14_0)
	arg_14_0:RefreshItem()
	arg_14_0:RefreshCollect()
	arg_14_0:RefreshIllShow()
end

function var_0_0.RefreshItem(arg_15_0)
	local var_15_0

	if arg_15_0.sizeState_ == 0 or arg_15_0.sizeState_ == 1 then
		local var_15_1 = ChapterClientCfg[arg_15_0.id_]

		arg_15_0.nameText_.text = GetI18NText(var_15_1.name)

		SetSpriteWithoutAtlasAsync(arg_15_0.img_, SpritePathCfg.CollectPlotBig.path .. var_15_1.chapter_paint)

		if var_15_1.toggle == BattleConst.TOGGLE.PLOT then
			arg_15_0.isLock_ = not ChapterTools.IsFinishPreChapter(arg_15_0.id_)

			arg_15_0.categoryController_:SetSelectedState("main")
			arg_15_0.lockController_:SetSelectedState(tostring(arg_15_0.isLock_))
		else
			arg_15_0.isLock_ = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_SUB_PLOT)

			arg_15_0.categoryController_:SetSelectedState("branch")

			arg_15_0.branchText_.text = GetI18NText(var_15_1.name)

			SetSpriteWithoutAtlasAsync(arg_15_0.branchImg_, SpritePathCfg.CollectPlotBig.path .. var_15_1.chapter_paint)
			arg_15_0.lockController_:SetSelectedState(tostring(arg_15_0.isLock_))
		end

		arg_15_0.collectPrecent_ = ChapterTools.GetChapterClientFinishPercentage(arg_15_0.id_)
		arg_15_0.storyProgress_.fillAmount = arg_15_0.collectPrecent_
		arg_15_0.storyProgressText_.text = string.format("%s%%", math.floor(arg_15_0.collectPrecent_ * 100))
	elseif arg_15_0.sizeState_ == 2 then
		local var_15_2 = ChapterClassCfg[arg_15_0.id_]

		if var_15_2.mid_type == 1 then
			arg_15_0.nameText_.text = GetI18NText(var_15_2.mid_name)

			SetSpriteWithoutAtlasAsync(arg_15_0.img_, SpritePathCfg.CollectPlotBig.path .. var_15_2.mid_pic)
			arg_15_0.categoryController_:SetSelectedState("main")
		else
			arg_15_0.categoryController_:SetSelectedState("branch")
		end

		arg_15_0.lockController_:SetSelectedState("false")
	elseif arg_15_0.sizeState_ == 3 then
		local var_15_3 = ChapterClassCfg[ChapterClassCfg.get_id_list_by_big_id[arg_15_0.id_][1]]

		arg_15_0.nameText2_.text = GetI18NText(var_15_3.big_name)

		SetSpriteWithoutAtlasAsync(arg_15_0.img2_, SpritePathCfg.ChapterPaint.path .. var_15_3.big_pic)
		arg_15_0.categoryController_:SetSelectedState("main")
		arg_15_0.lockController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshLock(arg_16_0)
	arg_16_0.lockController_:SetSelectedState(tostring(arg_16_0.isLock_))
end

function var_0_0.RefreshIllShow(arg_17_0)
	arg_17_0.illShowController_:SetSelectedState(tostring(arg_17_0.isIllu_))
end

function var_0_0.RefreshActivity(arg_18_0)
	return
end

function var_0_0.RefreshCollect(arg_19_0)
	return
end

function var_0_0.PlayAnimate(arg_20_0)
	return
end

function var_0_0.SetID(arg_21_0, arg_21_1)
	arg_21_0.id_ = arg_21_1
	arg_21_0.transform_.name = arg_21_1

	arg_21_0:RefreshData()
	arg_21_0:RefreshUI()
	arg_21_0:Show(true)
end

function var_0_0.SetLocalPosition(arg_22_0, arg_22_1)
	arg_22_0.transform_.localPosition = arg_22_1
end

function var_0_0.GetLocalPosition(arg_23_0)
	return arg_23_0.transform_.localPosition + arg_23_0.parent_.transform.localPosition
end

function var_0_0.Show(arg_24_0, arg_24_1)
	if arg_24_1 == false then
		arg_24_0.tempVector3_.x = 1000000000000
		arg_24_0.tempVector3_.y = 1000000000000
		arg_24_0.tempVector3_.z = 1000000000000

		arg_24_0:SetLocalPosition(arg_24_0.tempVector3_)
	else
		SetActive(arg_24_0.gameObject_, arg_24_1)
	end
end

function var_0_0.Scale(arg_25_0, arg_25_1)
	arg_25_0.tempVector3_.x = arg_25_1
	arg_25_0.tempVector3_.y = arg_25_1
	arg_25_0.tempVector3_.z = 1
	arg_25_0.transform_.localScale = arg_25_0.tempVector3_
end

function var_0_0.SetAlpha(arg_26_0, arg_26_1)
	return
end

function var_0_0.SetSizeState(arg_27_0, arg_27_1)
	arg_27_0.sizeState_ = arg_27_1

	arg_27_0.stateController_:SetSelectedState(arg_27_1)
end

function var_0_0.SetClickCallBack(arg_28_0, arg_28_1)
	arg_28_0.clickCallBack_ = arg_28_1
end

function var_0_0.SetLockClickCallBack(arg_29_0, arg_29_1)
	arg_29_0.lockClickCallBack_ = arg_29_1
end

function var_0_0.SetScale(arg_30_0, arg_30_1)
	arg_30_0.tempVector3_.x = arg_30_1
	arg_30_0.tempVector3_.y = arg_30_1
	arg_30_0.tempVector3_.z = 1
	arg_30_0.mainTrs_.localScale = arg_30_0.tempVector3_
end

function var_0_0.GetID(arg_31_0)
	return arg_31_0.id_
end

function var_0_0.IsLock(arg_32_0)
	return arg_32_0.isLock_
end

return var_0_0

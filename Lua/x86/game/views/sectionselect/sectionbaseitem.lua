local var_0_0 = class("SectionBaseItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.transform_.name = arg_1_3
	arg_1_0.stageID_ = arg_1_3
	arg_1_0.chapterID_ = arg_1_4

	arg_1_0:Init()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	SetActive(arg_2_0.gameObject_, true)

	arg_2_0.selectController_ = arg_2_0.controllerEx_:GetController("select")
	arg_2_0.isBossController_ = arg_2_0.controllerEx_:GetController("isBoss")
	arg_2_0.showStarController_ = arg_2_0.controllerEx_:GetController("showStar")
	arg_2_0.threeStarBarList_ = {}

	for iter_2_0 = 1, 3 do
		arg_2_0.threeStarBarList_[iter_2_0] = SectionThreeStarBar.New(arg_2_0[string.format("starGo%s_", iter_2_0)])
	end
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.itemBtn_, nil, function()
		arg_3_0:OnClick()
	end)
end

function var_0_0.Init(arg_5_0)
	arg_5_0:InitUI()
	arg_5_0:AddListeners()
	arg_5_0:RefreshData()
	arg_5_0:RefreshUI()
	arg_5_0:InitCustom()
end

function var_0_0.Dispose(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.threeStarBarList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.threeStarBarList_ = nil

	Object.Destroy(arg_6_0.gameObject_)

	arg_6_0.gameObject_ = nil
	arg_6_0.transform_ = nil
	arg_6_0.isShow_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.OnClick(arg_7_0)
	return
end

function var_0_0.ShowRedPoint(arg_8_0)
	SetActive(arg_8_0.noticeContainer_.gameObject, false)
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = arg_9_0:GetPosition()

	arg_9_0.transform_.localPosition = Vector3(var_9_0[1], var_9_0[2], 0)

	arg_9_0:RefreshText()
	arg_9_0:RefreshStar()

	if arg_9_0:GetTag() == BattleConst.BATTLE_TAG.BOSS then
		arg_9_0.isBossController_:SetSelectedState("true")
	else
		arg_9_0.isBossController_:SetSelectedState("false")
	end

	SetActive(arg_9_0.gameObject_, not arg_9_0.isLock_)
	arg_9_0:ShowRedPoint()
end

function var_0_0.GetTag(arg_10_0)
	return BattleConst.BATTLE_TAG.DEFAULT
end

function var_0_0.GetPosition(arg_11_0)
	return {
		0,
		0
	}
end

function var_0_0.InitCustom(arg_12_0)
	return
end

function var_0_0.RefreshStar(arg_13_0)
	return
end

function var_0_0.RefreshText(arg_14_0)
	arg_14_0.text_.text = ""
end

function var_0_0.GetLocalPosition(arg_15_0)
	return arg_15_0.transform_.localPosition
end

function var_0_0.SelectorItem(arg_16_0, arg_16_1)
	if arg_16_0.stageID_ == arg_16_1 and arg_16_0:IsOpenSectionInfo() then
		arg_16_0.selectController_:SetSelectedState("true")
	else
		arg_16_0.selectController_:SetSelectedState("false")
	end
end

function var_0_0.SetData(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.chapterID_ = arg_17_1
	arg_17_0.stageID_ = arg_17_2

	arg_17_0:RefreshData()
	arg_17_0:RefreshUI()
end

function var_0_0.Show(arg_18_0, arg_18_1)
	SetActive(arg_18_0.gameObject_, arg_18_1)
end

return var_0_0

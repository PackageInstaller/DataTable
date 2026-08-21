local var_0_0 = class("TetrisGameChooseStageItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.rectTransform = arg_1_1:GetComponent("RectTransform")

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statusController = arg_3_0.controller:GetController("state")
	arg_3_0.selController = arg_3_0.controller:GetController("sel")
	arg_3_0.chapterController = arg_3_0.controller:GetController("chapter")
	arg_3_0.skillShowController = arg_3_0.controller:GetController("skill")
	arg_3_0.animator = arg_3_0.gameObject_:GetComponent("Animator")
	arg_3_0.skillItemList = {}

	for iter_3_0 = 1, 2 do
		arg_3_0.skillItemList[iter_3_0] = TetrisGameSkillIconItem.New(arg_3_0["skillObj" .. iter_3_0])

		arg_3_0.skillItemList[iter_3_0]:RegisterClickFunc(handler(arg_3_0, arg_3_0.ClickSkillItem))
	end
end

function var_0_0.ClickSkillItem(arg_4_0, arg_4_1)
	JumpTools.OpenPageByJump("tetrisGameGetSkillView", {
		stageID = arg_4_0.stageID,
		skillID = arg_4_1
	})
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.stageID = arg_5_1

	if arg_5_0.stageID then
		arg_5_0.stageName.text = ActivityTetrisGameStageCfg[arg_5_1].desc
	end

	if arg_5_0.stageID == arg_5_2 then
		arg_5_0.selController:SetSelectedState("on")
	else
		arg_5_0.selController:SetSelectedState("off")
	end

	local var_5_0, var_5_1 = TetrisGameTools:GetStageState(arg_5_0.stageID)

	if var_5_0 == "lock" then
		arg_5_0.statusController:SetSelectedState("lock")
	elseif var_5_0 == "finish" then
		arg_5_0.statusController:SetSelectedState("finish")
	else
		arg_5_0.statusController:SetSelectedState("normal")
	end

	arg_5_0.chapterController:SetSelectedState(tostring(arg_5_3))
	arg_5_0:UpdataRedPoint()

	local var_5_2 = ActivityTetrisGameStageCfg[arg_5_1].skill_list

	for iter_5_0 = 1, 2 do
		local var_5_3 = var_5_2[iter_5_0]
		local var_5_4 = arg_5_0.skillItemList[iter_5_0]

		if var_5_3 then
			SetActive(var_5_4.gameObject_, true)
			var_5_4:RefreshUI(var_5_3)
		else
			SetActive(var_5_4.gameObject_, false)
		end
	end

	if #var_5_2 == 0 then
		arg_5_0.skillShowController:SetSelectedState("hide")
	else
		arg_5_0.skillShowController:SetSelectedState("show")
	end
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.clickBtn, nil, function()
		if arg_6_0.clickFunc then
			arg_6_0.clickFunc(arg_6_0.stageID)
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_STAGE, arg_6_0.stageID), 0)
	end)
end

function var_0_0.PlayAni(arg_8_0, arg_8_1)
	if arg_8_0.animator then
		if arg_8_1 then
			arg_8_0.animator:Play("UI_ItemA01_cx", -1, 0)
		else
			arg_8_0.animator:Play("UI_ItemA01_suoxiao", -1, 0)
		end
	end
end

function var_0_0.RegisterClick(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0.clickFunc = arg_9_1
	end
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)

	for iter_10_0, iter_10_1 in pairs(arg_10_0.skillItemList) do
		iter_10_1:Dispose()
	end

	Object.Destroy(arg_10_0.gameObject_)
end

function var_0_0.UpdataRedPoint(arg_11_0)
	if manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_STAGE, arg_11_0.stageID)) then
		manager.redPoint:SetRedPointIndependent(arg_11_0.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(arg_11_0.transform_, false)
	end
end

return var_0_0

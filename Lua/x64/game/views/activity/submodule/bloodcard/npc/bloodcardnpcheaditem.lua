local var_0_0 = class("BloodCardNpcHeadItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.index_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0.stateController_ = arg_2_0.controller_:GetController("HeadNPC")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.clickCallBack_ then
			arg_3_0.clickCallBack_(arg_3_0.npcID_)
		end
	end)
end

function var_0_0.CancelRedPoint(arg_5_0)
	if BloodCardData:GetUnPassNpc() == arg_5_0.npcID_ then
		saveData("bloodCard", "hasClickStage", 1)
		manager.redPoint:SetRedPointIndependent(arg_5_0.btn_.transform, false)

		local var_5_0 = string.format("%s_%s", RedPointConst.ACTIVITY_BLOOD_CARD_STAGE_UNLOCK, BloodCardData:GetMainActivityID())

		manager.redPoint:setTip(var_5_0, 0)
	end
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.npcID_ = arg_6_1
	arg_6_0.cfg_ = BloodCardGameNPCCfg[arg_6_0.npcID_]
	arg_6_0.activityID_ = BloodCardGameStageCfg[arg_6_0.cfg_.stage_list[1]].activity_id

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1)
	arg_7_0.nameText_.text = arg_7_0.cfg_.name
	arg_7_0.numText_.text = #arg_7_0.cfg_.stage_list
	arg_7_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/BackHouseUI/RoleHead/" .. arg_7_0.cfg_.icon)

	local var_7_0 = BloodCardData:GetUnPassNpc()
	local var_7_1 = getData("bloodCard", "hasClickStage") or 0

	if var_7_0 == arg_7_0.npcID_ and var_7_1 ~= 1 then
		manager.redPoint:SetRedPointIndependent(arg_7_0.btn_.transform, true)
	else
		manager.redPoint:SetRedPointIndependent(arg_7_0.btn_.transform, false)
	end
end

function var_0_0.SetClickCallBack(arg_8_0, arg_8_1)
	arg_8_0.clickCallBack_ = arg_8_1
end

function var_0_0.RefreshState(arg_9_0, arg_9_1)
	local var_9_0 = BloodCardData:GetNpcUnlock(arg_9_0.npcID_, arg_9_0.activityID_)
	local var_9_1 = arg_9_0.npcID_ == arg_9_1

	if not var_9_0 then
		arg_9_0.stateController_:SetSelectedState("lock")
	elseif var_9_1 then
		arg_9_0.stateController_:SetSelectedState("select")
	else
		arg_9_0.stateController_:SetSelectedState("normal")
	end

	if not var_9_0 and arg_9_0.npcID_ == 105 then
		arg_9_0.stateController_:SetSelectedState("gengchen")

		arg_9_0.nameText_.text = GetTips("ACTIVITY_BLOOD_CARD_SCRETE_NPC")
	end
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.clickCallBack_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0

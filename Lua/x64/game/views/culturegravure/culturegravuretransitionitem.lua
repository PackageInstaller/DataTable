local var_0_0 = class("CultureGravureTransitionItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController_ = arg_3_0.transCon_:GetController("state")
	arg_3_0.indexController_ = arg_3_0.transCon_:GetController("index")
	arg_3_0.iconList_ = {}
	arg_3_0.nameList_ = {}
	arg_3_0.btnList_ = {}

	for iter_3_0 = 1, 2 do
		arg_3_0.iconList_[iter_3_0] = arg_3_0["transitionImg_" .. iter_3_0]
		arg_3_0.nameList_[iter_3_0] = arg_3_0["transitionName_" .. iter_3_0]
		arg_3_0.btnList_[iter_3_0] = arg_3_0["transitionBtn_" .. iter_3_0]
	end

	arg_3_0.data_ = {
		{},
		{}
	}
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.getBtn_, nil, function()
		local var_5_0 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.TRANSITION)

		if var_5_0 then
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.TRANSITION, var_5_0))
		else
			JumpTools.OpenPageByJump("/transitionSkill", {
				index = arg_4_0.index_,
				heroID = arg_4_0.heroId_,
				type_ = HeroConst.HERO_DATA_TYPE.DEFAULT
			})
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.equipBtn_, nil, function()
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in ipairs(arg_4_0.recommendIdList_) do
			var_6_0[iter_6_0] = {
				skill_level = 3,
				skill_id = iter_6_1
			}
		end

		HeroAction.TryToSaveTransitionSkill(arg_4_0.heroId_, arg_4_0.index_, var_6_0)
	end)

	for iter_4_0 = 1, 2 do
		arg_4_0:AddBtnListener(arg_4_0.btnList_[iter_4_0], nil, function()
			local var_7_0 = arg_4_0.btnList_[iter_4_0].transform.position

			arg_4_0.callback_(arg_4_0.data_[iter_4_0].name, arg_4_0.data_[iter_4_0].desc, Vector3(var_7_0.x, var_7_0.y, var_7_0.z), arg_4_0.rightTrans_, true)
		end)
	end
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	arg_8_0.recommendIdList_ = arg_8_1
	arg_8_0.index_ = arg_8_2
	arg_8_0.transitionInfo_ = arg_8_3
	arg_8_0.heroId_ = arg_8_4

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.recommendIdList_) do
		local var_8_0 = EquipSkillCfg[iter_8_1]

		arg_8_0.iconList_[iter_8_0].sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. var_8_0.icon or "")
		arg_8_0.nameList_[iter_8_0].text = var_8_0.name
		arg_8_0.data_[iter_8_0].name = var_8_0.name
		arg_8_0.data_[iter_8_0].desc = EquipTools.GetSkillDescWithoutNext(iter_8_1, 3, arg_8_0.heroId_)
	end

	arg_8_0.indexController_:SetSelectedState(arg_8_2)
	arg_8_0:RefreshBtnState()
end

function var_0_0.RefreshBtnState(arg_9_0)
	if arg_9_0.transitionInfo_ and arg_9_0.transitionInfo_.talent_points >= 6 then
		arg_9_0.stateController_:SetSelectedState(arg_9_0:IsSameTransition() and "equiped" or "exchange")
	else
		arg_9_0.stateController_:SetSelectedState("get")
	end
end

function var_0_0.IsSameTransition(arg_10_0)
	local var_10_0 = true

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.recommendIdList_) do
		local var_10_1 = false

		for iter_10_2, iter_10_3 in ipairs(arg_10_0.transitionInfo_.skill_list) do
			if iter_10_3.skill_id == iter_10_1 then
				var_10_1 = true

				break
			end
		end

		var_10_0 = var_10_0 and var_10_1
	end

	return var_10_0
end

function var_0_0.SetClickCallBack(arg_11_0, arg_11_1)
	arg_11_0.callback_ = arg_11_1
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0

local var_0_0 = class("CultureGravureRecommendEquipItem", ReduxView)

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

	arg_3_0.positionController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "position")
	arg_3_0.starController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "star")
	arg_3_0.btnController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "state")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btnEquip_, nil, function()
		local var_5_0 = {
			heroId = arg_4_0.heroID_,
			recommendIdList = {
				[arg_4_0.index_] = arg_4_0.id_
			},
			stateList = {
				[arg_4_0.index_] = arg_4_0.state_
			},
			index = arg_4_0.index_
		}

		JumpTools.OpenPageByJump("cultureGravureEquipPopView", var_5_0)
	end)
	arg_4_0:AddBtnListener(arg_4_0.btnGet_, nil, function()
		ShowPopItemSource(arg_4_0.id_)
	end)
	arg_4_0:AddBtnListener(arg_4_0.btnShow_, nil, function()
		ShowPopItem(POP_OPERATE_ITEM, {
			arg_4_0.id_
		})
	end)
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	arg_8_0.index_ = arg_8_1
	arg_8_0.id_ = arg_8_2
	arg_8_0.heroID_ = arg_8_3
	arg_8_0.state_ = arg_8_4
	arg_8_0.cfg_ = EquipCfg[arg_8_2]

	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.icon_.spriteAsync = SpritePathCfg.EquipIcon_s.path .. ItemCfg[arg_9_0.id_].icon

	arg_9_0.positionController_:SetSelectedState(arg_9_0.cfg_.pos)
	arg_9_0.starController_:SetSelectedState(arg_9_0.cfg_.starlevel)
	arg_9_0.btnController_:SetSelectedState(arg_9_0.state_)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0

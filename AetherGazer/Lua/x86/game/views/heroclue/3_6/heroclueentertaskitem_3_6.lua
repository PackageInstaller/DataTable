local var_0_0 = import("game.views.heroClue.HeroClueEnterTaskItem")
local var_0_1 = class("HeroClueEnterTaskItem_3_6", var_0_0)

function var_0_1.InitController(arg_1_0)
	arg_1_0.statusController_ = arg_1_0.controllerEx_:GetController("state")
	arg_1_0.typeController_ = arg_1_0.controllerEx_:GetController("type")
end

function var_0_1.InitReward(arg_2_0)
	arg_2_0.rewardItem_ = CommonItemView.New(arg_2_0.rewardItem_, true)
	arg_2_0.itemData_ = clone(ItemTemplateData)

	function arg_2_0.itemData_.clickFun(arg_3_0)
		ShowPopItem(POP_ITEM, {
			arg_3_0.id,
			arg_3_0.number
		})
	end
end

return var_0_1

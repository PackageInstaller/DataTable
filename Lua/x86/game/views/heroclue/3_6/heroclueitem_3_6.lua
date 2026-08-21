local var_0_0 = import("game.views.heroClue.HeroClueItem")
local var_0_1 = class("HeroClueItem_3_6", var_0_0)

function var_0_1.InitController(arg_1_0)
	arg_1_0.statusController_ = arg_1_0.controllerEx_:GetController("level")
end

function var_0_1.RefreshUI(arg_2_0)
	arg_2_0.curData_ = HeroClueData:GetUnlockClueDataDic()[arg_2_0.clueID_]

	SetActive(arg_2_0.animGo_, false)
	arg_2_0:RefreshState()
	arg_2_0:RefreshIcon()
	arg_2_0:RefreshName()
	arg_2_0:RefreshProgress()
	arg_2_0:RefreshIndex()
end

function var_0_1.RefreshState(arg_3_0)
	if arg_3_0.curData_ == nil then
		arg_3_0.statusController_:SetSelectedIndex(0)
	else
		arg_3_0.statusController_:SetSelectedIndex(arg_3_0.curData_.level)
	end
end

function var_0_1.RefreshIcon(arg_4_0)
	if arg_4_0.curData_ then
		local var_4_0 = HeroClueCfg[arg_4_0.clueID_]

		if arg_4_0.curData_.level == 1 then
			arg_4_0.clueIcon_.sprite = pureGetSpriteWithoutAtlas(var_4_0.icon_path_1)
		elseif arg_4_0.curData_.level == 2 then
			arg_4_0.clueIcon_.sprite = pureGetSpriteWithoutAtlas(var_4_0.icon_path_2)
		else
			arg_4_0.clueIcon_.sprite = pureGetSpriteWithoutAtlas(var_4_0.icon_path_3)
		end
	end
end

function var_0_1.RefreshName(arg_5_0)
	if arg_5_0.curData_ and arg_5_0.curData_.level >= 2 then
		local var_5_0 = HeroClueCfg[arg_5_0.clueID_]

		arg_5_0.nameText_.text = var_5_0.name
	end
end

function var_0_1.RefreshProgress(arg_6_0)
	local var_6_0 = #HeroClueCfg[arg_6_0.clueID_].level
	local var_6_1 = 0

	if arg_6_0.curData_ and arg_6_0.curData_.level >= 1 then
		var_6_1 = arg_6_0.curData_.level
	end

	arg_6_0.progressText_.text = string.format("%d/%d", var_6_1, var_6_0)
end

function var_0_1.RefreshIndex(arg_7_0)
	if arg_7_0.index_ < 10 then
		arg_7_0.indexText_.text = "0" .. arg_7_0.index_
	else
		arg_7_0.indexText_.text = arg_7_0.index_
	end
end

function var_0_1.PlayAnim(arg_8_0, arg_8_1)
	SetActive(arg_8_0.animGo_, true)
	AnimatorTools.PlayAnimationWithCallback(arg_8_0.anim_, "unlock", function()
		SetActive(arg_8_0.animGo_, false)

		if arg_8_1 then
			arg_8_1()
		end
	end)
	arg_8_0.anim_:Update(0)
end

return var_0_1

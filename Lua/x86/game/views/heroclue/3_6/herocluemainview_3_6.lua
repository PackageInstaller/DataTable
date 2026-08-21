local var_0_0 = import("game.views.heroClue.HeroClueMainView")
local var_0_1 = class("HeroClueMainView_3_6", var_0_0)

function var_0_1.InitController(arg_1_0)
	arg_1_0.coinEnoughController_ = arg_1_0.controllerEx_:GetController("coinEnough")
end

function var_0_1.OnEnter(arg_2_0)
	var_0_1.super.OnEnter(arg_2_0)
	arg_2_0:ResetClueAnim()
end

function var_0_1.ResetClueAnim(arg_3_0)
	arg_3_0.playingClueAnim_ = false

	SetActive(arg_3_0.clueTrailEffectGo_, false)
end

function var_0_1.OnExit(arg_4_0)
	var_0_1.super.OnExit(arg_4_0)
	arg_4_0:StopAnim()
end

function var_0_1.RefreshCoin(arg_5_0)
	var_0_1.super.RefreshCoin(arg_5_0)
	arg_5_0:RefreshCoinEnough()
end

function var_0_1.RefreshCoinEnough(arg_6_0)
	local var_6_0 = HeroCluePoolCfg[arg_6_0.cluePoolID_].item_id
	local var_6_1 = ItemTools.getItemNum(var_6_0) >= HeroClueTools.GetCostOfOneDraw()

	arg_6_0.coinEnoughController_:SetSelectedState(tostring(var_6_1))
end

function var_0_1.OnClickDraw(arg_7_0)
	if arg_7_0.playingClueAnim_ then
		return
	end

	var_0_1.super.OnClickDraw(arg_7_0)
end

function var_0_1.OnClueDraw(arg_8_0, arg_8_1)
	arg_8_0:RefreshCoin()
	arg_8_0:PlayClueAnim(arg_8_1[1])
end

function var_0_1.PlayClueAnim(arg_9_0, arg_9_1)
	arg_9_0:InitClueAnim()

	local var_9_0 = arg_9_0:GetClueItem(arg_9_1)
	local var_9_1 = var_9_0:GetPosition()
	local var_9_2 = arg_9_0:CulculateClueTrailTime(var_9_1)

	arg_9_0:StartTween(var_9_1, var_9_2, function()
		SetActive(arg_9_0.clueTrailEffectGo_, false)
		arg_9_0:RefreshClue()
		var_9_0:PlayAnim(function()
			arg_9_0.playingClueAnim_ = false
		end)
	end)
end

function var_0_1.InitClueAnim(arg_12_0)
	arg_12_0.playingClueAnim_ = true

	SetActive(arg_12_0.clueTrailEffectGo_, true)
	arg_12_0.clueTrailEffectTrans_:SetPosition(arg_12_0.drawBtn_.transform:GetPosition())
end

function var_0_1.GetClueItem(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.clueItemList_) do
		if iter_13_1:GetClueID() == arg_13_1 then
			return iter_13_1
		end
	end
end

function var_0_1.CulculateClueTrailTime(arg_14_0, arg_14_1)
	local var_14_0 = (arg_14_0.clueItemList_[1]:GetPosition() - arg_14_0.drawBtn_.transform:GetPosition()):Magnitude()
	local var_14_1 = (arg_14_1 - arg_14_0.drawBtn_.transform:GetPosition()):Magnitude() / var_14_0 * 0.5

	print(var_14_1)

	return var_14_1
end

function var_0_1.StartTween(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0.clueTrailPosTween_ = LeanTween.move(arg_15_0.clueTrailEffectGo_, arg_15_1, arg_15_2):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
		arg_15_0:StopTween()

		if arg_15_3 then
			arg_15_3()
		end
	end))
end

function var_0_1.StopTween(arg_17_0)
	if arg_17_0.clueTrailPosTween_ then
		arg_17_0.clueTrailPosTween_:setOnComplete(nil)
		LeanTween.cancel(arg_17_0.clueTrailEffectGo_)

		arg_17_0.clueTrailPosTween_ = nil
	end
end

function var_0_1.StopAnim(arg_18_0)
	if arg_18_0.playingClueAnim_ then
		AnimatorTools.Stop()

		arg_18_0.playingClueAnim_ = false

		arg_18_0:StopTween()
	end
end

return var_0_1

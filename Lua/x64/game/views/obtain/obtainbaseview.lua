local var_0_0 = class("ObtainBaseView", BaseView)

function var_0_0.Init(arg_1_0)
	return
end

function var_0_0.OnClick(arg_2_0)
	if not arg_2_0.playableDirector_ then
		return true
	end

	if arg_2_0.playableDirector_.time == 0 or arg_2_0.playableDirector_.time >= arg_2_0:GetTimeLineEndTime() then
		return true
	else
		arg_2_0.playableDirector_.time = arg_2_0:GetTimeLineEndTime()

		arg_2_0.playableDirector_:Evaluate()

		return false
	end
end

function var_0_0.Skip2End(arg_3_0)
	if arg_3_0.playableDirector_ then
		arg_3_0.playableDirector_.time = arg_3_0:GetTimeLineEndTime()
	end
end

function var_0_0.HideShareUI(arg_4_0, arg_4_1)
	if arg_4_0.rebateGo_ then
		SetActive(arg_4_0.rebateGo_, false)
	end
end

function var_0_0.ShowShareUI(arg_5_0, arg_5_1)
	if arg_5_0.rebateGo_ and arg_5_1.draw_rebate and arg_5_1.draw_rebate ~= 0 then
		SetActive(arg_5_0.rebateGo_, true)
	end
end

function var_0_0.Show(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1.id

	if arg_6_0.gameObject_ then
		SetActive(arg_6_0.gameObject_, true)
	end

	if arg_6_0.playableDirector_ then
		arg_6_0.playableDirector_:Evaluate()
		arg_6_0.playableDirector_:Play()
	end

	arg_6_0:SetInfo(var_6_0, arg_6_2)
end

function var_0_0.Hide(arg_7_0)
	if arg_7_0.gameObject_ then
		SetActive(arg_7_0.gameObject_, false)
	end
end

function var_0_0.SetInfo(arg_8_0)
	return
end

function var_0_0.GetTimeLineEndTime(arg_9_0)
	return 0
end

function var_0_0.OnObtainHeroMovieAnimtionEvent(arg_10_0)
	return
end

function var_0_0.NeedHandleInput(arg_11_0)
	return false
end

function var_0_0.NeedHideShare(arg_12_0)
	return false
end

function var_0_0.NeedGaussianBg(arg_13_0)
	return false
end

return var_0_0

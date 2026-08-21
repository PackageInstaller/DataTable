local var_0_0 = class("CookGameJudgesController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._sceneTf = findTF(arg_1_1, "scene")
	arg_1_0._sceneBackground = findTF(arg_1_1, "scene_background")
	arg_1_0._sceneFrontTf = findTF(arg_1_1, "scene_front")
	arg_1_0._tpl = findTF(arg_1_0._sceneBackground, "judgeTpl")
	arg_1_0._gameData = arg_1_2
	arg_1_0._event = arg_1_3
	arg_1_0.initFlag = false
	arg_1_0.jiujiuTf = findTF(arg_1_0._sceneBackground, "jiujiuTime")
	arg_1_0.jiujiuAnim = GetComponent(findTF(arg_1_0.jiujiuTf, "anim"), typeof(Animator))

	setActive(arg_1_0._tpl, false)

	return
end

function var_0_0.init(arg_2_0)
	arg_2_0.initFlag = true
	arg_2_0._judgeDatas = {}

	for iter_2_0 = 1, #CookGameConst.judge_data do
		table.insert(arg_2_0._judgeDatas, {
			data = Clone(CookGameConst.judge_data[iter_2_0]),
			runtimeAnimator = LoadAny(arg_2_0._gameData.path, CookGameConst.judge_data[iter_2_0].name, typeof(RuntimeAnimatorController))
		})
	end

	arg_2_0.judges = {}

	for iter_2_1 = 1, CookGameConst.judge_num do
		local var_2_0 = iter_2_1
		local var_2_1 = tf(instantiate(arg_2_0._tpl))
		local var_2_2 = findTF(arg_2_0._sceneBackground, "judgesPos" .. iter_2_1).anchoredPosition

		setParent(var_2_1, arg_2_0._sceneTf)
		setActive(var_2_1, true)

		var_2_1.anchoredPosition = var_2_2

		local var_2_3 = CookGameJudge.New(var_2_1, iter_2_1, arg_2_0._judgeDatas, arg_2_0._gameData, arg_2_0._event)

		var_2_3:setFrontContainer(arg_2_0._sceneFrontTf)
		var_2_3:setClickCallback(function()
			arg_2_0:onJudgeClick(var_2_0)

			return
		end)
		table.insert(arg_2_0.judges, var_2_3)
	end

	arg_2_0._gameData.judges = arg_2_0.judges

	return
end

function var_0_0.changeSpeed(arg_4_0, arg_4_1)
	for iter_4_0 = 1, #arg_4_0.judges do
		arg_4_0.judges[iter_4_0]:changeSpeed(arg_4_1)
	end

	return
end

function var_0_0.serverIndex(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_1 and arg_5_1 < #arg_5_0.judges then
		arg_5_0.judges[arg_5_1]:server(arg_5_2, arg_5_3)
	else
		arg_5_3(false)
	end

	return
end

function var_0_0.onJudgeClick(arg_6_0, arg_6_1)
	for iter_6_0 = 1, #arg_6_0.judges do
		if iter_6_0 == arg_6_1 then
			arg_6_0.judges[iter_6_0]:select(true)
			arg_6_0._event:emit(CookGameView.CLICK_JUDGE_EVENT, arg_6_0.judges[arg_6_1], function(arg_7_0)
				if not arg_7_0 then
					arg_6_0.judges[iter_6_0]:select(false)
				end

				return
			end)
		else
			arg_6_0.judges[iter_6_0]:select(false)
		end
	end

	return
end

function var_0_0.start(arg_8_0)
	if not arg_8_0.initFlag then
		arg_8_0:init()
	end

	for iter_8_0 = 1, #arg_8_0.judges do
		arg_8_0.judges[iter_8_0]:start()
	end

	return
end

function var_0_0.step(arg_9_0, arg_9_1)
	for iter_9_0 = 1, #arg_9_0.judges do
		arg_9_0.judges[iter_9_0]:step(arg_9_1)
	end

	return
end

function var_0_0.clear(arg_10_0)
	for iter_10_0 = 1, #arg_10_0.judges do
		arg_10_0.judges[iter_10_0]:clear()
	end

	return
end

function var_0_0.extend(arg_11_0)
	if arg_11_0.jiujiuAnim then
		arg_11_0.jiujiuAnim:SetTrigger("extend")
	end

	return
end

function var_0_0.timeUp(arg_12_0)
	if arg_12_0.jiujiuAnim then
		arg_12_0.jiujiuAnim:SetTrigger("time_up")
	end

	return
end

return var_0_0

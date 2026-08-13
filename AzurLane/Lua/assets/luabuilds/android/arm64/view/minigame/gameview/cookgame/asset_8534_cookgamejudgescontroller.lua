class = var_0_10000

local var_0_0 = var_0_10000("CookGameJudgesController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	findTF = var_1_10004
	arg_1_0._sceneTf = var_1_10004(arg_1_1, "scene")
	findTF = var_4
	arg_1_0._sceneBackground = var_4(arg_1_1, "scene_background")
	findTF = var_4
	arg_1_0._sceneFrontTf = var_4(arg_1_1, "scene_front")
	findTF = var_4
	arg_1_0._tpl = var_4(arg_1_0._sceneBackground, "judgeTpl")
	arg_1_0._gameData = arg_1_2
	arg_1_0._event = arg_1_3
	arg_1_0.initFlag = false
	findTF = var_4
	arg_1_0.jiujiuTf = var_4(arg_1_0._sceneBackground, "jiujiuTime")
	GetComponent = var_4
	findTF = var_6

	local var_1_0 = var_6(arg_1_0.jiujiuTf, "anim")

	typeof = var_7
	Animator = var_9
	arg_1_0.jiujiuAnim = var_4(var_1_0, var_7(var_9))
	setActive = var_4

	var_4(arg_1_0._tpl, false)

	return
end

function var_0_0.init(arg_2_0)
	arg_2_0.initFlag = true
	arg_2_0._judgeDatas = {}

	local var_2_0 = 1

	CookGameConst = var_1_10002

	for iter_2_0 = var_2_0, #var_1_10002.judge_data do
		CookGameConst = var_1_10005
		var_1_10005 = var_1_10005.judge_data[iter_2_0]
		LoadAny = var_1_10006
		var_1_10008 = arg_2_0._gameData.path

		local var_2_1 = var_1_10005.name

		typeof = var_1_10010
		RuntimeAnimatorController = var_1_10012
		var_1_10006 = var_1_10006(var_1_10008, var_2_1, var_1_10010(var_1_10012))
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_2_2 = arg_2_0._judgeDatas

		var_1_10010 = {}
		Clone = var_1_10011
		var_1_10010.data = var_1_10011(var_1_10005)
		var_1_10010.runtimeAnimator = var_1_10006

		var_1_10007(var_2_2, var_1_10010)
	end

	arg_2_0.judges = {}

	local var_2_3 = 1

	CookGameConst = var_2

	for iter_2_1 = var_2_3, var_2.judge_num do
		local var_2_4 = iter_2_1

		tf = var_1_10006
		instantiate = var_1_10008
		var_1_10006 = var_1_10006(var_1_10008(arg_2_0._tpl))
		findTF = var_1_10007
		var_1_10007 = var_1_10007(arg_2_0._sceneBackground, "judgesPos" .. iter_2_1).anchoredPosition
		setParent = var_1_10008

		var_1_10008(var_1_10006, arg_2_0._sceneTf)

		setActive = var_1_10008

		var_1_10008(var_1_10006, true)

		var_1_10006.anchoredPosition = var_1_10007
		CookGameJudge = var_1_10008

		local var_2_5 = var_1_10008.New(var_1_10006, var_2_4, arg_2_0._judgeDatas, arg_2_0._gameData, arg_2_0._event)

		var_1_10008.setFrontContainer(var_2_5, arg_2_0._sceneFrontTf)
		var_1_10008:setClickCallback(function()
			local var_3_0 = arg_2_0

			var_0.onJudgeClick(var_3_0, var_2_4)

			return
		end)

		table = var_9

		var_9.insert(arg_2_0.judges, var_1_10008)
	end

	arg_2_0._gameData.judges = arg_2_0.judges

	return
end

function var_0_0.changeSpeed(arg_4_0, arg_4_1)
	for iter_4_0 = 1, #arg_4_0.judges do
		local var_4_0 = arg_4_0.judges[iter_4_0]

		var_6.changeSpeed(var_4_0, arg_4_1)
	end

	return
end

function var_0_0.serverIndex(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_1 and arg_5_1 < #arg_5_0.judges then
		local var_5_0 = arg_5_0.judges[arg_5_1]

		var_4.server(var_5_0, arg_5_2, arg_5_3)
	else
		arg_5_3(false)
	end

	return
end

function var_0_0.onJudgeClick(arg_6_0, arg_6_1)
	for iter_6_0 = 1, #arg_6_0.judges do
		if iter_6_0 == arg_6_1 then
			local var_6_0 = arg_6_0.judges[iter_6_0]

			var_6.select(var_6_0, true)

			local var_6_1 = arg_6_0._event
			local var_6_2 = var_6.emit

			CookGameView = var_9

			var_6_2(var_6_1, var_9.CLICK_JUDGE_EVENT, arg_6_0.judges[arg_6_1], function(arg_7_0)
				if not arg_7_0 then
					local var_7_0 = arg_6_0.judges[iter_6_0]

					var_1.select(var_7_0, false)
				end

				return
			end)
		else
			local var_6_3 = arg_6_0.judges[iter_6_0]

			var_6.select(var_6_3, false)
		end
	end

	return
end

function var_0_0.start(arg_8_0)
	if not arg_8_0.initFlag then
		arg_8_0:init()
	end

	for iter_8_0 = 1, #arg_8_0.judges do
		local var_8_0 = arg_8_0.judges[iter_8_0]

		var_5.start(var_8_0)
	end

	return
end

function var_0_0.step(arg_9_0, arg_9_1)
	for iter_9_0 = 1, #arg_9_0.judges do
		local var_9_0 = arg_9_0.judges[iter_9_0]

		var_6.step(var_9_0, arg_9_1)
	end

	return
end

function var_0_0.clear(arg_10_0)
	for iter_10_0 = 1, #arg_10_0.judges do
		local var_10_0 = arg_10_0.judges[iter_10_0]

		var_5.clear(var_10_0)
	end

	return
end

function var_0_0.extend(arg_11_0)
	if arg_11_0.jiujiuAnim then
		local var_11_0 = arg_11_0.jiujiuAnim

		var_1.SetTrigger(var_11_0, "extend")
	end

	return
end

function var_0_0.timeUp(arg_12_0)
	if arg_12_0.jiujiuAnim then
		local var_12_0 = arg_12_0.jiujiuAnim

		var_1.SetTrigger(var_12_0, "time_up")
	end

	return
end

return var_0_0

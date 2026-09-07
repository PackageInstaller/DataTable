local CookGameJudgesController = class("CookGameJudgesController")

function CookGameJudgesController:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._sceneTf = findTF(arg_1_1, "scene")
	self._sceneBackground = findTF(arg_1_1, "scene_background")
	self._sceneFrontTf = findTF(arg_1_1, "scene_front")
	self._tpl = findTF(self._sceneBackground, "judgeTpl")
	self._gameData = arg_1_2
	self._event = arg_1_3
	self.initFlag = false
	self.jiujiuTf = findTF(self._sceneBackground, "jiujiuTime")
	self.jiujiuAnim = GetComponent(findTF(self.jiujiuTf, "anim"), typeof(Animator))

	setActive(self._tpl, false)

	return
end

function CookGameJudgesController:init()
	self.initFlag = true
	self._judgeDatas = {}

	for iter_2_0 = 1, #CookGameConst.judge_data do
		table.insert(self._judgeDatas, {
			data = Clone(CookGameConst.judge_data[iter_2_0]),
			runtimeAnimator = LoadAny(self._gameData.path, CookGameConst.judge_data[iter_2_0].name, typeof(RuntimeAnimatorController))
		})
	end

	self.judges = {}

	for iter_2_1 = 1, CookGameConst.judge_num do
		local var_2_0 = iter_2_1
		local var_2_1 = tf(instantiate(self._tpl))
		local var_2_2 = findTF(self._sceneBackground, "judgesPos" .. iter_2_1).anchoredPosition

		setParent(var_2_1, self._sceneTf)
		setActive(var_2_1, true)

		var_2_1.anchoredPosition = var_2_2

		local var_2_3 = CookGameJudge.New(var_2_1, iter_2_1, self._judgeDatas, self._gameData, self._event)

		var_2_3:setFrontContainer(self._sceneFrontTf)
		var_2_3:setClickCallback(function()
			self:onJudgeClick(var_2_0)

			return
		end)
		table.insert(self.judges, var_2_3)
	end

	self._gameData.judges = self.judges

	return
end

function CookGameJudgesController:changeSpeed(arg_4_1)
	for iter_4_0 = 1, #self.judges do
		self.judges[iter_4_0]:changeSpeed(arg_4_1)
	end

	return
end

function CookGameJudgesController:serverIndex(arg_5_1, arg_5_2, arg_5_3)
	if arg_5_1 and arg_5_1 < #self.judges then
		self.judges[arg_5_1]:server(arg_5_2, arg_5_3)
	else
		arg_5_3(false)
	end

	return
end

function CookGameJudgesController:onJudgeClick(arg_6_1)
	for iter_6_0 = 1, #self.judges do
		if iter_6_0 == arg_6_1 then
			self.judges[iter_6_0]:select(true)
			self._event:emit(CookGameView.CLICK_JUDGE_EVENT, self.judges[arg_6_1], function(arg_7_0)
				if not arg_7_0 then
					self.judges[iter_6_0]:select(false)
				end

				return
			end)
		else
			self.judges[iter_6_0]:select(false)
		end
	end

	return
end

function CookGameJudgesController:start()
	if not self.initFlag then
		self:init()
	end

	for iter_8_0 = 1, #self.judges do
		self.judges[iter_8_0]:start()
	end

	return
end

function CookGameJudgesController:step(arg_9_1)
	for iter_9_0 = 1, #self.judges do
		self.judges[iter_9_0]:step(arg_9_1)
	end

	return
end

function CookGameJudgesController:clear()
	for iter_10_0 = 1, #self.judges do
		self.judges[iter_10_0]:clear()
	end

	return
end

function CookGameJudgesController:extend()
	if self.jiujiuAnim then
		self.jiujiuAnim:SetTrigger("extend")
	end

	return
end

function CookGameJudgesController:timeUp()
	if self.jiujiuAnim then
		self.jiujiuAnim:SetTrigger("time_up")
	end

	return
end

return CookGameJudgesController

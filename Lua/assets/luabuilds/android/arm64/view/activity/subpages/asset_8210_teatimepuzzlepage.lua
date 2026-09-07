local TeaTimePuzzlePage = class("TeaTimePuzzlePage", import("...base.BaseActivityPage"))

function TeaTimePuzzlePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.total = 15
	self.Text = self._tf:Find("AD/Text"):GetComponent(typeof(Text))
	self.container = self._tf:Find("AD/container")
	self.GOBtn = self._tf:Find("AD/go")
	self.got = self._tf:Find("AD/got")

	return
end

function TeaTimePuzzlePage:OnFirstFlush()
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(self.activity:getData1List() or {}) do
		local var_2_1 = iter_2_1 - 24

		assert(iter_2_1 - 24 > 0, "puzzlaIndex should more than zero" .. iter_2_1)
		table.insert(var_2_0, var_2_1)
	end

	local var_2_2 = {}

	if self.activity:left4Day() then
		for iter_2_2 = 1, self.total do
			table.insert(var_2_2, pg.gametip["activity_puzzle_get" .. iter_2_2].tip)
		end
	end

	local var_2_3 = getProxy(TaskProxy)
	local var_2_4 = getProxy(ActivityProxy)

	onButton(self, self.GOBtn, function()
		local var_3_0 = var_2_4:getActivityById(ActivityConst.TEATIME_TW)

		if not var_3_0 or var_3_0:isEnd() then
			return
		end

		local var_3_1 = var_3_0:getConfig("config_data")
		local var_3_2 = false

		for iter_3_0, iter_3_1 in pairs((var_2_3:getTasks())) do
			if _.any(_.flatten(var_3_1), function(arg_4_0)
				return arg_4_0 == iter_3_1.id
			end) then
				var_3_2 = true

				break
			end
		end

		if var_3_2 then
			self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
				page = "activity"
			})
		else
			self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.NAVALACADEMYSCENE)
		end

		return
	end, SFX_PANEL)

	local var_2_5 = var_2_3:getTasks()
	local var_2_6 = var_2_4:getActivityById(ActivityConst.TEATIME_TW):isEnd()

	setActive(self.GOBtn, not var_2_6)
	setActive(self.got, var_2_6)

	self.Text.text = "<color=#A9F548FF>" .. #var_2_0 .. "</color>/" .. self.total
	self.puzzlaView = PuzzlaView.New({
		bg = "bg_1",
		go = self.container,
		list = var_2_0,
		descs = var_2_2,
		fetch = self.activity.data1 == 1
	}, nil)

	function self.puzzlaView.onFinish()
		if self.activity.data1 ~= 1 then
			self:emit(ActivityMediator.EVENT_OPERATION, {
				cmd = 1,
				activity_id = self.activity.id
			})
		end

		return
	end

	return
end

function TeaTimePuzzlePage:OnDestroy()
	clearImageSprite(self.bg)

	if self.puzzlaView then
		self.puzzlaView:dispose()
	end

	return
end

return TeaTimePuzzlePage

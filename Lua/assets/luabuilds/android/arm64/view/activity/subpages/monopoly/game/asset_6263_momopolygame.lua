local MonopolyGame = class("MonopolyGame")
local var_0_1 = pg.activity_event_monopoly_map
local var_0_2 = pg.activity_event_monopoly_event
local var_0_3 = 501041
local var_0_4 = 501041
local var_0_5 = 6
local var_0_6 = 5
local var_0_7 = {}

var_0_7.stateGold = "dafuweng_gold"
var_0_7.stateOil = "dafuweng_oil"
var_0_7.stateEvent = "dafuweng_event"
var_0_7.stateWalk = "dafuweng_walk"
var_0_7.stateStand = "dafuweng_stand"
var_0_7.stateJump = "dafuweng_jump"
var_0_7.stateRun = "dafuweng_run"
var_0_7.stateTouch = "dafuweng_touch"

local function var_0_10(arg_6_0)
	return {
		onMove = function(arg_7_0, arg_7_1)
			return
		end,
		onJump = function(arg_8_0, arg_8_1)
			return
		end,
		onUpdatePos = function(arg_9_0)
			return
		end,
		ship = Ship.New({
			configId = arg_6_0,
			skin_id = var_0_4
		}),
		state = var_0_8(),
		Move = function(self, arg_10_1, arg_10_2, arg_10_3)
			arg_10_2 = arg_10_2 or function()
				return
			end

			if #arg_10_1 == 0 then
				arg_10_2()

				return
			end

			local function var_10_0(arg_12_0)
				if arg_12_0 then
					self.state:ChangeState(var_0_7.stateWalk)
				else
					self.state:ChangeState(var_0_7.stateRun)
				end

				self.onMove(arg_10_1, function()
					local var_13_0 = self:GetAction(arg_10_1[#arg_10_1])

					if var_13_0 then
						self.state:ChangeState(var_13_0, function()
							self.state:ChangeState(var_0_7.stateStand)
							arg_10_2()

							return
						end)
					else
						self.state:ChangeState(var_0_7.stateStand)
						arg_10_2()
					end

					return
				end)

				return
			end

			if #arg_10_1 <= 3 and not arg_10_3 then
				self:Jump(arg_10_1, arg_10_2)
			else
				var_10_0(arg_10_3)
			end

			return
		end,
		Jump = function(arg_15_0, arg_15_1, arg_15_2)
			arg_15_2 = arg_15_2 or function()
				return
			end

			if #arg_15_1 == 0 then
				arg_15_2()

				return
			end

			local var_15_0 = {}

			for iter_15_0, iter_15_1 in pairs(arg_15_1) do
				table.insert(var_15_0, function(arg_17_0)
					arg_15_0.state:ChangeState(var_0_7.stateJump)
					arg_15_0.onJump(iter_15_1, function()
						arg_15_0.state:ChangeState(var_0_7.stateStand)
						arg_17_0()

						return
					end)

					return
				end)
			end

			seriesAsync(var_15_0, function()
				local var_19_0 = arg_15_0:GetAction(arg_15_1[#arg_15_1])

				if var_19_0 then
					arg_15_0.state:ChangeState(var_19_0, function()
						arg_15_0.state:ChangeState(var_0_7.stateStand)
						arg_15_2()

						return
					end)
				else
					arg_15_0.state:ChangeState(var_0_7.stateStand)
					arg_15_2()
				end

				return
			end)

			return
		end,
		Touch = function(self)
			if self.state:IsStandState() then
				self.state:ChangeState(var_0_7.stateTouch, function()
					self.state:ChangeState(var_0_7.stateStand)

					return
				end)
			end

			return
		end,
		GetAction = function(arg_23_0, arg_23_1)
			if arg_23_1.config.icon == "icon_1" then
				return var_0_7.stateEvent
			elseif arg_23_1.config.icon == "icon_2" then
				return var_0_7.stateGold
			elseif arg_23_1.config.icon == "icon_3" then
				-- block empty
			elseif arg_23_1.config.icon == "icon_4" then
				return var_0_7.stateEvent
			elseif arg_23_1.config.icon == "icon_5" then
				return var_0_7.stateOil
			elseif arg_23_1.config.icon == "icon_6" then
				return var_0_7.stateEvent
			end

			return
		end,
		InitPos = function(self, arg_24_1)
			self:ChangePos(arg_24_1)
			self.state:ChangeState(var_0_7.stateStand)

			return
		end,
		ChangePos = function(self, arg_25_1)
			assert(arg_25_1)
			self.onUpdatePos(arg_25_1)

			return
		end,
		Dispose = function(arg_26_0)
			arg_26_0.onMove = nil
			arg_26_0.onUpdatePos = nil

			return
		end
	}
end

local function var_0_11(arg_27_0)
	return {
		id = arg_27_0,
		config = var_0_2[arg_27_0],
		ExistStory = function(self)
			return self.config.story and self.config.story ~= "0"
		end,
		isEmpty = function(self)
			return self.config.story == "0" and self.config.drop == 0 and #self.config.effect == 0
		end,
		Dispose = function(arg_30_0)
			arg_30_0.config = nil

			return
		end
	}
end

local function var_0_12(arg_31_0)
	local var_31_0 = {}

	var_31_0.row, var_31_0.column = arg_31_0.pos[1], arg_31_0.pos[2]
	var_31_0.index = arg_31_0.index
	var_31_0.id = arg_31_0.id
	var_31_0.flag = arg_31_0.flag

	assert(var_31_0.id)

	var_31_0.config = var_0_1[var_31_0.id]
	var_31_0.events = {}

	for iter_31_0, iter_31_1 in ipairs(var_0_2.all) do
		if not table.contains(var_31_0.events, iter_31_1) then
			table.insert(var_31_0.events, var_0_11(iter_31_1))
		end
	end

	function var_31_0:GetEvent(arg_32_1)
		for iter_32_0, iter_32_1 in ipairs(self.events) do
			if iter_32_1.id == arg_32_1 then
				return iter_32_1
			end
		end

		return
	end

	function var_31_0.SetNext(arg_33_0, arg_33_1)
		arg_33_0.next = arg_33_1

		return
	end

	function var_31_0:Dispose()
		for iter_34_0, iter_34_1 in ipairs(self.events) do
			iter_34_1:Dispose()
		end

		return
	end

	return var_31_0
end

local function var_0_13(arg_35_0, arg_35_1)
	local var_35_0 = {
		ROW = var_0_5,
		COLUMN = var_0_6 - 2,
		cellIds = arg_35_0,
		path = {}
	}

	var_35_0.char = nil
	var_35_0.index = arg_35_1

	function var_35_0.onCreateCell(arg_36_0)
		return
	end

	function var_35_0.onCreateChar(arg_37_0)
		return
	end

	function var_35_0:Init()
		for iter_38_0 = 0, var_35_0.ROW - 1 do
			var_35_0:CeateCell({
				0,
				iter_38_0
			}, 0)
		end

		for iter_38_1 = 1, var_35_0.COLUMN do
			var_35_0:CeateCell({
				iter_38_1,
				var_35_0.ROW - 1
			}, #self.path)
		end

		for iter_38_2 = var_35_0.ROW - 1, 0, -1 do
			var_35_0:CeateCell({
				var_35_0.COLUMN + 1,
				iter_38_2
			}, #self.path)
		end

		for iter_38_3 = var_35_0.COLUMN, 1, -1 do
			var_35_0:CeateCell({
				iter_38_3,
				0
			}, #self.path - 1)
		end

		self:CreateChar(var_0_3)

		return
	end

	function var_35_0:CreateChar(arg_39_1)
		self.char = var_0_10(arg_39_1)

		self.onCreateChar(self.char)
		self.char:InitPos((self:GetCell(self.index)))

		return
	end

	function var_35_0:CeateCell(arg_40_1, arg_40_2)
		local var_40_0 = var_0_12({
			pos = arg_40_1,
			index = #self.path + 1,
			id = self.cellIds[#self.path + 1],
			flag = arg_40_2
		})

		if #self.path == 0 then
			var_40_0.SetNext(var_40_0, var_40_0)
		else
			self.path[#self.path]:SetNext(var_40_0)
			var_40_0:SetNext(self.path[1])
		end

		table.insert(self.path, var_40_0)
		self.onCreateCell(var_40_0)

		return
	end

	function var_35_0:GetPath()
		return self.path
	end

	function var_35_0:GetChar()
		return self.char
	end

	function var_35_0.GetPathCell(arg_43_0, arg_43_1)
		return _.map(arg_43_1, function(arg_44_0)
			return arg_43_0.path[arg_44_0]
		end)
	end

	function var_35_0:UpdateCharPos(arg_45_1, arg_45_2, arg_45_3)
		self.char:Move(self:GetPathCell(arg_45_1), arg_45_2, arg_45_3)

		self.index = arg_45_1[#arg_45_1]

		return
	end

	function var_35_0:GetCell(arg_46_1)
		return self.path[arg_46_1]
	end

	function var_35_0:GetPos()
		return self.index
	end

	function var_35_0:Dispose()
		for iter_48_0, iter_48_1 in ipairs(self.path) do
			iter_48_1:Dispose()
		end

		self.char:Dispose()

		self.onCreateCell = nil
		self.onCreateChar = nil

		return
	end

	return var_35_0
end

local function var_0_14(arg_49_0, arg_49_1)
	local var_49_0 = {
		_tf = arg_49_0,
		_img = arg_49_0:GetComponent(typeof(Image)),
		cell = arg_49_1,
		interval = Vector2(0, 0),
		startPos = Vector2(0, 0),
		offset = Vector2(arg_49_0.rect.width * 0.5 + 2.5, arg_49_0.rect.height * 0.5 - 2),
		GetGenPos = function(self)
			return Vector3(self.startPos.x + self.cell.column * self.offset.x + self.cell.row * self.offset.x, self.startPos.y + self.cell.column * self.offset.y + self.cell.row * -self.offset.y, 0)
		end,
		UpdateStyle = function(self)
			self._img.sprite = GetSpriteFromAtlas("ui/activityuipage/monopolycar_atlas", self.cell.config.icon)

			self._img:SetNativeSize()

			return
		end,
		Dispose = function(arg_52_0)
			return
		end
	}

	setAnchoredPosition(arg_49_0, var_49_0:GetGenPos())
	var_49_0._tf:SetSiblingIndex(arg_49_1.flag)

	return var_49_0
end

local function var_0_15(arg_53_0, arg_53_1)
	local var_53_0 = {
		_tf = arg_53_0
	}

	var_53_0.WalkSpeed = 1
	var_53_0.RunSpeed = 0.5
	var_53_0.jumpSpeed = 0.5
	var_53_0.char = arg_53_1

	local var_53_1 = arg_53_0:GetChild(0)

	tf(var_53_1).localScale = Vector3(0.5, 0.5, 0.5)
	var_53_0.SpineAnimUI = var_53_1:GetComponent("SpineAnimUI")

	local var_53_2 = GameObject("mouseChild")

	tf(var_53_2):SetParent(tf(var_53_1))

	tf(var_53_2).localPosition = Vector3.zero

	setParent(var_53_2, var_53_1)

	GetOrAddComponent(var_53_2, "Image").color = Color.New(0, 0, 0, 0)

	local var_53_3 = var_53_2:GetComponent(typeof(RectTransform))

	var_53_3.sizeDelta = Vector2(3, 3)
	var_53_3.pivot = Vector2(0.5, 0)
	var_53_3.anchoredPosition = Vector2(0, 0)

	onButton(nil, var_53_2, function()
		var_53_0.char:Touch()

		return
	end)

	function var_53_0.Action(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
		local var_55_0 = {}

		_.each(arg_55_1, function(arg_56_0)
			table.insert(var_55_0, function(arg_57_0)
				arg_55_0:UpdateScale(arg_56_0)

				local var_57_0 = arg_56_0:GetGenPos()

				if arg_55_0._tf.localPosition == var_57_0 then
					arg_57_0()
				else
					LeanTween.moveLocal(go(arg_55_0._tf), var_57_0, arg_55_3):setOnComplete(System.Action(function()
						arg_55_0.preCellTF = arg_56_0

						arg_57_0()

						return
					end))
				end

				return
			end)

			return
		end)
		seriesAsync(var_55_0, function()
			if arg_55_2 then
				arg_55_2()
			end

			return
		end)

		return
	end

	function var_53_0:Move(arg_60_1, arg_60_2)
		if #arg_60_1 > 3 then
			self:Action(arg_60_1, arg_60_2, self.RunSpeed)
		else
			self:Action(arg_60_1, arg_60_2, self.WalkSpeed)
		end

		return
	end

	function var_53_0:Jump(arg_61_1, arg_61_2)
		self:Action({
			arg_61_1
		}, function()
			arg_61_2()
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_STEP_MONOPOLY)

			return
		end, self.jumpSpeed)

		return
	end

	function var_53_0:UpdatePos(arg_63_1)
		self.preCellTF = arg_63_1
		self._tf.localPosition = arg_63_1:GetGenPos()

		return
	end

	function var_53_0:UpdateScale(arg_64_1)
		local var_64_0 = 1

		self.preCellTF = self.preCellTF or arg_64_1

		if arg_64_1.cell.row > self.preCellTF.cell.row or arg_64_1.cell.column > self.preCellTF.cell.column then
			var_64_0 = 1
		elseif arg_64_1.cell.row < self.preCellTF.cell.row or arg_64_1.cell.column < self.preCellTF.cell.column then
			var_64_0 = -1
		end

		self._tf.localScale = Vector3(var_64_0, 1, 1)

		return
	end

	function var_53_0:ChangeAction(arg_65_1, arg_65_2)
		self.SpineAnimUI:SetActionCallBack(nil)
		self.SpineAnimUI:SetAction(arg_65_1, 0)
		self.SpineAnimUI:SetActionCallBack(function(arg_66_0)
			if arg_66_0 == "finish" then
				self.SpineAnimUI:SetActionCallBack(nil)
				arg_65_2()
			end

			return
		end)

		return
	end

	function var_53_0:Dispose()
		self.SpineAnimUI:SetActionCallBack(nil)

		self.char.onMove = nil

		if self.timer then
			self.timer:Stop()

			self.timer = nil
		end

		return
	end

	return var_53_0
end

function MonopolyGame:SetUp(arg_68_1, arg_68_2)
	self.viewComponent = arg_68_1

	pg.DelegateInfo.New(self)

	self._tf = self.viewComponent._tf
	self._go = go(self.viewComponent._tf)
	self.models = {}

	parallelAsync({
		function(arg_69_0)
			local var_69_0 = Ship.New({
				configId = var_0_3,
				skin_id = var_0_4
			})

			PoolMgr.GetInstance():GetSpineChar(var_69_0:getPrefab(), true, function(arg_70_0)
				self.models[var_69_0.configId] = arg_70_0

				arg_69_0()

				return
			end)

			return
		end,
		function(arg_71_0)
			onNextTick(arg_71_0)

			return
		end
	}, function()
		self:setActivity(arg_68_2)
		self:init()
		self:didEnter()

		return
	end)

	return
end

function MonopolyGame:setActivity(arg_73_1)
	self.activity = arg_73_1
	self.useCount = self.activity.data1_list[2]

	local var_73_0 = self.activity.data1_list[3] - 1
	local var_73_1 = self.activity.data2_list[1]
	local var_73_2 = self.activity.data2_list[2]

	self.pos = self.activity.data2
	self.step = self.activity.data3
	self.effectId = self.activity.data4
	self.totalCnt = math.ceil((pg.TimeMgr.GetInstance():GetServerTime() - self.activity.data1) / 0) * self.activity:getDataConfig("daily_time") + self.activity.data1_list[1]
	self.leftCount = self.totalCnt - self.useCount

	local var_73_3 = arg_73_1:getDataConfig("reward_time")

	self.nextredPacketStep = var_73_3 - self.useCount % var_73_3
	self.advanceTotalCnt = #arg_73_1:getDataConfig("reward")
	self.isAdvanceRp = self.advanceTotalCnt - var_73_2 > 0
	self.leftAwardCnt = var_73_1 - var_73_2
	self.advanceRpCount = math.max(0, math.min(var_73_1, self.advanceTotalCnt) - var_73_2)
	self.commonRpCount = math.max(0, var_73_1 - self.advanceTotalCnt) - math.max(0, var_73_2 - self.advanceTotalCnt)
	self.leftDropShipCnt = 10 - var_73_0

	return
end

function MonopolyGame:NetActivity(arg_74_1)
	self:setActivity(arg_74_1)
	self:updateLeftCount()
	self:updateNextRedPacketStep()

	return
end

function MonopolyGame:init()
	self:blockAllEvent(false)

	self.bg = self._tf:Find("AD")
	self.mapCellTpl = self:getTpl("mapCell", self.bg)
	self.mapContainer = self.bg:Find("mapContainer")
	self.charTpl = self:getTpl("char", self.bg)
	self.startBtn = self.bg:Find("start")
	self.valueImg = self.bg:Find("value"):GetComponent(typeof(Image))
	self.leftcountLabel = self.bg:Find("leftcount"):GetComponent(typeof(Text))
	self.leftCountTF = self.bg:Find("leftcount/Text"):GetComponent(typeof(Text))
	self.nextRedPacketStepTF = self.bg:Find("nextRpStep/Text"):GetComponent(typeof(Text))
	self.commonRp = self.bg:Find("rp")
	self.commonAnim = self.commonRp:GetComponent(typeof(Animator))
	self.commonRpCnt = self.bg:Find("rp_text/Text"):GetComponent(typeof(Text))
	self.dropShipTxt = self._tf:Find("AD/drop_ship_text"):GetComponent(typeof(Text))
	self.helpBtn = self._tf:Find("AD/help")
	self.anim = self._tf:Find("AD/anim")

	setActive(self.anim, false)

	self.leftcountLabel.text = i18n("monopoly_left_count")
	self.advanceTag = self._tf:Find("AD/rp/sp")
	self.advanceLabel = self._tf:Find("AD/rp_text/sp")
	self.advancecLabel = self._tf:Find("AD/rp_text/label")
	self.advanceImage = self._tf:Find("AD/rp_text/sp_img")
	self.advanceTxt = self._tf:Find("AD/rp_text/sp_img/Text"):GetComponent(typeof(Text))

	return
end

function MonopolyGame:updateNextRedPacketStep()
	self.nextRedPacketStepTF.text = self.nextredPacketStep

	return
end

function MonopolyGame:updateLeftCount()
	self.leftCountTF.text = self.leftCount

	self.commonAnim:SetInteger("count", self.leftAwardCnt)

	self.commonRpCnt.text = self.commonRpCount

	return
end

function MonopolyGame:updateValue(arg_78_1)
	if arg_78_1 ~= 0 then
		self.valueImg.sprite = GetSpriteFromAtlas("ui/activityuipage/monopoly_atlas", arg_78_1)

		self.valueImg:SetNativeSize()
	end

	setActive(go(self.valueImg), arg_78_1 ~= 0)

	return
end

function MonopolyGame:didEnter()
	setActive(self.startBtn, self.leftCount > 0)
	self:updateLeftCount()
	self:updateValue(0)
	self:updateNextRedPacketStep()

	self.mapVO = var_0_13(self.activity:getDataConfig("map"), self.pos)

	self:createMap(self.mapVO)
	self.mapVO:Init()
	self:checkState()
	onButton(self, self.startBtn, function()
		if self.block then
			return
		end

		if self.leftCount <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_count_noenough"))

			return
		end

		self:startAction()

		return
	end, SFX_PANEL)
	onButton(self, self.commonRp, function()
		if self.leftAwardCnt > 0 then
			self:emit(MonopolyPage.ON_AWARD)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_chunjie_monopoly.tip
		})

		return
	end, SFX_PANEL)

	return
end

function MonopolyGame:blockAllEvent(arg_83_1)
	self:emit(ActivityMainScene.LOCK_ACT_MAIN, arg_83_1)

	self.block = arg_83_1

	return
end

function MonopolyGame:triggerEvent(arg_84_1, arg_84_2, arg_84_3)
	local var_84_0 = self.mapVO:GetCell(arg_84_1):GetEvent(arg_84_2)

	local function var_84_1(arg_85_0, arg_85_1)
		if arg_85_0 and arg_85_0:ExistStory() then
			pg.NewStoryMgr.GetInstance():Play(arg_85_0.config.story, arg_85_1, true, true)
		else
			arg_85_1()
		end

		return
	end

	seriesAsync({
		function(arg_86_0)
			var_84_1(var_84_0, arg_86_0)

			return
		end,
		function(arg_87_0)
			local function var_87_1()
				if not var_84_0 or var_84_0:isEmpty() then
					arg_87_0()

					return
				end

				self:emit(MonopolyPage.ON_TRIGGER, self.activity.id, function(arg_89_0, arg_89_1)
					if not arg_89_0 or #arg_89_0 == 0 then
						arg_87_0()

						return
					end

					self.mapVO:UpdateCharPos(arg_89_0, function()
						var_84_0 = self.mapVO:GetCell(arg_89_0[#arg_89_0]):GetEvent(arg_89_1)

						var_84_1(var_84_0, var_87_1)

						return
					end, true)

					return
				end)

				return
			end

			;(nil)()

			return
		end
	}, arg_84_3)

	return
end

function MonopolyGame:checkState()
	local var_91_0 = {}

	self:blockAllEvent(true)

	local var_91_1 = self:getStrory()

	if var_91_1 then
		table.insert(var_91_0, function(arg_92_0)
			pg.NewStoryMgr.GetInstance():Play(var_91_1, arg_92_0)

			return
		end)
	end

	if self.effectId ~= 0 then
		table.insert(var_91_0, function(arg_93_0)
			self:triggerEvent(self.mapVO:GetPos(), self.effectId, arg_93_0)

			return
		end)
	end

	if self.step ~= 0 then
		table.insert(var_91_0, function(arg_94_0)
			self:emit(MonopolyPage.ON_MOVE, self.activity.id, function(arg_95_0, arg_95_1, arg_95_2)
				if not arg_95_1 or #arg_95_1 == 0 then
					arg_94_0()

					return
				end

				self.mapVO:UpdateCharPos(arg_95_1, function()
					self:triggerEvent(arg_95_1[#arg_95_1], arg_95_2, arg_94_0)

					return
				end)

				return
			end)

			return
		end)
	end

	seriesAsync(var_91_0, function()
		self:blockAllEvent(false)

		return
	end)

	return
end

function MonopolyGame:startAction()
	local var_98_0 = self.activity.id
	local var_98_1 = 0

	local function var_98_2(arg_99_0)
		if var_98_1 == 0 then
			arg_99_0()

			return
		end

		self:emit(MonopolyPage.ON_MOVE, var_98_0, function(arg_100_0, arg_100_1, arg_100_2)
			if not arg_100_1 or #arg_100_1 == 0 then
				arg_99_0()

				return
			end

			var_98_1 = arg_100_0

			self.mapVO:UpdateCharPos(arg_100_1, function()
				self:triggerEvent(arg_100_1[#arg_100_1], arg_100_2, arg_99_0)

				return
			end)

			return
		end)

		return
	end

	seriesAsync({
		function(arg_102_0)
			setActive(self.startBtn, false)
			self:blockAllEvent(true)
			self:playerAnim(arg_102_0)

			return
		end,
		function(arg_103_0)
			self:emit(MonopolyPage.ON_START, var_98_0, function(arg_104_0)
				var_98_1 = arg_104_0

				self:updateValue(arg_104_0)
				arg_103_0()

				return
			end)

			return
		end,
		function(arg_105_0)
			var_98_2(arg_105_0)

			return
		end,
		function(arg_106_0)
			var_98_2(arg_106_0)

			return
		end,
		function(arg_107_0)
			local var_107_0 = self:getStrory()

			if not var_107_0 then
				arg_107_0()

				return
			end

			pg.NewStoryMgr.GetInstance():Play(var_107_0, arg_107_0)

			return
		end
	}, function()
		self:updateValue(0)
		self:blockAllEvent(false)
		setActive(self.startBtn, self.leftCount > 0)

		return
	end)

	return
end

function MonopolyGame:getStrory()
	local var_109_0 = self.useCount
	local var_109_1 = _.detect(self.activity:getDataConfig("story") or {}, function(arg_110_0)
		return arg_110_0[1] == var_109_0
	end)

	if var_109_1 then
		return var_109_1[2]
	end

	return nil
end

function MonopolyGame:createMap(arg_111_1)
	self.cellTFs, self.charCard = {}

	function arg_111_1:onCreateCell()
		local var_112_0 = var_0_14(cloneTplTo(self.mapCellTpl, self.mapContainer), self)

		var_112_0:UpdateStyle()

		self.cellTFs[self.index] = var_112_0

		return
	end

	function arg_111_1:onCreateChar()
		local var_113_0 = cloneTplTo(self.charTpl, self.mapContainer)

		setParent(self.models[self.ship.configId], var_113_0)

		self.charCard = var_0_15(var_113_0, self)

		function self.onMove(arg_114_0, arg_114_1)
			self.charCard:Move(_.map(arg_114_0, function(arg_115_0)
				return self.cellTFs[arg_115_0.index]
			end), arg_114_1)

			return
		end

		function self:onUpdatePos()
			self.charCard:UpdatePos(self.cellTFs[self.index])

			return
		end

		function self.state.onActionUpdated(arg_117_0, arg_117_1)
			self.charCard:ChangeAction(arg_117_0, arg_117_1)

			return
		end

		function self:onJump(arg_118_1)
			self.charCard:Jump(self.cellTFs[self.index], arg_118_1)

			return
		end

		return
	end

	return
end

function MonopolyGame:playerAnim(arg_119_1)
	setActive(self.anim, true)

	if self.timer then
		self.timer:Stop()
	end

	self.timer = Timer.New(function()
		arg_119_1()
		setActive(self.anim, false)

		return
	end, 1.5, 1)

	self.timer:Start()

	return
end

function MonopolyGame:getTpl(arg_121_1, arg_121_2)
	local var_121_0 = arg_121_2:Find(arg_121_1)

	var_121_0:SetParent(self._tf, false)
	SetActive(var_121_0, false)

	return var_121_0
end

function MonopolyGame:Destroy()
	for iter_122_0, iter_122_1 in pairs(self.cellTFs) do
		iter_122_1:Dispose()
	end

	self.charCard:Dispose()
	self.mapVO:Dispose()

	self.cellTFs = nil
	self.charCard = nil
	self.mapVO = nil

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	pg.DelegateInfo.Dispose(self)

	return
end

function MonopolyGame:emit(arg_123_1, arg_123_2, arg_123_3)
	self.viewComponent:emit(arg_123_1, arg_123_2, arg_123_3)

	return
end

return MonopolyGame

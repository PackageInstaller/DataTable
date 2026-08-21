local var_0_0 = class("MonopolyGame")
local var_0_1 = pg.activity_event_monopoly_map
local var_0_2 = pg.activity_event_monopoly_event
local var_0_3 = 501041
local var_0_4 = 501041
local var_0_5 = 6
local var_0_6 = 5
local var_0_7 = {}

;({}).stateGold = "dafuweng_gold"
;({}).stateOil = "dafuweng_oil"
;({}).stateEvent = "dafuweng_event"
;({}).stateWalk = "dafuweng_walk"
;({}).stateStand = "dafuweng_stand"
;({}).stateJump = "dafuweng_jump"
;({}).stateRun = "dafuweng_run"
;({}).stateTouch = "dafuweng_touch"

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
		Move = function(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
			arg_10_2 = arg_10_2 or function()
				return
			end

			if #arg_10_1 == 0 then
				arg_10_2()

				return
			end

			if #arg_10_1 <= 3 and not arg_10_3 then
				arg_10_0:Jump(arg_10_1, arg_10_2)
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
		Touch = function(arg_21_0)
			if arg_21_0.state:IsStandState() then
				arg_21_0.state:ChangeState(var_0_7.stateTouch, function()
					arg_21_0.state:ChangeState(var_0_7.stateStand)

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
		InitPos = function(arg_24_0, arg_24_1)
			arg_24_0:ChangePos(arg_24_1)
			arg_24_0.state:ChangeState(var_0_7.stateStand)

			return
		end,
		ChangePos = function(arg_25_0, arg_25_1)
			assert(arg_25_1)
			arg_25_0.onUpdatePos(arg_25_1)

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
		ExistStory = function(arg_28_0)
			return arg_28_0.config.story and arg_28_0.config.story ~= "0"
		end,
		isEmpty = function(arg_29_0)
			return arg_29_0.config.story == "0" and arg_29_0.config.drop == 0 and #arg_29_0.config.effect == 0
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
	;({}).index = arg_31_0.index
	;({}).id = arg_31_0.id
	;({}).flag = arg_31_0.flag

	assert(({}).id)

	;({}).config = var_0_1[({}).id]
	;({}).events = {}

	for iter_31_0, iter_31_1 in ipairs(var_0_2.all) do
		if not table.contains(({}).events, iter_31_1) then
			table.insert(({}).events, var_0_11(iter_31_1))
		end
	end

	;({}).GetEvent = function(arg_32_0, arg_32_1)
		for iter_32_0, iter_32_1 in ipairs(arg_32_0.events) do
			if iter_32_1.id == arg_32_1 then
				return iter_32_1
			end
		end

		return
	end
	;({}).SetNext = function(arg_33_0, arg_33_1)
		arg_33_0.next = arg_33_1

		return
	end
	;({}).Dispose = function(arg_34_0)
		for iter_34_0, iter_34_1 in ipairs(arg_34_0.events) do
			iter_34_1:Dispose()
		end

		return
	end

	return {}
end

local function var_0_13(arg_35_0, arg_35_1)
	local var_35_0 = {
		ROW = var_0_5,
		COLUMN = var_0_6 - 2,
		cellIds = arg_35_0,
		path = {}
	}

	;({
		ROW = var_0_5,
		COLUMN = var_0_6 - 2,
		cellIds = arg_35_0,
		path = {}
	}).char = nil
	;({
		ROW = var_0_5,
		COLUMN = var_0_6 - 2,
		cellIds = arg_35_0,
		path = {}
	}).index = arg_35_1
	;({
		ROW = var_0_5,
		COLUMN = var_0_6 - 2,
		cellIds = arg_35_0,
		path = {}
	}).onCreateCell = function(arg_36_0)
		return
	end
	;({
		ROW = var_0_5,
		COLUMN = var_0_6 - 2,
		cellIds = arg_35_0,
		path = {}
	}).onCreateChar = function(arg_37_0)
		return
	end
	;({
		ROW = var_0_5,
		COLUMN = var_0_6 - 2,
		cellIds = arg_35_0,
		path = {}
	}).Init = function(arg_38_0)
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
			}, #arg_38_0.path)
		end

		for iter_38_2 = var_35_0.ROW - 1, 0, -1 do
			var_35_0:CeateCell({
				var_35_0.COLUMN + 1,
				iter_38_2
			}, #arg_38_0.path)
		end

		for iter_38_3 = var_35_0.COLUMN, 1, -1 do
			var_35_0:CeateCell({
				iter_38_3,
				0
			}, #arg_38_0.path - 1)
		end

		arg_38_0:CreateChar(var_0_3)

		return
	end
	;({
		ROW = var_0_5,
		COLUMN = var_0_6 - 2,
		cellIds = arg_35_0,
		path = {}
	}).CreateChar = function(arg_39_0, arg_39_1)
		arg_39_0.char = var_0_10(arg_39_1)

		arg_39_0.onCreateChar(arg_39_0.char)
		arg_39_0.char:InitPos((arg_39_0:GetCell(arg_39_0.index)))

		return
	end
	;({
		ROW = var_0_5,
		COLUMN = var_0_6 - 2,
		cellIds = arg_35_0,
		path = {}
	}).CeateCell = function(arg_40_0, arg_40_1, arg_40_2)
		local var_40_0 = var_0_12({
			pos = arg_40_1,
			index = #arg_40_0.path + 1,
			id = arg_40_0.cellIds[#arg_40_0.path + 1],
			flag = arg_40_2
		})

		if #arg_40_0.path == 0 then
			var_40_0.SetNext(var_40_0, var_40_0)
		else
			arg_40_0.path[#arg_40_0.path]:SetNext(var_40_0)
			var_40_0:SetNext(arg_40_0.path[1])
		end

		table.insert(arg_40_0.path, var_40_0)
		arg_40_0.onCreateCell(var_40_0)

		return
	end
	;({
		ROW = var_0_5,
		COLUMN = var_0_6 - 2,
		cellIds = arg_35_0,
		path = {}
	}).GetPath = function(arg_41_0)
		return arg_41_0.path
	end
	;({
		ROW = var_0_5,
		COLUMN = var_0_6 - 2,
		cellIds = arg_35_0,
		path = {}
	}).GetChar = function(arg_42_0)
		return arg_42_0.char
	end
	;({
		ROW = var_0_5,
		COLUMN = var_0_6 - 2,
		cellIds = arg_35_0,
		path = {}
	}).GetPathCell = function(arg_43_0, arg_43_1)
		return _.map(arg_43_1, function(arg_44_0)
			return arg_43_0.path[arg_44_0]
		end)
	end
	;({
		ROW = var_0_5,
		COLUMN = var_0_6 - 2,
		cellIds = arg_35_0,
		path = {}
	}).UpdateCharPos = function(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
		arg_45_0.char:Move(arg_45_0:GetPathCell(arg_45_1), arg_45_2, arg_45_3)

		arg_45_0.index = arg_45_1[#arg_45_1]

		return
	end
	;({
		ROW = var_0_5,
		COLUMN = var_0_6 - 2,
		cellIds = arg_35_0,
		path = {}
	}).GetCell = function(arg_46_0, arg_46_1)
		return arg_46_0.path[arg_46_1]
	end
	;({
		ROW = var_0_5,
		COLUMN = var_0_6 - 2,
		cellIds = arg_35_0,
		path = {}
	}).GetPos = function(arg_47_0)
		return arg_47_0.index
	end
	;({
		ROW = var_0_5,
		COLUMN = var_0_6 - 2,
		cellIds = arg_35_0,
		path = {}
	}).Dispose = function(arg_48_0)
		for iter_48_0, iter_48_1 in ipairs(arg_48_0.path) do
			iter_48_1:Dispose()
		end

		arg_48_0.char:Dispose()

		arg_48_0.onCreateCell = nil
		arg_48_0.onCreateChar = nil

		return
	end

	return {
		ROW = var_0_5,
		COLUMN = var_0_6 - 2,
		cellIds = arg_35_0,
		path = {}
	}
end

local function var_0_14(arg_49_0, arg_49_1)
	local var_49_0 = {
		_tf = arg_49_0,
		_img = arg_49_0:GetComponent(typeof(Image)),
		cell = arg_49_1,
		interval = Vector2(0, 0),
		startPos = Vector2(0, 0),
		offset = Vector2(arg_49_0.rect.width * 0.5 + 2.5, arg_49_0.rect.height * 0.5 - 2),
		GetGenPos = function(arg_50_0)
			return Vector3(arg_50_0.startPos.x + arg_50_0.cell.column * arg_50_0.offset.x + arg_50_0.cell.row * arg_50_0.offset.x, arg_50_0.startPos.y + arg_50_0.cell.column * arg_50_0.offset.y + arg_50_0.cell.row * -arg_50_0.offset.y, 0)
		end,
		UpdateStyle = function(arg_51_0)
			arg_51_0._img.sprite = GetSpriteFromAtlas("ui/activityuipage/monopolycar_atlas", arg_51_0.cell.config.icon)

			arg_51_0._img:SetNativeSize()

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

	;({
		_tf = arg_53_0
	}).WalkSpeed = 1
	;({
		_tf = arg_53_0
	}).RunSpeed = 0.5
	;({
		_tf = arg_53_0
	}).jumpSpeed = 0.5
	;({
		_tf = arg_53_0
	}).char = arg_53_1

	local var_53_1 = arg_53_0:GetChild(0)

	tf(var_53_1).localScale = Vector3(0.5, 0.5, 0.5)
	;({
		_tf = arg_53_0
	}).SpineAnimUI = var_53_1:GetComponent("SpineAnimUI")

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

	;({
		_tf = arg_53_0
	}).Action = function(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
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
		seriesAsync({}, function()
			if arg_55_2 then
				arg_55_2()
			end

			return
		end)

		return
	end
	;({
		_tf = arg_53_0
	}).Move = function(arg_60_0, arg_60_1, arg_60_2)
		if #arg_60_1 > 3 then
			arg_60_0:Action(arg_60_1, arg_60_2, arg_60_0.RunSpeed)
		else
			arg_60_0:Action(arg_60_1, arg_60_2, arg_60_0.WalkSpeed)
		end

		return
	end
	;({
		_tf = arg_53_0
	}).Jump = function(arg_61_0, arg_61_1, arg_61_2)
		arg_61_0:Action({
			arg_61_1
		}, function()
			arg_61_2()
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_STEP_MONOPOLY)

			return
		end, arg_61_0.jumpSpeed)

		return
	end
	;({
		_tf = arg_53_0
	}).UpdatePos = function(arg_63_0, arg_63_1)
		arg_63_0.preCellTF = arg_63_1
		arg_63_0._tf.localPosition = arg_63_1:GetGenPos()

		return
	end
	;({
		_tf = arg_53_0
	}).UpdateScale = function(arg_64_0, arg_64_1)
		local var_64_0 = 1

		arg_64_0.preCellTF = arg_64_0.preCellTF or arg_64_1

		if arg_64_1.cell.row > arg_64_0.preCellTF.cell.row or arg_64_1.cell.column > arg_64_0.preCellTF.cell.column then
			var_64_0 = 1
		elseif arg_64_1.cell.row < arg_64_0.preCellTF.cell.row or arg_64_1.cell.column < arg_64_0.preCellTF.cell.column then
			var_64_0 = -1
		end

		arg_64_0._tf.localScale = Vector3(var_64_0, 1, 1)

		return
	end
	;({
		_tf = arg_53_0
	}).ChangeAction = function(arg_65_0, arg_65_1, arg_65_2)
		arg_65_0.SpineAnimUI:SetActionCallBack(nil)
		arg_65_0.SpineAnimUI:SetAction(arg_65_1, 0)
		arg_65_0.SpineAnimUI:SetActionCallBack(function(arg_66_0)
			if arg_66_0 == "finish" then
				arg_65_0.SpineAnimUI:SetActionCallBack(nil)
				arg_65_2()
			end

			return
		end)

		return
	end
	;({
		_tf = arg_53_0
	}).Dispose = function(arg_67_0)
		arg_67_0.SpineAnimUI:SetActionCallBack(nil)

		arg_67_0.char.onMove = nil

		if arg_67_0.timer then
			arg_67_0.timer:Stop()

			arg_67_0.timer = nil
		end

		return
	end

	return {
		_tf = arg_53_0
	}
end

function var_0_0.SetUp(arg_68_0, arg_68_1, arg_68_2)
	arg_68_0.viewComponent = arg_68_1

	pg.DelegateInfo.New(arg_68_0)

	arg_68_0._tf = arg_68_0.viewComponent._tf
	arg_68_0._go = go(arg_68_0.viewComponent._tf)
	arg_68_0.models = {}

	parallelAsync({
		function(arg_69_0)
			local var_69_0 = Ship.New({
				configId = var_0_3,
				skin_id = var_0_4
			})

			PoolMgr.GetInstance():GetSpineChar(Ship.New({
				configId = var_0_3,
				skin_id = var_0_4
			}):getPrefab(), true, function(arg_70_0)
				arg_68_0.models[var_69_0.configId] = arg_70_0

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
		arg_68_0:setActivity(arg_68_2)
		arg_68_0:init()
		arg_68_0:didEnter()

		return
	end)

	return
end

function var_0_0.setActivity(arg_73_0, arg_73_1)
	arg_73_0.activity = arg_73_1
	arg_73_0.useCount = arg_73_0.activity.data1_list[2]

	local var_73_0 = arg_73_0.activity.data1_list[3] - 1
	local var_73_1 = arg_73_0.activity.data2_list[1]
	local var_73_2 = arg_73_0.activity.data2_list[2]

	arg_73_0.pos = arg_73_0.activity.data2
	arg_73_0.step = arg_73_0.activity.data3
	arg_73_0.effectId = arg_73_0.activity.data4
	arg_73_0.totalCnt = math.ceil((pg.TimeMgr.GetInstance():GetServerTime() - arg_73_0.activity.data1) / 0) * arg_73_0.activity:getDataConfig("daily_time") + arg_73_0.activity.data1_list[1]
	arg_73_0.leftCount = arg_73_0.totalCnt - arg_73_0.useCount

	local var_73_3 = arg_73_1:getDataConfig("reward_time")

	arg_73_0.nextredPacketStep = var_73_3 - arg_73_0.useCount % var_73_3
	arg_73_0.advanceTotalCnt = #arg_73_1:getDataConfig("reward")
	arg_73_0.isAdvanceRp = arg_73_0.advanceTotalCnt - var_73_2 > 0
	arg_73_0.leftAwardCnt = var_73_1 - var_73_2
	arg_73_0.advanceRpCount = math.max(0, math.min(var_73_1, arg_73_0.advanceTotalCnt) - var_73_2)
	arg_73_0.commonRpCount = math.max(0, var_73_1 - arg_73_0.advanceTotalCnt) - math.max(0, var_73_2 - arg_73_0.advanceTotalCnt)
	arg_73_0.leftDropShipCnt = 10 - var_73_0

	return
end

function var_0_0.NetActivity(arg_74_0, arg_74_1)
	arg_74_0:setActivity(arg_74_1)
	arg_74_0:updateLeftCount()
	arg_74_0:updateNextRedPacketStep()

	return
end

function var_0_0.init(arg_75_0)
	arg_75_0:blockAllEvent(false)

	arg_75_0.bg = arg_75_0._tf:Find("AD")
	arg_75_0.mapCellTpl = arg_75_0:getTpl("mapCell", arg_75_0.bg)
	arg_75_0.mapContainer = arg_75_0.bg:Find("mapContainer")
	arg_75_0.charTpl = arg_75_0:getTpl("char", arg_75_0.bg)
	arg_75_0.startBtn = arg_75_0.bg:Find("start")
	arg_75_0.valueImg = arg_75_0.bg:Find("value"):GetComponent(typeof(Image))
	arg_75_0.leftcountLabel = arg_75_0.bg:Find("leftcount"):GetComponent(typeof(Text))
	arg_75_0.leftCountTF = arg_75_0.bg:Find("leftcount/Text"):GetComponent(typeof(Text))
	arg_75_0.nextRedPacketStepTF = arg_75_0.bg:Find("nextRpStep/Text"):GetComponent(typeof(Text))
	arg_75_0.commonRp = arg_75_0.bg:Find("rp")
	arg_75_0.commonAnim = arg_75_0.commonRp:GetComponent(typeof(Animator))
	arg_75_0.commonRpCnt = arg_75_0.bg:Find("rp_text/Text"):GetComponent(typeof(Text))
	arg_75_0.dropShipTxt = arg_75_0._tf:Find("AD/drop_ship_text"):GetComponent(typeof(Text))
	arg_75_0.helpBtn = arg_75_0._tf:Find("AD/help")
	arg_75_0.anim = arg_75_0._tf:Find("AD/anim")

	setActive(arg_75_0.anim, false)

	arg_75_0.leftcountLabel.text = i18n("monopoly_left_count")
	arg_75_0.advanceTag = arg_75_0._tf:Find("AD/rp/sp")
	arg_75_0.advanceLabel = arg_75_0._tf:Find("AD/rp_text/sp")
	arg_75_0.advancecLabel = arg_75_0._tf:Find("AD/rp_text/label")
	arg_75_0.advanceImage = arg_75_0._tf:Find("AD/rp_text/sp_img")
	arg_75_0.advanceTxt = arg_75_0._tf:Find("AD/rp_text/sp_img/Text"):GetComponent(typeof(Text))

	return
end

function var_0_0.updateNextRedPacketStep(arg_76_0)
	arg_76_0.nextRedPacketStepTF.text = arg_76_0.nextredPacketStep

	return
end

function var_0_0.updateLeftCount(arg_77_0)
	arg_77_0.leftCountTF.text = arg_77_0.leftCount

	arg_77_0.commonAnim:SetInteger("count", arg_77_0.leftAwardCnt)

	arg_77_0.commonRpCnt.text = arg_77_0.commonRpCount

	return
end

function var_0_0.updateValue(arg_78_0, arg_78_1)
	if arg_78_1 ~= 0 then
		arg_78_0.valueImg.sprite = GetSpriteFromAtlas("ui/activityuipage/monopoly_atlas", arg_78_1)

		arg_78_0.valueImg:SetNativeSize()
	end

	setActive(go(arg_78_0.valueImg), arg_78_1 ~= 0)

	return
end

function var_0_0.didEnter(arg_79_0)
	setActive(arg_79_0.startBtn, arg_79_0.leftCount > 0)
	arg_79_0:updateLeftCount()
	arg_79_0:updateValue(0)
	arg_79_0:updateNextRedPacketStep()

	arg_79_0.mapVO = var_0_13(arg_79_0.activity:getDataConfig("map"), arg_79_0.pos)

	arg_79_0:createMap(arg_79_0.mapVO)
	arg_79_0.mapVO:Init()
	arg_79_0:checkState()
	onButton(arg_79_0, arg_79_0.startBtn, function()
		if arg_79_0.block then
			return
		end

		if arg_79_0.leftCount <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_count_noenough"))

			return
		end

		arg_79_0:startAction()

		return
	end, SFX_PANEL)
	onButton(arg_79_0, arg_79_0.commonRp, function()
		if arg_79_0.leftAwardCnt > 0 then
			arg_79_0:emit(MonopolyPage.ON_AWARD)
		end

		return
	end, SFX_PANEL)
	onButton(arg_79_0, arg_79_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_chunjie_monopoly.tip
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.blockAllEvent(arg_83_0, arg_83_1)
	arg_83_0:emit(ActivityMainScene.LOCK_ACT_MAIN, arg_83_1)

	arg_83_0.block = arg_83_1

	return
end

function var_0_0.triggerEvent(arg_84_0, arg_84_1, arg_84_2, arg_84_3)
	local var_84_0 = arg_84_0.mapVO:GetCell(arg_84_1):GetEvent(arg_84_2)

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
			(function()
				if not var_84_0 or var_84_0:isEmpty() then
					arg_87_0()

					return
				end

				arg_84_0:emit(MonopolyPage.ON_TRIGGER, arg_84_0.activity.id, function(arg_89_0, arg_89_1)
					if not arg_89_0 or #arg_89_0 == 0 then
						arg_87_0()

						return
					end

					arg_84_0.mapVO:UpdateCharPos(arg_89_0, function()
						var_84_0 = arg_84_0.mapVO:GetCell(arg_89_0[#arg_89_0]):GetEvent(arg_89_1)

						var_84_1(var_84_0, var_0)

						return
					end, true)

					return
				end)

				return
			end)()

			return
		end
	}, arg_84_3)

	return
end

function var_0_0.checkState(arg_91_0)
	arg_91_0:blockAllEvent(true)

	if arg_91_0:getStrory() then
		table.insert({}, function(arg_92_0)
			pg.NewStoryMgr.GetInstance():Play(var_0, arg_92_0)

			return
		end)
	end

	if arg_91_0.effectId ~= 0 then
		table.insert({}, function(arg_93_0)
			arg_91_0:triggerEvent(arg_91_0.mapVO:GetPos(), arg_91_0.effectId, arg_93_0)

			return
		end)
	end

	if arg_91_0.step ~= 0 then
		table.insert({}, function(arg_94_0)
			arg_91_0:emit(MonopolyPage.ON_MOVE, arg_91_0.activity.id, function(arg_95_0, arg_95_1, arg_95_2)
				if not arg_95_1 or #arg_95_1 == 0 then
					arg_94_0()

					return
				end

				arg_91_0.mapVO:UpdateCharPos(arg_95_1, function()
					arg_91_0:triggerEvent(arg_95_1[#arg_95_1], arg_95_2, arg_94_0)

					return
				end)

				return
			end)

			return
		end)
	end

	seriesAsync({}, function()
		arg_91_0:blockAllEvent(false)

		return
	end)

	return
end

function var_0_0.startAction(arg_98_0)
	local var_98_0 = arg_98_0.activity.id
	local var_98_1 = 0

	local function var_98_2(arg_99_0)
		if var_98_1 == 0 then
			arg_99_0()

			return
		end

		arg_98_0:emit(MonopolyPage.ON_MOVE, var_98_0, function(arg_100_0, arg_100_1, arg_100_2)
			if not arg_100_1 or #arg_100_1 == 0 then
				arg_99_0()

				return
			end

			var_98_1 = arg_100_0

			arg_98_0.mapVO:UpdateCharPos(arg_100_1, function()
				arg_98_0:triggerEvent(arg_100_1[#arg_100_1], arg_100_2, arg_99_0)

				return
			end)

			return
		end)

		return
	end

	seriesAsync({
		function(arg_102_0)
			setActive(arg_98_0.startBtn, false)
			arg_98_0:blockAllEvent(true)
			arg_98_0:playerAnim(arg_102_0)

			return
		end,
		function(arg_103_0)
			arg_98_0:emit(MonopolyPage.ON_START, var_98_0, function(arg_104_0)
				var_98_1 = arg_104_0

				arg_98_0:updateValue(arg_104_0)
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
			local var_107_0 = arg_98_0:getStrory()

			if not var_107_0 then
				arg_107_0()

				return
			end

			pg.NewStoryMgr.GetInstance():Play(var_107_0, arg_107_0)

			return
		end
	}, function()
		arg_98_0:updateValue(0)
		arg_98_0:blockAllEvent(false)
		setActive(arg_98_0.startBtn, arg_98_0.leftCount > 0)

		return
	end)

	return
end

function var_0_0.getStrory(arg_109_0)
	local var_109_0 = arg_109_0.useCount
	local var_109_1 = arg_109_0.activity:getDataConfig("story") or {}
	local var_109_2 = _.detect(var_109_1, function(arg_110_0)
		return arg_110_0[1] == var_109_0
	end)

	if var_109_2 then
		return var_109_2[2]
	end

	return nil
end

function var_0_0.createMap(arg_111_0, arg_111_1)
	arg_111_0.cellTFs, arg_111_0.charCard = {}

	function arg_111_1.onCreateCell(arg_112_0)
		local var_112_0 = var_0_14(cloneTplTo(arg_111_0.mapCellTpl, arg_111_0.mapContainer), arg_112_0)

		var_112_0:UpdateStyle()

		arg_111_0.cellTFs[arg_112_0.index] = var_112_0

		return
	end

	function arg_111_1.onCreateChar(arg_113_0)
		local var_113_0 = cloneTplTo(arg_111_0.charTpl, arg_111_0.mapContainer)

		setParent(arg_111_0.models[arg_113_0.ship.configId], var_113_0)

		arg_111_0.charCard = var_0_15(var_113_0, arg_113_0)

		function arg_113_0.onMove(arg_114_0, arg_114_1)
			arg_111_0.charCard:Move(_.map(arg_114_0, function(arg_115_0)
				return arg_111_0.cellTFs[arg_115_0.index]
			end), arg_114_1)

			return
		end

		function arg_113_0.onUpdatePos(arg_116_0)
			arg_111_0.charCard:UpdatePos(arg_111_0.cellTFs[arg_116_0.index])

			return
		end

		function arg_113_0.state.onActionUpdated(arg_117_0, arg_117_1)
			arg_111_0.charCard:ChangeAction(arg_117_0, arg_117_1)

			return
		end

		function arg_113_0.onJump(arg_118_0, arg_118_1)
			arg_111_0.charCard:Jump(arg_111_0.cellTFs[arg_118_0.index], arg_118_1)

			return
		end

		return
	end

	return
end

function var_0_0.playerAnim(arg_119_0, arg_119_1)
	setActive(arg_119_0.anim, true)

	if arg_119_0.timer then
		arg_119_0.timer:Stop()
	end

	arg_119_0.timer = Timer.New(function()
		arg_119_1()
		setActive(arg_119_0.anim, false)

		return
	end, 1.5, 1)

	arg_119_0.timer:Start()

	return
end

function var_0_0.getTpl(arg_121_0, arg_121_1, arg_121_2)
	local var_121_0 = arg_121_2:Find(arg_121_1)

	var_121_0:SetParent(arg_121_0._tf, false)
	SetActive(var_121_0, false)

	return var_121_0
end

function var_0_0.Destroy(arg_122_0)
	for iter_122_0, iter_122_1 in pairs(arg_122_0.cellTFs) do
		iter_122_1:Dispose()
	end

	arg_122_0.charCard:Dispose()
	arg_122_0.mapVO:Dispose()

	arg_122_0.cellTFs = nil
	arg_122_0.charCard = nil
	arg_122_0.mapVO = nil

	if arg_122_0.timer then
		arg_122_0.timer:Stop()

		arg_122_0.timer = nil
	end

	pg.DelegateInfo.Dispose(arg_122_0)

	return
end

function var_0_0.emit(arg_123_0, arg_123_1, arg_123_2, arg_123_3)
	arg_123_0.viewComponent:emit(arg_123_1, arg_123_2, arg_123_3)

	return
end

return var_0_0

class = var_0_10000

local var_0_0 = "CoreScenarioTemplatePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

import = var_0_10001

local var_0_2 = var_0_10001("Mgr/Pool/PoolPlural")

var_0_1.LINE_COLOR = {
	"43536c",
	"dbe7ea",
	"db6587"
}
var_0_1.TITLE_COLOR = nil
var_0_1.TITLE_ALPHA = {
	0.5,
	1,
	1
}

function var_0_1.getUIName(arg_1_0)
	return "AEBCSScenarioPage"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.storyLayer = var_1.Find(var_2_0, "Story")

	local var_2_1 = arg_2_0._tf

	arg_2_0.top = var_1.Find(var_2_1, "TopPage")

	local var_2_2 = arg_2_0._tf

	arg_2_0.bg = var_1.Find(var_2_2, "bg")

	local var_2_3 = arg_2_0._tf

	arg_2_0.storyHolder = var_1.Find(var_2_3, "Story/Nodes")

	local var_2_4 = arg_2_0.storyHolder

	arg_2_0.storyContainer = var_1.Find(var_2_4, "Viewport/Content")
	arg_2_0.nodes = {}

	local var_2_5 = arg_2_0._tf

	arg_2_0.progressText = var_1.Find(var_2_5, "TopPage/Desc/Text")

	local var_2_6 = arg_2_0._tf

	arg_2_0.storyAward = var_1.Find(var_2_6, "TopPage/Award")

	local var_2_7 = arg_2_0._tf

	arg_2_0.storyNodeTpl = var_1.Find(var_2_7, "Story/NodeTemplate")

	local var_2_8 = arg_2_0._tf

	arg_2_0.oneLineTpl = var_1.Find(var_2_8, "Story/OneLine")

	local var_2_9 = arg_2_0._tf

	arg_2_0.branchHeadTpl = var_1.Find(var_2_9, "Story/BranchHead")

	local var_2_10 = arg_2_0._tf

	arg_2_0.branchCenterTpl = var_1.Find(var_2_10, "Story/BranchCenter")

	local var_2_11 = arg_2_0._tf

	arg_2_0.branchUpTpl = var_1.Find(var_2_11, "Story/BranchUp")

	local var_2_12 = arg_2_0._tf

	arg_2_0.branchDownTpl = var_1.Find(var_2_12, "Story/BranchDown")

	local var_2_13 = arg_2_0._tf

	arg_2_0.unionTailTpl = var_1.Find(var_2_13, "Story/UnionTail")

	local var_2_14 = arg_2_0._tf

	arg_2_0.unionCenterTpl = var_1.Find(var_2_14, "Story/UnionCenter")

	local var_2_15 = arg_2_0._tf

	arg_2_0.unionUpTpl = var_1.Find(var_2_15, "Story/UnionUp")

	local var_2_16 = arg_2_0._tf

	arg_2_0.unionDownTpl = var_1.Find(var_2_16, "Story/UnionDown")

	local var_2_17 = arg_2_0._tf

	arg_2_0.unreleasedNodeTpl = var_1.Find(var_2_17, "Story/UnreleasedNode")
	setActive = var_1

	var_1(arg_2_0.storyNodeTpl, false)

	setActive = var_1

	var_1(arg_2_0.oneLineTpl, false)

	setActive = var_1

	var_1(arg_2_0.branchHeadTpl, false)

	setActive = var_1

	var_1(arg_2_0.branchCenterTpl, false)

	setActive = var_1

	var_1(arg_2_0.branchUpTpl, false)

	setActive = var_1

	var_1(arg_2_0.branchDownTpl, false)

	setActive = var_1

	var_1(arg_2_0.unionTailTpl, false)

	setActive = var_1

	var_1(arg_2_0.unionCenterTpl, false)

	setActive = var_1

	var_1(arg_2_0.unionUpTpl, false)

	setActive = var_1

	var_1(arg_2_0.unionDownTpl, false)

	setActive = var_1

	var_1(arg_2_0.unreleasedNodeTpl, false)

	local var_2_18 = {}
	local var_2_19 = arg_2_0.storyNodeTpl
	local var_2_20 = var_0_2.New

	go = var_1_10005
	var_2_18[var_2_19] = var_2_20(var_1_10005(arg_2_0.storyNodeTpl), 0)

	local var_2_21 = arg_2_0.oneLineTpl
	local var_2_22 = var_0_2.New

	go = var_5
	var_2_18[var_2_21] = var_2_22(var_5(arg_2_0.oneLineTpl), 0)

	local var_2_23 = arg_2_0.branchHeadTpl
	local var_2_24 = var_0_2.New

	go = var_5
	var_2_18[var_2_23] = var_2_24(var_5(arg_2_0.branchHeadTpl), 0)

	local var_2_25 = arg_2_0.branchCenterTpl
	local var_2_26 = var_0_2.New

	go = var_5
	var_2_18[var_2_25] = var_2_26(var_5(arg_2_0.branchCenterTpl), 0)

	local var_2_27 = arg_2_0.branchUpTpl
	local var_2_28 = var_0_2.New

	go = var_5
	var_2_18[var_2_27] = var_2_28(var_5(arg_2_0.branchUpTpl), 0)

	local var_2_29 = arg_2_0.branchDownTpl
	local var_2_30 = var_0_2.New

	go = var_5
	var_2_18[var_2_29] = var_2_30(var_5(arg_2_0.branchDownTpl), 0)

	local var_2_31 = arg_2_0.unionTailTpl
	local var_2_32 = var_0_2.New

	go = var_5
	var_2_18[var_2_31] = var_2_32(var_5(arg_2_0.unionTailTpl), 0)

	local var_2_33 = arg_2_0.unionCenterTpl
	local var_2_34 = var_0_2.New

	go = var_5
	var_2_18[var_2_33] = var_2_34(var_5(arg_2_0.unionCenterTpl), 0)

	local var_2_35 = arg_2_0.unionUpTpl
	local var_2_36 = var_0_2.New

	go = var_5
	var_2_18[var_2_35] = var_2_36(var_5(arg_2_0.unionUpTpl), 0)

	local var_2_37 = arg_2_0.unionDownTpl
	local var_2_38 = var_0_2.New

	go = var_5
	var_2_18[var_2_37] = var_2_38(var_5(arg_2_0.unionDownTpl), 0)

	local var_2_39 = arg_2_0.unreleasedNodeTpl
	local var_2_40 = var_0_2.New

	go = var_5
	var_2_18[var_2_39] = var_2_40(var_5(arg_2_0.unreleasedNodeTpl), 0)
	arg_2_0.pools = var_2_18
	arg_2_0.nodeTplWidth = arg_2_0.storyNodeTpl.rect.width
	arg_2_0.oneLineWidth = arg_2_0.oneLineTpl.rect.width
	arg_2_0.oneLineHeight = arg_2_0.oneLineTpl.rect.height
	arg_2_0.branchHeadWidth = arg_2_0.branchHeadTpl.rect.width
	arg_2_0.branchUpWidth = arg_2_0.branchUpTpl.rect.width
	arg_2_0.branchUpHeight = arg_2_0.branchUpTpl.rect.height
	arg_2_0.UnionTailWidth = arg_2_0.unionTailTpl.rect.width
	arg_2_0.activeItems = {}
	arg_2_0.displayChapterIDs = {}
	arg_2_0.chapterTFsById = {}
	arg_2_0.storyNodeTFsById = {}

	local var_2_41 = arg_2_0._tf

	arg_2_0.topPage = var_1.Find(var_2_41, "TopPage")

	local var_2_42 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_42, "TopPage/top/btn_back")

	local var_2_43 = arg_2_0._tf

	arg_2_0.homeBtn = var_1.Find(var_2_43, "TopPage/top/btn_home")
	onButton = var_1

	local var_2_44 = arg_2_0
	local var_2_45 = arg_2_0.backBtn

	local function var_2_46()
		local var_3_0 = arg_2_0

		var_0.Hide(var_3_0)

		return
	end

	SFX_PANEL = var_6

	var_1(var_2_44, var_2_45, var_2_46, var_6)

	onButton = var_1

	local var_2_47 = arg_2_0
	local var_2_48 = arg_2_0.homeBtn

	local function var_2_49()
		local var_4_0 = arg_2_0.event
		local var_4_1 = var_0.emit

		BaseUI = var_2_10003

		var_4_1(var_4_0, var_2_10003.ON_HOME)

		return
	end

	SFX_PANEL = var_6

	var_1(var_2_47, var_2_48, var_2_49, var_6)

	setText = var_1

	local var_2_50 = arg_2_0._tf
	local var_2_51 = var_3.Find(var_2_50, "TopPage/Desc/Desc")

	i18n = var_2_48

	var_1(var_2_51, var_2_48("series_enemy_storyreward"))

	arg_2_0.mapGroup = {}
	arg_2_0.currentBG = nil
	AutoLoader = var_1
	arg_2_0.loader = var_1.New()

	return
end

function var_0_1.SetCoreStoryPage(arg_5_0, arg_5_1)
	arg_5_0.coreStoryPage = arg_5_1

	return
end

function var_0_1.SetActivity(arg_6_0, arg_6_1)
	arg_6_0.activity = arg_6_1

	arg_6_0:BuildStoryTree()

	return
end

function var_0_1.BuildStoryTree(arg_7_0)
	local var_7_0 = arg_7_0.activity

	arg_7_0.spStoryIDs = var_1.getConfig(var_7_0, "config_client").storys
	arg_7_0.spStoryNodes = {}
	_ = var_1

	var_1.each(arg_7_0.spStoryIDs, function(arg_8_0)
		table = var_2_10001

		local var_8_0 = var_2_10001.insert
		local var_8_1 = arg_7_0.spStoryNodes

		ActivitySpStoryNode = var_2_10004

		var_8_0(var_8_1, var_2_10004.New({
			configId = arg_8_0
		}))

		return
	end)

	local var_7_1 = {}

	arg_7_0.nodeChildDict = {}
	arg_7_0.nodeRootList = var_7_1
	_ = var_7_1

	var_7_1.each(arg_7_0.spStoryNodes, function(arg_9_0)
		if #arg_9_0:GetPreNodes() == 0 then
			table = var_2

			var_2.insert(arg_7_0.nodeRootList, arg_9_0)
		else
			_ = var_2

			var_2.each(var_1, function(arg_10_0)
				local var_10_0 = arg_7_0.nodeChildDict
				local var_10_1

				if not arg_7_0.nodeChildDict[arg_10_0] then
					var_10_1 = {}
				end

				var_10_0[arg_10_0] = var_10_1
				table = var_10_0

				var_10_0.insert(arg_7_0.nodeChildDict[arg_10_0], arg_9_0)

				return
			end)
		end

		return
	end)

	return
end

function var_0_1.IsShowRed(arg_11_0, arg_11_1)
	arg_11_0:SetActivity(arg_11_1)
	arg_11_0:UpdateStoryNodeStatus()

	local var_11_0 = false

	for iter_11_0 = 1, #arg_11_0.spStoryNodes do
		local var_11_1 = arg_11_0.spStoryNodes[iter_11_0]

		arg_11_0:checkRequireBlock(var_11_1)

		if arg_11_0.spStoryUnlockNode then
			var_11_0 = true

			break
		end
	end

	arg_11_0.spStoryUnlockNode = nil
	arg_11_0.spStoryUnreleasedNode = nil

	return var_11_0
end

function var_0_1.UpdateView(arg_12_0, arg_12_1)
	arg_12_0:UpdateStoryNodeStatus()
	arg_12_0:UpdateStory(arg_12_1)
	arg_12_0:Move2UnlockStory()
	arg_12_0:SwitchStoryMapAndBGM()

	setActive = var_2

	var_2(arg_12_0.storyLayer, true)
	arg_12_0:TrySubmitTask()

	return
end

function var_0_1.RecyclePools(arg_13_0)
	for iter_13_0 = #arg_13_0.activeItems, 1, -1 do
		local var_13_0 = arg_13_0.activeItems[iter_13_0]
		local var_13_1 = arg_13_0.pools[var_13_0.template]

		if var_13_0.template == arg_13_0.oneLineTpl then
			setSizeDelta = var_7

			var_7(var_13_0.active, {
				x = arg_13_0.oneLineWidth,
				y = arg_13_0.oneLineHeight
			})
		end

		var_13_1:Enqueue(var_13_0.active)
	end

	table = var_1

	var_1.clean(arg_13_0.activeItems)

	arg_13_0.storyNodeTFsById = {}

	return
end

local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3

function var_0_1.UpdateStoryNodeStatus(arg_14_0)
	local var_14_0 = 0
	local var_14_1 = 0

	pg = var_1_10003

	local var_14_2 = var_1_10003.NewStoryMgr.GetInstance()

	getProxy = var_1_10004
	TaskProxy = var_1_10006

	local var_14_3 = var_1_10004(var_1_10006)
	local var_14_4 = {}

	table = var_1_10006

	var_1_10006.Foreach(arg_14_0.spStoryIDs, function(arg_15_0, arg_15_1)
		var_14_4[arg_15_1] = {}

		return
	end)

	local var_14_5 = arg_14_0.spStoryNodes

	for iter_14_0 = 1, #var_14_5 do
		local var_14_6 = var_14_5[iter_14_0]
		local var_14_7 = var_11.GetConfigID(var_14_6)
		local var_14_8 = var_11:GetPreEvent()
		local var_14_9 = true
		local var_14_10 = var_0_3
		local var_14_11 = var_11:GetStoryName()
		local var_14_12 = false

		if var_14_11 and var_14_11 ~= "" then
			var_14_0 = var_14_0 + (var_14_2:IsPlayed(var_14_11) and 1 or 0)
			var_14_1 = var_14_1 + 1
		end

		if not var_14_12 then
			local var_14_13 = {}

			_ = var_1_10019

			var_1_10019.each(var_11:GetUnlockConditions(), function(arg_16_0)
				local var_16_0 = true
				local var_16_1 = arg_16_0[1]

				ActivitySpStoryNode = var_2_10003

				if var_16_1 == var_2_10003.CONDITION.TIME then
					pg = var_16_1

					local var_16_2 = var_16_1.TimeMgr.GetInstance()

					var_16_1 = var_16_1.parseTimeFromConfig(var_16_2, arg_16_0[2])
					pg = var_3

					local var_16_3 = var_3.TimeMgr.GetInstance()

					var_16_0 = var_16_1 <= var_3.GetServerTime(var_16_3)
				else
					var_16_1 = arg_16_0[1]
					ActivitySpStoryNode = var_3

					if var_16_1 == var_3.CONDITION.PASSCHAPTER then
						var_16_1 = arg_16_0[2]
						_ = var_3
						var_16_0 = var_3.all(var_16_1, function(arg_17_0)
							getProxy = var_3_10001
							ChapterProxy = var_3_10003

							local var_17_0 = var_3_10001(var_3_10003)
							local var_17_1 = var_1.getChapterById(var_17_0, arg_17_0, true)

							return var_1.isClear(var_17_1)
						end)
					else
						var_16_1 = arg_16_0[1]
						ActivitySpStoryNode = var_3

						local var_16_4

						if var_16_1 == var_3.CONDITION.PT then
							var_16_1 = arg_16_0[2][1]
							var_16_4 = arg_16_0[2][2]

							local var_16_5 = arg_16_0[2][3]
							local var_16_6 = 0

							DROP_TYPE_RESOURCE = var_2_10006

							if var_16_1 == var_2_10006 then
								getProxy = var_2_10006
								PlayerProxy = var_2_10008
								var_2_10008 = var_2_10006(var_2_10008)
								var_2_10008 = var_2_10006.getRawData(var_2_10008)
								var_16_6 = var_2_10006.getResource(var_2_10008, arg_16_0[2][2])
							else
								DROP_TYPE_ITEM = var_2_10006

								if var_16_1 == var_2_10006 then
									getProxy = var_2_10006
									BagProxy = var_2_10008

									local var_16_7 = var_2_10006(var_2_10008)

									var_16_6 = var_6.getItemCountById(var_16_7, var_16_4)
								end
							end

							var_16_0 = var_16_5 <= var_16_6
							var_14_4[var_14_7].reuqire = var_16_5
						else
							var_16_1 = arg_16_0[1]
							ActivitySpStoryNode = var_16_4

							if var_16_1 == var_16_4.CONDITION.PRE_PASSED then
								var_16_1 = var_14_4

								local var_16_8 = var_0

								var_16_0 = var_16_1[var_3.GetPreEvent(var_16_8)].status == var_0_5
							else
								var_16_1 = arg_16_0[1]
								ActivitySpStoryNode = var_3

								if var_16_1 == var_3.CONDITION.TASK_FINISHED then
									local var_16_9 = var_14_3

									var_16_1 = var_16_1.getFinishTaskById(var_16_9, arg_16_0[2]) ~= nil
									var_16_0 = var_16_1
									var_14_4[var_14_7].hasTaskCondition = true
									var_14_4[var_14_7].taskConditionFinished = var_16_1

									if not var_16_1 and arg_16_0[3] and arg_16_0[3] ~= "" then
										var_14_4[var_14_7].taskConditionTextKey = arg_16_0[3]
									end
								end
							end
						end
					end
				end

				table = var_16_1

				var_16_1.insert(var_14_13, var_16_0)

				local var_16_10

				if var_14_9 then
					var_16_10 = var_16_0
				end

				var_14_9 = var_16_10

				return
			end)

			var_1_10019 = var_14_4[var_14_7]
			var_1_10019.conditionFinishedList = var_14_13
		end

		if var_14_12 then
			var_14_10 = var_0_5
		elseif var_14_9 then
			var_14_10 = var_0_4
		end

		var_14_4[var_14_7].status = var_14_10
	end

	arg_14_0.storyNodeStatus = var_14_4
	arg_14_0.storyReadCount, arg_14_0.storyReadMax = var_14_0, var_14_1

	return
end

function var_0_1.checkRequireBlock(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1:GetConfigID()

	if arg_18_0.storyNodeStatus[var_18_0].reuqire and var_3.status ~= var_0_5 then
		local var_18_1 = arg_18_1

		if arg_18_1.GetCleanAnimator(var_18_1) then
			if var_3.status == var_0_3 then
				arg_18_0.spStoryUnreleasedNode = arg_18_1

				return false
			elseif var_3.status == var_0_4 then
				getProxy = var_4
				PlayerProxy = var_18_1

				local var_18_2 = var_4(var_18_1)
				local var_18_3 = var_4.getRawData(var_18_2).id

				PlayerPrefs = var_5

				if var_5.GetInt("player_" .. var_18_3 .. "_activity_spStoryNodeID_" .. var_18_0 .. "_unlock", 0) == 0 then
					arg_18_0.spStoryUnlockNode = arg_18_1

					return false
				end
			end
		end
	end

	return true
end

function var_0_1.UpdateStory(arg_19_0, arg_19_1)
	arg_19_0:RecyclePools()

	local var_19_0 = arg_19_0.LINE_COLOR
	local var_19_1 = 0
	local var_19_2 = 150
	local var_19_3 = 150
	local var_19_4 = arg_19_0.nodeTplWidth
	local var_19_5 = arg_19_0.oneLineWidth
	local var_19_6 = arg_19_0.branchHeadWidth
	local var_19_7 = arg_19_0.branchUpWidth
	local var_19_8 = arg_19_0.branchUpHeight
	local var_19_9 = arg_19_0.UnionTailWidth
	local var_19_10 = 95
	local var_19_11 = 82
	local var_19_12 = 20
	local var_19_13 = 0

	pg = var_1_10016

	local var_19_14 = var_1_10016.NewStoryMgr.GetInstance()

	ipairs = var_1_10017

	for iter_19_0, iter_19_1 in var_1_10017(arg_19_0.nodeRootList) do
		local var_19_15 = {}

		var_1_10023 = {
			node = iter_19_1
		}
		Vector2 = var_1_10024
		var_1_10023.nodePos = var_1_10024.New(var_19_2, (iter_19_0 - 1) * 16)
		var_19_15[1] = var_1_10023

		function var_1_10023()
			table = var_2_10000

			local var_20_0 = var_2_10000.remove(var_19_15, 1).node
			local var_20_1 = arg_19_0

			if not var_2.checkRequireBlock(var_20_1, var_20_0) then
				var_19_13 = var_0.nodePos.x + var_19_3

				return false
			end

			local var_20_2 = var_20_0:GetConfigID()

			;(function()
				local var_21_0 = arg_19_0
				local var_21_1 = var_0.DequeItem(var_21_0, arg_19_0.storyNodeTpl, arg_19_1)

				var_21_1.name = var_20_2
				setAnchoredPosition = var_1

				var_1(var_21_1, var_0.nodePos)

				local var_21_2 = arg_19_0.storyNodeTFsById
				local var_21_3 = var_20_2
				local var_21_4 = {}

				tf = var_4
				var_21_4.nodeTF = var_4(var_21_1)
				var_21_2[var_21_3] = var_21_4

				return
			end)()

			local var_20_3

			if not arg_19_0.nodeChildDict[var_20_2] then
				var_20_3 = {}
			end

			local var_20_18

			if #var_20_3 == 0 then
				var_19_13 = var_0.nodePos.x + var_19_4 + var_19_3
			elseif #var_20_3 == 1 then
				local var_20_4 = var_20_3[1]
				local var_20_5 = var_20_18.GetConfigID(var_20_4)
				local var_20_6 = arg_19_0

				var_2_10008 = var_2_10008.DequeItem(var_20_6, arg_19_0.oneLineTpl, arg_19_1)
				string = var_20_4
				var_2_10008.name = var_20_4.format("Line%s_%s", var_20_2, var_20_5)
				setAnchoredPosition = var_9

				local var_20_7 = var_2_10008
				local var_20_8 = var_0.nodePos

				Vector2 = var_13

				var_9(var_20_7, var_20_8 + var_13.New(var_19_4 + var_19_12, 0))

				tf = var_9

				local var_20_9 = var_9(var_2_10008).anchoredPosition

				Vector2 = var_20_6

				local var_20_10 = var_20_9 + var_20_6.New(var_19_5 + var_19_10, 0)
				local var_20_11 = nextPos
				local var_20_12 = arg_19_0.storyNodeStatus[var_20_5].status

				tf = var_10

				local var_20_13 = var_10(var_2_10008)
				local var_20_14 = var_10.Find(var_20_13, "mask/Lines")

				eachChild = var_11

				var_11(var_20_14, function(arg_22_0)
					setImageColor = var_3_10001

					local var_22_0 = arg_22_0

					Color = var_3_10004

					var_3_10001(var_22_0, var_3_10004.NewHex(var_19_0[var_20_12]))

					return
				end)

				table = var_11

				local var_20_15 = var_11.insert
				local var_20_16 = var_19_15
				local var_20_17 = {
					node = var_20_18
				}

				nextPos = var_15
				var_20_17.nodePos = var_15

				var_20_15(var_20_16, var_20_17)
			elseif #var_20_3 > 1 then
				var_20_18 = {}

				local var_20_19

				table = var_2_10008

				var_2_10008.Ipairs(var_20_3, function(arg_23_0, arg_23_1)
					local var_23_0 = 0
					local var_23_1 = arg_23_1

					local function var_23_2()
						var_23_0 = var_23_0 + 1

						local var_24_0 = arg_19_0.nodeChildDict
						local var_24_1 = var_23_1
						local var_24_2 = var_24_0[var_1.GetConfigID(var_24_1)]

						assert = var_1

						var_1(#var_24_2 <= 1)

						if var_24_2[1] and #var_1:GetPreNodes() == 1 then
							var_23_1 = var_1

							return true
						else
							var_20_19 = var_1
						end

						return
					end

					while var_23_2() do
						-- block empty
					end

					var_20_18[arg_23_0] = var_23_0

					return
				end)

				_ = var_8

				local var_20_20 = var_8.max(var_20_18) * (var_19_4 + var_19_10 + var_19_12) + (var_8 - 1) * var_19_5
				local var_20_21 = var_0.nodePos

				Vector2 = var_11

				local var_20_22 = var_20_21 + var_11.New(var_19_4 + var_19_12, 0)

				;(function()
					local var_25_0 = arg_19_0
					local var_25_1 = var_0.DequeItem(var_25_0, arg_19_0.branchHeadTpl, arg_19_1)

					setAnchoredPosition = var_3_10001

					var_3_10001(var_25_1, var_20_22)

					local var_25_2 = var_20_22

					Vector2 = var_25_0
					var_20_22 = var_25_2 + var_25_0.New(var_19_6, 0)

					local var_25_3 = arg_19_0.storyNodeStatus
					local var_25_4 = var_20_3[1]
					local var_25_5 = var_25_3[var_2.GetConfigID(var_25_4)].status

					tf = var_2

					local var_25_6 = var_2(var_25_1)
					local var_25_7 = var_2.Find(var_25_6, "mask/Lines")

					eachChild = var_3

					var_3(var_25_7, function(arg_26_0)
						setImageColor = var_4_10001

						local var_26_0 = arg_26_0

						Color = var_4_10004

						var_4_10001(var_26_0, var_4_10004.NewHex(var_19_0[var_25_5]))

						return
					end)

					return
				end)()

				local var_20_23

				table = var_13

				var_13.Ipairs(var_20_3, function(arg_27_0, arg_27_1)
					local var_27_0 = var_19_5

					if var_20_18[arg_27_0] < var_0 then
						local var_27_1 = var_20_18[arg_27_0]

						var_27_0 = (var_20_20 - var_27_1 * (var_19_4 + var_19_10 + var_19_12)) / (var_27_1 + 1)
					end

					local var_27_2 = arg_27_1:GetConfigID()
					local var_27_3 = var_20_22

					;(function()
						local var_28_0
						local var_28_2

						if arg_27_0 == 1 then
							local var_28_1 = arg_19_0

							var_28_0 = var_28_2.DequeItem(var_28_1, arg_19_0.branchUpTpl, arg_19_1)
							setAnchoredPosition = var_28_2

							var_28_2(var_28_0, var_27_3)

							var_28_2 = var_27_3
							Vector2 = var_4_10002
							var_27_3 = var_28_2 + var_4_10002.New(var_19_7, var_19_8)

							if var_20_18[arg_27_0] < var_0 then
								setSizeDelta = var_28_2

								var_28_2(var_28_0, {
									x = var_19_7 + var_27_0,
									y = var_19_8
								})

								tf = var_28_2

								local var_28_3 = var_28_2(var_28_0)

								var_28_2.x = var_28_2.Find(var_28_3, "Line_1").sizeDelta.x + var_27_0
								setSizeDelta = var_4_10002
								tf = var_4

								local var_28_4 = var_4(var_28_0)

								var_4_10002(var_4.Find(var_28_4, "Line_1"), var_28_2)

								var_4_10002 = var_27_3
								Vector2 = var_3
								var_27_3 = var_4_10002 + var_3.New(var_27_0, 0)
							end
						elseif arg_27_0 == 3 or arg_27_0 == 2 and #var_20_3 == 2 then
							local var_28_5 = arg_19_0

							var_28_0 = var_28_2.DequeItem(var_28_5, arg_19_0.branchDownTpl, arg_19_1)
							setAnchoredPosition = var_28_2

							var_28_2(var_28_0, var_27_3)

							var_28_2 = var_27_3
							Vector2 = var_4_10002
							var_27_3 = var_28_2 + var_4_10002.New(var_19_7, -var_19_8)

							if var_20_18[arg_27_0] < var_0 then
								setSizeDelta = var_28_2

								var_28_2(var_28_0, {
									x = var_19_7 + var_27_0,
									y = var_19_8
								})

								tf = var_28_2

								local var_28_6 = var_28_2(var_28_0)

								var_28_2.x = var_28_2.Find(var_28_6, "Line_1").sizeDelta.x + var_27_0
								setSizeDelta = var_4_10002
								tf = var_4

								local var_28_7 = var_4(var_28_0)

								var_4_10002(var_4.Find(var_28_7, "Line_1"), var_28_2)

								var_4_10002 = var_27_3
								Vector2 = var_3
								var_27_3 = var_4_10002 + var_3.New(var_27_0, 0)
							end
						else
							local var_28_8 = arg_19_0

							var_28_0 = var_28_2.DequeItem(var_28_8, arg_19_0.branchCenterTpl, arg_19_1)
							setAnchoredPosition = var_28_2

							var_28_2(var_28_0, var_27_3)

							var_28_2 = var_27_3
							Vector2 = var_4_10002
							var_27_3 = var_28_2 + var_4_10002.New(var_19_7, 0)

							if var_20_18[arg_27_0] < var_0 then
								tf = var_28_2
								var_28_2.x = var_28_2(var_28_0).sizeDelta.x + var_27_0
								setSizeDelta = var_2

								var_2(var_28_0, var_28_2)

								local var_28_9 = var_27_3

								Vector2 = var_3
								var_27_3 = var_28_9 + var_3.New(var_27_0, 0)
							end
						end

						string = var_28_2
						var_28_0.name = var_28_2.format("Branch%s_%s", var_20_2, var_27_2)

						local var_28_10 = arg_19_0.storyNodeStatus[var_27_2].status

						tf = var_2

						local var_28_11 = var_2(var_28_0)
						local var_28_12 = var_2.Find(var_28_11, "mask/Lines")

						eachChild = var_3

						var_3(var_28_12, function(arg_29_0)
							setImageColor = var_5_10001

							local var_29_0 = arg_29_0

							Color = var_5_10004

							var_5_10001(var_29_0, var_5_10004.NewHex(var_19_0[var_28_10]))

							return
						end)

						return
					end)()

					Vector2 = var_6
					var_27_3 = var_27_3 + var_6.New(var_19_10, 0)

					local var_27_4 = arg_19_0

					if not var_6.checkRequireBlock(var_27_4, arg_27_1) then
						var_19_13 = var_27_3.x
						var_20_23 = true

						return
					end

					local var_27_5 = arg_19_0
					local var_27_6 = var_7.DequeItem(var_27_5, arg_19_0.storyNodeTpl, arg_19_1)

					var_27_6.name = var_27_2
					setAnchoredPosition = var_27_4

					var_27_4(var_27_6, var_27_3)

					local var_27_7 = arg_19_0.storyNodeTFsById
					local var_27_8 = {}

					tf = var_10
					var_27_8.nodeTF = var_10(var_27_6)
					var_27_7[var_27_2] = var_27_8
					Vector2 = var_27_7
					var_27_3 = var_27_3 + var_27_7.New(var_19_4 + var_19_12, 0)

					local var_27_9 = arg_19_0.nodeChildDict[var_27_2][1]
					local var_27_10 = arg_27_1

					local function var_27_11()
						if not var_27_9 or var_27_9 == var_20_19 then
							return
						end

						local var_30_0 = arg_19_0
						local var_30_1 = var_0.DequeItem(var_30_0, arg_19_0.oneLineTpl, arg_19_1)

						string = var_4_10001

						local var_30_2 = var_4_10001.format
						local var_30_3 = "Line%s_%s"
						local var_30_4 = var_27_10
						local var_30_5 = var_4.GetConfigID(var_30_4)
						local var_30_6 = var_27_9

						var_30_1.name = var_30_2(var_30_3, var_30_5, var_5.GetConfigID(var_30_6))
						setAnchoredPosition = var_1

						var_1(var_30_1, var_27_3)

						local var_30_7 = var_27_3

						Vector2 = var_30_0
						var_27_3 = var_30_7 + var_30_0.New(var_27_0 + var_19_10, 0)
						setSizeDelta = var_1

						var_1(var_30_1, {
							x = var_27_0,
							y = arg_19_0.oneLineHeight
						})

						local var_30_8 = arg_19_0.storyNodeStatus
						local var_30_9 = var_27_9
						local var_30_10 = var_30_8[var_2.GetConfigID(var_30_9)].status

						tf = var_2

						local var_30_11 = var_2(var_30_1)
						local var_30_12 = var_2.Find(var_30_11, "mask/Lines")

						eachChild = var_3

						var_3(var_30_12, function(arg_31_0)
							setImageColor = var_5_10001

							local var_31_0 = arg_31_0

							Color = var_5_10004

							var_5_10001(var_31_0, var_5_10004.NewHex(var_19_0[var_30_10]))

							return
						end)

						local var_30_13 = arg_19_0

						if not var_3.checkRequireBlock(var_30_13, var_27_9) then
							var_19_13 = var_27_3.x
							var_20_23 = true

							return
						end

						local var_30_14 = arg_19_0
						local var_30_15 = var_4.DequeItem(var_30_14, arg_19_0.storyNodeTpl, arg_19_1)
						local var_30_16 = var_27_9

						var_30_15.name = var_5.GetConfigID(var_30_16)
						setAnchoredPosition = var_5

						var_5(var_30_15, var_27_3)

						local var_30_17 = arg_19_0.storyNodeTFsById
						local var_30_18 = var_27_9
						local var_30_19 = var_6.GetConfigID(var_30_18)
						local var_30_20 = {}

						tf = var_30_18
						var_30_20.nodeTF = var_30_18(var_30_15)
						var_30_17[var_30_19] = var_30_20

						local var_30_21 = var_27_3

						Vector2 = var_30_19
						var_27_3 = var_30_21 + var_30_19.New(var_19_4 + var_19_12, 0)

						local var_30_22 = arg_19_0.nodeChildDict
						local var_30_23 = var_27_9

						var_27_9, var_27_10 = var_30_22[var_6.GetConfigID(var_30_23)][1], var_27_9

						return true
					end

					while var_27_11() do
						-- block empty
					end

					if var_20_19 then
						local var_27_12

						if arg_27_0 == 1 then
							local var_27_13 = arg_19_0

							var_27_12 = var_12.DequeItem(var_27_13, arg_19_0.unionUpTpl, arg_19_1)
							setAnchoredPosition = var_12

							var_12(var_27_12, var_27_3)

							if var_20_18[arg_27_0] < var_0 then
								setSizeDelta = var_12

								var_12(var_27_12, {
									x = var_19_7 + var_27_0,
									y = var_19_8
								})

								tf = var_12

								local var_27_14 = var_12(var_27_12)

								var_12.x = var_12.Find(var_27_14, "Line_1").sizeDelta.x + var_27_0
								setSizeDelta = var_13
								tf = var_15

								local var_27_15 = var_15(var_27_12)

								var_13(var_15.Find(var_27_15, "Line_1"), var_12)

								Vector2 = var_13
								var_27_3 = var_27_3 + var_13.New(var_27_0, 0)
							end
						elseif arg_27_0 == 3 or arg_27_0 == 2 and #var_20_3 == 2 then
							local var_27_16 = arg_19_0

							var_27_12 = var_12.DequeItem(var_27_16, arg_19_0.unionDownTpl, arg_19_1)
							setAnchoredPosition = var_12

							var_12(var_27_12, var_27_3)

							if var_20_18[arg_27_0] < var_0 then
								setSizeDelta = var_12

								var_12(var_27_12, {
									x = var_19_7 + var_27_0,
									y = var_19_8
								})

								tf = var_12

								local var_27_17 = var_12(var_27_12)

								var_12.x = var_12.Find(var_27_17, "Line_1").sizeDelta.x + var_27_0
								setSizeDelta = var_13
								tf = var_15

								local var_27_18 = var_15(var_27_12)

								var_13(var_15.Find(var_27_18, "Line_1"), var_12)

								Vector2 = var_13
								var_27_3 = var_27_3 + var_13.New(var_27_0, 0)
							end
						else
							local var_27_19 = arg_19_0

							var_27_12 = var_12.DequeItem(var_27_19, arg_19_0.unionCenterTpl, arg_19_1)
							setAnchoredPosition = var_12

							var_12(var_27_12, var_27_3)

							if var_20_18[arg_27_0] < var_0 then
								tf = var_12
								var_12.x = var_12(var_27_12).sizeDelta.x + var_27_0
								setSizeDelta = var_13

								var_13(var_27_12, var_12)

								Vector2 = var_13
								var_27_3 = var_27_3 + var_13.New(var_27_0, 0)
							end
						end

						string = var_12

						local var_27_20 = var_12.format
						local var_27_21 = "Union%s_%s"
						local var_27_22 = var_27_10:GetConfigID()
						local var_27_23 = var_20_19

						var_27_12.name = var_27_20(var_27_21, var_27_22, var_16.GetConfigID(var_27_23))

						local var_27_24 = arg_19_0.storyNodeStatus
						local var_27_25 = var_20_19
						local var_27_26 = var_27_24[var_13.GetConfigID(var_27_25)].status

						tf = var_13

						local var_27_27 = var_13(var_27_12)
						local var_27_28 = var_13.Find(var_27_27, "mask/Lines")

						eachChild = var_27_21

						var_27_21(var_27_28, function(arg_32_0)
							setImageColor = var_4_10001

							local var_32_0 = arg_32_0

							Color = var_4_10004

							var_4_10001(var_32_0, var_4_10004.NewHex(var_19_0[var_27_26]))

							return
						end)
					end

					return
				end)

				if var_20_23 then
					return false
				end

				Vector2 = var_13
				var_20_22 = var_20_22 + var_13.New(var_20_20 + var_19_7, 0)

				if var_20_19 then
					(function()
						local var_33_0 = var_20_22

						Vector2 = var_3_10001
						var_20_22 = var_33_0 + var_3_10001.New(var_19_7, 0)

						local var_33_1 = arg_19_0
						local var_33_2 = var_0.DequeItem(var_33_1, arg_19_0.unionTailTpl, arg_19_1)

						setAnchoredPosition = var_1

						var_1(var_33_2, var_20_22)

						local var_33_3 = var_20_22

						Vector2 = var_33_1
						var_20_22 = var_33_3 + var_33_1.New(var_19_9 + var_19_11, 0)

						local var_33_4 = arg_19_0.storyNodeStatus
						local var_33_5 = var_20_19
						local var_33_6 = var_33_4[var_2.GetConfigID(var_33_5)].status

						tf = var_2

						local var_33_7 = var_2(var_33_2)
						local var_33_8 = var_2.Find(var_33_7, "mask/Lines")

						eachChild = var_3

						var_3(var_33_8, function(arg_34_0)
							setImageColor = var_4_10001

							local var_34_0 = arg_34_0

							Color = var_4_10004

							var_4_10001(var_34_0, var_4_10004.NewHex(var_19_0[var_33_6]))

							return
						end)

						return
					end)()

					table = var_14

					var_14.insert(var_19_15, {
						node = var_20_19,
						nodePos = var_20_22
					})
				else
					var_19_13 = var_20_22 + var_19_3
				end
			end

			next = var_20_18

			return var_20_18(var_19_15)
		end

		while var_1_10023() do
			-- block empty
		end

		math = var_1_10024
		var_19_1 = var_1_10024.max(var_19_1, var_19_13)
	end

	setSizeDelta = var_17

	var_17(arg_19_0.storyContainer, {
		x = var_19_1
	})

	if arg_19_0.spStoryUnreleasedNode or arg_19_0.spStoryUnlockNode then
		tf = var_17

		local var_19_16 = var_17(arg_19_0:DequeItem(arg_19_0.unreleasedNodeTpl), arg_19_1)

		setAnchoredPosition = var_18

		var_18(var_19_16, {
			y = 0,
			x = var_19_13
		})

		local var_19_17
		local var_19_18, var_19_19

		if arg_19_0.spStoryUnreleasedNode then
			var_19_18 = arg_19_0.storyNodeStatus
			var_19_19 = arg_19_0.spStoryUnreleasedNode
			var_19_18 = var_19_18[var_20.GetConfigID(var_19_19)].reuqire
			setText = var_20
			var_1_10024 = var_19_16
			var_19_19 = var_19_16.Find(var_1_10024, "text")
			i18n = var_1_10023

			var_20(var_19_19, var_1_10023("scenario_unlock_pt_require", var_19_18))

			var_19_19 = arg_19_0.spStoryUnreleasedNode
			var_19_17 = var_20.GetCleanAnimator(var_19_19)
		elseif arg_19_0.spStoryUnlockNode then
			setText = var_19_18

			local var_19_20 = var_19_16:Find("text")

			i18n = var_19_19

			var_19_18(var_19_20, var_19_19("scenario_unlock"))

			local var_19_21 = arg_19_0.spStoryUnlockNode

			var_19_18 = var_19_18.GetConfigID(var_19_21)
			onButton = var_20

			var_20(arg_19_0, var_19_16:Find("btn_unlock"), function()
				getProxy = var_2_10000
				PlayerProxy = var_2_10002

				local var_35_0 = var_2_10000(var_2_10002)
				local var_35_1 = var_0.getRawData(var_35_0).id

				PlayerPrefs = var_2_10001

				var_2_10001.SetInt("player_" .. var_35_1 .. "_activity_spStoryNodeID_" .. var_19_18 .. "_unlock", 1)

				local var_35_2 = arg_19_0

				var_1.UpdateView(var_35_2, true)

				local var_35_3 = arg_19_0

				var_1.Move2UnlockStory(var_35_3)

				return
			end)

			local var_19_22 = arg_19_0.spStoryUnlockNode

			var_19_17 = var_20.GetCleanAnimator(var_19_22)
		end

		ResourceMgr = var_19_18

		local var_19_23 = var_19_18.Inst
		local var_19_24 = var_19.getAssetAsync
		local var_19_25 = "ui/" .. var_19_17
		local var_19_26 = ""

		UnityEngine = var_1_10024

		var_19_24(var_19_23, var_19_25, var_19_26, var_1_10024.Events.UnityAction_UnityEngine_Object(function(arg_36_0)
			Instantiate = var_2_10001

			local var_36_0 = var_2_10001(arg_36_0)

			Vector3 = var_2_10002

			local var_36_1 = var_2_10002.New(-525, 0, 0)

			tf = var_3

			local var_36_2 = var_3(var_36_0)

			var_36_2.localPosition = var_36_1
			setParent = var_36_2

			var_36_2(var_36_0, var_19_16)

			WorldConst = var_36_2

			var_36_2.ArrayEffectOrder(var_19_16, 200)

			return
		end), true, true)
	end

	arg_19_0.spStoryUnreleasedNode = nil
	arg_19_0.spStoryUnlockNode = nil

	local var_19_27 = arg_19_0.spStoryNodes

	for iter_19_2 = 1, #var_19_27 do
		local var_19_28 = var_19_27[iter_19_2]
		local var_19_29 = var_22.GetConfigID(var_19_28)

		if arg_19_0.storyNodeTFsById[var_19_29] then
			local var_19_30 = arg_19_0.storyNodeStatus[var_19_29].status
			local var_19_31 = arg_19_0.storyNodeTFsById[var_19_29].nodeTF
			local var_19_32 = var_25.Find(var_19_31, "info/bk/title_form/title")
			local var_19_33 = arg_19_0.TITLE_COLOR
			local var_19_34

			if not arg_19_0.TITLE_ALPHA then
				var_19_34 = {
					0.5,
					1,
					1
				}
			end

			if var_19_33 and var_19_33[var_19_30] then
				setTextColor = var_29

				local var_19_35 = var_19_32

				Color = var_1_10032

				var_29(var_19_35, var_1_10032.NewHex(var_19_33[var_19_30]))
			end

			if var_19_30 == var_0_3 then
				local var_19_36 = var_22
				local var_19_37 = var_22.GetUnlockDesc(var_19_36)

				var_1_10030 = ""
				type = var_19_36

				if var_19_36(var_19_37) == "table" then
					local var_19_38

					if not arg_19_0.storyNodeStatus[var_19_29].conditionFinishedList then
						var_19_38 = {}
					end

					var_1_10030 = var_19_37[1] or ""
					ipairs = var_1_10032

					for iter_19_3, iter_19_4 in var_1_10032(var_19_37) do
						if not var_19_38[iter_19_3] then
							var_1_10030 = iter_19_4 or ""

							break
						end
					end
				else
					var_1_10030 = var_19_37 or ""
				end

				var_1_10033 = arg_19_0

				local var_19_39 = arg_19_0.RefreshUnlockDesc
				local var_19_40 = var_25

				HXSet = iter_19_3
				iter_19_3 = iter_19_3.hxLan(var_22:GetDisplayName())
				HXSet = iter_19_4

				var_19_39(var_1_10033, var_19_40, iter_19_3, iter_19_4.hxLan(var_1_10030))

				setTextAlpha = var_19_39
				var_1_10033 = var_19_32

				local var_19_41

				if not var_19_34[var_19_30] then
					var_19_41 = 0.5
				end

				var_19_39(var_1_10033, var_19_41)
			else
				local var_19_42 = arg_19_0
				local var_19_43 = arg_19_0.RefreshNodeTitle

				var_1_10032 = var_25
				HXSet = var_1_10033

				var_19_43(var_19_42, var_1_10032, var_1_10033.hxLan(var_22:GetDisplayName()))

				setTextAlpha = var_19_43

				local var_19_44 = var_19_32

				if not var_19_34[var_19_30] then
					var_1_10032 = 1
				end

				var_19_43(var_19_44, var_1_10032)
			end

			local var_19_45 = var_22
			local var_19_46 = var_22.GetType(var_19_45)

			setActive = var_1_10030
			var_1_10032 = var_25:Find("circle/lock")
			var_1_10033 = var_19_30 == var_0_3

			var_1_10030(var_1_10032, var_1_10033)

			if var_19_30 == var_0_3 then
				setActive = var_1_10030

				var_1_10030(var_25:Find("circle/Story"), false)

				setActive = var_1_10030

				var_1_10030(var_25:Find("circle/Battle"), false)

				setText = var_1_10030

				var_1_10030(var_25:Find(""))
			else
				ActivitySpStoryNode = var_1_10030

				if var_19_46 == var_1_10030.NODE_TYPE.STORY then
					setActive = var_1_10030
					var_1_10032 = var_25:Find("circle/Story")
					ActivitySpStoryNode = var_1_10033
					var_1_10033 = var_19_46 == var_1_10033.NODE_TYPE.STORY

					var_1_10030(var_1_10032, var_1_10033)

					setActive = var_1_10030
					var_1_10032 = var_25:Find("circle/Battle")
					ActivitySpStoryNode = var_1_10033
					var_1_10033 = var_19_46 == var_1_10033.NODE_TYPE.BATTLE

					var_1_10030(var_1_10032, var_1_10033)

					setActive = var_1_10030
					var_1_10032 = var_25:Find("circle/Story/Done")
					var_1_10033 = var_19_30 == var_0_5

					var_1_10030(var_1_10032, var_1_10033)
				else
					ActivitySpStoryNode = var_1_10030

					if var_19_46 == var_1_10030.NODE_TYPE.BATTLE then
						setActive = var_1_10030
						var_1_10032 = var_25:Find("circle/Story")
						ActivitySpStoryNode = var_1_10033
						var_1_10033 = var_19_46 == var_1_10033.NODE_TYPE.STORY

						var_1_10030(var_1_10032, var_1_10033)

						setActive = var_1_10030
						var_1_10032 = var_25:Find("circle/Battle")
						ActivitySpStoryNode = var_1_10033
						var_1_10033 = var_19_46 == var_1_10033.NODE_TYPE.BATTLE

						var_1_10030(var_1_10032, var_1_10033)

						setActive = var_1_10030
						var_1_10032 = var_25:Find("circle/Battle/Done")
						var_1_10033 = var_19_30 == var_0_5

						var_1_10030(var_1_10032, var_1_10033)
					end
				end
			end

			setActive = var_1_10030
			var_1_10032 = var_25:Find("circle/bk/Inactive")
			var_1_10033 = var_19_30 == var_0_3

			var_1_10030(var_1_10032, var_1_10033)

			setActive = var_1_10030
			var_1_10032 = var_25:Find("circle/bk/Active")
			var_1_10033 = var_19_30 == var_0_4

			var_1_10030(var_1_10032, var_1_10033)

			setActive = var_1_10030
			var_1_10032 = var_25:Find("circle/bk/Readed")
			var_1_10033 = var_19_30 == var_0_5

			var_1_10030(var_1_10032, var_1_10033)

			setActive = var_1_10030
			var_1_10032 = var_25:Find("info/bk/BG/Inactive")
			var_1_10033 = var_19_30 == var_0_3

			var_1_10030(var_1_10032, var_1_10033)

			setActive = var_1_10030

			local var_19_47 = var_25

			var_1_10032 = var_25.Find(var_19_47, "info/bk/BG/Active")
			var_1_10033 = var_19_30 ~= var_0_3

			var_1_10030(var_1_10032, var_1_10033)

			var_1_10032 = var_25

			if var_25.Find(var_1_10032, "condition") then
				if arg_19_0.storyNodeStatus[var_19_29].hasTaskCondition then
					var_1_10032 = not var_19_45.taskConditionFinished
				end

				setActive = var_1_10033

				var_1_10033(var_1_10030, var_1_10032)

				if var_1_10032 then
					if var_19_45.taskConditionTextKey then
						i18n = var_19_47

						local var_19_48

						if not var_19_47(var_1_10033) then
							var_19_48 = ""
						end

						if not var_1_10030:Find("Text") then
							iter_19_3 = var_1_10030:Find("text")
						end

						if iter_19_3 then
							setText = iter_19_4

							iter_19_4(iter_19_3, var_19_48)
						else
							setText = iter_19_4

							iter_19_4(var_1_10030, var_19_48)
						end

						onButton = var_19_45

						var_19_45(arg_19_0, var_25, function()
							if var_19_30 == var_0_3 then
								return
							end

							local var_37_0 = var_0
							local var_37_1 = var_0.GetStoryName(var_37_0)
							local var_37_2 = arg_19_0

							var_1.PlayStory(var_37_2, var_37_1, function()
								local var_38_0 = arg_19_0

								var_0.UpdateView(var_38_0, true)

								local var_38_1 = arg_19_0

								var_0.Move2UnlockStory(var_38_1)

								return
							end, true)

							return
						end)
					end
				end
			end
		end
	end

	local var_19_49 = arg_19_0.storyReadCount
	local var_19_50 = arg_19_0.storyReadMax

	setText = var_20

	var_20(arg_19_0.progressText, var_19_49 .. "/" .. var_19_50)

	setActive = var_20

	local var_19_51 = arg_19_0.storyAward

	tobool = var_23

	var_20(var_19_51, var_23(arg_19_0.storyTask))

	if arg_19_0.storyTask then
		local var_19_52 = arg_19_0.storyTask
		local var_19_53 = var_20.getConfig(var_19_52, "award_display")

		Drop = iter_19_2

		local var_19_54 = iter_19_2.New({
			type = var_19_53[1][1],
			id = var_19_53[1][2],
			count = var_19_53[1][3]
		})

		updateDrop = var_19_52

		local var_19_55 = arg_19_0.storyAward

		var_19_52(var_24.Find(var_19_55, "IconTpl"), var_19_54)

		local var_19_56 = arg_19_0.storyTask
		local var_19_57 = var_22.getTaskStatus(var_19_56)

		setActive = var_23

		local var_19_58 = arg_19_0.storyAward

		var_23(var_25.Find(var_19_58, "get"), var_19_57 == 1)

		setActive = var_23

		local var_19_59 = arg_19_0.storyAward

		var_23(var_25.Find(var_19_59, "got"), var_19_57 == 2)

		onButton = var_23

		var_23(arg_19_0, arg_19_0.storyAward, function()
			local var_39_0 = arg_19_0.coreStoryPage
			local var_39_1 = var_0.emit

			BaseUI = var_2_10003

			var_39_1(var_39_0, var_2_10003.ON_DROP, var_19_54)

			return
		end)
	end

	return
end

function var_0_1.DequeItem(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_0.pools[arg_40_1]
	local var_40_1 = var_3.Dequeue(var_40_0)

	table = var_1_10004

	var_1_10004.insert(arg_40_0.activeItems, {
		template = arg_40_1,
		active = var_40_1
	})

	setActive = var_4

	var_4(var_40_1, true)

	setParent = var_4

	var_4(var_40_1, arg_40_0.storyContainer)

	local var_40_2 = var_40_1
	local var_40_3 = var_40_1.GetComponent

	typeof = var_7
	Animation = var_1_10009

	if var_40_3(var_40_2, var_7(var_1_10009)) then
		var_4.enabled = not arg_40_2
	end

	return var_40_1
end

function var_0_1.Move2UnlockStory(arg_41_0)
	local var_41_0 = arg_41_0.spStoryNodes
	local var_41_1

	for iter_41_0 = #var_41_0, 1, -1 do
		var_1_10010 = var_41_0[iter_41_0]

		local var_41_2 = var_7.GetConfigID(var_1_10010)

		if arg_41_0.storyNodeStatus[var_41_2].status > var_0_3 and (not var_9.reuqire or not var_7:GetCleanAnimator()) then
			var_41_1 = var_41_2

			break
		end
	end

	if not var_41_1 then
		for iter_41_1 = 1, #var_41_0 do
			local var_41_3 = var_41_0[iter_41_1]
			local var_41_4 = var_7.GetConfigID(var_41_3)

			if arg_41_0.storyNodeTFsById[var_41_4] then
				var_41_1 = var_41_4

				break
			end
		end
	end

	if not var_41_1 then
		setAnchoredPosition = var_3

		var_3(arg_41_0.storyContainer, {
			x = 0
		})

		return
	end

	local var_41_5 = arg_41_0.storyNodeTFsById[var_41_1].nodeTF
	local var_41_6 = arg_41_0.storyNodeTpl.rect.width
	local var_41_7 = var_41_5.anchoredPosition.x + var_41_6 * 0.5 - arg_41_0.storyContainer.parent.rect.width * 0.5

	math = var_6

	local var_41_8 = var_6.clamp
	local var_41_9 = var_41_7
	local var_41_10 = 0

	math = var_1_10010

	local var_41_11 = var_41_8(var_41_9, var_41_10, var_1_10010.max(0, arg_41_0.storyContainer.rect.width - arg_41_0.storyContainer.parent.rect.width))

	setAnchoredPosition = var_6

	var_6(arg_41_0.storyContainer, {
		x = -var_41_11
	})

	return
end

function var_0_1.SwitchStoryMapAndBGM(arg_42_0)
	local var_42_0 = arg_42_0.activity
	local var_42_1 = var_1.getConfig(var_42_0, "config_client").default_background
	local var_42_2 = arg_42_0.activity
	local var_42_3 = var_2.getConfig(var_42_2, "config_client").default_bgm
	local var_42_4
	local var_42_5 = arg_42_0.spStoryNodes

	for iter_42_0 = 1, #var_42_5 do
		local var_42_6 = var_42_5[iter_42_0]
		local var_42_7 = var_9.GetConfigID(var_42_6)

		if arg_42_0.storyNodeStatus[var_42_7].status == var_0_5 then
			local var_42_8 = var_9:GetCleanAnimator()

			var_42_1 = var_9:GetCleanBG() ~= "" and var_9:GetCleanBG() or var_42_1

			if var_9:GetCleanBGM() ~= "" then
				var_42_3 = var_9:GetCleanBGM() or var_42_3
			end
		else
			break
		end
	end

	if var_42_1 ~= nil and var_42_1 ~= "" then
		arg_42_0:SwitchBG({
			{
				BG = var_42_1
			}
		})
	end

	if var_42_3 ~= nil and var_42_3 ~= "" then
		pg = var_5

		local var_42_9 = var_5.BgmMgr.GetInstance()

		var_5.Push(var_42_9, arg_42_0.__cname, var_42_3)
	end

	return
end

function var_0_1.SwitchBG(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	if not arg_43_1 or #arg_43_1 <= 0 then
		existCall = var_1_10004

		var_1_10004(arg_43_2)

		return
	elseif arg_43_3 then
		-- block empty
	else
		table = var_1_10004

		if var_1_10004.equal(arg_43_0.currentBG, arg_43_1) then
			return
		end
	end

	arg_43_0.currentBG = arg_43_1
	ipairs = var_1_10004

	for iter_43_0, iter_43_1 in var_1_10004(arg_43_0.mapGroup) do
		local var_43_0 = arg_43_0.loader

		var_9.ClearRequest(var_43_0, iter_43_1)
	end

	table = var_4

	var_4.clear(arg_43_0.mapGroup)

	local var_43_1 = arg_43_0.loader
	local var_43_2 = var_4.GetSpriteDirect(var_43_1, "bg/" .. arg_43_1[1].BG, "", function(arg_44_0)
		setImageSprite = var_2_10001

		var_2_10001(arg_43_0.bg, arg_44_0)

		SetActive = var_2_10001

		var_2_10001(arg_43_0.bg, true)

		return
	end)

	table = var_5

	var_5.insert(arg_43_0.mapGroup, var_43_2)

	return
end

function var_0_1.TrySubmitTask(arg_45_0)
	local var_45_0 = true

	ipairs = var_1_10002

	for iter_45_0, iter_45_1 in var_1_10002(arg_45_0.spStoryNodes) do
		if iter_45_1:GetStoryName() and var_7 ~= "" and var_45_0 then
			pg = var_1_10008

			local var_45_1 = var_1_10008.NewStoryMgr.GetInstance()

			var_45_0 = var_1_10008.IsPlayed(var_45_1, var_7)
		end

		if not var_45_0 then
			break
		end
	end

	if var_45_0 and arg_45_0.storyTask then
		local var_45_2 = arg_45_0.storyTask

		if var_2.getTaskStatus(var_45_2) == 1 then
			local var_45_3 = arg_45_0.coreStoryPage
			local var_45_4 = var_2.emit

			ActivityMediator = iter_45_0

			var_45_4(var_45_3, iter_45_0.ON_TASK_SUBMIT, arg_45_0.storyTask)

			return
		end
	end

	return
end

function var_0_1.PlayStory(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	if not arg_46_1 then
		existCall = var_1_10004

		return var_1_10004(arg_46_2)
	end

	pg = var_1_10004

	local var_46_0 = var_1_10004.NewStoryMgr.GetInstance()
	local var_46_1 = var_4.IsPlayed(var_46_0, arg_46_1)

	seriesAsync = var_1_10006

	var_1_10006({
		function(arg_47_0)
			if var_46_1 and not arg_46_3 then
				return arg_47_0()
			end

			tonumber = var_1

			if var_1(arg_46_1) and var_1 > 0 then
				local var_47_0 = arg_46_0.coreStoryPage
				local var_47_1 = var_2.emit

				ActivityMediator = var_2_10005

				var_47_1(var_47_0, var_2_10005.GO_PERFORM_COMBAT, {
					stageId = var_1,
					exitCallback = arg_46_2
				})
			else
				local var_47_2 = var_0

				var_2.Play(var_47_2, arg_46_1, arg_47_0, arg_46_3)
			end

			return
		end,
		function(arg_48_0, ...)
			existCall = var_2_10001

			var_2_10001(arg_46_2, ...)

			return
		end
	})

	return
end

function var_0_1.UpdateStoryTask(arg_49_0)
	local var_49_0 = arg_49_0.activity
	local var_49_1 = var_1.getConfig(var_49_0, "config_client").task_id

	getProxy = var_1_10002
	TaskProxy = var_4

	local var_49_2 = var_1_10002(var_4)

	if not var_2.getTaskVO(var_49_2, var_49_1) then
		errorMsg = var_49_0

		var_49_0("Missing Activity Task ID : " .. var_49_1)
	end

	if not var_2 then
		::label_49_0::

		Task = var_49_0
		var_49_0 = var_49_0.New({
			id = var_49_1
		})
	end

	arg_49_0.storyTask = var_49_0

	return
end

function var_0_1.OnSubmitTaskDone(arg_50_0)
	arg_50_0:UpdateView()

	return
end

function var_0_1.RefreshNodeTitle(arg_51_0, arg_51_1, arg_51_2)
	setScrollText = var_1_10003

	var_1_10003(arg_51_1:Find("info/bk/title_form/title"), arg_51_2)

	return
end

function var_0_1.RefreshUnlockDesc(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	setScrollText = var_1_10004

	var_1_10004(arg_52_1:Find("info/bk/title_form/title"), arg_52_3)

	return
end

function var_0_1.Show(arg_53_0)
	var_0_1.super.Show(arg_53_0)
	arg_53_0:OverlayPanel(arg_53_0._tf)
	arg_53_0:OverlayPanel(arg_53_0.topPage, {
		stopTop = true
	})

	return
end

function var_0_1.Hide(arg_54_0)
	arg_54_0:UnOverlayPanel(arg_54_0.topPage, arg_54_0._tf)
	arg_54_0:UnOverlayPanel(arg_54_0._tf, arg_54_0._parentTf)
	var_0_1.super.Hide(arg_54_0)

	return
end

function var_0_1.OnDestroy(arg_55_0)
	arg_55_0:RecyclePools()

	pairs = var_1

	for iter_55_0, iter_55_1 in var_1(arg_55_0.pools) do
		iter_55_1:Clear()
	end

	return
end

return var_0_1

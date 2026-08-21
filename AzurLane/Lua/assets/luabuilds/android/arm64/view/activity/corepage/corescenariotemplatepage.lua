local var_0_0 = class("CoreScenarioTemplatePage", import("view.base.BaseSubView"))
local var_0_1 = import("Mgr/Pool/PoolPlural")

var_0_0.LINE_COLOR = {
	"43536c",
	"dbe7ea",
	"db6587"
}
var_0_0.TITLE_COLOR = nil
var_0_0.TITLE_ALPHA = {
	0.5,
	1,
	1
}

function var_0_0.getUIName(arg_1_0)
	return "AEBCSScenarioPage"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.storyLayer = arg_2_0._tf:Find("Story")
	arg_2_0.top = arg_2_0._tf:Find("TopPage")
	arg_2_0.bg = arg_2_0._tf:Find("bg")
	arg_2_0.storyHolder = arg_2_0._tf:Find("Story/Nodes")
	arg_2_0.storyContainer = arg_2_0.storyHolder:Find("Viewport/Content")
	arg_2_0.nodes = {}
	arg_2_0.progressText = arg_2_0._tf:Find("TopPage/Desc/Text")
	arg_2_0.storyAward = arg_2_0._tf:Find("TopPage/Award")
	arg_2_0.storyNodeTpl = arg_2_0._tf:Find("Story/NodeTemplate")
	arg_2_0.oneLineTpl = arg_2_0._tf:Find("Story/OneLine")
	arg_2_0.branchHeadTpl = arg_2_0._tf:Find("Story/BranchHead")
	arg_2_0.branchCenterTpl = arg_2_0._tf:Find("Story/BranchCenter")
	arg_2_0.branchUpTpl = arg_2_0._tf:Find("Story/BranchUp")
	arg_2_0.branchDownTpl = arg_2_0._tf:Find("Story/BranchDown")
	arg_2_0.unionTailTpl = arg_2_0._tf:Find("Story/UnionTail")
	arg_2_0.unionCenterTpl = arg_2_0._tf:Find("Story/UnionCenter")
	arg_2_0.unionUpTpl = arg_2_0._tf:Find("Story/UnionUp")
	arg_2_0.unionDownTpl = arg_2_0._tf:Find("Story/UnionDown")
	arg_2_0.unreleasedNodeTpl = arg_2_0._tf:Find("Story/UnreleasedNode")

	setActive(arg_2_0.storyNodeTpl, false)
	setActive(arg_2_0.oneLineTpl, false)
	setActive(arg_2_0.branchHeadTpl, false)
	setActive(arg_2_0.branchCenterTpl, false)
	setActive(arg_2_0.branchUpTpl, false)
	setActive(arg_2_0.branchDownTpl, false)
	setActive(arg_2_0.unionTailTpl, false)
	setActive(arg_2_0.unionCenterTpl, false)
	setActive(arg_2_0.unionUpTpl, false)
	setActive(arg_2_0.unionDownTpl, false)
	setActive(arg_2_0.unreleasedNodeTpl, false)

	arg_2_0.pools = {
		[arg_2_0.storyNodeTpl] = var_0_1.New(go(arg_2_0.storyNodeTpl), 0),
		[arg_2_0.oneLineTpl] = var_0_1.New(go(arg_2_0.oneLineTpl), 0),
		[arg_2_0.branchHeadTpl] = var_0_1.New(go(arg_2_0.branchHeadTpl), 0),
		[arg_2_0.branchCenterTpl] = var_0_1.New(go(arg_2_0.branchCenterTpl), 0),
		[arg_2_0.branchUpTpl] = var_0_1.New(go(arg_2_0.branchUpTpl), 0),
		[arg_2_0.branchDownTpl] = var_0_1.New(go(arg_2_0.branchDownTpl), 0),
		[arg_2_0.unionTailTpl] = var_0_1.New(go(arg_2_0.unionTailTpl), 0),
		[arg_2_0.unionCenterTpl] = var_0_1.New(go(arg_2_0.unionCenterTpl), 0),
		[arg_2_0.unionUpTpl] = var_0_1.New(go(arg_2_0.unionUpTpl), 0),
		[arg_2_0.unionDownTpl] = var_0_1.New(go(arg_2_0.unionDownTpl), 0),
		[arg_2_0.unreleasedNodeTpl] = var_0_1.New(go(arg_2_0.unreleasedNodeTpl), 0)
	}
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
	arg_2_0.topPage = arg_2_0._tf:Find("TopPage")
	arg_2_0.backBtn = arg_2_0._tf:Find("TopPage/top/btn_back")
	arg_2_0.homeBtn = arg_2_0._tf:Find("TopPage/top/btn_home")

	onButton(arg_2_0, arg_2_0.backBtn, function()
		arg_2_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.homeBtn, function()
		arg_2_0.event:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)
	setText(arg_2_0._tf:Find("TopPage/Desc/Desc"), i18n("series_enemy_storyreward"))

	arg_2_0.mapGroup = {}
	arg_2_0.currentBG = nil
	arg_2_0.loader = AutoLoader.New()

	return
end

function var_0_0.SetCoreStoryPage(arg_5_0, arg_5_1)
	arg_5_0.coreStoryPage = arg_5_1

	return
end

function var_0_0.SetActivity(arg_6_0, arg_6_1)
	arg_6_0.activity = arg_6_1

	arg_6_0:BuildStoryTree()

	return
end

function var_0_0.BuildStoryTree(arg_7_0)
	arg_7_0.spStoryIDs = arg_7_0.activity:getConfig("config_client").storys
	arg_7_0.spStoryNodes = {}

	_.each(arg_7_0.spStoryIDs, function(arg_8_0)
		table.insert(arg_7_0.spStoryNodes, ActivitySpStoryNode.New({
			configId = arg_8_0
		}))

		return
	end)

	arg_7_0.nodeRootList, arg_7_0.nodeChildDict = {}, {}

	_.each(arg_7_0.spStoryNodes, function(arg_9_0)
		local var_9_0 = arg_9_0:GetPreNodes()

		if #var_9_0 == 0 then
			table.insert(arg_7_0.nodeRootList, arg_9_0)
		else
			_.each(var_9_0, function(arg_10_0)
				arg_7_0.nodeChildDict[arg_10_0] = arg_7_0.nodeChildDict[arg_10_0] or {}

				table.insert(arg_7_0.nodeChildDict[arg_10_0], arg_9_0)

				return
			end)
		end

		return
	end)

	return
end

function var_0_0.IsShowRed(arg_11_0, arg_11_1)
	arg_11_0:SetActivity(arg_11_1)
	arg_11_0:UpdateStoryNodeStatus()

	local var_11_0 = false

	for iter_11_0 = 1, #arg_11_0.spStoryNodes do
		arg_11_0:checkRequireBlock(arg_11_0.spStoryNodes[iter_11_0])

		if arg_11_0.spStoryUnlockNode then
			var_11_0 = true

			break
		end
	end

	arg_11_0.spStoryUnlockNode = nil
	arg_11_0.spStoryUnreleasedNode = nil

	return var_11_0
end

function var_0_0.UpdateView(arg_12_0, arg_12_1)
	arg_12_0:UpdateStoryNodeStatus()
	arg_12_0:UpdateStory(arg_12_1)
	arg_12_0:Move2UnlockStory()
	arg_12_0:SwitchStoryMapAndBGM()
	setActive(arg_12_0.storyLayer, true)
	arg_12_0:TrySubmitTask()

	return
end

function var_0_0.RecyclePools(arg_13_0)
	for iter_13_0 = #arg_13_0.activeItems, 1, -1 do
		if arg_13_0.activeItems[iter_13_0].template == arg_13_0.oneLineTpl then
			setSizeDelta(arg_13_0.activeItems[iter_13_0].active, {
				x = arg_13_0.oneLineWidth,
				y = arg_13_0.oneLineHeight
			})
		end

		arg_13_0.pools[arg_13_0.activeItems[iter_13_0].template]:Enqueue(arg_13_0.activeItems[iter_13_0].active)
	end

	table.clean(arg_13_0.activeItems)

	arg_13_0.storyNodeTFsById = {}

	return
end

local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function var_0_0.UpdateStoryNodeStatus(arg_14_0)
	local var_14_0 = 0
	local var_14_1 = 0
	local var_14_2 = pg.NewStoryMgr.GetInstance()
	local var_14_3 = getProxy(TaskProxy)
	local var_14_4 = {}

	table.Foreach(arg_14_0.spStoryIDs, function(arg_15_0, arg_15_1)
		var_14_4[arg_15_1] = {}

		return
	end)

	for iter_14_0 = 1, #arg_14_0.spStoryNodes do
		local var_14_5 = arg_14_0.spStoryNodes[iter_14_0]
		local var_14_6 = arg_14_0.spStoryNodes[iter_14_0]:GetConfigID()
		local var_14_7 = arg_14_0.spStoryNodes[iter_14_0]:GetPreEvent()
		local var_14_8 = true
		local var_14_9 = var_0_2
		local var_14_10 = arg_14_0.spStoryNodes[iter_14_0]:GetStoryName()
		local var_14_11 = false

		if var_14_10 and var_14_10 ~= "" then
			var_14_11 = var_14_2:IsPlayed(var_14_10)
			var_14_0 = var_14_0 + (var_14_11 and 1 or 0)
			var_14_1 = var_14_1 + 1
		end

		if not var_14_11 then
			local var_14_12 = {}

			_.each(arg_14_0.spStoryNodes[iter_14_0]:GetUnlockConditions(), function(arg_16_0)
				local var_16_0 = true

				if arg_16_0[1] == ActivitySpStoryNode.CONDITION.TIME then
					var_16_0 = pg.TimeMgr.GetInstance():parseTimeFromConfig(arg_16_0[2]) <= pg.TimeMgr.GetInstance():GetServerTime()
				elseif arg_16_0[1] == ActivitySpStoryNode.CONDITION.PASSCHAPTER then
					var_16_0 = _.all(arg_16_0[2], function(arg_17_0)
						return getProxy(ChapterProxy):getChapterById(arg_17_0, true):isClear()
					end)
				elseif arg_16_0[1] == ActivitySpStoryNode.CONDITION.PT then
					local var_16_1 = arg_16_0[2][3]
					local var_16_2 = 0

					if arg_16_0[2][1] == DROP_TYPE_RESOURCE then
						var_16_2 = getProxy(PlayerProxy):getRawData():getResource(arg_16_0[2][2])
					elseif arg_16_0[2][1] == DROP_TYPE_ITEM then
						var_16_2 = getProxy(BagProxy):getItemCountById(arg_16_0[2][2])
					end

					var_16_0 = var_16_1 <= var_16_2
					var_14_4[var_14_6].reuqire = var_16_1
				elseif arg_16_0[1] == ActivitySpStoryNode.CONDITION.PRE_PASSED then
					var_16_0 = var_14_4[var_14_5:GetPreEvent()].status == var_0_4
				elseif arg_16_0[1] == ActivitySpStoryNode.CONDITION.TASK_FINISHED then
					local var_16_3 = var_14_3:getFinishTaskById(arg_16_0[2]) ~= nil

					var_16_0 = var_16_3
					var_14_4[var_14_6].hasTaskCondition = true
					var_14_4[var_14_6].taskConditionFinished = var_16_3

					if not var_16_3 and arg_16_0[3] and arg_16_0[3] ~= "" then
						var_14_4[var_14_6].taskConditionTextKey = arg_16_0[3]
					end
				end

				table.insert(var_14_12, var_16_0)

				var_14_8 = var_14_8 and var_16_0

				return
			end)

			var_14_4[var_14_6].conditionFinishedList = {}
		end

		if var_14_11 then
			var_14_9 = var_0_4
		elseif true then
			var_14_9 = var_0_3
		end

		var_14_4[var_14_6].status = var_14_9
	end

	arg_14_0.storyNodeStatus = var_14_4
	arg_14_0.storyReadCount, arg_14_0.storyReadMax = var_14_0, var_14_1

	return
end

function var_0_0.checkRequireBlock(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1:GetConfigID()

	if arg_18_0.storyNodeStatus[var_18_0].reuqire and arg_18_0.storyNodeStatus[var_18_0].status ~= var_0_4 and arg_18_1:GetCleanAnimator() then
		if arg_18_0.storyNodeStatus[var_18_0].status == var_0_2 then
			arg_18_0.spStoryUnreleasedNode = arg_18_1

			return false
		elseif arg_18_0.storyNodeStatus[var_18_0].status == var_0_3 then
			if PlayerPrefs.GetInt("player_" .. getProxy(PlayerProxy):getRawData().id .. "_activity_spStoryNodeID_" .. var_18_0 .. "_unlock", 0) == 0 then
				arg_18_0.spStoryUnlockNode = arg_18_1

				return false
			end
		end
	end

	return true
end

function var_0_0.UpdateStory(arg_19_0, arg_19_1)
	arg_19_0:RecyclePools()

	local var_19_0 = arg_19_0.LINE_COLOR
	local var_19_1 = 0
	local var_19_2 = 150
	local var_19_3 = arg_19_0.nodeTplWidth
	local var_19_4 = arg_19_0.oneLineWidth
	local var_19_5 = arg_19_0.branchHeadWidth
	local var_19_6 = arg_19_0.branchUpWidth
	local var_19_7 = arg_19_0.branchUpHeight
	local var_19_8 = arg_19_0.UnionTailWidth
	local var_19_9 = 95
	local var_19_10 = 82
	local var_19_11 = 20
	local var_19_12 = 0
	local var_19_13 = pg.NewStoryMgr.GetInstance()

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.nodeRootList) do
		local var_19_14 = {
			{
				node = iter_19_1,
				nodePos = Vector2.New(150, (iter_19_0 - 1) * 16)
			}
		}

		while (function()
			local var_20_0 = table.remove(var_19_14, 1)

			if not arg_19_0:checkRequireBlock(var_20_0.node) then
				var_19_12 = var_20_0.nodePos.x + var_19_2

				return false
			end

			local var_20_1 = var_20_0.node:GetConfigID()

			;(function()
				local var_21_0 = arg_19_0:DequeItem(arg_19_0.storyNodeTpl, arg_19_1)

				var_21_0.name = var_20_1

				setAnchoredPosition(var_21_0, var_20_0.nodePos)

				arg_19_0.storyNodeTFsById[var_20_1] = {
					nodeTF = tf(var_21_0)
				}

				return
			end)()

			local var_20_2 = arg_19_0.nodeChildDict[var_20_1] or {}

			if #var_20_2 == 0 then
				var_19_12 = var_20_0.nodePos.x + var_19_3 + var_19_2
			elseif #var_20_2 == 1 then
				local var_20_3 = var_20_2[1]:GetConfigID()
				local var_20_4 = arg_19_0:DequeItem(arg_19_0.oneLineTpl, arg_19_1)

				var_20_4.name = string.format("Line%s_%s", var_20_1, var_20_3)

				setAnchoredPosition(var_20_4, var_20_0.nodePos + Vector2.New(var_19_3 + var_19_11, 0))

				nextPos = tf(var_20_4).anchoredPosition + Vector2.New(var_19_4 + var_19_9, 0)

				local var_20_5 = arg_19_0.storyNodeStatus[var_20_3].status

				eachChild(tf(var_20_4):Find("mask/Lines"), function(arg_22_0)
					setImageColor(arg_22_0, Color.NewHex(var_19_0[var_20_5]))

					return
				end)
				table.insert(var_19_14, {
					node = var_20_2[1],
					nodePos = nextPos
				})
			elseif #var_20_2 > 1 then
				local var_20_6 = {}
				local var_20_7

				table.Ipairs(var_20_2, function(arg_23_0, arg_23_1)
					local var_23_0 = 0
					local var_23_1 = arg_23_1

					while (function()
						var_23_0 = var_23_0 + 1

						local var_24_0 = arg_19_0.nodeChildDict[var_23_1:GetConfigID()]

						assert(#var_24_0 <= 1)

						if var_24_0[1] and #var_24_0[1]:GetPreNodes() == 1 then
							var_23_1 = var_24_0[1]

							return true
						else
							var_20_7 = var_24_0[1]
						end

						return
					end)() do
						-- block empty
					end

					var_20_6[arg_23_0] = 0

					return
				end)

				local var_20_8 = _.max({})
				local var_20_9 = var_20_8 * (var_19_3 + var_19_9 + var_19_11) + (var_20_8 - 1) * var_19_4
				local var_20_10 = var_20_0.nodePos + Vector2.New(var_19_3 + var_19_11, 0)

				;(function()
					local var_25_0 = arg_19_0:DequeItem(arg_19_0.branchHeadTpl, arg_19_1)

					setAnchoredPosition(var_25_0, var_20_10)

					var_20_10 = var_20_10 + Vector2.New(var_19_5, 0)

					local var_25_1 = arg_19_0.storyNodeStatus[var_20_2[1]:GetConfigID()].status

					eachChild(tf(var_25_0):Find("mask/Lines"), function(arg_26_0)
						setImageColor(arg_26_0, Color.NewHex(var_19_0[var_25_1]))

						return
					end)

					return
				end)()

				local var_20_11

				table.Ipairs(var_20_2, function(arg_27_0, arg_27_1)
					local var_27_0 = var_19_4

					if var_20_6[arg_27_0] < var_20_8 then
						var_27_0 = (var_20_9 - var_20_6[arg_27_0] * (var_19_3 + var_19_9 + var_19_11)) / (var_20_6[arg_27_0] + 1)
					end

					local var_27_1 = arg_27_1:GetConfigID()
					local var_27_2 = var_20_10

					;(function()
						local var_28_0

						if arg_27_0 == 1 then
							var_28_0 = arg_19_0:DequeItem(arg_19_0.branchUpTpl, arg_19_1)

							setAnchoredPosition(var_28_0, var_27_2)

							var_27_2 = var_27_2 + Vector2.New(var_19_6, var_19_7)

							if var_20_6[arg_27_0] < var_20_8 then
								setSizeDelta(var_28_0, {
									x = var_19_6 + var_27_0,
									y = var_19_7
								})

								local var_28_1 = tf(var_28_0):Find("Line_1").sizeDelta

								var_28_1.x = var_28_1.x + var_27_0

								setSizeDelta(tf(var_28_0):Find("Line_1"), var_28_1)

								var_27_2 = var_27_2 + Vector2.New(var_27_0, 0)
							end
						elseif arg_27_0 == 3 or arg_27_0 == 2 and #var_20_2 == 2 then
							var_28_0 = arg_19_0:DequeItem(arg_19_0.branchDownTpl, arg_19_1)

							setAnchoredPosition(var_28_0, var_27_2)

							var_27_2 = var_27_2 + Vector2.New(var_19_6, -var_19_7)

							if var_20_6[arg_27_0] < var_20_8 then
								setSizeDelta(var_28_0, {
									x = var_19_6 + var_27_0,
									y = var_19_7
								})

								local var_28_2 = tf(var_28_0):Find("Line_1").sizeDelta

								var_28_2.x = var_28_2.x + var_27_0

								setSizeDelta(tf(var_28_0):Find("Line_1"), var_28_2)

								var_27_2 = var_27_2 + Vector2.New(var_27_0, 0)
							end
						else
							var_28_0 = arg_19_0:DequeItem(arg_19_0.branchCenterTpl, arg_19_1)

							setAnchoredPosition(var_28_0, var_27_2)

							var_27_2 = var_27_2 + Vector2.New(var_19_6, 0)

							if var_20_6[arg_27_0] < var_20_8 then
								local var_28_3 = tf(var_28_0).sizeDelta

								var_28_3.x = var_28_3.x + var_27_0

								setSizeDelta(var_28_0, var_28_3)

								var_27_2 = var_27_2 + Vector2.New(var_27_0, 0)
							end
						end

						var_28_0.name = string.format("Branch%s_%s", var_20_1, var_27_1)

						local var_28_4 = arg_19_0.storyNodeStatus[var_27_1].status

						eachChild(tf(var_28_0):Find("mask/Lines"), function(arg_29_0)
							setImageColor(arg_29_0, Color.NewHex(var_19_0[var_28_4]))

							return
						end)

						return
					end)()

					var_27_2 = var_27_2 + Vector2.New(var_19_9, 0)

					if not arg_19_0:checkRequireBlock(arg_27_1) then
						var_19_12 = var_27_2.x
						var_20_11 = true

						return
					end

					local var_27_3 = arg_19_0:DequeItem(arg_19_0.storyNodeTpl, arg_19_1)

					var_27_3.name = var_27_1

					setAnchoredPosition(var_27_3, var_27_2)

					arg_19_0.storyNodeTFsById[var_27_1] = {
						nodeTF = tf(var_27_3)
					}
					var_27_2 = var_27_2 + Vector2.New(var_19_3 + var_19_11, 0)

					local var_27_4 = arg_19_0.nodeChildDict[var_27_1][1]
					local var_27_5 = arg_27_1

					while (function()
						if not var_27_4 or var_27_4 == var_20_7 then
							return
						end

						local var_30_0 = arg_19_0:DequeItem(arg_19_0.oneLineTpl, arg_19_1)

						var_30_0.name = string.format("Line%s_%s", var_27_5:GetConfigID(), var_27_4:GetConfigID())

						setAnchoredPosition(var_30_0, var_27_2)

						var_27_2 = var_27_2 + Vector2.New(var_27_0 + var_19_9, 0)

						setSizeDelta(var_30_0, {
							x = var_27_0,
							y = arg_19_0.oneLineHeight
						})

						local var_30_1 = arg_19_0.storyNodeStatus[var_27_4:GetConfigID()].status

						eachChild(tf(var_30_0):Find("mask/Lines"), function(arg_31_0)
							setImageColor(arg_31_0, Color.NewHex(var_19_0[var_30_1]))

							return
						end)

						if not arg_19_0:checkRequireBlock(var_27_4) then
							var_19_12 = var_27_2.x
							var_20_11 = true

							return
						end

						local var_30_2 = arg_19_0:DequeItem(arg_19_0.storyNodeTpl, arg_19_1)

						var_30_2.name = var_27_4:GetConfigID()

						setAnchoredPosition(var_30_2, var_27_2)

						arg_19_0.storyNodeTFsById[var_27_4:GetConfigID()] = {
							nodeTF = tf(var_30_2)
						}
						var_27_2 = var_27_2 + Vector2.New(var_19_3 + var_19_11, 0)
						var_27_4, var_27_5 = arg_19_0.nodeChildDict[var_27_4:GetConfigID()][1], var_27_4

						return true
					end)() do
						-- block empty
					end

					if var_20_7 then
						local var_27_6

						if arg_27_0 == 1 then
							var_27_6 = arg_19_0:DequeItem(arg_19_0.unionUpTpl, arg_19_1)

							setAnchoredPosition(var_27_6, var_27_2)

							if var_20_6[arg_27_0] < var_20_8 then
								setSizeDelta(var_27_6, {
									x = var_19_6 + var_27_0,
									y = var_19_7
								})

								local var_27_7 = tf(var_27_6):Find("Line_1").sizeDelta

								var_27_7.x = var_27_7.x + var_27_0

								setSizeDelta(tf(var_27_6):Find("Line_1"), var_27_7)

								var_27_2 = var_27_2 + Vector2.New(var_27_0, 0)
							end
						elseif arg_27_0 == 3 or arg_27_0 == 2 and #var_20_2 == 2 then
							var_27_6 = arg_19_0:DequeItem(arg_19_0.unionDownTpl, arg_19_1)

							setAnchoredPosition(var_27_6, var_27_2)

							if var_20_6[arg_27_0] < var_20_8 then
								setSizeDelta(var_27_6, {
									x = var_19_6 + var_27_0,
									y = var_19_7
								})

								local var_27_8 = tf(var_27_6):Find("Line_1").sizeDelta

								var_27_8.x = var_27_8.x + var_27_0

								setSizeDelta(tf(var_27_6):Find("Line_1"), var_27_8)

								var_27_2 = var_27_2 + Vector2.New(var_27_0, 0)
							end
						else
							var_27_6 = arg_19_0:DequeItem(arg_19_0.unionCenterTpl, arg_19_1)

							setAnchoredPosition(var_27_6, var_27_2)

							if var_20_6[arg_27_0] < var_20_8 then
								local var_27_9 = tf(var_27_6).sizeDelta

								var_27_9.x = var_27_9.x + var_27_0

								setSizeDelta(var_27_6, var_27_9)

								var_27_2 = var_27_2 + Vector2.New(var_27_0, 0)
							end
						end

						var_27_6.name = string.format("Union%s_%s", var_27_5:GetConfigID(), var_20_7:GetConfigID())

						local var_27_10 = arg_19_0.storyNodeStatus[var_20_7:GetConfigID()].status

						eachChild(tf(var_27_6):Find("mask/Lines"), function(arg_32_0)
							setImageColor(arg_32_0, Color.NewHex(var_19_0[var_27_10]))

							return
						end)
					end

					return
				end)

				if nil then
					return false
				end

				var_20_10 = var_20_10 + Vector2.New(var_20_8 * (var_19_3 + var_19_9 + var_19_11) + (var_20_8 - 1) * var_19_4 + var_19_6, 0)

				if nil then
					(function()
						var_20_10 = var_20_10 + Vector2.New(var_19_6, 0)

						local var_33_0 = arg_19_0:DequeItem(arg_19_0.unionTailTpl, arg_19_1)

						setAnchoredPosition(var_33_0, var_20_10)

						var_20_10 = var_20_10 + Vector2.New(var_19_8 + var_19_10, 0)

						local var_33_1 = arg_19_0.storyNodeStatus[var_20_7:GetConfigID()].status

						eachChild(tf(var_33_0):Find("mask/Lines"), function(arg_34_0)
							setImageColor(arg_34_0, Color.NewHex(var_19_0[var_33_1]))

							return
						end)

						return
					end)()
					table.insert(var_19_14, {
						node = nil,
						nodePos = var_20_10
					})
				else
					var_19_12 = var_20_10 + var_19_2
				end
			end

			return next(var_19_14)
		end)() do
			-- block empty
		end

		var_19_1 = math.max(var_19_1, 0)
	end

	setSizeDelta(arg_19_0.storyContainer, {
		x = var_19_1
	})

	if arg_19_0.spStoryUnreleasedNode or arg_19_0.spStoryUnlockNode then
		local var_19_15 = tf(arg_19_0:DequeItem(arg_19_0.unreleasedNodeTpl), arg_19_1)

		setAnchoredPosition(var_19_15, {
			y = 0,
			x = 0
		})

		local var_19_16

		if arg_19_0.spStoryUnreleasedNode then
			setText(var_19_15:Find("text"), i18n("scenario_unlock_pt_require", arg_19_0.storyNodeStatus[arg_19_0.spStoryUnreleasedNode:GetConfigID()].reuqire))

			var_19_16 = arg_19_0.spStoryUnreleasedNode:GetCleanAnimator()
		elseif arg_19_0.spStoryUnlockNode then
			setText(var_19_15:Find("text"), i18n("scenario_unlock"))

			local var_19_17 = arg_19_0.spStoryUnlockNode:GetConfigID()

			onButton(arg_19_0, var_19_15:Find("btn_unlock"), function()
				PlayerPrefs.SetInt("player_" .. getProxy(PlayerProxy):getRawData().id .. "_activity_spStoryNodeID_" .. var_19_17 .. "_unlock", 1)
				arg_19_0:UpdateView(true)
				arg_19_0:Move2UnlockStory()

				return
			end)

			var_19_16 = arg_19_0.spStoryUnlockNode:GetCleanAnimator()
		end

		ResourceMgr.Inst:getAssetAsync("ui/" .. var_19_16, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_36_0)
			local var_36_0 = Instantiate(arg_36_0)

			tf(var_36_0).localPosition = Vector3.New(-525, 0, 0)

			setParent(var_36_0, var_19_15)
			WorldConst.ArrayEffectOrder(var_19_15, 200)

			return
		end), true, true)
	end

	arg_19_0.spStoryUnreleasedNode = nil
	arg_19_0.spStoryUnlockNode = nil

	for iter_19_2 = 1, #arg_19_0.spStoryNodes do
		local var_19_18 = arg_19_0.spStoryNodes[iter_19_2]
		local var_19_19 = arg_19_0.spStoryNodes[iter_19_2]:GetConfigID()

		if arg_19_0.storyNodeTFsById[var_19_19] then
			local var_19_20 = arg_19_0.storyNodeStatus[var_19_19].status
			local var_19_21 = arg_19_0.storyNodeTFsById[var_19_19].nodeTF
			local var_19_22 = arg_19_0.storyNodeTFsById[var_19_19].nodeTF:Find("info/bk/title_form/title")
			local var_19_23 = arg_19_0.TITLE_ALPHA or {
				0.5,
				1,
				1
			}

			if arg_19_0.TITLE_COLOR and arg_19_0.TITLE_COLOR[var_19_20] then
				setTextColor(var_19_22, Color.NewHex(arg_19_0.TITLE_COLOR[var_19_20]))
			end

			if var_19_20 == var_0_2 then
				local var_19_24 = var_19_18:GetUnlockDesc()
				local var_19_25 = ""

				if type(var_19_24) == "table" then
					local var_19_26 = arg_19_0.storyNodeStatus[var_19_19].conditionFinishedList or {}

					var_19_25 = var_19_24[1] or ""

					for iter_19_3, iter_19_4 in ipairs(var_19_24) do
						if not var_19_26[iter_19_3] then
							var_19_25 = iter_19_4 or ""

							break
						end
					end
				else
					var_19_25 = var_19_24 or ""
				end

				arg_19_0:RefreshUnlockDesc(var_19_21, HXSet.hxLan(var_19_18:GetDisplayName()), HXSet.hxLan(var_19_25))

				local var_19_28 = var_19_23[var_19_20] or 0.5

				setTextAlpha(var_19_22, var_19_28)
			else
				arg_19_0:RefreshNodeTitle(var_19_21, HXSet.hxLan(var_19_18:GetDisplayName()))

				local var_19_30 = var_19_23[var_19_20] or 1

				setTextAlpha(var_19_22, var_19_30)
			end

			local var_19_31 = var_19_18:GetType()

			setActive(var_19_21:Find("circle/lock"), var_19_20 == var_0_2)

			if var_19_20 == var_0_2 then
				setActive(var_19_21:Find("circle/Story"), false)
				setActive(var_19_21:Find("circle/Battle"), false)
				setText(var_19_21:Find(""))
			elseif var_19_31 == ActivitySpStoryNode.NODE_TYPE.STORY then
				setActive(var_19_21:Find("circle/Story"), var_19_31 == ActivitySpStoryNode.NODE_TYPE.STORY)
				setActive(var_19_21:Find("circle/Battle"), var_19_31 == ActivitySpStoryNode.NODE_TYPE.BATTLE)
				setActive(var_19_21:Find("circle/Story/Done"), var_19_20 == var_0_4)
			elseif var_19_31 == ActivitySpStoryNode.NODE_TYPE.BATTLE then
				setActive(var_19_21:Find("circle/Story"), var_19_31 == ActivitySpStoryNode.NODE_TYPE.STORY)
				setActive(var_19_21:Find("circle/Battle"), var_19_31 == ActivitySpStoryNode.NODE_TYPE.BATTLE)
				setActive(var_19_21:Find("circle/Battle/Done"), var_19_20 == var_0_4)
			end

			setActive(var_19_21:Find("circle/bk/Inactive"), var_19_20 == var_0_2)
			setActive(var_19_21:Find("circle/bk/Active"), var_19_20 == var_0_3)
			setActive(var_19_21:Find("circle/bk/Readed"), var_19_20 == var_0_4)
			setActive(var_19_21:Find("info/bk/BG/Inactive"), var_19_20 == var_0_2)
			setActive(var_19_21:Find("info/bk/BG/Active"), var_19_20 ~= var_0_2)

			local var_19_32 = var_19_21:Find("condition")

			if var_19_32 then
				local var_19_33 = arg_19_0.storyNodeStatus[var_19_19].hasTaskCondition and not arg_19_0.storyNodeStatus[var_19_19].taskConditionFinished

				setActive(var_19_32, var_19_33)

				if var_19_33 then
					local var_19_34 = arg_19_0.storyNodeStatus[var_19_19].taskConditionTextKey and i18n(arg_19_0.storyNodeStatus[var_19_19].taskConditionTextKey) or ""
					local var_19_35 = var_19_32:Find("Text") or var_19_32:Find("text")

					if var_19_35 then
						setText(var_19_35, var_19_34)
					else
						setText(var_19_32, var_19_34)
					end
				end
			end

			onButton(arg_19_0, var_19_21, function()
				if var_19_20 == var_0_2 then
					return
				end

				arg_19_0:PlayStory(var_19_18:GetStoryName(), function()
					arg_19_0:UpdateView(true)
					arg_19_0:Move2UnlockStory()

					return
				end, true)

				return
			end)
		end
	end

	setText(arg_19_0.progressText, arg_19_0.storyReadCount .. "/" .. arg_19_0.storyReadMax)
	setActive(arg_19_0.storyAward, tobool(arg_19_0.storyTask))

	if arg_19_0.storyTask then
		local var_19_36 = arg_19_0.storyTask:getConfig("award_display")

		updateDrop(arg_19_0.storyAward:Find("IconTpl"), (Drop.New({
			type = var_19_36[1][1],
			id = var_19_36[1][2],
			count = var_19_36[1][3]
		})))

		local var_19_37 = arg_19_0.storyTask:getTaskStatus()

		setActive(arg_19_0.storyAward:Find("get"), var_19_37 == 1)
		setActive(arg_19_0.storyAward:Find("got"), var_19_37 == 2)
		onButton(arg_19_0, arg_19_0.storyAward, function()
			arg_19_0.coreStoryPage:emit(BaseUI.ON_DROP, var_0)

			return
		end)
	end

	return
end

function var_0_0.DequeItem(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_0.pools[arg_40_1]:Dequeue()

	table.insert(arg_40_0.activeItems, {
		template = arg_40_1,
		active = var_40_0
	})
	setActive(var_40_0, true)
	setParent(var_40_0, arg_40_0.storyContainer)

	local var_40_1 = var_40_0:GetComponent(typeof(Animation))

	if var_40_1 then
		var_40_1.enabled = not arg_40_2
	end

	return var_40_0
end

function var_0_0.Move2UnlockStory(arg_41_0)
	local var_41_0

	for iter_41_0 = #arg_41_0.spStoryNodes, 1, -1 do
		local var_41_1 = arg_41_0.spStoryNodes[iter_41_0]:GetConfigID()

		if arg_41_0.storyNodeStatus[var_41_1].status > var_0_2 and (not arg_41_0.storyNodeStatus[var_41_1].reuqire or not arg_41_0.spStoryNodes[iter_41_0]:GetCleanAnimator()) then
			var_41_0 = var_41_1

			break
		end
	end

	if not var_41_0 then
		for iter_41_1 = 1, #arg_41_0.spStoryNodes do
			local var_41_2 = arg_41_0.spStoryNodes[iter_41_1]:GetConfigID()

			if arg_41_0.storyNodeTFsById[var_41_2] then
				var_41_0 = var_41_2

				break
			end
		end
	end

	if not var_41_0 then
		setAnchoredPosition(arg_41_0.storyContainer, {
			x = 0
		})

		return
	end

	;({}).x = -math.clamp(arg_41_0.storyNodeTFsById[var_41_0].nodeTF.anchoredPosition.x + arg_41_0.storyNodeTpl.rect.width * 0.5 - arg_41_0.storyContainer.parent.rect.width * 0.5, 0, math.max(0, arg_41_0.storyContainer.rect.width - arg_41_0.storyContainer.parent.rect.width))

	setAnchoredPosition(arg_41_0.storyContainer, {})

	return
end

function var_0_0.SwitchStoryMapAndBGM(arg_42_0)
	local var_42_0 = arg_42_0.activity:getConfig("config_client").default_background
	local var_42_1 = arg_42_0.activity:getConfig("config_client").default_bgm

	for iter_42_0 = 1, #arg_42_0.spStoryNodes do
		if arg_42_0.storyNodeStatus[arg_42_0.spStoryNodes[iter_42_0]:GetConfigID()].status == var_0_4 then
			local var_42_3 = arg_42_0.spStoryNodes[iter_42_0]:GetCleanAnimator()

			var_42_0 = arg_42_0.spStoryNodes[iter_42_0]:GetCleanBG() ~= "" and arg_42_0.spStoryNodes[iter_42_0]:GetCleanBG() or var_42_0

			if arg_42_0.spStoryNodes[iter_42_0]:GetCleanBGM() ~= "" then
				var_42_1 = arg_42_0.spStoryNodes[iter_42_0]:GetCleanBGM() or var_42_1
			end
		else
			break
		end
	end

	if var_42_0 ~= nil and var_42_0 ~= "" then
		arg_42_0:SwitchBG({
			{
				BG = var_42_0
			}
		})
	end

	if var_42_1 ~= nil and var_42_1 ~= "" then
		pg.BgmMgr.GetInstance():Push(arg_42_0.__cname, var_42_1)
	end

	return
end

function var_0_0.SwitchBG(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	if not arg_43_1 or #arg_43_1 <= 0 then
		existCall(arg_43_2)

		return
	elseif arg_43_3 then
		-- block empty
	elseif table.equal(arg_43_0.currentBG, arg_43_1) then
		return
	end

	arg_43_0.currentBG = arg_43_1

	for iter_43_0, iter_43_1 in ipairs(arg_43_0.mapGroup) do
		arg_43_0.loader:ClearRequest(iter_43_1)
	end

	table.clear(arg_43_0.mapGroup)
	table.insert(arg_43_0.mapGroup, (arg_43_0.loader:GetSpriteDirect("bg/" .. arg_43_1[1].BG, "", function(arg_44_0)
		setImageSprite(arg_43_0.bg, arg_44_0)
		SetActive(arg_43_0.bg, true)

		return
	end)))

	return
end

function var_0_0.TrySubmitTask(arg_45_0)
	local var_45_0 = true

	for iter_45_0, iter_45_1 in ipairs(arg_45_0.spStoryNodes) do
		local var_45_1 = iter_45_1:GetStoryName()

		if var_45_1 and var_45_1 ~= "" then
			var_45_0 = var_45_0 and pg.NewStoryMgr.GetInstance():IsPlayed(var_45_1)
		end

		if not var_45_0 then
			break
		end
	end

	arg_45_0:UpdateStoryTask()

	if var_45_0 and arg_45_0.storyTask and arg_45_0.storyTask:getTaskStatus() == 1 then
		arg_45_0.coreStoryPage:emit(ActivityMediator.ON_TASK_SUBMIT, arg_45_0.storyTask)

		return
	end

	return
end

function var_0_0.PlayStory(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	if not arg_46_1 then
		return existCall(arg_46_2)
	end

	local var_46_0 = pg.NewStoryMgr.GetInstance()
	local var_46_1 = var_46_0:IsPlayed(arg_46_1)

	seriesAsync({
		function(arg_47_0)
			if var_46_1 and not arg_46_3 then
				return arg_47_0()
			end

			local var_47_0 = tonumber(arg_46_1)

			if var_47_0 and var_47_0 > 0 then
				arg_46_0.coreStoryPage:emit(ActivityMediator.GO_PERFORM_COMBAT, {
					stageId = var_47_0,
					exitCallback = arg_46_2
				})
			else
				var_46_0:Play(arg_46_1, arg_47_0, arg_46_3)
			end

			return
		end,
		function(arg_48_0, ...)
			existCall(arg_46_2, ...)

			return
		end
	})

	return
end

function var_0_0.UpdateStoryTask(arg_49_0)
	local var_49_0 = arg_49_0.activity:getConfig("config_client").task_id
	local var_49_1 = getProxy(TaskProxy):getTaskVO(var_49_0)

	if not var_49_1 then
		errorMsg("Missing Activity Task ID : " .. var_49_0)
	end

	arg_49_0.storyTask = var_49_1 or Task.New({
		id = var_49_0
	})

	return
end

function var_0_0.OnSubmitTaskDone(arg_50_0)
	arg_50_0:UpdateView()

	return
end

function var_0_0.RefreshNodeTitle(arg_51_0, arg_51_1, arg_51_2)
	setScrollText(arg_51_1:Find("info/bk/title_form/title"), arg_51_2)

	return
end

function var_0_0.RefreshUnlockDesc(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	setScrollText(arg_52_1:Find("info/bk/title_form/title"), arg_52_3)

	return
end

function var_0_0.Show(arg_53_0)
	var_0_0.super.Show(arg_53_0)
	arg_53_0:OverlayPanel(arg_53_0._tf)
	arg_53_0:OverlayPanel(arg_53_0.topPage, {
		stopTop = true
	})

	return
end

function var_0_0.Hide(arg_54_0)
	arg_54_0:UnOverlayPanel(arg_54_0.topPage, arg_54_0._tf)
	arg_54_0:UnOverlayPanel(arg_54_0._tf, arg_54_0._parentTf)
	var_0_0.super.Hide(arg_54_0)

	return
end

function var_0_0.OnDestroy(arg_55_0)
	arg_55_0:RecyclePools()

	for iter_55_0, iter_55_1 in pairs(arg_55_0.pools) do
		iter_55_1:Clear()
	end

	return
end

return var_0_0

local CoreScenarioTemplatePage = class("CoreScenarioTemplatePage", import("view.base.BaseSubView"))
local PoolPlural = import("Mgr/Pool/PoolPlural")

CoreScenarioTemplatePage.LINE_COLOR = {
	"43536c",
	"dbe7ea",
	"db6587"
}
CoreScenarioTemplatePage.TITLE_COLOR = nil
CoreScenarioTemplatePage.TITLE_ALPHA = {
	0.5,
	1,
	1
}

function CoreScenarioTemplatePage:getUIName()
	return "AEBCSScenarioPage"
end

function CoreScenarioTemplatePage:OnInit()
	self.storyLayer = self._tf:Find("Story")
	self.top = self._tf:Find("TopPage")
	self.bg = self._tf:Find("bg")
	self.storyHolder = self._tf:Find("Story/Nodes")
	self.storyContainer = self.storyHolder:Find("Viewport/Content")
	self.nodes = {}
	self.progressText = self._tf:Find("TopPage/Desc/Text")
	self.storyAward = self._tf:Find("TopPage/Award")
	self.storyNodeTpl = self._tf:Find("Story/NodeTemplate")
	self.oneLineTpl = self._tf:Find("Story/OneLine")
	self.branchHeadTpl = self._tf:Find("Story/BranchHead")
	self.branchCenterTpl = self._tf:Find("Story/BranchCenter")
	self.branchUpTpl = self._tf:Find("Story/BranchUp")
	self.branchDownTpl = self._tf:Find("Story/BranchDown")
	self.unionTailTpl = self._tf:Find("Story/UnionTail")
	self.unionCenterTpl = self._tf:Find("Story/UnionCenter")
	self.unionUpTpl = self._tf:Find("Story/UnionUp")
	self.unionDownTpl = self._tf:Find("Story/UnionDown")
	self.unreleasedNodeTpl = self._tf:Find("Story/UnreleasedNode")

	setActive(self.storyNodeTpl, false)
	setActive(self.oneLineTpl, false)
	setActive(self.branchHeadTpl, false)
	setActive(self.branchCenterTpl, false)
	setActive(self.branchUpTpl, false)
	setActive(self.branchDownTpl, false)
	setActive(self.unionTailTpl, false)
	setActive(self.unionCenterTpl, false)
	setActive(self.unionUpTpl, false)
	setActive(self.unionDownTpl, false)
	setActive(self.unreleasedNodeTpl, false)

	self.pools = {
		[self.storyNodeTpl] = PoolPlural.New(go(self.storyNodeTpl), 0),
		[self.oneLineTpl] = PoolPlural.New(go(self.oneLineTpl), 0),
		[self.branchHeadTpl] = PoolPlural.New(go(self.branchHeadTpl), 0),
		[self.branchCenterTpl] = PoolPlural.New(go(self.branchCenterTpl), 0),
		[self.branchUpTpl] = PoolPlural.New(go(self.branchUpTpl), 0),
		[self.branchDownTpl] = PoolPlural.New(go(self.branchDownTpl), 0),
		[self.unionTailTpl] = PoolPlural.New(go(self.unionTailTpl), 0),
		[self.unionCenterTpl] = PoolPlural.New(go(self.unionCenterTpl), 0),
		[self.unionUpTpl] = PoolPlural.New(go(self.unionUpTpl), 0),
		[self.unionDownTpl] = PoolPlural.New(go(self.unionDownTpl), 0),
		[self.unreleasedNodeTpl] = PoolPlural.New(go(self.unreleasedNodeTpl), 0)
	}
	self.nodeTplWidth = self.storyNodeTpl.rect.width
	self.oneLineWidth = self.oneLineTpl.rect.width
	self.oneLineHeight = self.oneLineTpl.rect.height
	self.branchHeadWidth = self.branchHeadTpl.rect.width
	self.branchUpWidth = self.branchUpTpl.rect.width
	self.branchUpHeight = self.branchUpTpl.rect.height
	self.UnionTailWidth = self.unionTailTpl.rect.width
	self.activeItems = {}
	self.displayChapterIDs = {}
	self.chapterTFsById = {}
	self.storyNodeTFsById = {}
	self.topPage = self._tf:Find("TopPage")
	self.backBtn = self._tf:Find("TopPage/top/btn_back")
	self.homeBtn = self._tf:Find("TopPage/top/btn_home")

	onButton(self, self.backBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.homeBtn, function()
		self.event:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)
	setText(self._tf:Find("TopPage/Desc/Desc"), i18n("series_enemy_storyreward"))

	self.mapGroup = {}
	self.currentBG = nil
	self.loader = AutoLoader.New()

	return
end

function CoreScenarioTemplatePage:SetCoreStoryPage(arg_5_1)
	self.coreStoryPage = arg_5_1

	return
end

function CoreScenarioTemplatePage:SetActivity(arg_6_1)
	self.activity = arg_6_1

	self:BuildStoryTree()

	return
end

function CoreScenarioTemplatePage:BuildStoryTree()
	self.spStoryIDs = self.activity:getConfig("config_client").storys
	self.spStoryNodes = {}

	_.each(self.spStoryIDs, function(arg_8_0)
		table.insert(self.spStoryNodes, ActivitySpStoryNode.New({
			configId = arg_8_0
		}))

		return
	end)

	self.nodeRootList, self.nodeChildDict = {}, {}

	_.each(self.spStoryNodes, function(arg_9_0)
		local var_9_0 = arg_9_0:GetPreNodes()

		if #var_9_0 == 0 then
			table.insert(self.nodeRootList, arg_9_0)
		else
			_.each(var_9_0, function(arg_10_0)
				self.nodeChildDict[arg_10_0] = self.nodeChildDict[arg_10_0] or {}

				table.insert(self.nodeChildDict[arg_10_0], arg_9_0)

				return
			end)
		end

		return
	end)

	return
end

function CoreScenarioTemplatePage:IsShowRed(arg_11_1)
	self:SetActivity(arg_11_1)
	self:UpdateStoryNodeStatus()

	local var_11_0 = false

	for iter_11_0 = 1, #self.spStoryNodes do
		self:checkRequireBlock(self.spStoryNodes[iter_11_0])

		if self.spStoryUnlockNode then
			var_11_0 = true

			break
		end
	end

	self.spStoryUnlockNode = nil
	self.spStoryUnreleasedNode = nil

	return var_11_0
end

function CoreScenarioTemplatePage:UpdateView(arg_12_1)
	self:UpdateStoryNodeStatus()
	self:UpdateStory(arg_12_1)
	self:Move2UnlockStory()
	self:SwitchStoryMapAndBGM()
	setActive(self.storyLayer, true)
	self:TrySubmitTask()

	return
end

function CoreScenarioTemplatePage:RecyclePools()
	for iter_13_0 = #self.activeItems, 1, -1 do
		if self.activeItems[iter_13_0].template == self.oneLineTpl then
			setSizeDelta(self.activeItems[iter_13_0].active, {
				x = self.oneLineWidth,
				y = self.oneLineHeight
			})
		end

		self.pools[self.activeItems[iter_13_0].template]:Enqueue(self.activeItems[iter_13_0].active)
	end

	table.clean(self.activeItems)

	self.storyNodeTFsById = {}

	return
end

local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function CoreScenarioTemplatePage:UpdateStoryNodeStatus()
	local var_14_0 = 0
	local var_14_1 = 0
	local var_14_2 = pg.NewStoryMgr.GetInstance()
	local var_14_3 = getProxy(TaskProxy)
	local var_14_4 = {}

	table.Foreach(self.spStoryIDs, function(arg_15_0, arg_15_1)
		var_14_4[arg_15_1] = {}

		return
	end)

	for iter_14_0 = 1, #self.spStoryNodes do
		local var_14_5 = self.spStoryNodes[iter_14_0]
		local var_14_6 = self.spStoryNodes[iter_14_0]:GetConfigID()
		local var_14_7 = self.spStoryNodes[iter_14_0]:GetPreEvent()
		local var_14_8 = true
		local var_14_9 = var_0_2
		local var_14_10 = self.spStoryNodes[iter_14_0]:GetStoryName()
		local var_14_11 = false

		if var_14_10 and var_14_10 ~= "" then
			var_14_11 = var_14_2:IsPlayed(var_14_10)
			var_14_0 = var_14_0 + (var_14_11 and 1 or 0)
			var_14_1 = var_14_1 + 1
		end

		if not var_14_11 then
			local var_14_12 = {}

			_.each(self.spStoryNodes[iter_14_0]:GetUnlockConditions(), function(arg_16_0)
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

			var_14_4[var_14_6].conditionFinishedList = var_14_12
		end

		if var_14_11 then
			var_14_9 = var_0_4
		elseif true then
			var_14_9 = var_0_3
		end

		var_14_4[var_14_6].status = var_14_9
	end

	self.storyNodeStatus = var_14_4
	self.storyReadCount, self.storyReadMax = var_14_0, var_14_1

	return
end

function CoreScenarioTemplatePage:checkRequireBlock(arg_18_1)
	local var_18_0 = arg_18_1:GetConfigID()

	if self.storyNodeStatus[var_18_0].reuqire and self.storyNodeStatus[var_18_0].status ~= var_0_4 and arg_18_1:GetCleanAnimator() then
		if self.storyNodeStatus[var_18_0].status == var_0_2 then
			self.spStoryUnreleasedNode = arg_18_1

			return false
		elseif self.storyNodeStatus[var_18_0].status == var_0_3 then
			if PlayerPrefs.GetInt("player_" .. getProxy(PlayerProxy):getRawData().id .. "_activity_spStoryNodeID_" .. var_18_0 .. "_unlock", 0) == 0 then
				self.spStoryUnlockNode = arg_18_1

				return false
			end
		end
	end

	return true
end

function CoreScenarioTemplatePage:UpdateStory(arg_19_1)
	self:RecyclePools()

	local var_19_0 = self.LINE_COLOR
	local var_19_1 = 0
	local var_19_2 = 150
	local var_19_3 = self.nodeTplWidth
	local var_19_4 = self.oneLineWidth
	local var_19_5 = self.branchHeadWidth
	local var_19_6 = self.branchUpWidth
	local var_19_7 = self.branchUpHeight
	local var_19_8 = self.UnionTailWidth
	local var_19_9 = 95
	local var_19_10 = 82
	local var_19_11 = 20
	local var_19_12 = 0
	local var_19_13 = pg.NewStoryMgr.GetInstance()

	for iter_19_0, iter_19_1 in ipairs(self.nodeRootList) do
		local var_19_14 = {
			{
				node = iter_19_1,
				nodePos = Vector2.New(150, (iter_19_0 - 1) * 16)
			}
		}

		while (function()
			local var_20_0 = table.remove(var_19_14, 1)

			if not self:checkRequireBlock(var_20_0.node) then
				var_19_12 = var_20_0.nodePos.x + var_19_2

				return false
			end

			local var_20_1 = var_20_0.node:GetConfigID()

			;(function()
				local var_21_0 = self:DequeItem(self.storyNodeTpl, arg_19_1)

				var_21_0.name = var_20_1

				setAnchoredPosition(var_21_0, var_20_0.nodePos)

				self.storyNodeTFsById[var_20_1] = {
					nodeTF = tf(var_21_0)
				}

				return
			end)()

			local var_20_2 = self.nodeChildDict[var_20_1] or {}

			if #var_20_2 == 0 then
				var_19_12 = var_20_0.nodePos.x + var_19_3 + var_19_2
			elseif #var_20_2 == 1 then
				local var_20_3 = var_20_2[1]:GetConfigID()
				local var_20_4 = self:DequeItem(self.oneLineTpl, arg_19_1)

				var_20_4.name = string.format("Line%s_%s", var_20_1, var_20_3)

				setAnchoredPosition(var_20_4, var_20_0.nodePos + Vector2.New(var_19_3 + var_19_11, 0))

				nextPos = tf(var_20_4).anchoredPosition + Vector2.New(var_19_4 + var_19_9, 0)

				local var_20_5 = self.storyNodeStatus[var_20_3].status

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

						local var_24_0 = self.nodeChildDict[var_23_1:GetConfigID()]

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

				local var_20_8 = _.max(var_20_6)
				local var_20_9 = var_20_8 * (var_19_3 + var_19_9 + var_19_11) + (var_20_8 - 1) * var_19_4
				local var_20_10 = var_20_0.nodePos + Vector2.New(var_19_3 + var_19_11, 0)

				;(function()
					local var_25_0 = self:DequeItem(self.branchHeadTpl, arg_19_1)

					setAnchoredPosition(var_25_0, var_20_10)

					var_20_10 = var_20_10 + Vector2.New(var_19_5, 0)

					local var_25_1 = self.storyNodeStatus[var_20_2[1]:GetConfigID()].status

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
							var_28_0 = self:DequeItem(self.branchUpTpl, arg_19_1)

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
							var_28_0 = self:DequeItem(self.branchDownTpl, arg_19_1)

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
							var_28_0 = self:DequeItem(self.branchCenterTpl, arg_19_1)

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

						local var_28_4 = self.storyNodeStatus[var_27_1].status

						eachChild(tf(var_28_0):Find("mask/Lines"), function(arg_29_0)
							setImageColor(arg_29_0, Color.NewHex(var_19_0[var_28_4]))

							return
						end)

						return
					end)()

					var_27_2 = var_27_2 + Vector2.New(var_19_9, 0)

					if not self:checkRequireBlock(arg_27_1) then
						var_19_12 = var_27_2.x
						var_20_11 = true

						return
					end

					local var_27_3 = self:DequeItem(self.storyNodeTpl, arg_19_1)

					var_27_3.name = var_27_1

					setAnchoredPosition(var_27_3, var_27_2)

					self.storyNodeTFsById[var_27_1] = {
						nodeTF = tf(var_27_3)
					}
					var_27_2 = var_27_2 + Vector2.New(var_19_3 + var_19_11, 0)

					local var_27_4 = self.nodeChildDict[var_27_1][1]
					local var_27_5 = arg_27_1

					while (function()
						if not var_27_4 or var_27_4 == var_20_7 then
							return
						end

						local var_30_0 = self:DequeItem(self.oneLineTpl, arg_19_1)

						var_30_0.name = string.format("Line%s_%s", var_27_5:GetConfigID(), var_27_4:GetConfigID())

						setAnchoredPosition(var_30_0, var_27_2)

						var_27_2 = var_27_2 + Vector2.New(var_27_0 + var_19_9, 0)

						setSizeDelta(var_30_0, {
							x = var_27_0,
							y = self.oneLineHeight
						})

						local var_30_1 = self.storyNodeStatus[var_27_4:GetConfigID()].status

						eachChild(tf(var_30_0):Find("mask/Lines"), function(arg_31_0)
							setImageColor(arg_31_0, Color.NewHex(var_19_0[var_30_1]))

							return
						end)

						if not self:checkRequireBlock(var_27_4) then
							var_19_12 = var_27_2.x
							var_20_11 = true

							return
						end

						local var_30_2 = self:DequeItem(self.storyNodeTpl, arg_19_1)

						var_30_2.name = var_27_4:GetConfigID()

						setAnchoredPosition(var_30_2, var_27_2)

						self.storyNodeTFsById[var_27_4:GetConfigID()] = {
							nodeTF = tf(var_30_2)
						}
						var_27_2 = var_27_2 + Vector2.New(var_19_3 + var_19_11, 0)
						var_27_4, var_27_5 = self.nodeChildDict[var_27_4:GetConfigID()][1], var_27_4

						return true
					end)() do
						-- block empty
					end

					if var_20_7 then
						local var_27_6

						if arg_27_0 == 1 then
							var_27_6 = self:DequeItem(self.unionUpTpl, arg_19_1)

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
							var_27_6 = self:DequeItem(self.unionDownTpl, arg_19_1)

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
							var_27_6 = self:DequeItem(self.unionCenterTpl, arg_19_1)

							setAnchoredPosition(var_27_6, var_27_2)

							if var_20_6[arg_27_0] < var_20_8 then
								local var_27_9 = tf(var_27_6).sizeDelta

								var_27_9.x = var_27_9.x + var_27_0

								setSizeDelta(var_27_6, var_27_9)

								var_27_2 = var_27_2 + Vector2.New(var_27_0, 0)
							end
						end

						var_27_6.name = string.format("Union%s_%s", var_27_5:GetConfigID(), var_20_7:GetConfigID())

						local var_27_10 = self.storyNodeStatus[var_20_7:GetConfigID()].status

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

						local var_33_0 = self:DequeItem(self.unionTailTpl, arg_19_1)

						setAnchoredPosition(var_33_0, var_20_10)

						var_20_10 = var_20_10 + Vector2.New(var_19_8 + var_19_10, 0)

						local var_33_1 = self.storyNodeStatus[var_20_7:GetConfigID()].status

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

	setSizeDelta(self.storyContainer, {
		x = var_19_1
	})

	if self.spStoryUnreleasedNode or self.spStoryUnlockNode then
		local var_19_15 = tf(self:DequeItem(self.unreleasedNodeTpl), arg_19_1)

		setAnchoredPosition(var_19_15, {
			y = 0,
			x = 0
		})

		local var_19_16

		if self.spStoryUnreleasedNode then
			setText(var_19_15:Find("text"), i18n("scenario_unlock_pt_require", self.storyNodeStatus[self.spStoryUnreleasedNode:GetConfigID()].reuqire))

			var_19_16 = self.spStoryUnreleasedNode:GetCleanAnimator()
		elseif self.spStoryUnlockNode then
			setText(var_19_15:Find("text"), i18n("scenario_unlock"))

			local var_19_17 = self.spStoryUnlockNode:GetConfigID()

			onButton(self, var_19_15:Find("btn_unlock"), function()
				PlayerPrefs.SetInt("player_" .. getProxy(PlayerProxy):getRawData().id .. "_activity_spStoryNodeID_" .. var_19_17 .. "_unlock", 1)
				self:UpdateView(true)
				self:Move2UnlockStory()

				return
			end)

			var_19_16 = self.spStoryUnlockNode:GetCleanAnimator()
		end

		ResourceMgr.Inst:getAssetAsync("ui/" .. var_19_16, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_36_0)
			local var_36_0 = Instantiate(arg_36_0)

			tf(var_36_0).localPosition = Vector3.New(-525, 0, 0)

			setParent(var_36_0, var_19_15)
			WorldConst.ArrayEffectOrder(var_19_15, 200)

			return
		end), true, true)
	end

	self.spStoryUnreleasedNode = nil
	self.spStoryUnlockNode = nil

	for iter_19_2 = 1, #self.spStoryNodes do
		local var_19_18 = self.spStoryNodes[iter_19_2]
		local var_19_19 = self.spStoryNodes[iter_19_2]:GetConfigID()

		if self.storyNodeTFsById[var_19_19] then
			local var_19_20 = self.storyNodeStatus[var_19_19].status
			local var_19_21 = self.storyNodeTFsById[var_19_19].nodeTF
			local var_19_22 = self.storyNodeTFsById[var_19_19].nodeTF:Find("info/bk/title_form/title")
			local var_19_23 = self.TITLE_ALPHA or {
				0.5,
				1,
				1
			}

			if self.TITLE_COLOR and self.TITLE_COLOR[var_19_20] then
				setTextColor(var_19_22, Color.NewHex(self.TITLE_COLOR[var_19_20]))
			end

			if var_19_20 == var_0_2 then
				local var_19_24 = var_19_18:GetUnlockDesc()
				local var_19_25 = ""

				if type(var_19_24) == "table" then
					local var_19_26 = self.storyNodeStatus[var_19_19].conditionFinishedList or {}

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

				self:RefreshUnlockDesc(var_19_21, HXSet.hxLan(var_19_18:GetDisplayName()), HXSet.hxLan(var_19_25))
				setTextAlpha(var_19_22, var_19_23[var_19_20] or 0.5)
			else
				self:RefreshNodeTitle(var_19_21, HXSet.hxLan(var_19_18:GetDisplayName()))
				setTextAlpha(var_19_22, var_19_23[var_19_20] or 1)
			end

			local var_19_29 = var_19_18:GetType()

			setActive(var_19_21:Find("circle/lock"), var_19_20 == var_0_2)

			if var_19_20 == var_0_2 then
				setActive(var_19_21:Find("circle/Story"), false)
				setActive(var_19_21:Find("circle/Battle"), false)
				setText(var_19_21:Find(""))
			elseif var_19_29 == ActivitySpStoryNode.NODE_TYPE.STORY then
				setActive(var_19_21:Find("circle/Story"), var_19_29 == ActivitySpStoryNode.NODE_TYPE.STORY)
				setActive(var_19_21:Find("circle/Battle"), var_19_29 == ActivitySpStoryNode.NODE_TYPE.BATTLE)
				setActive(var_19_21:Find("circle/Story/Done"), var_19_20 == var_0_4)
			elseif var_19_29 == ActivitySpStoryNode.NODE_TYPE.BATTLE then
				setActive(var_19_21:Find("circle/Story"), var_19_29 == ActivitySpStoryNode.NODE_TYPE.STORY)
				setActive(var_19_21:Find("circle/Battle"), var_19_29 == ActivitySpStoryNode.NODE_TYPE.BATTLE)
				setActive(var_19_21:Find("circle/Battle/Done"), var_19_20 == var_0_4)
			end

			setActive(var_19_21:Find("circle/bk/Inactive"), var_19_20 == var_0_2)
			setActive(var_19_21:Find("circle/bk/Active"), var_19_20 == var_0_3)
			setActive(var_19_21:Find("circle/bk/Readed"), var_19_20 == var_0_4)
			setActive(var_19_21:Find("info/bk/BG/Inactive"), var_19_20 == var_0_2)
			setActive(var_19_21:Find("info/bk/BG/Active"), var_19_20 ~= var_0_2)

			local var_19_30 = var_19_21:Find("condition")

			if var_19_30 then
				local var_19_31 = self.storyNodeStatus[var_19_19].hasTaskCondition and not self.storyNodeStatus[var_19_19].taskConditionFinished

				setActive(var_19_30, var_19_31)

				if var_19_31 then
					local var_19_32 = self.storyNodeStatus[var_19_19].taskConditionTextKey and i18n(self.storyNodeStatus[var_19_19].taskConditionTextKey) or ""
					local var_19_33 = var_19_30:Find("Text") or var_19_30:Find("text")

					if var_19_33 then
						setText(var_19_33, var_19_32)
					else
						setText(var_19_30, var_19_32)
					end
				end
			end

			onButton(self, var_19_21, function()
				if var_19_20 == var_0_2 then
					return
				end

				self:PlayStory(var_19_18:GetStoryName(), function()
					self:UpdateView(true)
					self:Move2UnlockStory()

					return
				end, true)

				return
			end)
		end
	end

	setText(self.progressText, self.storyReadCount .. "/" .. self.storyReadMax)
	setActive(self.storyAward, tobool(self.storyTask))

	if self.storyTask then
		local var_19_34 = self.storyTask:getConfig("award_display")
		local var_19_35 = Drop.New({
			type = var_19_34[1][1],
			id = var_19_34[1][2],
			count = var_19_34[1][3]
		})

		updateDrop(self.storyAward:Find("IconTpl"), var_19_35)

		local var_19_36 = self.storyTask:getTaskStatus()

		setActive(self.storyAward:Find("get"), var_19_36 == 1)
		setActive(self.storyAward:Find("got"), var_19_36 == 2)
		onButton(self, self.storyAward, function()
			self.coreStoryPage:emit(BaseUI.ON_DROP, var_19_35)

			return
		end)
	end

	return
end

function CoreScenarioTemplatePage:DequeItem(arg_40_1, arg_40_2)
	local var_40_0 = self.pools[arg_40_1]:Dequeue()

	table.insert(self.activeItems, {
		template = arg_40_1,
		active = var_40_0
	})
	setActive(var_40_0, true)
	setParent(var_40_0, self.storyContainer)

	local var_40_1 = var_40_0:GetComponent(typeof(Animation))

	if var_40_1 then
		var_40_1.enabled = not arg_40_2
	end

	return var_40_0
end

function CoreScenarioTemplatePage:Move2UnlockStory()
	local var_41_0

	for iter_41_0 = #self.spStoryNodes, 1, -1 do
		local var_41_1 = self.spStoryNodes[iter_41_0]:GetConfigID()

		if self.storyNodeStatus[var_41_1].status > var_0_2 and (not self.storyNodeStatus[var_41_1].reuqire or not self.spStoryNodes[iter_41_0]:GetCleanAnimator()) then
			var_41_0 = var_41_1

			break
		end
	end

	if not var_41_0 then
		for iter_41_1 = 1, #self.spStoryNodes do
			local var_41_2 = self.spStoryNodes[iter_41_1]:GetConfigID()

			if self.storyNodeTFsById[var_41_2] then
				var_41_0 = var_41_2

				break
			end
		end
	end

	local var_41_3

	if not var_41_0 then
		setAnchoredPosition(self.storyContainer, {
			x = 0
		})

		do return end

		var_41_3 = {}
	end

	var_41_3.x = -math.clamp(self.storyNodeTFsById[var_41_0].nodeTF.anchoredPosition.x + self.storyNodeTpl.rect.width * 0.5 - self.storyContainer.parent.rect.width * 0.5, 0, math.max(0, self.storyContainer.rect.width - self.storyContainer.parent.rect.width))

	setAnchoredPosition(self.storyContainer, var_41_3)

	return
end

function CoreScenarioTemplatePage:SwitchStoryMapAndBGM()
	local var_42_0 = self.activity:getConfig("config_client").default_background
	local var_42_1 = self.activity:getConfig("config_client").default_bgm

	for iter_42_0 = 1, #self.spStoryNodes do
		if self.storyNodeStatus[self.spStoryNodes[iter_42_0]:GetConfigID()].status == var_0_4 then
			local var_42_3 = self.spStoryNodes[iter_42_0]:GetCleanAnimator()

			var_42_0 = self.spStoryNodes[iter_42_0]:GetCleanBG() ~= "" and self.spStoryNodes[iter_42_0]:GetCleanBG() or var_42_0

			if self.spStoryNodes[iter_42_0]:GetCleanBGM() ~= "" then
				var_42_1 = self.spStoryNodes[iter_42_0]:GetCleanBGM() or var_42_1
			end
		else
			break
		end
	end

	if var_42_0 ~= nil and var_42_0 ~= "" then
		self:SwitchBG({
			{
				BG = var_42_0
			}
		})
	end

	if var_42_1 ~= nil and var_42_1 ~= "" then
		pg.BgmMgr.GetInstance():Push(self.__cname, var_42_1)
	end

	return
end

function CoreScenarioTemplatePage:SwitchBG(arg_43_1, arg_43_2, arg_43_3)
	if not arg_43_1 or #arg_43_1 <= 0 then
		existCall(arg_43_2)

		return
	elseif arg_43_3 then
		-- block empty
	elseif table.equal(self.currentBG, arg_43_1) then
		return
	end

	self.currentBG = arg_43_1

	for iter_43_0, iter_43_1 in ipairs(self.mapGroup) do
		self.loader:ClearRequest(iter_43_1)
	end

	table.clear(self.mapGroup)
	table.insert(self.mapGroup, (self.loader:GetSpriteDirect("bg/" .. arg_43_1[1].BG, "", function(arg_44_0)
		setImageSprite(self.bg, arg_44_0)
		SetActive(self.bg, true)

		return
	end)))

	return
end

function CoreScenarioTemplatePage:TrySubmitTask()
	local var_45_0 = true

	for iter_45_0, iter_45_1 in ipairs(self.spStoryNodes) do
		local var_45_1 = iter_45_1:GetStoryName()

		if var_45_1 and var_45_1 ~= "" then
			var_45_0 = var_45_0 and pg.NewStoryMgr.GetInstance():IsPlayed(var_45_1)
		end

		if not var_45_0 then
			break
		end
	end

	self:UpdateStoryTask()

	if var_45_0 and self.storyTask and self.storyTask:getTaskStatus() == 1 then
		self.coreStoryPage:emit(ActivityMediator.ON_TASK_SUBMIT, self.storyTask)

		return
	end

	return
end

function CoreScenarioTemplatePage:PlayStory(arg_46_1, arg_46_2, arg_46_3)
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
				self.coreStoryPage:emit(ActivityMediator.GO_PERFORM_COMBAT, {
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

function CoreScenarioTemplatePage:UpdateStoryTask()
	local var_49_0 = self.activity:getConfig("config_client").task_id
	local var_49_1 = getProxy(TaskProxy):getTaskVO(var_49_0)

	if not var_49_1 then
		errorMsg("Missing Activity Task ID : " .. var_49_0)
	end

	self.storyTask = var_49_1 or Task.New({
		id = var_49_0
	})

	return
end

function CoreScenarioTemplatePage:OnSubmitTaskDone()
	self:UpdateView()

	return
end

function CoreScenarioTemplatePage:RefreshNodeTitle(arg_51_1, arg_51_2)
	setScrollText(arg_51_1:Find("info/bk/title_form/title"), arg_51_2)

	return
end

function CoreScenarioTemplatePage:RefreshUnlockDesc(arg_52_1, arg_52_2, arg_52_3)
	setScrollText(arg_52_1:Find("info/bk/title_form/title"), arg_52_3)

	return
end

function CoreScenarioTemplatePage:Show()
	CoreScenarioTemplatePage.super.Show(self)
	self:OverlayPanel(self._tf)
	self:OverlayPanel(self.topPage, {
		stopTop = true
	})

	return
end

function CoreScenarioTemplatePage:Hide()
	self:UnOverlayPanel(self.topPage, self._tf)
	self:UnOverlayPanel(self._tf, self._parentTf)
	CoreScenarioTemplatePage.super.Hide(self)

	return
end

function CoreScenarioTemplatePage:OnDestroy()
	self:RecyclePools()

	for iter_55_0, iter_55_1 in pairs(self.pools) do
		iter_55_1:Clear()
	end

	return
end

return CoreScenarioTemplatePage

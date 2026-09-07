local ClueGroupSingleView = class("ClueGroupSingleView", import("view.base.BaseUI"))
local var_0_1 = pg.activity_clue
local var_0_2 = pg.activity_clue_group
local var_0_3 = 0.6
local var_0_4 = 1

function ClueGroupSingleView:getUIName()
	return "ClueGroupSingleUI"
end

function ClueGroupSingleView:init()
	self.clueGroupTf = self._tf:Find("clueGroup")

	setText(self.clueGroupTf:Find("goBtn/Text"), i18n("clue_task_goto"))
	setText(self._tf:Find("closeTip"), i18n("clue_close_tip"))

	self.timerList = {}

	return
end

function ClueGroupSingleView:didEnter()
	self.activityId = ActivityConst.Valleyhospital_ACT_ID
	self.playerId = getProxy(PlayerProxy):getRawData().id
	self.investigatingGroupId = PlayerPrefs.GetInt("investigatingGroupId_" .. self.activityId .. "_" .. self.playerId)
	self.taskProxy = getProxy(TaskProxy)

	onButton(self, self._tf:Find("mask"), function()
		self:closeView()

		return
	end, SFX_PANEL)
	self:SetClueGroup()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function ClueGroupSingleView:SetClueGroup()
	local var_5_0 = self.contextData.clueGroupId
	local var_5_1 = self.contextData.submitClueIds
	local var_5_2 = self.clueGroupTf
	local var_5_3 = var_0_2[self.contextData.clueGroupId]
	local var_5_4 = var_0_1.get_id_list_by_group[self.contextData.clueGroupId]
	local var_5_5 = {
		var_0_1[var_0_1.get_id_list_by_group[self.contextData.clueGroupId][1]],
		var_0_1[var_0_1.get_id_list_by_group[self.contextData.clueGroupId][2]],
		var_0_1[var_0_1.get_id_list_by_group[self.contextData.clueGroupId][3]]
	}
	local var_5_6 = self.taskProxy:getTaskVO(tonumber(var_5_5[3].task_id)):getProgress()
	local var_5_7 = {}

	for iter_5_0 = 1, 3 do
		var_5_7[iter_5_0] = self.taskProxy:getFinishTaskById(tonumber(var_5_5[iter_5_0].task_id))
	end

	setText(var_5_2:Find("title/Text"), var_5_3.title)
	setActive(var_5_2:Find("title/Text"), var_5_7[1] or var_5_7[2] or var_5_7[3])
	setActive(var_5_2:Find("title/lock"), not var_5_7[1] and not var_5_7[2] and not var_5_7[3])
	LoadImageSpriteAsync("cluepictures/" .. var_5_3.pic, var_5_2:Find("picture"), true)

	var_5_2:Find("picture").localScale = var_5_3.type == 1 and Vector3(1, 1, 1) or Vector3(0.6, 0.6, 1)

	setActive(var_5_2:Find("picture/lockSite"), var_5_3.type == 1 and not var_5_7[1] and not var_5_7[2] and not var_5_7[3])
	setActive(var_5_2:Find("picture/lockChara"), var_5_3.type == 2 and not var_5_7[1] and not var_5_7[2] and not var_5_7[3])

	for iter_5_1 = 1, 3 do
		if var_5_7[iter_5_1] then
			setText(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_1), var_5_5[iter_5_1].desc)
		elseif self.investigatingGroupId == var_5_0 then
			setText(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_1), "<color=#858593>" .. var_5_5[iter_5_1].unlock_desc .. var_5_5[iter_5_1].unlock_num .. i18n("clue_task_tip", var_5_6) .. "</color>")
		else
			local var_5_8

			if not false then
				var_5_8 = true

				setText(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_1), "<color=#858593>" .. var_5_5[iter_5_1].unlock_desc .. var_5_5[iter_5_1].unlock_num .. i18n("clue_task_tip", var_5_6) .. "</color>")
			else
				setText(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_1), "<color=#858593>？？？</color>")
			end
		end
	end

	setActive(var_5_2:Find("goBtn/selected"), self.investigatingGroupId == var_5_0)
	onButton(self, var_5_2:Find("goBtn"), function()
		self.investigatingGroupId = var_5_0

		PlayerPrefs.SetInt("investigatingGroupId_" .. self.activityId .. "_" .. self.playerId, var_5_0)
		setActive(var_5_2:Find("goBtn/selected"), true)

		if self.pageIndex == 1 then
			self:ShowSitePage()
		elseif self.pageIndex == 2 then
			self:ShowCharaPage()
		end

		self:OpenChapter(var_5_0)
		self:closeView()

		return
	end, SFX_PANEL)

	if not var_5_7[1] and not var_5_7[2] and not var_5_7[3] then
		setActive(self.clueGroupTf:Find("triangle"), false)
	else
		setActive(self.clueGroupTf:Find("triangle"), true)
		setActive(self.clueGroupTf:Find("triangle"), self.clueGroupTf:Find("clueScroll"):GetComponent(typeof(ScrollRect)).normalizedPosition.y > 0.01)
		onScroll(self, self.clueGroupTf:Find("clueScroll"), function(arg_7_0)
			setActive(self.clueGroupTf:Find("triangle"), arg_7_0.y > 0.01)

			return
		end)
	end

	setActive(self._tf:Find("top"), var_5_1 and #var_5_1 > 0)

	if var_5_1 and #var_5_1 > 0 then
		if table.contains(var_5_1, var_5_4[1]) then
			setActive(var_5_2:Find("title/Text"), false)
			setActive(var_5_2:Find("title/lock"), true)
			setActive(var_5_2:Find("picture/lockSite"), var_5_3.type == 1)
			setActive(var_5_2:Find("picture/lockChara"), var_5_3.type == 2)

			for iter_5_2 = 1, #var_5_1 do
				if self.investigatingGroupId == var_5_0 then
					setText(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_2), "<color=#858593>" .. var_5_5[iter_5_2].unlock_desc .. var_5_5[iter_5_2].unlock_num .. "</color>")
				else
					setText(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_2), "<color=#858593>？？？</color>")
				end
			end

			self:StartTimer(function()
				setActive(var_5_2:Find("title/Text"), true)

				local var_8_0 = var_5_2:Find("title"):GetComponent(typeof(Animation)):Play("anim_clue_single_unlock1")

				self:SetEndAniEvent(var_5_2:Find("title"), function()
					setActive(var_5_2:Find("title/lock"), false)

					return
				end)

				return
			end, var_0_3)
			self:StartTimer(function()
				local var_10_0 = var_5_2:Find("picture"):GetComponent(typeof(Animation)):Play("anim_clue_single_unlock")

				self:SetEndAniEvent(var_5_2:Find("picture"), function()
					setActive(var_5_2:Find("picture/lockSite"), false)
					setActive(var_5_2:Find("picture/lockChara"), false)

					return
				end)

				return
			end, var_0_3)

			for iter_5_3 = 1, #var_5_1 do
				self:StartTimer(function()
					setText(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_3), var_5_5[iter_5_3].desc)

					return
				end, var_0_4 * iter_5_3 + var_0_3)
			end
		else
			local var_5_9 = table.indexof(var_5_4, var_5_1[1])

			for iter_5_4 = var_5_9, 3 do
				if self.investigatingGroupId == var_5_0 then
					setText(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_4), "<color=#858593>" .. var_5_5[iter_5_4].unlock_desc .. var_5_5[iter_5_4].unlock_num .. "</color>")
				else
					setText(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_4), "<color=#858593>？？？</color>")
				end
			end

			for iter_5_5 = var_5_9, var_5_9 + #var_5_1 - 1 do
				self:StartTimer(function()
					setText(var_5_2:Find("clueScroll/Viewport/Content/clue" .. iter_5_5), var_5_5[iter_5_5].desc)

					return
				end, var_0_4 * 1)
			end
		end

		setActive(var_5_2:Find("goBtn"), false)
	else
		setActive(var_5_2:Find("goBtn"), not var_5_7[1] or not var_5_7[2] or not var_5_7[3])
	end

	return
end

function ClueGroupSingleView:OpenChapter(arg_14_1)
	self:emit(ClueGroupSingleMediator.OPEN_CLUE_JUMP, arg_14_1)

	return
end

function ClueGroupSingleView:StartTimer(arg_15_1, arg_15_2)
	local var_15_0 = Timer.New(arg_15_1, arg_15_2, 1)

	var_15_0:Start()
	table.insert(self.timerList, var_15_0)

	return
end

function ClueGroupSingleView:RemoveAllTimer()
	for iter_16_0, iter_16_1 in ipairs(self.timerList) do
		iter_16_1:Stop()
	end

	self.timerList = {}

	return
end

function ClueGroupSingleView:SetEndAniEvent(arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1:GetComponent(typeof(DftAniEvent))

	if var_17_0 then
		var_17_0:SetEndEvent(function()
			arg_17_2()
			var_17_0:SetEndEvent(nil)

			return
		end)
	end

	return
end

function ClueGroupSingleView:willExit()
	self:RemoveAllTimer()

	return
end

function ClueGroupSingleView:onBackPressed()
	self:closeView()

	return
end

return ClueGroupSingleView

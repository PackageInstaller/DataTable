local VoteScheduleScene = class("VoteScheduleScene", import("view.base.BaseUI"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5 = 5
local var_0_6 = 6
local var_0_7 = 1
local var_0_8 = 2
local var_0_9 = 3

function VoteScheduleScene:getUIName()
	return "VoteScheduleUI"
end

function VoteScheduleScene:init()
	self.backBtn = self._tf:Find("blur_panel/adapt/top/back_btn")
	self.raceTpl = self._tf:Find("res/raceTpl")
	self.layoutTpl = self._tf:Find("res/layoutTpl")
	self.raceTpl1 = self._tf:Find("res/raceTpl1")
	self.layoutTpl1 = self._tf:Find("res/layoutTpl1")
	self.container = self._tf:Find("scrollrect/content")
	self.verLeftTpl = self._tf:Find("res/ver_left")
	self.verLeftTplClose = self._tf:Find("res/ver_left_close")
	self.verRightTpl = self._tf:Find("res/ver_right")
	self.verRightTplClose = self._tf:Find("res/ver_right_close")
	self.centTpl = self._tf:Find("res/cen")
	self.centTplClose = self._tf:Find("res/cen_close")
	self.hrzRightTpl = self._tf:Find("res/hrz_rigth")
	self.hrzRightTplClose = self._tf:Find("res/hrz_rigth_close")
	self.hrzLeftTpl = self._tf:Find("res/hrz_left")
	self.hrzLeftTplClose = self._tf:Find("res/hrz_left_close")
	self.lineContainer = self._tf:Find("scrollrect/content/line")
	self.lineTpls = {}

	setText(self.raceTpl:Find("open/Text"), i18n("vote_lable_voting"))
	setText(self.raceTpl:Find("close/Text"), i18n("vote_lable_not_start"))
	setText(self.raceTpl1:Find("open/Text"), i18n("vote_lable_voting"))
	setText(self.raceTpl1:Find("close/Text"), i18n("vote_lable_not_start"))
	setText(self._tf:Find("title/Text"), i18n("vote_lable_title"))

	self.LayoutHeight = self.layoutTpl:GetComponent(typeof(LayoutElement)).preferredHeight
	self.spacing = self.container:GetComponent(typeof(VerticalLayoutGroup)).spacing

	return
end

function VoteScheduleScene:didEnter()
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_PANEL)
	pg.UIMgr.GetInstance():LoadingOn(false)
	seriesAsync({
		function(arg_5_0)
			self:RequestFinishedVoteGroup(arg_5_0)

			return
		end,
		function(arg_6_0)
			pg.UIMgr.GetInstance():LoadingOff()
			self:SetUp(arg_6_0)

			return
		end
	}, function()
		return
	end)

	return
end

function VoteScheduleScene:RequestFinishedVoteGroup(arg_8_1)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(pg.activity_vote.all) do
		if pg.TimeMgr.GetInstance():parseTimeFromConfig(pg.activity_vote[iter_8_1].time_vote[2]) <= pg.TimeMgr.GetInstance():GetServerTime() then
			table.insert(var_8_0, function(arg_9_0)
				self:emit(VoteScheduleMediator.FETCH_RANK, iter_8_1, arg_9_0)

				return
			end)
		end
	end

	seriesAsync(var_8_0, arg_8_1)

	return
end

function VoteScheduleScene:SetUp(arg_10_1)
	self.voteIdList = self:GetVoteIdList()
	self.displayList = self:GenDisplayList(self.voteIdList)

	self:ClearLines()

	local var_10_0 = self:InitScheduleList()

	self.lineContainer:SetAsLastSibling()
	seriesAsync({
		function(arg_11_0)
			Canvas.ForceUpdateCanvases()
			onNextTick(arg_11_0)

			return
		end,
		function(arg_12_0)
			self:UpdateLinesPosition()
			self:ScrollTo(var_10_0)
			onNextTick(arg_12_0)

			return
		end,
		function(arg_13_0)
			self:PlayAnimation(arg_13_0)

			return
		end
	}, arg_10_1)

	return
end

function VoteScheduleScene:PlayAnimation(arg_14_1)
	local var_14_0 = 1

	local function var_14_1(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = arg_15_0:GetComponent(typeof(CanvasGroup))

		LeanTween.value(arg_15_0.gameObject, 0, 1, 0.333):setOnUpdate(System.Action_float(function(arg_16_0)
			var_15_0.alpha = arg_16_0

			return
		end)):setOnComplete(System.Action(arg_15_2)):setDelay(arg_15_1 * var_14_0)

		var_14_0 = var_14_0 + 1

		return
	end

	local var_14_2 = {}

	for iter_14_0, iter_14_1 in pairs(self.voteIdList or {}) do
		local var_14_3 = self:GetRaceState(iter_14_1) == var_0_9

		for iter_14_2, iter_14_3 in ipairs(self.animationNodes[iter_14_1]) do
			if var_14_3 then
				table.insert(var_14_2, function(arg_17_0)
					var_14_1(iter_14_3, 0.066, arg_17_0)

					return
				end)
			else
				iter_14_3:GetComponent(typeof(CanvasGroup)).alpha = 1
			end
		end
	end

	parallelAsync(var_14_2, function()
		self.animationNodes = {}

		arg_14_1()

		return
	end)

	return
end

function VoteScheduleScene:ScrollTo(arg_19_1)
	setAnchoredPosition(self.container, {
		y = (self.LayoutHeight + self.spacing) * (arg_19_1 - 1) - 170
	})

	return
end

function VoteScheduleScene:ClearLines()
	for iter_20_0, iter_20_1 in ipairs(self.lineTpls) do
		Object.Destroy(iter_20_1[1].gameObject)
	end

	self.lineTpls = {}

	return
end

local function var_0_10(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0 == arg_21_1 then
		return arg_21_2
	else
		local var_21_0 = arg_21_1:InverseTransformPoint((arg_21_0:TransformPoint(arg_21_2)))

		return Vector3(var_21_0.x, var_21_0.y, 0)
	end

	return
end

function VoteScheduleScene:UpdateLinesPosition()
	for iter_22_0, iter_22_1 in ipairs(self.lineTpls) do
		setAnchoredPosition(iter_22_1[1], (var_0_10(iter_22_1[2], self.lineContainer, iter_22_1[3])))
	end

	return
end

function VoteScheduleScene:GetVoteIdList()
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in ipairs(pg.activity_vote.all) do
		table.insert(var_23_0, iter_23_1)
	end

	table.sort(var_23_0, function(arg_24_0, arg_24_1)
		return pg.TimeMgr.GetInstance():parseTimeFromConfig(pg.activity_vote[arg_24_0].time_vote[1]) < pg.TimeMgr.GetInstance():parseTimeFromConfig(pg.activity_vote[arg_24_1].time_vote[1])
	end)

	return var_23_0
end

function VoteScheduleScene:GenDisplayList(arg_25_1)
	local var_25_0 = {}

	if #arg_25_1 <= 4 then
		for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
			table.insert(var_25_0, {
				{
					id = iter_25_1,
					dir = (iter_25_0 == #arg_25_1 or nil) and var_0_6
				}
			})
		end

		return var_25_0
	end

	table.insert(var_25_0, {
		{
			id = arg_25_1[1],
			dir = var_0_1
		}
	})

	local var_25_2 = 0

	for iter_25_2 = 2, #arg_25_1 - 3, 2 do
		var_25_2 = var_25_2 + 1

		local var_25_3 = iter_25_2 == #arg_25_1 - 3 or #arg_25_1 - 3 < iter_25_2 + 2

		if var_25_2 % 2 == 0 then
			local var_25_4 = {}
			local var_25_5 = {
				id = arg_25_1[iter_25_2 + 1]
			}

			if var_25_3 then
				var_25_5.dir = var_0_2 or var_0_3
			end

			var_25_4[1] = var_25_5
			var_25_4[2] = {
				id = arg_25_1[iter_25_2],
				dir = var_0_5
			}

			table.insert(var_25_0, var_25_4)
		else
			local var_25_6 = {
				{
					id = arg_25_1[iter_25_2],
					dir = var_0_4
				}
			}
			local var_25_7 = {
				id = arg_25_1[iter_25_2 + 1]
			}

			if var_25_3 then
				var_25_7.dir = var_0_1 or var_0_3
			end

			var_25_6[2] = var_25_7

			table.insert(var_25_0, var_25_6)
		end
	end

	if #arg_25_1 % 2 == 0 then
		table.insert(var_25_0, {
			{
				id = arg_25_1[#arg_25_1 - 2],
				dir = var_0_3
			}
		})
	end

	table.insert(var_25_0, {
		{
			id = arg_25_1[#arg_25_1 - 1],
			dir = var_0_3
		}
	})
	table.insert(var_25_0, {
		{
			id = arg_25_1[#arg_25_1],
			dir = var_0_6
		}
	})

	return var_25_0
end

function VoteScheduleScene:InitScheduleList()
	self.animationNodes = {}

	local var_26_0 = {}

	for iter_26_0 = 1, self.container.childCount do
		local var_26_1 = self.container:GetChild(iter_26_0 - 1)

		if var_26_1.name ~= "line" then
			table.insert(var_26_0, var_26_1.gameObject)
		end
	end

	if #var_26_0 > 0 then
		for iter_26_1, iter_26_2 in ipairs(var_26_0) do
			Object.Destroy(iter_26_2)
		end
	end

	local var_26_2 = {}

	for iter_26_3, iter_26_4 in ipairs(self.voteIdList) do
		var_26_2[iter_26_4] = self:GetRaceState(iter_26_4)
	end

	local var_26_3 = 1

	for iter_26_5, iter_26_6 in ipairs(self.displayList) do
		if self:GenRaceList(iter_26_5 == #self.displayList and cloneTplTo(self.layoutTpl1, self.container) or cloneTplTo(self.layoutTpl, self.container), iter_26_6, var_26_2, iter_26_5 == #self.displayList) then
			var_26_3 = iter_26_5
		end
	end

	local var_26_6 = false

	for iter_26_7, iter_26_8 in pairs(var_26_2) do
		if pg.activity_vote[iter_26_7].type == VoteConst.RACE_TYPE_FINAL and iter_26_8 == var_0_8 then
			var_26_6 = true

			break
		end
	end

	if var_26_6 then
		cloneTplTo(self.layoutTpl, self.container)
	end

	return var_26_3
end

function VoteScheduleScene:GenRaceList(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0 = false
	local var_27_1 = arg_27_4 and UIItemList.New(arg_27_1:Find("content"), self.raceTpl1) or UIItemList.New(arg_27_1:Find("content"), self.raceTpl)

	var_27_1:make(function(arg_28_0, arg_28_1, arg_28_2)
		if arg_28_0 == UIItemList.EventUpdate then
			local var_28_0 = table.indexof(self.voteIdList, arg_27_2[arg_28_1 + 1].id)
			local var_28_1

			if var_28_0 and var_28_0 > 0 then
				var_28_1 = arg_27_3[self.voteIdList[var_28_0 + 1]]
			end

			local var_28_2 = arg_27_3[arg_27_2[arg_28_1 + 1].id]

			self:UpdateRace(arg_28_2, arg_27_2[arg_28_1 + 1], arg_27_3[arg_27_2[arg_28_1 + 1].id], var_28_1)

			if not var_27_0 and var_28_2 == var_0_8 then
				var_27_0 = true
			end
		end

		return
	end)
	var_27_1:align(#arg_27_2)

	return false
end

function VoteScheduleScene:GetRaceState(arg_29_1)
	if pg.TimeMgr.GetInstance():inTime(pg.activity_vote[arg_29_1].time_vote) then
		return var_0_8
	elseif pg.TimeMgr.GetInstance():parseTimeFromConfig(pg.activity_vote[arg_29_1].time_vote[2]) <= pg.TimeMgr.GetInstance():GetServerTime() then
		return var_0_7
	else
		return var_0_9
	end

	return
end

function VoteScheduleScene:UpdateRace(arg_30_1, arg_30_2, arg_30_3, arg_30_4)
	self:UpdateRaceState(arg_30_1, pg.activity_vote[arg_30_2.id], arg_30_3)

	self.animationNodes[arg_30_2.id] = {
		arg_30_1,
		(self:UpdateRaceLink(arg_30_1, arg_30_2, arg_30_4 and arg_30_4 ~= var_0_9))
	}

	return
end

local function var_0_11(arg_31_0, arg_31_1)
	if arg_31_1 == var_0_9 then
		return "border_close"
	elseif arg_31_0.type == VoteConst.RACE_TYPE_FINAL then
		return "border_finals"
	else
		return "border_open"
	end

	return
end

local function var_0_12(arg_32_0, arg_32_1)
	if arg_32_1 == var_0_9 then
		return "frame_title_close"
	elseif arg_32_0.type == VoteConst.RACE_TYPE_FINAL then
		return "frame_title_finals"
	elseif arg_32_0.type == VoteConst.RACE_TYPE_RESURGENCE then
		return "frame_title_rec"
	elseif arg_32_0.type == VoteConst.RACE_TYPE_FUN then
		if arg_32_0.sub_type == VoteConst.RACE_SUBTYPE_SIRE then
			return "frame_title_sire"
		elseif arg_32_0.sub_type == VoteConst.RACE_SUBTYPE_META then
			return "frame_title_META"
		elseif arg_32_0.sub_type == VoteConst.RACE_SUBTYPE_KID then
			return "frame_title_kid"
		end
	else
		return "frame_title"
	end

	return
end

local function var_0_13(arg_33_0, arg_33_1)
	if arg_33_0.type == VoteConst.RACE_TYPE_FUN then
		if arg_33_0.sub_type == VoteConst.RACE_SUBTYPE_SIRE then
			return "icon_sire"
		elseif arg_33_0.sub_type == VoteConst.RACE_SUBTYPE_META then
			return "icon_META"
		elseif arg_33_0.sub_type == VoteConst.RACE_SUBTYPE_KID then
			return "icon_kid"
		end
	end

	return nil
end

function VoteScheduleScene:UpdateRaceState(arg_34_1, arg_34_2, arg_34_3)
	arg_34_1:Find("border"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/VoteScheduleUI_atlas", var_0_11(arg_34_2, arg_34_3))
	arg_34_1:Find("title"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/VoteScheduleUI_atlas", var_0_12(arg_34_2, arg_34_3))

	local var_34_0 = var_0_13(arg_34_2, arg_34_3)

	setActive(arg_34_1:Find("title/content/icon"), var_34_0)

	if var_34_0 then
		arg_34_1:Find("title/content/icon"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/VoteScheduleUI_atlas", var_34_0)
	end

	local var_34_1 = arg_34_3 ~= var_0_9 and arg_34_2.type == VoteConst.RACE_TYPE_RESURGENCE and "#074e51" or COLOR_WHITE

	setText(arg_34_1:Find("title/content/Text"), setColorStr(arg_34_2.name, arg_34_3 ~= var_0_9 and arg_34_2.type == VoteConst.RACE_TYPE_RESURGENCE and "#074e51" or COLOR_WHITE))
	setText(arg_34_1:Find("title/content/Text/Text"), setColorStr(VoteGroup.GetTimeDesc2(arg_34_2.time_vote, arg_34_2.type), var_34_1))
	setActive(arg_34_1:Find("open"), arg_34_3 == var_0_8)
	setActive(arg_34_1:Find("close"), arg_34_3 == var_0_9)
	setActive(arg_34_1:Find("list"), arg_34_3 == var_0_7)

	local var_34_2 = getProxy(VoteProxy):RawGetTempVoteGroup(arg_34_2.id)
	local var_34_3 = UIItemList.New(arg_34_1:Find("list"), arg_34_1:Find("list/ship_tpl"))

	var_34_3:make(function(arg_35_0, arg_35_1, arg_35_2)
		if arg_35_0 == UIItemList.EventUpdate then
			self:UpdateRaceRank(var_34_2, arg_35_1 + 1, arg_35_2)
		end

		return
	end)
	var_34_3:align(arg_34_3 == var_0_7 and var_34_2 and #var_34_2:getList() >= 3 and 3 or 0)
	onButton(self, arg_34_1, function()
		local var_36_0 = getProxy(VoteProxy):GetOpeningNonFunVoteGroup()

		var_36_0 = var_36_0 or getProxy(VoteProxy):GetOpeningFunVoteGroup()

		if getProxy(VoteProxy):RawGetVoteGroupByConfigId(arg_34_2.id) and var_36_0 and var_36_0.id == arg_34_2.id then
			local var_36_1 = getProxy(ContextProxy):getCurrentContext()

			if var_36_1 and var_36_1.mediator == VoteMediator then
				self:emit(VoteScheduleScene.ON_CLOSE)
			else
				self:emit(VoteScheduleMediator.ON_VOTE)
			end
		elseif var_34_2 then
			self:emit(VoteScheduleMediator.GO_RANK, var_34_2)
		end

		return
	end, SFX_PANEL)

	return
end

function VoteScheduleScene:UpdateRaceRank(arg_37_1, arg_37_2, arg_37_3)
	if not arg_37_1 then
		setActive(arg_37_3, false)

		return
	end

	local var_37_0 = arg_37_1:getList()[arg_37_2]

	VoteShipItem.New(arg_37_3.gameObject):update(var_37_0, {
		rank = arg_37_1:GetRank(var_37_0)
	})

	return
end

function VoteScheduleScene:UpdateRaceLink(arg_38_1, arg_38_2, arg_38_3)
	local var_38_0

	if arg_38_2.dir == var_0_1 and arg_38_3 then
		var_38_0 = cloneTplTo(self.verLeftTpl, self.lineContainer)

		table.insert(self.lineTpls, {
			var_38_0,
			arg_38_1,
			Vector2(-224.42, -203.2)
		})
	elseif arg_38_2.dir == var_0_1 then
		var_38_0 = cloneTplTo(self.verLeftTplClose, self.lineContainer)

		table.insert(self.lineTpls, {
			var_38_0,
			arg_38_1,
			Vector2(-224.42, -203.2)
		})
	elseif arg_38_2.dir == var_0_2 and arg_38_3 then
		var_38_0 = cloneTplTo(self.verRightTpl, self.lineContainer)

		table.insert(self.lineTpls, {
			var_38_0,
			arg_38_1,
			Vector2(224.42, -203.2)
		})
	elseif arg_38_2.dir == var_0_2 then
		var_38_0 = cloneTplTo(self.verRightTplClose, self.lineContainer)

		table.insert(self.lineTpls, {
			var_38_0,
			arg_38_1,
			Vector2(224.42, -203.2)
		})
	elseif arg_38_2.dir == var_0_3 and arg_38_3 then
		var_38_0 = cloneTplTo(self.centTpl, self.lineContainer)

		table.insert(self.lineTpls, {
			var_38_0,
			arg_38_1,
			Vector2(0, -203.2)
		})
	elseif arg_38_2.dir == var_0_3 then
		var_38_0 = cloneTplTo(self.centTplClose, self.lineContainer)

		table.insert(self.lineTpls, {
			var_38_0,
			arg_38_1,
			Vector2(0, -203.2)
		})
	elseif arg_38_2.dir == var_0_4 and arg_38_3 then
		var_38_0 = cloneTplTo(self.hrzRightTpl, self.lineContainer)

		table.insert(self.lineTpls, {
			var_38_0,
			arg_38_1,
			Vector2(447.2, 0)
		})
	elseif arg_38_2.dir == var_0_4 then
		var_38_0 = cloneTplTo(self.hrzRightTplClose, self.lineContainer)

		table.insert(self.lineTpls, {
			var_38_0,
			arg_38_1,
			Vector2(447.2, 0)
		})
	elseif arg_38_2.dir == var_0_5 and arg_38_3 then
		var_38_0 = cloneTplTo(self.hrzLeftTpl, self.lineContainer)

		table.insert(self.lineTpls, {
			var_38_0,
			arg_38_1,
			Vector2(-447.2, 0)
		})
	elseif arg_38_2.dir == var_0_5 then
		var_38_0 = cloneTplTo(self.hrzLeftTplClose, self.lineContainer)

		table.insert(self.lineTpls, {
			var_38_0,
			arg_38_1,
			Vector2(-447.2, 0)
		})
	end

	return var_38_0
end

function VoteScheduleScene:onBackPressed()
	VoteScheduleScene.super.onBackPressed(self)

	return
end

function VoteScheduleScene:willExit()
	return
end

return VoteScheduleScene

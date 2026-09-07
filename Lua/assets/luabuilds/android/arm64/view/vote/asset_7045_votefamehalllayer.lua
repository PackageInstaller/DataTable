local VoteFameHallLayer = class("VoteFameHallLayer", import("..base.BaseUI"))

function VoteFameHallLayer:getUIName()
	if PLATFORM_CODE == PLATFORM_CHT then
		return "VoteFameHallUIForCht"
	else
		return "VoteFameHallUI"
	end

	return
end

function VoteFameHallLayer:SetPastVoteData(arg_2_1)
	self.voteData = arg_2_1

	return
end

function VoteFameHallLayer:init()
	self.tip = self._tf:Find("Text"):GetComponent(typeof(Text))
	self.backBtn = self._tf:Find("adapt/back")

	return
end

function VoteFameHallLayer:didEnter()
	onButton(self, self.backBtn, function()
		self:emit(VoteFameHallLayer.ON_CLOSE)

		return
	end, SFX_PANEL)
	self:InitData()

	return
end

function VoteFameHallLayer:InitData()
	self.displays = {}
	self.btns = {}

	local var_6_0 = 0

	for iter_6_0, iter_6_1 in pairs(self.voteData) do
		local var_6_1 = self._tf:Find("adapt/btns/btn_" .. iter_6_0)

		self.displays[iter_6_0] = iter_6_1

		onToggle(self, var_6_1, function(arg_7_0)
			if arg_7_0 then
				self:Flush(iter_6_0)
			end

			return
		end, SFX_PANEL)

		self.btns[iter_6_0] = var_6_1

		if var_6_0 < iter_6_0 then
			var_6_0 = iter_6_0
		end
	end

	triggerToggle(self.btns[var_6_0], true)
	self:UpdateBtnsTip()

	return
end

function VoteFameHallLayer:Flush(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(self.displays[arg_8_1]) do
		local var_8_0 = pg.vote_champion[iter_8_1].story
		local var_8_1 = pg.vote_champion[iter_8_1].task

		onButton(self, self._tf:Find(arg_8_1 .. "/" .. pg.vote_champion[iter_8_1].rank), function()
			self:GetAward(var_8_0, var_8_1)

			return
		end, SFX_PANEL)
	end

	self:UpdateTips(arg_8_1)

	self.year = arg_8_1

	return
end

function VoteFameHallLayer:UpdateTips(arg_10_1)
	local var_10_1
	local var_10_0

	if not arg_10_1 then
		do return end

		var_10_0 = getProxy(AttireProxy)
		var_10_1 = {
			{
				"",
				false
			},
			{
				"",
				false
			},
			{
				"",
				false
			}
		}
	end

	for iter_10_0, iter_10_1 in ipairs(self.displays[arg_10_1]) do
		local var_10_2 = pg.vote_champion[iter_10_1]
		local var_10_4 = getProxy(TaskProxy)
		local var_10_5 = var_10_4:getTaskById(pg.vote_champion[iter_10_1].task) or var_10_4:getFinishTaskById(pg.vote_champion[iter_10_1].task)
		local var_10_6 = self._tf:Find(arg_10_1 .. "/" .. pg.vote_champion[iter_10_1].rank .. "/title/tip")
		local var_10_7 = var_10_0:getAttireFrame(AttireConst.TYPE_ICON_FRAME, pg.task_data_template[pg.vote_champion[iter_10_1].task].award_display[1][2])

		var_10_1[iter_10_0][2] = var_10_7 ~= nil and var_10_7:isOwned()
		var_10_1[iter_10_0][1] = ShipGroup.getDefaultShipConfig(var_10_2.ship_group).name

		setActive(var_10_6, var_10_5 and var_10_5:isFinish() and not var_10_5:isReceive() and (var_10_7 == nil or not var_10_7:isOwned()))
	end

	local var_10_8 = _.map(var_10_1, function(arg_11_0)
		return arg_11_0[2] and arg_11_0[1] .. "(<color=#92fc63>" .. i18n("word_got") .. "</color>)" or arg_11_0[1]
	end)

	self.tip.text = i18n("vote_fame_tip", var_10_8[1], var_10_8[2], var_10_8[3])

	return
end

function VoteFameHallLayer:UpdateBtnsTip()
	local var_12_0 = getProxy(TaskProxy)
	local var_12_1 = getProxy(AttireProxy)

	for iter_12_0, iter_12_1 in pairs(self.displays) do
		setActive(self.btns[iter_12_0]:Find("tip"), (_.any(iter_12_1, function(arg_13_0)
			local var_13_0 = var_12_0:getTaskById(pg.vote_champion[arg_13_0].task) or var_12_0:getFinishTaskById(pg.vote_champion[arg_13_0].task)
			local var_13_1 = var_12_1:getAttireFrame(AttireConst.TYPE_ICON_FRAME, pg.task_data_template[pg.vote_champion[arg_13_0].task].award_display[1][2])

			return var_13_0 and var_13_0:isFinish() and not var_13_0:isReceive() and (var_13_1 == nil or not var_13_1:isOwned())
		end)))
	end

	return
end

function VoteFameHallLayer:GetAward(arg_14_1, arg_14_2)
	seriesAsync({
		function(arg_15_0)
			pg.NewStoryMgr.GetInstance():Play(arg_14_1, arg_15_0, true)

			return
		end,
		function(arg_16_0)
			local var_16_0 = getProxy(TaskProxy)
			local var_16_1 = var_16_0:getTaskById(arg_14_2) or var_16_0:getFinishTaskById(arg_14_2)

			if var_16_1 and var_16_1:isFinish() and not var_16_1:isReceive() then
				self:emit(VoteFameHallMediator.ON_SUBMIT_TASK, var_16_1.id)
			end

			arg_16_0()

			return
		end
	})

	return
end

function VoteFameHallLayer:willExit()
	return
end

return VoteFameHallLayer

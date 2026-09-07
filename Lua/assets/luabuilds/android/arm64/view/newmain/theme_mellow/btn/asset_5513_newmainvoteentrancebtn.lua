local NewMainVoteEntranceBtn = class("NewMainVoteEntranceBtn")

function NewMainVoteEntranceBtn:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self.event = arg_1_2

	return
end

function NewMainVoteEntranceBtn:Init(arg_2_1)
	self.tip = self._tf:Find("tip")

	setActive(self.tip, self:IsShowTip())
	onButton(self, self._tf, function()
		self.event:emit(NewMainMediator.GO_SCENE, SCENE.VOTEENTRANCE)

		return
	end, SFX_MAIN)

	local var_2_0 = getProxy(VoteProxy):IsAllRaceEnd()
	local var_2_1 = self:AnyVoteActIsOpening()

	setActive(self._tf:Find("unopen"), not var_2_0 and var_2_1)
	setActive(self._tf:Find("end"), var_2_0)

	self._tf:GetComponent(typeof(Image)).enabled = not var_2_0 and not var_2_1

	return
end

function NewMainVoteEntranceBtn:InShowTime()
	local var_4_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.VOTE_ENTRANCE_ACT_ID)

	return var_4_0 and not var_4_0:isEnd()
end

function NewMainVoteEntranceBtn:AnyVoteActIsOpening()
	return getProxy(VoteProxy):AnyVoteActIsOpening()
end

function NewMainVoteEntranceBtn:IsShowTip()
	return NewMainVoteEntranceBtn.ShouldTipNewRace() or NewMainVoteEntranceBtn.ShouldTipVotes() or NewMainVoteEntranceBtn.ShouldTipAward() or NewMainVoteEntranceBtn.ShouldTipFinalAward()
end

function NewMainVoteEntranceBtn.ShouldTipFinalAward()
	local var_7_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.VOTE_ENTRANCE_ACT_ID)

	if not var_7_0 or var_7_0:isEnd() then
		return false
	end

	local var_7_1 = var_7_0:getConfig("config_client")[2] or -1
	local var_7_2 = getProxy(TaskProxy):getTaskById(var_7_1)

	var_7_2 = var_7_2 or getProxy(TaskProxy):getFinishTaskById(var_7_1)

	return var_7_2 and var_7_2:isFinish() and not var_7_2:isReceive()
end

function NewMainVoteEntranceBtn.ShouldTipNewRace()
	local var_8_0 = getProxy(PlayerProxy):getRawData().id

	for iter_8_0, iter_8_1 in ipairs((getProxy(VoteProxy):GetVoteGroupList())) do
		if iter_8_1 and iter_8_1:IsOpening() then
			if getProxy(VoteProxy):IsNewRace(iter_8_1) then
				return true
			end
		end
	end

	return false
end

function NewMainVoteEntranceBtn.ShouldTipVotes()
	for iter_9_0, iter_9_1 in ipairs((getProxy(VoteProxy):GetVoteGroupList())) do
		if getProxy(VoteProxy):GetVotesByConfigId(iter_9_1.configId) > 0 then
			return true
		end
	end

	return false
end

function NewMainVoteEntranceBtn.ShouldTipAward()
	return getProxy(VoteProxy):ExistPastVoteAward()
end

function NewMainVoteEntranceBtn:Hide()
	if self._tf then
		setActive(self._tf, false)
	end

	return
end

function NewMainVoteEntranceBtn.IsShowTip()
	return NewMainVoteEntranceBtn.ShouldTipNewRace() or NewMainVoteEntranceBtn.ShouldTipVotes() or NewMainVoteEntranceBtn.ShouldTipAward() or NewMainVoteEntranceBtn.ShouldTipFinalAward()
end

function NewMainVoteEntranceBtn:Dispose()
	return
end

return NewMainVoteEntranceBtn

local MainVoteEntranceBtn = class("MainVoteEntranceBtn", import(".MainBaseSpcailActBtn"))

function MainVoteEntranceBtn:GetContainer()
	return self.root.parent:Find("eventPanel")
end

function MainVoteEntranceBtn:InShowTime()
	local var_2_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.VOTE_ENTRANCE_ACT_ID)

	return var_2_0 and not var_2_0:isEnd()
end

function MainVoteEntranceBtn:GetUIName()
	return "MainUIVoteActBtn"
end

function MainVoteEntranceBtn:OnClick()
	self.event:emit(NewMainMediator.GO_SCENE, SCENE.VOTEENTRANCE)

	return
end

function MainVoteEntranceBtn:OnInit()
	setActive(self._tf:Find("tip"), self:ShouldTipNewRace() or self:ShouldTipVotes() or self:ShouldTipAward() or self:ShouldTipFinalAward())

	local var_5_0 = getProxy(VoteProxy):IsAllRaceEnd()
	local var_5_1 = self:AnyVoteActIsOpening()

	setActive(self._tf:Find("unopen"), not var_5_0 and var_5_1)
	setActive(self._tf:Find("end"), var_5_0)

	self._tf:GetComponent(typeof(Image)).enabled = not var_5_0 and not var_5_1

	return
end

function MainVoteEntranceBtn:AnyVoteActIsOpening()
	return getProxy(VoteProxy):AnyVoteActIsOpening()
end

function MainVoteEntranceBtn:ShouldTipFinalAward()
	local var_7_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.VOTE_ENTRANCE_ACT_ID)

	if not var_7_0 or var_7_0:isEnd() then
		return false
	end

	local var_7_1 = var_7_0:getConfig("config_client")[2] or -1
	local var_7_2 = getProxy(TaskProxy):getTaskById(var_7_1)

	var_7_2 = var_7_2 or getProxy(TaskProxy):getFinishTaskById(var_7_1)

	return var_7_2 and var_7_2:isFinish() and not var_7_2:isReceive()
end

function MainVoteEntranceBtn:ShouldTipNewRace()
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

function MainVoteEntranceBtn:ShouldTipVotes()
	for iter_9_0, iter_9_1 in ipairs((getProxy(VoteProxy):GetVoteGroupList())) do
		if getProxy(VoteProxy):GetVotesByConfigId(iter_9_1.configId) > 0 then
			return true
		end
	end

	return false
end

function MainVoteEntranceBtn:ShouldTipAward()
	return getProxy(VoteProxy):ExistPastVoteAward()
end

return MainVoteEntranceBtn

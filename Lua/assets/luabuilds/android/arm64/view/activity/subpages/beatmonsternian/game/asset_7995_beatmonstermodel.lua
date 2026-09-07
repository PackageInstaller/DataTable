local BeatMonsterModel = class("BeatMonsterModel")

function BeatMonsterModel:Ctor(arg_1_1)
	self.controller = arg_1_1
	self.fuShun = nil
	self.mosterNian = nil
	self.attackCnt = 0
	self.actionStr = ""

	return
end

function BeatMonsterModel:AddFuShun()
	self.fuShun = {}

	return
end

function BeatMonsterModel:AddMonsterNian(arg_3_1, arg_3_2)
	self.mosterNian = {
		hp = arg_3_1,
		maxHp = arg_3_2
	}

	return
end

function BeatMonsterModel:UpdateMonsterHp(arg_4_1)
	self.mosterNian.hp = arg_4_1

	return
end

function BeatMonsterModel:UpdateData(arg_5_1)
	self:UpdateMonsterHp(arg_5_1.hp)

	self.mosterNian.maxHp = arg_5_1.maxHp

	self:SetAttackCnt(arg_5_1.leftCount)

	return
end

function BeatMonsterModel:SetAttackCnt(arg_6_1)
	self.attackCnt = arg_6_1

	return
end

function BeatMonsterModel:UpdateActionStr(arg_7_1)
	self.actionStr = (not arg_7_1 or arg_7_1 == "") and "" or self.actionStr .. arg_7_1

	return
end

function BeatMonsterModel:SetStorys(arg_8_1)
	self.storys = arg_8_1

	return
end

function BeatMonsterModel:GetPlayableStory()
	if not self.storys or type(self.storys) ~= "table" then
		return
	end

	local var_9_0 = pg.NewStoryMgr.GetInstance()

	for iter_9_0, iter_9_1 in pairs(self.storys) do
		if iter_9_1[1] >= self.mosterNian.hp and not var_9_0:IsPlayed(iter_9_1[2]) then
			return iter_9_1[2]
		end
	end

	return
end

function BeatMonsterModel:GetActionStr()
	return self.actionStr
end

function BeatMonsterModel:IsMatchAction()
	return BeatMonsterNianConst.MatchAction(self.actionStr)
end

function BeatMonsterModel:GetMatchAction()
	return BeatMonsterNianConst.GetMatchAction(self.actionStr)
end

function BeatMonsterModel:GetMonsterAction()
	return BeatMonsterNianConst.GetMonsterAction(self.actionStr)
end

function BeatMonsterModel:RandomDamage()
	return math.max(self.mosterNian.hp - math.random(1, 2), 0)
end

function BeatMonsterModel:GetMonsterMaxHp()
	return self.mosterNian.maxHp
end

function BeatMonsterModel:GetAttackCount()
	return self.attackCnt
end

function BeatMonsterModel:Dispose()
	return
end

return BeatMonsterModel

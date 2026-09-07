local BeatMonsterNianConst = class("BeatMonsterNianConst")

BeatMonsterNianConst.INPUT_TIME = 3
BeatMonsterNianConst.ACTION_NAME_L = "L"
BeatMonsterNianConst.ACTION_NAME_R = "R"
BeatMonsterNianConst.ACTION_NAME_A = "A"
BeatMonsterNianConst.ACTION_NAME_B = "B"
BeatMonsterNianConst.MotionCombinations = {
	BRB = "isAttack8",
	BRA = "isAttack6",
	ARA = "isAttack6",
	BBB = "isAttack1",
	ABB = "isAttack4",
	RBA = "isAttack8",
	LLA = "isAttack1",
	LBA = "isAttack8",
	RAB = "isAttack4",
	AAA = "isAttack1",
	BLB = "isAttack7",
	LRB = "isAttack6",
	RLA = "isAttack2",
	LAA = "isAttack3",
	LAB = "isAttack4",
	ALB = "isAttack7",
	ARB = "isAttack8",
	RRA = "isAttack1",
	LBB = "isAttack7",
	LRA = "isAttack2",
	LLB = "isAttack5",
	BBA = "isAttack2",
	ABA = "isAttack3",
	AAB = "isAttack2",
	BAB = "isAttack3",
	ALA = "isAttack5",
	RAA = "isAttack3",
	RLB = "isAttack6",
	BLA = "isAttack5",
	RBB = "isAttack7",
	BAA = "isAttack4",
	RRB = "isAttack5"
}

function BeatMonsterNianConst:MatchAction()
	return BeatMonsterNianConst.MotionCombinations[self] ~= nil
end

function BeatMonsterNianConst:GetMatchAction()
	return BeatMonsterNianConst.MotionCombinations[self]
end

function BeatMonsterNianConst:GetMonsterAction()
	return "isAttack"
end

return BeatMonsterNianConst

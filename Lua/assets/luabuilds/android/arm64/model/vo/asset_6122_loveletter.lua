local LoveLetter = class("LoveLetter", import(".BaseVO"))

function LoveLetter:Ctor(arg_1_1)
	self.groupId = arg_1_1.group_id
	self.configId = self.groupId
	self.exp = arg_1_1.exp or 0
	self.level = arg_1_1.level or 0
	self.unlockLetterDic = {}

	return
end

function LoveLetter:bindConfigTable()
	return pg.lover_character_template
end

function LoveLetter:SetUnlockLetters(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		self.unlockLetterDic[iter_3_1] = defaultValue(self.unlockLetterDic[iter_3_1], 0) + 1
	end

	return
end

function LoveLetter:GetLetterUnlock(arg_4_1)
	return defaultValue(self.unlockLetterDic[arg_4_1], 0) > 0
end

function LoveLetter:GetLetterList()
	local var_5_0 = getProxy(LoveLetterProxy):GetRecordGiftLetters(self.groupId)

	for iter_5_0, iter_5_1 in ipairs(pg.lover_letter_content.get_id_list_by_ship_group[self.groupId]) do
		if not table.contains(var_5_0, iter_5_1) then
			table.insert(var_5_0, iter_5_1)
		end
	end

	return var_5_0
end

function LoveLetter:IsExpMax()
	return self.exp >= self:getConfig("exp_upper_limit")
end

function LoveLetter:IsLevelMax()
	return self.level >= self:GetMaxLevel()
end

function LoveLetter:AddExp(arg_8_1)
	if self:IsExpMax() then
		return 0
	end

	self.exp = math.min(self.exp + arg_8_1, (self:getConfig("exp_upper_limit")))
	arg_8_1 = self.exp

	return self.exp - arg_8_1
end

function LoveLetter:AddGiftExp(arg_9_1)
	self.exp = self.exp + self:getConfig("exp_up") * arg_9_1
	self.level = self.level + arg_9_1

	return
end

function LoveLetter:GetMaxLevel()
	self.maxLevel = self.maxLevel or calcFloor(self:getConfig("exp_upper_limit") / self:getConfig("exp_up"))

	return self.maxLevel
end

function LoveLetter:CanLevelUp()
	return self.exp >= (self.level + 1) * self:getConfig("exp_up")
end

function LoveLetter:MaxLevelUp()
	self.level = calcFloor(self.exp / self:getConfig("exp_up"))

	return
end

function LoveLetter:CanUnlockLetter(arg_13_1)
	local var_13_0 = table.indexof(self:GetLetterList(), arg_13_1)

	assert(var_13_0)

	return var_13_0 <= self.level
end

function LoveLetter:GetDisplayLetterList()
	return underscore.first(self:GetLetterList(), self.level)
end

function LoveLetter:GetDisplayLevel()
	return math.min(self.level, self:GetMaxLevel())
end

function LoveLetter:GetDisplayRank()
	return math.floor((self:GetDisplayLevel() - 1) / 10) + 1
end

LoveLetter.Mark = {
	"I",
	"II",
	"III",
	"IV",
	"V",
	"VI",
	"VII",
	"VIII",
	"IX",
	"X"
}

function LoveLetter:GetDisplayLevelMark()
	return self:GetDisplayLevel()
end

function LoveLetter:GetDisplayExp()
	if self:IsLevelMax() then
		return 0, 0
	else
		local var_18_0 = self:getConfig("exp_up")

		return math.min(self.exp - self.level * var_18_0, var_18_0), var_18_0
	end

	return
end

function LoveLetter:GetPrefabName()
	return "lovelettermedal/default_" .. self:GetDisplayRank()
end

function LoveLetter:GetEmptyShipGroup()
	self.shipGroup = self.shipGroup or ShipGroup.New({
		id = self.configId
	})

	return self.shipGroup
end

function LoveLetter:GetPainting()
	return self:GetEmptyShipGroup():getPainting()
end

function LoveLetter:GetName()
	return self:GetEmptyShipGroup():getName()
end

function LoveLetter:GetNation()
	return self:GetEmptyShipGroup():getNation()
end

function LoveLetter:GetDisplayInfo()
	local var_24_0 = pg.ship_skin_template[self:GetEmptyShipGroup():getPaintingId()]

	return {
		hand = var_24_0.lover_hand,
		kiss = var_24_0.lover_kiss
	}
end

function LoveLetter:GetLetterDataFromId()
	local var_25_0 = pg.lover_nation[self:GetNation()]

	return {
		bg = var_25_0.bg,
		prefab = var_25_0.letter
	}
end

function LoveLetter:GetTrophyList()
	local var_26_0 = {}

	for iter_26_0 = 1, self.level, 10 do
		table.insert(var_26_0, LoveLetterTrophy.New({
			id = 0 + self.groupId * 100 + iter_26_0
		}))
	end

	return var_26_0
end

return LoveLetter

local LoveLetterTrophy = class("LoveLetterTrophy", import(".Trophy"))

function LoveLetterTrophy:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = arg_1_1.id
	self.level = self.id % 100
	self.groupId = math.floor(self.id % 0 / 100)
	self.ll = getProxy(LoveLetterProxy):GetGroupData(self.groupId)
	self.oll = setmetatable({
		level = self.level
	}, {
		__index = self.ll
	})
	self.isMax = self.level + 10 > self.ll:GetMaxLevel()
	self.groupName = self.ll:GetName()
	self.paint = self.ll:GetPainting()
	self.subTrophyList = {}

	self:update(arg_1_1)

	return
end

function LoveLetterTrophy:getConfigTable()
	if not self.configTable then
		local var_2_0 = {}

		if not self.isMax then
			var_2_0.next = self.id + 10 or nil
		end

		self.configTable = var_2_0
	end

	return self.configTable
end

function LoveLetterTrophy:update(arg_3_1)
	self.timestamp = 1

	return
end

function LoveLetterTrophy:isComplexTrophy()
	return false
end

function LoveLetterTrophy:getTargetID()
	return self:getConfig("target_id")
end

function LoveLetterTrophy:getHideType()
	return self:getConfig("hide")
end

function LoveLetterTrophy:isHide()
	return false
end

function LoveLetterTrophy:isMaxLevel()
	return self.isMax
end

function LoveLetterTrophy:getName()
	return i18n("loveactivity_ui_14", self.groupName)
end

function LoveLetterTrophy:GetPrefabName()
	return self.oll:GetPrefabName()
end

function LoveLetterTrophy:GetPainting()
	return self.paint
end

function LoveLetterTrophy:GetDisplayLevelMark()
	return self.oll:GetDisplayLevelMark()
end

return LoveLetterTrophy

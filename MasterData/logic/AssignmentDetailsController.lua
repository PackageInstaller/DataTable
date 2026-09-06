-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assignment/controller/AssignmentDetailsController.lua

module("logic.extensions.assignment.controller.AssignmentDetailsController", package.seeall)

local AssignmentDetailsController = class("AssignmentDetailsController", BaseController)

function AssignmentDetailsController:ctor()
	AssignmentDetailsController.super.ctor(self)
end

function AssignmentDetailsController:onInit()
	AssignmentDetailsController.super.onInit(self)
end

function AssignmentDetailsController:onReset()
	AssignmentDetailsController.super.onReset(self)
end

function AssignmentDetailsController:setView(view)
	self._view = view
end

function AssignmentDetailsController:direction(startPos, endPos)
	local x = {
		direction = (endPos - startPos) / 10
	}

	x.length = math.pow(x.direction.x, 2) + math.pow(x.direction.y, 2)

	return x
end

function AssignmentDetailsController:GetSortParms()
	local parm1 = {}
	local parm2 = {}
	local sortName
	local sortValue = BagModel.instance:GetSortState()

	for k, v in ipairs(sortValue) do
		local vArr = BagModel.SORT_VALUE[k]

		if vArr[v + 1] ~= -1 then
			table.insert(parm1, BagModel.SORT_NAME[k])
			table.insert(parm2, vArr[v + 1])
		end
	end

	return parm1, parm2
end

function AssignmentDetailsController:analysisCondition(str)
	local s = string.split(str, "#")
	local conditions = {}

	for _, v in ipairs(s) do
		local sx = string.split(v, ",")

		if #sx == 1 then
			self:_addCondition(conditions, string.split(sx[1], ":"))
		else
			self:_addCondition(conditions, string.split(sx[1], ":"), string.split(sx[2], ":"))
		end
	end

	return conditions
end

function AssignmentDetailsController:_addCondition(conditions, s1, s2)
	if s2 == nil then
		if s1[1] == "总星级" then
			table.insert(conditions, {
				s1[1],
				num = 0,
				tonumber(CharacterConfig.instance:getAwakenRareCfg(tonumber(s1[2])).starNum)
			})
		else
			table.insert(conditions, {
				s1[1],
				num = 0,
				tonumber(s1[2])
			})
		end
	elseif s2[1] == "星级" then
		table.insert(conditions, {
			s1[1],
			tonumber(s1[2]),
			s2[1],
			CharacterConfig.instance:getAwakenRareCfg(tonumber(s2[2])).starNum,
			num = 0
		})
	else
		table.insert(conditions, {
			s1[1],
			tonumber(s1[2]),
			s2[1],
			s2[2],
			num = 0
		})
	end
end

function AssignmentDetailsController:getConditionText(i, gameObject)
	local x = AssignmentDetailsModel.instance:getCondition(i)

	if x.num < x[2] then
		gameObject:GetComponent("UITextColorChange"):SetState(0)
	else
		gameObject:GetComponent("UITextColorChange"):SetState(1)
	end

	local text = gameObject:GetComponent("Text")

	if x[1] == "总等级" then
		text.text = string.format("队伍%s达到%s%s(%s/%s)", x[1], x[2], self:sub(x[1], -1), x.num, x[2])
	elseif x[1] == "总觉醒" then
		text.text = string.format("队伍%s等级达到%s%s(%s/%s)", x[1], x[2], self:sub(x[1], -1), x.num, x[2])
	else
		local s = "至少派遣" .. x[2] .. "只"

		text.text = (x[3] == "等级" or x[3] == "觉醒") and s .. string.format("%s不低于%s的精灵(%s/%s)", x[3], x[4], x.num, x[2]) or x[3] == "稀有度" and s .. string.format("%s为%s的精灵(%s/%s)", "初始" .. x[3], self:_analysisRarity(tonumber(x[4])), x.num, x[2]) or s .. string.format("%s为%s的精灵(%s/%s)", x[3], x[4], x.num, x[2])
	end
end

function AssignmentDetailsController:checkCondition()
	local _rank = AssignmentDetailsModel.instance:getRanks()
	local _condition = AssignmentDetailsModel.instance:getCondition()

	for i = 1, #_condition do
		if _condition[i][1] == "总觉醒" then
			local _sum = 0

			for _, v in pairs(_rank.pets) do
				if v.awakenLv then
					_sum = _sum + CharacterConfig.instance:getAwakenRareCfg(v.awakenLv).starNum
				end
			end

			AssignmentDetailsModel.instance:setConditionNum(_sum, i)
		elseif _condition[i][1] == "总等级" then
			local _sum = 0

			for _, v in pairs(_rank.pets) do
				if v.level then
					_sum = _sum + v.level
				end
			end

			AssignmentDetailsModel.instance:setConditionNum(_sum, i)
		else
			local _sum = 0

			if _condition[i][3] == "职业" then
				for _, v in pairs(_rank.pets) do
					local x = PetSkinConfig.instance:getPetSkinCfg(v.curFaceId)
					local s = string.split(x.job, ",")

					for _, ss in pairs(s) do
						if ss == _condition[i][4] then
							_sum = _sum + 1
						end
					end
				end

				AssignmentDetailsModel.instance:setConditionNum(_sum, i)
			elseif _condition[i][3] == "觉醒" then
				for _, v in pairs(_rank.pets) do
					if CharacterConfig.instance:getAwakenRareCfg(v.awakenLv).starNum >= tonumber(_condition[i][4]) then
						_sum = _sum + 1
					end
				end

				AssignmentDetailsModel.instance:setConditionNum(_sum, i)
			elseif _condition[i][3] == "等级" then
				for _, v in pairs(_rank.pets) do
					if v.level >= tonumber(_condition[i][4]) then
						_sum = _sum + 1
					end
				end

				AssignmentDetailsModel.instance:setConditionNum(_sum, i)
			elseif _condition[i][3] == "稀有度" then
				for _, v in pairs(_rank.pets) do
					local x = CharacterConfig.instance:getPetCo(v.raceId)

					if x.rare >= tonumber(_condition[i][4]) then
						_sum = _sum + 1
					end
				end

				AssignmentDetailsModel.instance:setConditionNum(_sum, i)
			elseif _condition[i][3] == "属性" then
				for _, v in pairs(_rank.pets) do
					local firstEle = PetSkinConfig.instance:getFisrtEleAttrIdx(v.curFaceId)

					if firstEle == GameEnum.Races[_condition[i][4]] then
						_sum = _sum + 1
					end
				end

				AssignmentDetailsModel.instance:setConditionNum(_sum, i)
			end
		end
	end
end

function AssignmentDetailsController:searchConditionPet(petData)
	if not AssignmentDetailsModel.instance:isQuick() then
		local rank = AssignmentDetailsModel.instance:getRanks()

		for i = 1, AssignmentDetailsModel.instance:getRankMaxNum() do
			if rank.pets[i] then
				self._view:_removeSendPet(rank.pets[i].petId)
			end
		end
	end

	local _condition = AssignmentDetailsModel.instance:getCondition()
	local petCopy = {}

	for _, v in ipairs(petData) do
		if not self:isMemberPet(v.petId) and not self:isPetInOut(v.petId) then
			table.insert(petCopy, v)
		end
	end

	local petIds = {
		postion = {}
	}
	local conditionPet = {}

	for _, v in ipairs(_condition) do
		table.insert(conditionPet, {
			num = v[2]
		})
	end

	for i = 1, #petCopy do
		petCopy[i].priority = 0

		for j = 1, #conditionPet do
			if self:_isConditionPet(petCopy[i], _condition[j]) then
				petCopy[i].priority = petCopy[i].priority + 1
				conditionPet[j][petCopy[i].petId] = petCopy[i].petId
			end
		end
	end

	function _localSort(petCopy)
		table.sort(petCopy, function(a, b)
			if a.priority == b.priority then
				return a.level * CharacterConfig.instance:getAwakenRareCfg(a.awakenLv).starNum * a.rare < b.level * CharacterConfig.instance:getAwakenRareCfg(b.awakenLv).starNum * b.rare
			else
				return a.priority > b.priority
			end
		end)
	end

	_localSort(petCopy)

	for i = 1, #petCopy do
		table.insert(petIds.postion, AssignmentDetailsModel.instance:addRanksMember(petCopy[1], true))

		for j = 1, #conditionPet do
			if conditionPet[j] == nil then
				break
			end

			if conditionPet[j][petCopy[1].petId] ~= nil then
				conditionPet[j][petCopy[1].petId] = nil
				conditionPet[j].num = conditionPet[j].num - 1

				if conditionPet[j].num == 0 then
					for _, k in pairs(conditionPet[j]) do
						for n = 1, #petCopy do
							if k == petCopy[n].petId then
								petCopy[n].priority = petCopy[n].priority - 1
							end
						end
					end

					_localSort(petCopy)
					table.remove(conditionPet, j)

					j = j - 1
				end
			end
		end

		table.insert(petIds, table.remove(petCopy, 1).petId)

		if AssignmentDetailsController.instance:_isRankEnd(petCopy, 0) then
			return petIds
		end
	end

	return petIds
end

function AssignmentDetailsController:_isConditionPet(pet, condition)
	if condition[1] == "总觉醒" or condition[2] == "总等级" then
		return true
	elseif condition[3] == "职业" and condition.num < condition[2] then
		local x = PetSkinConfig.instance:getPetSkinCfg(pet.curFaceId)
		local s = string.split(x.job, ",")

		for _, ss in pairs(s) do
			if ss == condition[4] then
				return true
			end
		end
	elseif condition[3] == "觉醒" and condition.num < condition[2] and CharacterConfig.instance:getAwakenRareCfg(pet.awakenLv).starNum >= tonumber(condition[4]) then
		return true
	elseif condition[3] == "等级" and condition.num < condition[2] and pet.level >= tonumber(condition[4]) then
		return true
	elseif condition[3] == "稀有度" and condition.num < condition[2] then
		local x = CharacterConfig.instance:getPetCo(pet.raceId)

		return x.rare >= tonumber(condition[4])
	elseif condition[3] == "属性" and condition.num < condition[2] then
		local fisrtEle = PetSkinConfig.instance:getFisrtEleAttrIdx(pet.curFaceId)

		return fisrtEle == GameEnum.Races[condition[4]]
	end

	return false
end

function AssignmentDetailsController:isMemberPet(petId)
	local x = AssignmentDetailsModel.instance:getRanks()

	for _, v in pairs(x.pets) do
		if petId == v.petId then
			return true
		end
	end

	return false
end

function AssignmentDetailsController:isPetInOut(petId)
	local outPet = AssignmentModel.instance:getOutPet()

	for _, v in ipairs(outPet) do
		if petId == v then
			return true
		end
	end

	return false
end

function AssignmentDetailsController:_isRankEnd(petCopy, j)
	return AssignmentDetailsModel.instance:isRankFull() or petCopy[j + 1] == nil
end

function AssignmentDetailsController:_analysisRarity(n)
	local rs = ""

	if n == 1 then
		rs = "<color=#8c8c8c>初代</color>/"
	end

	if n <= 2 then
		rs = rs .. "<color=#08a0d8>幻兽</color>/"
	end

	if n <= 3 then
		rs = rs .. "<color=#df4dff>超能</color>/"
	end

	if n <= 4 then
		rs = rs .. "<color=#d56d08>传说</color>"
	end

	return rs
end

function AssignmentDetailsController:sub(str, startIndex, endIndex)
	local tempStr = str
	local byteStart = 1
	local byteEnd = -1
	local index = 0
	local bytes = 0

	startIndex = math.max(startIndex, 0)
	endIndex = endIndex or -1

	while string.len(tempStr) > 0 do
		if index == startIndex - 1 then
			byteStart = bytes + 1
		elseif index == endIndex then
			byteEnd = bytes

			break
		end

		bytes = bytes + self.getBytes(tempStr)
		tempStr = string.sub(str, bytes + 1)
		index = index + 1
	end

	return string.sub(str, byteStart, byteEnd)
end

function AssignmentDetailsController.getBytes(char)
	if not char then
		return 0
	end

	local code = string.byte(char)

	if code < 127 then
		return 1
	elseif code <= 223 then
		return 2
	elseif code <= 239 then
		return 3
	elseif code <= 247 then
		return 4
	else
		return 0
	end
end

AssignmentDetailsController.instance = AssignmentDetailsController.New()

return AssignmentDetailsController

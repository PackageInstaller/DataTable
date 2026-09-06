-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/model/AoQiAttackForceBlockData.lua

module("logic.extensions.aoqiattackforce.model.AoQiAttackForceBlockData", package.seeall)

local AoQiAttackForceBlockData = class("AoQiAttackForceBlockData")

function AoQiAttackForceBlockData:ctor()
	self.curWidth = 0
	self.curHeight = 0
	self.posCellMap = {}
	self.anchorMap = {}
	self.existPosList = {}
end

function AoQiAttackForceBlockData:initWidthAndHeight(w, h)
	self.curWidth = checknumber(w)
	self.curHeight = checknumber(h)
	self.posCellMap = {}
	self.anchorMap = {}

	for i = 1, self.curWidth do
		for k = 1, self.curHeight do
			self.posCellMap[i] = self.posCellMap[i] or {}
			self.posCellMap[i][k] = AoQiAttackForcePosCellData.New(i, k)
			self.posCellMap[i][k].isExist = true
		end
	end

	self:updateAllExistPos()
end

function AoQiAttackForceBlockData:getPos(x, y)
	local posX = checknumber(x)
	local posY = checknumber(y)

	return self.posCellMap[posX] and self.posCellMap[posX][posY]
end

function AoQiAttackForceBlockData:getPosExist(x, y)
	local pos = self:getPos(x, y)

	return pos and pos.isExist
end

function AoQiAttackForceBlockData:getPosCover(x, y)
	local pos = self:getPos(x, y)
	local var_5_0

	if pos then
		::label_5_0::

		var_5_0 = pos.isExist and pos.coverBlock
	end

	return var_5_0
end

function AoQiAttackForceBlockData:updateAllExistPos()
	self.existPosList = {}

	for i = 1, self.curWidth do
		for k = 1, self.curHeight do
			local pos = self:getPos(i, k)

			if pos and pos.isExist then
				table.insert(self.existPosList, pos)
			end
		end
	end
end

function AoQiAttackForceBlockData:getAllExistPos()
	return self.existPosList
end

function AoQiAttackForceBlockData:getPosByAnchorPos(pos, anchorPos)
	local newPosX = pos.posX + anchorPos.posX - 1
	local newPosY = pos.posY + anchorPos.posY - 1

	return self:getPos(newPosX, newPosY)
end

function AoQiAttackForceBlockData:checkAndGetPutInPosList(block, anchorPosX, anchorPosY)
	local coverPosList = {}
	local anchorPos = self:getPos(anchorPosX, anchorPosY)

	if anchorPos then
		local existPosList = block:getAllExistPos()

		for _, pos in ipairs(existPosList) do
			local checkPos = self:getPosByAnchorPos(pos, anchorPos)

			if checkPos then
				if checkPos.coverBlock then
					return false, {}
				else
					table.insert(coverPosList, checkPos)
				end
			else
				return false, {}
			end
		end
	end

	return true, coverPosList
end

function AoQiAttackForceBlockData:checkAndGetPutInPosListIgnore(block, anchorPosX, anchorPosY)
	local coverPosList = {}
	local coverBlockMap = {}
	local anchorPos = self:getPos(anchorPosX, anchorPosY)

	if anchorPos then
		local existPosList = block:getAllExistPos()

		for _, pos in ipairs(existPosList) do
			local checkPos = self:getPosByAnchorPos(pos, anchorPos)

			if checkPos then
				if checkPos.coverBlock then
					coverBlockMap[checkPos.coverBlock] = true
				else
					table.insert(coverPosList, checkPos)
				end
			else
				return false, {}
			end
		end
	end

	return true, coverPosList, coverBlockMap
end

function AoQiAttackForceBlockData:putInBlock(block, anchorPosX, anchorPosY)
	local anchorPos = self:getPos(anchorPosX, anchorPosY)

	if anchorPos then
		local existPosList = block:getAllExistPos()

		for _, pos in ipairs(existPosList) do
			local checkPos = self:getPosByAnchorPos(pos, anchorPos)

			if checkPos then
				checkPos.coverBlock = block
			end
		end

		self.anchorMap[block] = anchorPos
	end
end

function AoQiAttackForceBlockData:removeBlock(block)
	local anchorPos = self.anchorMap[block]

	if anchorPos then
		local existPosList = block:getAllExistPos()

		for _, pos in ipairs(existPosList) do
			local checkPos = self:getPosByAnchorPos(pos, anchorPos)

			if checkPos then
				checkPos.coverBlock = nil
			end
		end

		self.anchorMap[block] = nil
	end
end

function AoQiAttackForceBlockData:checkConnected(blockA, blockB)
	local anchorPosA = self.anchorMap[blockA]
	local anchorPosB = self.anchorMap[blockB]

	if anchorPosA and anchorPosB then
		local existPosList = blockA:getAllExistPos()

		for _, pos in ipairs(existPosList) do
			local checkPos = self:getPosByAnchorPos(pos, anchorPosA)

			if blockB == self:getPosCover(checkPos.posX + 1, checkPos.posY) then
				return true
			elseif blockB == self:getPosCover(checkPos.posX - 1, checkPos.posY) then
				return true
			elseif blockB == self:getPosCover(checkPos.posX, checkPos.posY + 1) then
				return true
			elseif blockB == self:getPosCover(checkPos.posX, checkPos.posY - 1) then
				return true
			end
		end
	end

	return false
end

function AoQiAttackForceBlockData:mergeBlock(blockA, blockB)
	local anchorPosA = self.anchorMap[blockA]
	local anchorPosB = self.anchorMap[blockB]

	if anchorPosA and anchorPosB then
		local posX, posY, newWidth, newHeigh = self:getBlockParams(blockA, blockB)
		local newBlock = AoQiAttackForceBlockData.New()
		local newPosMap = {}

		for i = 1, newWidth do
			for k = 1, newHeigh do
				newPosMap[i] = newPosMap[i] or {}
				newPosMap[i][k] = AoQiAttackForcePosCellData.New(i, k)
			end
		end

		local posListA = blockA:getAllExistPos()
		local posListB = blockB:getAllExistPos()
		local anchorPosA = self.anchorMap[blockA]
		local anchorPosB = self.anchorMap[blockB]

		for _, pos in ipairs(posListA) do
			local x = pos.posX + anchorPosA.posX - posX
			local y = pos.posY + anchorPosA.posY - posY
			local setPos = newPosMap[x][y]

			setPos.isExist = true
			setPos.coverBlock = pos.coverBlock
		end

		for _, pos in ipairs(posListB) do
			local x = pos.posX + anchorPosB.posX - posX
			local y = pos.posY + anchorPosB.posY - posY
			local setPos = newPosMap[x][y]

			setPos.isExist = true
			setPos.coverBlock = pos.coverBlock
		end

		local anchorMap = {}

		for block, anchorPos in pairs(blockA.anchorMap) do
			local x = anchorPos.posX - anchorPosA.posX - posX
			local y = anchorPos.posY + anchorPosA.posY - posY

			anchorMap[block] = newPosMap[x][y]
		end

		for block, anchorPos in pairs(blockB.anchorMap) do
			local x = anchorPos.posX - anchorPosB.posX - posX
			local y = anchorPos.posY + anchorPosB.posY - posY

			anchorMap[block] = newPosMap[x][y]
		end

		newBlock.posCellMap = newPosMap
		newBlock.anchorMap = anchorMap

		newBlock:updateAllExistPos()
		self:removeBlock(blockA)
		self:removeBlock(blockB)
		self:putInBlock(newBlock, posX, posY)

		return newBlock
	end
end

function AoQiAttackForceBlockData:getBlockParams(blockA, blockB)
	local minX, minY, maxX, maxY
	local existPosListA = blockA:getAllExistPos()
	local existPosListB = blockB:getAllExistPos()
	local anchorPosA = self.anchorMap[blockA]
	local anchorPosB = self.anchorMap[blockB]

	for _, pos in ipairs(existPosListA) do
		local checkPos = self:getPosByAnchorPos(pos, anchorPosA)

		minX = self:compareAndSetValue(minX, checkPos.posX, false)
		minY = self:compareAndSetValue(minX, checkPos.posY, false)
		maxX = self:compareAndSetValue(true, checkPos.posX, false)
		maxY = self:compareAndSetValue(minX, checkPos.posY, true)
	end

	for _, pos in ipairs(existPosListB) do
		local checkPos = self:getPosByAnchorPos(pos, anchorPosB)

		minX = self:compareAndSetValue(minX, checkPos.posX, false)
		minY = self:compareAndSetValue(minX, checkPos.posY, false)
		maxX = self:compareAndSetValue(true, checkPos.posX, false)
		maxY = self:compareAndSetValue(minX, checkPos.posY, true)
	end

	return minX, minY, maxX - minX + 1, maxY - minY + 1
end

function AoQiAttackForceBlockData:compareAndSetValue(setValue, compareValue, isGreater)
	local newValue

	return setValue and (isGreater and (setValue < compareValue and compareValue or setValue) or compareValue < setValue and compareValue or setValue) or compareValue
end

return AoQiAttackForceBlockData

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarykoi/view/AnniversaryKoiNumMove.lua

module("logic.extensions.anniversarykoi.view.AnniversaryKoiNumMove", package.seeall)

local AnniversaryKoiNumMove = class("AnniversaryKoiNumMove")

function AnniversaryKoiNumMove:ctor(parent, animParams, cfg)
	self._animParams = animParams
	self._cfg = cfg
	self._parent = parent
end

function AnniversaryKoiNumMove:init(go)
	self._petCells = {}

	for i = 1, #self._animParams do
		local cell = goutil.cloneAndSetParent(go, self._parent.transform)

		GameUtil.setLocalPos(cell, self._animParams[i].posX, self._animParams[i].posY, 0)
		MaterialMgr.setIcon(goutil.findChild(cell, "con"), MatType.Pet, self._cfg[i - 1].raceId)
		GameUtil.SetActive(cell, true)
		table.insert(self._petCells, cell)
	end

	self._isSetNumber = false
end

function AnniversaryKoiNumMove:refrshNum(koiNum)
	if #self._petCells > 0 then
		for i = 1, #self._animParams do
			local cell = self._petCells[i]
			local num = koiNum + i - 3

			if num < 0 then
				num = 9 - math.abs(num)
			elseif num > 9 then
				num = num % 10
			end

			MaterialMgr.setIcon(goutil.findChild(cell, "con"), MatType.Pet, self._cfg[num].raceId)
		end
	end
end

function AnniversaryKoiNumMove:setMoveParams(speed, round, myNumber)
	self._speed = speed
	self._round = round
	self._myNumber = myNumber
	self._curPos = 1
	self._curNumber = 5
	self._curRound = 1
	self._isSlow = false
	self._isStop = false
end

function AnniversaryKoiNumMove:setSlown()
	self._isSlow = true
end

function AnniversaryKoiNumMove:getStopState()
	return self._isStop
end

function AnniversaryKoiNumMove:setNumberOn()
	self._isSetNumber = true
end

function AnniversaryKoiNumMove:getSetNumber()
	return self._isSetNumber
end

function AnniversaryKoiNumMove:move()
	settimer(self._speed, self.moveNextPos, self, true)
end

function AnniversaryKoiNumMove:moveNextPos()
	if self._myNumber > 5 then
		if not (self._myNumber - 6) then
			local moveNum = self._myNumber + 4

			if self._isSlow then
				local isSlowDownNum = self._curRound * 10 + moveNum - 5

				if self._curRound < self._round then
					isSlowDownNum = self._round * 10 + moveNum - 5
				end

				local roundNum = math.floor(isSlowDownNum / 10)

				if isSlowDownNum % 10 >= 5 then
					roundNum = math.ceil(isSlowDownNum / 10)
				end

				if self._curRound == roundNum and self._curNumber == moveNum and not self._isStop then
					self._isStop = true

					self:stop()

					return
				elseif self._curRound == roundNum then
					if isSlowDownNum % 10 < 5 and self._curNumber < isSlowDownNum % 10 then
						self._speed = self._speed + 0.2

						self:stop()
						settimer(self._speed, self.moveNextPos, self, true)
					elseif isSlowDownNum % 10 >= 5 and self._curNumber >= isSlowDownNum % 10 then
						self:stop()

						self._speed = self._speed + 0.2

						settimer(self._speed, self.moveNextPos, self, true)
					end
				end
			end

			self:tweenKill()

			for id = 1, #self._animParams do
				local posId = math.floor((self._curPos + id) % 5) + 1
				local cell = self._petCells[id]
				local pos = Vector3.New(self._animParams[posId].posX, self._animParams[posId].posY, 0)
				local tweenMove = cell.transform:DOLocalMove(pos, self._speed - 0.1):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
					GameUtil.setLocalPos(cell, self._animParams[posId].posX, self._animParams[posId].posY, 0)
				end)

				self._tweenList = self._tweenList or {}

				table.insert(self._tweenList, tweenMove)
				GameUtil.SetActive(cell, posId ~= 1)

				if posId == 5 then
					MaterialMgr.setIcon(goutil.findChild(cell, "con"), MatType.Pet, self._cfg[self._curNumber % 10].raceId)
				end
			end

			self._curPos = self._curPos <= #self._animParams - 1 and self._curPos + 1 or 1

			if self._curNumber >= 9 then
				self._curNumber = 0
				self._curRound = self._curRound + 1
			else
				self._curNumber = self._curNumber + 1
			end
		end
	end
end

function AnniversaryKoiNumMove:stop()
	removetimer(self.moveNextPos, self)
	self:tweenKill()
end

function AnniversaryKoiNumMove:tweenKill()
	if self._tweenList then
		for _, tween in ipairs(self._tweenList) do
			tween:Kill(true)
		end
	end

	self._tweenList = {}
end

function AnniversaryKoiNumMove:destroy()
	for _, cell in ipairs(self._petCells) do
		goutil.destroy(cell, true)
	end
end

return AnniversaryKoiNumMove

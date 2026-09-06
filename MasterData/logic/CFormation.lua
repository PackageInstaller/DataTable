-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/component/CFormation.lua

module("logic.extensions.common.component.CFormation", package.seeall)

local CFormation = class("CFormation", BaseLuaOnce)

function CFormation:buildUI()
	self._petPos = {}

	for i = 1, 9 do
		local petPosCell = {}

		petPosCell.go = self:getGo("cell_" .. i)
		petPosCell.con = goutil.findChild(petPosCell.go, "con")
		self._petPos[i] = petPosCell
	end
end

function CFormation:onExit()
	for i = 1, #self._petPos do
		uGuiUtil.clearImage(self._petPos[i].con)
	end

	self._updateCellCallBack = nil
	self._updateCellCallBackObj = nil
end

function CFormation:regCellUpdateCallBack(updateCellCallBack, updateCellCallBackObj)
	self._updateCellCallBack = updateCellCallBack
	self._updateCellCallBackObj = updateCellCallBackObj
end

function CFormation:onEnter(cFormationMo)
	self._cFormationMo = cFormationMo

	self:_refreshUI()
end

function CFormation:_refreshUI()
	self:_petPosReset()

	local isFlip = self._cFormationMo:isFlip()
	local scaleX = isFlip and -1 or 1

	for i, cell in ipairs(self._petPos) do
		local raceId = self._cFormationMo:getRaceId(i)

		goutil.setActive(cell.go, raceId > 0)

		if raceId > 0 then
			local modelCo = CharacterConfig.instance:getModelCo(raceId)

			uGuiUtil.setSpriteToImage(cell.con, uGuiUtil.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))

			local x, y, z = Framework.TransformUtil.GetLocalScale(cell.con.transform, 0, 0, 0)

			Framework.TransformUtil.SetLocalScale(cell.con.transform, scaleX, y, z)

			if self._updateCellCallBack then
				if self._updateCellCallBackObj then
					self._updateCellCallBack(self._updateCellCallBackObj, cell, raceId, i)
				else
					self._updateCellCallBack(cell, raceId, i)
				end
			end
		end
	end
end

function CFormation:_petPosReset()
	for i = 1, #self._petPos do
		goutil.setActive(self._petPos[i].go, false)
	end
end

return CFormation

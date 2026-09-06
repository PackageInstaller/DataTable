-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brotherhood/view/BHDialogCell.lua

module("logic.extensions.brotherhood.view.BHDialogCell", package.seeall)

local BHDialogCell = class("BHDialogCell")

function BHDialogCell:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self.mainGO = go
	self._dropArea = goutil.findChild(go, "dropArea")

	DropHandler.Get(self._dropArea):AddLuaHandler(function(_go, eventData)
		self:_onDrop(_go, eventData)
	end)

	self._txtDesc = goutil.findChildTextComponent(go, "dropArea/txt")
	self._txtDesc.text = ""
	self._headIcon = goutil.findChild(go, "head/icon")
end

function BHDialogCell:init(data)
	self._data = data
	self.mainGO.name = "cell_" .. data.groupId

	local isNeedMatch = data.match == 1

	if isNeedMatch then
		local isUnlock = BrotherHoodModel.instance:isUnlock(data.plotPlan, data.fragmentsId)

		self._txtDesc.text = isUnlock and data.plot or ""
	else
		self._txtDesc.text = data.plot
	end

	if self._headIcon and data.raceId > 0 then
		MaterialMgr.setIcon(self._headIcon, MatType.Pet, data.raceId)
	end
end

function BHDialogCell:reset()
	MaterialMgr.clearIcon(self._headIcon)
end

function BHDialogCell:_onDrop(go, eventData)
	BrotherHoodController.instance:localNotify(BrotherHoodController.Drop, go, eventData, self._data)
end

return BHDialogCell

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/scufflemission/CampScuffleFmtCell.lua

module("logic.extensions.funcamp.view.scufflemission.CampScuffleFmtCell", package.seeall)

local CampScuffleFmtCell = class("CampScuffleFmtCell")

function CampScuffleFmtCell:buildUI(go)
	self._go = go
	self._itemPet = goutil.findChild(go, "itemPet")
	self._txtName = goutil.findChildTextComponent(go, "txtName")
end

function CampScuffleFmtCell:init(index, id)
	self._index = index
	self._id = id

	local bagPetMo = CampScuffleModel.instance:createPet(id)
	local proxy = MaterialMgr.setCellByMo(bagPetMo, self._itemPet)

	proxy.binder:setAutoTips(false)
	proxy.binder:setCallBack(function()
		CommonTipsMgr.instance:showPetTips(bagPetMo)
	end)

	self._txtName.text = bagPetMo:getName()
end

function CampScuffleFmtCell:onReset()
	MaterialMgr.resetAll(self._itemPet)
end

return CampScuffleFmtCell

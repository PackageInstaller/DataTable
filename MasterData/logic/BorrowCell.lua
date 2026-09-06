-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/pet/BorrowCell.lua

module("logic.extensions.material.proxy.pet.BorrowCell", package.seeall)

local BorrowCell = class("BorrowCell", PetCell)

function BorrowCell:setData(info)
	local petMo = BorrowPetModel.instance:getPet(info.petId)

	BorrowCell.super.setData(self, petMo)
	self.target:SetActive(true)
end

function BorrowCell:setCfgData(borrowCo)
	BorrowCell.super.setCfgData(self, borrowCo)

	if checknumber(borrowCo.faceId) > 0 then
		self:setSkin(borrowCo.faceId)
	end

	self.target:SetActive(true)
end

function BorrowCell:_OnClick()
	print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>            BorrowCell:_OnClick()   ", self.data, self.autoTips, self.callback)

	if self.autoTips and self.data then
		-- block empty
	end

	GameUtil.callBack(self.callback, self)
end

function BorrowCell:initCfg(matType, cfgId)
	self.type = matType
	self.id = cfgId
	self.autoTips = true

	local cfg = MaterialMgr.getMatCfg(MatType.Pet, cfgId)

	if cfg == nil and Framework.OSDef.isEditor then
		printWarn(">>>>>MaterialCell initCfg 强制报错：配置错误 存在空的物品【" .. matType .. ":" .. cfgId .. "】")
	end

	self:setCfgData(cfg)
end

return BorrowCell

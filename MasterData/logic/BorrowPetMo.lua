-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/borrowpet/model/BorrowPetMo.lua

module("logic.extensions.bag.model.BorrowPetMo", package.seeall)

local BorrowPetMo = class("BorrowPetMo", BagPetMo)

function BorrowPetMo:ctor()
	BorrowPetMo.super.ctor(self)
end

function BorrowPetMo:initBaseView(baseView)
	BorrowPetMo.super.initBaseView(self, baseView)
end

return BorrowPetMo

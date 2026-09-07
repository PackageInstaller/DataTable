local TransportCellView = class("TransportCellView", import(".OniCellView"))

function TransportCellView:Ctor(arg_1_1)
	TransportCellView.super.Ctor(self, arg_1_1)

	self.tfShadow = self.tf:Find("shadow")
	self.tfIcon = self.tf:Find("ship/icon")
	self.tfHp = self.tf:Find("hp")
	self.tfHpText = self.tf:Find("hp/text")
	self.tfFighting = self.tf:Find("fighting")

	return
end

function TransportCellView:GetRotatePivot()
	return self.tfIcon
end

function TransportCellView:GetOrder()
	return ChapterConst.CellPriorityLittle
end

function TransportCellView:SetActive(arg_4_1)
	SetActive(self.tf, arg_4_1)

	return
end

function TransportCellView:LoadIcon(arg_5_1, arg_5_2)
	if arg_5_1 == "" or self.lastPrefab == arg_5_1 then
		existCall(arg_5_2)

		return
	end

	self.lastPrefab = arg_5_1

	self:GetLoader():GetSpriteQuiet("enemies/" .. arg_5_1, arg_5_1, self.tfIcon)
	existCall(arg_5_2)

	return
end

return TransportCellView

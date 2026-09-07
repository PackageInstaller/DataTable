local AttachmentSupplyCell = class("AttachmentSupplyCell", import("view.level.cell.StaticCellView"))

function AttachmentSupplyCell:GetOrder()
	return ChapterConst.CellPriorityAttachment
end

function AttachmentSupplyCell:Update()
	if IsNil(self.go) then
		self:PrepareBase("supply")
		self:GetLoader():GetPrefab("leveluiview/tpl_supply", "Tpl_Supply", function(arg_3_0)
			setParent(arg_3_0, self.tf)

			tf(arg_3_0).anchoredPosition3D = Vector3(0, 30, 0)
			self.attachTw = LeanTween.moveY(tf(arg_3_0), 40, 1.5):setEase(LeanTweenType.easeInOutSine):setLoopPingPong().uniqueId
			self.supply = arg_3_0

			self:Update()

			return
		end)
	end

	if self.supply then
		setActive(findTF(self.supply, "normal"), self.info.attachmentId > 0)
		setActive(findTF(self.supply, "empty"), false)
	end

	setActive(self.tf, self.info.flag == ChapterConst.CellFlagActive)

	return
end

function AttachmentSupplyCell:RemoveTween()
	if self.attachTw then
		LeanTween.cancel(self.attachTw)
	end

	self.attachTw = nil

	return
end

function AttachmentSupplyCell:Clear()
	self:RemoveTween()
	AttachmentSupplyCell.super.Clear(self)

	return
end

return AttachmentSupplyCell

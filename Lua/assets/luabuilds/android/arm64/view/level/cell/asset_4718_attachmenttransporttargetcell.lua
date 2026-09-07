local AttachmentTransportTargetCell = class("AttachmentTransportTargetCell", import("view.level.cell.StaticCellView"))

function AttachmentTransportTargetCell:GetOrder()
	return ChapterConst.CellPriorityAttachment
end

function AttachmentTransportTargetCell:Update()
	if IsNil(self.go) then
		self:PrepareBase("transport_target")
		self:GetLoader():GetPrefab("leveluiview/Tpl_TransportTarget", "Tpl_TransportTarget", function(arg_3_0)
			setParent(arg_3_0, self.tf)

			tf(arg_3_0).anchoredPosition3D = Vector3.zero
			self.attachTw = LeanTween.moveY(tf(arg_3_0), 10, 1.5):setEase(LeanTweenType.easeInOutSine):setLoopPingPong().uniqueId

			self:ResetCanvasOrder()
			self:Update()

			return
		end)
	end

	return
end

function AttachmentTransportTargetCell:RemoveTween()
	if self.attachTw then
		LeanTween.cancel(self.attachTw)
	end

	self.attachTw = nil

	return
end

function AttachmentTransportTargetCell:Clear()
	self:RemoveTween()
	AttachmentTransportTargetCell.super.Clear(self)

	return
end

return AttachmentTransportTargetCell

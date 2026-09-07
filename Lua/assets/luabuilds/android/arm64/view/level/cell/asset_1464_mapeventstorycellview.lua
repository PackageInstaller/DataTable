local MapEventStoryCellView = class("MapEventStoryCellView", import("view.level.cell.StaticCellView"))

function MapEventStoryCellView:Ctor(arg_1_1)
	MapEventStoryCellView.super.Ctor(self, arg_1_1)

	self.attachTw = nil

	return
end

function MapEventStoryCellView:GetOrder()
	return ChapterConst.CellPriorityAttachment
end

function MapEventStoryCellView:Update()
	local var_3_2

	if IsNil(self.go) then
		local var_3_1 = pg.map_event_template[self.info.attachmentId].icon

		self:PrepareBase("story_" .. self.info.row .. "_" .. self.info.column .. "_" .. self.info.attachmentId)
		setAnchoredPosition(self.tf, Vector2(0, 30))

		self.attachTw = LeanTween.moveY(rtf(self.go), 40, 1.5):setEase(LeanTweenType.easeInOutSine):setLoopPingPong()

		self:GetLoader():GetPrefab("leveluiview/tpl_box", "tpl_box", function(arg_4_0)
			arg_4_0.name = var_3_1

			setParent(arg_4_0, self.tf)
			setAnchoredPosition(arg_4_0, Vector2.zero)
			self:GetLoader():GetPrefab("boxprefab/" .. var_3_1, var_3_1, function(arg_5_0)
				setParent(arg_5_0, tf(arg_4_0):Find("icon"))

				return
			end)

			return
		end)

		var_3_2 = setActive
	end

	var_3_2(self.tf, self.info.flag == ChapterConst.CellFlagActive)

	return
end

function MapEventStoryCellView:DestroyGO()
	if self.attachTw then
		LeanTween.cancel(self.attachTw.uniqueId)

		self.attachTw = nil
	end

	MapEventStoryCellView.super.DestroyGO(self)

	return
end

return MapEventStoryCellView

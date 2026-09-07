local AttachmentBoxCell = class("AttachmentBoxCell", import("view.level.cell.StaticCellView"))

function AttachmentBoxCell:GetOrder()
	return ChapterConst.CellPriorityAttachment
end

function AttachmentBoxCell:Update()
	if IsNil(self.go) then
		local var_2_0 = pg.box_data_template[self.info.attachmentId]

		assert(pg.box_data_template[self.info.attachmentId], "box_data_template not exist: " .. self.info.attachmentId)
		self:PrepareBase("box_" .. self.info.attachmentId)

		local var_2_1
		local var_2_2

		parallelAsync({
			function(arg_3_0)
				self:GetLoader():GetPrefab("boxprefab/" .. var_2_0.icon, var_2_0.icon, function(arg_4_0)
					var_2_2 = arg_4_0

					arg_3_0()

					return
				end)

				return
			end,
			function(arg_5_0)
				self:GetLoader():GetPrefab("leveluiview/tpl_box", "tpl_box", function(arg_6_0)
					var_2_1 = arg_6_0

					setParent(tf(var_2_1), self.tf)

					tf(var_2_1).anchoredPosition3D = Vector3(0, 30, 0)

					if var_2_0.type ~= ChapterConst.BoxTorpedo then
						self.attachTw = LeanTween.move(tf(var_2_1), Vector3(0, 40, 0), 1.5):setEase(LeanTweenType.easeInOutSine):setLoopPingPong().uniqueId
					end

					self.box = var_2_1

					arg_5_0()

					return
				end)

				return
			end
		}, function()
			setParent(var_2_2, tf(var_2_1):Find("icon"))
			self:ResetCanvasOrder()
			self:Update()

			return
		end)
	end

	if self.box and self.info.flag == ChapterConst.CellFlagActive then
		setActive(findTF(self.box, "effect_found"), self.info.trait == ChapterConst.TraitVirgin)

		if self.info.trait == ChapterConst.TraitVirgin then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_WEIGHANCHOR_ENEMY)
		end
	end

	setActive(self.tf, self.info.flag == ChapterConst.CellFlagActive)

	return
end

function AttachmentBoxCell:RemoveTween()
	if self.attachTw then
		LeanTween.cancel(self.attachTw)
	end

	self.attachTw = nil

	return
end

function AttachmentBoxCell:Clear()
	self:RemoveTween()
	AttachmentBoxCell.super.Clear(self)

	return
end

return AttachmentBoxCell

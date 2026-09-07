local EnemyDeadCellView = class("EnemyDeadCellView", import("view.level.cell.StaticCellView"))

function EnemyDeadCellView:Ctor(arg_1_1)
	EnemyDeadCellView.super.Ctor(self, arg_1_1)

	self.config = nil
	self.chapter = nil
	self._live2death = nil

	return
end

function EnemyDeadCellView:GetOrder()
	return ChapterConst.CellPriorityLittle
end

function EnemyDeadCellView:Update()
	local var_3_0 = self.info
	local var_3_1 = self.config

	if IsNil(self.go) then
		self:GetLoader():GetPrefab("leveluiview/Tpl_Dead", "Tpl_Dead", function(arg_4_0)
			arg_4_0.name = "enemy_" .. var_3_0.attachmentId
			self.go = arg_4_0
			self.tf = tf(arg_4_0)

			setParent(arg_4_0, self.parent)
			self:OverrideCanvas()
			self:ResetCanvasOrder()
			setAnchoredPosition(self.tf, Vector2.zero)

			if var_3_1.icon_type == 1 then
				setAnchoredPosition(self.tf, Vector2(0, 10))
				self:GetLoader():LoadSprite("enemies/" .. var_3_1.icon .. "_d_blue", "", tf(arg_4_0):Find("icon"))
			end

			setActive(findTF(self.tf, "effect_not_open"), false)
			setActive(findTF(self.tf, "effect_open"), false)
			setActive(findTF(self.tf, "huoqiubaozha"), false)
			self:Update()

			return
		end, "Main")

		return
	end

	setActive(findTF(self.tf, "huoqiubaozha"), self._live2death)

	return
end

function EnemyDeadCellView:Clear()
	self._live2death = nil
	self.chapter = nil

	EnemyDeadCellView.super.Clear(self)

	return
end

return EnemyDeadCellView

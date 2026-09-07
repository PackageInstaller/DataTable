local AgoraDecorationShapePage = class("AgoraDecorationShapePage")

function AgoraDecorationShapePage:Ctor(arg_1_1)
	pg.DelegateInfo.New(self)

	self.tr = arg_1_1
	self.parentTr = arg_1_1.parent
	self.shapes = {
		[IslandConst.AGORA_TILE_SHAPE_ALL] = self.tr:Find("bg/list/1"),
		[IslandConst.AGORA_TILE_SHAPE_FAN] = self.tr:Find("bg/list/2"),
		[IslandConst.AGORA_TILE_SHAPE_TRIANGLE] = self.tr:Find("bg/list/3"),
		[IslandConst.AGORA_TILE_SHAPE_ARC] = self.tr:Find("bg/list/4")
	}

	self:InitShapes()

	self.bgTr = arg_1_1:Find("bg")
	self.localPosition = self.bgTr.localPosition

	return
end

function AgoraDecorationShapePage:InitShapes()
	for iter_2_0, iter_2_1 in pairs(self.shapes) do
		onButton(self, iter_2_1, function()
			if self.callback then
				self.callback(iter_2_0)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function AgoraDecorationShapePage:Show(arg_4_1, arg_4_2)
	self.callback = arg_4_2

	setParent(self.tr, arg_4_1._go.transform.parent)
	self.tr:SetSiblingIndex(arg_4_1._go.transform:GetSiblingIndex() + 1)
	setActive(self.tr, true)
	self:AdjustPosition(arg_4_1._go.transform.parent)

	return
end

function AgoraDecorationShapePage:AdjustPosition(arg_5_1)
	self.bgTr.localPosition = self.localPosition - Vector3(arg_5_1:GetComponent(typeof(HorizontalLayoutGroup)).spacing, 0, 0)

	return
end

function AgoraDecorationShapePage:Hide()
	self.callback = nil

	setParent(self.tr, self.parentTr)
	setActive(self.tr, false)

	return
end

function AgoraDecorationShapePage:Destroy()
	pg.DelegateInfo.Dispose(self)

	return
end

return AgoraDecorationShapePage

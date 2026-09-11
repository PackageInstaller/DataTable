local MatrixRotationDiagramItem = class("MatrixRotationDiagramItem", ReduxView)

function MatrixRotationDiagramItem:OnCtor(arg_1_1, arg_1_2)
	local var_1_0 = Object.Instantiate(arg_1_1, arg_1_2)

	self.gameObject_ = var_1_0
	self.transform_ = var_1_0.transform
	self.rectTransform_ = var_1_0:GetComponent(typeof(RectTransform))

	self:Init()
end

function MatrixRotationDiagramItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.campController = ControllerUtil.GetController(self.transform_, "camp")
end

function MatrixRotationDiagramItem:InitUI()
	self:BindCfgUI()
end

function MatrixRotationDiagramItem:AddUIListener()
	return
end

function MatrixRotationDiagramItem:SetData(arg_5_1)
	self.index = arg_5_1

	self.campController:SetSelectedIndex(arg_5_1 - 1)

	self.img = self["m_img" .. arg_5_1]
end

function MatrixRotationDiagramItem:RegistCallBack(arg_6_1)
	self.callback_ = arg_6_1
end

function MatrixRotationDiagramItem:SetPosId(arg_7_1)
	self.posId = arg_7_1
end

function MatrixRotationDiagramItem:GetPosId()
	return self.posId
end

function MatrixRotationDiagramItem:GetIndex()
	return self.index
end

function MatrixRotationDiagramItem:InitPosData(arg_10_1)
	self.rectTransform_.anchoredPosition = arg_10_1.pos
	self.m_container.transform.localScale = Vector2.one * arg_10_1.scale
	self.img.color = arg_10_1.color

	self.transform_:SetSiblingIndex(arg_10_1.order)
end

function MatrixRotationDiagramItem:SetPosData(arg_11_1)
	LeanTween.scale(self.m_container, Vector3.one * arg_11_1.scale, 0.5):setEase(LeanTweenType.easeOutQuad)
	LeanTween.moveLocal(self.gameObject_, arg_11_1.pos, 0.5):setEase(LeanTweenType.easeOutQuad)

	local var_11_0 = self.img.color
	local var_11_1 = arg_11_1.color

	LeanTween.value(self.gameObject_, 0, 1, 0.5):setEase(LeanTweenType.easeOutQuad):setOnUpdate(LuaHelper.FloatAction(function(arg_12_0)
		self.img.color = Color.Lerp(var_11_0, var_11_1, arg_12_0)
	end))
	self.transform_:SetSiblingIndex(arg_11_1.order)
end

function MatrixRotationDiagramItem:Dispose()
	MatrixRotationDiagramItem.super.Dispose(self)
end

return MatrixRotationDiagramItem

local AshSectionLineItem = class("AshSectionLineItem", ReduxView)
local var_0_1 = "Widget/System/Activity_EkChuah/EkChuah_Com/Stage_item/stageLine"

function AshSectionLineItem:Ctor(arg_1_1)
	self.gameObject_ = GameObject.Instantiate(Asset.Load(var_0_1))
	self.transform_ = self.gameObject_.transform
	self.transform_.parent = arg_1_1
	self.lineTf_ = self.transform_:GetComponent("RectTransform")
	self.transform_.localPosition = Vector3.zero
	self.transform_.localRotation = Quaternion.identity
	self.transform_.localScale = Vector3.one
end

function AshSectionLineItem:RefreshUI(arg_2_1, arg_2_2)
	self.lineTf_.localPosition = arg_2_1
	self.lineTf_.localScale = Vector2.New(arg_2_2 and 1 or -1, 1)
end

function AshSectionLineItem:Dispose()
	GameObject.DestroyImmediate(self.gameObject_)
	Asset.Unload(var_0_1)
	self.super.Dispose(self)
end

return AshSectionLineItem

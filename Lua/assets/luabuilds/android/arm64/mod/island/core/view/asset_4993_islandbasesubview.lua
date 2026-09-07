local IslandBaseSubView = class("IslandBaseSubView", import("Mod.Island.Core.View.IslandBaseUnit"))

function IslandBaseSubView:Init(...)
	local var_1_0 = packEx(...)

	self:LoadUI(function(arg_2_0)
		self:DoInit(arg_2_0, var_1_0)

		return
	end)

	return
end

function IslandBaseSubView:LoadUI(arg_3_1)
	self.loadingId = IslandAssetLoadDispatcher.Instance:Enqueue("UI/" .. self:GetUIName(), "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_4_0)
		self.insId = FrameAsyncInstantiateManager.Instance:EnqueueInstantiateUI(arg_4_0, self:GetUIParent(), Vector3.zero, arg_3_1)

		return
	end), true, true)

	return
end

function IslandBaseSubView:DoInit(arg_5_1, arg_5_2)
	self._go = arg_5_1
	self._tf = arg_5_1.transform

	IslandBaseSubView.super.Init(self, arg_5_1)

	self._tf.localPosition = Vector3.zero

	arg_5_1.transform:SetAsFirstSibling()
	self:OnBeforeLoaded()
	self:FirstFlush()
	self:Flush(unpackEx(arg_5_2))
	self:OnLoaded()

	return
end

function IslandBaseSubView:OnDispose()
	self:UnloadUI()

	self._go = nil
	self._tf = nil

	return
end

function IslandBaseSubView:UnloadUI()
	if not IsNil(self._go) then
		Object.Destroy(self._go)
	end

	if self.loadingId then
		IslandAssetLoadDispatcher.Instance:Cancel(self.loadingId)

		self.loadingId = nil
	end

	if self.insId then
		FrameAsyncInstantiateManager.Instance:Cancel(self.insId)

		self.insId = nil
	end

	self.exited = true

	return
end

function IslandBaseSubView:ShowMsgbox(arg_8_1)
	self:GetView():ShowMsgbox(arg_8_1)

	return
end

function IslandBaseSubView:GetPlayerUnit()
	return self:GetView().player
end

function IslandBaseSubView:CreateSubView(arg_10_1)
	return arg_10_1.New(self:GetView())
end

function IslandBaseSubView:GetUIName()
	assert(false, "overwrite me")

	return
end

function IslandBaseSubView:GetUIParent(arg_12_1)
	assert(false, "overwrite me")

	return
end

function IslandBaseSubView:Flush(...)
	return
end

function IslandBaseSubView:FirstFlush()
	return
end

function IslandBaseSubView:OnBeforeLoaded()
	return
end

function IslandBaseSubView:OnLoaded()
	return
end

return IslandBaseSubView

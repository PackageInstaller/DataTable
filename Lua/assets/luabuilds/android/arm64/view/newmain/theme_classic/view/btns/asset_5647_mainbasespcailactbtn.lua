local MainBaseSpcailActBtn = class("MainBaseSpcailActBtn")

function MainBaseSpcailActBtn:Ctor(arg_1_1, arg_1_2)
	pg.DelegateInfo.New(self)

	self.root = arg_1_1
	self.event = arg_1_2
	self.isloading = false

	return
end

function MainBaseSpcailActBtn:Init(arg_2_1, arg_2_2)
	self.isScale = arg_2_1
	self.isOverflow = arg_2_2

	if self.isloading then
		return
	end

	if not self._tf then
		self.isloading = true

		ResourceMgr.Inst:getAssetAsync("ui/" .. self:GetUIName(), "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_3_0)
			self.isloading = false

			if self.exited then
				return
			end

			self._tf = Object.Instantiate(arg_3_0, self:GetContainer()).transform

			self:OnRegister()
			self:OnInit()
			onButton(self, self._tf, function()
				self:OnClick()

				return
			end, SFX_MAIN)

			if self.shouldHide then
				setActive(self._tf, false)
			end

			return
		end), true, true)
	else
		self:OnInit()
	end

	self:CheckHide()

	return
end

function MainBaseSpcailActBtn:Clear()
	if not IsNil(self._tf) then
		Destroy(self._tf.gameObject)

		self._tf = nil

		self:OnClear()
	end

	return
end

function MainBaseSpcailActBtn:Dispose()
	self.exited = true

	pg.DelegateInfo.Dispose(self)
	self:Clear()

	return
end

function MainBaseSpcailActBtn:Refresh()
	self:CheckHide()

	return
end

function MainBaseSpcailActBtn:CheckHide()
	if self.shouldHide and not IsNil(self._tf) then
		setActive(self._tf, true)
	end

	self.shouldHide = false

	return
end

function MainBaseSpcailActBtn:Disable()
	self.shouldHide = true

	self:OnDisable()

	return
end

function MainBaseSpcailActBtn:GetContainer()
	assert(false, "overview me !!!")

	return
end

function MainBaseSpcailActBtn:InShowTime()
	assert(false, "overview me !!!")

	return
end

function MainBaseSpcailActBtn:GetUIName()
	return
end

function MainBaseSpcailActBtn:OnClick()
	return
end

function MainBaseSpcailActBtn:OnRegister()
	return
end

function MainBaseSpcailActBtn:OnInit()
	return
end

function MainBaseSpcailActBtn:OnClear()
	return
end

function MainBaseSpcailActBtn:OnDisable()
	return
end

return MainBaseSpcailActBtn

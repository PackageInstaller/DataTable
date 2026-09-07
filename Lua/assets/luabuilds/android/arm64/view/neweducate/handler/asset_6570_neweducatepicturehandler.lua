local NewEducatePictureHandler = class("NewEducatePictureHandler")
local var_0_1 = 1

function NewEducatePictureHandler:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self._anim = self._tf:GetComponent(typeof(Animation))
	self.bgTF = self._tf:Find("bg")
	self.nameTF = self.bgTF:Find("name")
	self.imageCom = self.bgTF:Find("picture"):GetComponent(typeof(Image))

	return
end

function NewEducatePictureHandler:Play(arg_2_1, arg_2_2, arg_2_3)
	setActive(self._go, true)

	if self._anim then
		self._anim:Play()
	end

	setText(self.nameTF, arg_2_3 or "")
	ResourceMgr.Inst:getAssetAsync("neweducateicon/" .. arg_2_1, "", typeof(Sprite), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_3_0)
		self.imageCom.sprite = arg_3_0
		self.timer = Timer.New(function()
			existCall(arg_2_2)

			return
		end, var_0_1)

		self.timer:Start()

		return
	end), true, true)

	return
end

function NewEducatePictureHandler:Reset()
	setActive(self._go, false)

	self.imageCom.sprite = nil

	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function NewEducatePictureHandler:Destroy()
	return
end

return NewEducatePictureHandler

local SpineAnimChar = class("SpineAnimChar")
local var_0_1 = "normal"

SpineAnimChar.state_init = 1
SpineAnimChar.state_loading = 2
SpineAnimChar.state_complete = 3
SpineAnimChar.state_dispose = 4

function SpineAnimChar:Ctor(arg_1_1)
	if arg_1_1 then
		self.config = pg.ship_skin_template[arg_1_1]
		self.prefab = self.config.prefab
	end

	self.state = SpineAnimChar.state_init
	self.normalAction = var_0_1

	return
end

function SpineAnimChar:GetCharModel()
	return self._model
end

function SpineAnimChar:SetName(arg_3_1)
	if self:isComplete() then
		self._model.name = arg_3_1
	end

	return
end

function SpineAnimChar:SetSiblingIndex(arg_4_1)
	if self:isComplete() then
		self._model.transform:SetSiblingIndex(arg_4_1)
	end

	return
end

function SpineAnimChar:SetPaint(arg_5_1)
	self.prefab = arg_5_1

	return
end

function SpineAnimChar:Load(arg_6_1, arg_6_2)
	if self.state == SpineAnimChar.state_init then
		self.state = SpineAnimChar.state_loading

		PoolMgr.GetInstance():GetSpineChar(self.prefab, self.sync, function(arg_7_0)
			if arg_7_0 then
				if self:isDispose() then
					PoolMgr.GetInstance():ReturnSpineChar(self.prefab, arg_7_0)
				else
					self:start(arg_7_0)

					if arg_6_2 then
						arg_6_2(self)
					end
				end
			else
				self.state = SpineAnimChar.state_init
			end

			return
		end)
	end

	return
end

function SpineAnimChar:SetPivot(arg_8_1)
	if self:isComplete() then
		tf(self._model).pivot = arg_8_1
	end

	return
end

function SpineAnimChar:SetSizeDelta(arg_9_1)
	if self:isComplete() then
		tf(self._model).sizeDelta = arg_9_1
	end

	return
end

function SpineAnimChar:SetParent(arg_10_1, arg_10_2)
	if not self:isComplete() then
		self.loadedParent = arg_10_1

		return
	end

	SetParent(self._model, arg_10_1, arg_10_2 and true or false)

	return
end

function SpineAnimChar:SetNormalAction(arg_11_1)
	self.normalAction = arg_11_1

	return
end

function SpineAnimChar:SetAction(arg_12_1, arg_12_2)
	arg_12_2 = arg_12_2 or 0
	self.actionName = arg_12_1

	local var_12_0, var_12_1 = self:getDirectActonName(arg_12_1)

	self.modelScale = self.modelScale or tf(self._model).localScale

	if var_12_1 then
		tf(self._model).localScale = Vector3(math.abs(self.modelScale.x), self.modelScale.y, self.modelScale.z)
	else
		local var_12_3 = math.sign(self.modelScale.x)

		tf(self._model).localScale = self.modelScale
	end

	self._animUI:SetAction(var_12_0, arg_12_2)

	return
end

function SpineAnimChar:SetActionOnce(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	self:SetActionCallBack(nil)
	self:SetActionCallBack(function(arg_14_0)
		if arg_14_0 == "action" then
			if arg_13_3 then
				arg_13_3()
			end
		elseif arg_14_0 == "finish" and arg_13_4 then
			arg_13_4()
		end

		return
	end)
	self:SetAction(arg_13_1, arg_13_2)

	return
end

function SpineAnimChar:SetActionCallBack(arg_15_1)
	self._animUI:SetActionCallBack(arg_15_1)

	return
end

function SpineAnimChar:GetLocalScale()
	if self:isComplete() then
		return tf(self._model).localScale
	end

	return
end

function SpineAnimChar:SetLocalScale(arg_17_1)
	if self:isComplete() then
		self.direct = math.sign(arg_17_1.x)
		tf(self._model).localScale = arg_17_1
		self.modelScale = arg_17_1

		self:updateCharDirect()
	end

	return
end

function SpineAnimChar:SetLocalPosition(arg_18_1)
	if self:isComplete() then
		tf(self._model).localPosition = arg_18_1
	end

	return
end

function SpineAnimChar:SetAnchoredPosition(arg_19_1)
	if self:isComplete() then
		tf(self._model).anchoredPosition = arg_19_1
	end

	return
end

function SpineAnimChar:GetAnchoredPosition()
	if self:isComplete() then
		return tf(self._model).anchoredPosition
	end

	return
end

function SpineAnimChar:SetLayer(arg_21_1)
	if self:isComplete() then
		pg.ViewUtils.SetLayer(tf(self._model), arg_21_1)
	end

	return
end

function SpineAnimChar:SetAnchoredPosition3D(arg_22_1)
	if self:isComplete() then
		tf(self._model).anchoredPosition3D = arg_22_1
	end

	return
end

function SpineAnimChar:GetPauseStatue()
	if self._animUI then
		return self._animUI.Pause
	end

	return nil
end

function SpineAnimChar:GetSkeletonGraphic()
	return self._skeletonGraphic
end

function SpineAnimChar:GetAnimationState()
	if self._animUI then
		return self._animUI:GetAnimationState()
	end

	return nil
end

function SpineAnimChar:GetModel()
	return self._model
end

function SpineAnimChar:Resume()
	if self._animUI then
		return self._animUI:Resume()
	end

	return
end

function SpineAnimChar:Pause()
	if self._animUI then
		return self._animUI:Pause()
	end

	return
end

function SpineAnimChar:Dispose()
	if self.state == SpineAnimChar.state_complete then
		self:SetActionCallBack(nil)
		PoolMgr.GetInstance():ReturnSpineChar(self.prefab, self._model)
	end

	self._animUI = nil
	self.prefab = nil
	self._model = nil
	self.state = SpineAnimChar.state_dispose
	self.parent = nil

	return
end

function SpineAnimChar:start(arg_30_1)
	self.state = SpineAnimChar.state_complete
	self._model = arg_30_1
	self._animUI = arg_30_1:GetComponent(typeof(SpineAnimUI))
	self._skeletonGraphic = arg_30_1:GetComponent("SkeletonGraphic")

	if self.loadedParent then
		self:setParent(arg_30_1, self.parent)

		self.loadedParent = nil
	end

	if self.loadedScale then
		self:setScale(self.loadedScale)

		self.loadedScale = nil
	end

	if self.loadedPosition then
		self:setPosition(self.loadedPosition)

		self.loadedPosition = nil
	end

	return
end

function SpineAnimChar:updateCharDirect()
	if self.normalAction == self.actionName then
		self:SetAction(self.actionName, 0, -1)
	end

	return
end

function SpineAnimChar:GetActionName()
	return self.actionName
end

function SpineAnimChar:getDirectActonName(arg_33_1)
	local var_33_0

	if not self.direct then
		self.direct = math.sign(tf(self._model).localScale.x)
		var_33_0 = arg_33_1
	end

	if self._skeletonGraphic.SkeletonData:FindAnimation(var_33_0 .. (self.direct == 1 and "_R" or "_L")) then
		return var_33_0 .. (self.direct == 1 and "_R" or "_L"), true
	end

	return arg_33_1, false
end

function SpineAnimChar:isComplete()
	return self.state == SpineAnimChar.state_complete
end

function SpineAnimChar:isDispose()
	return self.state == SpineAnimChar.state_dispose
end

return SpineAnimChar

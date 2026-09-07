local MainEffectView = class("MainEffectView")

function MainEffectView:Ctor(arg_1_1)
	self.tr = arg_1_1
	self.loading = false
	self.caches = {}

	return
end

function MainEffectView:GetEffect(arg_2_1)
	if arg_2_1.propose then
		return "jiehuntexiao"
	end

	return nil
end

function MainEffectView:Init(arg_3_1)
	self:Load((self:GetEffect(arg_3_1)))

	return
end

function MainEffectView:Refresh(arg_4_1)
	local var_4_0 = self:GetEffect(arg_4_1)

	if var_4_0 and self.loading then
		self:SetDirty(var_4_0)

		return
	end

	self:Load(var_4_0)

	return
end

function MainEffectView:Load(arg_5_1)
	if self.effectName and not arg_5_1 then
		self:Clear()

		return
	end

	if not arg_5_1 or arg_5_1 == self.effectName then
		return
	end

	self:Clear()

	self.loading = true

	self:LoadEffect(arg_5_1, function(arg_6_0)
		self.loading = false
		arg_6_0.transform.localPosition = Vector3.zero
		arg_6_0.transform.localScale = Vector3.one
		self.effectGo = arg_6_0
		self.effectName = arg_5_1

		return
	end)

	self.dirty = nil

	return
end

function MainEffectView:LoadEffect(arg_7_1, arg_7_2)
	if self.caches[arg_7_1] then
		setActive(self.caches[arg_7_1], true)
		arg_7_2(self.caches[arg_7_1])
	else
		ResourceMgr.Inst:getAssetAsync("Effect/" .. arg_7_1, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_8_0)
			if self.exited then
				return
			end

			if self:IsDirty() then
				self:Load(self.dirty)

				return
			end

			local var_8_0 = Object.Instantiate(arg_8_0, self.tr)

			self.caches[arg_7_1] = var_8_0

			arg_7_2(var_8_0)

			return
		end), true, true)
	end

	return
end

function MainEffectView:SetDirty(arg_9_1)
	self.dirty = arg_9_1

	return
end

function MainEffectView:IsDirty()
	return self.dirty ~= nil
end

function MainEffectView:Clear()
	if self.effectGo then
		setActive(self.effectGo, false)

		self.effectGo = nil
	end

	self.effectName = nil
	self.loading = nil

	return
end

function MainEffectView:Dispose()
	self:Clear()

	for iter_12_0, iter_12_1 in pairs(self.caches) do
		Object.Destroy(iter_12_1)
	end

	self.caches = nil
	self.exited = true
	self.dirty = nil

	return
end

return MainEffectView

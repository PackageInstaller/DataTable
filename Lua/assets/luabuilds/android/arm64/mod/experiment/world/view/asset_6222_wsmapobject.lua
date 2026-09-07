local WSMapObject = class("WSMapObject", import("...BaseEntity"))

WSMapObject.Fields = {
	modelType = "number",
	modelAction = "string",
	modelResPath = "string",
	modelParent = "userdata",
	modelActionTimer = "table",
	modelAngles = "table",
	modelScale = "table",
	model = "userdata",
	modelComps = "table",
	modelResAsync = "boolean",
	modelResName = "string"
}

function WSMapObject:GetModelAngles()
	return self.modelAngles and self.modelAngles:Clone() or Vector3.zero
end

function WSMapObject:UpdateModelAngles(arg_2_1)
	if self.modelAngles ~= arg_2_1 then
		self.modelAngles = arg_2_1

		self:FlushModelAngles()
	end

	return
end

function WSMapObject:FlushModelAngles()
	if self.model and self.modelAngles then
		self.model.localEulerAngles = self.modelAngles
	end

	return
end

function WSMapObject:GetModelScale()
	return self.modelScale and self.modelScale:Clone() or Vector3.one
end

function WSMapObject:UpdateModelScale(arg_5_1)
	if self.modelScale ~= arg_5_1 then
		self.modelScale = arg_5_1

		self:FlushModelScale()
	end

	return
end

function WSMapObject:GetModelAction()
	return self.modelAction
end

function WSMapObject:FlushModelScale()
	if self.model and self.modelScale then
		self.model.localScale = self.modelScale
	end

	return
end

function WSMapObject:UpdateModelAction(arg_8_1)
	if self.modelAction ~= arg_8_1 then
		self.modelAction = arg_8_1

		self:FlushModelAction()
	end

	return
end

function WSMapObject:FlushModelAction()
	if self.model and self.modelAction then
		if self.modelType == WorldConst.ModelSpine then
			local var_9_0 = self.modelComps and self.modelComps[1]

			if var_9_0 then
				var_9_0:SetAction(self.modelAction, 0)
			end
		elseif self.modelType == WorldConst.ModelPrefab then
			local var_9_1 = self.modelComps and self.modelComps[1]

			if var_9_1 then
				local var_9_2 = Animator.StringToHash(self.modelAction)

				if var_9_1:HasState(0, var_9_2) then
					var_9_1:Play(var_9_2)
				end
			end
		end
	end

	return
end

function WSMapObject:PlayModelAction(arg_10_1, arg_10_2, arg_10_3)
	assert(arg_10_1)

	local var_10_0 = {}

	if self.model then
		if self.modelType == WorldConst.ModelSpine then
			local var_10_1 = self.modelComps[1]

			if self.modelComps[1] and isa(self.modelComps[1], SpineAnimChar) and self.modelComps[1]:GetModel().transform.gameObject.activeInHierarchy then
				table.insert(var_10_0, function(arg_11_0)
					var_10_1:SetAction(arg_10_1, 0)

					if arg_10_2 then
						self:NewActionTimer(arg_10_2, arg_11_0)
					else
						var_10_1:SetActionCallBack(function(arg_12_0)
							if arg_12_0 == "finish" then
								var_10_1:SetActionCallBack(nil)
								arg_11_0()
							end

							return
						end)
					end

					return
				end)
			elseif self.modelComps[1] and isa(self.modelComps[1], SpineRole) and self.modelComps[1]:GetRootModel().transform.gameObject.activeInHierarchy then
				table.insert(var_10_0, function(arg_13_0)
					var_10_1:SetAction(arg_10_1, 0)

					if arg_10_2 then
						self:NewActionTimer(arg_10_2, arg_13_0)
					else
						var_10_1:SetActionCallBack(function(arg_14_0)
							if arg_14_0 == "finish" then
								var_10_1:SetActionCallBack(nil)
								arg_13_0()
							end

							return
						end)
					end

					return
				end)
			elseif self.modelComps[1] and self.modelComps[1].transform.gameObject.activeInHierarchy then
				table.insert(var_10_0, function(arg_15_0)
					var_10_1:SetAction(arg_10_1, 0)

					if arg_10_2 then
						self:NewActionTimer(arg_10_2, arg_15_0)
					else
						var_10_1:SetActionCallBack(function(arg_16_0)
							if arg_16_0 == "finish" then
								var_10_1:SetActionCallBack(nil)
								arg_15_0()
							end

							return
						end)
					end

					return
				end)
			end
		elseif self.modelType == WorldConst.ModelPrefab then
			local var_10_2 = self.modelComps

			if self.modelComps then
				var_10_2 = self.modelComps[1]
			end

			if var_10_2 and var_10_2.transform.gameObject.activeInHierarchy then
				local var_10_3 = Animator.StringToHash(arg_10_1)

				if var_10_2:HasState(0, var_10_3) then
					table.insert(var_10_0, function(arg_17_0)
						var_10_2:Play(var_10_3)

						if arg_10_2 then
							self:NewActionTimer(arg_10_2, arg_17_0)
						else
							local var_17_0 = self.modelComps[2]

							self.modelComps[2]:SetEndEvent(function()
								var_17_0:SetEndEvent(nil)
								arg_17_0()

								return
							end)
						end

						return
					end)
				end
			end
		end
	end

	seriesAsync(var_10_0, arg_10_3)

	return
end

function WSMapObject:LoadModel(arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	if self.modelType ~= arg_19_1 or self.modelResPath ~= arg_19_2 or self.modelResName ~= arg_19_3 then
		self:UnloadModel()

		self.model = createNewGameObject("model")
		self.modelType = arg_19_1
		self.modelResPath = arg_19_2
		self.modelResName = arg_19_3
		self.modelResAsync = defaultValue(arg_19_4, true)

		local var_19_0 = {}

		if self.modelType == WorldConst.ModelSpine then
			self.modelAction = self.modelAction or WorldConst.ActionIdle

			table.insert(var_19_0, function(arg_20_0)
				self:LoadSpine(arg_20_0)

				return
			end)
		elseif self.modelType == WorldConst.ModelPrefab then
			self.modelAction = self.modelAction or "idle"

			table.insert(var_19_0, function(arg_21_0)
				self:LoadPrefab(arg_21_0)

				return
			end)
		else
			assert("invalid model type: " .. arg_19_1)
		end

		seriesAsync(var_19_0, function()
			if self.modelScale == nil then
				self.modelScale = self.model.localScale
			else
				self:FlushModelScale()
			end

			if self.modelAngles == nil then
				self.modelAngles = self.model.localEulerAngles
			else
				self:FlushModelAngles()
			end

			self:FlushModelAction()

			if arg_19_5 then
				arg_19_5()
			end

			return
		end)
	end

	return
end

function WSMapObject:UnloadModel()
	self:DisposeActionTimer()

	if self.model then
		if self.model.childCount > 0 then
			if self.modelType == WorldConst.ModelSpine then
				self:UnloadSpine()
			elseif self.modelType == WorldConst.ModelPrefab then
				self:UnloadPrefab()
			end
		end

		Destroy(self.model)
	end

	self.model = nil
	self.modelComps = nil
	self.modelType = nil
	self.modelResPath = nil
	self.modelResName = nil
	self.modelResAsync = nil

	return
end

function WSMapObject:LoadSpine(arg_24_1)
	local var_24_0 = self.modelResPath
	local var_24_1 = SpineAnimChar.New()

	var_24_1:SetPaint(self.modelResPath)
	var_24_1:Load(self.modelResAsync, function(arg_25_0)
		if self.modelType ~= WorldConst.ModelSpine or self.modelResPath ~= var_24_0 then
			arg_25_0:Dispose()

			var_24_1 = nil

			return
		end

		arg_25_0:GetSkeletonGraphic().raycastTarget = false

		arg_25_0:SetAnchoredPosition3D(Vector3.zero)
		arg_25_0:SetLocalScale(Vector3.one)
		arg_25_0:SetLayer(Layer.UI)
		arg_25_0:SetParent(self.model)

		self.modelComps = {
			arg_25_0
		}

		arg_24_1()

		return
	end)

	return
end

function WSMapObject:LoadPrefab(arg_26_1)
	local var_26_0 = self.modelResPath
	local var_26_1 = self.modelResName

	PoolMgr.GetInstance():GetPrefab(self.modelResPath, self.modelResName, self.modelResAsync, function(arg_27_0)
		if self.modelType ~= WorldConst.ModelPrefab or self.modelResPath ~= var_26_0 or self.modelResName ~= var_26_1 then
			PoolMgr.GetInstance():ReturnPrefab(var_26_0, var_26_1, arg_27_0, true)

			return
		end

		for iter_27_0, iter_27_1 in ipairs((arg_27_0:GetComponentsInChildren(typeof(Image)):ToTable())) do
			iter_27_1.raycastTarget = false
		end

		arg_27_0.transform:SetParent(self.model, false)

		self.modelComps = {}

		local var_27_0 = arg_27_0:GetComponentInChildren(typeof(Animator))

		if var_27_0 then
			self.modelComps = {
				var_27_0,
				(var_27_0:GetComponent("DftAniEvent"))
			}
		end

		arg_26_1()

		return
	end)

	return
end

function WSMapObject:UnloadSpine()
	if self.modelComps[1] and isa(self.modelComps[1], SpineAnimChar) then
		self.modelComps[1]:SetActionCallBack(nil)
		self.modelComps[1]:Dispose()
	end

	return
end

function WSMapObject:UnloadPrefab()
	if self.modelComps[2] then
		self.modelComps[2]:SetEndEvent(nil)
	end

	PoolMgr.GetInstance():ReturnPrefab(self.modelResPath, self.modelResName, self.model:GetChild(0).gameObject, true)

	return
end

function WSMapObject:NewActionTimer(arg_30_1, arg_30_2)
	self:DisposeActionTimer()

	self.modelActionTimer = Timer.New(arg_30_2, arg_30_1, 1)

	self.modelActionTimer:Start()

	return
end

function WSMapObject:DisposeActionTimer()
	if self.modelActionTimer then
		self.modelActionTimer:Stop()

		self.modelActionTimer = nil
	end

	return
end

return WSMapObject

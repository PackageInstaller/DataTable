local CommonHeadPortrait = class("CommonHeadPortrait", ReduxView)

function CommonHeadPortrait:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CommonHeadPortrait:Init()
	self.headItem = nil
	self.state = {
		isDynamicHead = false,
		isNormalFrame = true,
		isDynamicFrame = false,
		isNormalHead = true
	}
	self.pool = {
		dynamicHead = {},
		dynamicFrame = {}
	}

	self:InitUI()
	self:AddListeners()
end

function CommonHeadPortrait:InitUI()
	self:BindCfgUI()
end

function CommonHeadPortrait:AddListeners()
	self:AddBtnListener(self.clickBtn_, nil, handler(self, self.OnBtnClick))
end

function CommonHeadPortrait:OnBtnClick()
	if self.clickHandle then
		self.clickHandle(self.headItem)
	end
end

function CommonHeadPortrait:RegisteClickCallback(arg_6_1)
	self.clickHandle = arg_6_1
end

function CommonHeadPortrait:Render(arg_7_1)
	self.headItem = arg_7_1

	if arg_7_1.headId then
		if ProfileDecorateItemCfg[arg_7_1.headId].type == 1 then
			self:RenderNormalHead(arg_7_1.headId)
		elseif ProfileDecorateItemCfg[arg_7_1.headId].type == 2 then
			self:RenderDynamicHead(arg_7_1.headId)
		end
	else
		self:ChangeHeadActive(false)
	end

	if arg_7_1.frameId then
		if ProfileDecorateItemCfg[arg_7_1.frameId].type == 1 then
			self:RenderNormalFrame(arg_7_1.frameId)
		elseif ProfileDecorateItemCfg[arg_7_1.frameId].type == 2 then
			self:RenderDynamicFrame(arg_7_1.frameId)
		end
	else
		self:ChangeFrameActive(false)
	end
end

function CommonHeadPortrait:RenderHead(arg_8_1)
	if arg_8_1 then
		if ProfileDecorateItemCfg[arg_8_1] then
			if ProfileDecorateItemCfg[arg_8_1].type == 1 then
				self:RenderNormalHead(arg_8_1)
			elseif ProfileDecorateItemCfg[arg_8_1].type == 2 then
				self:RenderDynamicHead(arg_8_1)
			end
		else
			Debug.LogError("不存在的Id: " .. arg_8_1)
		end
	else
		self:ChangeHeadActive(false)
	end
end

function CommonHeadPortrait:RenderFrame(arg_9_1)
	if arg_9_1 then
		if ProfileDecorateItemCfg[arg_9_1] then
			if ProfileDecorateItemCfg[arg_9_1].type == 1 then
				self:RenderNormalFrame(arg_9_1)
			elseif ProfileDecorateItemCfg[arg_9_1].type == 2 then
				self:RenderDynamicFrame(arg_9_1)
			end
		else
			Debug.LogError("不存在的Id: " .. arg_9_1)
		end
	else
		self:ChangeFrameActive(false)
	end
end

function CommonHeadPortrait:RenderCustomSpriteHead(arg_10_1)
	self:ChangeHeadActive(true, true)

	self.headImg_.spriteSync = arg_10_1

	self.headImg_:SetNativeSize()
end

function CommonHeadPortrait:RenderCustomSpriteFrame(arg_11_1)
	self:ChangeFrameActive(true, true)

	self.frameImg_.spriteSync = arg_11_1

	self.frameImg_:SetNativeSize()
end

function CommonHeadPortrait:RenderNormalHead(arg_12_1)
	self:ChangeHeadActive(true, true)

	self.headImg_.sprite = ItemTools.getItemSprite(arg_12_1, nil, true)

	self.headImg_:SetNativeSize()
end

function CommonHeadPortrait:RenderNormalFrame(arg_13_1)
	self:ChangeFrameActive(true, true)

	self.frameImg_.spriteSync = "TextureConfig/Frame/" .. ProfileDecorateItemCfg[arg_13_1].resource

	self.frameImg_:SetNativeSize()
end

function CommonHeadPortrait:RenderDynamicHead(arg_14_1)
	self:ChangeHeadActive(true, false)

	if not isNil(self.pool.dynamicHead.obj) then
		DynamicPortraitPool.GetInstance():ReturnHead(self.pool.dynamicHead.id, self.pool.dynamicHead.obj)
	end

	self.pool.dynamicHead.obj = DynamicPortraitPool.GetInstance():GetHead(arg_14_1, self.dynamicHead_.transform)
	self.pool.dynamicHead.id = arg_14_1
end

function CommonHeadPortrait:RenderDynamicFrame(arg_15_1)
	self:ChangeFrameActive(true, false)

	if not isNil(self.pool.dynamicFrame.obj) then
		DynamicPortraitPool.GetInstance():ReturnFrame(self.pool.dynamicFrame.id, self.pool.dynamicFrame.obj)
	end

	self.pool.dynamicFrame.obj = DynamicPortraitPool.GetInstance():GetFrame(arg_15_1, self.dynamicFrame_.transform)
	self.pool.dynamicFrame.id = arg_15_1
end

function CommonHeadPortrait:ChangeHeadActive(arg_16_1, arg_16_2)
	local var_16_0 = false
	local var_16_1 = false

	if arg_16_1 then
		var_16_0 = arg_16_2 or false
		var_16_1 = not var_16_0
	end

	if var_16_0 ~= self.state.isNormalHead then
		self.state.isNormalHead = var_16_0

		self.normalHead_:SetActive(var_16_0)
	end

	if var_16_1 ~= self.state.isDynamicHead then
		self.state.isDynamicHead = var_16_1

		self.dynamicHeadRoot_:SetActive(var_16_1)

		if not var_16_1 then
			if not isNil(self.pool.dynamicHead.obj) then
				DynamicPortraitPool.GetInstance():ReturnHead(self.pool.dynamicHead.id, self.pool.dynamicHead.obj)
			end

			self.pool.dynamicHead.id = nil
			self.pool.dynamicHead.obj = nil
		end
	end
end

function CommonHeadPortrait:ChangeFrameActive(arg_17_1, arg_17_2)
	local var_17_0 = false
	local var_17_1 = false

	if arg_17_1 then
		var_17_0 = arg_17_2 or false
		var_17_1 = not var_17_0
	end

	if var_17_0 ~= self.state.isNormalFrame then
		self.state.isNormalFrame = var_17_0

		self.normalFrame_:SetActive(var_17_0)
	end

	if var_17_1 ~= self.state.isDynamicFrame then
		self.state.isDynamicFrame = var_17_1

		self.dynamicFrame_:SetActive(var_17_1)
	end
end

function CommonHeadPortrait:Dispose()
	self:RemoveAllListeners()
	CommonHeadPortrait.super.Dispose(self)

	if self.pool.dynamicHead.id then
		DynamicPortraitPool.GetInstance():ReturnHead(self.pool.dynamicHead.id, self.pool.dynamicHead.obj)

		self.pool.dynamicHead.id = nil
	end

	if self.pool.dynamicFrame.id then
		DynamicPortraitPool.GetInstance():ReturnFrame(self.pool.dynamicFrame.id, self.pool.dynamicFrame.obj)

		self.pool.dynamicFrame.id = nil
	end
end

return CommonHeadPortrait

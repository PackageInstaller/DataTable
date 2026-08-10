local var_0_0 = class("CommonHeadPortrait", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.headItem = nil
	arg_2_0.state = {
		isDynamicHead = false,
		isNormalFrame = true,
		isDynamicFrame = false,
		isNormalHead = true
	}
	arg_2_0.pool = {
		dynamicHead = {},
		dynamicFrame = {}
	}

	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.clickBtn_, nil, handler(arg_4_0, arg_4_0.OnBtnClick))
end

function var_0_0.OnBtnClick(arg_5_0)
	if arg_5_0.clickHandle then
		arg_5_0.clickHandle(arg_5_0.headItem)
	end
end

function var_0_0.RegisteClickCallback(arg_6_0, arg_6_1)
	arg_6_0.clickHandle = arg_6_1
end

function var_0_0.Render(arg_7_0, arg_7_1)
	arg_7_0.headItem = arg_7_1

	if arg_7_1.headId then
		local var_7_0 = ProfileDecorateItemCfg[arg_7_1.headId]

		if var_7_0.type == 1 then
			arg_7_0:RenderNormalHead(arg_7_1.headId)
		elseif var_7_0.type == 2 then
			arg_7_0:RenderDynamicHead(arg_7_1.headId)
		end
	else
		arg_7_0:ChangeHeadActive(false)
	end

	if arg_7_1.frameId then
		local var_7_1 = ProfileDecorateItemCfg[arg_7_1.frameId]

		if var_7_1.type == 1 then
			arg_7_0:RenderNormalFrame(arg_7_1.frameId)
		elseif var_7_1.type == 2 then
			arg_7_0:RenderDynamicFrame(arg_7_1.frameId)
		end
	else
		arg_7_0:ChangeFrameActive(false)
	end
end

function var_0_0.RenderHead(arg_8_0, arg_8_1)
	if arg_8_1 then
		local var_8_0 = ProfileDecorateItemCfg[arg_8_1]

		if var_8_0 then
			if var_8_0.type == 1 then
				arg_8_0:RenderNormalHead(arg_8_1)
			elseif var_8_0.type == 2 then
				arg_8_0:RenderDynamicHead(arg_8_1)
			end
		else
			Debug.LogError("不存在的Id: " .. arg_8_1)
		end
	else
		arg_8_0:ChangeHeadActive(false)
	end
end

function var_0_0.RenderFrame(arg_9_0, arg_9_1)
	if arg_9_1 then
		local var_9_0 = ProfileDecorateItemCfg[arg_9_1]

		if var_9_0 then
			if var_9_0.type == 1 then
				arg_9_0:RenderNormalFrame(arg_9_1)
			elseif var_9_0.type == 2 then
				arg_9_0:RenderDynamicFrame(arg_9_1)
			end
		else
			Debug.LogError("不存在的Id: " .. arg_9_1)
		end
	else
		arg_9_0:ChangeFrameActive(false)
	end
end

function var_0_0.RenderCustomSpriteHead(arg_10_0, arg_10_1)
	arg_10_0:ChangeHeadActive(true, true)

	arg_10_0.headImg_.spriteSync = arg_10_1

	arg_10_0.headImg_:SetNativeSize()
end

function var_0_0.RenderCustomSpriteFrame(arg_11_0, arg_11_1)
	arg_11_0:ChangeFrameActive(true, true)

	arg_11_0.frameImg_.spriteSync = arg_11_1

	arg_11_0.frameImg_:SetNativeSize()
end

function var_0_0.RenderNormalHead(arg_12_0, arg_12_1)
	arg_12_0:ChangeHeadActive(true, true)

	arg_12_0.headImg_.sprite = ItemTools.getItemSprite(arg_12_1, nil, true)

	arg_12_0.headImg_:SetNativeSize()
end

function var_0_0.RenderNormalFrame(arg_13_0, arg_13_1)
	arg_13_0:ChangeFrameActive(true, true)

	local var_13_0 = ProfileDecorateItemCfg[arg_13_1]

	arg_13_0.frameImg_.spriteSync = "TextureConfig/Frame/" .. var_13_0.resource

	arg_13_0.frameImg_:SetNativeSize()
end

function var_0_0.RenderDynamicHead(arg_14_0, arg_14_1)
	arg_14_0:ChangeHeadActive(true, false)

	if not isNil(arg_14_0.pool.dynamicHead.obj) then
		DynamicPortraitPool.GetInstance():ReturnHead(arg_14_0.pool.dynamicHead.id, arg_14_0.pool.dynamicHead.obj)
	end

	local var_14_0 = DynamicPortraitPool.GetInstance():GetHead(arg_14_1, arg_14_0.dynamicHead_.transform)

	arg_14_0.pool.dynamicHead.obj = var_14_0
	arg_14_0.pool.dynamicHead.id = arg_14_1
end

function var_0_0.RenderDynamicFrame(arg_15_0, arg_15_1)
	arg_15_0:ChangeFrameActive(true, false)

	if not isNil(arg_15_0.pool.dynamicFrame.obj) then
		DynamicPortraitPool.GetInstance():ReturnFrame(arg_15_0.pool.dynamicFrame.id, arg_15_0.pool.dynamicFrame.obj)
	end

	local var_15_0 = DynamicPortraitPool.GetInstance():GetFrame(arg_15_1, arg_15_0.dynamicFrame_.transform)

	arg_15_0.pool.dynamicFrame.obj = var_15_0
	arg_15_0.pool.dynamicFrame.id = arg_15_1
end

function var_0_0.ChangeHeadActive(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = false
	local var_16_1 = false

	if arg_16_1 then
		var_16_0 = arg_16_2 or false
		var_16_1 = not var_16_0
	end

	if var_16_0 ~= arg_16_0.state.isNormalHead then
		arg_16_0.state.isNormalHead = var_16_0

		arg_16_0.normalHead_:SetActive(var_16_0)
	end

	if var_16_1 ~= arg_16_0.state.isDynamicHead then
		arg_16_0.state.isDynamicHead = var_16_1

		arg_16_0.dynamicHeadRoot_:SetActive(var_16_1)

		if not var_16_1 then
			if not isNil(arg_16_0.pool.dynamicHead.obj) then
				DynamicPortraitPool.GetInstance():ReturnHead(arg_16_0.pool.dynamicHead.id, arg_16_0.pool.dynamicHead.obj)
			end

			arg_16_0.pool.dynamicHead.id = nil
			arg_16_0.pool.dynamicHead.obj = nil
		end
	end
end

function var_0_0.ChangeFrameActive(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = false
	local var_17_1 = false

	if arg_17_1 then
		var_17_0 = arg_17_2 or false
		var_17_1 = not var_17_0
	end

	if var_17_0 ~= arg_17_0.state.isNormalFrame then
		arg_17_0.state.isNormalFrame = var_17_0

		arg_17_0.normalFrame_:SetActive(var_17_0)
	end

	if var_17_1 ~= arg_17_0.state.isDynamicFrame then
		arg_17_0.state.isDynamicFrame = var_17_1

		arg_17_0.dynamicFrame_:SetActive(var_17_1)
	end
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_18_0)

	if arg_18_0.pool.dynamicHead.id then
		DynamicPortraitPool.GetInstance():ReturnHead(arg_18_0.pool.dynamicHead.id, arg_18_0.pool.dynamicHead.obj)

		arg_18_0.pool.dynamicHead.id = nil
	end

	if arg_18_0.pool.dynamicFrame.id then
		DynamicPortraitPool.GetInstance():ReturnFrame(arg_18_0.pool.dynamicFrame.id, arg_18_0.pool.dynamicFrame.obj)

		arg_18_0.pool.dynamicFrame.id = nil
	end
end

return var_0_0

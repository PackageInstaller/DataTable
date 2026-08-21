local var_0_0 = class("CaptureSectionModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.BuildContext(arg_3_0)
	arg_3_0.staticContext = {
		clickHandle = handler(arg_3_0, arg_3_0.OnSlotClick)
	}
	arg_3_0.slots = {
		{},
		{},
		{}
	}
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:BuildContext()
	arg_4_0:AddListener()
end

function var_0_0.AddListener(arg_5_0)
	return
end

function var_0_0.OnSlotClick(arg_6_0, arg_6_1)
	CaptureGameData:CancelRedPoint(arg_6_0.staticContext.gameData.sectionId, arg_6_1)
	CaptureGameTools:EnterCaptureGame(arg_6_0.staticContext.gameData.sectionId, arg_6_1, false)
end

function var_0_0.RenderView(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.gameData

	arg_7_0.staticContext.gameData = var_7_0

	local var_7_1 = var_7_0.sub_section_list

	if arg_7_0.staticContext.instTimer then
		arg_7_0:StopTimer()
	end

	for iter_7_0 = 1, 3 do
		if not isNil(arg_7_0.slots[iter_7_0].obj) then
			arg_7_0.slots[iter_7_0].obj:SetActive(false)
		end
	end

	local var_7_2 = 1

	arg_7_0.staticContext.instTimer = Timer.New(function()
		if not arg_7_0.slots[var_7_2].obj then
			local var_8_0 = Object.Instantiate(arg_7_0.slotModule_)

			var_8_0.transform.parent = arg_7_0[string.format("sectionObj%d_", var_7_2)]
			var_8_0.transform.localScale = Vector3.one
			var_8_0.transform.localPosition = Vector3.zero
			arg_7_0.slots[var_7_2].obj = var_8_0
			arg_7_0.slots[var_7_2].entity = CapturePictureSlotModule.New(var_8_0)

			arg_7_0.slots[var_7_2].entity:RegisterClickCallback(arg_7_0.staticContext.clickHandle)
		else
			arg_7_0.slots[var_7_2].obj:SetActive(true)
		end

		if var_7_1[var_7_2] then
			arg_7_0.slots[var_7_2].entity:RenderView({
				id = var_7_1[var_7_2] or 1,
				mainActivityId = var_7_0.sectionId
			})

			var_7_2 = var_7_2 + 1
		else
			arg_7_0.slots[var_7_2].obj:SetActive(true)
			arg_7_0.slots[var_7_2].entity:RenderView(nil)
		end
	end, 0.05, 3)

	arg_7_0.staticContext.instTimer:Start()
end

function var_0_0.StopTimer(arg_9_0)
	if arg_9_0.staticContext.instTimer then
		arg_9_0.staticContext.instTimer:Stop()

		arg_9_0.staticContext.instTimer = nil
	end
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:StopTimer()
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:StopTimer()

	for iter_11_0, iter_11_1 in pairs(arg_11_0.slots) do
		if iter_11_1.entity then
			iter_11_1.entity:Dispose()

			iter_11_1.entity = nil
			iter_11_1.obj = nil
		end
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0

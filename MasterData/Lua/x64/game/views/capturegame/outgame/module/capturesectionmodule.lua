local CaptureSectionModule = class("CaptureSectionModule", ReduxView)

function CaptureSectionModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CaptureSectionModule:Init()
	self:InitUI()
end

function CaptureSectionModule:BuildContext()
	self.staticContext = {
		clickHandle = handler(self, self.OnSlotClick)
	}
	self.slots = {
		{},
		{},
		{}
	}
end

function CaptureSectionModule:InitUI()
	self:BindCfgUI()
	self:BuildContext()
	self:AddListener()
end

function CaptureSectionModule:AddListener()
	return
end

function CaptureSectionModule:OnSlotClick(arg_6_1)
	CaptureGameData:CancelRedPoint(self.staticContext.gameData.sectionId, arg_6_1)
	CaptureGameTools:EnterCaptureGame(self.staticContext.gameData.sectionId, arg_6_1, false)
end

function CaptureSectionModule:RenderView(arg_7_1)
	local var_7_0 = arg_7_1.gameData

	self.staticContext.gameData = arg_7_1.gameData

	local var_7_1 = arg_7_1.gameData.sub_section_list

	if self.staticContext.instTimer then
		self:StopTimer()
	end

	for iter_7_0 = 1, 3 do
		if not isNil(self.slots[iter_7_0].obj) then
			self.slots[iter_7_0].obj:SetActive(false)
		end
	end

	local var_7_2 = 1

	self.staticContext.instTimer = Timer.New(function()
		if not self.slots[var_7_2].obj then
			local var_8_0 = Object.Instantiate(self.slotModule_)

			var_8_0.transform.parent = self[string.format("sectionObj%d_", var_7_2)]
			var_8_0.transform.localScale = Vector3.one
			var_8_0.transform.localPosition = Vector3.zero
			self.slots[var_7_2].obj = var_8_0
			self.slots[var_7_2].entity = CapturePictureSlotModule.New(var_8_0)

			self.slots[var_7_2].entity:RegisterClickCallback(self.staticContext.clickHandle)
		else
			self.slots[var_7_2].obj:SetActive(true)
		end

		if var_7_1[var_7_2] then
			local var_8_1 = {}

			var_8_1.id = var_7_1[var_7_2] or 1
			var_8_1.mainActivityId = var_7_0.sectionId

			self.slots[var_7_2].entity:RenderView(var_8_1)

			var_7_2 = var_7_2 + 1
		else
			self.slots[var_7_2].obj:SetActive(true)
			self.slots[var_7_2].entity:RenderView(nil)
		end
	end, 0.05, 3)

	self.staticContext.instTimer:Start()
end

function CaptureSectionModule:StopTimer()
	if self.staticContext.instTimer then
		self.staticContext.instTimer:Stop()

		self.staticContext.instTimer = nil
	end
end

function CaptureSectionModule:OnExit()
	self:StopTimer()
end

function CaptureSectionModule:Dispose()
	self:StopTimer()

	for iter_11_0, iter_11_1 in pairs(self.slots) do
		if iter_11_1.entity then
			iter_11_1.entity:Dispose()

			iter_11_1.entity = nil
			iter_11_1.obj = nil
		end
	end

	CaptureSectionModule.super.Dispose(self)
end

return CaptureSectionModule

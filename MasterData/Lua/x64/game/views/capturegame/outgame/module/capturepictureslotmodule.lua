local CapturePictureSlotModule = class("CapturePictureSlotModule", ReduxView)

function CapturePictureSlotModule:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CapturePictureSlotModule:Init()
	self:InitUI()
end

function CapturePictureSlotModule:BuildContext()
	self.staticContext = {}
	self.runtimeCtx = {
		id = -1
	}
end

function CapturePictureSlotModule:InitUI()
	self:BindCfgUI()
	self:BuildContext()
	self:AddListener()
end

function CapturePictureSlotModule:AddListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:OnSectionClick()
	end)
end

function CapturePictureSlotModule:OnSectionClick()
	if self.staticContext.clickCallback then
		self.staticContext.clickCallback(self.runtimeCtx.id)
	end
end

function CapturePictureSlotModule:RegisterClickCallback(arg_8_1)
	self.staticContext.clickCallback = arg_8_1
end

function CapturePictureSlotModule:RenderView(arg_9_1)
	if arg_9_1 ~= nil then
		self.runtimeCtx.id = arg_9_1.id
		self.runtimeCtx.mainActivityId = arg_9_1.mainActivityId
		self.description_.text = ActivitySwimSkinSubSectionCfg[arg_9_1.id].description

		SetActive(self.pictureImg_, (CaptureGameData:CheckSectionTaskComplete(self.runtimeCtx.mainActivityId, self.runtimeCtx.id)))
		self:UnbindRedPoint()
		self:BindRedPoint()
		self.emptyObj_:SetActive(false)
		self.contentObj_:SetActive(true)
	else
		self.runtimeCtx.id = nil
		self.runtimeCtx.mainActivityId = nil

		self:UnbindRedPoint()
		self.emptyObj_:SetActive(true)
		self.contentObj_:SetActive(false)
	end
end

function CapturePictureSlotModule:BindRedPoint()
	manager.redPoint:bindUIandKey(self.noticeContainer_.transform, table.concat({
		RedPointConst.CAPTURE_GAME_UNLOCK_STAGE,
		"_",
		0,
		[3] = self.runtimeCtx.id
	}))
end

function CapturePictureSlotModule:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.noticeContainer_.transform)
end

function CapturePictureSlotModule:Exit()
	self:UnbindRedPoint()
end

function CapturePictureSlotModule:Dispose()
	CapturePictureSlotModule.super.Dispose(self)
end

return CapturePictureSlotModule

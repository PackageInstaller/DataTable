local QWorldFunctionOpenView = class("QWorldFunctionOpenView", (import("game.views.qworld.hint.QWorldHintBaseView")))

function QWorldFunctionOpenView:UIName()
	return "Widget/System/SandPlay/SandPlay_Unlock/SandPlay_Unlock"
end

function QWorldFunctionOpenView:InitUI()
	self:AddUIListener()
end

function QWorldFunctionOpenView:AddUIListener()
	self:AddBtnListener(self.btnClose_, nil, function()
		if not self.isCanClose_ then
			return
		end

		QWorldNotifyQueue:ImmediatelyNextNotifies()
	end)
end

function QWorldFunctionOpenView:SetData(arg_5_1)
	self.functionInfo_ = arg_5_1
end

function QWorldFunctionOpenView:RefreshUI()
	self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/SandPlay/MiniIcon/" .. self.functionInfo_.icon)
	self.content_.text = self.functionInfo_.function_content
end

function QWorldFunctionOpenView:Hide()
	if self.gameObject_ then
		SetActive(self.gameObject_, false)
	end

	if self.functionInfo_ then
		manager.notify:CallUpdateFunc("CheckQWorldFunctionOpen")
		manager.notify:Invoke(QWORLD_SYSTEM_OPEN, self.functionInfo_.id)
		QWorldAction.UnlockFunction(self.functionInfo_.id)
	end

	self:OnHide()
end

function QWorldFunctionOpenView:OnShow()
	self.showTimer_ = nil
	self.showTimer_ = Timer.New(function()
		self.isCanClose_ = true
	end, 0.5, 1)

	self.showTimer_:Start()
	QWorldMgr:ActivePlayerControlWithMain(false)
end

function QWorldFunctionOpenView:OnHide()
	if self.showTimer_ then
		self.showTimer_:Stop()

		self.showTimer_ = nil
	end

	self.isCanClose_ = false

	QWorldMgr:ActivePlayerControlWithMain(true)
end

return QWorldFunctionOpenView

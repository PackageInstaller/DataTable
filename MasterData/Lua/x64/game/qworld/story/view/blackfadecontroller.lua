local QWBlackFadeController = class("QWBlackFadeController")
local var_0_1 = "QWWorld/UI/Story/StoryCross"

function QWBlackFadeController:Ctor()
	self.stroyPage = nil
	self.timer = nil
	self.curCtx = nil
	self.startTimestamp = -1
end

function QWBlackFadeController:Load()
	if not self.stroyPage then
		local var_2_0 = GameObject.Instantiate(Asset.Load(var_0_1), manager.ui.uiTips.transform)

		var_2_0.transform:SetAsLastSibling()

		local var_2_1 = {
			gameObject = var_2_0,
			transform = var_2_0.transform
		}

		var_2_1.textComp = var_2_0.transform:Find("Text").gameObject:GetComponent(typeof(Text))
		var_2_1.textEffect_ = var_2_0.transform:Find("Text").gameObject:GetComponent("UITypewriterEffect")
		var_2_1.canvasGroup = var_2_0:GetComponent(typeof(CanvasGroup))
		self.stroyPage = var_2_1
	end
end

function QWBlackFadeController:UnLoad()
	self:Reset()

	if self.stroyPage and not isNil(self.stroyPage.gameObject) then
		GameObject.Destroy(self.stroyPage.gameObject)
		Asset.Unload(var_0_1)
	end

	self.stroyPage = nil
end

function QWBlackFadeController:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function QWBlackFadeController:StartFade(arg_5_1)
	self.curCtx = arg_5_1
	self.startTimestamp = Time.time

	self:Load()
	self:StopTimer()

	self.stroyPage.textEffect_.percent = 0

	self.stroyPage.textEffect_:SetDirty()
	self.stroyPage.gameObject:SetActive(true)
	self.stroyPage.transform:SetAsLastSibling()

	self.stroyPage.canvasGroup.alpha = 0
	self.timer = FrameTimer.New(function()
		if (Time.time - self.startTimestamp) / arg_5_1.showTimer > 1 then
			self.stroyPage.canvasGroup.alpha = 1
		end

		if Time.time - self.startTimestamp >= arg_5_1.showTimer then
			self:StopTimer()

			if arg_5_1.showContent then
				if arg_5_1.centerAction then
					arg_5_1.centerAction()
				end

				manager.gc:Collect()
				Resources.UnloadUnusedAssets()
				self:ShowContent()
			elseif arg_5_1.action then
				arg_5_1.action()
			else
				self:ContinueFade()
			end
		end
	end, 1, -1)

	self.timer:Start()
end

function QWBlackFadeController:ShowContent()
	self:Load()

	self.stroyPage.textComp.text = self.curCtx.content and self.curCtx.content > 0 and GetI18NText(SandplayStoryTalkCfg[tonumber(self.curCtx.content)].dialogue_text) or ""

	self:StopTimer()

	self.startTimestamp = Time.time
	self.timer = FrameTimer.New(function()
		if (Time.time - self.startTimestamp) / (self.curCtx.contentTime / 1.5) > 1 then
			self.stroyPage.textEffect_.percent = 1
		end

		self.stroyPage.textEffect_:SetDirty()

		if Time.time - self.startTimestamp >= self.curCtx.contentTime then
			self:StopTimer()

			if self.curCtx.action then
				self.curCtx.action()
			else
				self:ContinueFade()
			end
		end
	end, 1, -1)

	self.timer:Start()
end

function QWBlackFadeController:ContinueFade()
	self:Load()

	self.stroyPage.textEffect_.percent = 0

	self.stroyPage.textEffect_:SetDirty()

	if self.curCtx then
		self:StopTimer()

		self.startTimestamp = Time.time
		self.timer = FrameTimer.New(function()
			self.stroyPage.canvasGroup.alpha = 1 - (((Time.time - self.startTimestamp) / self.curCtx.outTimer > 1 or nil) and 1)

			if Time.time - self.startTimestamp >= self.curCtx.outTimer then
				self:StopTimer()
				self:Reset()

				if self.curCtx.done then
					self.curCtx.done()
				end
			end
		end, 1, -1)

		self.timer:Start()
	end
end

function QWBlackFadeController:ForceStop()
	self:Reset()
end

function QWBlackFadeController:Reset()
	self:StopTimer()

	self.curCtx = nil
	self.startTimestamp = -1

	if self.stroyPage then
		self.stroyPage.gameObject:SetActive(false)
	end
end

function QWBlackFadeController:Dispose()
	self:UnLoad()
end

return QWBlackFadeController

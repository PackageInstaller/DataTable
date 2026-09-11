local RollTipsView = class("RollTipsView")

function RollTipsView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
end

function RollTipsView:InitUI()
	ComponentBinder.GetInstance():BindCfgUI(self, self.gameObject_)

	self.bgimage_.sprite = AssetEx.LoadSprite("TextureConfig/Common/bg_funeng_details", true)
	self.btnimage_.sprite = AssetEx.LoadSprite("TextureConfig/Common/Popup_common_b", true)
	self.iconiamge_.sprite = AssetEx.LoadSprite("TextureConfig/Common/icon_ShutDown", true)

	self:AddUIListeners()
end

function RollTipsView:Play(arg_3_1)
	self.showString_ = arg_3_1
	self.showtext_.text = GetI18NText(self.showString_)
	self.texttrans_.sizeDelta = Vector2.New(ExStringCount(self.showtext_.text) * self.showtext_.fontSize / 2, self.texttrans_.rect.height)
	self.texttrans_.localPosition = Vector3.New(0, 0, 0)

	if self.timer_ == nil then
		self.timer_ = FrameTimer.New(function()
			if LuaExchangeHelper.GetSceneIsHanding() then
				return
			elseif -self.texttrans_.localPosition.x < self.contenttrans_.rect.width + self.texttrans_.rect.width then
				self.texttrans_.localPosition = Vector3.New(self.texttrans_.localPosition.x + -100 * Time.deltaTime, 0, 0)
			else
				self:StopTimer()
				SetActive(self.gameObject_, false)
			end
		end, 1, -1)

		self.timer_:Start()
	end
end

function RollTipsView:AddUIListeners()
	self.closebtn_.onClick:AddListener(function()
		self:StopTimer()
		SetActive(self.gameObject_, false)
	end)
end

function RollTipsView:Dispose()
	AssetEx.UnloadSprite("TextureConfig/Common/bg_funeng_details", true)
	AssetEx.UnloadSprite("TextureConfig/Common/Popup_common_b", true)
	AssetEx.UnloadSprite("TextureConfig/Common/icon_ShutDown", true)
	self:StopTimer()
end

function RollTipsView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return RollTipsView

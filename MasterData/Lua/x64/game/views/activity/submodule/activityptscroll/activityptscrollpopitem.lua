local ActivityPtScrollPopItem = class("ActivityPtScrollPopItem", ReduxView)

function ActivityPtScrollPopItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityPtScrollPopItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityPtScrollPopItem:InitUI()
	self:BindCfgUI()
end

function ActivityPtScrollPopItem:AddUIListeners()
	return
end

function ActivityPtScrollPopItem:OnEnter()
	return
end

function ActivityPtScrollPopItem:RefreshData(arg_6_1, arg_6_2, arg_6_3)
	self.data_ = arg_6_1
	self.handler_ = arg_6_2
	self.viewHeight_ = arg_6_3
	self.height_ = self.transform_.rect.height
	self.centerY_ = centerY

	self:RefreshUI()
	self:RefreshScroll()
end

function ActivityPtScrollPopItem:RefreshUI()
	if self.data_.useless then
		self.title_.text = ActivityPtRouletteTipsCfg[self.data_.affix].name
		self.desc_.text = ActivityPtRouletteTipsCfg[self.data_.affix].desc
		self.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.AffixIcon.path .. ActivityPtRouletteTipsCfg[self.data_.affix].icon)
	else
		self.title_.text = getAffixName({
			self.data_.affix
		})
		self.desc_.text = getAffixDesc({
			self.data_.affix,
			self.data_.level
		})
		self.icon_.sprite = getAffixSprite({
			self.data_.affix
		})
	end

	self.icon_:SetNativeSize()
end

function ActivityPtScrollPopItem:RefreshScroll()
	self:StopTimer()
	self:RefreshSelf()

	self.timer_ = FrameTimer.New(function()
		self:RefreshSelf()
	end, 1, -1)

	self.timer_:Start()
end

function ActivityPtScrollPopItem:RefreshSelf()
	local var_10_0 = (self.viewHeight_ - math.abs(self.handler_.localPosition.y + self.transform_.localPosition.y - 0.5 * self.height_)) / self.viewHeight_

	self.content_.localScale = Vector3(var_10_0, var_10_0, var_10_0)
	self.canvas_.alpha = var_10_0
end

function ActivityPtScrollPopItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityPtScrollPopItem:OnExit()
	self:StopTimer()
end

function ActivityPtScrollPopItem:Dispose()
	self:RemoveAllListeners()
	self:StopTimer()
	self.super.Dispose(self)
end

return ActivityPtScrollPopItem

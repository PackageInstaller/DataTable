local AchievementTipsMgr = class("AchievementTipsMgr")

function AchievementTipsMgr:Ctor()
	self:InitData()
end

function AchievementTipsMgr:InitData()
	self.achievementList_ = {}
	self.fliterTypeList_ = {}
	self.fliterList_ = {}
	self.canShow_ = true
end

function AchievementTipsMgr:FliteAchievementType(arg_3_1)
	self.fliterTypeList_ = arg_3_1

	if #arg_3_1 <= 0 then
		table.insertto(self.achievementList_, self.fliterList_)

		self.fliterList_ = {}
	end

	self:SetShowFlag(true)
end

function AchievementTipsMgr:AddAchievementID(arg_4_1)
	if #self.fliterTypeList_ > 0 and not table.keyof(self.fliterTypeList_, AchievementCfg[arg_4_1].type_id) then
		table.insert(self.fliterList_, arg_4_1)
	else
		table.insert(self.achievementList_, arg_4_1)
	end

	self:ShowAchievementTips()
end

function AchievementTipsMgr:SetShowFlag(arg_5_1)
	self.canShow_ = arg_5_1

	if arg_5_1 and self.timer_ == nil then
		self:ShowAchievementTips()
	end
end

function AchievementTipsMgr:ShowAchievementTips()
	if self.timer_ then
		return
	end

	if #self.achievementList_ > 0 then
		if self.canShow_ == false then
			return
		end

		self.isRuning_ = true

		if self.gameObject_ == nil then
			self:InitUI()
		end

		self.textName_.text = AchievementCfg[self.achievementList_[1]].name

		self.typeController_:SetSelectedState(AchievementCfg[self.achievementList_[1]].type_id)
		SetActive(self.gameObject_, true)
		table.remove(self.achievementList_, 1)

		self.timer_ = Timer.New(function()
			SetActive(self.gameObject_, false)

			self.timer_ = nil

			self:ShowAchievementTips()
		end, 2, 1)

		self.timer_:Start()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.rectItem_)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.textRect_)
	end
end

function AchievementTipsMgr:InitUI()
	self.gameObject_ = GameObject.Instantiate(Asset.Load("Widget/Common/Pop/AchievementTipsUI"), GameObject.Find("UICamera_DontDestroy/Canvas/UIMessage").transform)
	self.transform_ = self.gameObject_.transform

	ComponentBinder.GetInstance():BindCfgUI(self, self.gameObject_)

	self.typeController_ = self.controllerEx_:GetController("icon")
end

function AchievementTipsMgr:Hide(arg_9_1)
	if self.gameObject_ == nil then
		return
	end

	SetActive(self.goPanel_, not arg_9_1)
end

function AchievementTipsMgr:Dispose()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self.transform_ = nil

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
end

return AchievementTipsMgr

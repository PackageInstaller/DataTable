local HeroArchiveStoryItem = class("HeroArchiveStoryItem", ReduxView)

local function var_0_1(arg_1_0)
	return (math.ceil(arg_1_0 / math.round(HeroConst.HERO_LOVE_LV_MAX / 5)))
end

function HeroArchiveStoryItem:OnCtor(arg_2_1)
	self.gameObject_ = arg_2_1
	self.transform_ = arg_2_1.transform

	self:Init()
end

function HeroArchiveStoryItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroArchiveStoryItem:InitUI()
	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.gameObject_.transform, "conName")
	self.colorController_ = ControllerUtil.GetController(self.gameObject_.transform, "colorChange")
end

function HeroArchiveStoryItem:RefreshLoveCircle(arg_5_1)
	arg_5_1 = arg_5_1 or ArchiveData:GetArchive(self.archiveID_).lv

	self.colorController_:SetSelectedIndex(var_0_1(arg_5_1) - 1)

	self.lovelevelText_.text = arg_5_1
end

function HeroArchiveStoryItem:RefreshUI(arg_6_1, arg_6_2)
	self.archiveID_ = arg_6_2
	self.ID_ = arg_6_1
	self.storyLinId_ = HeroRecordCfg[arg_6_2].plot_id[arg_6_1]

	local var_6_1, var_6_2, var_6_3 = IsConditionAchieved(GameSetting.hero_plot_unlock_condition.value[arg_6_1], {
		heroId = self.archiveID_
	})

	self:RefreshLoveCircle(ConditionCfg[GameSetting.hero_plot_unlock_condition.value[arg_6_1]].params[1])

	if var_6_1 then
		self.controller_:SetSelectedState("unLock")
	else
		self.controller_:SetSelectedState("lock")
	end

	self.titleText_.text = GetI18NText(HeroRecordCfg[arg_6_2].plot_title[arg_6_1])

	manager.redPoint:SetRedPointIndependent(self.playbtnBtn_.transform, not ArchiveData:IsStoryRead(self.archiveID_, self.storyLinId_) and var_6_1)
end

function HeroArchiveStoryItem:AddUIListener()
	self:AddBtnListener(self.playbtnBtn_, nil, function()
		manager.redPoint:SetRedPointIndependent(self.playbtnBtn_.transform, false)
		manager.story:StartStoryById(self.storyLinId_, function(arg_9_0)
			HeroAction.ReadStory(self.archiveID_, self.storyLinId_)
		end)
	end)
end

function HeroArchiveStoryItem:Dispose()
	HeroArchiveStoryItem.super.Dispose(self)
end

return HeroArchiveStoryItem

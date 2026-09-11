local VolumeMusicRewardItem = class("VolumeMusicRewardItem", ReduxView)

function VolumeMusicRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function VolumeMusicRewardItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function VolumeMusicRewardItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")
	self.list_ = LuaList.New(handler(self, self.IndexItem), self.m_list, CommonItemView)
end

function VolumeMusicRewardItem:AddUIListener()
	self:AddBtnListener(self.m_rewardBtn, nil, function()
		MusicAction.QueryReward({
			self.id
		})
	end)
end

function VolumeMusicRewardItem:SetData(arg_6_1)
	self.id = arg_6_1
	self.items = ActivityMusicCfg[arg_6_1].reward

	self.list_:StartScroll(#self.items)

	self.m_des.text = GetI18NText(self:GeDes(arg_6_1))

	self.stateController_:SetSelectedIndex((MusicData:GetRewardState(arg_6_1)))
end

function VolumeMusicRewardItem:GeDes(arg_7_1)
	local var_7_1 = MusicData:GetTargetAccuracyDes(ActivityMusicCfg[arg_7_1].target)

	return GetTips("ACTIVITY_MUSIC_2_10_TASK")
end

function VolumeMusicRewardItem:IndexItem(arg_8_1, arg_8_2)
	local var_8_0 = clone(ItemTemplateData)

	var_8_0.id = self.items[arg_8_1][1]
	var_8_0.number = self.items[arg_8_1][2]

	function var_8_0:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end

	arg_8_2:SetData(var_8_0)
end

function VolumeMusicRewardItem:Dispose()
	self.list_:Dispose()
	VolumeMusicRewardItem.super.Dispose(self)
end

return VolumeMusicRewardItem

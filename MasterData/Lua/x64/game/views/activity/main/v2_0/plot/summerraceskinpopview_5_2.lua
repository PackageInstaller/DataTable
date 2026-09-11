local SummerRaceSkinPopView_5_2 = class("SummerRaceSkinPopView_5_2", ReduxView)

function SummerRaceSkinPopView_5_2:UIName()
	return "Widget/Version/V5_2_SummerRace/V5_2_SummerRace_SkinDLC/V5_2_SummerRace_SkinDLCPopUI"
end

function SummerRaceSkinPopView_5_2:UIParent()
	return manager.ui.uiPop.transform
end

function SummerRaceSkinPopView_5_2:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SummerRaceSkinPopView_5_2:InitUI()
	self:BindCfgUI()

	local var_4_0 = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_NYA_SUMMER_RACE_SKIN_DLC] or {}

	self.taskItemList_ = {}

	for iter_4_0 = 1, 2 do
		if var_4_0[iter_4_0] then
			table.insert(self.taskItemList_, (SummerPopSkinPopTaskItem.New(self["item" .. iter_4_0 .. "_"], var_4_0[iter_4_0])))
		end
	end
end

function SummerRaceSkinPopView_5_2:AddUIListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function SummerRaceSkinPopView_5_2:OnEnter()
	self:RefreshUI()
end

function SummerRaceSkinPopView_5_2:RefreshUI()
	self.descText_.text = string.format(GetTips("CHAPTER_REMAKE_SKIN_POP_DESC"))
	self.heroImage_.sprite = pureGetSpriteWithoutAtlas(GameSetting.chapter_remake_skin_dlc_hero_image.value[1])

	for iter_8_0 = 1, #self.taskItemList_ do
		self.taskItemList_[iter_8_0]:RefreshUI()
	end
end

function SummerRaceSkinPopView_5_2:Dispose()
	if self.taskItemList_ then
		for iter_9_0 = 1, #self.taskItemList_ do
			self.taskItemList_[iter_9_0]:Dispose()
		end
	end

	SummerRaceSkinPopView_5_2.super.Dispose(self)
end

function SummerRaceSkinPopView_5_2:OnDispose()
	SummerRaceSkinPopView_5_2.super.OnDispose(self)
end

function SummerRaceSkinPopView_5_2:OnExit()
	SummerRaceSkinPopView_5_2.super.OnExit(self)
end

return SummerRaceSkinPopView_5_2

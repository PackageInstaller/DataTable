local SummerPubSkinPopView = class("SummerPubSkinPopView", ReduxView)

function SummerPubSkinPopView:UIName()
	return "Widget/Version/V4_3_SummerPub/V4_3_SummerPub_SkinDLCPopUI"
end

function SummerPubSkinPopView:UIParent()
	return manager.ui.uiPop.transform
end

function SummerPubSkinPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SummerPubSkinPopView:InitUI()
	self:BindCfgUI()

	local var_4_0 = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_NYA_SUMMER_PUB_SKIN_DLC] or {}

	self.taskItemList_ = {}

	for iter_4_0 = 1, 2 do
		if var_4_0[iter_4_0] then
			table.insert(self.taskItemList_, (SummerPopSkinPopTaskItem.New(self["item" .. iter_4_0 .. "_"], var_4_0[iter_4_0])))
		end
	end
end

function SummerPubSkinPopView:AddUIListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function SummerPubSkinPopView:OnEnter()
	self:RefreshUI()
end

function SummerPubSkinPopView:RefreshUI()
	self.descText_.text = string.format(GetTips("SUMMER_PUB_SKIN_POP_DESC"))
	self.heroImage_.sprite = pureGetSpriteWithoutAtlas(GameSetting.summer_pub_skin_dlc_hero_image.value[1])

	for iter_8_0 = 1, #self.taskItemList_ do
		self.taskItemList_[iter_8_0]:RefreshUI()
	end
end

function SummerPubSkinPopView:Dispose()
	if self.taskItemList_ then
		for iter_9_0 = 1, #self.taskItemList_ do
			self.taskItemList_[iter_9_0]:Dispose()
		end
	end

	SummerPubSkinPopView.super.Dispose(self)
end

function SummerPubSkinPopView:OnDispose()
	SummerPubSkinPopView.super.OnDispose(self)
end

function SummerPubSkinPopView:OnExit()
	SummerPubSkinPopView.super.OnExit(self)
end

return SummerPubSkinPopView

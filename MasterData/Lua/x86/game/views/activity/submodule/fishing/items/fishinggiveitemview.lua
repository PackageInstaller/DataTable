local FishingGiveItemView = class("FishingGiveItemView", ReduxView)

function FishingGiveItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function FishingGiveItemView:Init()
	self:InitUI()
	self:AddUIListener()
	self:AddEventListeners()
end

function FishingGiveItemView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.fishListGo_, FishIcon)
end

function FishingGiveItemView:indexItem(arg_4_1, arg_4_2)
	arg_4_2:SetId(self.data_.fishList[arg_4_1], 1)
end

function FishingGiveItemView:AddUIListener()
	self:AddBtnListener(self.giveBtn_, nil, function()
		if FishingData:IsFriendGiveMax(self.friendInfo_.user_id) then
			ShowTips("DAILY_GIVE_RARE_FISH_LIMIT_TIP")

			return
		end

		JumpTools.OpenPageByJump("fishingGivePop", {
			data = self.data_
		})
	end)
end

function FishingGiveItemView:AddEventListeners()
	return
end

function FishingGiveItemView:OnTop()
	self:UpdateBar()
end

function FishingGiveItemView:UpdateBar()
	return
end

function FishingGiveItemView:SetData(arg_10_1, arg_10_2)
	self.data_ = arg_10_1
	self.friendInfo_ = arg_10_2

	self:UpdateView()
end

function FishingGiveItemView:UpdateView()
	self.playerNameLabel_.text = GetI18NText(self.friendInfo_.nick)
	self.playerHeadIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. self.friendInfo_.icon)

	self.uiList_:StartScroll(#self.data_.fishList)

	if FishingData:IsFriendGiveMax(self.data_.friendId) then
		self.statusController_:SetSelectedState("full")
	else
		self.statusController_:SetSelectedState("normal")
	end
end

function FishingGiveItemView:OnEnter()
	return
end

function FishingGiveItemView:OnExit()
	return
end

function FishingGiveItemView:OnMainHomeViewTop()
	return
end

function FishingGiveItemView:Dispose()
	self:RemoveAllEventListener()

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	FishingGiveItemView.super.Dispose(self)
end

return FishingGiveItemView

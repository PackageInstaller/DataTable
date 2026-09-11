local MardukSpecialRankItemView = class("MardukSpecialRankItemView", ReduxView)

function MardukSpecialRankItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function MardukSpecialRankItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MardukSpecialRankItemView:InitUI()
	self:BindCfgUI()

	self.heroCountController_ = ControllerUtil.GetController(self.gameObject_.transform, "heroCount")
	self.rankController_ = ControllerUtil.GetController(self.gameObject_.transform, "rank")
end

function MardukSpecialRankItemView:AddUIListener()
	return
end

function MardukSpecialRankItemView:AddEventListeners()
	return
end

function MardukSpecialRankItemView:SetData(arg_6_1, arg_6_2)
	self.index_ = arg_6_1
	self.data_ = arg_6_2

	self:UpdateView()
end

function MardukSpecialRankItemView:UpdateView()
	self.icon_.sprite = ItemTools.getItemSprite(self.data_.portrait)
	self.frame_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. self.data_.frame)
	self.name_.text = GetI18NText(self.data_.nick)
	self.score_.text = self.data_.score
	self.rank_.text = self.data_.rank

	if self.data_.rank <= 3 then
		self.rankController_:SetSelectedState(tostring(self.data_.rank))
	else
		self.rankController_:SetSelectedState("0")
	end

	local var_7_0 = self.data_:GetSingleSelectHeroList()

	self.heroCountController_:SetSelectedState(tostring(#var_7_0))

	for iter_7_0 = 1, 3 do
		if var_7_0[iter_7_0] then
			self["m_heroIcon_" .. iter_7_0].sprite = ItemTools.getItemSprite((var_7_0[iter_7_0].skin_id == 0 or nil) and var_7_0[iter_7_0].hero_id)
		end
	end
end

function MardukSpecialRankItemView:OnEnter()
	self:AddEventListeners()
end

function MardukSpecialRankItemView:OnExit()
	self:RemoveAllEventListener()
end

function MardukSpecialRankItemView:OnMainHomeViewTop()
	return
end

function MardukSpecialRankItemView:Dispose()
	self.data_ = nil

	MardukSpecialRankItemView.super.Dispose(self)
end

return MardukSpecialRankItemView

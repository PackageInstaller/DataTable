local SectionBaseItem = class("SectionBaseItem", ReduxView)

function SectionBaseItem:OnCtor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.transform_.name = arg_1_3
	self.stageID_ = arg_1_3
	self.chapterID_ = arg_1_4

	self:Init()
end

function SectionBaseItem:InitUI()
	self:BindCfgUI()
	SetActive(self.gameObject_, true)

	self.selectController_ = self.controllerEx_:GetController("select")
	self.isBossController_ = self.controllerEx_:GetController("isBoss")
	self.showStarController_ = self.controllerEx_:GetController("showStar")
	self.threeStarBarList_ = {}

	for iter_2_0 = 1, 3 do
		self.threeStarBarList_[iter_2_0] = SectionThreeStarBar.New(self[string.format("starGo%s_", iter_2_0)])
	end
end

function SectionBaseItem:AddListeners()
	self:AddBtnListener(self.itemBtn_, nil, function()
		self:OnClick()
	end)
end

function SectionBaseItem:Init()
	self:InitUI()
	self:AddListeners()
	self:RefreshData()
	self:RefreshUI()
	self:InitCustom()
end

function SectionBaseItem:Dispose()
	for iter_6_0, iter_6_1 in ipairs(self.threeStarBarList_) do
		iter_6_1:Dispose()
	end

	self.threeStarBarList_ = nil

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
	self.isShow_ = nil

	SectionBaseItem.super.Dispose(self)
end

function SectionBaseItem:OnClick()
	return
end

function SectionBaseItem:ShowRedPoint()
	SetActive(self.noticeContainer_.gameObject, false)
end

function SectionBaseItem:RefreshUI()
	local var_9_0 = self:GetPosition()

	self.transform_.localPosition = Vector3(var_9_0[1], var_9_0[2], 0)

	self:RefreshText()
	self:RefreshStar()

	if self:GetTag() == BattleConst.BATTLE_TAG.BOSS then
		self.isBossController_:SetSelectedState("true")
	else
		self.isBossController_:SetSelectedState("false")
	end

	SetActive(self.gameObject_, not self.isLock_)
	self:ShowRedPoint()
end

function SectionBaseItem:GetTag()
	return BattleConst.BATTLE_TAG.DEFAULT
end

function SectionBaseItem:GetPosition()
	return {
		0,
		0
	}
end

function SectionBaseItem:InitCustom()
	return
end

function SectionBaseItem:RefreshStar()
	return
end

function SectionBaseItem:RefreshText()
	self.text_.text = ""
end

function SectionBaseItem:GetLocalPosition()
	return self.transform_.localPosition
end

function SectionBaseItem:SelectorItem(arg_16_1)
	if self.stageID_ == arg_16_1 and self:IsOpenSectionInfo() then
		self.selectController_:SetSelectedState("true")
	else
		self.selectController_:SetSelectedState("false")
	end
end

function SectionBaseItem:SetData(arg_17_1, arg_17_2)
	self.chapterID_ = arg_17_1
	self.stageID_ = arg_17_2

	self:RefreshData()
	self:RefreshUI()
end

function SectionBaseItem:Show(arg_18_1)
	SetActive(self.gameObject_, arg_18_1)
end

return SectionBaseItem

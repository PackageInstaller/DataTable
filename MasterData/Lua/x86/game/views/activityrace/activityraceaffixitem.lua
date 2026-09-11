local ActivityRaceAffixItem = class("ActivityRaceAffixItem", ReduxView)

function ActivityRaceAffixItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	SetActive(self.gameObject_, true)
	self:Init()
end

function ActivityRaceAffixItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.levelController_ = ControllerUtil.GetController(self.transform_, "level")
	self.unlockController_ = ControllerUtil.GetController(self.transform_, "unlock")
end

function ActivityRaceAffixItem:InitUI()
	self:BindCfgUI()
end

function ActivityRaceAffixItem:AddUIListener()
	if self.btn_ then
		self:AddBtnListener(self.btn_, nil, function()
			if self.selectCallBack_ then
				self.selectCallBack_(self.index_, self.affixID_, self.affixLv_)
			end
		end)
	end
end

function ActivityRaceAffixItem:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self.index_ = arg_6_1
	self.affixID_ = arg_6_2
	self.affixLv_ = arg_6_3
	self.unlock_ = arg_6_4

	self:RefreshUI()
end

function ActivityRaceAffixItem:RefreshUI()
	self:RefreshAffixImage()

	if self.affixLv_ ~= nil then
		self.levelController_:SetSelectedState(self.affixLv_)
	else
		self.levelController_:SetSelectedState(0)
	end

	self.unlockController_:SetSelectedState(tostring(self.unlock_))
end

function ActivityRaceAffixItem:RefreshAffixImage()
	if self.affixID_ then
		if PublicBuffCfg[AffixTypeCfg[self.affixID_].affix_buff_id].icon == "" then
			-- block empty
		end

		self.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.AffixIcon.path .. PublicBuffCfg[AffixTypeCfg[self.affixID_].affix_buff_id].icon)
		self.name_.text = GetI18NText(AffixTypeCfg[self.affixID_].name)
	end
end

function ActivityRaceAffixItem:RegistSelectCallBack(arg_9_1)
	self.selectCallBack_ = arg_9_1
end

function ActivityRaceAffixItem:Dispose()
	self.selectCallBack_ = nil

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil

	ActivityRaceAffixItem.super.Dispose(self)
end

function ActivityRaceAffixItem:SetActive(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)
end

return ActivityRaceAffixItem

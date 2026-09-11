local PlayerDisplayHeroItem = class("PlayerDisplayHeroItem", ReduxView)

function PlayerDisplayHeroItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index_ = arg_1_2

	self:InitUI()
	self:AddUIListener()
end

function PlayerDisplayHeroItem:InitUI()
	self:BindCfgUI()

	self.lockedController_ = ControllerUtil.GetController(self.transform_, "locked")
	self.campController_ = ControllerUtil.GetController(self.transform_, "camp")
	self.gradeController_ = ControllerUtil.GetController(self.transform_, "grade")
	self.sizeController_ = ControllerUtil.GetController(self.transform_, "size")
	self.selectedController_ = ControllerUtil.GetController(self.transform_, "selected")
	self.hpController_ = ControllerUtil.GetController(self.transform_, "hp")
end

function PlayerDisplayHeroItem:AddUIListener()
	self:AddBtnListener(self.selfBtn_, nil, function()
		ForeignInfoAction:TryToCheckForeignHeroInfo(self.userID_, self.data_.hero_id, 1, function()
			JumpTools.OpenPageByJump("/newHero", {
				isEnter = true,
				isForeign = true,
				notShowBar = true,
				hid = self.data_.hero_id
			}, ViewConst.SYSTEM_ID.PLAYER_INFO)
		end)
	end)
end

function PlayerDisplayHeroItem:OnEnter()
	return
end

function PlayerDisplayHeroItem:SetHeroData(arg_7_1, arg_7_2)
	self.userID_ = arg_7_1
	self.data_ = arg_7_2

	self:UpdataView()
end

function PlayerDisplayHeroItem:UpdataView()
	self.headIcon_.sprite = getSpriteViaConfig("HeroLittleIcon", (self.data_.using_skin == 0 or nil) and (self.data_.hero_id or self.data_.using_skin))

	self.headIcon_:SetNativeSize()
	self.campController_:SetSelectedState(HeroCfg[self.data_.hero_id].race)
	self.gradeController_:SetSelectedState((HeroStarCfg[self.data_.star] ~= nil or nil) and (HeroStarCfg[self.data_.star].star or 1))
	self.lockedController_:SetSelectedState("false")
	self.sizeController_:SetSelectedState("short")
	self.selectedController_:SetSelectedState("false")
end

function PlayerDisplayHeroItem:OnExit()
	return
end

function PlayerDisplayHeroItem:Dispose()
	PlayerDisplayHeroItem.super.Dispose(self)
end

return PlayerDisplayHeroItem

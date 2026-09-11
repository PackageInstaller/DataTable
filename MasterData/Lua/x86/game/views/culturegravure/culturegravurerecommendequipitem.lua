local CultureGravureRecommendEquipItem = class("CultureGravureRecommendEquipItem", ReduxView)

function CultureGravureRecommendEquipItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CultureGravureRecommendEquipItem:Init()
	self:InitUI()
	self:AddListeners()
end

function CultureGravureRecommendEquipItem:InitUI()
	self:BindCfgUI()

	self.positionController_ = ControllerUtil.GetController(self.gameObject_.transform, "position")
	self.starController_ = ControllerUtil.GetController(self.gameObject_.transform, "star")
	self.btnController_ = ControllerUtil.GetController(self.gameObject_.transform, "state")
end

function CultureGravureRecommendEquipItem:AddListeners()
	self:AddBtnListener(self.btnEquip_, nil, function()
		JumpTools.OpenPageByJump("cultureGravureEquipPopView", {
			heroId = self.heroID_,
			recommendIdList = {
				[self.index_] = self.id_
			},
			stateList = {
				[self.index_] = self.state_
			},
			index = self.index_
		})
	end)
	self:AddBtnListener(self.btnGet_, nil, function()
		ShowPopItemSource(self.id_)
	end)
	self:AddBtnListener(self.btnShow_, nil, function()
		ShowPopItem(POP_OPERATE_ITEM, {
			self.id_
		})
	end)
end

function CultureGravureRecommendEquipItem:SetData(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self.index_ = arg_8_1
	self.id_ = arg_8_2
	self.heroID_ = arg_8_3
	self.state_ = arg_8_4
	self.cfg_ = EquipCfg[arg_8_2]

	self:RefreshUI()
end

function CultureGravureRecommendEquipItem:RefreshUI()
	self.icon_.spriteAsync = SpritePathCfg.EquipIcon_s.path .. ItemCfg[self.id_].icon

	self.positionController_:SetSelectedState(self.cfg_.pos)
	self.starController_:SetSelectedState(self.cfg_.starlevel)
	self.btnController_:SetSelectedState(self.state_)
end

function CultureGravureRecommendEquipItem:Dispose()
	CultureGravureRecommendEquipItem.super.Dispose(self)
end

return CultureGravureRecommendEquipItem

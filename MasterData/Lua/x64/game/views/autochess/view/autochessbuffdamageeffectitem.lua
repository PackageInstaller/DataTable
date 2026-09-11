local AutoChessHeroUpgradePopItem = class("AutoChessHeroUpgradePopItem", ReduxView)

function AutoChessHeroUpgradePopItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function AutoChessHeroUpgradePopItem:Init()
	self:BindCfgUI()

	self.motionCom_ = self.gameObject_:GetComponent("UIParabolaMotion")
	self.dirController_ = self.controllerEx_:GetController("dir")
	self.isFree = true
end

function AutoChessHeroUpgradePopItem:SetActive(arg_3_1)
	SetActive(self.gameObject_, arg_3_1)
end

function AutoChessHeroUpgradePopItem:SetDir(arg_4_1)
	self.dirController_:SetSelectedState(arg_4_1 and "left" or "right")
end

function AutoChessHeroUpgradePopItem:SetIsFree(arg_5_1)
	self.isFree = arg_5_1

	self:SetActive(not arg_5_1)

	if arg_5_1 then
		LuaForUtil.SetTrailRendererClear(self.leftTrail_)
		LuaForUtil.SetTrailRendererClear(self.rightTrail_)
	end
end

function AutoChessHeroUpgradePopItem:GetIsFree()
	return self.isFree
end

return AutoChessHeroUpgradePopItem

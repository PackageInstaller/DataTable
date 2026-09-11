local OsirisPlayGameChallegeStageItem = class("OsirisPlayGameChallegeStageItem", ReduxView)

function OsirisPlayGameChallegeStageItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.index = arg_1_2

	self:Init()
end

function OsirisPlayGameChallegeStageItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function OsirisPlayGameChallegeStageItem:InitUI()
	self:BindCfgUI()

	self.stateCon_ = self.transform_:GetComponent("ControllerExCollection"):GetController("state")
end

function OsirisPlayGameChallegeStageItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.receiveFunc_ then
			self.receiveFunc_(self.index)
		end
	end)
end

function OsirisPlayGameChallegeStageItem:RefreshView(arg_6_1)
	self.titleText_.text = GetI18NText(ActivityGeneralityStageCfg[arg_6_1].name)
	self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureBg/Activity_Osiris/" .. ActivityGeneralityStageCfg[arg_6_1].generality)
	self.scoreText_.text = 0

	if ActivityGeneralityStageCfg[arg_6_1].rank_activity and ActivityGeneralityStageCfg[arg_6_1].rank_activity > 0 then
		local var_6_0 = OsirisPlayGameData:GetStageInfoById(ActivityGeneralityStageCfg[arg_6_1].stage_id)

		if var_6_0.point then
			self.scoreText_.text = var_6_0.point or 0
		end
	end
end

function OsirisPlayGameChallegeStageItem:RefreshState(arg_7_1)
	self.stateCon_:SetSelectedIndex(arg_7_1)
end

function OsirisPlayGameChallegeStageItem:RegisterClickFunc(arg_8_1)
	self.receiveFunc_ = arg_8_1
end

function OsirisPlayGameChallegeStageItem:OnExit()
	return
end

function OsirisPlayGameChallegeStageItem:Dispose()
	self:RemoveAllListeners()
	OsirisPlayGameChallegeStageItem.super.Dispose(self)
end

return OsirisPlayGameChallegeStageItem

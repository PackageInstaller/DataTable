local DanceDIYSceneItem = class("DanceDIYSceneItem", ReduxView)

function DanceDIYSceneItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function DanceDIYSceneItem:InitUI()
	self:BindCfgUI()

	self.selectController = self.controllers_:GetController("select")

	self:AddUIListener()
end

function DanceDIYSceneItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		self:OnClick()
	end)
end

function DanceDIYSceneItem:SetOnClick(arg_5_1)
	self.onClick = arg_5_1
end

function DanceDIYSceneItem:SetData(arg_6_1)
	self.scene = arg_6_1

	self:Refresh()
end

function DanceDIYSceneItem:SetSelected(arg_7_1)
	self.selectController:SetSelectedState(arg_7_1 and "true" or "false")
end

function DanceDIYSceneItem:Refresh()
	self.icon_.sprite = getSpriteViaConfig("IdolStageIcon", IdolStageSceneCfg[self.scene].stage_picture)
end

function DanceDIYSceneItem:OnClick()
	if self.onClick then
		self.onClick(self.scene)
	end
end

return DanceDIYSceneItem

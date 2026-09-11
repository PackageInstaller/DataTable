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
	self:AddBtnListener(self.itemBtn_, nil, function()
		self:OnClick()
	end)
end

function DanceDIYSceneItem:SetOnClick(arg_5_1)
	self.onClick = arg_5_1
end

function DanceDIYSceneItem:SetOnSelect(arg_6_1)
	self.onSelect = arg_6_1
end

function DanceDIYSceneItem:SetData(arg_7_1)
	self.music = arg_7_1

	self:Refresh()
end

function DanceDIYSceneItem:SetSelected(arg_8_1)
	self.selectController:SetSelectedState(arg_8_1 and "true" or "false")
end

function DanceDIYSceneItem:Refresh()
	self.name_.text = IdolStageMusicCfg[self.music].music_name
	self.duration_.text = manager.time:DescCdTime2(IdolTraineeTools.GetMusicDuration(self.music))
end

function DanceDIYSceneItem:OnClick()
	if self.onClick then
		self.onClick(self.music)
	end
end

function DanceDIYSceneItem:OnSelect()
	if self.onSelect then
		self.onSelect(self.music)
	end
end

return DanceDIYSceneItem

local DormPrivateOccupySuccessView = class("DormPrivateOccupySuccessView", ReduxView)

function DormPrivateOccupySuccessView:UIName()
	return "Widget/BackHouseUI/Dorm/DormUnlockTips"
end

function DormPrivateOccupySuccessView:UIParent()
	return manager.ui.uiPop.transform
end

function DormPrivateOccupySuccessView:OnCtor()
	return
end

function DormPrivateOccupySuccessView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormPrivateOccupySuccessView:InitUI()
	self:BindCfgUI()
end

function DormPrivateOccupySuccessView:OnEnter()
	self.archiveID = self.params_.archiveID

	local var_6_0 = DormData:GetHeroInfo(self.archiveID):GetHeroId()

	if var_6_0 then
		self.iconImg_.sprite = DormHeroTools.GetBackHomeHeadSprite(var_6_0)
	end

	if self.archiveID and HeroRecordCfg[self.archiveID] then
		local var_6_1 = GetI18NText(HeroRecordCfg[self.archiveID].name)

		if var_6_1 then
			self.nameTex_.text = string.format(GetTips("DORM_HERO_ROOM_NAME"), var_6_1)
		end
	else
		Debug.LogError("名字不存在")
	end
end

function DormPrivateOccupySuccessView:OnExit()
	return
end

function DormPrivateOccupySuccessView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	end)
end

function DormPrivateOccupySuccessView:Dispose()
	DormPrivateOccupySuccessView.super.Dispose(self)
end

return DormPrivateOccupySuccessView

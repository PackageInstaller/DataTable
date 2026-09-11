local DormRoomUnLockItem = class("DormRoomUnLockItem", ReduxView)

function DormRoomUnLockItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function DormRoomUnLockItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormRoomUnLockItem:InitUI()
	self:BindCfgUI()
end

function DormRoomUnLockItem:AddUIListener()
	self:AddBtnListener(self.unLockBtn_, nil, function()
		if self.unLockFunc then
			self.unLockFunc(self.archiveID)
		end
	end)
end

function DormRoomUnLockItem:RefreshUI(arg_6_1)
	self.archiveID = arg_6_1
	self.archiveName.text = string.format(GetTips("DORM_HERO_ROOM_NAME"), GetI18NText(HeroRecordCfg[self.archiveID].name))
	self.condition.text = string.format(GetTips("DORM_ROOM_UNLOCK_TIPS"), GetI18NText(HeroRecordCfg[self.archiveID].name))
	self.heroImg_.sprite = DormHeroTools.GetBackHomeHeadSprite(self.archiveID)
end

function DormRoomUnLockItem:PlaceHeroCallBack(arg_7_1)
	if arg_7_1 then
		self.unLockFunc = arg_7_1
	end
end

function DormRoomUnLockItem:Dispose()
	DormRoomUnLockItem.super.Dispose(self)
end

return DormRoomUnLockItem

local ActivitySkinDrawItemOld = class("ActivitySkinDrawItemOld", ReduxView)

function ActivitySkinDrawItemOld:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivitySkinDrawItemOld:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivitySkinDrawItemOld:InitUI()
	self:BindCfgUI()

	self.typeCon_ = ControllerUtil.GetController(self.transform_, "type")
end

function ActivitySkinDrawItemOld:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		ShowPopItem(POP_ITEM, {
			self.itemID_
		})
	end)
end

function ActivitySkinDrawItemOld:OnEnter()
	return
end

function ActivitySkinDrawItemOld:SetData(arg_7_1, arg_7_2)
	self.id_ = arg_7_2[1]
	self.iconID_ = arg_7_2[2]
	self.activityID_ = arg_7_1
	self.cfg_ = ActivityLimitedDrawPoolCfg[self.id_]

	self:RefreshUI()
end

function ActivitySkinDrawItemOld:RefreshUI()
	self.itemID_ = self.cfg_.reward[1][1]
	self.icon_.sprite = ItemTools.getItemSprite(self.iconID_)
	self.data_ = ActivitySkinDrawDataOld:GetDrawInfo(self.activityID_, self.id_)

	self.typeCon_:SetSelectedState(((self.data_ or nil) and (self.data_.num or self.cfg_.total)) > 0 and "false" or "true")
end

function ActivitySkinDrawItemOld:SetValue(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

function ActivitySkinDrawItemOld:OnExit()
	return
end

function ActivitySkinDrawItemOld:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ActivitySkinDrawItemOld

local ActivityFactoryArchiveView = class("ActivityFactoryArchiveView", ReduxView)

function ActivityFactoryArchiveView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.lockController_ = ControllerUtil.GetController(self.transform_, "name")
end

function ActivityFactoryArchiveView:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self.isLock_ then
			ShowTips(string.format(GetTips("ACTIVITY_RACE_UNLOCK"), GetI18NText(BattleActivityStoryStageCfg[self.stageID_].name)))

			return
		end

		JumpTools.OpenPageByJump("stageArchive", {
			archiveID = self.archiveID_
		})
		saveData("StageArchive", "archiveID" .. self.archiveID_, true)
	end)
end

function ActivityFactoryArchiveView:SetData(arg_4_1, arg_4_2, arg_4_3)
	self.stageID_ = arg_4_1
	self.archiveID_ = arg_4_2
	self.isLock_ = arg_4_3
	self.nameText_.text = GetI18NText(StageArchiveCfg[arg_4_2].name)
	self.transform_.localPosition = Vector3(StageArchiveCfg[arg_4_2].position[1], StageArchiveCfg[arg_4_2].position[2], 0)

	if arg_4_3 then
		self.lockController_:SetSelectedState("lock")
	elseif getData("StageArchive", "archiveID" .. arg_4_2) == true then
		self.lockController_:SetSelectedState("read")
	else
		self.lockController_:SetSelectedState("unlock")
	end

	self:Show(true)
end

function ActivityFactoryArchiveView:OnExit()
	self:Show(false)
end

function ActivityFactoryArchiveView:Dispose()
	ActivityFactoryArchiveView.super.Dispose(self)
end

function ActivityFactoryArchiveView:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

return ActivityFactoryArchiveView

local TeachStageBaseItem = class("TeachStageBaseItem", ReduxView)

function TeachStageBaseItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.transform_.name = arg_1_3
	self.stageID_ = arg_1_3

	self:Init()
end

function TeachStageBaseItem:Init()
	self:InitUI()
	self:AddListeners()
	self:SetData(self.stageID_)
end

function TeachStageBaseItem:InitUI()
	SetActive(self.gameObject_, true)
	self:BindCfgUI()

	self.selectcontroller_ = ControllerUtil.GetController(self.transform_, "select")
end

function TeachStageBaseItem:AddListeners()
	self:AddBtnListener(self.itemBtn_, nil, function()
		if self.isLock_ then
			ShowTips(self.lockStr_)

			return
		end

		BattleFieldData:SetCacheStage(getChapterAndSectionID(self.stageID_), self.stageID_)
		manager.redPoint:setTip(RedPointConst.TEACH_BASE_TEACHING .. "_" .. self.stageID_, 0)
		saveData("redPoint", "BattleBaseTeachStageViewed_" .. self.stageID_, true)
		self:Go("teachSectionInfo", {
			section = self.stageID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING
		})
	end)
end

function TeachStageBaseItem:RefreshSelect(arg_6_1)
	self.selectcontroller_:SetSelectedState(arg_6_1 == self.stageID_ and "choice" or "normal")
end

function TeachStageBaseItem:Dispose()
	self.icon_ = nil
	self.itemBtn_ = nil
	self.text_ = nil
	self.clear_ = nil

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil

	TeachStageBaseItem.super.Dispose(self)
end

function TeachStageBaseItem:SetData(arg_8_1)
	if self.stageID_ then
		manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.TEACH_BASE_TEACHING .. "_" .. self.stageID_)
	end

	self.stageID_ = arg_8_1

	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.TEACH_BASE_TEACHING .. "_" .. self.stageID_)

	for iter_8_0, iter_8_1 in ipairs(GameSetting.new_player_study_stage_unlock.value) do
		if iter_8_1[1] == arg_8_1 then
			self.isLock_ = false
		end
	end

	self:RefreshUI()
end

function TeachStageBaseItem:RefreshUI()
	if self.oldStageID_ ~= self.stageID_ then
		self.oldStageID_ = self.stageID_
		self.transform_.localPosition = Vector3(BattleBaseTeachStageCfg[self.stageID_].position[1], BattleBaseTeachStageCfg[self.stageID_].position[2], 0)
		self.icon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.StageHDPaint.path, BattleBaseTeachStageCfg[self.stageID_].hd_image))
		self.text_.text = GetI18NText(BattleBaseTeachStageCfg[self.stageID_].name)
	end

	local var_9_0 = BattleTeachData:GetBaseTeachList()[self.stageID_]

	SetActive(self.gameObject_, true)
	SetActive(self.clear_, var_9_0 and var_9_0 > 0 or false)
	SetActive(self.lockGo_, self.isLock_)
end

function TeachStageBaseItem:GetLocalPosition()
	return self.transform_.localPosition
end

function TeachStageBaseItem:Show(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)
end

function TeachStageBaseItem:IsOpenSectionInfo()
	return self:IsOpenRoute("teachSectionInfo")
end

return TeachStageBaseItem

local NewWarChessLevelItem = class("NewWarChessLevelItem", ReduxView)

function NewWarChessLevelItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.isOpen_ = false
	self.activityIsOpen_ = false

	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.transform_, "isopen")

	self:AddListeners()
end

function NewWarChessLevelItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if not self.activityIsOpen_ then
			if manager.time:GetServerTime() < ActivityData:GetActivityData(self.cfg_.activity).startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(self.cfg_.activity).startTime))))
			else
				ShowTips(GetTips("TIME_OVER"))
			end

			return
		end

		if not self.isOpen_ then
			ShowTips(string.format(GetTips("ACTIVITY_NEW_WARCHESS_UNLOCK"), NewWarChessLevelCfg[self.cfg_.front_level_id].name_level))

			return
		end

		if self.isOpen_ and self.activityIsOpen_ then
			if NewWarChessData:GetExploreValue(self.chapterID_) >= 100 then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("ACTIVITY_NEW_WARCHESS_LEVEL_EXPLORE_MAX"),
					OkCallback = function()
						NewChessTools.EnterChessMap(self.chapterID_)
					end
				})
			else
				NewChessTools.EnterChessMap(self.chapterID_)
			end
		end
	end)
end

function NewWarChessLevelItem:SetEventListener()
	self:RegistEventListener(ACTIVITY_UPDATE, handler(self, self.OnActivityUpdate))
end

function NewWarChessLevelItem:RemoveEventListener()
	self:RemoveAllEventListener()
end

function NewWarChessLevelItem:SetData(arg_7_1)
	self.chapterID_ = arg_7_1
	self.cfg_ = NewWarChessLevelCfg[arg_7_1]

	self:RefreshUI()
	self:RefreshStatus()
end

function NewWarChessLevelItem:RefreshUI()
	self.nametext_.text = self.cfg_.name_level
	self.bgImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/NewWarChess/" .. self.cfg_.background_level)
	self.movePointText_.text = NewChessTools.GetMovePointText(NewWarChessData:GetMovePoint(self.chapterID_))
	self.progressText_.text = NewWarChessData:GetExploreValue(self.chapterID_) .. "<size=16>%</size>"
	self.progressImage_.fillAmount = NewWarChessData:GetExploreValue(self.chapterID_) / 100
end

function NewWarChessLevelItem:RefreshStatus()
	if self.cfg_.activity ~= 0 then
		if ActivityData:GetActivityIsOpen(self.cfg_.activity) then
			self.activityIsOpen_ = true

			if self.cfg_.front_level_id ~= 0 then
				if NewWarChessData:GetLevelIsFinish(self.cfg_.front_level_id) == 1 then
					self.controller_:SetSelectedState("true")

					self.isOpen_ = true
				else
					self.controller_:SetSelectedState("false")

					self.lockText_.text = string.format(GetTips("ACTIVITY_NEW_WARCHESS_UNLOCK"), NewWarChessLevelCfg[self.cfg_.front_level_id].name_level)
					self.isOpen_ = false
				end
			else
				self.controller_:SetSelectedState("true")

				self.isOpen_ = true
			end
		else
			self.activityIsOpen_ = false

			self.controller_:SetSelectedState("false")

			if manager.time:GetServerTime() < ActivityData:GetActivityData(self.cfg_.activity).startTime then
				self.lockText_.text = string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(self.cfg_.activity).startTime)))
				self.lockText_.text = manager.time:GetServerTime() < ActivityData:GetActivityData(self.cfg_.activity).startTime and string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(self.cfg_.activity).startTime))) or GetTips("TIME_OVER")
			else
				self.lockText_.text = GetTips("TIME_OVER")
			end
		end
	else
		self.activityIsOpen_ = true

		if self.cfg_.front_level_id ~= 0 then
			if NewWarChessData:GetLevelIsFinish(self.cfg_.front_level_id) == 1 then
				self.controller_:SetSelectedState("true")

				self.isOpen_ = true
			else
				self.controller_:SetSelectedState("false")

				self.lockText_.text = string.format(GetTips("ACTIVITY_NEW_WARCHESS_UNLOCK"), NewWarChessLevelCfg[self.cfg_.front_level_id].name_level)
				self.isOpen_ = false
			end
		else
			self.controller_:SetSelectedState("true")

			self.isOpen_ = true
		end
	end
end

function NewWarChessLevelItem:OnActivityUpdate(arg_10_1)
	if arg_10_1 == self.cfg_.activity then
		self:RefreshStatus()
	end
end

function NewWarChessLevelItem:CreatTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:RefreshStatus()
		end, 1, -1)

		self.timer_:Start()
	end
end

function NewWarChessLevelItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function NewWarChessLevelItem:Dispose()
	self:StopTimer()
	NewWarChessLevelItem.super.Dispose(self)
end

return NewWarChessLevelItem

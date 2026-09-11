ChapterPlot19MapBaseLocation = import(".ChapterPlot19MapBaseLocation")

local ChapterPlot19MapNormalLocation = class("ChapterPlot19MapNormalLocation", ChapterPlot19MapBaseLocation)

function ChapterPlot19MapNormalLocation:Ctor(arg_1_1, arg_1_2)
	ChapterPlot19MapNormalLocation.super.Ctor(self, arg_1_1, arg_1_2)

	self.controller_ = self.controllerEx_:GetController("stage")
end

function ChapterPlot19MapNormalLocation:Dispose()
	ChapterPlot19MapNormalLocation.super.Dispose(self)
end

function ChapterPlot19MapNormalLocation:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if not ChapterTools.IsEnableLocation(self.locationID_) then
			return
		end

		BattleFieldData:SetChapterLocationID(self.chapterID_, self.locationID_)
		manager.notify:Invoke(CHAPTER_SELECT_LOCATION)
		self:Go("chapterPlot19MapLocationInfo", {
			chapterID = self.chapterID_,
			locationID = self.locationID_
		})
	end)
end

function ChapterPlot19MapNormalLocation:UpdateLocation()
	ChapterPlot19MapNormalLocation.super.UpdateLocation(self)

	self.nameText_.text = GetI18NText(ChapterLocationCfg[self.locationID_].name)

	if ChapterTools.HasNewLocationMainStage(self.locationID_) then
		self.controller_:SetSelectedState("state1")
	elseif ChapterTools.HasNewLocationStage(mapID, self.locationID_) then
		self.controller_:SetSelectedState("state0")
	else
		self.controller_:SetSelectedState("state2")
	end
end

function ChapterPlot19MapNormalLocation:Show(arg_6_1)
	ChapterPlot19MapNormalLocation.super.Show(self, arg_6_1)

	if arg_6_1 and self.needRefreshAnimaor_ then
		self.animator_:Play("verStage", -1, 0)
	end

	self.needRefreshAnimaor_ = false
end

return ChapterPlot19MapNormalLocation

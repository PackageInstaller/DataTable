local ChapterPlot19MapBaseLocation = class("ChapterPlot19MapBaseLocation", ReduxView)

function ChapterPlot19MapBaseLocation:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = self.controllerEx_:GetController("select")
end

function ChapterPlot19MapBaseLocation:OnUpdate()
	self:UpdateLocation()
end

function ChapterPlot19MapBaseLocation:Dispose()
	ChapterPlot19MapBaseLocation.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ChapterPlot19MapBaseLocation:AddListeners()
	return
end

function ChapterPlot19MapBaseLocation:SetLocationID(arg_5_1, arg_5_2, arg_5_3)
	self.chapterID_ = arg_5_1
	self.locationID_ = arg_5_3
	self.needRefreshAnimaor_ = self.mapID_ ~= arg_5_2
	self.mapID_ = arg_5_2
	self.disabled_ = false

	self:UpdateLocation()
end

function ChapterPlot19MapBaseLocation:UpdateLocation()
	self:Show((ChapterTools.NeedShowLocation(self.mapID_, self.locationID_)))

	self.transform_.localPosition = Vector3(ChapterLocationCfg[self.locationID_].position[1], ChapterLocationCfg[self.locationID_].position[2], ChapterLocationCfg[self.locationID_].position[3])
end

function ChapterPlot19MapBaseLocation:Disabled()
	self.disabled_ = true

	self:Show(false)
end

function ChapterPlot19MapBaseLocation:IsDisabled()
	return self.disabled_
end

function ChapterPlot19MapBaseLocation:Show(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

function ChapterPlot19MapBaseLocation:RefreshSelectState(arg_10_1)
	if self.locationID_ == BattleFieldData:GetChapterLocationID(self.chapterID_) and arg_10_1 then
		self.selectController_:SetSelectedState("yes")
	else
		self.selectController_:SetSelectedState("no")
	end
end

return ChapterPlot19MapBaseLocation

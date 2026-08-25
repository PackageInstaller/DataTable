local CopyRecordsAwakertem, Super = NewViewComponent("CopyRecordsAwakertem")

function CopyRecordsAwakertem:ctor(uiNode, view, awakerData)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Social_PvpRecordAwakerResource(uiNode)
  self.awakerData = awakerData
  self.awakerTid = awakerData.tid
  self.level = awakerData.level or awakerData.lv
  self.curSkin = awakerData.curSkin
end

function CopyRecordsAwakertem:RegisterNotifications()
end

function CopyRecordsAwakertem:RegisterEvents()
end

function CopyRecordsAwakertem:OnBuildComponent()
  Super.OnBuildComponent(self)
end

function CopyRecordsAwakertem:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:SetAwakerData()
end

function CopyRecordsAwakertem:OnExitComponent()
  Super.OnExitComponent(self)
end

function CopyRecordsAwakertem:SetAwakerData()
  self:SetActive(self.ui.Image_Icon, true)
  self:SetActive(self.ui.Image_School, true)
  self:SetActive(self.ui.Text_Level, self.level ~= nil)
  self:SetActive(self.ui.Image_Quality, false)
  self:SetImage(self.ui.Image_Icon, AwakerDataUtils.GetLittleIcon(self.awakerTid, true, self.curSkin))
  self:SetImage(self.ui.Image_School, AwakerDataUtils.GetAwakerSchoolIcon(self.awakerTid))
  self:SetText(self.ui.Text_Level, string.format("Lv.%s", self.level))
end

return CopyRecordsAwakertem

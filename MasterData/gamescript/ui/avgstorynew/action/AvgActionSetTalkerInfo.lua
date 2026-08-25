local AvgDialogType = CommonDefine.AvgDialogType
local AvgActionSetTalkerInfo, Super = System.NewClass("AvgActionSetTalkerInfo", AvgActionBase)

function AvgActionSetTalkerInfo:ctor(...)
  Super.ctor(self, ...)
  self.binder:BindEvent(EventMgr.Instance.VideoCaption, System.fn(self, self.OnVideoCaption))
end

function AvgActionSetTalkerInfo:OnVideoCaption(isShow, captionCfg)
  if not isShow then
    self.ui.Group_Dialog:SetActive(false)
    return
  end
  self.ui.Group_Dialog:SetActive(true)
  self.ui.Image_Dialog_Bg:SetActive(true)
  local talkRoleInfo = self.avgModel:GetTalkRoleInfo(captionCfg.TalkRole)
  self:DoAction(self.binder, talkRoleInfo, function()
  end)
  self:SetUIVisible(captionCfg.DialogType)
end

function AvgActionSetTalkerInfo:DoAction(childBinder, talkRoleInfo, finishCb)
  self:SetUIVisible(self.avgModel:GetDialogType())
  childBinder:SetText(self.ui.Text_Name, self.avgModel:GetTalkerName(talkRoleInfo))
  childBinder:SetText(self.ui.Text_Name_Sec, self.avgModel:GetTalkerTitle(talkRoleInfo))
  self.binder:SetImage(self.ui.Image_Awaker_Icon, self.avgModel:GetTalkerIcon(talkRoleInfo))
  self.binder:SetImage(self.ui.Image_Exp_Face, self.avgModel:GetTalkerEmotion(talkRoleInfo))
  self.ui.Image_Exp_Face:SetActive(self.avgModel:GetTalkerEmotion(talkRoleInfo) ~= nil)
  finishCb()
end

function AvgActionSetTalkerInfo:SetUIVisible(dialogType)
  self.ui.AvgHeadIcon:SetActive(dialogType == CommonDefine.AvgDialogType.HeadIconDialog)
  local isShowName = (dialogType == AvgDialogType.NameDialog or dialogType == AvgDialogType.HeadIconDialog) and not self.avgModel:IsCaption()
  self.ui.Group_Name:SetActive(isShowName)
end

return AvgActionSetTalkerInfo

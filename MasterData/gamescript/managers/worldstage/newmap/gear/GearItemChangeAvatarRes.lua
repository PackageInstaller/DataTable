local GearItemChangeAvatarRes, Super = System.NewClass("GearItemChangeAvatarRes", GearItemBase)

function GearItemChangeAvatarRes:OnTriggerChild(svrData)
  local stageData = self.manager.parent.model:GetStageData()
  if stageData and svrData and svrData.data then
    stageData.avatarResId = svrData.data.avatarResId
  end
end

return GearItemChangeAvatarRes

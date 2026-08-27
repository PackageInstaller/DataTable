local UITrainingSlot = class("UITrainingSlot", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local SlotState = {
  Lock = 1,
  Empty = 2,
  Training = 3,
  TrainingComplete = 4
}

function UITrainingSlot:OnInit()
  self.OnSlotHeroEvent = nil
  self.OnSettleEvent = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.rootBtn, self, self.OnClickRootButton)
  self.ui.img_Hero.texture = nil
end

function UITrainingSlot:InitTrainingSlot(slotData, resloader)
  self.slotData = slotData
  self.resloader = resloader
end

function UITrainingSlot:Update(timestamp)
  self.__timestamp = timestamp
  if self.__enableUpdateProgress then
    self:__UpdateProgress()
  end
end

function UITrainingSlot:__UpdateProgress()
  local duration, remainSecond, progress = self.slotData:UpdateProgress(self.__timestamp)
  MsgCenter:Broadcast(eMsgEventId.UpdateTrainingProgress, self.slotData.index, duration, remainSecond, progress)
  if progress < 1 then
    self.__slotState = SlotState.Training
    local reaminText = TimeUtil:TimestampToTime(remainSecond)
    self.ui.img_Exp.fillAmount = progress
    self.ui.tex_Time:SetIndex(0, reaminText)
    self.ui.tex_Time.text.color = self.ui.trainingColor
    self.__enableUpdateProgress = true
  else
    self.__slotState = SlotState.TrainingComplete
    self.ui.finish:SetActive(true)
    self.ui.tex_Time:SetIndex(1)
    self.ui.tex_Time.text.color = self.ui.trainingCompleteColor
    self.ui.img_Exp.fillAmount = 1
    self.__enableUpdateProgress = false
  end
end

function UITrainingSlot:UpdateSlot()
  local unlock, unlockLevels = self.slotData:CheckUnlock()
  self.__enableUpdateProgress = false
  if not unlock then
    self.__slotState = SlotState.Lock
    self.ui.heroInfoNode:SetActive(false)
    self.ui.add:SetActive(false)
    self.ui.finish:SetActive(false)
    self.ui.addOrLockNode:SetActive(true)
    self.ui.lock:SetActive(true)
    self.ui.tex_Lock.gameObject:SetActive(true)
    self.ui.tex_Title:SetIndex(1)
    if unlockLevels ~= nil and 0 < #unlockLevels then
      self.ui.tex_Lock:SetIndex(0, tostring(unlockLevels[1]))
    end
  elseif self.slotData.heroId == nil then
    self.__slotState = SlotState.Empty
    self.ui.heroInfoNode:SetActive(false)
    self.ui.add:SetActive(true)
    self.ui.finish:SetActive(false)
    self.ui.addOrLockNode:SetActive(true)
    self.ui.lock:SetActive(false)
    self.ui.tex_Lock.gameObject:SetActive(false)
    self.ui.tex_Title:SetIndex(0)
    self.ui.img_Hero.texture = nil
  else
    self.ui.heroInfoNode:SetActive(true)
    self.ui.addOrLockNode:SetActive(false)
    local heroCard = PlayerDataCenter.heroDic[self.slotData.heroId]
    if heroCard == nil then
      error("角色不存在,heroCardId=" .. tostring(self.slotData.heroId))
      return
    end
    if IsNull(self.ui.img_Hero.texture) then
      self.resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(heroCard:GetResPicName()), function(texture)
        self.ui.img_Hero.texture = texture
      end)
    end
    self.ui.tex_Name.text = heroCard:GetName()
    self.ui.tex_Level.text = "LV.<Size=30>" .. tostring(heroCard.level) .. "</Size>"
    local starSize = self.ui.img_Star.sizeDelta
    starSize.x = starSize.y * heroCard.star
    self.ui.img_Star.sizeDelta = starSize
    self:__UpdateProgress()
  end
end

function UITrainingSlot:OnClickRootButton()
  if self.__slotState == SlotState.Lock then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Train_LockedInfo))
  elseif self.__slotState == SlotState.Empty then
    if self.OnSlotHeroEvent ~= nil then
      self.OnSlotHeroEvent(self.slotData.index)
    end
  elseif self.__slotState == SlotState.Training then
    if self.OnSettleEvent ~= nil then
      self.OnSettleEvent(self.slotData.index, false)
    end
  elseif self.__slotState == SlotState.TrainingComplete and self.OnSettleEvent ~= nil then
    self.OnSettleEvent(self.slotData.index, true)
  end
end

function UITrainingSlot:OnDelete()
  self.resloader = nil
  base.OnDelete(self)
end

return UITrainingSlot

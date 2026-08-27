local UINDungeonItemBase = class("UINDungeonItemBase", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon

function UINDungeonItemBase:OnInit()
  self.isLock = false
  self.clickEvent = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.tog_DungeonItem, self, self.__onClick)
  self.ui.state_lock.gameObject:SetActive(false)
  self.ui.img_Select:SetActive(false)
end

function UINDungeonItemBase:InitDungeonItem(dungeonData, resLoader, clickEvent)
  self.dungeonData = dungeonData
  self.clickEvent = clickEvent
  local name, name_en = dungeonData:GetDungeonName()
  self.ui.tex_Name.text = name
  if self.ui.tex_ENName ~= nil and not IsNull(self.ui.tex_ENName.text) then
    self.ui.tex_ENName.text = name_en
  end
  self.gameObject.name = name_en
  if not dungeonData:GetIsUnlock() then
    self.ui.state_lock:SetActive(true)
    self.isLock = true
  end
  self:IsMultReward()
end

function UINDungeonItemBase:UpdateDailyLimit()
  self:IsMultReward()
end

function UINDungeonItemBase:__onClick()
  if self.isLock then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(self.dungeonData:GetDungeonUnlockDes())
    return
  end
  AudioManager:PlayAudioById(1060)
  if self.clickEvent ~= nil then
    self.clickEvent(self)
  end
end

function UINDungeonItemBase:OnSelectDisplay(isShow)
  self.ui.img_Select:SetActive(isShow)
end

function UINDungeonItemBase:IsMultReward()
  if self.ui.obj_dropUp ~= nil then
    if self.dungeonData:GetIsHaveMultReward() then
      self.ui.obj_dropUp:SetActive(true)
      local multAddRate = self.dungeonData:GetActivityMultRewardRate()
      if multAddRate == 1 then
        self.ui.tex_multType:SetIndex(1)
      else
        self.ui.tex_multType:SetIndex(0)
      end
      local leftTime, totalTime = self.dungeonData:GetLeftActivityMultRewardNum()
      self.ui.tex_CompleteNum:SetIndex(0, tostring(leftTime), tostring(totalTime))
    else
      self.ui.obj_dropUp:SetActive(false)
    end
  end
end

function UINDungeonItemBase:OnDelete()
  base.OnDelete(self)
end

return UINDungeonItemBase

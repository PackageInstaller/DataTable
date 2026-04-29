_class("UIN34TaskDelegatePersonTaskItem", UICustomWidget)
UIN34TaskDelegatePersonTaskItem = UIN34TaskDelegatePersonTaskItem

function UIN34TaskDelegatePersonTaskItem:OnShow(uiParams)
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._costLabel = self:GetUIComponent("UILocalizationText", "Cost")
  self._desLabel = self:GetUIComponent("UILocalizationText", "Des")
  self._selected = self:GetGameObject("Selected")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._rewardLoader = self:GetUIComponent("UISelectObjectPath", "Rewards")
  self._go = self:GetGameObject()
  self._anim = self:GetUIComponent("Animation", "Anim")
end

function UIN34TaskDelegatePersonTaskItem:SetData(data, isSelected, callback, itemClickCallback)
  if not data then
    self._go:SetActive(false)
    return
  end
  self._go:SetActive(true)
  self._data = data
  self._callback = callback
  self._nameLabel:SetText(data:GetName())
  self._iconLoader:LoadImage(data:GetIcon())
  self._costLabel:SetText(data:GetCost())
  self._desLabel:SetText("-" .. data:GetDes())
  self._selected:SetActive(isSelected)
  local rewards = data:GetRewards()
  local trust = data:GetTrustValue()
  self._rewardLoader:SpawnObjects("UIN34TaskDelegatePersonTaskReward", #rewards)
  local items = self._rewardLoader:GetAllSpawnList()
  for i = 1, #items do
    items[i]:SetData(false, rewards[i], function(id, pos)
      if itemClickCallback then
        itemClickCallback(id, pos)
      end
    end)
  end
end

function UIN34TaskDelegatePersonTaskItem:GetData()
  return self._data
end

function UIN34TaskDelegatePersonTaskItem:Select()
  self._selected:SetActive(true)
end

function UIN34TaskDelegatePersonTaskItem:UnSelect()
  self._selected:SetActive(false)
end

function UIN34TaskDelegatePersonTaskItem:BGOnClick()
  if self._callback then
    self._callback(self._data)
  end
end

function UIN34TaskDelegatePersonTaskItem:PlayAnimation()
  self._anim:Play("uieff_UIN34TaskDelegatePersonTaskItem_in")
end

function UIN34TaskDelegatePersonTaskItem:PlayGetAnimation()
  self._anim:Play("uieff_UIN34TaskDelegatePersonTaskItem_get")
end

function UIN34TaskDelegatePersonTaskItem:StopAnimation()
  self._anim:Stop()
end

function UIN34TaskDelegatePersonTaskItem:SetActive(status)
  self._go:SetActive(status)
end

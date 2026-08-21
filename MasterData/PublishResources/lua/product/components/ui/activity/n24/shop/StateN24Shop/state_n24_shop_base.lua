_class("StateN24ShopBase", State)
StateN24ShopBase = StateN24ShopBase

function StateN24ShopBase:Init()
  self.fsm = self:GetFsm()
  self.ui = self.fsm:GetData()
  self.data = self.ui.data
  self.mCampaign = self.ui.mCampaign
  self._uiModule = self.ui._uiModule
  self.mPet = self.ui.mPet
end

function StateN24ShopBase:Destroy()
  StateN24ShopBase.super.Destroy(self)
  self.ui = nil
end

function StateN24ShopBase:CurPageIndex()
  return self.ui._curPageIndex
end

function StateN24ShopBase:ShowHideSpineSkip(isShow)
  self.ui.spineSkipGo:SetActive(isShow)
end

function StateN24ShopBase:SetSpineSkipClickCallback(callback)
  self.ui.spineSkipClickCallback = callback
end

function StateN24ShopBase:PlaySpineAnimation(spineAnim, loop)
  return self.ui:PlaySpineAnimation(spineAnim, loop)
end

function StateN24ShopBase:GetRewardRecord()
  return self.ui.rewardRecord
end

function StateN24ShopBase:_ForceRefresh(isOpenNew)
  self.ui:_ForceRefresh(isOpenNew)
end

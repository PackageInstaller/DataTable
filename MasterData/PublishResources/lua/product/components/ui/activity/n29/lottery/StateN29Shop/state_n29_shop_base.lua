_class("StateN29ShopBase", State)
StateN29ShopBase = StateN29ShopBase

function StateN29ShopBase:Init()
  self.fsm = self:GetFsm()
  self.ui = self.fsm:GetData()
  self.data = self.ui.data
  self.mCampaign = self.ui.mCampaign
  self._uiModule = self.ui._uiModule
  self.mPet = self.ui.mPet
end

function StateN29ShopBase:Destroy()
  StateN29ShopBase.super.Destroy(self)
  self.ui = nil
end

function StateN29ShopBase:CurPageIndex()
  return self.ui._curPageIndex
end

function StateN29ShopBase:ShowHideSpineSkip(isShow)
  self.ui.spineSkipGo:SetActive(isShow)
end

function StateN29ShopBase:SetSpineSkipClickCallback(callback)
  self.ui.spineSkipClickCallback = callback
end

function StateN29ShopBase:PlaySpineAnimation(spineAnim, loop)
  return self.ui:PlaySpineAnimation(spineAnim, loop)
end

function StateN29ShopBase:GetRewardRecord()
  return self.ui.rewardRecord
end

function StateN29ShopBase:_ForceRefresh(isOpenNew, dontPlaySpine)
  self.ui:_ForceRefresh(isOpenNew, dontPlaySpine)
end

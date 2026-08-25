local SummonMixPoolLimitItemComp, Super = System.NewComponent("SummonMixPoolLimitItemComp")
SummonMixPoolLimitItemComp.uiResCls = UI_Summon_Item_MixPoolLimitResource
local PORTRAIT_POS_Y = 60

function SummonMixPoolLimitItemComp:ctor(uiNode, poolId, slot, clickFunc)
  Super.ctor(self)
  self.ui = SummonMixPoolLimitItemComp.uiResCls(uiNode)
  self.poolId = poolId
  self.slot = slot
  self.clickFunc = clickFunc
  self.itemTid = nil
end

function SummonMixPoolLimitItemComp:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self._OnClick))
  self:_RefreshTypeIcon()
  self:_RefreshSlot()
end

function SummonMixPoolLimitItemComp:_OnClick()
  if self.clickFunc then
    self.clickFunc(self.slot)
  end
end

function SummonMixPoolLimitItemComp:_ClearLegacyAwakerImage()
  if not self.ui.AwakerPos then
    return
  end
  local awakerPosGo = self.ui.AwakerPos.gameObject or self.ui.AwakerPos
  local image = awakerPosGo:GetComponent(typeof(CS.UnityEngine.UI.Image))
  if image then
    image.enabled = false
  end
end

function SummonMixPoolLimitItemComp:_ApplyPortraitOffset()
  if not self.ui.AwakerPos then
    return
  end
  local awakerPosGo = self.ui.AwakerPos.gameObject or self.ui.AwakerPos
  local rectTrans = awakerPosGo:GetComponent(typeof(CS.UnityEngine.RectTransform))
  if not rectTrans then
    return
  end
  local pos = rectTrans.anchoredPosition
  rectTrans.anchoredPosition = CS.UnityEngine.Vector2(pos.x, PORTRAIT_POS_Y)
end

function SummonMixPoolLimitItemComp:_RefreshAwakerPortrait(awakerTid)
  if not (self.ui.AwakerPos and self.binder) or not awakerTid then
    return
  end
  self:_ClearLegacyAwakerImage()
  self:_ApplyPortraitOffset()
  local portraitAlign = CommonDefine.PortraitAlign.HorizontalCenter
  if not self._awakerPortraitComp then
    self._awakerPortraitComp = self.binder:BindComponent(AwakerPortraitComp(self.ui.AwakerPos, awakerTid, nil, nil, portraitAlign))
  else
    self._awakerPortraitComp:ChangeAwakerTid(awakerTid)
  end
end

function SummonMixPoolLimitItemComp:_RefreshWeaponIcon()
  if not self.ui.Image_Weapon or not self.binder then
    return
  end
  if not self.itemTid then
    self.binder:SetActive(self.ui.Image_Weapon, false)
    return
  end
  local weaponItemTid = SummonCategorySelectDataUtils.GetRecommendWeaponItemTid(self.itemTid)
  if not weaponItemTid then
    self.binder:SetActive(self.ui.Image_Weapon, false)
    return
  end
  self.binder:SetActive(self.ui.Image_Weapon, true)
  self.binder:SetImage(self.ui.Image_Weapon, ItemDataUtils.GetItemIcon(weaponItemTid))
end

function SummonMixPoolLimitItemComp:_SafeSetImage(imageGo, path)
  if not imageGo then
    return
  end
  if not SummonCategorySelectDataUtils.IsValidImagePath(path) then
    self.binder:SetActive(imageGo, false)
    return
  end
  self.binder:SetActive(imageGo, true)
  self.binder:SetImage(imageGo, path)
end

function SummonMixPoolLimitItemComp:_RefreshTypeIcon()
  local iconPath = SummonCategorySelectDataUtils.GetSelectTypeIcon(self.poolId, self.slot)
  self:_SafeSetImage(self.ui.Image_Type, iconPath)
end

function SummonMixPoolLimitItemComp:_RefreshSlot()
  local hasAwaker = self.itemTid ~= nil
  self.binder:SetActive(self.ui.Group_AwakerEmpty, not hasAwaker)
  self.binder:SetActive(self.ui.Group_AwakerWeapon, hasAwaker)
  if not hasAwaker then
    return
  end
  local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(self.itemTid)
  self:_RefreshAwakerPortrait(awakerTid)
  self:_RefreshWeaponIcon()
end

function SummonMixPoolLimitItemComp:UpdateItemTid(itemTid)
  self.itemTid = itemTid
  if self.binder then
    self:_RefreshSlot()
  end
end

return SummonMixPoolLimitItemComp

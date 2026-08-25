local T_Image = typeof(CS.UnityEngine.UI.Image)
local SettleAwardItemNew, Super = System.NewComponent("SettleAwardItemNew")

function SettleAwardItemNew:ctor(uiNode, itemData)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_Out_ObtainResource(uiNode)
  self.data = itemData
end

function SettleAwardItemNew:OnBind(binder)
  self.binder = binder
  binder:SetText(self.ui.Text_Obtain, string.format("+%s", self.data.itemCount))
  binder:BindToImageSync(self.ui.Image_Icon, function()
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, self.data.itemTid
  end)
  if self.ui.Image_Icon then
    local IconImageComp = self.ui.Image_Icon:GetComponent(T_Image)
    if IconImageComp and IconImageComp.sprite == nil then
      binder:BindToImage(self.ui.Image_Icon, function()
        do return ItemDataUtils.GetItemIcon end
        return ItemDataUtils.GetItemIcon, self.data.itemTid
      end)
    end
  end
  local config = DT.Item[self.data.itemTid]
  binder:SetText(self.ui.Text_Description, self:_IsBonusExp() and LT.Text("PVPSettleAccelerateField") or LT.Text(config.Name))
  self.ui.UI_Pvp_Out_Manifestation_1:SetActive(false)
  if self:NeedShowExpLimitItem() then
    self.ui.UI_Pvp_Out_Manifestation_1:SetActive(true)
    self.binder:BindComponent(RoleDayExpLimitTips(self.ui.UI_Pvp_Out_Manifestation_1))
  end
  self.ui.Group_Tab_Topic:SetActive(self:HasAdvancedPrivilege())
  self.ui.Group_Tab_Double:SetActive(self:HasDoubleActivity())
end

function SettleAwardItemNew:NeedShowExpLimitItem()
  if not BattlePassDataUtils.IsRoleExp(self.data.itemTid) then
    return false
  end
  local expBonus = PlayerDataUtils.GetDRoleByField("expBonus") or 0
  if expBonus > 0 then
    do return self._IsBonusExp end
    return self._IsBonusExp, self
  end
  return not self:_IsBonusExp()
end

function SettleAwardItemNew:_IsBonusExp()
  return self.data.itemAwardType == CommonDefine.ItemAwardType.ExpBonus
end

function SettleAwardItemNew:HasAdvancedPrivilege()
  return false
end

function SettleAwardItemNew:HasDoubleActivity()
  local isRoleExp = BattlePassDataUtils.IsRoleExp(self.data.itemTid)
  local hasActivity = ActivityManager.Instance:IsActivityOpenByType(ActivityDefine.ActivityType.DoubleExp)
  return isRoleExp and hasActivity
end

return SettleAwardItemNew

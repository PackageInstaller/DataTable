local MAX_SHOW_WEAPON_NUM = 5
local AWAKER_WEAPON_SCALE = 0.8
local BpWeaponView, Super = NewClass("BpWeaponView", BaseView)
BpWeaponView.uiResCls = UI_Passport_Praising_ItemResource

function BpWeaponView:ctor()
  Super.ctor(self)
end

function BpWeaponView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnBpWeaponViewWeaponChanged, self.RefreshView, self)
end

function BpWeaponView:RegisterEvents()
end

function BpWeaponView:OnEnterView()
  Super.OnEnterView(self)
  BpWeaponModel.Instance:SetChooseItemTid(BpWeaponModel.Instance.showWeaponRewards[1])
  AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_C_Content)
  self:RefreshView()
end

function BpWeaponView:RefreshOnRendered()
end

function BpWeaponView:_RefreshWeaponList()
  local content = self.ui.GoodsScrollView:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect)).content
  for i = 1, MAX_SHOW_WEAPON_NUM do
    local itemObj = self.ui["Goods_" .. i]
    local itemId = BpWeaponModel.Instance.showWeaponRewards[i]
    local active = itemId and DT.Item[itemId].Type == "Weapon"
    self:SetActive(itemObj, active)
    if active then
      local function clickFunc()
        BpWeaponModel.Instance:SetChooseItemTid(itemId)
      end
      
      local isSelect = BpWeaponModel.Instance.chooseItemTid == itemId
      local viewData = {
        itemTid = itemId,
        clickFunc = clickFunc,
        isSelect = isSelect
      }
      self:AddViewComponentOnce(itemObj, CompPublicIconItemType2, viewData)
    end
  end
  content:GetComponent(typeof(CS.UnityEngine.RectTransform)).sizeDelta = CS.UnityEngine.Vector2(156, 160 * #BpWeaponModel.Instance.weaponList)
end

function BpWeaponView:RefreshView()
  self:_RefreshWeaponTips()
  self:_RefreshWeaponList()
  self:_RefreshWeaponLargeView()
end

function BpWeaponView:_RefreshWeaponTips()
  local itemCfg = DT.Item[BpWeaponModel.Instance.chooseItemTid]
  if itemCfg.Type ~= "Weapon" then
    self:SetActive(self.ui.WeaponScrollView, false)
    return
  end
  self:SetActive(self.ui.WeaponScrollView, true)
  local viewData = {
    itemTid = BpWeaponModel.Instance.chooseItemTid
  }
  self:AddViewComponentOnce(self.ui.UI_Passport_Tips, CompPublicWeaponTips, viewData)
end

function BpWeaponView:_RefreshWeaponLargeView()
  local itemCfg = DT.Item[BpWeaponModel.Instance.chooseItemTid]
  if itemCfg.Type ~= "Weapon" then
    self:SetActive(self.ui.Group_Weapon, false)
    return
  end
  self:SetActive(self.ui.Group_Weapon, true)
  local imagePath = itemCfg and itemCfg.SpIcon or ""
  local viewData = {path = imagePath, scale = AWAKER_WEAPON_SCALE}
  self:AddViewComponentOnce(self.ui.Image_Weapon_Large, CompPublicAwakerWeapon, viewData)
end

function BpWeaponView:OnEnterViewFinished()
end

function BpWeaponView:OnExitView()
  Super.OnExitView(self)
end

return BpWeaponView

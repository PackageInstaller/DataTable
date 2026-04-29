_class("UIN31SecondAnniversaryItemTips", UICustomWidget)
UIN31SecondAnniversaryItemTips = UIN31SecondAnniversaryItemTips

function UIN31SecondAnniversaryItemTips:Constructor()
  self._itemModule = GameGlobal.GetModule(ItemModule)
  self._roleModule = GameGlobal.GetModule(RoleModule)
end

function UIN31SecondAnniversaryItemTips:OnShow(uiParams)
  self:_GetComponents()
end

function UIN31SecondAnniversaryItemTips:_GetComponents()
  self._parentGo = self:GetGameObject("Parent")
  self._itemInfoGo = self:GetGameObject("ItemInfo")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._count = self:GetUIComponent("UILocalizationText", "Count")
  self._content = self:GetUIComponent("UILocalizationText", "Content")
  self._uIItem = self:GetUIComponent("UISelectObjectPath", "UIItem")
  self._uiItemWidget = self._uIItem:SpawnObject("UIItemHomeland")
  self.atc = self:GetGameObject():GetComponent(typeof(ATransitionComponent))
  self._parentGo:SetActive(false)
end

function UIN31SecondAnniversaryItemTips:SetData(id, position)
  local cfg = Cfg.cfg_item[id]
  if not cfg then
    return
  end
  self._name:SetText(StringTable.Get(cfg.Name))
  local count = self._roleModule:GetAssetCount(id)
  local str = string.format("<color=#d57f48>%s</color>", self:_FormatItemCount(count))
  self._count:SetText(StringTable.Get("str_item_public_owned") .. str)
  self._content:SetText(StringTable.Get(cfg.Intro))
  local roleAsset = {}
  roleAsset.assetid = id
  self._uiItemWidget:Flush(roleAsset)
  self._uiItemWidget:SetNotShowTips(true)
  self._itemInfoGo.transform.position = position
  self._itemInfoGo.transform.localPosition = Vector3(self._itemInfoGo.transform.localPosition.x + 380, self._itemInfoGo.transform.localPosition.y + 130, 0)
  self._parentGo:SetActive(true)
  self.atc:PlayEnterAnimation(true)
end

function UIN31SecondAnniversaryItemTips:CloseBtnOnClick(go)
  self:StartTask(function(TT)
    local key = "UIN31SecondAnniversaryItemTipsClose"
    self:Lock(key)
    self.atc:PlayLeaveAnimation(true)
    YIELD(TT, 233)
    self._parentGo:SetActive(false)
    self:UnLock(key)
  end, self)
end

function UIN31SecondAnniversaryItemTips:ForceHideObject()
  self._parentGo:SetActive(false)
end

function UIN31SecondAnniversaryItemTips:_FormatItemCount(itemCount)
  return HelperProxy:GetInstance():FormatItemCount(itemCount)
end

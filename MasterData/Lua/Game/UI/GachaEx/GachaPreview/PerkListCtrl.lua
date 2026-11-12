local PerkListCtrl = class("PerkListCtrl", BaseCtrl)
PerkListCtrl._mapNodeConfig = {
  tog = {
    sComponentName = "UIButton",
    nCount = 2,
    callback = "OnBtnClick_Tog"
  },
  togCtrl = {
    sNodeName = "tog",
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl",
    nCount = 2
  },
  rtExPerkGrid = {
    nCount = 4,
    sCtrlName = "Game.UI.GachaEx.GachaPreview.PerkGridCtrl"
  }
}
PerkListCtrl._mapEventConfig = {}

function PerkListCtrl:Awake()
  self.curTog = 1
  self.canvasGroup = self.gameObject:GetComponent("CanvasGroup")
end

function PerkListCtrl:FadeIn()
end

function PerkListCtrl:FadeOut()
end

function PerkListCtrl:OnEnable()
  for i = 1, 2 do
    self._mapNode.togCtrl[i]:SetDefault(i == self.curTog)
  end
  self._mapNode.togCtrl[1]:SetText(ConfigTable.GetUIText("Build_Leader"))
  self._mapNode.togCtrl[2]:SetText(ConfigTable.GetUIText("Build_Sub"))
end

function PerkListCtrl:OnDisable()
end

function PerkListCtrl:OnDestroy()
end

function PerkListCtrl:OnRelease()
end

function PerkListCtrl:SetShow(bShow)
  if bShow then
    NovaAPI.SetCanvasGroupAlpha(self.canvasGroup, 1)
    NovaAPI.SetCanvasGroupBlocksRaycasts(self.canvasGroup, true)
  else
    NovaAPI.SetCanvasGroupAlpha(self.canvasGroup, 0)
    NovaAPI.SetCanvasGroupBlocksRaycasts(self.canvasGroup, false)
  end
end

function PerkListCtrl:Refresh(nCharId)
  self.nCharId = nCharId
  local mapCharCfgData = ConfigTable.GetData_Character(nCharId)
  if mapCharCfgData == nil then
    self.gameObject:SetActive(false)
    return
  end
  if #mapCharCfgData.Weapons < 1 then
    self.gameObject:SetActive(false)
    return
  end
  local nWeaponId = mapCharCfgData.Weapons[#mapCharCfgData.Weapons]
  local mapWeaponCfgData = ConfigTable.GetData("Weapon", nWeaponId)
  local tbPerks
  if self.curTog == 1 then
    tbPerks = mapWeaponCfgData.MasterSpecificPerkIds
  else
    tbPerks = mapWeaponCfgData.AssistSpecificPerkIds
  end
  for index = 1, 4 do
    self._mapNode.rtExPerkGrid[index]:SetPerk(tbPerks[index])
  end
end

function PerkListCtrl:OnBtnClick_Tog(tog)
  local togIdx = table.indexof(self._mapNode.tog, tog)
  if togIdx ~= self.curTog then
    self._mapNode.togCtrl[togIdx]:SetTrigger(true)
    self._mapNode.togCtrl[self.curTog]:SetTrigger(false)
    self.curTog = togIdx
    self:Refresh(self.nCharId)
  end
end

return PerkListCtrl

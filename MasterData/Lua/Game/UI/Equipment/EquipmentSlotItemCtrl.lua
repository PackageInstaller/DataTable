local EquipmentSlotItemCtrl = class("EquipmentSlotItemCtrl", BaseCtrl)
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
EquipmentSlotItemCtrl._mapNodeConfig = {
  goEmpty = {},
  imgAbleBg = {sComponentName = "Image"},
  txtUnEquip = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharEquipment_UnEquip"
  },
  imgLockBg = {sComponentName = "Image"},
  txtLockDesc = {sComponentName = "TMP_Text"},
  imgLockType = {sComponentName = "Image"},
  imgChoose = {},
  goEquip = {},
  imgEquipmentIcon = {sComponentName = "Transform"}
}
EquipmentSlotItemCtrl._mapEventConfig = {}
EquipmentSlotItemCtrl._mapRedDotConfig = {}

function EquipmentSlotItemCtrl:Init(mapSlot, nCharId)
  self.mapSlot = mapSlot
  local bEmpty = mapSlot.nGemIndex == 0
  local bUnlock = mapSlot.bUnlock
  self._mapNode.goEmpty.gameObject:SetActive(bEmpty or not bUnlock)
  self._mapNode.imgAbleBg.gameObject:SetActive(bEmpty and bUnlock)
  self._mapNode.imgLockBg.gameObject:SetActive(not bUnlock)
  self._mapNode.goEquip.gameObject:SetActive(not bEmpty and bUnlock)
  self:ClearEquipment()
  local nGemId = PlayerData.Equipment:GetGemIdBySlot(nCharId, mapSlot.nSlotId)
  local mapGemCfg = ConfigTable.GetData("CharGem", nGemId)
  if not mapGemCfg then
    return
  end
  if not bUnlock then
    self:SetPngSprite(self._mapNode.imgLockType, mapGemCfg.IconBg)
    NovaAPI.SetTMPText(self._mapNode.txtLockDesc, orderedFormat(ConfigTable.GetUIText("Equipment_SlotActiveLevel"), mapSlot.nLevel))
  elseif bUnlock and not bEmpty then
    local mapEquipment = PlayerData.Equipment:GetEquipmentByGemIndex(nCharId, mapSlot.nSlotId, mapSlot.nGemIndex)
    local bUpgrade = 0 < mapEquipment:GetUpgradeCount()
    if not self.goEquipment then
      local equipPrefab
      local sPrefab = mapEquipment.sIcon .. ".prefab"
      if GameResourceLoader.ExistsAsset(Settings.AB_ROOT_PATH .. sPrefab) == true then
        equipPrefab = self:LoadAsset(sPrefab)
      end
      if equipPrefab then
        self.goEquipment = instantiate(equipPrefab, self._mapNode.imgEquipmentIcon)
      end
    end
    if self.goEquipment then
      self.goEquipment.transform:Find("goFx").gameObject:SetActive(bUpgrade)
    end
  end
  if mapSlot.nSlotId == 1 and bEmpty and bUnlock then
    local mapSlotCfg = ConfigTable.GetData("CharGemSlotControl", mapSlot.nSlotId)
    local nHasCount = PlayerData.Item:GetItemCountByID(mapGemCfg.GenerateCostTid)
    if nHasCount >= mapSlotCfg.GeneratenCostQty then
      EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_EquipmentSlot")
    end
  end
  self:SetChooseState(false)
end

function EquipmentSlotItemCtrl:SetChooseState(bChoose)
  self._mapNode.imgChoose.gameObject:SetActive(bChoose)
end

function EquipmentSlotItemCtrl:ClearEquipment()
  delChildren(self._mapNode.imgEquipmentIcon)
  self.goEquipment = nil
end

function EquipmentSlotItemCtrl:PlayAnim()
  local sAnimName = ""
  sAnimName = "imgEquipmentIcon_in"
  self.animRoot:Play(sAnimName, 0, 0)
end

function EquipmentSlotItemCtrl:Awake()
  self.animRoot = self.gameObject:GetComponent("Animator")
  self.goEquipment = nil
end

function EquipmentSlotItemCtrl:OnDisable()
  self:ClearEquipment()
end

return EquipmentSlotItemCtrl

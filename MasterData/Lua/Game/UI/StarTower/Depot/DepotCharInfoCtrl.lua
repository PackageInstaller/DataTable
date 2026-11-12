local DepotCharInfoCtrl = class("DepotCharInfoCtrl", BaseCtrl)
local AdventureModuleHelper = CS.AdventureModuleHelper
local CharacterAttrData = require("GameCore.Data.DataClass.CharacterAttrData")
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
DepotCharInfoCtrl._mapNodeConfig = {
  goProperty = {
    nCount = 5,
    sCtrlName = "Game.UI.TemplateEx.TemplatePropertyCtrl"
  },
  txtTitleAttr = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Depot_Info_Property"
  },
  btnChar = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Char"
  },
  imgHead = {nCount = 3, sComponentName = "Image"},
  goSelect = {nCount = 3},
  txtLeaderCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Leader"
  },
  txtSubCn = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Sub"
  },
  btnPopSkill = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Skill"
  },
  btnAttrDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  rtInfo = {
    sCtrlName = "Game.UI.TemplateEx.TemplateCharInfoCtrl"
  },
  txtBtnSkill = {sComponentName = "TMP_Text", sLanguageId = "SkillCn"},
  rtEquipment = {},
  txtTitleEquipment = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Depot_Info_Equipment"
  },
  btnEquipment = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Equipment"
  },
  imgEquipment = {nCount = 3, sComponentName = "Transform"},
  goEquipment = {nCount = 3},
  txtEquipmentLock = {nCount = 3, sComponentName = "TMP_Text"}
}
DepotCharInfoCtrl._mapEventConfig = {}
DepotCharInfoCtrl._mapRedDotConfig = {}

function DepotCharInfoCtrl:RefreshCharInfo(tbTeam, mapCharaData)
  self.tbTeam = tbTeam
  self.mapCharData = mapCharaData
  if not self.nCharId then
    self.nCharId = self.tbTeam[1]
    self.nSelectIndex = 1
  end
  self:RefreshActorId()
  self:SwitchChar()
  self:RefreshChoose()
end

function DepotCharInfoCtrl:SwitchChar()
  local mapChar = {
    nLevel = self.mapCharData[self.nCharId].nLevel,
    nAdvance = self.mapCharData[self.nCharId].nAdvance
  }
  local tbEffect = {}
  for _, v in ipairs(self.mapCharData[self.nCharId].tbAffinityeffectIds) do
    table.insert(tbEffect, v)
  end
  for _, v in ipairs(self.mapCharData[self.nCharId].tbTalentEffect) do
    table.insert(tbEffect, v)
  end
  for _, v in ipairs(self.mapCharData[self.nCharId].tbEquipmentEffect) do
    table.insert(tbEffect, v)
  end
  local tbRandomAttr = self:GetCharEquipmentRandomAttr()
  if not self.attrData then
    self.attrData = CharacterAttrData.new(self.nCharId, {
      mapChar = mapChar,
      tbEffect = tbEffect,
      tbRandomAttr = tbRandomAttr
    })
  else
    self.attrData:SetCharacter(self.nCharId, {
      mapChar = mapChar,
      tbEffect = tbEffect,
      tbRandomAttr = tbRandomAttr
    })
  end
  self:RefreshActor2D()
  self:RefreshAttribute()
  self:RefreshInfo()
end

function DepotCharInfoCtrl:GetCharEquipmentRandomAttr()
  local tbEquipedGem = self.mapCharData[self.nCharId].tbEquipment
  if not tbEquipedGem or #tbEquipedGem == 0 then
    return {}
  end
  local tbRandomAttrList = {}
  for _, mapEquipment in pairs(tbEquipedGem) do
    local mapRandomAttr = mapEquipment:GetRandomAttr()
    for k, v in ipairs(mapRandomAttr) do
      local nAttrId = v.AttrId
      if nAttrId ~= nil then
        local nCfgValue = v.CfgValue
        local nValue = v.Value
        if nil == tbRandomAttrList[nAttrId] then
          tbRandomAttrList[nAttrId] = {CfgValue = nCfgValue, Value = nValue}
        else
          tbRandomAttrList[nAttrId].CfgValue = tbRandomAttrList[nAttrId].CfgValue + nCfgValue
          tbRandomAttrList[nAttrId].Value = tbRandomAttrList[nAttrId].Value + nValue
        end
      end
    end
  end
  for _, v in pairs(tbRandomAttrList) do
    v.CfgValue = clearFloat(v.CfgValue)
  end
  return tbRandomAttrList
end

function DepotCharInfoCtrl:RefreshChoose()
  for i = 1, 3 do
    local nCharId = self.tbTeam[i]
    local charData = self.mapCharData[nCharId]
    if charData ~= nil then
      local nCharSkinId = charData.nSkinId
      local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
      self:SetPngSprite(self._mapNode.imgHead[i], mapCharSkin.Icon, AllEnum.CharHeadIconSurfix.L)
      self._mapNode.goSelect[i]:SetActive(self.nSelectIndex == i)
    end
  end
end

function DepotCharInfoCtrl:RefreshActor2D()
  EventManager.Hit("RefreshActor2D_Depot", self.nCharId)
end

function DepotCharInfoCtrl:RefreshAttribute()
  local HealthInfo = self.tbActorHealthInfo[self.nCharId]
  local Info = self.tbActorInfo[self.nCharId]
  local tbAttr = {}
  if self.nSelectIndex == 1 then
    local hp = HealthInfo ~= nil and HealthInfo.hp or 0
    local hpMax = HealthInfo ~= nil and HealthInfo.hpMax or 0
    tbAttr = {totalValue = hp, baseValue = hp}
    self._mapNode.goProperty[1]:SetCharProperty(AllEnum.CharAttr[1], tbAttr, true, hpMax)
    self._mapNode.goProperty[1].gameObject:SetActive(true)
  else
    local hpMax = HealthInfo ~= nil and HealthInfo.hpMax or 0
    tbAttr = {totalValue = hpMax, baseValue = hpMax}
    self._mapNode.goProperty[1]:SetCharProperty(AllEnum.CharAttr[1], tbAttr, true)
    self._mapNode.goProperty[1].gameObject:SetActive(true)
  end
  local atk = Info ~= nil and Info.atk:AsFloat() or 0
  tbAttr = {totalValue = atk, baseValue = atk}
  self._mapNode.goProperty[2]:SetCharProperty(AllEnum.CharAttr[2], tbAttr, true)
  local def = Info ~= nil and Info.def:AsFloat() or 0
  tbAttr = {totalValue = def, baseValue = def}
  self._mapNode.goProperty[3]:SetCharProperty(AllEnum.CharAttr[3], tbAttr, true)
  local critRate = Info ~= nil and Info.critRate:AsFloat() or 0
  tbAttr = {
    totalValue = critRate * 100,
    baseValue = critRate * 100
  }
  self._mapNode.goProperty[4]:SetCharProperty(AllEnum.CharAttr[4], tbAttr, false)
  local critPower = Info ~= nil and Info.critPower:AsFloat() or 0
  tbAttr = {
    totalValue = critPower * 100,
    baseValue = critPower * 100
  }
  self._mapNode.goProperty[5]:SetCharProperty(AllEnum.CharAttr[5], tbAttr, false)
end

function DepotCharInfoCtrl:RefreshActorId()
  local actorIdCSList = AdventureModuleHelper.GetCurrentGroupPlayers()
  self.tbActorInfo, self.tbActorHealthInfo, self.tbElementInfo, self.tbSkillCd, self.tbEnergyEfficiency, self.tbEnergyConvRatio = {}, {}, {}, {}, {}, {}
  for i = 0, actorIdCSList.Count - 1 do
    local characterId = AdventureModuleHelper.GetCharacterId(actorIdCSList[i])
    if characterId and 0 < characterId then
      self.tbActorInfo[characterId] = AdventureModuleHelper.GetEntityInfo(actorIdCSList[i])
      self.tbActorHealthInfo[characterId] = AdventureModuleHelper.GetEntityHealthInfo(actorIdCSList[i])
      self.tbElementInfo[characterId] = AdventureModuleHelper.GetEntityElementInfo(actorIdCSList[i])
      self.tbSkillCd[characterId] = AdventureModuleHelper.GetPlayerSkillCd(actorIdCSList[i])
      self.tbEnergyEfficiency[characterId] = AdventureModuleHelper.GetPlayerAttributeValue(characterId, GameEnum.playerAttributeType.FRONT_ADD_ENERGY)
      self.tbEnergyConvRatio[characterId] = AdventureModuleHelper.GetPlayerAttributeValue(characterId, GameEnum.playerAttributeType.ADD_ENERGY)
    end
  end
end

function DepotCharInfoCtrl:RefreshInfo()
  local mapCfg = ConfigTable.GetData_Character(self.nCharId)
  local mapChar = self.mapCharData[self.nCharId]
  if mapChar ~= nil then
    self._mapNode.rtInfo:Refresh(mapChar, mapCfg)
    self:RefreshEquipment(mapChar)
  end
end

function DepotCharInfoCtrl:RefreshEquipment(mapChar)
  self.tbEquipment = clone(mapChar.tbEquipment)
  local tbSlot = PlayerData.Equipment:GetSlotCfgWithIndex()
  for i, v in ipairs(tbSlot) do
    local mapEquipment = mapChar.tbEquipmentSlot[v.nSlotId]
    local bEmpty = mapEquipment == nil
    self._mapNode.imgEquipment[i].gameObject:SetActive(not bEmpty)
    self._mapNode.goEquipment[i].gameObject:SetActive(bEmpty)
    if bEmpty then
      if mapChar.nLevel < v.nLevel then
        NovaAPI.SetTMPText(self._mapNode.txtEquipmentLock[i], orderedFormat(ConfigTable.GetUIText("Equipment_SlotActiveLevel"), v.nLevel))
      else
        NovaAPI.SetTMPText(self._mapNode.txtEquipmentLock[i], ConfigTable.GetUIText("CharEquipment_UnEquip"))
      end
    else
      delChildren(self._mapNode.imgEquipment[i])
      local equipPrefab
      local sPrefab = mapEquipment.sIcon .. ".prefab"
      if GameResourceLoader.ExistsAsset(Settings.AB_ROOT_PATH .. sPrefab) == true then
        equipPrefab = self:LoadAsset(sPrefab)
      end
      if equipPrefab then
        local goEquip = instantiate(equipPrefab, self._mapNode.imgEquipment[i])
        goEquip.transform:Find("goFx").gameObject:SetActive(mapEquipment:GetUpgradeCount() > 0)
      end
    end
  end
end

function DepotCharInfoCtrl:Clear()
end

function DepotCharInfoCtrl:Awake()
  self.nCharId = nil
  self.nSelectIndex = nil
end

function DepotCharInfoCtrl:OnEnable()
end

function DepotCharInfoCtrl:OnDisable()
end

function DepotCharInfoCtrl:OnDestroy()
end

function DepotCharInfoCtrl:OnBtnClick_Char(btn, nIndex)
  if nIndex == self.nSelectIndex then
    return
  end
  self._mapNode.goSelect[self.nSelectIndex]:SetActive(false)
  self._mapNode.goSelect[nIndex]:SetActive(true)
  self.nCharId = self.tbTeam[nIndex]
  self.nSelectIndex = nIndex
  self:SwitchChar()
end

function DepotCharInfoCtrl:OnBtnClick_Skill(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.PopupSkillPanel, self.tbTeam, false, {}, self.mapCharData, self.nCharId)
end

function DepotCharInfoCtrl:OnBtnClick_Detail()
  local HealthInfo = self.tbActorHealthInfo[self.nCharId]
  local Info = self.tbActorInfo[self.nCharId]
  local ElementInfo = self.tbElementInfo[self.nCharId]
  local SkillCd = self.tbSkillCd[self.nCharId]
  local EnergyEfficiency = self.tbEnergyEfficiency[self.nCharId]
  local EnergyConvRatio = self.tbEnergyConvRatio[self.nCharId]
  local attrList = self.attrData:GetAttrList()
  for k, v in pairs(AllEnum.CharAttr) do
    local total, base
    if v.sKey == "Hp" then
      total = HealthInfo ~= nil and HealthInfo.hpMax or 0
    elseif v.sKey == "Atk" then
      total = Info ~= nil and Info.atk:AsFloat() or 0
    elseif v.sKey == "Def" then
      total = Info ~= nil and Info.def:AsFloat() or 0
    elseif v.sKey == "CritRate" then
      total = Info ~= nil and Info.critRate:AsFloat() or 0
      total = total * 100
    elseif v.sKey == "CritPower" then
      total = Info ~= nil and Info.critPower:AsFloat() or 0
      total = total * 100
    elseif v.sKey == "Suppress" then
      total = Info ~= nil and Info.suppressRatio:AsFloat() or 0
      total = total * 100
      base = total
    elseif v.sKey == "UltraEnergy" then
      total = SkillCd and SkillCd:GetTotalEnergy() or 0
      base = total
    elseif v.sKey == "EnergyEfficiency" then
      total = EnergyEfficiency
      total = total * 100
      base = total
    elseif v.sKey == "EnergyConvRatio" then
      total = EnergyConvRatio
      total = total * 100
      base = total
    elseif v.sKey == "DefPierce" then
      total = Info ~= nil and Info.defPenetrate:AsFloat() or 0
      base = total
    elseif v.sKey == "DefIgnore" then
      total = Info ~= nil and Info.defIgnore:AsFloat() or 0
      total = total * 100
      base = total
    elseif v.sKey == "WEE" then
      total = ElementInfo ~= nil and ElementInfo.WEE:AsFloat() or 0
      total = total * 100
      base = total
    elseif v.sKey == "WEP" then
      total = ElementInfo ~= nil and ElementInfo.WEP:AsFloat() or 0
      base = total
    elseif v.sKey == "WEI" then
      total = ElementInfo ~= nil and ElementInfo.WEI:AsFloat() or 0
      total = total * 100
      base = total
    elseif v.sKey == "FEE" then
      total = ElementInfo ~= nil and ElementInfo.FEE:AsFloat() or 0
      total = total * 100
      base = total
    elseif v.sKey == "FEP" then
      total = ElementInfo ~= nil and ElementInfo.FEP:AsFloat() or 0
      base = total
    elseif v.sKey == "FEI" then
      total = ElementInfo ~= nil and ElementInfo.FEI:AsFloat() or 0
      total = total * 100
      base = total
    elseif v.sKey == "SEE" then
      total = ElementInfo ~= nil and ElementInfo.SEE:AsFloat() or 0
      total = total * 100
      base = total
    elseif v.sKey == "SEP" then
      total = ElementInfo ~= nil and ElementInfo.SEP:AsFloat() or 0
      base = total
    elseif v.sKey == "SEI" then
      total = ElementInfo ~= nil and ElementInfo.SEI:AsFloat() or 0
      total = total * 100
      base = total
    elseif v.sKey == "AEE" then
      total = ElementInfo ~= nil and ElementInfo.AEE:AsFloat() or 0
      total = total * 100
      base = total
    elseif v.sKey == "AEP" then
      total = ElementInfo ~= nil and ElementInfo.AEP:AsFloat() or 0
      base = total
    elseif v.sKey == "AEI" then
      total = ElementInfo ~= nil and ElementInfo.AEI:AsFloat() or 0
      total = total * 100
      base = total
    elseif v.sKey == "LEE" then
      total = ElementInfo ~= nil and ElementInfo.LEE:AsFloat() or 0
      total = total * 100
      base = total
    elseif v.sKey == "LEP" then
      total = ElementInfo ~= nil and ElementInfo.LEP:AsFloat() or 0
      base = total
    elseif v.sKey == "LEI" then
      total = ElementInfo ~= nil and ElementInfo.LEI:AsFloat() or 0
      total = total * 100
      base = total
    elseif v.sKey == "DEE" then
      total = ElementInfo ~= nil and ElementInfo.DEE:AsFloat() or 0
      total = total * 100
      base = total
    elseif v.sKey == "DEP" then
      total = ElementInfo ~= nil and ElementInfo.DEP:AsFloat() or 0
      base = total
    elseif v.sKey == "DEI" then
      total = ElementInfo ~= nil and ElementInfo.DEI:AsFloat() or 0
      total = total * 100
      base = total
    end
    if total then
      attrList[k].totalValue = total
    end
    if base then
      attrList[k].baseValue = base
    end
  end
  local mapCfg = ConfigTable.GetData_Character(self.nCharId)
  if not mapCfg then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.CharAttrDetail, attrList, mapCfg.EET)
end

function DepotCharInfoCtrl:OnBtnClick_Equipment(btn)
  if next(self.tbEquipment) == nil then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Equipment_CharEquipNone"))
  else
    EventManager.Hit(EventId.OpenPanel, PanelId.EquipmentAttrPreview, self.nCharId, self.tbEquipment)
  end
end

return DepotCharInfoCtrl

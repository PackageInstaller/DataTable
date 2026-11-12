local SoldierMainCharItemCtrl = class("SoldierMainCharItemCtrl", BaseCtrl)
local ImgChessRarityColor = {
  [GameEnum.ChessRarity.Gold] = "#FFF0BB",
  [GameEnum.ChessRarity.Purple] = "#C099FF",
  [GameEnum.ChessRarity.Blue] = "#8BF3FF",
  [GameEnum.ChessRarity.Green] = "#A1FF8D",
  [GameEnum.ChessRarity.White] = "#DBDBDB"
}
SoldierMainCharItemCtrl._mapNodeConfig = {
  imgSkillStart = {sComponentName = "Image"},
  AnimRoot = {sComponentName = "Animator"},
  SkillCharge = {
    sComponentName = "RectTransform"
  },
  btnItem = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Item"
  },
  imgRarity = {sComponentName = "Image"},
  imgIconSoldier = {sComponentName = "Image"},
  imgStar = {nCount = 5, sComponentName = "Image"},
  imgDeathMask = {},
  Fx_Charge = {},
  Fx_fish = {},
  Fx_Death = {},
  ItemRoot = {},
  imgEmpty = {}
}
SoldierMainCharItemCtrl._mapEventConfig = {
  SoldierCharSpawn = "OnEvent_SoldierCharSpawn"
}
SoldierMainCharItemCtrl._mapRedDotConfig = {}
local iconPath = "Icon/SoldierOtherIcon/"
local nMaxSize = 0

function SoldierMainCharItemCtrl:AddEntityEvent()
  EventManager.AddEntityEvent("Soldier_EnergyChange", self.nCharId, self, self.OnEvent_EnergyChange)
  EventManager.AddEntityEvent("Event_SoldierMoYu", self.nCharId, self, self.OnEvent_MoYu)
  EventManager.AddEntityEvent("Event_SoldierDeath", self.nCharId, self, self.Event_Death)
end

function SoldierMainCharItemCtrl:RemoveEntityEvent()
  EventManager.RemoveEntityEvent("Soldier_EnergyChange", self.nCharId, self, self.OnEvent_EnergyChange)
  EventManager.RemoveEntityEvent("Event_SoldierMoYu", self.nCharId, self, self.OnEvent_MoYu)
  EventManager.RemoveEntityEvent("Event_SoldierDeath", self.nCharId, self, self.Event_Death)
end

function SoldierMainCharItemCtrl:InitChar(mapData, tbChess, tbPartner, parent)
  self.isDeath = false
  self.isEnergyMax = false
  self._mapNode.imgSkillStart.gameObject:SetActive(false)
  self.tmpMapData = mapData
  self.bAddEvent = false
  self.nDataId = mapData.nId
  self.tbChess = tbChess
  self.tbPartner = tbPartner
  self.parent = parent
  nMaxSize = self._mapNode.SkillCharge.sizeDelta.x
  local mapCfg = ConfigTable.GetData("SoldierCharacter", self.nDataId)
  if mapCfg ~= nil then
    local sIcon = AllEnum.SoldierChessRarityIcon[mapCfg.Rarity]
    sIcon = iconPath .. sIcon .. AllEnum.SoldierChessIconSurfix.M
    self:SetPngSprite(self._mapNode.imgRarity, sIcon)
    local skinCfg = ConfigTable.GetData("SoldierSkin", mapCfg.Skin)
    if skinCfg then
      self:SetPngSprite(self._mapNode.imgIconSoldier, skinCfg.Icon .. AllEnum.SoldierChessIconSurfix.M)
    end
    local _, color = ColorUtility.TryParseHtmlString(ImgChessRarityColor[mapCfg.Rarity])
    NovaAPI.SetImageColor(self._mapNode.imgSkillStart, color)
  end
  self._mapNode.SkillCharge.sizeDelta = Vector2(nMaxSize, 0)
  for k, v in ipairs(self._mapNode.imgStar) do
    v.gameObject:SetActive(k <= mapData.nStar)
  end
  self._mapNode.ItemRoot:SetActive(false)
  self._mapNode.AnimRoot.gameObject:SetActive(true)
  self._mapNode.imgEmpty:SetActive(false)
end

function SoldierMainCharItemCtrl:SetEmpty()
  self._mapNode.AnimRoot.gameObject:SetActive(false)
  self._mapNode.imgEmpty:SetActive(true)
end

function SoldierMainCharItemCtrl:CloseUI()
  if self.nCharId and self.nCharId > 0 then
    self:RemoveEntityEvent()
  end
  self.bAddEvent = false
  self.nCharId = 0
end

function SoldierMainCharItemCtrl:Awake()
end

function SoldierMainCharItemCtrl:OnEnable()
end

function SoldierMainCharItemCtrl:OnDisable()
end

function SoldierMainCharItemCtrl:OnDestroy()
end

function SoldierMainCharItemCtrl:SetTipsRoot(tr)
  self.tipsRoot = tr
end

function SoldierMainCharItemCtrl:OnBtnClick_Item()
  if self.nCharId == nil or self.nCharId == 0 then
    return
  end
  if self.isDeath == true then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_Death_Tips"))
    return
  end
  local chessData = {
    nPositionType = GameEnum.SoldierPositionType.FightPosition,
    nId = self.tmpMapData.nId,
    nStar = math.max(self.tmpMapData.nStar, 1)
  }
  local Info = CS.AdventureModuleHelper.GetSoldierActorInfo(self.nDataId)
  local HealthInfo = CS.AdventureModuleHelper.GetSoldierHealthInfo(self.nDataId)
  local atk = Info ~= nil and Info.atk:AsFloat() or 0
  local def = Info ~= nil and Info.def:AsFloat() or 0
  local critRate = Info ~= nil and Info.critRate:AsFloat() or 0
  local critPower = Info ~= nil and Info.critPower:AsFloat() or 0
  local attackSpeed = Info ~= nil and Info.normalAttackSpd:AsFloat() or 0
  local hp = HealthInfo ~= nil and HealthInfo.hp or 0
  local hpMax = HealthInfo ~= nil and HealthInfo.hpMax or 0
  local tab = {}
  tab.atk = atk
  tab.def = def
  tab.critRate = critRate
  tab.critPower = critPower
  tab.attackSpeed = attackSpeed
  tab.hp = hp
  tab.hpMax = hpMax
  tab.nEnergy = self.nEnergy
  tab.nMaxEnergy = self.nMaxEnergy
  tab.nRecoverRate = self.nRecoverRate
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCharCardTips, self.tipsRoot, chessData, self.tbChess, self.tbPartner, tab)
  EventManager.Hit("OnSetTipsPosition", self.tipsRoot:GetChild(0).position, self.tipsRoot:GetChild(1).position, self.tipsRoot:GetChild(2).position)
end

function SoldierMainCharItemCtrl:OnEvent_EnergyChange(nEnergy, nMaxEnergy, nRecoverRate)
  local nValue = nEnergy / nMaxEnergy
  self.nEnergy = nEnergy
  self.nMaxEnergy = nMaxEnergy
  self.nRecoverRate = nRecoverRate
  if self.parent ~= nil then
    self.parent:CacheSoldierEnergyData(self.nCharId, nEnergy, nMaxEnergy, nRecoverRate, self.isDeath)
  end
  self._mapNode.SkillCharge.sizeDelta = Vector2(nMaxSize, nMaxSize * nValue)
  if self.isEnergyMax == false then
    if nEnergy == nMaxEnergy then
      self.isEnergyMax = true
      self._mapNode.imgSkillStart.gameObject:SetActive(true)
      self._mapNode.Fx_Charge:SetActive(true)
      self:AddTimer(1, 1, function()
        if self == nil or self._mapNode == nil then
          return
        end
        self._mapNode.imgSkillStart.gameObject:SetActive(false)
        self._mapNode.Fx_Charge:SetActive(false)
      end, true, true, true)
    end
  elseif nEnergy ~= nMaxEnergy then
    self.isEnergyMax = false
  end
end

function SoldierMainCharItemCtrl:OnEvent_MoYu(isMoYu)
  self._mapNode.Fx_fish:SetActive(isMoYu)
end

function SoldierMainCharItemCtrl:Event_Death()
  self.isDeath = true
  self._mapNode.imgDeathMask:SetActive(true)
  self._mapNode.Fx_Death:SetActive(true)
  self._mapNode.Fx_Charge:SetActive(false)
  self._mapNode.Fx_fish:SetActive(false)
  self._mapNode.AnimRoot:Play("SoldierMainCharItem_death")
  if self.parent ~= nil then
    self.parent:CacheSoldierEnergyData(self.nCharId, self.nEnergy, self.nMaxEnergy, self.nRecoverRate, self.isDeath)
  end
end

function SoldierMainCharItemCtrl:OnEvent_SoldierCharSpawn(nDataId, nUId)
  if nDataId == self.nDataId and not self.bAddEvent then
    self.nEnergy = 0
    self.nMaxEnergy = 0
    self.nRecoverRate = 0
    self.bAddEvent = true
    self.nCharId = nUId
    self.isDeath = false
    self.isEnergyMax = false
    self._mapNode.imgDeathMask:SetActive(false)
    self._mapNode.Fx_Death:SetActive(false)
    self._mapNode.Fx_Charge:SetActive(false)
    self._mapNode.Fx_fish:SetActive(false)
    self:AddEntityEvent()
  end
end

return SoldierMainCharItemCtrl

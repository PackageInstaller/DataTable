local base = UIBaseNode
local UINActCommonMonsterCardCardItem = class("UINActCommonMonsterCardCardItem", base)
local eActMonsterCardEnum = require("Game.ActivityFrame.ActivityMonsterCard.eActMonsterCardEnum")

function UINActCommonMonsterCardCardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_item, self, self.__OnClick)
end

function UINActCommonMonsterCardCardItem:Refresh_ACMCCI(monsterCardPlayData, cardData, onClickFunc, isSelectedUse, resloader)
  self.monsterCardPlayData = monsterCardPlayData
  self.cardData = cardData
  self.onClickFunc = onClickFunc
  self.resloader = resloader
  local isActive = cardData:AacMCD_GetType() == eActMonsterCardEnum.cardType.active
  self.ui.Img_ActiveFrame:SetActive(isActive)
  self.ui.Img_PassiveFrame:SetActive(not isActive)
  local quality = cardData:AacMCD_GetQuailty()
  local qualityColor = ItemQualityColor[quality]
  self.ui.Img_QualityFrame.color = qualityColor
  local level = cardData:AacMCD_GetLevel()
  self.ui.Tex_Level:SetIndex(0, tostring(level))
  local itemCfg = cardData:AacMCD_GetItemCfg()
  self.ui.Img_Pic.sprite = CRH:GetSpriteByItemConfig(itemCfg)
  self.ui.IsSet:SetActive(false)
  local isFake = cardData:AacMCD_GetIsFakeCard()
  self.ui.level:SetActive(not isFake)
  self.ui.unCollected:SetActive(isFake)
  if not isSelectedUse then
    self:__RefreshBlueDot()
  end
end

function UINActCommonMonsterCardCardItem:__RefreshBlueDot()
  local actFrameId = self.monsterCardPlayData:ActMCPD_GetActFrameId()
  local monCardId = self.cardData:AacMCD_GetId()
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local isHaveBlue = userDataCache:GetCommonMonsterCardIsHasBlue(actFrameId, monCardId)
  self.ui.BlueDot:SetActive(isHaveBlue)
  if isHaveBlue then
    if self.__isShowen then
      return
    end
    self.__isShowen = true
    
    local function HideTimer()
      TimerManager:StopTimer(self._timer)
      self._timer = TimerManager:StartTimer(1, function()
        if IsNull(self.gameObject) then
          return
        end
        if self.__fxGo ~= nil then
          self.__fxGo:SetActive(false)
        end
      end, self, true, false, false)
    end
    
    if self.__fxGo ~= nil then
      self.__fxGo:SetActive(true)
      HideTimer()
      return
    end
    local path = "FX/UI_effct/UI_MonsterCardItem/FXP_MonsterCardItem.prefab"
    self.resloader:LoadABAssetAsync(path, function(prefab)
      if IsNull(prefab) or IsNull(self.transform) then
        return
      end
      local go = prefab:Instantiate(self.transform)
      go:SetActive(true)
      self.__fxGo = go
      HideTimer()
    end)
  end
end

function UINActCommonMonsterCardCardItem:Set_ACMCCI_IsSelected(isSelected)
  self.ui.IsSet:SetActive(isSelected)
end

function UINActCommonMonsterCardCardItem:Get_ACMCCI_MonCardData()
  return self.cardData
end

function UINActCommonMonsterCardCardItem:Get_ACMCCI_MonCardId()
  return self.cardData:AacMCD_GetId()
end

function UINActCommonMonsterCardCardItem:__OnClick()
  if self.onClickFunc ~= nil then
    self.onClickFunc(self)
  end
  self.ui.BlueDot:SetActive(false)
end

function UINActCommonMonsterCardCardItem:OnDelete()
  TimerManager:StopTimer(self._timer)
  base.OnDelete(self)
end

return UINActCommonMonsterCardCardItem

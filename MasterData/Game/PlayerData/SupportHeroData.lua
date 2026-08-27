local SupportHeroData = class("SupportHeroData")

function SupportHeroData:ctor()
  self.cachedData = {}
  self.__isHeroDataChanged = true
  self.__cachedFixCfg = nil
  self.__OnHeroDataUpdate = BindCallback(self, self.OnHeroDataUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__OnHeroDataUpdate)
end

function SupportHeroData:SetCachedSupportData(allSupportHeroDataDic, nextRefreshTm, friendsBanData, userInfoDic, assistHeroTime)
  self.cachedData.allSupportHeroDataDic = allSupportHeroDataDic
  self.cachedData.nextRefreshTm = nextRefreshTm
  self.cachedData.friendsBanData = friendsBanData
  self.cachedData.userInfoDic = userInfoDic
  self.cachedData.assistHeroTime = assistHeroTime
end

function SupportHeroData:GetCachedSupportData()
  return self.cachedData.allSupportHeroDataDic, self.cachedData.nextRefreshTm, self.cachedData.friendsBanData, self.cachedData.userInfoDic, self.cachedData.assistHeroTime
end

function SupportHeroData:GetCurFormationLevelEffectByAllHero(HeroDatas)
  if self.__isHeroDataChanged or self.__cachedFixCfg == nil or HeroDatas ~= PlayerDataCenter.heroDic then
    local heightestLevel = {level = 1, potential = 0}
    for heroId, heroData in pairs(HeroDatas) do
      if heroData.level >= heightestLevel.level and heroData.potential >= heightestLevel.potential then
        heightestLevel.level = heroData.level
        heightestLevel.potential = heroData.potential
      end
    end
    local finalCfg
    for id, supportCfg in ipairs(ConfigData.support_fix) do
      if finalCfg == nil then
        finalCfg = supportCfg
      end
      if heightestLevel.level >= supportCfg.lv and heightestLevel.potential >= supportCfg.potential then
        finalCfg = supportCfg
      end
    end
    if HeroDatas == PlayerDataCenter.heroDic then
      self.__cachedFixCfg = finalCfg
      self.__isHeroDataChanged = false
    end
    return finalCfg
  else
    return self.__cachedFixCfg
  end
end

function SupportHeroData:OnHeroDataUpdate()
  self.__isHeroDataChanged = true
  MsgCenter:Broadcast(eMsgEventId.OnSupportHoreNeedFresh)
end

function SupportHeroData:CleanCachedSupportData()
  self.cachedData = {}
end

function SupportHeroData:Delete()
  self:CleanCachedSupportData()
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__OnHeroDataUpdate)
end

return SupportHeroData

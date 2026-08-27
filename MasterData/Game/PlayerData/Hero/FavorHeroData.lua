local FavorHeroData = class("FavorHeroData")

function FavorHeroData:ctor()
  self.__favorHeroIdDic = {}
  self.__favorHeroIdBuffDic = {}
end

function FavorHeroData:InitFavorHeroDataByMsg(msg)
  self.__favorHeroIdDic = msg
end

function FavorHeroData:UpdateFavorHeroDataByMsg(msg)
end

function FavorHeroData:IsFavorHero(heroId)
  return self.__favorHeroIdDic[heroId] and self.__favorHeroIdBuffDic[heroId] ~= false or self.__favorHeroIdBuffDic[heroId]
end

function FavorHeroData:SetIsFavorHero(heroId, bool)
  if bool then
    if not self.__favorHeroIdDic[heroId] then
      self.__favorHeroIdBuffDic[heroId] = true
    else
      self.__favorHeroIdBuffDic[heroId] = nil
    end
  elseif self.__favorHeroIdDic[heroId] then
    self.__favorHeroIdBuffDic[heroId] = false
  elseif self.__favorHeroIdBuffDic[heroId] then
    self.__favorHeroIdBuffDic[heroId] = nil
  end
end

function FavorHeroData:ApplyFavorHeroBuffDic()
  local favorList = {}
  local removeLis = {}
  for heroId, bool in pairs(self.__favorHeroIdBuffDic) do
    if bool then
      self.__favorHeroIdDic[heroId] = true
      table.insert(favorList, heroId)
    else
      self.__favorHeroIdDic[heroId] = nil
      table.insert(removeLis, heroId)
    end
  end
  if #favorList + #removeLis == 0 then
    return
  end
  local heroNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Hero)
  heroNetCtrl:CS_HERO_FAVOR(favorList, removeLis)
end

function FavorHeroData:CleanFavorHeroBuffDic()
  self.__favorHeroIdBuffDic = {}
end

return FavorHeroData

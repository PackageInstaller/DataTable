local HeroAttrChecker = class("HeroAttrChecker")

function HeroAttrChecker:ctor()
  self:__ClearCheckHeroAttriTimer()
  self.__waitForCheckHeroAttri = {}
  self.__onCheckPlayerHeroAttri = BindCallback(self, self.__CheckPlayerHeroAttri)
end

function HeroAttrChecker:DirtyPlayerHeroAttri(heroId, attriId, attriValue)
  local heroAttriDic = self.__waitForCheckHeroAttri[heroId]
  if heroAttriDic == nil then
    heroAttriDic = {}
    self.__waitForCheckHeroAttri[heroId] = heroAttriDic
  end
  heroAttriDic[attriId] = attriValue
  if self.__checkHeroAttriTimerId == nil then
    self.__checkHeroAttriTimerId = TimerManager:StartTimer(1, self.__StartCheckPlayerHeroAttri, self, true, true)
  end
end

function HeroAttrChecker:__StartCheckPlayerHeroAttri()
  self.__checkHeroAttriTimerId = nil
  local heroDic = {}
  for heroId, v in pairs(self.__waitForCheckHeroAttri) do
    heroDic[heroId] = true
  end
  local debugNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Debug)
  debugNetCtrl:CS_HERO_Debug_Attr(heroDic, self.__onCheckPlayerHeroAttri)
end

function HeroAttrChecker:__CheckPlayerHeroAttri(msg)
  for heroId, attrDic in pairs(msg.data) do
    local clientAttrDic = self.__waitForCheckHeroAttri[heroId]
    if clientAttrDic ~= nil then
      for attriId, attriValue in pairs(clientAttrDic) do
        local serverValue = attrDic.data[attriId] or 0
        if serverValue ~= attriValue then
          local msg = string.format("[Dev]角色属性不同， heroId:%s, AttrID:%s, client:%s, server:%s", heroId, attriId, attriValue, serverValue)
          local heroCfg = ConfigData.hero_data[heroId]
          local camp = heroCfg.camp
          local categoryValueDic = PlayerDataCenter.playerBonus:GetCtgrCampBuff(camp, attriId)
          for uid, value in pairs(categoryValueDic) do
            local module = uid >> 32
            local id = uid & CommonUtil.UInt32Max
            msg = msg .. string.format("\n企业加成：module:%s, id:%s, value:%s", module, id, value)
          end
          local career = heroCfg.career
          local categoryValueDic = PlayerDataCenter.playerBonus:GetCtgrCareerBuff(career, attriId)
          for uid, value in pairs(categoryValueDic) do
            local module = uid >> 32
            local id = uid & CommonUtil.UInt32Max
            msg = msg .. string.format("\n职业加成：module:%s, id:%s, value:%s", module, id, value)
          end
          local categoryValueDic = PlayerDataCenter.playerBonus:GetCtgrAllHeroBuff(attriId)
          for uid, value in pairs(categoryValueDic) do
            local module = uid >> 32
            local id = uid & CommonUtil.UInt32Max
            msg = msg .. string.format("\n所有角色加成：module:%s, id:%s, value:%s", module, id, value)
          end
          warn(msg)
        end
      end
    end
  end
  self.__waitForCheckHeroAttri = {}
  self:__ClearCheckHeroAttriTimer()
end

function HeroAttrChecker:__ClearCheckHeroAttriTimer()
  TimerManager:StopTimer(self.__checkHeroAttriTimerId)
end

return HeroAttrChecker

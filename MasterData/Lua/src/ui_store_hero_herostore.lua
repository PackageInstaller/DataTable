local this = class("heroStore", G_BaseStore)
local _charKiboTpl = L_GameTpl:getCharKiboTpl()
local _heroTpl = L_GameTpl:getHeroTpl()
this.event = {
  heroSync = "heroSync",
  heroDataSync = "heroDataSync",
  setCurHeroGuid = "setCurHeroGuid",
  refreshAttr = "refreshAttr",
  refreshCharKibo = "refreshCharKibo",
  favorLvChange = "favorLvChange"
}
this:importPartialClass(require(L_R.store .. "hero.heroState"))

function this:ctor()
  this.super.ctor(self)
end

local registeredHeroRedDots = {}

function this:clear()
  this.super.clear(self)
  self.dataState = nil
  table.clear(registeredHeroRedDots)
end

function this:rsp_syncHeroInfoes(data)
  local ownerPlayerId = C_DataUtil.GetUuid2PlayerId(data.hero_guid)
  local isLocalHero = ownerPlayerId == AzurWorld.playerMgr.myPlayerId
  if isLocalHero and not registeredHeroRedDots[data.hero_guid] then
    local emptyParentRefreshDot = AzurWorld.RedDotMgr:RegistRedDot(L_ReddotManager.DotDef.HeroHead, nil, true)
    local reddot = AzurWorld.RedDotMgr:RegistRedDot(string.format(L_ReddotManager.DotDef.HeroHead, data.hero_guid), emptyParentRefreshDot, function()
      return not L_ReddotManager:haveNew(L_ReddotManager.DotDef.HeroNew, data.hero_guid)
    end, false)
    AzurWorld.RedDotMgr:RegistRedDot(string.format(L_ReddotManager.DotDef.HeroTalentAndJewelMenu, data.hero_guid), reddot, function()
      if not data then
        return
      end
      local kvMap = L_ReddotManager:dotHeroTalentAndJewel(data.hero_guid)
      if kvMap and kvMap[data.hero_guid] and kvMap[data.hero_guid] == 1 then
        return true
      end
      return false
    end, false)
    local emptyParentInfoDot = AzurWorld.RedDotMgr:RegistRedDot(string.format(L_ReddotManager.DotDef.HeroGrade, data.hero_guid .. "_heroProperty"), reddot, nil, true)
    local gradeDot = AzurWorld.RedDotMgr:RegistRedDot(string.format(L_ReddotManager.DotDef.HeroGrade, data.hero_guid), emptyParentInfoDot, function()
      if not data then
        return
      end
      local systemId = L_SystemConst.enum.heroGrade
      local result = not C_IntegrateMgr.SystemUnlockModule:getSystemIsBan(systemId) and C_IntegrateMgr.SystemUnlockModule:Check(systemId)
      if not result then
        return
      end
      return L_ReddotManager:canHeroStarUp(data.hero_guid)
    end, false)
    local maxGrade = L_GameTpl:getGameConstTpl():getData("HERO_MAX_GRADE", L_Const.GameTplType.int)
    for i = 1, maxGrade do
      AzurWorld.RedDotMgr:RegistRedDot(string.format(L_ReddotManager.DotDef.HeroGrade, data.hero_guid .. "_" .. i), gradeDot, function()
        if not data then
          return
        end
        return L_ReddotManager:canHeroStarUp(data.hero_guid, i)
      end, false)
    end
    AzurWorld.RedDotMgr:RegistRedDot(string.format("HeroGradeTab_%s", data.hero_guid), gradeDot, function()
      if not data then
        return
      end
      local systemId = L_SystemConst.enum.heroGrade
      local result = not C_IntegrateMgr.SystemUnlockModule:getSystemIsBan(systemId) and C_IntegrateMgr.SystemUnlockModule:Check(systemId)
      if not result then
        return
      end
      return L_ReddotManager:canHeroStarUp(data.hero_guid)
    end, false)
    AzurWorld.RedDotMgr:RegistRedDot(string.format(L_ReddotManager.DotDef.HeroClothing, data.hero_guid), emptyParentInfoDot, function()
      local _heroClothingTpl = L_GameTpl:getHeroClothingTpl()
      local curHeroId = self:getHero(data.hero_guid).configId
      for k, v in pairs(_heroClothingTpl.data) do
        local heroId = _heroClothingTpl:getHero(v)
        if k ~= heroId and heroId == curHeroId and AzurWorld.RedDotMgr:HaveNew(string.format(L_ReddotManager.DotDef.HeroClothing, k)) then
          return true
        end
      end
      return false
    end, false)
    AzurWorld.RedDotMgr:RegistRedDot(string.format(L_ReddotManager.DotDef.HeroInfo, data.hero_guid), reddot, function()
      local curHeroId = self:getHero(data.hero_guid).configId
      local tableData = _charKiboTpl:getTplById(curHeroId)
      if tableData then
        local herotpl = _heroTpl:getTplById(curHeroId)
        local kiboId = _heroTpl:getKiboId(herotpl)
        if kiboId and 0 < kiboId then
          local unLockCondition = _charKiboTpl:getUnlockCondition(tableData)
          local isComp, results = L_ConditionManager:isComplete(unLockCondition)
          if isComp and tableData.getType == 1 and L_PetStore:getPetNum(kiboId) == 0 then
            return true
          end
        end
      end
      return false
    end, false)
    registeredHeroRedDots[data.hero_guid] = true
  end
  local attr = self:getHeroAttrInfo(data.hero_guid)
  if data.modules then
    for _, module in ipairs(data.modules) do
      attr:addModule(module)
    end
    attr:updateAttrMap()
  end
  self:call(self.event.refreshAttr, data.hero_guid)
end

return this

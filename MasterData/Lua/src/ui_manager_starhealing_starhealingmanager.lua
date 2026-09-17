local this = class("starHealingManager")

function this:ctor()
end

function this:initialize()
  L_UI:addListener(L_UI.pageEvent.closed, self.onUICloseEvent, self)
end

function this:dispose()
  L_UI:removeListener(L_UI.pageEvent.closed, self.onUICloseEvent, self)
end

function this:onExitBattle(args)
  if not args or args.finishType == C_EBattlerServerFinishType.ForceOut then
  end
end

function this:onUICloseEvent(pageName)
  if pageName == "pageBattleSettle" or pageName == "pageBattleReward" or pageName == "pageBattleFailed" then
  end
end

function this:checkIsCityValid()
  local worldCityTpl = L_GameTpl:getWorldCityTpl()
  local sceneId = AzurWorldInstance.CurWorldId
  if math.isEmpty(sceneId) then
    return false
  end
  local tpl = worldCityTpl:getTplById(sceneId)
  if tpl == nil then
    return false
  end
  return math.isEmpty(worldCityTpl:getCharge(tpl))
end

function this:checkHealingValid()
  local bFull = true
  local formationType = L_FormationManager:getCurFormationType()
  local posData = L_FormationStore:getFormationPosData(formationType)
  for _, heroId in pairs(posData) do
    if not math.isEmpty(heroId) then
      local maxHp = L_AttributeManager:getAttValueByHeroGuid(heroId, L_Const.battleAtt.MAXHP)
      local curHp = L_FormationStore:getFormationHeroHp(heroId)
      if maxHp > curHp then
        bFull = false
        break
      end
    end
  end
  return bFull
end

function this:getStarHealingFoods()
  local allItem = C_BagMgr:getAllItem()
  local commonItemTpl = L_GameTpl:getCommonItemTpl()
  local foodTpl = L_GameTpl:getFoodTpl()
  local all = {}
  for _, v in pairs(allItem) do
    local tpl = commonItemTpl:getTplById(v.itemId)
    if not tpl then
      errorf("commonItem表没有Id: " .. v.itemId)
    else
      local type = commonItemTpl:getType(tpl)
      local useType = commonItemTpl:getUseType(tpl)
      if type == L_BagConst.bagItemType.food and useType == L_BagConst.bagUseType.starHealing then
        local fTpl = foodTpl:getTplById(v.itemId)
        if not fTpl then
          errorf("itemId: " .. v.itemId .. " subId: " .. v.itemId .. " 在food表里面找不到")
        else
          table.insert(all, {
            itemId = v.itemId,
            itemNum = v.itemNum,
            itemType = L_Const.resType.commonItem,
            itemSubId = v.itemId,
            charge = foodTpl:getCharge(fTpl)
          })
        end
      end
    end
  end
  table.sort(all, function(a, b)
    return a.charge > b.charge
  end)
  return all
end

function this:checkTannsportRecoverValid()
  local heros = L_PlayerManager:getAllHeroCsEntity()
  if TableIsNull(heros) then
    return false
  end
  for _, hero in pairs(heros) do
    if not hero then
      return false
    end
    local curHp = hero.data.aliveProperty.luaHp
    local maxHp = hero.data.aliveProperty.luaMaxHp
    if curHp < maxHp then
      return false
    end
  end
  return true
end

return this

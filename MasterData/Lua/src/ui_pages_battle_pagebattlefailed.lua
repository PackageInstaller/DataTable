local this = class("pageBattleFailed", G_UIPageBase)
local goToConstType = {
  hero = 1,
  skill = 2,
  equip = 3,
  pet = 5
}
local transportType = {reborn = 1, gohome = 2}
local transportTxt = {
  [1] = "ui_hintFight_02"
}
local goToConstTypeSystemId = {
  [goToConstType.hero] = L_SystemConst.enum.heroStrength,
  [goToConstType.skill] = L_SystemConst.enum.skill,
  [goToConstType.equip] = L_SystemConst.enum.accessory,
  [goToConstType.pet] = L_SystemConst.enum.pet
}
local goToConstTypeImg = {
  [goToConstType.hero] = "UI/Atlas/BattleSettle/tex_battlefailed_icon_1.png",
  [goToConstType.skill] = "UI/Atlas/BattleSettle/tex_battlefailed_icon_2.png",
  [goToConstType.equip] = "UI/Atlas/BattleSettle/tex_battlefailed_icon_3.png",
  [goToConstType.pet] = "UI/Atlas/BattleSettle/tex_battlefailed_icon_5.png"
}
local goToConstTypeTip = {
  [goToConstType.hero] = "battleFailed_heroTip",
  [goToConstType.skill] = "battleFailed_skillTip",
  [goToConstType.equip] = "battleFailed_equipTip",
  [goToConstType.pet] = "battleFailed_petTip"
}

function this.bind()
  return {
    listFailed = {
      moduleName = "pages/battle/cellBattleFailed"
    },
    show_btnReborn = true,
    transportNearTxt = L_WordsTpl:getValue(transportTxt[1])
  }
end

function this.methods()
  return {
    listFailed = {
      onClick_failed = function(self, index)
        self:onClick_failed(index)
      end
    },
    onClick_reborn = function(self)
      self:onClick_transPort(transportType.reborn)
    end
  }
end

function this:created(obj, config)
  this.super.created(self, obj, config)
end

function this:preOpen(options)
  C_AudioManager.Play("Play_SFX_System_Dungeon_Info_Loose")
  this.super.preOpen(self, options)
  if options then
    self.callback = options.callBack
  end
  local homeSystemId = L_SystemConst.enum.home
  local isOpenHome = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(homeSystemId)
  if isOpenHome and not AzurWorld.DungeonMgr:CheckIsDungeonScene() then
    self.bind.show_btnGohome = true
  else
    self.bind.show_btnGohome = false
  end
  self.bind.transportNearTxt = AzurWorld.DungeonMgr:CheckIsDungeonScene() == true and transportTxt[2] or L_WordsTpl:getValue(transportTxt[1])
  self:switchLockState("pageBattleFailed", true)
end

function this:open()
  local list = {}
  for i, v in pairs(goToConstType) do
    if C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(goToConstTypeSystemId[v]) then
      table.insert(list, {
        indexType = v,
        img_icon = goToConstTypeImg[v],
        txt_tip = L_WordsTpl:getValue(goToConstTypeTip[v])
      })
    end
  end
  table.sort(list, function(a, b)
    return a.indexType < b.indexType
  end)
  self.bind.listFailed:insert_array(list)
end

function this:show()
end

function this:close(options)
  this.super.close(self, options)
  self:switchLockState("pageBattleFailed", false)
  self:checkCallBack()
end

function this:switchLockState(pageName, isShow)
  C_UIMgr.uiListenerMiddleware:ControlInputMapLock(pageName, isShow)
end

function this:onClick_failed(index)
  L_UI:close(self.pageName)
  local fType = L_FormationManager:getCurFormationType()
  local posData = L_FormationStore:getFormationPosData(fType)
  local heroId = posData[1]
  if index == goToConstType.hero then
    L_SystemBreakManager.jumpToPageHero(L_SystemConst.enum.heroStrength, {heroId = heroId})
  elseif index == goToConstType.skill then
    L_SystemBreakManager.jumpToPageHero(L_SystemConst.enum.skill, {heroId = heroId})
  elseif index == goToConstType.soulEssence then
    L_SystemBreakManager.jumpToPageHero(L_SystemConst.enum.soulEssence, {heroId = heroId})
  elseif index == goToConstType.equip then
    L_SystemBreakManager.jumpToPageHero(L_SystemConst.enum.accessory, {heroId = heroId})
  elseif index == goToConstType.pet then
    L_SystemBreakManager:jumpTo(L_SystemConst.enum.pet)
  end
end

function this:onClick_transPort(index)
  L_UI:close(self.pageName)
  if index == transportType.reborn then
    AzurWorld.playerMgr.myPlayerUnitAdapter:RevivePlayerUnit()
  end
end

function this:escHandle()
end

function this:checkCallBack()
  if self.callback ~= nil then
    self.callback()
    self.callback = nil
  end
end

return this

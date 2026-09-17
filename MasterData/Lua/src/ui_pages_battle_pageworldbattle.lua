local page = class("pageWorldBattle", G_UIPageBase)

function page.bind()
  return {
    module_hero = {
      moduleName = "pages/main/moduleMainPlayer"
    },
    module_battleControl = {
      type = "toggleModule",
      mobile = {
        assetName = "UI/Pages/BattlePage/moduleSkillControl",
        moduleName = "pages/battle/moduleBattleControl"
      },
      pc = {
        assetName = "UI/Pages/BattlePage/moduleSkillControlPc",
        moduleName = "pages/battle/moduleBattleControl"
      }
    },
    module_battleControlName = "",
    module_moveBlock = {
      type = "toggleModule",
      content = {
        assetName = "UI/CommonModules/moduleMovementBlock",
        moduleName = "modulePages/moduleMovementBlock"
      }
    },
    module_moveBlockName = "",
    moduleBattleEnergy = {
      moduleName = "pages/battle/moduleBattleEnergy"
    },
    modulePlayerHp = {
      moduleName = "pages/battle/modulePlayerHp"
    },
    moduleBossHpList = {
      type = "toggleModule",
      content = {
        assetName = "UI/Pages/BattlePage/moduleBossHpList",
        moduleName = "pages/battle/moduleBossHpList"
      }
    },
    moduleBossHpListName = "",
    modulePetSkill = {
      type = "toggleModule",
      content = {
        assetName = "UI/Pages/BattlePage/modulePetSkill",
        moduleName = "pages/battle/modulePetSkill"
      }
    },
    modulePetSkillName = "content",
    module_battleDialog = {
      type = "toggleModule",
      content = {
        assetName = "UI/Pages/BattlePage/moduleBattleDialog",
        moduleName = "pages/battle/moduleBattleDialog"
      }
    },
    module_battleDialogName = "content",
    module_battleCombo = {
      type = "toggleModule",
      content = {
        assetName = "UI/Pages/BattlePage/moduleBattleCombo",
        moduleName = "pages/battle/moduleBattleCombo"
      }
    },
    module_battleComboName = "content",
    module_battleEffect = {
      type = "toggleModule",
      content = {
        assetName = "UI/Pages/BattlePage/moduleBattleEffect",
        moduleName = "pages/battle/moduleBattleEffect"
      }
    },
    module_battleEffectName = "",
    moduleIndicator = {
      type = "toggleModule",
      content = {
        assetName = "UI/Pages/BattlePage/moduleIndicator",
        moduleName = "pages/main/moduleIndicator"
      }
    },
    moduleIndicatortName = "content",
    moduleLeaveWall = {
      type = "toggleModule",
      content = {
        assetName = "UI/Pages/BattlePage/moduleBattleLeaveWall",
        moduleName = "pages/main/moduleLeaveWall"
      }
    },
    moduleLeaveWallName = "",
    module_mount = {
      type = "toggleModule",
      content = {
        assetName = "UI/Pages/Main/moduleMount",
        moduleName = "pages/Main/moduleMount"
      }
    },
    module_mountName = "content",
    module_battleLimitTime = {
      type = "toggleModule",
      content = {
        assetName = "UI/Pages/BattlePage/moduleBattleLimitTime",
        moduleName = "pages/battle/moduleBattleLimitTime"
      }
    },
    module_battleLimitTimeName = "content",
    activeCloseBtn = false
  }
end

function page.methods()
  return {
    onClose = function(self)
      self:onClick_close()
    end
  }
end

function page:created(...)
  page.super.created(self, ...)
  self:createBattle()
end

function page:preOpen()
  if L_DeviceTpl:getIsPc() then
    self.bind.module_battleControlName = "pc"
  else
    self.bind.module_battleControlName = "mobile"
  end
  self.modules.module_hero:refreshFormation()
  self.enterHeroDic = nil
  self.bind.module_battleEffectName = "content"
  self.bind.module_moveBlockName = "content"
  self.modules.module_moveBlock.content:setDefalutHide()
  self.bind.moduleLeaveWallName = "content"
end

function page:open(options)
  page.super.open(self, options)
  self:isInterimBattle(options)
end

function page:show()
  L_ShortCutManager:registerShortCutMapList(self.pageName, {
    C_InputManager_KeyType.EMainSwitchHero1,
    C_InputManager_KeyType.EMainSwitchHero2,
    C_InputManager_KeyType.EMainSwitchHero3,
    C_InputManager_KeyType.EMainCallMount,
    C_InputManager_KeyType.EMainMountFly
  })
end

function page:hide()
  self.modules.module_battleEffect.content:hideEffect()
end

function page:escHandle()
end

function page:createBattle()
  L_BattleDataManager:addListener(L_BattleDataManager.event.battleFinished, self.onEvent_battleFinish, self)
  L_BattleManager:addListener(L_BattleManager.event.battleStart, self.onEvent_battleStart, self)
end

function page:isInterimBattle(options)
  if options == nil then
    return
  end
  self.callBack = options.callBack
  self.isInterim = options.isInterim
end

function page:onEvent_battleStart()
  self.bind.moduleBossHpListName = "content"
  self.modules.moduleBossHpList.content:initBoss()
end

function page:removeListener()
  L_BattleDataManager:removeListener(L_BattleDataManager.event.battleFinished, self.onEvent_battleFinish, self)
  L_BattleManager:removeListener(L_BattleManager.event.battleStart, self.onEvent_battleStart, self)
end

function page:close()
  self:removeListener()
  if self.isDoSendExitBattle == nil then
  end
end

function page:onClick_stop()
end

function page:closeOutBattle()
  self:removeListener()
  C_BattleManager.ForceOutBattle()
  self:onGameOver()
end

function page:onEvent_battleFinish(args)
  self.isDoOnEvent_battleFinish = true
  self:onGameOver()
end

function page:onGameOver()
  self:removeListener()
  self.modules.modulePlayerHp:close()
end

function page:update()
  self.modules.moduleIndicator.content:update()
end

function page:getGroupInfo()
  local infoList = {}
  local curHeroDic = L_PlayerManager:getAllHeroCsEntity()
  for i, v in pairs(self.enterHeroDic) do
    local info = {}
    info.hero_id = v.id
    if curHeroDic[i] == nil then
      info.hp = 0
      info.sp = 0
    else
      local csEntity = curHeroDic[i]
      info.hp = csEntity.data.aliveProperty.luaHp
      info.sp = csEntity.data.aliveProperty.luaSp
    end
    table.insert(infoList, info)
  end
  return infoList
end

function page:onClick_close()
  local main = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  if main and main.state:GetCurrentStateType() == L_Const.fsmType.skill then
    local skillProperty = main.data.skillProperty
    local skillUltimate = skillProperty:GetSkillBySlot(L_Const.C_ESkillSlotType.UltraSkill)
    if main.data.skillSyncInfo.curSkillId == skillUltimate.id then
      return
    end
  end
  local entry = L_BattleStore:getBattleEntry()
  if entry == L_Const.battleEntry.tower then
    L_GameUtil.showCommonTip({
      txtTitle = L_WordsTpl:getValue(L_TowerConst.text.notify_title),
      txtContent = L_WordsTpl:getValue(L_TowerConst.text.quit_battle_tips),
      confirmCallback = function()
        L_SystemBreakManager:jumpTo(L_SystemConst.enum.climbTower)
        self:closeOutBattle()
      end
    })
  else
    L_GameUtil.showCommonTip({
      txtTitle = L_WordsTpl:getValue("ui_hintFight_03"),
      txtContent = L_WordsTpl:getValue("ui_hintFight_04"),
      confirmCallback = function()
        self:closeOutBattle()
      end
    })
  end
end

return page

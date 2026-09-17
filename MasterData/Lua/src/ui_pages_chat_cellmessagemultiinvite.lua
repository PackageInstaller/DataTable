local this = class("cellMessageMultiInvite", G_UIModuleBase)
local nestSystemID = 2001
local MultiMaterialType = 7
local MultiWeeklyType = 8
local str = "cellMessage"

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {photoEntity = nil}
end

function this.bind()
  return {
    moduleBaseInfo = {
      moduleName = "pages/chat/moduleChatBaseInfo"
    },
    txt_message = "",
    go_invite = true,
    txt_multi_level = "",
    txt_multi_title = "",
    img_mask = false,
    go_invite_rdy = false,
    img_hero = "",
    txt_petName = "",
    go_hero = true
  }
end

function this.methods()
  return {
    moduleBaseInfo = {
      onClick_head = function(self)
        if L_PlayerStore:getPlayerId() == self.bind.playerUid then
          return
        end
        self:emit("onClick_head", self.bind.playerUid)
      end
    },
    onClick_head = function(self)
      if L_PlayerStore:getPlayerId() == self.bind.playerUid then
        return
      end
      self:emit("onClick_head", self.bind.playerUid)
    end,
    onClick_invite = function(self)
      if self.bind.type == 5 then
        local ret = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.multiTeamDungeon)
        if ret == false then
          return
        end
        if C_MultiTeam.IsExitTimer(self.tiemrName) then
          return
        end
        local isComplete, results, lockIndex = L_ConditionManager:isComplete(self.unLock)
        if not isComplete then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_dungeon_lock_level", {
            [0] = self.unLock[1][2]
          }))
          return
        end
      elseif self.bind.type == 6 then
        local ret = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.NestCoop)
        if ret == false then
          return
        end
        if C_MultiTeam.IsExitTimer(self.tiemrName) then
          return
        end
        if AzurWorld.proxyCenter.curProxy.proxyType == C_EWorldType.HomeDorm or AzurWorld.proxyCenter.curProxy.proxyType == C_EWorldType.Home then
          local str = L_WordsTpl:getValue("notice_cannot_goscene")
          L_FlyMsgManager:showNormalMsg(str)
          return
        end
        if C_NestCoopMgr:NeedGuide() then
          C_NestCoopMgr:ShowGuideTip()
          return
        end
      elseif self.bind.type == MultiMaterialType then
        local ret = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.DungeonMaterial)
        if ret == false then
          return
        end
        if not C_MultiTeamMgr:CheckDungeonMaterialUnlock(self.bind.configId, true) then
          return
        end
        if AzurWorld.proxyCenter.curProxy.proxyType == C_EWorldType.HomeDorm or AzurWorld.proxyCenter.curProxy.proxyType == C_EWorldType.Home then
          local str = L_WordsTpl:getValue("notice_cannot_goscene")
          L_FlyMsgManager:showNormalMsg(str)
          return
        end
      elseif self.bind.type == MultiWeeklyType then
        local ret = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.DungeonWeekly)
        if ret == false then
          return
        end
        if not C_MultiTeamMgr:CheckDungeonWeeklyUnlock(self.bind.configId, true) then
          return
        end
        if AzurWorld.proxyCenter.curProxy.proxyType == C_EWorldType.HomeDorm or AzurWorld.proxyCenter.curProxy.proxyType == C_EWorldType.Home then
          local str = L_WordsTpl:getValue("notice_cannot_goscene")
          L_FlyMsgManager:showNormalMsg(str)
          return
        end
      end
      C_MultiTeam.StartTimer(self.tiemrName, 30, function()
        self:SetMaskState(false)
      end, 1, 0, true, false)
      C_MultiTeam.AddSelfRemoveTimer(self.tiemrName)
      self:SetMaskState(true)
      print("cellMessageMultiInvite:onClick_invite")
      if self.bind.type == MultiMaterialType or self.bind.type == MultiWeeklyType then
        local campType = self.bind.campType or 0
        C_MultiTeamMgr:req_ApplyEnterTeam(self.bind.teamId, campType, self.bind.configId)
      else
        C_MultiTeam.EnterTeam(tonumber(self.bind.teamId))
      end
    end
  }
end

function this:refresh()
  self.bind.go_invite = false
  self.bind.go_invite_rdy = false
  if string.isEmpty(self.bind.player_name) then
    return
  end
  local infoModule = self.modules.moduleBaseInfo
  if infoModule then
    infoModule.bind.uid = self.bind.playerUid
    infoModule.bind.txt_name = self.bind.txt_name
    infoModule.bind.txt_title = self.bind.txt_title
    infoModule.bind.img_headFrame = self.bind.icon_frame
    infoModule.bind.txt_level = self.bind.txt_level
    infoModule:initShow()
  end
  if self.bind.type == 5 then
    self.bind.txt_message = string.format("%s%s", self.bind.player_name, L_WordsTpl:getValue("residual_code_cellmessagemultiinvite_01"))
    local dungeonId = self.bind.multi_level
    local all_list = L_GameTpl:getDungeonCrisisCrusadeTpl():getData()
    local levelId = 0
    for i, v in pairs(all_list) do
      if v.dungeonId == dungeonId then
        levelId = v.id
        break
      end
    end
    local tpl = L_GameTpl:getDungeonCrisisCrusadeTpl():getTplById(levelId)
    self.unLock = L_GameTpl:getDungeonCrisisCrusadeTpl():getTaskUnlock(tpl)
    self.recmmondLevel = L_GameTpl:getDungeonCrisisCrusadeTpl():getRecommendLevel(tpl)
    self.bind.txt_multi_level = string.format("%s%s", L_WordsTpl:getValue("residual_code_cellmessagemultiinvite_02"), L_GameTpl:getDungeonCrisisCrusadeTpl():getRecommendLevel(tpl))
    self.bind.txt_multi_title = L_GameTpl:getDungeonCrisisCrusadeTpl():getName(tpl)
    self:getDungeonEnemyBoss(dungeonId)
    local _enemyTpl = L_GameTpl:getEnemyTpl()
    local enemyData = self:getDungeonEnemyBoss(dungeonId)
    if enemyData then
      local enemyCfg = _enemyTpl:getTplById(enemyData)
      if enemyCfg then
        self.bind.img_hero = _enemyTpl:getAvatarTexture(enemyCfg)
      end
    end
  elseif self.bind.type == 6 then
    local nest_tpl = L_GameTpl:getNestcoopLevelTpl()
    local nest_site = L_GameTpl:getNestcoopSiteTpl()
    local tpl = nest_tpl:getTplById(self.bind.multi_level)
    local info = C_NestCoopStore.TryGetSiteDataByLevelLua(self.bind.multi_level)
    local _systemUnlock = L_GameTpl:getSystemUnlockTpl()
    local sysTpl = _systemUnlock:getTplById(nestSystemID)
    self.bind.txt_multi_title = _systemUnlock:getName(sysTpl)
    self.bind.txt_multi_level = "LV." .. nest_tpl:getRecommendLv(tpl)
    local _enemyTpl = L_GameTpl:getEnemyTpl()
    local enemyId = nest_tpl:getEnemyID(tpl)
    if enemyId then
      local enemyCfg = _enemyTpl:getTplById(enemyId)
      if enemyCfg then
        self.bind.img_hero = _enemyTpl:getAvatarTexture(enemyCfg)
        self.bind.txt_petName = _enemyTpl:getName(enemyCfg)
      end
    end
  elseif self.bind.type == MultiMaterialType then
    self:refreshMultipleTeam()
  elseif self.bind.type == MultiWeeklyType then
    self:refreshMultiWeeklyType()
  end
  if self.bind.type ~= MultiMaterialType and self.bind.type ~= MultiWeeklyType then
    local timerSuffix = self.bind.index
    self.tiemrName = str .. timerSuffix
    if C_MultiTeam.IsExitTimer(self.tiemrName) then
      self:SetMaskState(true)
      C_MultiTeam.StartExitTimer(self.tiemrName, function()
        self:SetMaskState(false)
      end)
    else
      self:SetMaskState(false)
    end
  else
    self.tiemrName = str .. self.bind.player_name .. self.bind.teamId .. self.bind.index
    if C_MultiTeam.IsExitTimer(self.tiemrName) then
      self:SetMaskState(true)
      C_MultiTeam.StartExitTimer(self.tiemrName, function()
        self:SetMaskState(false)
      end)
    else
      self:SetMaskState(false)
    end
  end
  if self.playInitFXNextRefresh then
    self:playInitFX()
  elseif self.bindComponents and self.bindComponents.anim_messageBox then
    self.bindComponents.anim_messageBox:Play("anim_chatpanel_message_content_reset")
  end
end

function this:SetMaskState(bShowMask)
  self.bind.img_mask = bShowMask
  if not self.bind.is_sender then
    self.bind.go_invite_rdy = bShowMask
    self.bind.go_invite = not bShowMask
  end
end

function this:getDungeonEnemyBoss(dungeonId)
  local _dungeonTpl = L_GameTpl:getDungeonTpl()
  local _enemyTpl = L_GameTpl:getEnemyTpl()
  local cfg = _dungeonTpl:getTplById(dungeonId)
  local enemyList = _dungeonTpl:getEnemy(cfg)
  local infos = {}
  for i, v in ipairs(enemyList) do
    local id, level = table.unpack(v)
    table.insert(infos, id)
  end
  table.sort(infos, function(a, b)
    local tplA = _enemyTpl:getTplById(a)
    local tplB = _enemyTpl:getTplById(b)
    if tplA and tplB then
      return tplA.enemyType < tplB.enemyType
    else
      return false
    end
  end)
  return infos[1]
end

function this:unBind()
  self:stopFX()
  if self.tiemrName then
    C_MultiTeam.RemoveTimerCallBack(self.tiemrName)
  end
end

function this:close()
  if self.tiemrName then
    C_MultiTeam.RemoveTimerCallBack(self.tiemrName)
  end
end

this.playInitFXNextRefresh = false

function this:playInitFX()
  print("playInitFX \n" .. debug.traceback())
  self.playInitFXNextRefresh = false
  if self.bindComponents and self.bindComponents.ani_cellMessage then
    local result = self.bindComponents.ani_cellMessage:Play()
  else
    self.playInitFXNextRefresh = true
  end
  if self.bindComponents and self.bindComponents.anim_messageBox then
    self.bindComponents.anim_messageBox:Play("anim_chatpanel_message_content_in")
  end
end

function this:stopFX()
  self.playInitFXNextRefresh = false
  print("stopFX \n" .. debug.traceback())
end

function this:refreshMultipleTeam()
  local _dungeonMaterialTpl = L_GameTpl:getDungeonMaterialTpl()
  local tpl = _dungeonMaterialTpl:getTplById(self.bind.configId)
  if tpl ~= nil then
    local dungeonName = _dungeonMaterialTpl:getName(tpl)
    local _dungeonMaterialDiffTpl = L_GameTpl:getDungeonMaterialDiffTpl()
    local diff = _dungeonMaterialTpl:getDiff(tpl)
    local diffTpl = _dungeonMaterialDiffTpl:getTplById(diff)
    local diffName = _dungeonMaterialDiffTpl:getDiffName(diffTpl)
    local diffWords = L_WordsTpl:getValue("ui_dungeon_material_diff_name")
    self.bind.txt_petName = string.format("%s%s%s", dungeonName, diffWords, diffName)
    self.bind.txt_multi_level = string.format("LV.%d", _dungeonMaterialTpl:getRecommendLevel(tpl))
    local pic = _dungeonMaterialTpl:getRecruitPic(tpl)
    if string.isEmpty(pic) then
      self.bind.go_hero = false
    else
      self.bind.go_hero = true
      self.bind.img_hero = _dungeonMaterialTpl:getRecruitPic(tpl)
    end
  end
  local _systemUnlock = L_GameTpl:getSystemUnlockTpl()
  local sysTpl = _systemUnlock:getTplById(L_SystemConst.enum.DungeonMaterial)
  if sysTpl ~= nil then
    self.bind.txt_multi_title = _systemUnlock:getName(sysTpl)
  end
end

function this:refreshMultiWeeklyType()
  local _dungeonWeeklyTpl = L_GameTpl:getdungeonWeeklyTpl()
  local tpl = _dungeonWeeklyTpl:getTplById(self.bind.configId)
  if tpl ~= nil then
    local dungeonName = L_Config:provider(tpl.name)
    local _dungeonMaterialDiffTpl = L_GameTpl:getDungeonMaterialDiffTpl()
    local diff = tpl.difficulty
    local diffTpl = _dungeonMaterialDiffTpl:getTplById(diff)
    local diffName = _dungeonMaterialDiffTpl:getDiffName(diffTpl)
    local diffWords = L_WordsTpl:getValue("ui_dungeon_material_diff_name")
    self.bind.txt_petName = string.format("%s%s%s", dungeonName, diffWords, diffName)
    self.bind.txt_multi_level = string.format("LV.%s", L_Config:provider(tpl.recommendedlevel))
    self.bind.img_hero = tpl.recruitPic
  end
  local _systemUnlock = L_GameTpl:getSystemUnlockTpl()
  local sysTpl = _systemUnlock:getTplById(L_SystemConst.enum.DungeonWeekly)
  if sysTpl ~= nil then
    self.bind.txt_multi_title = _systemUnlock:getName(sysTpl)
  end
end

return this

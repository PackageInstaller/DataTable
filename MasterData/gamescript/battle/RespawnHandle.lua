local RespawnHandle = System.NewClass("RespawnHandle")

function RespawnHandle:ctor(battleRender)
  self.battleRender = battleRender
  self.respawnQueue = nil
  self.hasUsedFreeRevivalThisBattle = false
end

function RespawnHandle:Dispose()
  if self.respawnQueue then
    self.respawnQueue:OnDestroy()
    self.respawnQueue = nil
  end
  self.battleRender = nil
end

function RespawnHandle:OnResRespawnConfirm(data)
  if bg.isReplay then
    self:PlayReplayRespawnAnimation()
    return
  end
  if data.reason == bc.ConfirmReason.BoutLimit then
    BattleBackTrackUtils.ShowFailTips(function()
      self.battleRender:OnReqRespawn(data.effectUid, false)
    end, function()
      self.battleRender:OnReqRespawn(data.effectUid, false, true)
    end, nil, data.reason)
    return
  end
  local stageData = WorldStageManager.Instance:GetCurStageData()
  if not stageData then
    self:ShowPullBackOrRestartTips(data.effectUid)
    return
  end
  local stageCfg = DT.Stage[stageData.stageId]
  if not stageCfg or 0 == stageCfg.RevivalAllowed then
    self:ShowPullBackOrRestartTips(data.effectUid)
    return
  end
  self:PlayRespawnEffect(data)
end

function RespawnHandle:PlayReplayRespawnAnimation()
  local playerRole = bg.battleScene:GetPlayerRole()
  if not playerRole then
    return
  end
  local skillName = require("Data.ItemDataUtils").GetReviveItemName()
  playerRole:PlayKeeperSkillTimeline(CommonDefine.Player_Respawn_Timeline, skillName)
  local timeLineData = DT.TimelineEventData[CommonDefine.Player_Respawn_TLKey] or {}
  local castTimeCfg = timeLineData[CommonDefine.Player_Respawn_TLSkillKey] or {}
  if castTimeCfg.castTime then
    self.battleRender:PerformWithDelay(castTimeCfg.castTime / self.battleRender.gameSpeed, function()
      EventMgr.Instance.BattleReviveAnim:Dispatch()
    end, self.battleRender)
  end
end

function RespawnHandle:ShowPullBackOrRestartTips(effectUid)
  if self.respawnQueue then
    self.respawnQueue:OnDestroy()
    self.respawnQueue = nil
  end
  BattleBackTrackUtils.ShowFailTips(function()
    self.battleRender:OnReqRespawn(effectUid, false)
  end, function()
    BattleBackTrackUtils.RestartBattle()
  end)
end

function RespawnHandle:PlayRespawnEffect(data)
  if self.respawnQueue then
    self.respawnQueue:OnDestroy()
  end
  local isBoughtRespawn = false
  local queue = require("Managers.Queue.Z1Queue")()
  self.respawnQueue = queue
  AudioManager.Instance:PostSoundEvent("Play_UI_Ft_Anim_Player_KO")
  queue:Insert("RespawnIn", function()
    UIManager.Instance:Reopen(Urls.TimelineVideoUIAdd, "Vx/DeadResistance_In_Rgb.mp4", "Vx/DeadResistance_In_Alpha.mp4", false, function()
      queue:Next()
    end, 1.33)
  end)
  queue:Insert("BuyRespawn", function()
    local stageData = WorldStageManager.Instance:GetCurStageData()
    local cost = AbyssDataUtils.GetStageRespawnCostByStageTid(stageData and stageData.stageId)
    local revivalItemId = DT.GetConstant("RevivalItemId")
    local ownedLives = math.max((data.lives or 1) - 1, 0)
    if cost > ownedLives then
      local needBuyCount = cost - ownedLives
      local shopCfg = ShopCfgUtils.GetExchangeShopCfg(revivalItemId) or {}
      local shopItemData = MainShopDataUtils.GetShopDataByTid(shopCfg.ID)
      local remainBuyCount = MainShopDataUtils.GetGoodRemaining(shopItemData) or 0
      if MainShopDataUtils.IsInitData() and cost > ownedLives + remainBuyCount then
        queue:OnDestroy()
        self.respawnQueue = nil
        self:ShowPullBackOrRestartTips(data.effectUid)
        return
      end
      local viewData = {
        needBuyCount = needBuyCount,
        confirmFunc = function()
          isBoughtRespawn = true
          self.battleRender:OnReqRespawn(data.effectUid, true)
          queue:Next()
        end,
        cancelFunc = function()
          queue:OnDestroy()
          self.respawnQueue = nil
          self:ShowPullBackOrRestartTips(data.effectUid)
        end
      }
      BattleBackTrackUtils.OpenRebirthChargeView(viewData)
    else
      queue:Next()
    end
  end)
  queue:Insert("RespawnTip", function()
    local stageData = WorldStageManager.Instance:GetCurStageData()
    if isBoughtRespawn or not stageData then
      queue:Next()
      return
    end
    local stageCfg = DT.Stage[stageData.stageId]
    if not stageCfg.RevivalAllowed or 1 == stageCfg.RevivalAllowed then
      local function showRevivalComfirm()
        local isAbyss = AbyssDataUtils.IsAbyssStageTid(stageData.stageId)
        
        local tipsId = 20079
        if isAbyss then
          tipsId = "AbyssChallengeRevivalTips"
        elseif self.battleRender.isIntro then
          tipsId = 20080
        end
        local DT = bg.DT
        local cfg = DT.TipsType[tipsId]
        local maxNum = DT.Constant.RevivalItemNumLimit.Data[1]
        local cost = AbyssDataUtils.GetStageRespawnCostByStageTid(stageData.stageId)
        local detail
        if isAbyss then
          detail = LT.Textf(cfg.Desc, cost)
        else
          detail = LT.Textf(cfg.Desc, math.max(self.battleRender.lives - 1, 0), maxNum)
        end
        Alert.Show(tipsId, function()
          queue:OnDestroy()
          self.respawnQueue = nil
          BattleBackTrackUtils.ShowFailTips(function()
            self.battleRender:OnReqRespawn(data.effectUid, false)
          end, function()
            self.battleRender:OnReqRespawn(data.effectUid, false, true)
          end)
        end, function()
          self.battleRender:OnReqRespawn(data.effectUid, true)
          queue:Next()
        end, nil, detail, nil, nil, nil, true)
      end
      
      if 0 == PlayerDataUtils.GetRevivalItemUseNum() and not self.hasUsedFreeRevivalThisBattle then
        self.hasUsedFreeRevivalThisBattle = true
      end
      showRevivalComfirm()
    else
      self.battleRender:OnReqRespawn(data.effectUid, false)
      queue:OnDestroy()
      self.respawnQueue = nil
    end
  end)
  queue:Insert("ShowRespawn", function()
    local playerRole = bg.battleScene:GetPlayerRole()
    if not playerRole then
      queue:Next()
    else
      local skillName = require("Data.ItemDataUtils").GetReviveItemName()
      playerRole:PlayKeeperSkillTimeline(CommonDefine.Player_Respawn_Timeline, skillName, function()
        queue:Next()
      end)
      local timeLineData = DT.TimelineEventData[CommonDefine.Player_Respawn_TLKey] or {}
      local castTimeCfg = timeLineData[CommonDefine.Player_Respawn_TLSkillKey] or {}
      if castTimeCfg.castTime then
        self.battleRender:PerformWithDelay(castTimeCfg.castTime / self.battleRender.gameSpeed, function()
          EventMgr.Instance.BattleReviveAnim:Dispatch()
        end, self.battleRender)
      end
    end
  end)
  queue:Insert("RespawnEnd", function()
    queue:OnDestroy()
    self.respawnQueue = nil
  end)
end

return RespawnHandle

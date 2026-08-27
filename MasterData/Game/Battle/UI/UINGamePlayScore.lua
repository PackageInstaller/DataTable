local UINGamePlayScore = class("UINGamePlayScore", UIBaseNode)
local base = UIBaseNode
local CS_DOTween = CS.DG.Tweening.DOTween
local GamePlayScoreType = {
  Number = 1,
  Timer = 2,
  Collect = 3,
  CustomCollect = 4
}

function UINGamePlayScore:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._defTimeColor = self.ui.img_timerNode.color
  self.listScoreNode = {}
  self.listScoreNode[GamePlayScoreType.Number] = self.ui.damageNode
  self.listScoreNode[GamePlayScoreType.Timer] = self.ui.timerNode
  self.listScoreNode[GamePlayScoreType.Collect] = self.ui.collect
  self.listScoreNode[GamePlayScoreType.CustomCollect] = self.ui.collect
  self.listScoreFunc = {}
  self.listScoreFunc[GamePlayScoreType.Number] = self.__BattleScoreNumber
  self.listScoreFunc[GamePlayScoreType.Timer] = self.__BattleScoreTimer
  self.listScoreFunc[GamePlayScoreType.Collect] = self.__BattleCollect
  self.listScoreFunc[GamePlayScoreType.CustomCollect] = self.__BattleCollect
  self.listInitFunc = {}
  self.listInitFunc[GamePlayScoreType.Collect] = self.__InitShowCollect
  self.listInitFunc[GamePlayScoreType.CustomCollect] = self.__InitShowCustomCollect
  self.__ChangeBattleScoreActive = BindCallback(self, self.ChangeBattleScoreActive)
  self.__ChangeBattleScoreValue = BindCallback(self, self.ChangeBattleScoreValue)
  MsgCenter:AddListener(eMsgEventId.ChangeBattleScoreActive, self.__ChangeBattleScoreActive)
  MsgCenter:AddListener(eMsgEventId.ChangeBattleScoreValue, self.__ChangeBattleScoreValue)
  if BattleDungeonManager.dunInterfaceData ~= nil and BattleDungeonManager.dunInterfaceData:GetIsListen2OverKill() then
    self.__onOverKillValueChange = BindCallback(self, self.__OnOverKillValueChange)
    MsgCenter:AddListener(eMsgEventId.OnOverKillValueChange, self.__onOverKillValueChange)
  end
  self:_InitSequcenceFactory()
end

function UINGamePlayScore:SetGamePlayScoreResloader(resloader)
  self.resloader = resloader
end

function UINGamePlayScore:StartBattleRacingShow(battleCtrl, lastFrame)
  self:ChangeBattleScoreActive(GamePlayScoreType.Timer, true)
  self._racingTimer = TimerManager:StartTimer(1, BindCallback(self, self.UpdateRacing, battleCtrl), nil, false, false, false)
  self._lastRacingFrame = lastFrame
  if 0 <= lastFrame then
    self.ui.recordNode:SetActive(true)
    self.ui.text_RecordTime:SetIndex(0, BattleUtil.FrameToTimeString(lastFrame, true))
  end
  self.ui.img_timerNode.color = Color.black
  self.ui.tex_Timer.text = BattleUtil.FrameToTimeString(0)
end

function UINGamePlayScore:UpdateRacing(battleCtrl)
  local frame = battleCtrl.frame
  self.ui.tex_Timer.text = BattleUtil.FrameToTimeString(frame)
  if self._lastRacingFrame >= 0 and frame > self._lastRacingFrame then
    self.ui.img_timerNode.color = self._defTimeColor
  end
end

function UINGamePlayScore:ChangeBattleScoreActive(nodeId, active)
  local node = self.listScoreNode[nodeId]
  if node == nil then
    error("not game play score id:" .. tostring(nodeId))
    return
  end
  active = active or false
  node:SetActive(active)
  local initFunc = self.listInitFunc[nodeId]
  if initFunc ~= nil then
    initFunc(self)
  end
end

function UINGamePlayScore:ChangeBattleScoreValue(nodeId, value)
  local func = self.listScoreFunc[nodeId]
  if func == nil then
    error("not game play score id:" .. tostring(nodeId))
    return
  end
  value = value or 0
  func(self, value)
end

function UINGamePlayScore:__BattleScoreNumber(value)
  self.ui.tex_DamageNum.text = tostring(value)
end

function UINGamePlayScore:__BattleScoreTimer(value)
  local min = math.floor(value / 60)
  local sec = math.floor(value % 60)
  local text = string.format("%d:%d", min, sec)
  self.ui.tex_Timer.text = tostring(value)
end

function UINGamePlayScore:__BattleCollect(value)
  self.ui.tex_CollectNum.text = tostring(FormatNum(value / 10)) .. "%"
  self.ui.img_CollectBar.fillAmount = value / 1000
end

function UINGamePlayScore:__InitShowCollect()
  local bdCtrl = BattleDungeonManager:GetDungeonCtrl()
  if bdCtrl == nil then
    return
  end
  local dungeonStageCfg = ConfigData.battle_dungeon[bdCtrl.dungeonId]
  local play_para, wave_battlesCfg, curWaveCfg
  if dungeonStageCfg ~= nil then
    play_para = dungeonStageCfg.play_para
  end
  if play_para ~= nil then
    wave_battlesCfg = ConfigData.wave_battles[play_para]
  end
  if wave_battlesCfg ~= nil then
    curWaveCfg = wave_battlesCfg[bdCtrl.sceneCtrl.sceneWave.cur]
  end
  if curWaveCfg == nil then
    return
  end
  self.ui.tex_CollectName.text = LanguageUtil.GetLocaleText(curWaveCfg.bar_text)
  self.ui.img_CollectIcon.sprite = CRH:GetSprite(curWaveCfg.bar_icon)
end

function UINGamePlayScore:__InitShowCustomCollect()
  local epCtrl = ExplorationManager.epCtrl
  if epCtrl == nil then
    return
  end
  local roomData = epCtrl:GetCurrentRoomData()
  if roomData == nil then
    return
  end
  local battleId = roomData.battleId
  local roomMonsterCfg = ConfigData.exploration_room_monster[battleId]
  if roomMonsterCfg == nil then
    return
  end
  self.ui.tex_CollectName.text = LanguageUtil.GetLocaleText(roomMonsterCfg.bar_text)
  self.ui.img_CollectIcon.sprite = CRH:GetSprite(roomMonsterCfg.bar_icon)
end

function UINGamePlayScore:__OnOverKillValueChange(value, isEnd)
  if not self.ui.overKill.activeSelf then
    self.ui.overKill:SetActive(true)
    local prefab = self.resloader:LoadABAsset("FX/UI_effct/OverKill/FXP_UINChipItemDetail_up.prefab")
    self.__overKillEffect = prefab:Instantiate(self.ui.overKill.transform)
  end
  if self.__overKillColor == nil then
    self.__overKillColor = Color.New(0.7, 0.7, 0.7, 1)
  end
  self.ui.tex_Damage.text = tostring(value)
  self.ui.img_OverKillBottom:DOKill()
  self.ui.img_OverKillBottom.color = Color.white
  self.ui.img_OverKillBottom:DOColor(self.__overKillColor, 0.5)
end

function UINGamePlayScore:_InitSequcenceFactory()
  self.__tweenTransMidToUp = self:__ScoreMoveMidToUpTween()
  self.__tweenTransUpToMid = self:__ScoreMoveUpToMidTween()
  self.__tweenTransBuffTip = self:__ScoreBuffTipTween()
end

function UINGamePlayScore:__ScoreMoveMidToUpTween(seq)
  seq = seq or CS_DOTween.Sequence()
  local rect_list = self.ui.rect_list
  local localPos = rect_list.localPosition
  seq:Append(rect_list:DOLocalMove(Vector2.New(localPos.x, localPos.y - 20), 0)):Append(rect_list:DOLocalMove(Vector2.New(localPos.x, localPos.y + 50), 0.5)):SetAutoKill(false):SetUpdate(true):Pause():SetLink(rect_list.gameObject)
  return seq
end

function UINGamePlayScore:__ScoreMoveUpToMidTween(seq)
  seq = seq or CS_DOTween.Sequence()
  local rect_list = self.ui.rect_list
  local localPos = rect_list.localPosition
  seq:Append(rect_list:DOLocalMove(Vector2.New(localPos.x, localPos.y + 50), 0)):Append(rect_list:DOLocalMove(Vector2.New(localPos.x, localPos.y - 20), 0.5)):SetAutoKill(false):SetUpdate(true):Pause():SetLink(rect_list.gameObject)
  return seq
end

function UINGamePlayScore:PlaySeqMidToUp()
  if self.__tweenTransMidToUp then
    self.__tweenTransMidToUp:Restart()
  end
end

function UINGamePlayScore:PlaySeqUpToMid()
  if self.__tweenTransUpToMid then
    self.__tweenTransUpToMid:Restart()
  end
end

function UINGamePlayScore:__ScoreBuffTipTween(seq)
  seq = seq or CS_DOTween.Sequence()
  local rect_list = self.ui.obj_ProtocolTip.transform
  local canvas = self.ui.canva_ProtocolTip
  local localPos = rect_list.localPosition
  seq:AppendCallback(function()
    self.ui.obj_ProtocolTip:SetActive(true)
  end):Append(rect_list:DOLocalMove(Vector2.New(localPos.x, localPos.y + 50), 0.5)):Join(canvas:DOFade(1, 0)):Join(canvas:DOFade(0.5, 0.5)):AppendCallback(function()
    self.ui.obj_ProtocolTip:SetActive(false)
  end):SetAutoKill(false):SetUpdate(true):Pause():SetLink(rect_list.gameObject)
  return seq
end

function UINGamePlayScore:PlaySeqBuffTipTween()
  if self.__tweenTransBuffTip then
    self.__tweenTransBuffTip:Restart()
  end
end

local eSpBattleRewardType = {TotalDamage = 1}
local initSpBattleRewardFunc = {
  [eSpBattleRewardType.TotalDamage] = function(self)
    self:_UdpSpBtRewardBarTotalDamage(0)
    self._UdpSpBtRewardBarTotalDamageFunc = BindCallback(self, self._UdpSpBtRewardBarTotalDamage)
    MsgCenter:AddListener(eMsgEventId.OnDamageValueChange, self._UdpSpBtRewardBarTotalDamageFunc)
  end
}

function UINGamePlayScore:TryInitSpBattleRewardBar()
  if not ExplorationManager:IsInExploration() then
    return
  end
  local curRoomData = ExplorationManager.epCtrl:GetCurrentRoomData()
  local isHaveSpBattleReward, spBattleId = curRoomData:IsRoomHasSpbattleReward()
  if not isHaveSpBattleReward then
    return
  end
  if spBattleId == nil then
    local epId = ExplorationManager:GetCurExplorationId()
    local explorationConfig = ConfigData.exploration[epId]
    if explorationConfig == nil or explorationConfig.spbattle_room_reward == 0 then
      return
    end
    spBattleId = explorationConfig.spbattle_room_reward
  end
  local spBtRewardCfg = ConfigData.exploration_spbattle_reward[spBattleId]
  if spBtRewardCfg == nil or spBtRewardCfg[1] == nil then
    error("cant get exploration_spbattle_reward, groupId:" .. tostring(spBattleId))
    return
  end
  local tagId = spBtRewardCfg[1].tag_id
  self._spBtRewardCfg = spBtRewardCfg
  self._spBtRewardStage = 1
  self.ui.collect:SetActive(true)
  self.ui.obj_SpBattleIcon:SetActive(true)
  self.ui.img_CollectIcon.gameObject:SetActive(false)
  local initFunc = initSpBattleRewardFunc[tagId]
  if initFunc then
    initFunc(self)
  else
    error("Unsupported eSpBattleRewardType:" .. tostring(tagId))
    return
  end
end

function UINGamePlayScore:_UdpSpBtRewardBarTotalDamage(totalDamage)
  if self._spBtRewardCfg == nil then
    return
  end
  for i = self._spBtRewardStage, #self._spBtRewardCfg do
    local cfg = self._spBtRewardCfg[i]
    if #cfg.tag_num ~= 2 or cfg.tag_num[1] == cfg.tag_num[2] then
      error("exploration_spbattle_reward.tag_num error")
      return
    end
    local valueFrom = cfg.tag_num[1]
    local valueTo = cfg.tag_num[2]
    if totalDamage >= valueFrom and totalDamage < valueTo or i == #self._spBtRewardCfg then
      if self._spBtRewardStage ~= i then
        self:_PlayChangeStageShowSpbtReward()
      end
      self._spBtRewardStage = i
      local name = LanguageUtil.GetLocaleText(cfg.name_txt)
      local percent = (totalDamage - valueFrom) / (valueTo - valueFrom)
      percent = math.clamp(percent, 0, 1)
      self.ui.tex_CollectName.text = name
      self:__BattleCollect(math.floor(percent * 1000))
      break
    end
  end
end

function UINGamePlayScore:_PlayChangeStageShowSpbtReward()
  local animState = self.ui.anim_SpBattle:get_Item("UI_BattleCollectIcon")
  self:_PlayAnimSpBattle()
  local num = 1
  self:_StopAnimSpBattleTimer()
  self._animSpBattleTimer = TimerManager:StartTimer(animState.length, function()
    num = num + 1
    if num <= 2 then
      self:_PlayAnimSpBattle()
    else
      self.ui.fx_SpBattleChange:SetActive(false)
      self.ui.fx_SpBattleChange:SetActive(true)
      self.ui.anim_SpBattle.gameObject:SetActive(false)
      self:_StopAnimSpBattleTimer()
    end
  end, self, false)
end

function UINGamePlayScore:_PlayAnimSpBattle()
  self.ui.anim_SpBattle.gameObject:SetActive(false)
  self.ui.anim_SpBattle.gameObject:SetActive(true)
end

function UINGamePlayScore:_StopAnimSpBattleTimer()
  TimerManager:StopTimer(self._animSpBattleTimer)
end

function UINGamePlayScore:OnDelete()
  self:_StopAnimSpBattleTimer()
  MsgCenter:RemoveListener(eMsgEventId.ChangeBattleScoreActive, self.__ChangeBattleScoreActive)
  MsgCenter:RemoveListener(eMsgEventId.ChangeBattleScoreValue, self.__ChangeBattleScoreValue)
  if self._UdpSpBtRewardBarTotalDamageFunc ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.OnDamageValueChange, self._UdpSpBtRewardBarTotalDamageFunc)
  end
  if self.__onOverKillValueChange ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.OnOverKillValueChange, self.__onOverKillValueChange)
  end
  self.ui.img_OverKillBottom:DOKill()
  TimerManager:StopTimer(self._racingTimer)
  self.__tweenTransMidToUp:Kill()
  self.__tweenTransUpToMid:Kill()
  self.__tweenTransBuffTip:Kill()
  base.OnDelete(self)
end

return UINGamePlayScore

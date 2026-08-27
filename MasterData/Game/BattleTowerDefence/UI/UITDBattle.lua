local UITDBattle = class("TDBattle", UIBaseWindow)
local base = UIBaseWindow
local CS_BattleManager = CS.BattleManager.Instance
local UINTDBattleHeroHeadItem = require("Game.BattleTowerDefence.UI.UINTDBattleHeroHeadItem")
local UINTDBattleNextBtn = require("Game.BattleTowerDefence.UI.UINTDBattleNextBtn")
local UINMonsterLevel = require("Game.Exploration.UI.MonsterLevel.UINMonsterLevel")
local UINTDBtParticle = require("Game.BattleTowerDefence.UI.Battle.UINTDBtParticle")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local cs_scrambleMode = CS.DG.Tweening.ScrambleMode
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_LeanTouch = CS.Lean.Touch.LeanTouch

function UITDBattle:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_EpStore, self, self.__OnClickResidentStore)
  UIUtil.AddButtonListener(self.ui.btn_cancle, self, self.EndDragMode)
  self.tdBtParticleNode = UINTDBtParticle.New()
  self.tdBtParticleNode:Init(self.ui.particalNode)
  self.__onDragUpdate = BindCallback(self, self.__OnDragUpdate)
  cs_LeanTouch.OnFingerSet("+", self.__onDragUpdate)
  self.__onFingerDown = BindCallback(self, self.__OnFingerDown)
  cs_LeanTouch.OnFingerDown("+", self.__onFingerDown)
  self.__onFingerUp = BindCallback(self, self.__OnFingerUp)
  cs_LeanTouch.OnFingerUp("+", self.__onFingerUp)
  self.ui.img_cancle.gameObject:SetActive(false)
  self.ui.heroHeadItem:SetActive(false)
  self.headPool = UIItemPool.New(UINTDBattleHeroHeadItem, self.ui.heroHeadItem)
  self.__OnDragHeroTower = BindCallback(self, self.OnDragHeroTower)
  self.__OnClickHeroHead = BindCallback(self, self.OnClickHeroHead)
  self.__onChangePointDrag = BindCallback(self, self.ChangePointDrag)
  self.__setCurrentSelectRole = BindCallback(self, self.__SetCurrentSelectRole)
  self.__CountDown = BindCallback(self, self.CountDown)
  self.__ShowCD = BindCallback(self, self.ShowCD)
  MsgCenter:AddListener(eMsgEventId.TDNextCountDown, self.__ShowCD)
  self.__ShowNextClick = BindCallback(self, self.ShowNextClick)
  MsgCenter:AddListener(eMsgEventId.TDNextClickActive, self.__ShowNextClick)
  self.__updateMoney = BindCallback(self, self.__UpdateExpMoney)
  MsgCenter:AddListener(eMsgEventId.EpMoneyChange, self.__updateMoney)
  self.__openBulletTime = BindCallback(self, self.__OpenBulletTime)
  MsgCenter:AddListener(eMsgEventId.TDOpenBulletTime, self.__openBulletTime)
  self.__onTapSetTDRole = BindCallback(self, self.__OnTapSetTDRole)
  MsgCenter:AddListener(eMsgEventId.OnTapSetTDRole, self.__onTapSetTDRole)
  self.__closeBulletTime = BindCallback(self, self.__CloseBulletTime)
  MsgCenter:AddListener(eMsgEventId.TDCloseBulletTime, self.__closeBulletTime)
  self.__displayOtherUI = BindCallback(self, self.__DisplayOtherUI)
  MsgCenter:AddListener(eMsgEventId.TDDisplayOtherUI, self.__displayOtherUI)
  self.__updateTowerList = BindCallback(self, self.OnTowerPlacement)
  MsgCenter:AddListener(eMsgEventId.TDUpdateTowerList, self.__updateTowerList)
  self.showNextWave = false
  self.headers = {}
  self.__OnNextWave = BindCallback(self, self.OnNextWave)
  MsgCenter:AddListener(eMsgEventId.TDNextWava, self.__OnNextWave)
  self.__OnMonsterBorn = BindCallback(self, self.OnMonsterBorn)
  MsgCenter:AddListener(eMsgEventId.TDMonsterBorn, self.__OnMonsterBorn)
  self.__OnReceiveMpSpeed = BindCallback(self, self.OnReceiveMpSpeed)
  MsgCenter:AddListener(eMsgEventId.TDMPAddSpeed, self.__OnReceiveMpSpeed)
  self.__onEnemyIsDead = BindCallback(self, self.__OnEnemyIsDead)
  MsgCenter:AddListener(eMsgEventId.EnemyIsDead, self.__onEnemyIsDead)
  self.tdNextWaveBtn = UINTDBattleNextBtn.New()
  self.tdNextWaveBtn:Init(self.ui.btn_BattleNext)
  self.tdNextWaveBtn:SetNextWaveCallback(BindCallback(self, self.__OnClickNextWave))
  self.monsterLevelView = UINMonsterLevel.New()
  self.monsterLevelView:Init(self.ui.monsterLevel)
  self.monsterLevelView:InitMonsterLevelUI(BattleUtil.GetCurDynPlayer(), true)
  self.monsterLevelView:Hide()
  self._positionTokenInfo = self.ui.tokenInfo.transform.localPosition
  self._positionWaitHero = self.ui.waitHeroList.transform.localPosition
  self._positionEpStore = self.ui.btn_EpStore.transform.localPosition
  self.ui.obj_TokenFx:SetActive(false)
  self.ui.btn_token.onPress:AddListener(BindCallback(self, self.__OnTokenLongPress))
  self.ui.btn_token.onPressUp:AddListener(BindCallback(self, self.__OnTokenPressUp))
  self:ShowDeployTowerTips(false)
end

function UITDBattle:InitTDBattle(waitToCasteTowerEntities, theBattleTowerCount, csCallNextWave, csGetTowerMp, csDragWaitTower, csRetreatTower)
  if waitToCasteTowerEntities == nil then
    return
  end
  self.headPool:HideAll()
  for k, v in pairs(waitToCasteTowerEntities) do
    if v ~= nil then
      local item = self.headPool:GetOne()
      item:OnInitHeroItem(v, v:GetTDRoleCastCost(), self.__OnDragHeroTower, self.__OnClickHeroHead, self.__onChangePointDrag, self.__setCurrentSelectRole)
      self.headers[v] = item
    end
  end
  self.__callNextWaveAction = csCallNextWave
  self.__getTowerMpFunction = csGetTowerMp
  self.__dragWaitTower = csDragWaitTower
  self.__retreatTower = csRetreatTower
  self.tdNextWaveBtn:Hide()
  self.ui.cDText.gameObject:SetActive(false)
  self:PlayCountDownWarringTween(-1)
  self.ui.btn_EpStore.gameObject:SetActive(true)
  self:__UpdateExpMoney()
  local maxCount = 0
  local dynPlayer = BattleUtil.GetCurDynPlayer()
  if dynPlayer ~= nil then
    maxCount = dynPlayer:GetEnterFiledNum()
  end
  self:_RefreshDeployUI(theBattleTowerCount, maxCount)
  self.ui.tDInfo:SetActive(false)
  self:TryShowMonsterLevel(true)
  self.ui.img_TokenBar.fillAmount = 0
  self._mpReplySpeed = 0
  self:LeftPositionSet(false)
  self._isSpecialTDMode = BattleUtil.IsSpecialTDMode()
  if self._isSpecialTDMode then
    self.ui.waitHeroList.gameObject:SetActive(false)
    self.ui.btn_EpStore.gameObject:SetActive(false)
    self.ui.tokenInfo:SetActive(false)
    self.ui.monsterLevel:SetActive(false)
    self.ui.tDInfo:SetActive(false)
  end
end

function UITDBattle:GetBtnCancleUI()
  return self.ui.img_cancle
end

function UITDBattle:InjectTimeScaleAction(changeTimeScale, getLastTimeScale)
  self.__changeTimeScale = changeTimeScale
  self.__getLastTimeScale = getLastTimeScale
end

function UITDBattle:__UpdateExpMoney(money)
  if money == nil then
    money = self:__GetCurCoin()
  end
  self:UpdateTowerMp(money)
end

function UITDBattle:__SetCurrentSelectRole(item)
  self.curSelectRoleItem = item
  self.onTapSelectRole = true
end

function UITDBattle:__OnFingerDown(leanFinger)
  self.__fingerId = leanFinger.Index
end

function UITDBattle:__OnFingerUp(leanFinger)
  self.__fingerId = nil
  if self.curSelectRoleItem ~= nil and not self.onTapSelectRole then
    self:EndDragMode()
  end
end

function UITDBattle:__OnDragUpdate(leanFinger)
  if not self.onTapSelectRole or self.curSelectRoleItem == nil then
    return
  end
  if leanFinger.IsOverGui then
    return
  end
  self:OnDragHeroTower(self.curSelectRoleItem)
end

function UITDBattle:OnDragHeroTower(battleHeroHead, eventData)
  if not ConfigData.buildinConfig.TowerOptionInDeploy then
    local battleCtrl = CS.BattleManager.Instance.CurBattleController
    if battleCtrl ~= nil and not battleCtrl:BattleIsRunning() then
      return
    end
  end
  local characterWindow = UIManager:GetWindow(UIWindowTypeID.TDCharactorInfo)
  if characterWindow ~= nil and characterWindow.active then
    characterWindow:Hide()
  end
  local roleEntity = battleHeroHead.roleEntity
  if roleEntity ~= nil then
    self.ui.img_cancle.gameObject:SetActive(true)
    self:__DisplayOtherUI(false)
    self:ShowDeployTowerTips(true)
    self:__OpenBulletTime()
    if self.__dragWaitTower ~= nil then
      self.__dragWaitTower(roleEntity)
    end
  end
end

function UITDBattle:__OnTapSetTDRole()
  self.ui.img_cancle.gameObject:SetActive(true)
  self:__DisplayOtherUI(false)
  self:__OpenBulletTime()
  self:ShowDeployTowerTips(true)
end

function UITDBattle:OnTowerPlacement(role, isOn, towerCasteCost, theBattleTowerCount)
  towerCasteCost = towerCasteCost or 0
  theBattleTowerCount = theBattleTowerCount or 0
  if role == nil then
    return
  end
  local maxCount = 0
  local dynHero
  local dynPlayer = BattleUtil.GetCurDynPlayer()
  if dynPlayer ~= nil then
    maxCount = dynPlayer:GetEnterFiledNum()
    dynHero = dynPlayer:GetDynHeroByDataId(role.roleDataId)
  end
  local skillMoudleUI = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if isOn then
    local headItem = self.headers[role]
    if headItem ~= nil then
      self.headPool:HideOne(headItem)
      self.headers[role] = nil
    end
    if skillMoudleUI ~= nil and not skillMoudleUI:IsHaveHeroHeadInUlt(role.roleDataId) and dynHero ~= nil then
      skillMoudleUI:AddHeroItemWithoutUltSkill(role.roleDataId, dynHero.heroData)
    end
  else
    theBattleTowerCount = self:GetAliveTowerCount()
    self:ClearCurInputTile(role)
    local item = self.headPool:GetOne()
    item:OnInitHeroItem(role, towerCasteCost, self.__OnDragHeroTower, self.__OnClickHeroHead, self.__onChangePointDrag, self.__setCurrentSelectRole)
    if self.headers[role] == nil then
      self.headers[role] = item
    end
    local flag, isUlt = skillMoudleUI:IsHaveHeroHeadInUlt(role.roleDataId)
    if skillMoudleUI ~= nil and flag and not isUlt then
      skillMoudleUI:RemoveHeroItemWithoutUltSkill(role.roleDataId)
    end
  end
  self:_RefreshDeployUI(theBattleTowerCount, maxCount)
  self:RefreshTDHeadState()
  local epWindow = UIManager:ShowWindow(UIWindowTypeID.DungeonStateInfo)
  if epWindow ~= nil then
    epWindow:TowerPlacementChange(role.roleDataId, isOn)
  end
end

function UITDBattle:_RefreshDeployUI(theBattleTowerCount, maxCount)
  self.ui.tex_Deploy.text = string.format("%d/%d", theBattleTowerCount, maxCount)
  local idx = maxCount <= theBattleTowerCount and 1 or 0
  local texCol = self.ui.deployTexCols[idx + 1]
  local bgCol = self.ui.deployBgCols[idx + 1]
  self.ui.tex_DeployState:SetIndex(idx)
  self.ui.tex_DeployState.text.color = texCol
  self.ui.tex_Deploy.color = texCol
  self.ui.img_deployBg.color = bgCol
  self._isFullHero = maxCount <= theBattleTowerCount
end

function UITDBattle:GetAliveTowerCount()
  local theBattleTowerCount = 0
  local battleCtrl = CS_BattleManager.CurBattleController
  if battleCtrl == nil then
    return 0
  end
  local playerTeamCtrl = battleCtrl.PlayerTeamController
  if playerTeamCtrl == nil then
    return 0
  end
  local battleRoleList = playerTeamCtrl.battleRoleList
  if battleRoleList == nil or 0 >= battleRoleList.Count then
    return 0
  end
  for i = 0, battleRoleList.Count - 1 do
    local role = battleRoleList[i]
    if role.roleType == eBattleRoleType.character and 0 < role.hp then
      theBattleTowerCount = theBattleTowerCount + 1
    end
  end
  return theBattleTowerCount
end

function UITDBattle:ClearCurInputTile(role)
  if role.hp > 0 then
    return
  end
  local csBattleCtrl = CS.BattleManager.Instance.CurBattleController
  if csBattleCtrl == nil then
    return
  end
  local battleSkillInputCtrl = csBattleCtrl.PlayerController.battleSkillInputController
  if not (battleSkillInputCtrl ~= nil and battleSkillInputCtrl:IsActive()) or battleSkillInputCtrl.inputRole == nil or battleSkillInputCtrl.inputRole ~= role then
    return
  end
  if battleSkillInputCtrl.cancleSelect ~= nil then
    battleSkillInputCtrl.cancleSelect()
  end
  CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(705))
end

function UITDBattle:EndDragMode()
  self.ui.img_cancle.gameObject:SetActive(false)
  self:__DisplayOtherUI(true)
  self:ShowDeployTowerTips(false)
  self:OnTowerInfoHide()
  self:__CloseBulletTime()
  self.curSelectRoleItem = nil
  self.onTapSelectRole = false
end

function UITDBattle:ShowDeployTowerTips(enable)
  self.ui.messageTips:SetActive(enable)
end

function UITDBattle:OnActiveCancleBtn()
  self.ui.img_cancle.color = self.ui.highlightColor
end

function UITDBattle:OnDisActiveCancleBtn()
  self.ui.img_cancle.color = self.ui.normalColor
end

function UITDBattle:ShowCD(frameCount)
  if frameCount <= 0 then
    self._secCount = 0
    self.ui.cDText.gameObject:SetActive(false)
    self:PlayCountDownWarringTween(-1)
    return
  end
  self._secCount = BattleUtil.FrameToTime(frameCount)
  if self.timer == nil then
    self.timer = TimerManager:StartTimer(1, self.__CountDown, nil, false, false, false)
  end
  self.ui.cDText.gameObject:SetActive(true)
  local floorSec = math.floor(self._secCount)
  self.ui.cDText.text = tostring(floorSec)
  self:PlayCountDownWarringTween(floorSec)
end

function UITDBattle:OnUpdateHeroCd()
  for i, headItem in ipairs(self.headPool.listItem) do
    headItem:UpdateCd()
  end
end

function UITDBattle:CountDown()
  self._secCount = self._secCount - 1
  if self._secCount < 0 then
    self.ui.cDText.gameObject:SetActive(false)
    self:PlayCountDownWarringTween(-1)
    return
  end
  local floorSec = math.floor(self._secCount)
  self.ui.cDText.text = tostring(floorSec)
  self:PlayCountDownWarringTween(floorSec)
end

function UITDBattle:PlayCountDownWarringTween(floorSec)
  if self.ui.Ani_CD.gameObject.activeSelf then
    self.ui.Ani_CD.gameObject:SetActive(false)
  end
  if floorSec < 0 then
    return
  end
  local startSec = self.ui.flo_CDStarTime or 5
  if floorSec > startSec then
    return
  end
  if not self.ui.Ani_CD.gameObject.activeSelf then
    self.ui.Ani_CD.gameObject:SetActive(true)
  end
end

function UITDBattle:UpdateTowerMp(mp)
  if self._lastMp == mp then
    return
  end
  self._lastMp = mp
  self.ui.tex_Token.text = tostring(mp)
  self:RefreshTDHeadState()
  local playerCtrl = CS_BattleManager:GetBattlePlayerController()
  if playerCtrl ~= nil and 0 < (self._mpReplySpeed or 0) then
    self._mpReplyOriTime = Time.time
    if self.mpAddTimerId == nil then
      self.mpAddTimerId = TimerManager:StartTimer(1, self.OnTimerMpForecastProcess, self, false, true, false)
    end
    self:OnTimerMpForecastProcess()
  end
end

function UITDBattle:OnReceiveMpSpeed(mpSpeed)
  self._mpReplySpeed = mpSpeed / 1000 / ConfigData.game_config.mpGrowInterval * BattleUtil.LogicFrameCount
end

function UITDBattle:__GetCurCoin()
  local dynPlayer = BattleUtil.GetCurDynPlayer()
  if dynPlayer == nil then
    return 0
  end
  return dynPlayer:GetMoneyCount()
end

function UITDBattle:RefreshTDHeadState()
  for _, headItem in ipairs(self.headPool.listItem) do
    headItem:UpdateEnoughState(self._lastMp, self._isFullHero)
  end
end

function UITDBattle:ShowNextClick(flag, displayCost, calcMoneyAction)
  if self.updateNextWaveCostTimerId ~= nil and self.updateNextWaveCostTimerId > 0 then
    TimerManager:StopTimer(self.updateNextWaveCostTimerId)
    self.updateNextWaveCostTimerId = 0
  end
  self.ui.btn_BattleNext.gameObject:SetActive(flag)
  self.showNextWave = flag
  if flag then
    self.tdNextWaveBtn:Show()
    self.curNextWaveDisplayCost = displayCost
    self.tdNextWaveBtn:RefreshNextBtnState(self._curWave, self._totalWave, displayCost)
    self.updateNextWaveCostTimerId = TimerManager:StartTimer(1, BindCallback(self, self.UpdateNextWaveCostText, calcMoneyAction), nil, false, false, false)
  else
    self.tdNextWaveBtn:Hide()
  end
end

function UITDBattle:UpdateNextWaveCostText(calcMoneyAction)
  if calcMoneyAction == nil then
    return
  end
  self.curNextWaveDisplayCost = calcMoneyAction()
  self.tdNextWaveBtn:RefreshRewardCount(self.curNextWaveDisplayCost)
end

function UITDBattle:__OnClickNextWave()
  self.ui.cDText.gameObject:SetActive(false)
  self.onClickNextWaveClick = true
  self:PlayCountDownWarringTween(-1)
  if self.__callNextWaveAction ~= nil then
    self.__callNextWaveAction()
  end
end

function UITDBattle:__PlayOnClickNextFx()
  local count = 10
  local destPos = self.ui.img_TokenIconAni.transform.position
  local originPos = self.transform:InverseTransformPoint(self.ui.cDText.transform.position)
  local win = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if win ~= nil then
    win:StartResFxFlyAni(1, originPos, destPos, count)
  end
  self:__PlayTokenIconTween()
end

function UITDBattle:__OnClickResidentStore()
  if not ExplorationManager:IsInExploration() then
    return
  end
  local dungeonInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonInfoWin ~= nil then
    dungeonInfoWin:SetMoneyActive(true)
  end
  ExplorationManager.epCtrl:OpenResidentStore(function()
    dungeonInfoWin:SetMoneyActive(false)
  end)
end

function UITDBattle:GetTowerMp()
  local mp = 0
  if self.__getTowerMpFunction ~= nil then
    mp = self.__getTowerMpFunction()
  end
  return mp
end

function UITDBattle:OnTdBattleStart()
  self.ui.btn_EpStore.gameObject:SetActive(false)
  if not BattleUtil.IsSpecialTDMode() then
    self.ui.tDInfo:SetActive(true)
  end
  self:TryShowMonsterLevel(false)
  local dungeonInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonInfoWin ~= nil then
    dungeonInfoWin:ShowTopInfo(false)
  end
  self:LeftPositionSet(true)
end

function UITDBattle:LeftPositionSet(isInBattle)
  self.ui.tokenInfo.transform:DOKill(true)
  self.ui.waitHeroList.transform:DOKill(true)
  self.ui.btn_EpStore.transform:DOKill(true)
  if isInBattle then
    self.ui.tokenInfo.transform:DOLocalMove(self._positionTokenInfo, 0.5):SetLink(self.ui.tokenInfo.gameObject)
    self.ui.waitHeroList.transform:DOLocalMove(self._positionWaitHero, 0.5):SetLink(self.ui.waitHeroList.gameObject)
    self.ui.btn_EpStore.transform:DOLocalMove(self._positionEpStore, 0.5):SetLink(self.ui.btn_EpStore.gameObject)
  else
    self.ui.tokenInfo.transform.localPosition = self._positionTokenInfo + self.ui.pos_waitLeftOffset
    self.ui.waitHeroList.transform.localPosition = self._positionWaitHero + self.ui.pos_waitLeftOffset
    self.ui.btn_EpStore.transform.localPosition = self._positionEpStore + self.ui.pos_waitLeftOffset
  end
end

function UITDBattle:OnBattleEnd()
  self:OnTowerInfoHide()
  if self.mpAddTimerId ~= nil then
    TimerManager:StopTimer(self.mpAddTimerId)
    self.mpAddTimerId = nil
  end
  local dungeonInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonInfoWin ~= nil then
    dungeonInfoWin:ShowTopInfo(true)
    dungeonInfoWin:ChipListWeakenTween(false)
  end
end

function UITDBattle:OnTowerInfoHide()
  local tdTowerInfo = UIManager:GetWindow(UIWindowTypeID.TDCharactorInfo)
  if tdTowerInfo ~= nil then
    tdTowerInfo:Hide()
  end
end

function UITDBattle:OnTowerInfoShow(hero, worldPos)
  local tdInfoUI = UIManager:GetWindow(UIWindowTypeID.TDCharactorInfo)
  if tdInfoUI == nil then
    tdInfoUI = UIManager:ShowWindow(UIWindowTypeID.TDCharactorInfo)
    tdInfoUI.transform.sizeDelta = Vector2.New(100, 100)
  else
    tdInfoUI:Show()
  end
  tdInfoUI:InitCharactor(hero, BindCallback(self, self.OnRoleRetreat))
  local uiCamera = UIManager.UICamera
  local mainCamera = UIManager:GetMainCamera()
  local pos = UIManager:World2UIPosition(worldPos, tdInfoUI.transform.parent, uiCamera, mainCamera)
  tdInfoUI.gameObject.transform.localPosition = Vector3.New(pos.x, pos.y, 0)
end

function UITDBattle:OnRoleRetreat(characterEntity)
  if self.__retreatTower ~= nil then
    self.__retreatTower(characterEntity)
  end
end

function UITDBattle:__DisplayOtherUI(active)
  if active then
    self:__ShowOtherUI()
  else
    self:__HideOtherUI()
  end
end

function UITDBattle:__HideOtherUI()
  if self.showNextWave then
    self.tdNextWaveBtn:Hide()
  end
  self.ui.waitHeroList:SetActive(false)
  self.ui.tokenInfo:SetActive(false)
  local battleSkillModule = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if battleSkillModule ~= nil and battleSkillModule.active then
    battleSkillModule:Hide(true)
  end
  local UIBattleWin = UIManager:GetWindow(UIWindowTypeID.Battle)
  if UIBattleWin ~= nil and UIBattleWin.active then
    UIBattleWin:Hide()
  end
end

function UITDBattle:__ShowOtherUI()
  if self.showNextWave then
    self.tdNextWaveBtn:Show()
  end
  if not self._isSpecialTDMode then
    self.ui.waitHeroList:SetActive(true)
    self.ui.tokenInfo:SetActive(true)
  end
  local battleSkillModule = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if battleSkillModule ~= nil and not battleSkillModule.active then
    battleSkillModule:Show(true)
  end
  local UIBattleWin = UIManager:GetWindow(UIWindowTypeID.Battle)
  if UIBattleWin ~= nil and not UIBattleWin.active then
    UIBattleWin:Show()
  end
end

function UITDBattle:OnClickHeroHead(roleEntity)
  local dungeonStateWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonStateWindow ~= nil then
    self:__OpenBulletTime(true)
    dungeonStateWindow:RegisterHeroListCloseCallBack(function()
      dungeonStateWindow:CancleHeroListCloseCallBack()
      self:__CloseBulletTime()
    end)
    dungeonStateWindow:OnHeroCoordChanged()
    dungeonStateWindow:ShowHero(roleEntity.character)
  end
end

function UITDBattle:OnNextWave(curWave, totalWave, remainEmptyCount)
  self.ui.tex_Enemy:SetIndex(0, "0", tostring(remainEmptyCount))
  self:CurrentWaveProcess(curWave, totalWave)
  if self.onClickNextWaveClick then
    self.onClickNextWaveClick = false
    self:__PlayOnClickNextFx()
  end
  self._waveEmptyCount = remainEmptyCount
  self._curWave = curWave
  self._totalWave = totalWave
end

function UITDBattle:OnMonsterBorn(remainEmptyCount)
  self.ui.tex_Enemy:SetIndex(0, tostring(self._waveEmptyCount - remainEmptyCount), self._waveEmptyCount)
end

function UITDBattle:OnTimerMpForecastProcess()
  local diff = Time.time - self._mpReplyOriTime
  local process = math.clamp(diff * self._mpReplySpeed, 0, 1)
  self.ui.img_TokenBar.fillAmount = process
end

function UITDBattle:CurrentWaveProcess(curWave, totalWave)
  local cur = tostring(curWave)
  local total = tostring(totalWave)
  self.ui.tex_Process.text = cur .. "/" .. total
end

function UITDBattle:__OpenBulletTime(isPause)
  if self.__isOpenBulletTime then
    return
  end
  self.__isOpenBulletTime = true
  self:__RecordTimeScale()
  self:__SetTimeScaleTemply(isPause)
end

function UITDBattle:__CloseBulletTime()
  if not self.__isOpenBulletTime then
    return
  end
  self.__isOpenBulletTime = false
  if self.curTimeScale ~= Time.unity_time.timeScale then
    return
  end
  self:__RecoverTimeScale()
end

function UITDBattle:__RecordTimeScale()
  self.lastRecordTimeScale = Time.unity_time.timeScale
end

function UITDBattle:__SetTimeScaleTemply(isPause)
  local targetScale = isPause and 0 or ConfigData.game_config.bulletTime
  Time.unity_time.timeScale = targetScale
  self.curTimeScale = Time.unity_time.timeScale
end

function UITDBattle:__RecoverTimeScale()
  Time.unity_time.timeScale = self.lastRecordTimeScale
end

function UITDBattle:__GetTopViewTimeLine()
  return CS.CameraController.Instance.SwitchToTopViewTimeLine
end

function UITDBattle:__SwitchToTopView()
  if self.ToTopViewing then
    return
  end
  self:__SetSwitchTimelineEnable(true)
  if self.timeLinePlayCoroutine ~= nil then
    TimelineUtil.StopTlCo(self.timeLinePlayCoroutine)
    self.timeLinePlayCoroutine = nil
  end
  self.switchToTopViewTimeLine = self.switchToTopViewTimeLine or self:__GetTopViewTimeLine()
  if self.switchToTopViewTimeLine ~= nil then
    self.timeLinePlayCoroutine = TimelineUtil.Play(self.switchToTopViewTimeLine, nil, false, true, true)
  end
  self.ToTopViewing = true
end

function UITDBattle:__SwitchToNormalView(withoutAnim)
  if not self.ToTopViewing then
    return
  end
  if self.timeLinePlayCoroutine ~= nil then
    TimelineUtil.StopTlCo(self.timeLinePlayCoroutine)
    self.timeLinePlayCoroutine = nil
  end
  self.switchToTopViewTimeLine = self.switchToTopViewTimeLine or self:__GetTopViewTimeLine()
  if self.switchToTopViewTimeLine ~= nil then
    if not withoutAnim then
      self.timeLinePlayCoroutine = TimelineUtil.Rewind(self.switchToTopViewTimeLine, nil, nil, true, true)
    else
      self.switchToTopViewTimeLine.time = 0
      self.switchToTopViewTimeLine:Evaluate()
      self:__SetSwitchTimelineEnable(false)
    end
  end
  self.ToTopViewing = false
end

function UITDBattle:__SetSwitchTimelineEnable(enable)
  self.switchToTopViewTimeLine = self.switchToTopViewTimeLine or self:__GetTopViewTimeLine()
  self.switchToTopViewTimeLine.gameObject:SetActive(enable)
end

function UITDBattle:ChangePointDrag(eventData)
  eventData.pointerDrag = self.ui.heroScrollRect.gameObject
  self.ui.heroScrollRect:OnBeginDrag(eventData)
end

function UITDBattle:TryShowMonsterLevel(enable)
  if self.monsterLevelView == nil then
    return
  end
  if not enable then
    self.monsterLevelView:Hide()
    return
  end
  local dynPlayer = BattleUtil.GetCurDynPlayer()
  if dynPlayer == nil or dynPlayer.epCommonData == nil or dynPlayer.epCommonData.monster == nil then
    self.monsterLevelView:Hide()
    return
  end
  self.monsterLevelView:Show()
  self.monsterLevelView:UpdateMonsterLevelByData(dynPlayer.epCommonData.monster)
end

function UITDBattle:__OnEnemyIsDead(rewardCount, worldPos)
  if worldPos ~= nil then
    self.tdBtParticleNode:TDBtPlayCoinAddFx(rewardCount, worldPos)
  end
  self:__PlayTokenIconTween()
end

function UITDBattle:__PlayTokenIconTween()
  self.ui.obj_TokenFx:SetActive(true)
  if self.tokenSeq ~= nil then
    self.ui.img_TokenIconAni.transform.localScale = Vector3.one
    self.ui.img_TokenIconAni.color = Color.white
    self.tokenSeq:Restart()
    return
  end
  local seq = cs_DoTween.Sequence()
  seq:SetAutoKill(false)
  seq:Append(self.ui.img_TokenIconAni.transform:DOScale(Vector3.New(3, 3, 1), 0.6))
  seq:Join(self.ui.img_TokenIconAni:DOFade(0, 0.6))
  seq:OnComplete(function()
    self.ui.obj_TokenFx:SetActive(false)
  end)
  self.tokenSeq = seq
end

function UITDBattle:__OnTokenLongPress()
  if ExplorationManager == nil then
    return
  end
  local dynplayer = ExplorationManager:GetDynPlayer()
  if dynplayer == nil then
    return
  end
  local epTypeCfg = ExplorationManager:GetEpTypeCfg()
  if epTypeCfg == nil then
    return
  end
  local hideInterest = false
  local theMoney = dynplayer:GetMoneyCount()
  if theMoney >= ConfigData.game_config.towerMoneyMax then
    hideInterest = true
  end
  local isInterestOpen = epTypeCfg.interest_open and not hideInterest
  if not isInterestOpen then
    return
  end
  local str = ConfigData:GetTipContent(763)
  local n = tostring(epTypeCfg.interest[1] // 10) .. "%"
  local msg = string.format(str, n, epTypeCfg.interest[2])
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  win:SetTitleAndContext(nil, msg)
  win:FloatTo(self.ui.btn_token.transform, HAType.autoCenter, VAType.up)
  win:Copy3DModifier(self.ui.comp_3dModifier)
end

function UITDBattle:__OnTokenPressUp()
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

function UITDBattle:OnDelete()
  self.onTapSelectRole = false
  if self.__isOpenBulletTime then
    self:__CloseBulletTime()
  end
  self.tdBtParticleNode:Delete()
  cs_LeanTouch.OnFingerSet("-", self.__onDragUpdate)
  cs_LeanTouch.OnFingerDown("-", self.__onFingerDown)
  cs_LeanTouch.OnFingerUp("-", self.__onFingerUp)
  self:__SwitchToNormalView(true)
  if self.timeLinePlayCoroutine ~= nil then
    TimelineUtil.StopTlCo(self.timeLinePlayCoroutine)
    self.timeLinePlayCoroutine = nil
  end
  self.switchToTopViewTimeLine = nil
  if self.updateNextWaveCostTimerId ~= nil and self.updateNextWaveCostTimerId > 0 then
    TimerManager:StopTimer(self.updateNextWaveCostTimerId)
  end
  self.__callNextWaveAction = nil
  self.__getTowerMpFunction = nil
  self.__retreatTower = nil
  self.__dragWaitTower = nil
  if self.timer ~= nil and 0 < self.timer then
    TimerManager:StopTimer(self.timer)
    self.timer = nil
  end
  if self.mpAddTimerId ~= nil then
    TimerManager:StopTimer(self.mpAddTimerId)
    self.mpAddTimerId = nil
  end
  self.headers = nil
  for _, headItem in ipairs(self.headPool.listItem) do
    headItem:OnDelete()
  end
  MsgCenter:RemoveListener(eMsgEventId.OnTapSetTDRole, self.__onTapSetTDRole)
  MsgCenter:RemoveListener(eMsgEventId.TDUpdateTowerList, self.__updateTowerList)
  MsgCenter:RemoveListener(eMsgEventId.TDNextCountDown, self.__ShowCD)
  MsgCenter:RemoveListener(eMsgEventId.TDNextClickActive, self.__ShowNextClick)
  MsgCenter:RemoveListener(eMsgEventId.EpMoneyChange, self.__updateMoney)
  MsgCenter:RemoveListener(eMsgEventId.TDOpenBulletTime, self.__openBulletTime)
  MsgCenter:RemoveListener(eMsgEventId.TDCloseBulletTime, self.__closeBulletTime)
  MsgCenter:RemoveListener(eMsgEventId.TDDisplayOtherUI, self.__displayOtherUI)
  MsgCenter:RemoveListener(eMsgEventId.TDNextWava, self.__OnNextWave)
  MsgCenter:RemoveListener(eMsgEventId.TDMonsterBorn, self.__OnMonsterBorn)
  MsgCenter:RemoveListener(eMsgEventId.TDMPAddSpeed, self.__OnReceiveMpSpeed)
  MsgCenter:RemoveListener(eMsgEventId.EnemyIsDead, self.__onEnemyIsDead)
  if self.tokenSeq ~= nil then
    self.tokenSeq:Kill()
    self.tokenSeq = nil
  end
  if self.monsterLevelView ~= nil then
    self.monsterLevelView:Delete()
  end
  base.OnDelete(self)
end

return UITDBattle

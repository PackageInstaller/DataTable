require("bounce_controller")
_class("UIBounceMainController", UIController)
UIBounceMainController = UIBounceMainController

function UIBounceMainController:Constructor()
  self.coreController = nil
  self.levelId = 0
  self.isBoss = false
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._loginModule = self:GetModule(LoginModule)
  self.aniName = {
    [1] = "uieff_UIBounceMainController_in_aniBgs",
    [2] = "uieff_UIBounceMainController_in_boss"
  }
end

function UIBounceMainController:LoadDataOnEnter(TT, res)
  self._campaign = UIActivityCampaign:New()
  local campaignModule = self:GetModule(CampaignModule)
  self._campaignModule = campaignModule
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N28_MINI_GAME, ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  local sample = self._campaign:GetSample()
  self._endTime = sample.end_time
  self._component = self._campaign:GetComponent(ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION)
  self._componentInfo = self._campaign:GetComponentInfo(ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION)
  local openTime = self._componentInfo.m_unlock_time
  local closeTime = self._endTime
  local nowtime = self._svrTimeModule:GetServerTime() / 1000
  if openTime > nowtime then
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN
    campaignModule:ShowErrorToast(res.m_result, true)
    return
  end
  if closeTime < nowtime then
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED
    campaignModule:ShowErrorToast(res.m_result, true)
    return
  end
end

function UIBounceMainController:OnShow(uiParams)
  self.levelId = uiParams[1]
  if BounceDebug.TestLevelId then
    self.levelId = BounceDebug.TestLevelId
  end
  self.selectPlayer = uiParams[2]
  self.historyBestScore = uiParams[3]
  self.isBoss = self.levelId == 6 or self.levelId == 7
  self:InitWidget()
  self:InitView()
  self:InitCore()
  self:StartAnim()
end

function UIBounceMainController:OnUpdate(deltaTimeMS)
  if self.coreController then
    self.coreController:OnUpdate(deltaTimeMS)
  end
  if self.inputView then
    self.inputView:OnUpdate()
  end
end

function UIBounceMainController:InitWidget()
  self._atlas = self:GetAsset("UIN28MinigameIn.spriteatlas", LoadType.SpriteAtlas)
  self.gameCanvasRt = self:GetUIComponent("RectTransform", "gameCanvas")
  self.uiGo = self:GetGameObject("ui")
  self.backBtnGo = self:GetGameObject("backBtn")
  self.scoreGo = self:GetGameObject("score")
  self.txtCurScore = self:GetUIComponent("UILocalizationText", "txtCurScore")
  self.txtHistoryScore = self:GetUIComponent("UILocalizationText", "txtHistoryScore")
  self.historyScoreGo = self:GetGameObject("historyScore")
  local inputPool = self:GetUIComponent("UISelectObjectPath", "input")
  self.inputView = inputPool:SpawnObject("UIBounceInput")
  self.inputGo = self:GetGameObject("input")
  local preparePool = self:GetUIComponent("UISelectObjectPath", "prepare")
  self.prepareView = preparePool:SpawnObject("UIBouncePrepare")
  self.prepareGo = self:GetGameObject("prepare")
  local resultPool = self:GetUIComponent("UISelectObjectPath", "result")
  self.resultView = resultPool:SpawnObject("UIBounceResult")
  self.resultGo = self:GetGameObject("result")
  local resumePool = self:GetUIComponent("UISelectObjectPath", "resume")
  self.resumeView = resumePool:SpawnObject("UIBounceResume")
  self.resumeGo = self:GetGameObject("resume")
  local pausePool = self:GetUIComponent("UISelectObjectPath", "pause")
  self.pauseView = pausePool:SpawnObject("UIBouncePause")
  self.pauseGo = self:GetGameObject("pause")
  self.backBtn = self:GetGameObject("backBtn")
  self.historyScore = self:GetGameObject("historyScore")
  self.curScore = self:GetGameObject("curScore")
  self._anim = self:GetUIComponent("Animation", "root")
  self.historyScoreItems = {}
  self.curScoreItems = {}
  for i = 1, 4 do
    self.historyScoreItems[i] = self.historyScore.transform:GetChild(i - 1):GetComponent(typeof(UnityEngine.UI.Image))
    self.curScoreItems[i] = self.curScore.transform:GetChild(i - 1):GetComponent(typeof(UnityEngine.UI.Image))
  end
  self.slider = self:GetUIComponent("Slider", "slider")
  self.historyScorePar = self:GetGameObject("historyScorePar")
  self.hpGo = self:GetGameObject("HP")
  self.aniBgs = self:GetGameObject("aniBgs")
  self.bossBgs = self:GetGameObject("bossBgs")
  self.nowGo = self:GetGameObject("now")
  self.maxGo = self:GetGameObject("max")
  self.lv1Go = self:GetGameObject("LV1")
  self.moveNode1Go = self:GetGameObject("MoveNode1")
  self.lv2Go = self:GetGameObject("LV2")
  self.night = self:GetGameObject("night")
  self.bossImage = self:GetUIComponent("RawImageLoader", "bossBg")
  self.BossMoveNode1 = self:GetGameObject("BossMoveNode1")
  self.BossMoveNode2 = self:GetGameObject("BossMoveNode2")
  self.BossMoveNode3 = self:GetGameObject("BossMoveNode3")
  self.bossThrone = self:GetGameObject("Throne")
  self.nowHp = {}
  self.maxHp = {}
  for i = 1, 2 do
    self.nowHp[i] = self.nowGo.transform:GetChild(i - 1):GetComponent(typeof(UnityEngine.UI.Image))
    self.maxHp[i] = self.maxGo.transform:GetChild(i - 1):GetComponent(typeof(UnityEngine.UI.Image))
  end
  self.bgRaws = {}
  local bgMark = 4
  for i = 1, bgMark do
    self.bgRaws[i] = self.lv1Go.transform:GetChild(i - 1):GetComponent(typeof(RawImageLoader))
  end
  for i = 1, self.moveNode1Go.transform.childCount do
    self.bgRaws[i + bgMark] = self.moveNode1Go.transform:GetChild(i - 1):GetComponent(typeof(RawImageLoader))
  end
  self.bgImgs = {}
  for i = 1, self.lv2Go.transform.childCount do
    self.bgImgs[i] = self.lv2Go.transform:GetChild(i - 1):GetComponent(typeof(UnityEngine.UI.Image))
  end
  self.guideRt = {}
  for i = 1, 8 do
    local key = "guide542008" .. i
    local guideRt = self:GetUIComponent("RectTransform", key)
    self.guideRt[key] = guideRt
  end
  for i = 1, 6 do
    local key = "guide542009" .. i
    local guideRt = self:GetUIComponent("RectTransform", key)
    self.guideRt[key] = guideRt
  end
  self.guideRt.guide5420111 = self:GetUIComponent("RectTransform", "guide5420111")
  self.guideRt.guide5420121 = self:GetUIComponent("RectTransform", "guide5420121")
end

function UIBounceMainController:InitView()
  self.resultView:Init(function()
    if self:CheckActivityOver() then
      return
    end
    self:QuickGame()
  end, function()
    if self:CheckActivityOver() then
      return
    end
    self:RestartGame()
  end)
  self.resumeView:Init(function()
    self.coreController:ChgFsmState(StateBounce.Battle)
  end)
  self.pauseView:Init(function()
    if not self.coreController:IsOvering() then
      self.backBtn:SetActive(true)
      self.coreController:ChgFsmState(StateBounce.Over)
    end
  end, function()
    if not self.coreController:IsOvering() then
      self.backBtn:SetActive(true)
      self.coreController:ChgFsmState(StateBounce.Resume)
      self:PlayAllMove()
    end
  end)
  self.inputView:Init(function(fromPC)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BoucneInfo)
    self.coreController:OnAttack(fromPC)
  end, function(fromPC)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BoucneInfo)
    self.coreController:OnJump(fromPC)
  end)
  for i = 1, 4 do
    self.historyScoreItems[i].sprite = self._atlas:GetSprite("N28_yrj_jngq_figure0" .. 0)
    self.curScoreItems[i].sprite = self._atlas:GetSprite("N28_yrj_jngq_figure0" .. 0)
  end
  for i = 1, 2 do
    self.maxHp[i].sprite = self._atlas:GetSprite("N28_yrj_jngq_figure1" .. 9)
    self.nowHp[i].sprite = self._atlas:GetSprite("N28_yrj_jngq_figure1" .. 0)
  end
  self.aniBgs:SetActive(not self.isBoss)
  self.bossBgs:SetActive(self.isBoss)
  self.hpGo:SetActive(false)
  local index = math.random(1, 3)
  for i = 1, #self.bgRaws do
    local str = UIN28GronruGameConst.bgData[index][1][i]
    self.bgRaws[i]:LoadImage(str)
  end
  for i = 1, #self.bgImgs do
    local str = UIN28GronruGameConst.bgData[index][2][i]
    self.bgImgs[i].sprite = self._atlas:GetSprite(str)
  end
  self.night:SetActive(index == 3)
  local str = self.levelId == 7 and "N28_yrj_gzdt_cbbg06" or "N28_yrj_gzdt_cbbg01"
  self.bossImage:LoadImage(str)
  self:CreateMoveNode()
end

function UIBounceMainController:InitCore()
  self.coreController = BounceController:New()
  self.coreController:Init(self, self.levelId, self.selectPlayer, self.historyBestScore)
  self.coreController:SetPlayerChangeStateRefUICallFun(function(isLeaveGround)
    self.inputView:ChangeJumpAttackBtnActive(isLeaveGround)
  end)
  self.historyScorePar:SetActive(self.levelId == 7)
  self:SetHistoryScore()
end

function UIBounceMainController:GetPrepareView()
  return self.prepareView, self.prepareGo
end

function UIBounceMainController:GetResultView()
  return self.resultView, self.resultGo
end

function UIBounceMainController:GetResumeView()
  return self.resumeView, self.resumeGo
end

function UIBounceMainController:GetPauseView()
  return self.pauseView, self.pauseGo
end

function UIBounceMainController:SetViewVisibleByBouceState(state)
  self.prepareGo:SetActive(state == StateBounce.Prepare)
  self.resultGo:SetActive(false)
  self.resumeGo:SetActive(state == StateBounce.Resume)
  self.pauseGo:SetActive(state == StateBounce.Pause)
  self.inputGo:SetActive(true)
end

function UIBounceMainController:BackBtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BoucneInfo)
  if self.coreController:IsOvering() then
    self:CloseDialog()
    return
  end
  self.backBtn:SetActive(false)
  self.coreController:ChgFsmState(StateBounce.Pause)
  self:PauseAllMove()
end

function UIBounceMainController:QuickGame()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BoucneInfo)
  self.coreController:OnQuick()
  self:CloseDialog()
end

function UIBounceMainController:RestartGame()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BoucneInfo)
  for i = 1, 4 do
    self.curScoreItems[i].sprite = self._atlas:GetSprite("N28_yrj_jngq_figure0" .. 0)
  end
  self.coreController:GetGameData():AddHistoryBestScore()
  self.coreController:OnRestartGame()
  self:SetHistoryScore()
  self.hpGo:SetActive(false)
  self.slider.value = 1
  self:StartMoveBG()
end

function UIBounceMainController:GetCanvasRt()
  return self.gameCanvasRt
end

function UIBounceMainController:MonsterDead(monsterId)
end

function UIBounceMainController:ScoreChange(score)
  local res = UIN28GronruGameConst.GetScoreFont(score)
  for i = 1, 4 do
    self.curScoreItems[i].sprite = self._atlas:GetSprite("N28_yrj_jngq_figure0" .. res[i])
  end
end

function UIBounceMainController:ShowHPProgress(serializeId, maxValue)
  local nums = UIN28GronruGameConst.GetScoreFont(maxValue)
  for i = 1, 2 do
    self.nowHp[i].sprite = self._atlas:GetSprite("N28_yrj_jngq_figure1" .. nums[i + 2])
    self.maxHp[i].sprite = self._atlas:GetSprite("N28_yrj_jngq_figure1" .. nums[i + 2])
  end
  self.hpGo:SetActive(true)
end

function UIBounceMainController:HideHPProgress(serializeId)
  self.hpGo:SetActive(false)
end

function UIBounceMainController:HPProgressChange(serializeId, currentValue, maxValue)
  local nums
  for i = 1, 2 do
    nums = UIN28GronruGameConst.GetScoreFont(currentValue)
    self.nowHp[i].sprite = self._atlas:GetSprite("N28_yrj_jngq_figure1" .. nums[i + 2])
    nums = UIN28GronruGameConst.GetScoreFont(maxValue)
    self.maxHp[i].sprite = self._atlas:GetSprite("N28_yrj_jngq_figure1" .. nums[i + 2])
  end
  self.slider.value = currentValue / maxValue
end

function UIBounceMainController:BounceMissionSettle(missionId, killNum, killBossNum, cost_time, callback)
  self:StartTask(function(TT)
    local asyncRes = AsyncRequestRes:New()
    asyncRes = self._component:HandleBounceMissionSettle(TT, asyncRes, missionId, killNum, killBossNum, cost_time, callback)
    if not (asyncRes and asyncRes:GetSucc()) or callback then
    end
  end)
end

function UIBounceMainController:ShowResult()
  local data = self.coreController:GetGameData().targetMonster
  self:StartTask(function(TT)
    self:Lock("UIBounceMainController:ShowResult")
    local res = AsyncRequestRes:New()
    self._campaign:ReLoadCampaignInfo_Force(TT, res)
    self:PlayMissionStory(self.levelId)
    self:StopAllMove()
    self:UnLock("UIBounceMainController:ShowResult")
  end, self)
end

function UIBounceMainController:PlayMissionStory(index)
  local roleId = self._loginModule:GetRoleShowID()
  local key = index
  if UIN28GronruGameConst.CheckStoryLocalDb(roleId, key, false) then
    self.resultGo:SetActive(true)
    self.resultView:FlushUI(self.coreController:GetGameData())
    return
  end
  local storyId = self.coreController:GetGameData().levelCfg.LastStoryId
  if storyId then
    if index == 6 then
      if self.coreController:GetGameData():GetKilledBoss() then
        GameGlobal.GetModule(StoryModule):StartStory(storyId, function()
          UIN28GronruGameConst.SetStoryLocalDb(roleId, key, false)
          self.resultGo:SetActive(true)
          self.resultView:FlushUI(self.coreController:GetGameData())
        end)
      else
        self.resultGo:SetActive(true)
        self.resultView:FlushUI(self.coreController:GetGameData())
      end
    else
      GameGlobal.GetModule(StoryModule):StartStory(storyId, function()
        UIN28GronruGameConst.SetStoryLocalDb(roleId, key, false)
        self.resultGo:SetActive(true)
        self.resultView:FlushUI(self.coreController:GetGameData())
      end)
    end
  else
    self.resultGo:SetActive(true)
    self.resultView:FlushUI(self.coreController:GetGameData())
  end
end

function UIBounceMainController:SetHistoryScore()
  local data = self.coreController:GetGameData()
  local res = UIN28GronruGameConst.GetScoreFont(data.historyBestScore)
  for i = 1, 4 do
    self.historyScoreItems[i].sprite = self._atlas:GetSprite("N28_yrj_jngq_figure0" .. res[i])
  end
end

function UIBounceMainController:StartAnim()
  self:StartTask(function(TT)
    self:Lock("UIBounceMainController:StartAnim")
    local anistr = self.levelId >= 6 and self.aniName[2] or self.aniName[1]
    self._anim:Play(anistr)
    YIELD(TT, 333)
    self:UnLock("UIBounceMainController:StartAnim")
  end)
end

function UIBounceMainController:GetGuideRt(guideStepKey)
  return self.guideRt[guideStepKey]
end

function UIBounceMainController:SetGuideStepShow(guideStepKey)
  local rt = self.guideRt[guideStepKey]
  if rt then
    rt.gameObject:SetActive(true)
  end
end

function UIBounceMainController:SetGuidePosition(key, position)
  local rt = self:GetGuideRt(key)
  if rt then
    rt.anchoredPosition = position
  end
end

function UIBounceMainController:CheckActivityOver()
  local closeTime = self._endTime
  local nowtime = self._svrTimeModule:GetServerTime() / 1000
  if closeTime < nowtime then
    self:CloseDialog()
    return true
  end
  return false
end

function UIBounceMainController:CreateMoveNode()
  if self.isBoss then
    for i = 1, 3 do
      local copyMoveNode1 = UnityEngine.GameObject.Instantiate(self["BossMoveNode" .. i], self["BossMoveNode" .. i].transform)
      copyMoveNode1.transform.localPosition = Vector3(math.abs(UIN28GronruGameConst["BossNodeMoveX_" .. i]), 0, 0)
    end
  else
    local copyMoveNode1 = UnityEngine.GameObject.Instantiate(self.moveNode1Go, self.moveNode1Go.transform)
    copyMoveNode1.transform.localPosition = Vector3(math.abs(UIN28GronruGameConst.plainMoveX), 0, 0)
    local copyLv2 = UnityEngine.GameObject.Instantiate(self.lv2Go, self.lv2Go.transform)
    copyLv2.transform.localPosition = Vector3(math.abs(UIN28GronruGameConst.smallItemsMoveX), 0, 0)
  end
  self:StartMoveBG()
end

function UIBounceMainController:StartMoveBG()
  if self.isBoss then
    self.bossThrone:SetActive(false)
    self:MoveBOSSBG_1()
    self:MoveBOSSBG_2()
    self:MoveBOSSBG_3()
  else
    self:MoveBG_MoveNode1()
    self:MoveBG_Lv2()
  end
end

function UIBounceMainController:MoveBG_MoveNode1()
  self.moveNode1Go.transform.localPosition = Vector3.zero
  local t = math.abs(UIN28GronruGameConst.plainMoveX / UIN28GronruGameConst.plainMoveSpeed)
  self.moveNode1Go.transform:DOLocalMoveX(UIN28GronruGameConst.plainMoveX, t):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
    self:MoveBG_MoveNode1()
  end)
end

function UIBounceMainController:MoveBG_Lv2()
  self.lv2Go.transform.localPosition = Vector3.zero
  local t = math.abs(UIN28GronruGameConst.smallItemsMoveX / UIN28GronruGameConst.smallItemsMoveSpeed)
  self.lv2Go.transform:DOLocalMoveX(UIN28GronruGameConst.smallItemsMoveX, t):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
    self:MoveBG_Lv2()
  end)
end

function UIBounceMainController:MoveBOSSBG_1()
  self.BossMoveNode1.transform.localPosition = Vector3.zero
  local t = math.abs(UIN28GronruGameConst.BossNodeMoveX_1 / UIN28GronruGameConst.BossNodeMoveSpeed_1)
  self.BossMoveNode1.transform:DOLocalMoveX(UIN28GronruGameConst.BossNodeMoveX_1, t):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
    self:MoveBOSSBG_1()
  end)
end

function UIBounceMainController:MoveBOSSBG_2()
  self.BossMoveNode2.transform.localPosition = Vector3.zero
  local t = math.abs(UIN28GronruGameConst.BossNodeMoveX_2 / UIN28GronruGameConst.BossNodeMoveSpeed_2)
  self.BossMoveNode2.transform:DOLocalMoveX(UIN28GronruGameConst.BossNodeMoveX_2, t):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
    self:MoveBOSSBG_2()
  end)
end

function UIBounceMainController:MoveBOSSBG_3()
  self.BossMoveNode3.transform.localPosition = Vector3.zero
  local t = math.abs(UIN28GronruGameConst.BossNodeMoveX_3 / UIN28GronruGameConst.BossNodeMoveSpeed_3)
  self.BossMoveNode3.transform:DOLocalMoveX(UIN28GronruGameConst.BossNodeMoveX_3, t):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
    self:MoveBOSSBG_3()
  end)
end

function UIBounceMainController:PauseMoveBOSSBG_ShowBoss()
  self.bossThrone:SetActive(true)
  for i = 1, 3 do
    self["BossMoveNode" .. i].transform:DOKill()
  end
end

function UIBounceMainController:PauseAllMove()
  if self.isBoss then
    for i = 1, 3 do
      self["BossMoveNode" .. i].transform:DOPause()
    end
  else
    self.moveNode1Go.transform:DOPause()
    self.lv2Go.transform:DOPause()
  end
end

function UIBounceMainController:StopAllMove()
  if self.isBoss then
    for i = 1, 3 do
      self["BossMoveNode" .. i].transform:DOKill()
    end
  else
    self.moveNode1Go.transform:DOKill()
    self.lv2Go.transform:DOKill()
  end
end

function UIBounceMainController:PlayAllMove()
  if self.isBoss then
    for i = 1, 3 do
      self["BossMoveNode" .. i].transform:DOPlay()
    end
  else
    self.moveNode1Go.transform:DOPlay()
    self.lv2Go.transform:DOPlay()
  end
end

function UIBounceMainController:OnHide()
  self:StopAllMove()
end

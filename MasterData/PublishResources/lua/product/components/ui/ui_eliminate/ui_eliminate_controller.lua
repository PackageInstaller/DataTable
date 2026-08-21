_class("UIEliminateController", UIController)
UIEliminateController = UIEliminateController

function UIEliminateController:Constructor()
end

function UIEliminateController:LoadDataOnEnter(TT, res)
  self._anipopModule = GameGlobal.GetModule(AnipopModule)
  res = self._anipopModule:RequestAnipopInfo(TT)
  if not res:GetSucc() then
    Log.fatal("请求消灭星星数据失败:", res:GetResult())
  end
end

function UIEliminateController:OnShow(uiParams)
  self:AttachEvent(GameEventType.AniPopRoundRes, self.InitComponent)
  self:AttachEvent(GameEventType.AniPopRefreshRedPoint, self.AniPopRefreshRedPoint)
  self._isEnd = uiParams[1]
  local isAllPass = uiParams[2]
  self:_GetComponent()
  self:InitComponent()
  if self._isEnd then
    self:ShowDialog("UIEliminateResultController", isAllPass)
  end
  self:CheckRoundOver()
  self:_CheckGuide()
end

function UIEliminateController:OnHide()
  if self._countTimer then
    GameGlobal.Timer():CancelEvent(self._countTimer)
    self._countTimer = nil
  end
end

function UIEliminateController:_GetComponent()
  local topBarPool = self:GetUIComponent("UISelectObjectPath", "CommonTopBar")
  local topBtns = topBarPool:SpawnObject("UINewCommonTopButton")
  topBtns:SetData(function()
    self:_Close()
  end, function()
    self:ShowDialog("UIHelpController", "UIEliminateController")
  end)
  self._endTimeTxt = self:GetUIComponent("UILocalizationText", "endTimeTxt")
  self._enemyAttrIcon = self:GetUIComponent("Image", "enemyAttrIcon")
  self._enemyAttrTxt = self:GetUIComponent("UILocalizationText", "enemyAttrTxt")
  self._scoreValueTxt = self:GetUIComponent("UILocalizationText", "scoreValueTxt")
  self._exploreValueTxt = self:GetUIComponent("UILocalizationText", "exploreValueTxt")
  self._progressValueTxt = self:GetUIComponent("UILocalizationText", "progressValueTxt")
  self._difficultyTxt = self:GetUIComponent("UILocalizationText", "difficultyTxt")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._eff = self:GetUIComponent("RawImage", "eff")
  self._screenShot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  self._completeGO = self:GetGameObject("Complete")
  self._startGO = self:GetGameObject("Start")
  self._continueGO = self:GetGameObject("Continue")
  self._redPointObj = self:GetGameObject("redPoint")
  self._eliminateAtlas = self:GetAsset("UIEliminate.spriteatlas", LoadType.SpriteAtlas)
  self._propertyAtlas = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
end

function UIEliminateController:InitComponent()
  local anipopInfo = self._anipopModule:GetAniPopInfo()
  self._curSeason = anipopInfo.cur_season
  local seasonCfg = Cfg.cfg_anipop_season[self._curSeason]
  local usingID = anipopInfo.relic_info.init_skill_relic
  self._enemyAttrIcon.sprite = self._propertyAtlas:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(Cfg.cfg_pet_element[seasonCfg.MonsterAttId].Icon))
  local roundInfo = anipopInfo.round_info
  if roundInfo.select_hard_id ~= 0 then
    self._completeGO:SetActive(true)
    self._continueGO:SetActive(true)
    self._startGO:SetActive(false)
    local levelProcessTxt = roundInfo.mission_index .. "/" .. table.count(roundInfo.level_list)
    self._progressValueTxt:SetText(StringTable.Get("str_eliminate_progress", levelProcessTxt))
    self._difficultyTxt:SetText(StringTable.Get("str_eliminate_difficulty", roundInfo.select_hard_id))
  else
    self._completeGO:SetActive(false)
    self._continueGO:SetActive(false)
    self._startGO:SetActive(true)
  end
  self:EndOldRoundInfo()
  local weekInfo = anipopInfo.week_info
  if weekInfo then
    local curHardID = anipopInfo.cur_hard_id
    local hardCfg = Cfg.cfg_anipop_hard[curHardID]
    local scoreHardID = anipopInfo.week_info.hard_id
    local scoreHardCfg = Cfg.cfg_anipop_hard[scoreHardID]
    local showTotalScore = math.min(weekInfo.total_score, scoreHardCfg.MaxScore)
    self._scoreValueTxt:SetText("<color=#ffffff>" .. showTotalScore .. "</color>/" .. scoreHardCfg.MaxScore)
    local dropMax = hardCfg.DropMax
    if EliminateHelper.IsAniPopUseNewCfg() then
      dropMax = hardCfg.NewDropMax
    end
    self._exploreValueTxt:SetText(weekInfo.search_reward_num .. "/" .. dropMax)
  else
    Log.fatal("weekInfo错误，为空")
  end
  self:CountDown()
  self._countTimer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:CountDown()
  end)
  self:CheckAwardRed()
end

function UIEliminateController:CheckRoundOver()
  local aniPopInfo = self._anipopModule:GetAniPopInfo()
  local roundInfo = aniPopInfo.round_info
  local leftHP = math.floor(roundInfo.team_blood * 100)
  if leftHP == 0 then
    self:ShowDialog("UIEliminateResultController")
  end
end

function UIEliminateController:CheckAwardRed()
  self._redPointObj:SetActive(EliminateHelper.CheckAwardRed())
end

function UIEliminateController:_Close()
  self:StartTask(function(TT)
    self._screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
    local rt = self._screenShot:RefreshBlurTexture()
    local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    UnityEngine.Graphics.Blit(rt, cache_rt)
    YIELD(TT)
    self._eff.texture = rt
    self:Lock("uieff_UIEliminateController_out")
    self._anim:Play("uieff_UIEliminateController_out")
    YIELD(TT, 500)
    self:UnLock("uieff_UIEliminateController_out")
    self:SwitchState(UIStateType.UIDiscovery)
  end)
end

function UIEliminateController:CountDown()
  if not tolua.isnull(self._endTimeTxt) then
    local endTime = self._anipopModule.end_time
    local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
    local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
    local timeTxt = StringTable.Get("str_eliminate_time", UITimerHelper.GetTimeString(endTime - curTime))
    self._endTimeTxt:SetText(timeTxt)
    if endTime - curTime <= 0 then
      self:StartTask(function(TT)
        if self:LoadData(TT) then
          self:InitComponent()
        else
          self:SwitchState(UIStateType.UIDiscovery)
        end
      end)
      return
    end
  end
end

function UIEliminateController:SupportCampOnClick(go)
  local seasonCfg = Cfg.cfg_anipop_season[self._curSeason]
  self:ShowDialog("UIEliminateSupportCampController", seasonCfg.FettersId)
end

function UIEliminateController:FettersOnClick(go)
  local seasonCfg = Cfg.cfg_anipop_season[self._curSeason]
  self:ShowDialog("UIEliminateFettersController", seasonCfg.FettersId)
end

function UIEliminateController:TotalScoreOnClick(go)
  self:ShowDialog("UIEliminateAwardController")
end

function UIEliminateController:StartOnClick(go)
  self:ShowDialog("UIEliminateDiffController")
end

function UIEliminateController:ContinueOnClick(go)
  self:ShowDialog("UIEliminateLevelController")
end

function UIEliminateController:CompleteOnClick(go)
  local title = StringTable.Get("str_eliminate_res_tip")
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", title, function()
    self:ShowDialog("UIEliminateResultController")
  end)
end

function UIEliminateController:_CheckGuide()
  local guideModule = GameGlobal.GetModule(GuideModule)
  if not guideModule:IsGuideDone(128102) then
    self:ShowDialog("UIStoryController", 50690101, function()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIEliminateController2)
    end)
  end
end

function UIEliminateController:StoryBtnOnClick()
  self:ShowDialog("UIStoryController", 50690101)
end

function UIEliminateController:EndOldRoundInfo()
  local anipopInfo = self._anipopModule:GetAniPopInfo()
  local usingID = anipopInfo.relic_info.init_skill_relic
  if usingID == 0 then
    local roundInfo = anipopInfo.round_info
    if roundInfo.select_hard_id ~= 0 then
      local title = StringTable.Get("str_eliminate_season_switch_tip1")
      PopupManager.Alert("UIEliminateMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", title, function()
        self:ShowDialog("UIEliminateResultController", false)
      end)
    end
    local defaultSkillID = Cfg.cfg_eliminate_relic_book({Type = 1, IsDefault = true})[1].ItemID
    self:StartTask(function(TT)
      local res = self._anipopModule:AnipopChangeSkill(TT, defaultSkillID)
      if res:GetSucc() then
      else
        Log.fatal("装备初始技能失败！！！", res:GetResult())
      end
    end)
  end
end

function UIEliminateController:LoadData(TT)
  local res = self._anipopModule:RequestAnipopInfo(TT)
  if res:GetSucc() then
    return true
  else
    Log.fatal("请求启迪互联数据失败")
    return false
  end
end

function UIEliminateController:BookOnClick()
  self:ShowDialog("UIEliminateBookController")
end

function UIEliminateController:AniPopRefreshRedPoint()
  self:CheckAwardRed()
end

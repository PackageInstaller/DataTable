_class("UIEliminateAwardController", UIController)
UIEliminateAwardController = UIEliminateAwardController

function UIEliminateAwardController:Constructor()
end

function UIEliminateAwardController:OnShow(uiParams)
  self.atlas = self:GetAsset("UIEliminate.spriteatlas", LoadType.SpriteAtlas)
  self:_GetComponent()
  self:InitComponent()
end

function UIEliminateAwardController:OnHide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AniPopRoundRes)
end

function UIEliminateAwardController:_GetComponent()
  self._scoreTxt = self:GetUIComponent("UILocalizationText", "scoreTxt")
  self._awardArea = self:GetUIComponent("UISelectObjectPath", "awardArea")
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UIEliminateAwardController:InitComponent()
  local anipopModule = GameGlobal.GetModule(AnipopModule)
  local anipopInfo = anipopModule:GetAniPopInfo()
  local weekInfo = anipopInfo.week_info
  local scoreHardID = weekInfo.hard_id
  local scoreHardCfg = Cfg.cfg_anipop_hard[scoreHardID]
  local showTotalScore = math.min(weekInfo.total_score, scoreHardCfg.MaxScore)
  local scoreProcess = "<color=#ffe288>" .. showTotalScore .. "/" .. scoreHardCfg.MaxScore .. "</color>"
  local awardList = EliminateHelper.GetAwardList()
  self._scoreTxt:SetText(StringTable.Get("str_eliminate_award_title_1", scoreProcess))
  self._awards = self._awardArea:SpawnObjects("UIEliminateAwardItem", #awardList)
  for i, award in pairs(self._awards) do
    award:SetData(awardList[i], i, function(cfgID)
      self:StartTask(function(TT)
        self:GetAllReward(TT)
      end, self)
    end, function(id, pos)
      self:OnItemSelect(id, pos)
    end)
  end
end

function UIEliminateAwardController:OnItemSelect(id, pos)
  if not self._selectInfo then
    local selectInfoPool = self:GetUIComponent("UISelectObjectPath", "selectInfoPool")
    self._selectInfo = selectInfoPool:SpawnObject("UISelectInfo")
  end
  self._selectInfo:SetData(id, pos)
end

function UIEliminateAwardController:FullBtnOnClick()
  self:_Close()
end

function UIEliminateAwardController:_Close()
  self:StartTask(function(TT)
    self:Lock("uieff_UIEliminateAwardController_out")
    self._anim:Play("uieff_UIEliminateAwardController_out")
    YIELD(TT, 500)
    self:UnLock("uieff_UIEliminateAwardController_out")
    self:CloseDialog()
  end)
end

function UIEliminateAwardController:GetAllReward(TT)
  local showReward = {}
  local anipopModule = GameGlobal.GetModule(AnipopModule)
  self:Lock("UIEliminateAwardController_GetReward")
  for _, award in pairs(self._awards) do
    local score = award:GetScore()
    local cfgID = award:GetCfgID()
    if self:CheckAwardCanReceive(cfgID, score) then
      local res, rewards = anipopModule:GetReward(TT, cfgID)
      if res:GetSucc() then
        for _, v in pairs(rewards) do
          table.insert(showReward, v)
        end
      else
        Log.fatal("奖励领取失败：", res:GetResult())
      end
    end
  end
  self:UnLock("UIEliminateAwardController_GetReward")
  self:ShowDialog("UIGetItemController", showReward, function()
    self:InitComponent()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AniPopRefreshRedPoint)
  end)
end

function UIEliminateAwardController:CheckAwardCanReceive(cfgID, score)
  local anipopModule = GameGlobal.GetModule(AnipopModule)
  local anipopInfo = anipopModule:GetAniPopInfo()
  local weekInfo = anipopInfo.week_info
  if score <= weekInfo.total_score and not table.icontains(weekInfo.score_received, cfgID) then
    return true
  else
    return false
  end
end

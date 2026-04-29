_class("UIEliminateChooseCardController", UIController)
UIEliminateChooseCardController = UIEliminateChooseCardController

function UIEliminateChooseCardController:Constructor()
  self._count = 3
  self._cardIndex = 0
  self._timeOut = false
  self._relicTab = {}
  self._itemTab = {}
  self._allLeftTime = 0
  self._init = false
  self._resetItemCfgs = {}
  self._rerollID = 0
end

function UIEliminateChooseCardController:OnShow(uiParam)
  self._anipopModule = GameGlobal.GetModule(AnipopModule)
  self._atlas = self:GetAsset("UIEliminate.spriteatlas", LoadType.SpriteAtlas)
  self._itemModule = self:GetModule(ItemModule)
  self._cfg_item = Cfg.cfg_item({})
  self._levelIndex = uiParam[1]
  self._isInGame = uiParam[3]
  if uiParam[2] then
    self._timeOut = true
    for index, relic in ipairs(uiParam[2]) do
      if relic.id then
        self._relicTab[index] = relic.id
      else
        self._relicTab[index] = relic.assetid
      end
    end
  else
    local gameMatchModule = self:GetModule(GameMatchModule)
    local matchResult = UI_MatchResult:New()
    matchResult = gameMatchModule:GetMachResult()
    local tempRelics = matchResult.m_ext_star_rewards
    for i = 1, table.count(tempRelics) do
      self._relicTab[i] = tempRelics[i].assetid
    end
  end
  self:GetComponents()
  self:InitComponent()
  self:SetRefreshTime()
  local funcModule = self:GetModule(RoleModule).uiModule
  funcModule:LockAchievementFinishPanel(false)
end

function UIEliminateChooseCardController:OnHide()
end

function UIEliminateChooseCardController:GetComponents()
  local pos1 = self:GetUIComponent("RectTransform", "pos1")
  local pos2 = self:GetUIComponent("RectTransform", "pos2")
  local pos3 = self:GetUIComponent("RectTransform", "pos3")
  self._posTab = {
    pos1,
    pos2,
    pos3
  }
  self._itemPool = self:GetUIComponent("UISelectObjectPath", "itemPool")
  self._randomTime = self:GetUIComponent("UILocalizationText", "randomTime")
  self._chooseBtn = self:GetUIComponent("Image", "chooseBtn")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._randomBtnObj = self:GetGameObject("randomBtn")
  self._chooseBtnTxt = self:GetUIComponent("UILocalizationText", "chooseBtnTxt")
end

function UIEliminateChooseCardController:InitComponent()
  self._cardIndex = 0
  self._chooseBtn.sprite = self._atlas:GetSprite("qdhl_new_icon07")
  self._chooseBtnTxt.color = Color(0.30980392156862746, 0.24705882352941178, 0.043137254901960784)
  self._itemPool:SpawnObjects("UIEliminateChooseCardItem", self._count)
  self._itemTab = self._itemPool:GetAllSpawnList()
  for i = 1, self._count do
    self._itemTab[i]:SetData(i, self._relicTab[i], self._posTab[i].position, function(index)
      self:CardClick(index)
    end, function(index)
      self:ChooseClick(index)
    end)
    self._itemTab[i]._card.gameObject.name = i - 1
  end
end

function UIEliminateChooseCardController:CardClick(index)
  if self._cardIndex == index then
    return
  end
  self._cardIndex = index
  for i = 1, self._count do
    if i == self._cardIndex then
      self._itemTab[i]:CancelOrSelect(true)
    else
      self._itemTab[i]:CancelOrSelect(false)
    end
  end
  self._chooseBtn.sprite = self._atlas:GetSprite("map_gezi4_frame")
  self._chooseBtnTxt.color = Color(0.592156862745098, 0.4666666666666667, 0)
end

function UIEliminateChooseCardController:ChooseBtnOnClick()
  if self._cardIndex ~= 0 then
    GameGlobal.TaskManager():StartTask(self._ChooseCallback, self)
  end
end

function UIEliminateChooseCardController:_ChooseCallback(TT)
  self:Lock("UIRugueLikeChooseCardControllerchooseBtnOnClick")
  local res, relics = self._anipopModule:RequestSelectRelic(TT, self._relicTab[self._cardIndex])
  self:UnLock("UIRugueLikeChooseCardControllerchooseBtnOnClick")
  if res:GetSucc() then
    if relics and table.count(relics) > 0 then
      self._relicTab = {}
      for index, relic in ipairs(relics) do
        if relic.id then
          self._relicTab[index] = relic.id
        else
          self._relicTab[index] = relic.assetid
        end
      end
      self:InitComponent()
      self:SetRefreshTime()
      self:Lock("UIEliminateChooseCardController:RandomBtnOnClick")
      self._anim:Play("uieff_ChooseCard_In")
      YIELD(TT, 1534)
      self:UnLock("UIEliminateChooseCardController:RandomBtnOnClick")
    elseif self._timeOut == false then
      self:ShowDialog("UIEliminateBattleResultController", true, self._levelIndex)
    else
      local anipopModule = GameGlobal.GetModule(AnipopModule)
      local anipopInfo = anipopModule:GetAniPopInfo()
      local roundInfo = anipopInfo.round_info
      local levelInfo = roundInfo.level_list[roundInfo.mission_index]
      if self._isInGame then
        self:ShowDialog("UIEliminateBattleResultController", true, self._levelIndex)
      elseif not anipopInfo or not levelInfo then
        GameGlobal.UIStateManager():SwitchState(UIStateType.UIEliminateController)
        ToastManager.ShowToast(StringTable.Get("str_pet_config_pet_error_faild19"))
      else
        self:SwitchState(UIStateType.UIEliminateLevelController)
      end
    end
  else
    local result = res:GetResult()
    Log.error("###[UIEliminateChooseCardController] RequestSelectRelic fail ! result --> ", result)
    self:SwitchState(UIStateType.UIEliminateController)
  end
end

function UIEliminateChooseCardController:SetRefreshTime()
  self._rerollID = 0
  local anipopInfo = self._anipopModule:GetAniPopInfo()
  local relicInfo = anipopInfo.relic_info
  local relicBag = relicInfo.relics
  local relicCounters = relicInfo.relic_counters
  self._resetItemCfgs = {}
  for _, relicID in pairs(relicBag) do
    local cfg = Cfg.cfg_item_relic[relicID]
    if cfg.OutGameEffectType == AnipopRelicOutGameEffectType.AnipopRandAgain then
      table.insert(self._resetItemCfgs, cfg)
    end
  end
  local totalCfgTime = 0
  local leftTime = 0
  for _, cfg in pairs(self._resetItemCfgs) do
    local itemUseTime = relicCounters[cfg.ID] or 0
    local itemLeftTime = cfg.OutGameTriggerCount - itemUseTime
    totalCfgTime = totalCfgTime + cfg.OutGameTriggerCount
    if not self._init then
      self._allLeftTime = itemLeftTime + self._allLeftTime
    end
    leftTime = leftTime + itemLeftTime
    if 0 < itemLeftTime and self._rerollID == 0 then
      self._rerollID = cfg.ID
    end
  end
  if leftTime == 0 then
    self._randomBtnObj:SetActive(false)
  else
    self._randomBtnObj:SetActive(true)
    local tempTxt = leftTime .. "/" .. self._allLeftTime
    if leftTime > self._allLeftTime then
      tempTxt = leftTime .. "/" .. totalCfgTime
    end
    local leftTxt = StringTable.Get("str_eliminate_random_left", tempTxt)
    self._randomTime:SetText(leftTxt)
  end
  self._init = true
end

function UIEliminateChooseCardController:RandomBtnOnClick()
  if self._rerollID ~= 0 then
    self:StartTask(function(TT)
      local res = AsyncRequestRes:New()
      local relicTab = {}
      res, relicTab = self._anipopModule:AnipopUseRelic(TT, self._rerollID)
      if res:GetSucc() then
        self._relicTab = {}
        for index, relic in ipairs(relicTab) do
          if relic.id then
            self._relicTab[index] = relic.id
          else
            self._relicTab[index] = relic.assetid
          end
        end
        self:InitComponent()
        self:SetRefreshTime()
        self:Lock("UIEliminateChooseCardController:RandomBtnOnClick")
        self._anim:Play("uieff_ChooseCard_In")
        YIELD(TT, 1534)
        self:UnLock("UIEliminateChooseCardController:RandomBtnOnClick")
      else
        Log.fatal("重随失败：", res:GetResult())
      end
    end)
  else
    ToastManager.ShowToast(StringTable.Get("str_eliminate_sweep_notime_tip"))
  end
end

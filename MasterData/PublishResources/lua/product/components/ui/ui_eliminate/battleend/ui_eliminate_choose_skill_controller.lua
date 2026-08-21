_class("UIEliminateChooseSkillController", UIController)
UIEliminateChooseSkillController = UIEliminateChooseSkillController

function UIEliminateChooseSkillController:Constructor()
  self._selectItem = nil
  self._skillRewards = {}
end

function UIEliminateChooseSkillController:OnShow(uiParam)
  self._anipopModule = GameGlobal.GetModule(AnipopModule)
  self._levelIndex = uiParam[1]
  self._isInGame = uiParam[3]
  if uiParam[2] then
    for index, relic in ipairs(uiParam[2]) do
      if relic.id then
        self._skillRewards[index] = relic.id
      else
        self._skillRewards[index] = relic.assetid
      end
    end
  else
    local gameMatchModule = self:GetModule(GameMatchModule)
    local matchResult = UI_MatchResult:New()
    matchResult = gameMatchModule:GetMachResult()
    local tempRelics = matchResult.m_ext_skill_rewards
    for i = 1, table.count(tempRelics) do
      self._skillRewards[i] = tempRelics[i].assetid
    end
  end
  self:GetComponents()
  self:InitComponent()
  local funcModule = self:GetModule(RoleModule).uiModule
  funcModule:LockAchievementFinishPanel(false)
end

function UIEliminateChooseSkillController:OnHide()
end

function UIEliminateChooseSkillController:GetComponents()
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UIEliminateChooseSkillController:InitComponent()
  self._itemList = self._pool:SpawnObjects("UIEliminateSkillItem", table.count(self._skillRewards))
  for i, item in pairs(self._itemList) do
    item:SetData(self._skillRewards[i], i, function(item)
      if item == self._selectItem then
        return
      end
      if self._selectItem then
        self._selectItem:SetSelect(false)
      end
      self._selectItem = item
    end, function(item)
      self:StartTask(function(TT)
        local itemID = item:GetID()
        local res, relics = self._anipopModule:RequestSelectRelic(TT, itemID)
        if res:GetSucc() then
          self:Out(relics)
        else
          self:SwitchState(UIStateType.UIEliminateLevelController)
          Log.fatal("选择模块技能失败：", res:GetResult())
        end
      end)
    end)
  end
end

function UIEliminateChooseSkillController:OutBtnOnClick()
  self:StartTask(function(TT)
    local res, relics = self._anipopModule:AnipopConvertRelic(TT)
    if res:GetSucc() then
      self:Out(relics)
    else
      Log.fatal("切换至选启迪装具失败！:", res:GetResult())
    end
  end)
end

function UIEliminateChooseSkillController:Out(relics)
  self:StartTask(function(TT)
    self._anim:Play("uieff_UIEliminateChooseSkillController_out")
    for _, item in pairs(self._itemList) do
      item:PlayOutAnim()
    end
    YIELD(TT, 500)
    if relics then
      self:CloseDialog()
      self:ShowDialog("UIEliminateChooseCardController", self._levelIndex, relics, self._isInGame)
    else
      self:SwitchState(UIStateType.UIEliminateLevelController)
    end
  end)
end

function UIEliminateChooseSkillController:ChooseBtnOnClick()
  if self._selectItem then
    self._selectItem:ChooseItem()
  else
    ToastManager.ShowToast(StringTable.Get("str_eliminate_skill_unchoose_tip"))
  end
end

function UIEliminateChooseSkillController:TestFakeSelect(index)
  self:StartTask(function(TT)
    Log.fatal("选择模块技能，index：", index)
    local itemID = self._skillRewards[index]
    if not itemID then
      self:SwitchState(UIStateType.UIMain)
      Log.fatal("选择模块技能失败，index：", index)
      return
    end
    local res = self._anipopModule:RequestSelectRelic(TT, itemID)
    if res:GetSucc() then
      self:SwitchState(UIStateType.UIMain)
    else
      self:SwitchState(UIStateType.UIMain)
      Log.fatal("选择模块技能失败：", res:GetResult())
    end
  end)
end

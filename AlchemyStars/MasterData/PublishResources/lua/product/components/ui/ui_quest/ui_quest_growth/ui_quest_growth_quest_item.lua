_class("UIQuestGrowthQuestItem", UICustomWidget)
UIQuestGrowthQuestItem = UIQuestGrowthQuestItem

function UIQuestGrowthQuestItem:OnShow(uiParams)
  self._BGNormal = self:GetGameObject("BGNormal")
  self._BGFinish = self:GetGameObject("BGFinish")
  self._questDesc = self:GetUIComponent("UILocalizationText", "questDesc")
  self._questProgress = self:GetUIComponent("UILocalizationText", "questProgress")
end

function UIQuestGrowthQuestItem:OnHide()
end

function UIQuestGrowthQuestItem:SetData(index, quest, callback, anim)
  if not quest then
    Log.fatal("### quest is nil. index=", index)
    return
  end
  self._index = index
  self._quest = quest:QuestInfo()
  self._callback = callback
  self._questModule = GameGlobal.GetModule(QuestModule)
  if self._questModule == nil then
    Log.fatal("[quest] error --> questModule is nil !")
    return
  end
  self:_OnValue()
end

function UIQuestGrowthQuestItem:_OnValue()
  if self._quest == nil then
    Log.fatal("[quest] error --> quest is nil ! id --> " .. self._quest.quest_id)
    return
  end
  if self._quest.status <= QuestStatus.QUEST_Accepted then
    self._BGFinish:SetActive(false)
    self._BGNormal:SetActive(true)
    self._questDesc.color = Color(0.2980392156862745, 0.29411764705882354, 0.29411764705882354, 1)
    self._questProgress.color = Color(0.9019607843137255, 0.9019607843137255, 0.9019607843137255, 1)
  else
    self._BGFinish:SetActive(true)
    self._BGNormal:SetActive(false)
    self._questDesc.color = Color(0.9019607843137255, 0.9019607843137255, 0.9019607843137255, 0.57)
    self._questProgress.color = Color(0.9019607843137255, 0.9019607843137255, 0.9019607843137255, 0.57)
  end
  local progress = ""
  if self._quest.ShowType == 1 then
    local c, d = math.modf(self._quest.cur_progress * 100 / self._quest.total_progress)
    if c < 1 and 0 < d then
      c = 1
    end
    progress = c .. "%"
  elseif self._quest.cur_progress >= self._quest.total_progress then
    progress = self._quest.cur_progress .. "/" .. self._quest.total_progress
  else
    progress = self._quest.cur_progress .. "/" .. self._quest.total_progress
  end
  self._questDesc:SetText(StringTable.Get(self._quest.CondDesc))
  self._questProgress:SetText(progress)
end

function UIQuestGrowthQuestItem:BtnOnClick()
  if self._callback then
    self._callback(self._index)
  end
  if self._quest.status <= QuestStatus.QUEST_Accepted then
    local jumpModule = self._questModule.uiModule
    if jumpModule == nil then
      Log.fatal("[quest] error --> uiModule is nil ! --> jumpModule")
      return
    end
    local fromParam = {}
    table.insert(fromParam, QuestType.QT_Growth)
    jumpModule:SetFromUIData(FromUIType.NormalUI, "UIQuestController", UIStateType.UIMain, fromParam)
    local jumpType = self._quest.JumpID
    local jumpParams = self._quest.JumpParam
    jumpModule:SetJumpUIData(jumpType, jumpParams)
    jumpModule:Jump()
  else
    ToastManager.ShowToast(StringTable.Get("str_quest_base_growth_item_finish"))
  end
end

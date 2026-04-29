local UIQuestDailySpecialType = {DoOneDispatch = 20006, DoThreeDispatch = 20015}
_enum("UIQuestDailySpecialType", UIQuestDailySpecialType)
_class("UIQuestDailyListItem", UICustomWidget)
UIQuestDailyListItem = UIQuestDailyListItem

function UIQuestDailyListItem:OnShow(uiParams)
  self._module = GameGlobal.GetModule(QuestModule)
  if self._module == nil then
    Log.fatal("[quest] erro --> module is nil !")
    return
  end
  self._atlas = self:RootUIOwner():GetAsset("UIQuest.spriteatlas", LoadType.SpriteAtlas)
end

function UIQuestDailyListItem:SetData(index, quest, callback, itemCallback)
  self:_GetComponents()
  self._index = index
  self._quest = quest:QuestInfo()
  self._callback = callback
  self._itemCallback = itemCallback
  self:_OnValue()
  self.rootAnim:Stop()
end

function UIQuestDailyListItem:OnHide()
end

function UIQuestDailyListItem:_GetComponents()
  self._typeTex = self:GetUIComponent("UILocalizationText", "typeTex")
  self._desTex = self:GetUIComponent("UILocalizationText", "desTex")
  self._awardPool = self:GetUIComponent("UISelectObjectPath", "awardPool")
  self._stateValueImg = self:GetUIComponent("Image", "stateValueImg")
  self._stateValueTex = self:GetUIComponent("UILocalizationText", "stateValueTex")
  self._btn = self:GetGameObject("btn")
  self._got = self:GetGameObject("got")
  self._btnImg = self:GetUIComponent("Image", "btn")
  self._btnIcon = self:GetUIComponent("Image", "icon")
  self._btnTex = self:GetUIComponent("UILocalizationText", "stateTex")
  self._mask = self:GetGameObject("mask")
  self._select = self:GetGameObject("select")
  self._bg = self:GetGameObject("bg")
  self._daliyValueTex = self:GetUIComponent("UILocalizationText", "daliyValueTex")
  self.rootAnim = self:GetUIComponent("Animation", "UIQuestDailyListItem")
  self.canvasGroup = self:GetUIComponent("CanvasGroup", "UIQuestDailyListItem")
end

function UIQuestDailyListItem:InitAnim()
  self.rootAnim:Stop()
  self.canvasGroup.alpha = 0
end

function UIQuestDailyListItem:PlayAnim(index)
  self.rootAnim.enabled = false
  self.rootAnim.enabled = true
  self.canvasGroup.alpha = 1
  self.rootAnim:Play("uieff_UIQuestDailyListItem_in")
end

function UIQuestDailyListItem:_OnValue()
  self._typeTex:SetText(StringTable.Get(self._quest.QuestName))
  local str = StringTable.Get(self._quest.CondDesc)
  if self._quest.status == QuestStatus.QUEST_Taken then
    str = "<color=#e6e6e6>" .. str .. "</color>"
    self._bg:SetActive(false)
    self._stateValueTex.gameObject:SetActive(false)
  else
    str = "<color=#4c4b4b>" .. str .. "</color>"
    self._bg:SetActive(true)
    self._stateValueTex.gameObject:SetActive(true)
  end
  self._desTex:SetText(str)
  local progress = ""
  if self._quest.ShowType == 1 then
    local c, d = math.modf(self._quest.cur_progress * 100 / self._quest.total_progress)
    if c < 1 and 0 < d then
      c = 1
    end
    progress = c .. "%"
  else
    progress = self._quest.cur_progress .. "/" .. self._quest.total_progress
  end
  self._stateValueTex:SetText(progress)
  local rate = self._quest.cur_progress / self._quest.total_progress
  self._stateValueImg.fillAmount = rate
  local btnTex = ""
  local icon = ""
  local img = ""
  self._mask:SetActive(false)
  self._select:SetActive(false)
  if self._quest.status == QuestStatus.QUEST_Taken then
    self._got:SetActive(true)
    self._btn:SetActive(false)
    self._bg:SetActive(false)
  else
    self._got:SetActive(false)
    self._btn:SetActive(true)
    self._bg:SetActive(true)
    if self._quest.status <= QuestStatus.QUEST_Accepted then
      self._btnTex.color = Color(1, 1, 1)
      btnTex = StringTable.Get("str_quest_base_go_to_with_space")
      icon = "task_branch_qianwang1"
      img = "task_branch_qianwang1"
    elseif self._quest.status == QuestStatus.QUEST_Completed then
      btnTex = StringTable.Get("str_quest_base_get_with_space")
      icon = "task_branch_ingqu1"
      img = "task_branch_ingqu1"
    end
    self._btnTex:SetText(btnTex)
    self._btnImg.sprite = self._atlas:GetSprite(img)
  end
  local reward = self._quest.rewards
  self._awardPool:SpawnObjects("UIQuestSmallAwardItem", table.count(reward))
  local awards = self._awardPool:GetAllSpawnList()
  local awardsList = self._quest.rewards
  for i = 1, table.count(awardsList) do
    awards[i]:SetData(i, awardsList[i], self._itemCallback, UIItemScale.Level3)
  end
  local count = self._quest.rewards[1].count
  self._daliyValueTex:SetText(count)
end

function UIQuestDailyListItem:btnOnClick()
  if self._quest.quest_id == UIQuestDailySpecialType.DoOneDispatch or self._quest.quest_id == UIQuestDailySpecialType.DoThreeDispatch then
    local aircraftModule = self:GetModule(AircraftModule)
    local unLock = aircraftModule:GetRoomWithType(AirRoomType.DispatchRoom)
    if not unLock then
      ToastManager.ShowToast(StringTable.Get("str_function_lock_dispatchroom_unlock"))
      return
    end
  end
  if self._quest.status <= QuestStatus.QUEST_Accepted then
    local jumpModule = self._module.uiModule
    if jumpModule == nil then
      Log.fatal("[quest] error --> uiModule is nil ! --> jumpModule")
      return
    end
    local fromParam = {}
    table.insert(fromParam, QuestType.QT_Daily)
    jumpModule:SetFromUIData(FromUIType.NormalUI, "UIQuestController", UIStateType.UIMain, fromParam)
    local jumpType = self._quest.JumpID
    local jumpParams = self._quest.JumpParam
    jumpModule:SetJumpUIData(jumpType, jumpParams)
    jumpModule:Jump()
  elseif self._quest.status == QuestStatus.QUEST_Completed and self._callback then
    self._callback(self._quest)
  end
end

function UIQuestDailyListItem:GetBtnObj()
  return self._btn
end

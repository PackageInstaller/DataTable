_class("UIRecruitThumbItem", Object)
UIRecruitThumbItem = UIRecruitThumbItem

function UIRecruitThumbItem:Constructor(go, idx, poolInfo, onClick, questComp)
  go.name = go.name .. idx
  self._gameObject = go
  self._uiView = self._gameObject:GetComponent(typeof(UIView))
  self._uiView:SetShow(true, self)
  self._idx = idx
  self._poolInfo = poolInfo
  self._onClick = onClick
  self._questComponent = questComp
  self._anim = self._gameObject:GetComponent(typeof(UnityEngine.Animation))
  local cfg = Cfg.cfg_recruit_pool_view[poolInfo.poolData.performance_id]
  local title = self._uiView:GetUIComponent("RollingText", "title")
  local maskRect = self._uiView:GetUIComponent("RectTransform", "mask")
  if poolInfo:IsNovicePool() then
    maskRect.sizeDelta = Vector2(241, 39)
  else
    maskRect.sizeDelta = Vector2(212, 39)
  end
  title:RefreshText(StringTable.Get(cfg.ThumbTitle))
  local bg = self._uiView:GetUIComponent("RawImageLoader", "bg")
  bg:LoadImage(cfg.ThumbBG)
  self._selectBox = self._uiView:GetGameObject("Box")
  self._selectBoxImage = self._uiView:GetUIComponent("Image", "Box")
  self._back = self._uiView:GetGameObject("Back")
  self._new = self._uiView:GetGameObject("new")
  self._free = self._uiView:GetGameObject("free")
  self._selectIcon = self._uiView:GetGameObject("selectIcon")
  self._time = self._uiView:GetUIComponent("UILocalizationText", "time")
  self._offset = self._uiView:GetUIComponent("RectTransform", "Offset")
  self._root = self._uiView:GetUIComponent("RectTransform", "Root")
  self._red = self._uiView:GetGameObject("red")
  self._free_draw = self._poolInfo:HasFreeDraw()
  self:_CheckRed()
  self:DeSelect()
  self._CheckRedCB = GameHelper:GetInstance():CreateCallback(self._CheckRed, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.OnDrawCardGetAward, self._CheckRedCB)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.ItemCountChanged, self._CheckRedCB)
end

function UIRecruitThumbItem:Dispose()
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.OnDrawCardGetAward, self._CheckRedCB)
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.ItemCountChanged, self._CheckRedCB)
  self._CheckRedCB = nil
  self._onClick = nil
  self._poolInfo = nil
  if self._uiView then
    self._uiView:SetShow(false, self)
    self._uiView = nil
  end
  self._gameObject = nil
  self:_CancelTimer()
end

function UIRecruitThumbItem:RootOnClick()
  self._onClick(self._idx)
end

function UIRecruitThumbItem:OnSelect(isFirstShow)
  self._selectBox:SetActive(true)
  self._back:SetActive(true)
  if self._isNew then
    GameGlobal.GetModule(GambleModule):CancelPoolNew(self._poolInfo.poolData)
  end
  if isFirstShow then
    self:PlayFadeInAnim()
  end
  self:_CheckRed()
end

function UIRecruitThumbItem:DeSelect()
  self._selectBox:SetActive(false)
  self._back:SetActive(true)
  self._selectBoxImage.color = Color.clear
end

function UIRecruitThumbItem:SetOffset()
  self._selectBoxImage.color = Color.white
end

function UIRecruitThumbItem:GameObject()
  return self._gameObject
end

function UIRecruitThumbItem:_CountDown()
  local closeTime = self._poolInfo:GetPoolCloseTime()
  if closeTime == nil or closeTime <= 0 then
    self:_CancelTimer()
    return
  end
  local now = GetSvrTimeNow()
  local seconds = closeTime - now
  if seconds <= 0 then
    self:_CancelTimer()
    return
  end
  local days = math.floor(seconds / 86400)
  local str
  if days < 1 then
    str = StringTable.Get("str_draw_card_less_one_day")
  else
    str = StringTable.Get("str_common_days", days)
  end
  if self._timerStr ~= str then
    self._timeStr = str
    self._time:SetText(str)
  end
  if not self._timer then
    self._timer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
      self:_CountDown()
    end)
  end
end

function UIRecruitThumbItem:_CancelTimer()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
  end
  self._timeStr = nil
  self._time.gameObject:SetActive(false)
end

function UIRecruitThumbItem:PlayEnterAnim()
  self._anim:Play("uieff_RecruitThunbItem_in")
end

function UIRecruitThumbItem:PlayFadeInAnim()
  self._anim:Play("uieff_RecruitThunbItem_switch_in")
end

function UIRecruitThumbItem:PlayFadeOutAnim()
  self._anim:Play("uieff_RecruitThunbItem_switch_out")
end

function UIRecruitThumbItem:_CheckRed()
  if self:_IsNew() then
    self._new:SetActive(true)
    self._red:SetActive(false)
    self._free:SetActive(false)
  elseif self._free_draw then
    self._free:SetActive(true)
    self._red:SetActive(false)
    self._new:SetActive(false)
  elseif self._selWishRed then
    self._free:SetActive(false)
    self._red:SetActive(true)
    self._new:SetActive(false)
  elseif self:CheckQuestRed() then
    self._free:SetActive(false)
    self._red:SetActive(true)
    self._new:SetActive(false)
  else
    self._new:SetActive(false)
    self._red:SetActive(false)
    self._free:SetActive(false)
  end
end

function UIRecruitThumbItem:_IsNew()
  if self._isNew == true or self._isNew == nil then
    self._isNew = GameGlobal.GetModule(GambleModule):IsNewPool(self._poolInfo.poolData)
  end
  return self._isNew
end

function UIRecruitThumbItem:PublicCheckWishRed()
  local module = GameGlobal.GetModule(GambleModule)
  self._selWishRed = module:CheckOptionalRed(self._idx)
  self:_CheckRed()
  return self._selWishRed
end

function UIRecruitThumbItem:CheckQuestRed()
  if not self._questComponent then
    return false
  end
  local poolData = self._poolInfo.poolData
  if poolData.prize_group_id and poolData.prize_group_id > 0 then
    local curQuest = self:GetCurQuest()
    if not curQuest then
      return false
    else
      return curQuest._questInfo.status == QuestStatus.QUEST_Completed
    end
  end
  return false
end

function UIRecruitThumbItem:GetCurQuest()
  local curQuest
  local questList = self._questComponent:GetQuestInfo()
  for _, quest in pairs(questList) do
    if quest._questInfo.status < QuestStatus.QUEST_Completed then
      curQuest = quest
      break
    elseif quest._questInfo.status == QuestStatus.QUEST_Completed then
      curQuest = quest
      break
    end
  end
  if not curQuest then
    local len = table.count(questList)
    curQuest = questList[len]
  end
  return curQuest
end

_class("UIQuestSideListItem", UICustomWidget)
UIQuestSideListItem = UIQuestSideListItem

function UIQuestSideListItem:OnShow(uiParams)
  self._itemCountPerRow = 1
  self._questModule = GameGlobal.GetModule(QuestModule)
  if self._questModule == nil then
    Log.fatal("[quest] error --> self._questModule is nil !")
    return
  end
end

function UIQuestSideListItem:SetData(index, quest, callback, awardClick, playAnim)
  self:_GetComponents()
  self._index = index
  self._data = quest:QuestInfo()
  if callback then
    self._callback = callback
  end
  if awardClick then
    self._awardClick = awardClick
  end
  self._target = self._data.QuestDesc
  self._items = self._data.rewards
  if playAnim then
    self._anim.enabled = false
    self._anim.enabled = true
    self._anim:Stop()
    self._anim:Sample()
    self._alpha.alpha = 0
    self:PlayAnim()
  else
    self._alpha.alpha = 1
  end
  self:_OnValue()
end

function UIQuestSideListItem:PlayAnim()
  local yieldTime = self._index * 60
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self._timer = GameGlobal.Timer():AddEvent(yieldTime, function()
    self._anim:Play("uieffanim_UIQuestSideListItem_in")
  end)
end

function UIQuestSideListItem:_RefrenshInfo()
  self._target = self._data.QuestDesc
  self._items = self._data.rewards
  self:_OnValue()
end

function UIQuestSideListItem:_GetComponents()
  self._targetTex = self:GetUIComponent("UILocalizationText", "targetTex")
  self._targetValueImg = self:GetUIComponent("Image", "targetValueImg")
  self._targetValueTex = self:GetUIComponent("UILocalizationText", "targetValueTex")
  self._awardPool = self:GetUIComponent("UISelectObjectPath", "awardPool")
  self._gotoGo = self:GetGameObject("GoTo")
  self._getGo = self:GetGameObject("Get")
  self._alpha = self:GetUIComponent("CanvasGroup", "UIQuestSideListItem")
  self._anim = self:GetUIComponent("Animation", "UIQuestSideListItem")
end

function UIQuestSideListItem:_OnValue()
  self._gotoGo:SetActive(false)
  self._getGo:SetActive(false)
  local sprite
  if self._data.status == QuestStatus.QUEST_Accepted then
    self._gotoGo:SetActive(true)
    sprite = ""
  elseif self._data.status == QuestStatus.QUEST_Completed then
    self._getGo:SetActive(true)
  else
    Log.error("###[Quest] get a quest , state is error , state --> ", self._data.status, "|quest id  --> ", self._data.quest_id)
  end
  local rate = self._data.cur_progress / self._data.total_progress
  self._targetValueImg.fillAmount = rate
  local progress = ""
  if self._data.ShowType == 1 then
    local c, d = math.modf(self._data.cur_progress * 100 / self._data.total_progress)
    if c < 1 and 0 < d then
      c = 1
    end
    progress = c .. "%"
  else
    progress = self._data.cur_progress .. " /" .. self._data.total_progress
  end
  self._targetValueTex:SetText(progress)
  self._targetTex:SetText(StringTable.Get(self._target))
  self._awardPool:SpawnObjects("UIQuestSideAwardItem", table.count(self._items))
  local pools = self._awardPool:GetAllSpawnList()
  for i = 1, table.count(self._items) do
    local id = self._items[i].assetid
    local cfg_item = Cfg.cfg_item[id]
    local params = {}
    params.quality = cfg_item.Color
    params.icon = cfg_item.Icon
    params.text = self._items[i].count
    pools[i]:SetData(id, params, self._awardClick)
  end
end

function UIQuestSideListItem:GetOnClick()
  if self._callback then
    self._callback(self._data)
  end
end

function UIQuestSideListItem:GoToOnClick()
  local jumpModule = self._questModule.uiModule
  if jumpModule == nil then
    Log.fatal("[quest] error --> uiModule is nil ! --> jumpModule")
    return
  end
  local fromParam = {}
  table.insert(fromParam, QuestType.QT_Branch)
  jumpModule:SetFromUIData(FromUIType.NormalUI, "UIQuestController", UIStateType.UIMain, fromParam)
  local jumpType = self._data.JumpID
  local jumpParams = self._data.JumpParam
  jumpModule:SetJumpUIData(jumpType, jumpParams)
  jumpModule:Jump()
end

function UIQuestSideListItem:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end

_class("UIActivityAliceQuest", UICustomWidget)
UIActivityAliceQuest = UIActivityAliceQuest

function UIActivityAliceQuest:SetData(index, quest, callback, getCallback)
  self:GetComponents()
  self._questInfo = quest:QuestInfo()
  self._callback = callback
  self._getCallback = getCallback
  self:OnValue()
end

function UIActivityAliceQuest:GetComponents()
  self._got = self:GetGameObject("got")
  self._com = self:GetGameObject("com")
  self._not = self:GetGameObject("not")
  self._notTex = self:GetUIComponent("UILocalizationText", "notTex")
  self._gotTex = self:GetUIComponent("UILocalizationText", "gotTex")
  self._comTex = self:GetUIComponent("UILocalizationText", "comTex")
  self._rate = self:GetUIComponent("UILocalizationText", "rate")
  self._desc = self:GetUIComponent("UILocalizationText", "desc")
  self._img = self:GetUIComponent("Image", "Image")
  local sop = self:GetUIComponent("UISelectObjectPath", "pool")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.Base, UIItemScale.Level3)
  self.uiItem:SetClickCallBack(function(go)
    self:ItemOnClick(go)
  end)
end

function UIActivityAliceQuest:ItemOnClick(go)
  if self._callback then
    self._callback(self._id, go.transform.position)
  end
end

function UIActivityAliceQuest:OnValue()
  local cfg_vice_awards = Cfg.cfg_activity_vice_quest_rewards_view[self._questInfo.quest_id]
  local reward
  if cfg_vice_awards then
    local awardsView = cfg_vice_awards.AwardsView[1]
    reward = RoleAsset:New()
    reward.assetid = awardsView[1]
    reward.count = awardsView[2]
  else
    reward = self._questInfo.rewards[1]
  end
  self._id = reward.assetid
  local cfg_item = Cfg.cfg_item[self._id]
  if not cfg_item then
    Log.error("###[UIShopSailingPlanItem] cfg_item is nil ! id : ", self._id)
  end
  local icon = cfg_item.Icon
  local quality = cfg_item.Color
  local text1 = self._count
  local itemid = self._id
  self.uiItem:SetData({
    icon = icon,
    quality = quality,
    text1 = text1,
    itemId = itemid
  })
  local desc = StringTable.Get(self._questInfo.CondDesc)
  self._desc:SetText(desc)
  local rate = "（" .. self._questInfo.cur_progress .. "/" .. self._questInfo.total_progress .. "）"
  self._rate:SetText(rate)
  local status = self._questInfo.status
  self._not:SetActive(status == QuestStatus.QUEST_Accepted or status == QuestStatus.QUEST_NotStart)
  self._com:SetActive(status == QuestStatus.QUEST_Completed)
  self._got:SetActive(status == QuestStatus.QUEST_Taken)
end

function UIActivityAliceQuest:BtnOnClick(go)
  if self._getCallback then
    self._getCallback(self._questInfo.quest_id)
  end
end

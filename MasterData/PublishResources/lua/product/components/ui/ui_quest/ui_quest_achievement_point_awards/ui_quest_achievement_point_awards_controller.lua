_class("UIQuestAchievementPointAwardsController", UIController)
UIQuestAchievementPointAwardsController = UIQuestAchievementPointAwardsController

function UIQuestAchievementPointAwardsController:OnShow(uiParams)
  self:_GetComponents()
  self._questModule = GameGlobal.GetModule(QuestModule)
  self._achievementPoint = self._questModule:GetAchPoint()
  self._cfg = Cfg.cfg_achieve_reward({})
  if self._cfg == nil then
    Log.fatal("###[quest] error --> cfg_achieve_reward is nil !")
    return
  end
  self._awardsCount = table.count(self._cfg)
  self._achievementPointUpper = self._cfg[self._awardsCount].AchPoint
  self:_OnValue()
end

function UIQuestAchievementPointAwardsController:OnHide()
end

function UIQuestAchievementPointAwardsController:_GetComponents()
  self._pointValueTex = self:GetUIComponent("UILocalizationText", "pointValueTex")
  self._pools = self:GetUIComponent("UISelectObjectPath", "pools")
  self._itemInfo = self:GetUIComponent("UISelectObjectPath", "itemInfo")
  self._selectInfo = self._itemInfo:SpawnObject("UISelectInfo")
end

function UIQuestAchievementPointAwardsController:_OnValue()
  self._pointValueTex:SetText("<size=42><color=#fdd100>" .. self._achievementPoint .. "</color></size><size=32><color=#f2f2f2>/" .. self._achievementPointUpper .. "</color></size>")
  self:_InitScrollView()
end

function UIQuestAchievementPointAwardsController:_InitScrollView()
  self._pools:SpawnObjects("UIQuestAchievementPointAwardsItem", self._awardsCount)
  local pools = self._pools:GetAllSpawnList()
  for i = 1, self._awardsCount do
    local item = pools[i]
    local data = self._cfg[i]
    item:SetData(i, data, self._achievementPoint, function(matid, pos)
      self:_ItemClick(matid, pos)
    end)
  end
end

function UIQuestAchievementPointAwardsController:_AwardItemClick(idx)
end

function UIQuestAchievementPointAwardsController:_ItemClick(matid, pos)
  if self._selectInfo then
    self._selectInfo:SetData(matid, pos)
  end
end

function UIQuestAchievementPointAwardsController:BgOnClick()
  self:CloseDialog()
end

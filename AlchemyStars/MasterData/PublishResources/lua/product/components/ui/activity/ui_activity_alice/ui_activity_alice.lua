require("ui_side_enter_center_content_base")
_class("UIActivityAlice", UISideEnterCenterContentBase)
UIActivityAlice = UIActivityAlice

function UIActivityAlice:Constructor()
end

function UIActivityAlice:DoInit()
  self._campaign = self._data
  self._LocalProcess = self._campaign:GetLocalProcess()
  self._questInfo = self._LocalProcess:GetComponentInfo(ECCampaignInlandPetWSComponentID.QUEST)
  self._questModule = GameGlobal.GetModule(QuestModule)
  self:SetQuestList()
end

function UIActivityAlice:SetQuestList()
  self._quests = {}
  local list = self._questInfo.m_accept_cam_quest_list
  for index, value in ipairs(list) do
    local quest = self._questModule:GetQuest(value)
    table.insert(self._quests, quest)
  end
end

function UIActivityAlice:DoShow(uiParams)
  self:StartTask(function(TT)
    self._campaign:ClearCampaignNew(TT)
  end)
  self:GetComponents()
  self:OnValue()
  self._tips:closeOnClick()
end

function UIActivityAlice:GetComponents()
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
  self.matReq = UIWidgetHelper.SetLocalizedTMPMaterial(self, "tittle", "AliceFontMat.mat")
end

function UIActivityAlice:OnValue()
  self._pool:SpawnObjects("UIActivityAliceQuest", 3)
  local pools = self._pool:GetAllSpawnList()
  for i = 1, 3 do
    local item = pools[i]
    local quest = self._quests[i]
    item:SetData(i, quest, function(id, pos)
      self:ItemInfo(id, pos)
    end, function(id)
      self:FinishQuest(id)
    end)
  end
end

function UIActivityAlice:ItemInfo(id, pos)
  if self._tips then
    self._tips:SetData(id, pos)
  end
end

function UIActivityAlice:FinishQuest(id)
  self:Lock("UIActivityAlice:OnFinishQuest")
  GameGlobal.TaskManager():StartTask(self.OnFinishQuest, self, false, id)
end

function UIActivityAlice:OnFinishQuest(TT, all, questid)
  local res = AsyncRequestRes:New()
  local questCom = self._LocalProcess:GetComponent(ECCampaignInlandPetWSComponentID.QUEST)
  local ret, rewards
  if all then
    ret, rewards = questCom:HandleOneKeyTakeQuest(TT, res)
  else
    ret, rewards = questCom:HandleQuestTake(TT, res, questid)
  end
  self:UnLock("UIActivityAlice:OnFinishQuest")
  if res:GetSucc() then
    if self.view == nil then
      return
    end
    self:ShowDialog("UIGetItemController", rewards, function()
      self:SetQuestList()
      self:OnValue()
    end)
  else
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
    Log.error("###[UIActivityAlice] OnFinishQuest fail,type:", all, " result:", res:GetResult(), " questid:", questid)
  end
end

function UIActivityAlice:DoHide()
end

function UIActivityAlice:DoDestroy()
  UIWidgetHelper.DisposeLocalizedTMPMaterial(self.matReq)
end

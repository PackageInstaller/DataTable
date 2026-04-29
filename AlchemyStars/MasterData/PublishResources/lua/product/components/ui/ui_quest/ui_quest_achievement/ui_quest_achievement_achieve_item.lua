_class("UIQuestAchievementAchieveItem", UICustomWidget)
UIQuestAchievementAchieveItem = UIQuestAchievementAchieveItem

function UIQuestAchievementAchieveItem:OnShow(uiParams)
  self._module = GameGlobal.GetModule(QuestModule)
  if self._module == nil then
    Log.fatal("[quest] error --> module is nil !")
    return
  end
  self._atlas = self:RootUIOwner():GetAsset("UIQuest.spriteatlas", LoadType.SpriteAtlas)
end

function UIQuestAchievementAchieveItem:SetData(index, quest, point, getCallback, awardCallBack, refrenshCb)
  self:_GetComponents()
  self._quest = quest
  self._index = index
  self._point = point
  self._getCallback = getCallback
  self._awardCallBack = awardCallBack
  self._finishState = quest.status
  self._refrenshCb = refrenshCb
  self:_OnValue()
end

function UIQuestAchievementAchieveItem:OnHide()
end

function UIQuestAchievementAchieveItem:_GetComponents()
  self._achieveTagTex = self:GetUIComponent("UILocalizationText", "achieveTagTex")
  self._achieveDesTex = self:GetUIComponent("UILocalizationText", "achieveDesTex")
  self._achievePointTex = self:GetUIComponent("UILocalizationText", "achievePointTex")
  self._finishGo = self:GetGameObject("Finish")
  self._gotoGo = self:GetGameObject("GoTo")
  self._getGo = self:GetGameObject("Get")
  self._pools = self:GetUIComponent("UISelectObjectPath", "pools")
  self._bgImg = self:GetUIComponent("Image", "bg")
end

function UIQuestAchievementAchieveItem:_OnValue()
  self._achieveTagTex:SetText(StringTable.Get(self._quest.QuestName))
  self._achieveDesTex:SetText(StringTable.Get(self._quest.CondDesc))
  self._achievePointTex:SetText(self._point)
  self:_CheckQuestState()
  local awards = self._quest.rewards
  local awardsCount = table.count(awards)
  self._pools:SpawnObjects("UIQuestSmallAwardItem", awardsCount)
  local items = self._pools:GetAllSpawnList()
  for i = 1, table.count(items) do
    items[i]:SetData(i, awards[i], self._awardCallBack)
  end
end

function UIQuestAchievementAchieveItem:_CheckQuestState()
  self._finishGo:SetActive(false)
  self._gotoGo:SetActive(false)
  self._getGo:SetActive(false)
  if self._quest.status <= QuestStatus.QUEST_Accepted then
    self._bgImg.sprite = self._atlas:GetSprite("task_chengjiu_di24")
    self._gotoGo:SetActive(true)
  elseif self._quest.status == QuestStatus.QUEST_Completed then
    self._bgImg.sprite = self._atlas:GetSprite("task_chengjiu_di24")
    self._getGo:SetActive(true)
  elseif self._quest.status == QuestStatus.QUEST_Taken then
    self._bgImg.sprite = self._atlas:GetSprite("task_chengjiu_di7")
    self._finishGo:SetActive(true)
  end
end

function UIQuestAchievementAchieveItem:GetBtnOnClick()
  self:Lock("UIQuestGet")
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
  self:StartTask(self._OnGet, self)
end

function UIQuestAchievementAchieveItem:GoToBtnOnClick()
  local jumpModule = self._module.uiModule
  if jumpModule == nil then
    Log.fatal("[quest] error --> uiModule is nil ! --> jumpModule")
    return
  end
  local fromParam = {}
  table.insert(fromParam, QuestType.QT_Achieve)
  jumpModule:SetFromUIData(FromUIType.NormalUI, "UIQuestController", UIStateType.UIMain, fromParam)
  local jumpType = self._quest.JumpID
  local jumpParams = self._quest.JumpParam
  jumpModule:SetJumpUIData(jumpType, jumpParams)
  jumpModule:Jump()
end

function UIQuestAchievementAchieveItem:_OnGet(TT)
  if self._getCallback then
    self._getCallback(self._index)
  end
  local res, msg = self._module:TakeQuestReward(TT, self._quest.quest_id)
  self:UnLock("UIQuestGet")
  if self.uiOwner == nil then
    return
  end
  if res:GetSucc() then
    local tempPets = {}
    local pets = msg.rewards
    if 0 < #pets then
      for i = 1, #pets do
        local ispet = GameGlobal.GetModule(PetModule):IsPetID(pets[i].assetid)
        if ispet then
          table.insert(tempPets, pets[i])
        end
      end
    end
    if 0 < #tempPets then
      self:ShowDialog("UIPetObtain", tempPets, function()
        GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
        self:ShowDialog("UIGetItemController", msg.rewards, function()
          if self._refrenshCb then
            self._refrenshCb()
          end
        end)
      end)
    else
      self:ShowDialog("UIGetItemController", msg.rewards, function()
        if self._refrenshCb then
          self._refrenshCb()
        end
      end)
    end
  end
end

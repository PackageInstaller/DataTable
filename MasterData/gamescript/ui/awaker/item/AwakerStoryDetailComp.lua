local AwakerStoryDetailComp, Super = System.NewComponent("AwakerStoryDetailComp")

function AwakerStoryDetailComp:ctor(uiNode, awakerModel, storyModel)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_StoryResource(uiNode)
  self.awakerModel = awakerModel
  self.storyModel = storyModel
end

function AwakerStoryDetailComp:OnBind(binder)
  binder:LoadAllLangFont(self.ui.Text_Story)
  binder:BindToText(self.ui.Text_Title, function()
    do return LT.Text, self.storyModel:GetCurStoryTitle() end
    return LT.Text, self.storyModel:GetCurStoryTitle()
  end)
  binder:BindToRaw(function(_, storyContent, _)
    binder:SetText(self.ui.Text_Story, storyContent)
    binder:BindTimer(0.01, 0, nil, function()
      StrUtils.SetPreferredHeight(self.ui.Text_Story)
    end)
  end, function()
    do return LT.Text, self.storyModel:GetCurStoryContent() end
    return LT.Text, self.storyModel:GetCurStoryContent()
  end)
  binder:BindToRaw(function(_, nVal, _)
    self.storyModel:UpdateStoryLockList()
  end, function()
    return self.storyModel.curSelectVoiceId or self.awakerModel.selectAwakerId
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Item_Story_Lock, function()
    do return self.storyModel.GetStoryLockList end
    return self.storyModel.GetStoryLockList, self.storyModel
  end, function(itemBinder, item, index)
    local list = self.storyModel:GetStoryLockList()
    local data = list[index]
    itemBinder:BindComponent(AwakerStoryLockItem(item, data))
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Story, function()
    return self.storyModel.storyShowList
  end, function(itemBinder, item, index)
    local data = self.storyModel.storyShowList[index]
    
    local function callBack()
      self.storyModel:SetCurSelectVoiceId(data.tid)
      AwakerDataUtils.ReadStory(self.awakerModel.selectAwakerId, {
        data.tid
      })
    end
    
    itemBinder:BindComponent(AwakerVoiceItem(item, data, self.storyModel, callBack))
  end)
  binder:BindToVisible(self.ui.ScrollView_Item_Story_Lock, function()
    if not self.awakerModel.selectAwakerData or not self.awakerModel.selectAwakerData.stories then
      return false
    end
    return not self.awakerModel.selectAwakerData.stories[self.storyModel.curSelectVoiceId]
  end)
  binder:BindToVisible(self.ui.ScrollView_Story_Content, function()
    if not self.awakerModel.selectAwakerData or not self.awakerModel.selectAwakerData.stories then
      return false
    end
    return self.awakerModel.selectAwakerData.stories[self.storyModel.curSelectVoiceId]
  end)
end

function AwakerStoryDetailComp:RemoveRedPoints()
  local storyList = {}
  for _, data in pairs(self.storyModel.storyShowList) do
    table.insert(storyList, data.tid)
  end
  AwakerDataUtils.ReadStory(self.awakerModel.selectAwakerId, storyList)
end

function AwakerStoryDetailComp:OnTodoFunc()
end

return AwakerStoryDetailComp

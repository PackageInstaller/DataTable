_class("UISeasonTestFunc", UICustomWidget)
UISeasonTestFunc = UISeasonTestFunc

function UISeasonTestFunc:_GetComponents()
  self._window = self:GetGameObject("TestFuncWindow")
  self._gameobj = self:GetGameObject()
end

function UISeasonTestFunc:OnShow()
  self:_GetComponents()
  self._window:SetActive(false)
  self._btns = {}
  self:_PushBtns()
  local pool = self:GetUIComponent("UISelectObjectPath", "Group")
  local btns = pool:SpawnObjects("UISeasonTestBtn", #self._btns)
  for i, tb in ipairs(self._btns) do
    btns[i]:SetData(tb[1], tb[2])
  end
end

function UISeasonTestFunc:_PushBtns()
  self:_AddFunc("关卡详情", function()
    local missionId = 8001001
    UISeasonHelper.TestShowUIStage(missionId)
  end)
  self:_AddFunc("剧情关", function()
    local stageId = 800103
    UISeasonHelper.TriggerStoryNode(stageId)
  end)
  self:_AddFunc("奖励弹窗", function()
    local rewards = {}
    self:_AwardsTestAddAsset(rewards, 3210101, 10)
    self:_AwardsTestAddAsset(rewards, 3210302, 10)
    self:_AwardsTestAddAsset(rewards, 3201024, 10)
    self:_AwardsTestAddAsset(rewards, 3220005, 10)
    self:_AwardsTestAddAsset(rewards, 3753032, 1)
    self:_AwardsTestAddAsset(rewards, 3753034, 1)
    self:_AwardsTestAddAsset(rewards, 7000101, 1)
    self:_AwardsTestAddAsset(rewards, 7000103, 1)
    UISeasonHelper.ShowUIGetRewards(rewards, false)
  end)
  self:_AddFunc("帮助手册", function()
    UISeasonHelper.ShowSeasonHelperBook(1)
  end)
  self:_AddFunc("收藏盒", function()
    self:ShowDialog("UISeasonS1Collages")
  end)
  self:_AddFunc("赛季任务", function()
    self:ShowDialog("UISeasonQuestController")
  end)
  self:_AddFunc("S1", function()
    self:ShowDialog("UIS1MainController")
  end)
  self:_AddFunc("强制进局开关", function()
    if UISeasonHelper.TEST then
      UISeasonHelper.TEST = false
    else
      UISeasonHelper.TEST = true
    end
    ToastManager.ShowToast(UISeasonHelper.TEST and "已打开" or "已关闭")
  end)
  self:_AddFunc("一次性战斗关", function()
    self:ShowDialog("UISeasonOnceMission")
  end)
end

function UISeasonTestFunc:_AddFunc(title, onClick)
  self._btns[#self._btns + 1] = {title, onClick}
end

function UISeasonTestFunc:OnHide()
end

function UISeasonTestFunc:Switch(show)
  self._gameobj:SetActive(show)
end

function UISeasonTestFunc:TestFuncEntryOnClick()
  self._window:SetActive(true)
end

function UISeasonTestFunc:TestFuncWindowOnClick()
  self._window:SetActive(false)
end

function UISeasonTestFunc:_AwardsTestAddAsset(tb, id, count)
  local roleAsset = RoleAsset:New()
  roleAsset.assetid = id
  roleAsset.count = count
  table.insert(tb, roleAsset)
end

local TowerDefenseStoryCtrl = class("TowerDefenseStoryCtrl", BaseCtrl)
TowerDefenseStoryCtrl._mapNodeConfig = {
  txtWindowTitle_Story = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Story"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  sv_story = {
    sComponentName = "LoopScrollView"
  }
}
TowerDefenseStoryCtrl._mapEventConfig = {}
TowerDefenseStoryCtrl._mapRedDotConfig = {}

function TowerDefenseStoryCtrl:Awake()
  self.animator = self.gameObject:GetComponent("Animator")
end

function TowerDefenseStoryCtrl:SetData(ActId)
  self.animator:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self.TowerDefenseData = PlayerData.Activity:GetActivityDataById(ActId)
  self.tbStoryId = {}
  
  local function forEach(data)
    if ActId == data.ActivityIdId then
      table.insert(self.tbStoryId, data.Id)
    end
  end
  
  ForEachTableLine(DataTable.TowerDefenseStory, forEach)
  
  local function sortFunc(a, b)
    return a < b
  end
  
  table.sort(self.tbStoryId, sortFunc)
  self._mapNode.sv_story:Init(#self.tbStoryId, self, self.OnRefreshGrid)
end

function TowerDefenseStoryCtrl:OnRefreshGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local bUnlock = self.TowerDefenseData:IsStoryUnlock(self.tbStoryId[nIndex])
  local go_lock = goGrid.transform:Find("btnGrid/lock")
  local go_AnimRoot = goGrid.transform:Find("btnGrid/AnimRoot")
  local storyConfig = ConfigTable.GetData("TowerDefenseStory", self.tbStoryId[nIndex])
  if storyConfig == nil then
    return
  end
  if bUnlock then
    go_lock.gameObject:SetActive(false)
    go_AnimRoot.gameObject:SetActive(true)
    local txt_index = go_AnimRoot.transform:Find("txtLevelIndex"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(txt_index, orderedFormat(ConfigTable.GetUIText("TowerDef_Story_Index"), nIndex))
    local txt_name = go_AnimRoot.transform:Find("txtLevelName"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(txt_name, storyConfig.Name)
    local imgReward = go_AnimRoot.transform:Find("img_reward"):GetComponent("Image")
    local txt_Reward = go_AnimRoot.transform:Find("txt_reward"):GetComponent("TMP_Text")
    if storyConfig.Item1 ~= 0 then
      local itemConfig = ConfigTable.GetData_Item(storyConfig.Item1)
      if itemConfig ~= nil then
        self:SetPngSprite(imgReward, itemConfig.Icon)
        NovaAPI.SetTMPText(txt_Reward, "x" .. storyConfig.Qty1)
      end
    end
    local btn_go = go_AnimRoot.transform:Find("btnSelect"):GetComponent("UIButton")
    btn_go.onClick:RemoveAllListeners()
    btn_go.onClick:AddListener(function()
      self.TowerDefenseData:PlayAvg(storyConfig.Id, storyConfig.AvgId)
    end)
    local reddot = go_AnimRoot.transform:Find("RedDot")
    RedDotManager.RegisterNode(RedDotDefine.Activity_TowerDefense_Story, storyConfig.Id, reddot)
  else
    go_lock.gameObject:SetActive(true)
    go_AnimRoot.gameObject:SetActive(false)
    local txtUnlock = go_lock.transform:Find("txtUnlock"):GetComponent("TMP_Text")
    local levelConfig = ConfigTable.GetData("TowerDefenseLevel", storyConfig.LevelId)
    if levelConfig == nil then
      NovaAPI.SetTMPText(txtUnlock, orderedFormat(ConfigTable.GetUIText("TowerDef_Story_Lock"), ""))
    else
      NovaAPI.SetTMPText(txtUnlock, orderedFormat(ConfigTable.GetUIText("TowerDef_Story_Lock"), levelConfig.LevelName))
    end
    local txt_reward_title = go_lock.transform:Find("txtreward_title"):GetComponent("TMP_Text")
    local imgReward = go_lock.transform:Find("img_reward"):GetComponent("Image")
    local txt_Reward = go_lock.transform:Find("txt_reward"):GetComponent("TMP_Text")
    if storyConfig.Item1 ~= 0 then
      local itemConfig = ConfigTable.GetData_Item("storyConfig.Item1")
      if itemConfig ~= nil then
        self:SetPngSprite(imgReward, itemConfig.Icon)
        NovaAPI.SetTMPText(txt_Reward, storyConfig.Qty1)
        NovaAPI.SetTMPText(txt_reward_title, ConfigTable.GetUIText("TowerDef_Story_RewardTitle"))
      end
    end
  end
end

function TowerDefenseStoryCtrl:OnBtnClick_Close()
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self.animator:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, function()
    EventManager.Hit("CloseTowerDefenseStoryPanel")
  end, true, true, true)
end

return TowerDefenseStoryCtrl

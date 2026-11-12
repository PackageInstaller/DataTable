local MiningGameCtrl = class("MiningGameCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local listPrefabPath = "UI_Activity/_%s/GridCell/"
local assetPath = "UI_Activity/_%s/SpriteAtlas/Sprite/"
local signal_typeA = "zs_mining_signal_01"
local signal_typeB = "zs_mining_signal_02"
local signal_typeC = "zs_mining_signal_03"
local signal_typeD = "zs_mining_signal_04"
MiningGameCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  animator = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  GirdListPrefab = {},
  cellPos = {nCount = 21},
  txt_scoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "MiningGame_ScoreTitle"
  },
  txt_score = {sComponentName = "TMP_Text"},
  animator_score = {sNodeName = "bg_score", sComponentName = "Animator"},
  txt_level = {sComponentName = "TMP_Text"},
  char = {nCount = 2},
  imgShovel = {},
  Btn_Axe = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_OpenAxeTips"
  },
  txt_rewardTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "MiningGame_ItemTitle"
  },
  signal = {nCount = 3},
  txt_Amount = {sComponentName = "TMP_Text"},
  btn_guide = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_OpenGuidePanel"
  },
  txt_guide = {
    sComponentName = "TMP_Text",
    sLanguageId = "MiningGame_Guide"
  },
  btn_reward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_OpenTask"
  },
  txt_reward = {
    sComponentName = "TMP_Text",
    sLanguageId = "MiningGame_Reward"
  },
  reward_reddot = {},
  FinishPanel = {},
  txt_finish = {
    sComponentName = "TMP_Text",
    sLanguageId = "MiningGame_Finish"
  },
  GoNextLevelPanel = {},
  txt_NextLevel = {
    sComponentName = "TMP_Text",
    sLanguageId = "MiningGame_FinishLevel"
  }
}
MiningGameCtrl._mapEventConfig = {
  MiningUpdateLevel = "OnEvent_UpdateLevelData",
  MiningUpdateCell = "OnEvent_UpdateGridCell",
  MiningUpdateReward = "OnEvent_UpdateRewardStatus",
  MiningAxeUpdate = "OnEvent_UpdateAxeCount",
  MiningKnockResult = "OnEvent_MiningKnockResult",
  MiningGameUpdateScore = "OnEvent_UpdateScore",
  MiningGameRewardFxOver = "OnEvent_UpdateScoreFx",
  MiningShowReward = "OnEvent_ShowReward",
  Mining_Error = "OnEvent_Error"
}
MiningGameCtrl._mapRedDotConfig = {}

function MiningGameCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
  end
  self.nNewScore = 0
  self.bInPassAnim = false
  self.passAnimCb = nil
  self._mapNode.FinishPanel:SetActive(false)
  self._mapNode.GoNextLevelPanel:SetActive(false)
  self.miningData = PlayerData.Activity:GetActivityDataById(self.nActId)
  if self.miningData:GetIsFirstIn() then
    local function cb()
      local DicConfig = ConfigTable.GetData("TopBar", string.format("MiningGame_%s", self.nActId))
      
      if DicConfig ~= nil then
        local dicId = DicConfig.EntryId
        if dicId ~= 0 then
          EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, dicId, true)
        end
      end
      self.miningData:SetIsFirstIn()
    end
    
    self:AddTimer(1, 0.9, cb, true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, 1.1)
  end
end

function MiningGameCtrl:OnEnable()
  if self.miningData:CheckActivityOpen() then
    self:UpdateLevelData()
  else
    NovaAPI.InputDisable()
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_MiningEnd"))
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      EventManager.Hit(EventId.ClosePanel, self._panel.nPanelId)
      NovaAPI.InputEnable()
    end
    
    cs_coroutine.start(wait)
  end
  local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(self.nActId)
  if bInActGroup then
    local mapActivityData = ConfigTable.GetData("Activity", self.nActId)
    local actGroupId = mapActivityData.MidGroupId
    local actGroupData = PlayerData.Activity:GetActivityGroupDataById(actGroupId)
    local taskActId = actGroupData:GetActivityDataByIndex(AllEnum.ActivityThemeFuncIndex.Task).ActivityId
    local taskActData = PlayerData.Activity:GetActivityDataById(taskActId)
    if taskActData ~= nil and taskActData:CheckActivityOpen() then
      RedDotManager.RegisterNode(RedDotDefine.Activity_Group_Task_Group, {
        nActGroupId,
        taskActId,
        mapActivityData.MiniGameRedDot
      }, self._mapNode.reward_reddot)
      return
    end
  else
    RedDotManager.RegisterNode(RedDotDefine.Activity_Mining_AllQuest, nil, self._mapNode.reward_reddot)
  end
end

function MiningGameCtrl:OnDisable(...)
  if self.gridListCtrl ~= nil then
    self:UnbindCtrlByNode(self.gridListCtrl)
  end
  self.gridListCtrl = nil
end

function MiningGameCtrl:OnDestroy()
  if PlayerData.Activity:IsActivityInActivityGroup(self.nActId) then
    local mapActivityData = ConfigTable.GetData("Activity", self.nActId)
    local actGroupId = mapActivityData.MidGroupId
    local actGroupData = PlayerData.Activity:GetActivityGroupDataById(actGroupId)
    local taskActId = actGroupData:GetActivityDataByIndex(AllEnum.ActivityThemeFuncIndex.Task).ActivityId
    local taskActData = PlayerData.Activity:GetActivityDataById(taskActId)
    if taskActData ~= nil and taskActData:CheckActivityOpen() then
      RedDotManager.UnRegisterNode(RedDotDefine.Activity_Group_Task_Group, {
        actGroupId,
        taskActId,
        mapActivityData.MiniGameRedDot
      }, self._mapNode.reward_reddot)
      return
    end
  else
    RedDotManager.UnRegisterNode(RedDotDefine.Activity_Mining_AllQuest, nil, self._mapNode.reward_reddot)
  end
end

function MiningGameCtrl:InitData()
  self.tbRewardDataList = {}
  self.goBgPrefab = nil
end

function MiningGameCtrl:UpdateLevelData()
  self:InitData()
  local config = self.miningData:GetMiningCfg()
  local prefabPath = string.format(listPrefabPath, self.nActId) .. config.GridListPrefab .. ".prefab"
  if self.gridListCtrl == nil then
    for i = 1, 21 do
      delChildren(self._mapNode.cellPos[i].transform)
      local goCell = self:CreatePrefabInstance(prefabPath, self._mapNode.cellPos[i].transform)
      goCell.name = "cell" .. i
    end
    self.gridListCtrl = self:BindCtrlByNode(self._mapNode.GirdListPrefab, "Game.UI.Activity.Mining.MiningGridListCtrl")
    self.gridListCtrl:SetData(self.nActId)
  end
  self:UpdateSupData()
  NovaAPI.SetTMPText(self._mapNode.txt_level, orderedFormat(ConfigTable.GetUIText("MiningGame_Level"), self.miningData:GetLevel()))
  self:InitRewardList()
  self.tbRewardDataList = self.miningData:GetCurLevelRewardData()
  self:UpdateRewardList()
  local tbCellData = self.miningData:GetCellData()
  
  local function funcCallback(nId)
    self:KnockCallback(nId)
  end
  
  for _, v in pairs(tbCellData) do
    self.gridListCtrl:InitGridCell(v, funcCallback)
  end
  EventManager.Hit(EventId.BlockInput, true)
  self:AddTimer(1, 0.55, function()
    self.gridListCtrl:HideReward()
    self.gridListCtrl:InitRewardList(self.tbRewardDataList)
    EventManager.Hit(EventId.BlockInput, false)
  end, true, true, true, nil)
  self:UpdateAxeCount(self.miningData:GetAxeCount())
  self:UpdateScore(self.miningData:GetScore())
  self.miningData:DoEnterResult()
  self:CheckPassAllLevel()
end

function MiningGameCtrl:UpdateSupData()
  local tbSupIdList = self.miningData:GetSupDataList()
  if tbSupIdList == nil or #tbSupIdList == 0 then
    return
  end
  for _, char in pairs(self._mapNode.char) do
    char:SetActive(false)
  end
  for i = 1, math.min(#tbSupIdList, 2) do
    local char = self._mapNode.char[i]
    local img_head = char.transform:Find("bg/img_head"):GetComponent("Image")
    local txt_skillName = char.transform:Find("bg/txt_skillName"):GetComponent("TMP_Text")
    local txt_skillDesc = char.transform:Find("bg/txt_skillDesc"):GetComponent("TMP_Text")
    local supConfig = ConfigTable.GetData("MiningSupport", tbSupIdList[i].nId)
    if supConfig ~= nil then
      NovaAPI.SetTMPText(txt_skillName, supConfig.SkillName)
      NovaAPI.SetTMPText(txt_skillDesc, supConfig.SkillDes)
      if supConfig.CharIcon ~= "" then
        self:SetPngSprite(img_head, supConfig.CharIcon, AllEnum.CharHeadIconSurfix.S)
      end
      char:SetActive(true)
    end
  end
end

function MiningGameCtrl:InitRewardList()
  for _, go in ipairs(self._mapNode.signal) do
    go:SetActive(false)
  end
end

function MiningGameCtrl:UpdateRewardList()
  for i = 1, math.min(#self.tbRewardDataList, 3) do
    local rewardData = self.tbRewardDataList[i]
    local rewardConfig = ConfigTable.GetData("MiningTreasure", rewardData.nId)
    if rewardConfig ~= nil then
      local img_get = self._mapNode.signal[i].transform:Find("bg_reward/img_get")
      local img_signal = self._mapNode.signal[i].transform:Find("bg_reward/img_signal")
      if rewardConfig.MiningItemType == GameEnum.miningRewardType.RewardTypeA then
        self:SetPngSprite(img_signal:GetComponent("Image"), string.format(assetPath, self.nActId) .. signal_typeA)
      elseif rewardConfig.MiningItemType == GameEnum.miningRewardType.RewardTypeB then
        self:SetPngSprite(img_signal:GetComponent("Image"), string.format(assetPath, self.nActId) .. signal_typeB)
      elseif rewardConfig.MiningItemType == GameEnum.miningRewardType.RewardTypeC then
        self:SetPngSprite(img_signal:GetComponent("Image"), string.format(assetPath, self.nActId) .. signal_typeC)
      else
        self:SetPngSprite(img_signal:GetComponent("Image"), string.format(assetPath, self.nActId) .. signal_typeD)
      end
      img_signal:GetComponent("Image"):SetNativeSize()
      img_get.gameObject:SetActive(rewardData.bIsGet)
      self._mapNode.signal[i]:SetActive(true)
    end
  end
end

function MiningGameCtrl:UpdateGridCell(data, nEffectType)
  self.gridListCtrl:ChangeGridState(data, nEffectType)
end

function MiningGameCtrl:KnockCallback(nId)
  if self.miningData:GetAxeCount() == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("MiningGame_NoAxeTips"))
    return
  end
  self.miningData:RequestKnockCell(nId)
end

function MiningGameCtrl:UpdateAxeCount(nCount)
  NovaAPI.SetTMPText(self._mapNode.txt_Amount, tostring(nCount))
end

function MiningGameCtrl:UpdateScore(score)
  local sScore = self:formatNumber(score)
  NovaAPI.SetTMPText(self._mapNode.txt_score, sScore)
end

function MiningGameCtrl:formatNumber(n)
  local s = tostring(n)
  local result = ""
  local count = 0
  for i = #s, 1, -1 do
    count = count + 1
    result = s:sub(i, i) .. result
    if count % 3 == 0 and count < #s then
      result = "," .. result
    end
  end
  return result
end

function MiningGameCtrl:CheckPassAllLevel()
  local bPassAllLevel = self.miningData:GetPassAllLevelResult()
  self._mapNode.FinishPanel:SetActive(bPassAllLevel)
  self._mapNode.imgShovel:SetActive(not bPassAllLevel)
  self._mapNode.GirdListPrefab:SetActive(not bPassAllLevel)
end

function MiningGameCtrl:OnBtnClick_OpenGuidePanel()
  EventManager.Hit(EventId.OpenPanel, self._panel.nGuidePanelId, self.nActId)
end

function MiningGameCtrl:OnBtnClick_OpenTask()
  local controllConfig = ConfigTable.GetData("MiningControl", self.nActId)
  if controllConfig == nil then
    return
  end
  if controllConfig.UseType == GameEnum.ActivityUseType.Group then
    if PlayerData.Activity:IsActivityInActivityGroup(self.nActId) then
      local mapActivityData = ConfigTable.GetData("Activity", self.nActId)
      local actGroupId = mapActivityData.MidGroupId
      local actGroupData = PlayerData.Activity:GetActivityGroupDataById(actGroupId)
      local taskActId = actGroupData:GetActivityDataByIndex(AllEnum.ActivityThemeFuncIndex.Task).ActivityId
      local taskActData = PlayerData.Activity:GetActivityDataById(taskActId)
      if taskActData ~= nil and taskActData:CheckActivityOpen() then
        EventManager.Hit(EventId.OpenPanel, PanelId.Task_11100, taskActId, GameEnum.ActivityTaskTabType.Tab4)
        return
      end
      RedDotManager.UnRegisterNode(RedDotDefine.Activity_Group_Task_Group, {
        actGroupId,
        taskActId,
        mapActivityData.MiniGameRedDot
      }, self._mapNode.reward_reddot)
      self._mapNode.reward_reddot:SetActive(false)
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_End_Notice"))
    end
  else
    EventManager.Hit(EventId.OpenPanel, controllConfig.QuestPanelId, self.nActId)
  end
end

function MiningGameCtrl:OnBtnClick_OpenAxeTips()
  UTILS.ClickItemGridWithTips(self.miningData:GetAxeId(), self._mapNode.Btn_Axe.transform, true, false, true)
end

function MiningGameCtrl:OnEvent_UpdateScore(score)
  self.nNewScore = score
end

function MiningGameCtrl:OnEvent_UpdateScoreFx()
  self._mapNode.animator_score:Play("score_in")
  self:UpdateScore(self.nNewScore)
end

function MiningGameCtrl:OnEvent_UpdateRewardStatus(nId)
  local nIndex = 0
  for i = 1, #self.tbRewardDataList do
    if self.tbRewardDataList[i].nId == nId then
      nIndex = i
    end
  end
  if nIndex == 0 then
    return
  end
  self.gridListCtrl:FindReward(nIndex, self._mapNode.txt_score:GetComponent("RectTransform"))
  local img_get = self._mapNode.signal[nIndex].transform:Find("bg_reward/img_get")
  img_get.gameObject:SetActive(true)
  for _, rewardData in pairs(self.tbRewardDataList) do
    if rewardData.bIsGet == false then
      return
    end
  end
  EventManager.Hit(EventId.BlockInput, true)
  self.bInPassAnim = true
  self._mapNode.GoNextLevelPanel:SetActive(true)
  WwiseAudioMgr:PostEvent("mode_digging1_complete")
  self:AddTimer(1, 2.3, function()
    self._mapNode.animator:Play("MiningGamePanel_out")
  end, true, true, true)
  self:AddTimer(1, 2.5, function()
    self._mapNode.GoNextLevelPanel:SetActive(false)
  end, true, true, true)
  self:AddTimer(1, 2.7, function()
    if self.passAnimCb ~= nil then
      self.passAnimCb()
      self.bInPassAnim = false
    end
    EventManager.Hit(EventId.BlockInput, false)
  end, true, true, true)
end

function MiningGameCtrl:OnEvent_MiningKnockResult(tbSkillData)
  for k, v in pairs(tbSkillData) do
    local gridData = v.tbUpdateGrid
    for _, n in pairs(gridData) do
      self:UpdateGridCell(n, v.nEffectType)
    end
  end
end

function MiningGameCtrl:OnEvent_UpdateLevelData()
  if self.bInPassAnim then
    function self.passAnimCb()
      self:UpdateLevelData()
    end
  else
    self:UpdateLevelData()
  end
end

function MiningGameCtrl:OnEvent_UpdateGridCell(data, nEffectType)
  self:UpdateGridCell(data, nEffectType)
end

function MiningGameCtrl:OnEvent_UpdateAxeCount(nCount)
  self:UpdateAxeCount(nCount)
end

function MiningGameCtrl:OnEvent_ShowReward()
  self.gridListCtrl:ShowReward(self.tbRewardDataList)
end

function MiningGameCtrl:OnEvent_Error()
  EventManager.Hit(EventId.BlockInput, true)
  self.miningData:RequestLevelData(0, function()
    EventManager.Hit(EventId.BlockInput, false)
  end)
end

return MiningGameCtrl

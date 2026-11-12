local TutorialLevelCtrl = class("TutorialLevelCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local typeUITextKey = {
  [1] = "Tutorial_Leveltype_1",
  [2] = "Tutorial_Leveltype_2",
  [3] = "Tutorial_Leveltype_3"
}
local receivedColor = Color(0.0392156862745098, 0.7450980392156863, 0.7725490196078432)
local normalColor = Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764)
TutorialLevelCtrl._mapNodeConfig = {
  bg_title = {},
  txt_title = {
    sComponentName = "TMP_Text",
    sLanguageId = "QuestNewbiePanel_Tab_2"
  },
  txt_progress = {sComponentName = "TMP_Text"},
  bg_title_com = {},
  txt_title_com = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Tutorial_Finish"
  },
  Lsv = {
    sComponentName = "LoopScrollView"
  }
}
TutorialLevelCtrl._mapEventConfig = {
  [EventId.QuestDataRefresh] = "OnEvent_QuestDataRefresh",
  [EventId.TutorialQuestReceived] = "OnEvent_TutorialQuestReceived",
  Tutorial_Refesh = "Refresh"
}
TutorialLevelCtrl._mapRedDotConfig = {}

function TutorialLevelCtrl:Awake()
  self.itemCtrl = {}
end

function TutorialLevelCtrl:OnEnable()
end

function TutorialLevelCtrl:OnDisable()
  self:UnBind()
end

function TutorialLevelCtrl:OnDestroy()
  self:UnBind()
end

function TutorialLevelCtrl:UnBind()
  if self.itemCtrl ~= nil then
    for _, ctrl in pairs(self.itemCtrl) do
      self:UnbindCtrlByNode(ctrl)
    end
  end
  self.itemCtrl = {}
end

function TutorialLevelCtrl:Refresh()
  self.tbLevels = clone(PlayerData.TutorialData:GetLevelList())
  
  local function sortFunc(a, b)
    local aData = PlayerData.TutorialData:GetLevelData(a)
    local bData = PlayerData.TutorialData:GetLevelData(b)
    if aData.LevelStatus == bData.LevelStatus then
      return aData.nlevelId < bData.nlevelId
    end
    return aData.LevelStatus < bData.LevelStatus
  end
  
  table.sort(self.tbLevels, sortFunc)
  self._mapNode.Lsv.gameObject:SetActive(true)
  self._mapNode.Lsv:SetAnim(0.08)
  self._mapNode.Lsv:Init(#self.tbLevels, self, self.OnGridRefresh)
  self._mapNode.bg_title_com:SetActive(false)
  self._mapNode.bg_title:SetActive(false)
  local nTotalCount, nReceivedCount = PlayerData.TutorialData:GetProgress()
  if nTotalCount == nReceivedCount then
    self._mapNode.bg_title_com:SetActive(true)
  else
    self._mapNode.bg_title:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txt_progress, orderedFormat(ConfigTable.GetUIText("Tutorial_LevelCount"), nReceivedCount, nTotalCount))
  end
  return 0
end

function TutorialLevelCtrl:OnGridRefresh(goGrid, nGridIndex)
  local nIndex = nGridIndex + 1
  local levelId = self.tbLevels[nIndex]
  local levelConfig = ConfigTable.GetData("TutorialLevel", levelId)
  local levelData = PlayerData.TutorialData:GetLevelData(levelId)
  if levelConfig == nil or levelData == nil then
    return
  end
  local db = goGrid.transform:Find("btnGrid/AnimRoot/imgBg/db/")
  local txtName = goGrid.transform:Find("btnGrid/AnimRoot/imgBg/name/txtName"):GetComponent("TMP_Text")
  local txtIndex = goGrid.transform:Find("btnGrid/AnimRoot/imgBg/db/txtIndex"):GetComponent("TMP_Text")
  local txtType = goGrid.transform:Find("btnGrid/AnimRoot/imgBg/db/txtType"):GetComponent("TMP_Text")
  local item = goGrid.transform:Find("btnGrid/AnimRoot/imgBg/btnRewardItem/AnimRoot/item").gameObject
  local btnItem = goGrid.transform:Find("btnGrid/AnimRoot/imgBg/btnRewardItem"):GetComponent("UIButton")
  local nInstanceId = item:GetInstanceID()
  if not self.itemCtrl[nInstanceId] then
    self.itemCtrl[nInstanceId] = self:BindCtrlByNode(item, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  btnItem.onClick:RemoveAllListeners()
  btnItem.onClick:AddListener(function()
    local nRewardId = levelConfig.Item1
    if nRewardId ~= nil then
      UTILS.ClickItemGridWithTips(nRewardId, btnItem.transform, true, true, false)
    end
  end)
  NovaAPI.SetTMPText(txtName, levelConfig.Title)
  NovaAPI.SetTMPText(txtIndex, string.format("%02d", levelConfig.Id))
  NovaAPI.SetTMPText(txtType, ConfigTable.GetUIText(typeUITextKey[levelConfig.TutorialType]))
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(db)
  local bReceived = false
  if levelData.LevelStatus == AllEnum.ActQuestStatus.Received then
    bReceived = true
  end
  self.itemCtrl[nInstanceId]:SetItem(levelConfig.Item1, nil, levelConfig.Qty1, nil, bReceived)
  local imgFinish = goGrid.transform:Find("btnGrid/AnimRoot/imgBg/name/imgFinish")
  imgFinish.gameObject:SetActive(bReceived)
  if bReceived then
    NovaAPI.SetTMPColor(txtName, receivedColor)
  else
    NovaAPI.SetTMPColor(txtName, normalColor)
  end
  local btnActReceive = goGrid.transform:Find("btnGrid/AnimRoot/imgBg/btnActReceive"):GetComponent("UIButton")
  local btnActReceiveGray = goGrid.transform:Find("btnGrid/AnimRoot/imgBg/btnActReceiveGray"):GetComponent("UIButton")
  local txtBtnActReceive = btnActReceive.transform:Find("AnimRoot/txtBtnActReceive"):GetComponent("TMP_Text")
  local txtBtnActReceiveGray = btnActReceiveGray.transform:Find("AnimRoot/txtBtnActReceiveGray"):GetComponent("TMP_Text")
  btnActReceive.gameObject:SetActive(levelData.LevelStatus == AllEnum.ActQuestStatus.Complete)
  btnActReceiveGray.gameObject:SetActive(levelData.LevelStatus ~= AllEnum.ActQuestStatus.Complete)
  NovaAPI.SetTMPText(txtBtnActReceive, ConfigTable.GetUIText("Tutorial_GetReward"))
  NovaAPI.SetTMPText(txtBtnActReceiveGray, ConfigTable.GetUIText("Tutorial_Go"))
  btnActReceive.onClick:RemoveAllListeners()
  btnActReceiveGray.onClick:RemoveAllListeners()
  btnActReceive.onClick:AddListener(function()
    PlayerData.TutorialData:GetLevelReward(levelId)
  end)
  btnActReceiveGray.onClick:AddListener(function()
    local buildData = ConfigTable.GetData("TrialBuild", levelConfig.TutorialBuild)
    if buildData == nil then
      return
    end
    local charIdList = {}
    local discIdList = {}
    for _, id in pairs(buildData.Char) do
      local charData = ConfigTable.GetData("TrialCharacter", id)
      if charData ~= nil then
        table.insert(charIdList, charData.CharId)
      end
    end
    for _, id in pairs(buildData.Disc) do
      local discData = ConfigTable.GetData("TrialDisc", id)
      if discData ~= nil then
        table.insert(discIdList, discData.DiscId)
      end
    end
    
    local function cb()
      CS.AdventureModuleHelper.EnterDynamic(levelConfig.FloorId, charIdList, GameEnum.dynamicLevelType.Tutorial, nil)
      NovaAPI.EnterModule("AdventureModuleScene", true)
    end
    
    PlayerData.TutorialData:EnterLevel(levelConfig.Id, cb)
  end)
  local nLockType = PlayerData.TutorialData:GetLevelLockType(levelId)
  local mask = goGrid.transform:Find("btnGrid/AnimRoot/mask")
  mask.gameObject:SetActive(nLockType ~= AllEnum.TutorialLevelLockType.None)
  if nLockType ~= AllEnum.TutorialLevelLockType.None then
    local txt_tips = mask.transform:Find("imgLock/lockTips/txt_locktip"):GetComponent("TMP_Text")
    if nLockType == AllEnum.TutorialLevelLockType.WorldClass then
      NovaAPI.SetTMPText(txt_tips, orderedFormat(ConfigTable.GetUIText("Tutorial_WorldClassTip"), levelConfig.WorldClass))
    elseif nLockType == AllEnum.TutorialLevelLockType.PreLevel then
      NovaAPI.SetTMPText(txt_tips, orderedFormat(ConfigTable.GetUIText("Tutorial_PreLevelsTip"), string.format("%02d", levelConfig.PreLevelId)))
    end
    local lockTips = mask.transform:Find("imgLock/lockTips"):GetComponent("RectTransform")
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(lockTips)
  end
end

function TutorialLevelCtrl:OnEvent_QuestDataRefresh(questType)
  if self.gameObject.activeSelf then
    self:Refresh()
  end
end

function TutorialLevelCtrl:OnEvent_TutorialQuestReceived(msgData)
  self:Refresh()
end

return TutorialLevelCtrl

local MathParkourLevelSelectCtrl = class("MathParkourLevelSelectCtrl", BaseCtrl)
local SpineManager = require("Game.Spine.SpineManager")
local layoutRight = 915
local layoutRightDefault = 322
local layoutMax = -427
MathParkourLevelSelectCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  btnCloseBg = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseBg"
  },
  togRoot = {nCount = 7},
  btnTask = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Task"
  },
  txtTask = {
    sComponentName = "TMP_Text",
    sLanguageId = "MathParkour_QuestTitle"
  },
  Sp_BookScene = {
    sComponentName = "RectTransform"
  },
  Sp_BookSceneFront = {
    sComponentName = "RectTransform"
  },
  rt_Toggle = {},
  srToggle = {
    sComponentName = "UIScrollRect"
  },
  rt_ToggleTrans = {
    sNodeName = "rt_Toggle",
    sComponentName = "RectTransform"
  },
  levelDetail = {
    sNodeName = "LevelDetailsPanel",
    sCtrlName = "Game.UI.Activity.MathParkour.MathParkourLevelDetailCtrl"
  },
  charSpine = {sNodeName = "Sp_char"},
  reward_reddot = {}
}
MathParkourLevelSelectCtrl._mapEventConfig = {
  MathParkourLevelUpdate = "OnEvent_LevelUpdate"
}
MathParkourLevelSelectCtrl._mapRedDotConfig = {}

function MathParkourLevelSelectCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
  end
end

function MathParkourLevelSelectCtrl:OnEnable()
  self._mapNode.rt_Toggle.gameObject:SetActive(false)
  local aniamtor = self.gameObject:GetComponent("Animator")
  if aniamtor ~= nil then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      
      aniamtor:Play("MathParkourLevelsSelect_in")
      self._mapNode.rt_Toggle.gameObject:SetActive(true)
    end
    
    cs_coroutine.start(wait)
  end
  self._mapNode.Sp_BookSceneFront.gameObject:SetActive(true)
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
    end
  end
  self:RefreshLevelList()
  self._mapNode.levelDetail:ClosePanel()
  NovaAPI.SetLayoutGroupPadding(self._mapNode.rt_Toggle, 194, layoutRightDefault, -32, 0)
  self._mapNode.Sp_BookScene.localPosition = Vector3(0, self._mapNode.Sp_BookScene.localPosition.y, 0)
  self._mapNode.rt_ToggleTrans.localPosition = Vector3(0, self._mapNode.rt_ToggleTrans.localPosition.y, 0)
  if 0 < self._panel.nSelectIndex then
    local cacheLevelId = self.actData:GetCacheLevelId()
    if cacheLevelId ~= nil then
      for i, v in ipairs(self.tbLevelData) do
        if v.nId == cacheLevelId then
          self._panel.nSelectIndex = i
          self.actData:ClearCacheLevelId()
          break
        end
      end
    end
    self:AddTimer(1, 1.5, function()
      self:ShowDetail(self.tbLevelData[self._panel.nSelectIndex], self._panel.nSelectIndex, false)
      local imgSelect = self._mapNode.togRoot[self._panel.nSelectIndex].transform:Find("tog/AnimRoot/AnimSwitch/imgSelect")
      imgSelect.gameObject:SetActive(true)
      if self._panel.nSelectIndex > 4 then
        NovaAPI.SetLayoutGroupPadding(self._mapNode.rt_Toggle, 194, layoutRight, -32, 0)
        
        local function wait()
          coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
          local moveTime = 0.2
          local moveX = -325 - 340 * (self._panel.nSelectIndex - 5)
          self._mapNode.rt_ToggleTrans:DOLocalMoveX(moveX, moveTime)
          self._mapNode.Sp_BookScene:DOLocalMoveX(moveX, moveTime)
        end
        
        cs_coroutine.start(wait)
      end
    end, true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, 1.5)
  else
    EventManager.Hit(EventId.TemporaryBlockInput, 1)
  end
  SpineManager.PlayAnim(self._mapNode.Sp_BookScene.gameObject, "in", false)
  SpineManager.PlayAnim(self._mapNode.Sp_BookSceneFront, "in_Front", false)
  self:AddTimer(1, 1, function()
    SpineManager.PlayAnim(self._mapNode.Sp_BookScene.gameObject, "idle", true)
    self._mapNode.Sp_BookSceneFront.gameObject:SetActive(false)
  end, true, true, true)
  
  function self.onScrollValueChanged(value)
    self._mapNode.Sp_BookScene.localPosition = Vector3(self._mapNode.rt_ToggleTrans.localPosition.x, self._mapNode.Sp_BookScene.localPosition.y, 0)
  end
  
  self._mapNode.srToggle.onValueChanged:AddListener(self.onScrollValueChanged)
  SpineManager.PlayAnim(self._mapNode.charSpine, "in", false)
  self:AddTimer(1, 0.9, function()
    SpineManager.PlayAnim(self._mapNode.charSpine, "idle", true)
  end, true, true, true)
end

function MathParkourLevelSelectCtrl:OnDisable()
  if self.onScrollValueChanged ~= nil then
    self._mapNode.srToggle.onValueChanged:RemoveListener(self.onScrollValueChanged)
    self.onScrollValueChanged = nil
  end
end

function MathParkourLevelSelectCtrl:RefreshLevelList()
  self.actData = PlayerData.Activity:GetActivityDataById(self.nActId)
  if self.actData == nil then
    return
  end
  self.tbLevelData = self.actData:GetAllLevelData()
  for i = 1, 7 do
    local levelData = self.tbLevelData[i]
    if levelData ~= nil then
      self:SetLevelToggle(levelData, self._mapNode.togRoot[i], i)
      self._mapNode.togRoot[i]:SetActive(true)
    else
      self._mapNode.togRoot[i]:SetActive(false)
    end
  end
end

function MathParkourLevelSelectCtrl:OnEvent_LevelUpdate()
  self:RefreshLevelList()
end

function MathParkourLevelSelectCtrl:OnDestroy()
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
  end
end

function MathParkourLevelSelectCtrl:SetLevelToggle(levelData, toggle, nIndex)
  local rt_Targets = toggle.transform:Find("tog/grpText/rt_Targets")
  local rtLockPreLv = toggle.transform:Find("tog/grpText/rtLockPreLv")
  local txt_Open = toggle.transform:Find("tog/AnimRoot/AnimSwitch/txt_Open"):GetComponent("TextMeshProUGUI")
  local txt_Lock = toggle.transform:Find("tog/AnimRoot/AnimSwitch/txt_Lock"):GetComponent("TextMeshProUGUI")
  local levelUnlock = self.actData:GetLevelUnlock(levelData.nId)
  local tog = toggle.transform:Find("tog"):GetComponent("UIButton")
  tog.onClick:RemoveAllListeners()
  rt_Targets.gameObject:SetActive(levelUnlock)
  rtLockPreLv.gameObject:SetActive(not levelUnlock)
  txt_Open.gameObject:SetActive(levelUnlock)
  txt_Lock.gameObject:SetActive(not levelUnlock)
  local sLevelIndex = string.format("%02d", nIndex)
  NovaAPI.SetTMPText(txt_Open, sLevelIndex)
  NovaAPI.SetTMPText(txt_Lock, sLevelIndex)
  local imgSelect = toggle.transform:Find("tog/AnimRoot/AnimSwitch/imgSelect")
  imgSelect.gameObject:SetActive(false)
  if not levelUnlock then
    return
  end
  for i = 1, 3 do
    local btnTarget = rt_Targets.transform:Find("btnTarget" .. i):GetComponent("Button")
    btnTarget.interactable = i <= levelData.nStar
  end
  tog.onClick:AddListener(function()
    self:ShowDetail(levelData, nIndex, true)
    imgSelect.gameObject:SetActive(true)
  end)
  local bNewDot = toggle.transform:Find("tog/AnimRoot/AnimSwitch/redH")
  RedDotManager.RegisterNode(RedDotDefine.Activity_MathParkour_New_Level, {
    self.nActId,
    levelData.nId
  }, bNewDot)
end

function MathParkourLevelSelectCtrl:ShowDetail(levelData, nIndex, bScroll)
  local tempIndex = self._panel.nSelectIndex
  if 0 < tempIndex then
    local imgSelect = self._mapNode.togRoot[tempIndex].transform:Find("tog/AnimRoot/AnimSwitch/imgSelect")
    imgSelect.gameObject:SetActive(false)
  end
  self._panel.nSelectIndex = nIndex
  self._mapNode.levelDetail:ShowPanel(self.nActId, levelData)
  if bScroll and 4 < nIndex then
    NovaAPI.SetLayoutGroupPadding(self._mapNode.rt_Toggle, 194, layoutRight, -32, 0)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      local moveTime = 0.2
      local moveX = -325 - 340 * (nIndex - 5)
      self._mapNode.rt_ToggleTrans:DOLocalMoveX(moveX, moveTime)
      self._mapNode.Sp_BookScene:DOLocalMoveX(moveX, moveTime)
    end
    
    cs_coroutine.start(wait)
  end
end

function MathParkourLevelSelectCtrl:OnBtnClick_CloseBg()
  local tempIndex = self._panel.nSelectIndex
  if 0 < tempIndex then
    local imgSelect = self._mapNode.togRoot[tempIndex].transform:Find("tog/AnimRoot/AnimSwitch/imgSelect")
    imgSelect.gameObject:SetActive(false)
  end
  self._panel.nSelectIndex = 0
  self._mapNode.levelDetail:ClosePanel()
  local moveTime = 0.2
  EventManager.Hit(EventId.TemporaryBlockInput, moveTime)
  local layout = layoutRight
  self.tweener = DOTween.To(function()
    return layout
  end, function(v)
    NovaAPI.SetLayoutGroupPadding(self._mapNode.rt_Toggle, 194, math.floor(v), -32, 0)
  end, layoutRightDefault, moveTime):OnComplete(function()
    NovaAPI.SetLayoutGroupPadding(self._mapNode.rt_Toggle, 194, layoutRightDefault, -32, 0)
  end)
end

function MathParkourLevelSelectCtrl:OnBtnClick_Task()
  if PlayerData.Activity:IsActivityInActivityGroup(self.nActId) then
    local mapActivityData = ConfigTable.GetData("Activity", self.nActId)
    local actGroupId = mapActivityData.MidGroupId
    local actGroupData = PlayerData.Activity:GetActivityGroupDataById(actGroupId)
    local taskActId = actGroupData:GetActivityDataByIndex(AllEnum.ActivityThemeFuncIndex.Task).ActivityId
    local taskActData = PlayerData.Activity:GetActivityDataById(taskActId)
    if taskActData ~= nil and taskActData:CheckActivityOpen() then
      EventManager.Hit(EventId.OpenPanel, PanelId.Task_20104, taskActId, GameEnum.ActivityTaskTabType.Tab4)
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
end

return MathParkourLevelSelectCtrl

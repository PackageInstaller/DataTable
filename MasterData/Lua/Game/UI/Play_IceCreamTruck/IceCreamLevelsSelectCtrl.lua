local TimerManager = require("GameCore.Timer.TimerManager")
local IceCreamLevelsSelectCtrl = class("IceCreamLevelsSelectCtrl", BaseCtrl)
IceCreamLevelsSelectCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  LevelDetailsPanel = {
    sCtrlName = "Game.UI.Play_IceCreamTruck.IceCreamLevelDetailCtrl"
  },
  LevelGroup = {
    nCount = 4,
    sCtrlName = "Game.UI.Play_IceCreamTruck.IceCreamLevelGroupCtrl"
  },
  btnTarget = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Target"
  },
  TMPBtnTarget = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_Target"
  },
  goRedDotTarget = {}
}
IceCreamLevelsSelectCtrl._mapEventConfig = {}

function IceCreamLevelsSelectCtrl:Awake()
end

function IceCreamLevelsSelectCtrl:FadeIn()
end

function IceCreamLevelsSelectCtrl:FadeOut()
end

function IceCreamLevelsSelectCtrl:OnEnable()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
  end
  self.animatorRoot = self.gameObject:GetComponent("Animator")
  self:InitLevel(self.nActId)
  self:RegisterTaskRedNode()
  EventManager.Hit(EventId.SetTransition)
end

function IceCreamLevelsSelectCtrl:OnDisable()
  if self._tmrSwitchDetail ~= nil then
    TimerManager.Remove(self._tmrSwitchDetail, false)
    self._tmrSwitchDetail = nil
  end
end

function IceCreamLevelsSelectCtrl:OnDestroy()
end

function IceCreamLevelsSelectCtrl:InitLevel(nActId)
  self.IceCreamActData = PlayerData.Activity:GetActivityDataById(nActId)
  if self.IceCreamActData == nil then
    printError("没有冰淇淋活动数据")
    return
  end
  self.AllLevelTypeTable = self.IceCreamActData:GetLevelTypeTable()
  if self.AllLevelTypeTable == nil then
    printError("关卡组信息为空")
    return
  end
  local nGroupCount = #self._mapNode.LevelGroup
  for i = 1, nGroupCount do
    local value = self.AllLevelTypeTable[i]
    if value ~= nil then
      self._mapNode.LevelGroup[i].gameObject:SetActive(true)
      self:OnRefreshLevelGroup(i, value)
    else
      self._mapNode.LevelGroup[i].gameObject:SetActive(false)
    end
  end
  if nGroupCount < #self.AllLevelTypeTable then
    printError(string.format("[IceCream] LevelType 数(%d) 超出预绑定 LevelGroup 数(%d)", #self.AllLevelTypeTable, nGroupCount))
  end
end

function IceCreamLevelsSelectCtrl:OnRefreshLevelGroup(gridIndex, tbLevels)
  self._mapNode.LevelGroup[gridIndex]:InitData(self.nActId, gridIndex, tbLevels, self)
end

function IceCreamLevelsSelectCtrl:OpenLevelDetail_Animator(nTypeIndex)
  if nTypeIndex < 1 or 4 < nTypeIndex then
    return
  end
  local sAnimatorIn = string.format("IceCreamLevelsSelectPanel_in%d", nTypeIndex)
  self.animatorRoot:Play(sAnimatorIn, 0, 0)
  local nAnimTime = NovaAPI.GetAnimClipLength(self.animatorRoot, {sAnimatorIn})
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimTime)
end

function IceCreamLevelsSelectCtrl:OpenNextLevelDetail(nTypeIndex, NextTypeIndex)
  if nTypeIndex < 1 or 4 < nTypeIndex or NextTypeIndex < 1 or 4 < NextTypeIndex then
    return
  end
  local sAnimatorOut = string.format("IceCreamLevelsSelectPanel_out%d", nTypeIndex)
  self.animatorRoot:Play(sAnimatorOut, 0, 0)
  local nAnimTime = NovaAPI.GetAnimClipLength(self.animatorRoot, {sAnimatorOut})
  if type(nAnimTime) ~= "number" or nAnimTime <= 0 then
    printWarn("[IceCream] 拿不到 out 动画时长，直接切到下一关详情：anim=" .. sAnimatorOut)
    EventManager.Hit("Event_OpenLevelDetail", NextTypeIndex)
    return
  end
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimTime)
  if self._tmrSwitchDetail ~= nil then
    TimerManager.Remove(self._tmrSwitchDetail, false)
    self._tmrSwitchDetail = nil
  end
  self._tmrSwitchDetail = self:AddTimer(1, nAnimTime, function()
    self._tmrSwitchDetail = nil
    EventManager.Hit("Event_OpenLevelDetail", NextTypeIndex)
  end, true, true, true)
end

function IceCreamLevelsSelectCtrl:CloseLevelDetail_AnimatorOut(nTypeIndex)
  if nTypeIndex < 1 or 4 < nTypeIndex then
    return
  end
  local sAnimatorOut = string.format("IceCreamLevelsSelectPanel_out%d", nTypeIndex)
  self.animatorRoot:Play(sAnimatorOut, 0, 0)
end

function IceCreamLevelsSelectCtrl:RegisterTaskRedNode()
  local mapActivityData = ConfigTable.GetData("Activity", self.nActId)
  if mapActivityData ~= nil then
    local nGroupId = mapActivityData.MidGroupId
    local mapGroupData = PlayerData.Activity:GetActivityGroupDataById(nGroupId)
    if mapGroupData ~= nil then
      local actData = mapGroupData:GetActivityDataByIndex(AllEnum.ActivityThemeFuncIndex.Task)
      if actData ~= nil then
        RedDotManager.RegisterNode(RedDotDefine.Activity_Group_Task_Group, {
          nGroupId,
          actData.ActivityId,
          mapActivityData.MiniGameRedDot
        }, self._mapNode.goRedDotTarget)
      else
        self._mapNode.goRedDotTarget:SetActive(false)
      end
    else
      self._mapNode.goRedDotTarget:SetActive(false)
    end
  else
    self._mapNode.goRedDotTarget:SetActive(false)
  end
end

function IceCreamLevelsSelectCtrl:OnBtnClick_Target()
  local mapActivityData = ConfigTable.GetData("Activity", self.nActId)
  if mapActivityData ~= nil then
    local nGroupId = mapActivityData.MidGroupId
    local mapGroupData = PlayerData.Activity:GetActivityGroupDataById(nGroupId)
    if mapGroupData ~= nil then
      local actData = mapGroupData:GetActivityDataByIndex(AllEnum.ActivityThemeFuncIndex.Task)
      if actData ~= nil then
        EventManager.Hit(EventId.OpenPanel, self._panel.nQuestPanelId, actData.ActivityId, 4)
      end
    end
  end
end

return IceCreamLevelsSelectCtrl

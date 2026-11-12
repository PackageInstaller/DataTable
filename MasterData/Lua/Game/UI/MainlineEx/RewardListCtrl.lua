local RewardListCtrl = class("RewardListCtrl", BaseCtrl)
RewardListCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Instance_Reward_Preview_Title"
  },
  rewardList = {
    sComponentName = "LoopScrollView"
  },
  btnCloseRewardList = {
    sComponentName = "UIButton",
    callback = "OnBtnClickClose"
  },
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClickClose"
  },
  animWindow = {sNodeName = "t_window", sComponentName = "Animator"},
  goWindow = {sNodeName = "t_window"}
}
RewardListCtrl._mapEventConfig = {}

function RewardListCtrl:Awake()
  self._mapNode.goWindow:SetActive(false)
end

function RewardListCtrl:FadeOut()
end

function RewardListCtrl:OnEnable()
end

function RewardListCtrl:OnDisable()
end

function RewardListCtrl:OnDestroy()
end

function RewardListCtrl:OnRelease()
end

function RewardListCtrl:OpenPanel(tbReward, tbExtraDropReward)
  self._mapNode.goWindow:SetActive(false)
  self._mapNode.btnBlur.gameObject:SetActive(true)
  self.gameObject:SetActive(true)
  self._mapGrid = {}
  self.tbReward = {}
  local extraDropRewardCount = 0
  if tbExtraDropReward ~= nil then
    for k, v in pairs(tbExtraDropReward) do
      extraDropRewardCount = extraDropRewardCount + 1
    end
  end
  local needEx = tbExtraDropReward ~= nil and 0 < extraDropRewardCount
  local bBeforebFirstPass = true
  for i = 1, #tbReward do
    local bCurFirstPass = tbReward[i][3] ~= nil and tbReward[i][3] == 1
    if not bCurFirstPass and bBeforebFirstPass and needEx then
      tbExtraDropReward[6] = true
      table.insert(self.tbReward, tbExtraDropReward)
      needEx = false
    end
    bBeforebFirstPass = bCurFirstPass
    table.insert(self.tbReward, tbReward[i])
  end
  if needEx then
    tbExtraDropReward[6] = true
    table.insert(self.tbReward, tbExtraDropReward)
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goWindow:SetActive(true)
    self._mapNode.animWindow:Play("t_window_04_t_in")
    self._mapNode.rewardList:SetAnim(0.04)
    self._mapNode.rewardList:Init(#self.tbReward, self, self.OnGridRefresh, self.OnGridBtnClick)
  end
  
  cs_coroutine.start(wait)
end

function RewardListCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIdx = gridIndex + 1
  if self._mapGrid[goGrid] == nil then
    local goItem = goGrid.transform:Find("btnGrid/AnimRoot/gridRt/Item").gameObject
    self._mapGrid[goGrid] = self:BindCtrlByNode(goItem, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  local tbItem = self.tbReward[nIdx]
  local nRewardTypeIndex, nReceiveIndex, nShowCountIndex, nExtraDropIndex = 3, 4, 5, 6
  local bFloatCount = type(tbItem[4]) == "number"
  if bFloatCount then
    nRewardTypeIndex = 4
    nReceiveIndex = 5
    nShowCountIndex = 6
    nExtraDropIndex = 7
  end
  local bReceived = tbItem[nReceiveIndex] == true
  local nRewardType = tbItem[nRewardTypeIndex] or 0
  local bExtraDrop = tbItem[nExtraDropIndex] == true
  local nCount = -1
  if tbItem[nShowCountIndex] ~= false then
    local tbItemCount = bFloatCount and {
      tbItem[1],
      tbItem[2],
      tbItem[3],
      tbItem[4]
    } or {
      tbItem[1],
      tbItem[2],
      tbItem[3]
    }
    nCount = UTILS.ParseRewardItemCount(tbItemCount)
  end
  self._mapGrid[goGrid]:SetItem(tbItem[1], nil, nCount, nil, bReceived, nRewardType == 1, nRewardType == 2, false, false, false, bExtraDrop == true)
end

function RewardListCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIdx = gridIndex + 1
  local rtItem = goGrid.transform:Find("btnGrid/AnimRoot/gridRt/Item")
  local nTid = self.tbReward[nIdx][1]
  UTILS.ClickItemGridWithTips(nTid, rtItem, true, true, false)
end

function RewardListCtrl:OnBtnClickClose(btn)
  self._mapNode.btnBlur.gameObject:SetActive(false)
  local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.animWindow, {
    "t_window_04_t_out"
  })
  self._mapNode.animWindow:Play("t_window_04_t_out")
  self:AddTimer(1, nAnimTime, function()
    self.gameObject:SetActive(false)
    for goGrid, itemCtrl in pairs(self._mapGrid) do
      self:UnbindCtrlByNode(itemCtrl)
    end
    self._mapGrid = {}
  end)
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimTime)
end

return RewardListCtrl

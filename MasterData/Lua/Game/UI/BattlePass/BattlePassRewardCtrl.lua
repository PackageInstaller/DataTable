local BattlePassRewardCtrl = class("BattlePassRewardCtrl", BaseCtrl)
BattlePassRewardCtrl._mapNodeConfig = {
  svRewardList = {
    sComponentName = "LoopScrollView"
  },
  imgPrevReward = {
    sCtrlName = "Game.UI.BattlePass.BattlePassRewardGridCtrl"
  },
  iimgIconTitleVipLock = {},
  btnAllReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AllReceive"
  },
  Content = {sComponentName = "Transform"},
  TMPTitleVip = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePassRewardPremium"
  },
  TMPTitleBase = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePassRewardNormal"
  },
  txtbtnAllReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePassReceiveAll"
  },
  UIParticleVipIcon = {}
}
BattlePassRewardCtrl._mapEventConfig = {}
BattlePassRewardCtrl._mapRedDotConfig = {}

function BattlePassRewardCtrl:Awake()
  self._mapGrid = {}
end

function BattlePassRewardCtrl:FadeIn()
end

function BattlePassRewardCtrl:FadeOut()
end

function BattlePassRewardCtrl:OnEnable()
  self.anim = self.gameObject:GetComponent("Animator")
end

function BattlePassRewardCtrl:OnDisable()
  self:UnbindAllCtrl()
end

function BattlePassRewardCtrl:OnDestroy()
end

function BattlePassRewardCtrl:OnRelease()
end

function BattlePassRewardCtrl:Refresh(tbReward, bPremium, nBattlePassLevel)
  self.tbReward = tbReward
  self.bPremium = bPremium
  self.nBattlePassLevel = nBattlePassLevel
  self.tbFocus = {}
  self.curFocus = 0
  self.bAllReceive = false
  for idx, mapReward in ipairs(tbReward) do
    if mapReward.bFocus then
      table.insert(self.tbFocus, idx)
    end
    if not mapReward.bNormalReceive and idx <= nBattlePassLevel then
      self.bAllReceive = true
    end
    if self.bPremium and not mapReward.bVipReceive and idx <= nBattlePassLevel then
      self.bAllReceive = true
    end
  end
  self._mapNode.UIParticleVipIcon:SetActive(bPremium)
  self._mapNode.iimgIconTitleVipLock:SetActive(not bPremium)
  self._mapNode.svRewardList:Init(#self.tbReward, self, self.OnGridRefresh, nil, true, nil)
  self._mapNode.btnAllReceive.gameObject:SetActive(self.bAllReceive)
end

function BattlePassRewardCtrl:SetLevelPos()
  if self.nBattlePassLevel ~= nil then
    self._mapNode.svRewardList:SetScrollGridPos(self.nBattlePassLevel - 2)
  end
end

function BattlePassRewardCtrl:PlayUnlockAnim(tbShowRewardIdx)
  if 0 < #tbShowRewardIdx then
    local nFirstIdx = tbShowRewardIdx[1]
    self._mapNode.svRewardList:SetScrollGridPos(nFirstIdx - 1, 0.1, 0)
    
    local function wait()
      local nDelay = 0
      for _, nIdx in ipairs(tbShowRewardIdx) do
        local nName = tostring(nIdx - 1)
        local rtItem = self._mapNode.Content:Find(nName)
        if rtItem ~= nil and self._mapGrid[rtItem.gameObject] ~= nil then
          self._mapGrid[rtItem.gameObject]:BattlePassRewardShowEnableEffect(self.bPremium, nDelay)
          nDelay = nDelay + 0.1
        end
      end
      self._mapNode.imgPrevReward:BattlePassRewardShowEnableEffect(self.bPremium, nDelay)
    end
    
    self:AddTimer(1, 0.1, wait, true, true, true, nil)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.6)
  end
end

function BattlePassRewardCtrl:UnbindAllCtrl()
  for _, mapCtrl in pairs(self._mapGrid) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self._mapGrid = {}
end

function BattlePassRewardCtrl:OnGridRefresh(goGrid, gridIndex)
  if self._mapGrid[goGrid] == nil then
    local mapCtrl = self:BindCtrlByNode(goGrid, "Game.UI.BattlePass.BattlePassRewardGridCtrl")
    self._mapGrid[goGrid] = mapCtrl
  end
  local nIdx = gridIndex + 1
  local rewardData = self.tbReward[nIdx]
  if rewardData ~= nil then
    self._mapGrid[goGrid]:Refresh(rewardData, self.bPremium, self.nBattlePassLevel)
  end
  local nMaxIdx = self._mapNode.svRewardList:GetMaxUseGridIndex()
  if #self.tbFocus > 0 then
    for i = 1, #self.tbFocus do
      if nMaxIdx < self.tbFocus[i] then
        if self.tbFocus[i] ~= self.curFocus then
          local rewardDataPrev = self.tbReward[self.tbFocus[i]]
          if rewardDataPrev ~= nil then
            self._mapNode.imgPrevReward:Refresh(rewardDataPrev, self.bPremium, self.nBattlePassLevel)
            self.curFocus = self.tbFocus[i]
          end
        end
        return
      end
    end
    local nIdxPrev = #self.tbFocus
    if self.tbFocus[nIdxPrev] ~= self.curFocus then
      local rewardDataPrev = self.tbReward[self.tbFocus[nIdxPrev]]
      if rewardDataPrev ~= nil then
        self._mapNode.imgPrevReward:Refresh(rewardDataPrev, self.bPremium, self.nBattlePassLevel)
        self.curFocus = self.tbFocus[nIdxPrev]
      end
    end
  else
    self._mapNode.imgPrevReward.gameObject:SetActive(false)
  end
end

function BattlePassRewardCtrl:OnBtnClick_AllReceive()
  local function callback()
  end
  
  PlayerData.BattlePass:NetMsg_BattlePassRewardReceive(true, 0, false, callback)
end

function BattlePassRewardCtrl:PlayInAnim()
  if self.anim ~= nil then
    self.anim:Play("rt_RewardList_switch")
  end
end

return BattlePassRewardCtrl

local AchievementDetailCtrl = class("AchievementDetailCtrl", BaseCtrl)
AchievementDetailCtrl._mapNodeConfig = {
  TMPCupCount = {sComponentName = "TMP_Text", nCount = 3},
  txtBtnAllReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Btn_ReceiveAll"
  },
  imgFlagIcon = {sComponentName = "Image"},
  svAchievementList = {
    sComponentName = "LoopScrollView"
  },
  btnAllReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AllReceive"
  },
  btnTab = {
    sComponentName = "UIButton",
    nCount = 5,
    callback = "OnBtnClick_Tog"
  },
  imgTabBg = {
    sCtrlName = "Game.UI.AchievementEx.AchievementToggle"
  },
  imgIconF0 = {nCount = 5},
  AnimFlag = {sNodeName = "imgFlag", sComponentName = "Animator"}
}
AchievementDetailCtrl._mapEventConfig = {
  AchievementRefresh = "OnEvent_ReceiveReward"
}
AchievementDetailCtrl._mapRedDotConfig = {}

function AchievementDetailCtrl:Awake()
  self.mapAllAchievement = {}
  self.mapAllAchievementCount = {}
  self.mapGrid = {}
  self.curIdx = 1
end

function AchievementDetailCtrl:FadeIn()
end

function AchievementDetailCtrl:FadeOut()
end

function AchievementDetailCtrl:OnEnable()
  self._mapNode.imgTabBg:SetText(ConfigTable.GetUIText("Achievement_Type_1"), ConfigTable.GetUIText("Achievement_Type_2"), ConfigTable.GetUIText("Achievement_Type_3"), ConfigTable.GetUIText("Achievement_Type_4"), ConfigTable.GetUIText("Achievement_Type_5"))
  self:RegisterReddot()
end

function AchievementDetailCtrl:OnGridRefresh(goGrid, gridIndex)
  if self.mapGrid[goGrid] == nil then
    local mapCtrl = self:BindCtrlByNode(goGrid, "Game.UI.AchievementEx.AchievementGridCtrl")
    self.mapGrid[goGrid] = mapCtrl
  end
  local nIdx = gridIndex
  if nIdx == nil then
    return
  end
  nIdx = nIdx + 1
  local mapAllAchievement = self.mapAllAchievement[self.curType][nIdx]
  self.mapGrid[goGrid]:OnGridRefresh(mapAllAchievement)
end

function AchievementDetailCtrl:OnDisable()
  for goGrid, mapCtrl in pairs(self.mapGrid) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self.mapGrid = {}
end

function AchievementDetailCtrl:OnDestroy()
end

function AchievementDetailCtrl:OnRelease()
end

function AchievementDetailCtrl:OpenDetail(nIdx)
  self.curType = nIdx
  for i = 1, 5 do
    self._mapNode.imgIconF0[i]:SetActive(nIdx == i)
  end
  self._mapNode.imgTabBg:SetState(nIdx)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    local sAnimName = "imgFlagIcon_in0" .. self.curType
    self._mapNode.AnimFlag:Play(sAnimName)
  end
  
  cs_coroutine.start(wait)
  self._mapNode.svAchievementList:Init(#self.mapAllAchievement[self.curType], self, self.OnGridRefresh)
  self:SetPngSprite(self._mapNode.imgFlagIcon, "UI/big_sprites/zs_achievement_icon_0" .. nIdx)
  NovaAPI.SetImageNativeSize(self._mapNode.imgFlagIcon)
  local bShowAllReceive = false
  for _, mapAchievement in ipairs(self.mapAllAchievement[self.curType]) do
    if mapAchievement.nStatus == 1 then
      bShowAllReceive = true
    end
  end
  self._mapNode.btnAllReceive.gameObject:SetActive(bShowAllReceive)
  local mapCount = PlayerData.Achievement:GetAchievementTypeCount(self.curType)
  NovaAPI.SetTMPText(self._mapNode.TMPCupCount[1], mapCount.tbRarity[GameEnum.itemRarity.SSR])
  NovaAPI.SetTMPText(self._mapNode.TMPCupCount[2], mapCount.tbRarity[GameEnum.itemRarity.SR])
  NovaAPI.SetTMPText(self._mapNode.TMPCupCount[3], mapCount.tbRarity[GameEnum.itemRarity.R])
end

function AchievementDetailCtrl:UpdateData()
  for _, nValue in pairs(GameEnum.achievementType) do
    self.mapAllAchievement[nValue] = {}
    local mapAllAchievement = PlayerData.Achievement:GetAchievementTypeList(nValue)
    if mapAllAchievement ~= nil then
      for _, value in pairs(mapAllAchievement) do
        if not PlayerData.Achievement:JudgeHide(nValue, value) then
          table.insert(self.mapAllAchievement[nValue], value)
        end
      end
      
      local function sortAchievement(a, b)
        if a.nStatus ~= b.nStatus then
          return a.nStatus < b.nStatus
        end
        return a.nId < b.nId
      end
      
      table.sort(self.mapAllAchievement[nValue], sortAchievement)
    end
  end
end

function AchievementDetailCtrl:RegisterReddot(...)
  for k, v in pairs(self._mapNode.btnTab) do
    local goReddot = v.transform:Find("reddot_Tab").gameObject
    RedDotManager.RegisterNode(RedDotDefine.Achievement_Tab, k, goReddot)
  end
end

function AchievementDetailCtrl:OnBtnClick_Tog(btn, nIdx)
  if nIdx == self.curType then
    return
  end
  self.curType = nIdx
  for i = 1, 5 do
    self._mapNode.imgIconF0[i]:SetActive(nIdx == i)
  end
  self._mapNode.imgTabBg:SetState(nIdx)
  self._mapNode.svAchievementList:SetAnim(0.06)
  self._mapNode.svAchievementList:Init(#self.mapAllAchievement[self.curType], self, self.OnGridRefresh)
  local mapCount = PlayerData.Achievement:GetAchievementTypeCount(self.curType)
  NovaAPI.SetTMPText(self._mapNode.TMPCupCount[1], mapCount.tbRarity[GameEnum.itemRarity.SSR])
  NovaAPI.SetTMPText(self._mapNode.TMPCupCount[2], mapCount.tbRarity[GameEnum.itemRarity.SR])
  NovaAPI.SetTMPText(self._mapNode.TMPCupCount[3], mapCount.tbRarity[GameEnum.itemRarity.R])
  self:SetPngSprite(self._mapNode.imgFlagIcon, "UI/big_sprites/zs_achievement_icon_0" .. nIdx)
  NovaAPI.SetImageNativeSize(self._mapNode.imgFlagIcon)
  local bShowAllReceive = false
  for _, mapAchievement in ipairs(self.mapAllAchievement[self.curType]) do
    if mapAchievement.nStatus == 1 then
      bShowAllReceive = true
    end
  end
  self._panel.nDetailIdx = nIdx
  self._mapNode.btnAllReceive.gameObject:SetActive(bShowAllReceive)
end

function AchievementDetailCtrl:OnBtnClick_AllReceive(btn, nIdx)
  local tbId = {}
  for _, mapAchievement in ipairs(self.mapAllAchievement[self.curType]) do
    if mapAchievement.nStatus == 1 then
      table.insert(tbId, mapAchievement.nId)
    end
  end
  PlayerData.Achievement:SendAchievementRewardReq(tbId, self.curType, nil)
end

function AchievementDetailCtrl:OnEvent_ReceiveReward()
  self:UpdateData()
  self._mapNode.svAchievementList:Init(#self.mapAllAchievement[self.curType], self, self.OnGridRefresh)
  local mapCount = PlayerData.Achievement:GetAchievementTypeCount(self.curType)
  NovaAPI.SetTMPText(self._mapNode.TMPCupCount[1], mapCount.tbRarity[GameEnum.itemRarity.SSR])
  NovaAPI.SetTMPText(self._mapNode.TMPCupCount[2], mapCount.tbRarity[GameEnum.itemRarity.SR])
  NovaAPI.SetTMPText(self._mapNode.TMPCupCount[3], mapCount.tbRarity[GameEnum.itemRarity.R])
  local bShowAllReceive = false
  for _, mapAchievement in ipairs(self.mapAllAchievement[self.curType]) do
    if mapAchievement.nStatus == 1 then
      bShowAllReceive = true
    end
  end
  self._mapNode.btnAllReceive.gameObject:SetActive(bShowAllReceive)
end

return AchievementDetailCtrl

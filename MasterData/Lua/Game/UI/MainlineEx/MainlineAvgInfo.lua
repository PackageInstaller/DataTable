local MainlineAvgInfo = class("MainlineAvgInfo", BaseCtrl)
MainlineAvgInfo._mapNodeConfig = {
  mainLineAvgLvName = {sComponentName = "TMP_Text"},
  mainLineAvgLvNum = {sComponentName = "TMP_Text"},
  mainLineAvgLvDes = {sComponentName = "TMP_Text"},
  imgAVGLevelIcon = {sComponentName = "Image"},
  txtAvgRewardTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "RogueBoss_Reward_Title"
  },
  mainLineAvgBtnTex = {
    sComponentName = "TMP_Text",
    sLanguageId = "WorldMap_MainLine_Avg_Btn"
  },
  mainLineAvgBtn = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_OpenAvg"
  },
  avgItemBtn = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reward",
    nCount = 2
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  tcAvgItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 2
  },
  animator = {sNodeName = "rtWindow", sComponentName = "Animator"}
}
MainlineAvgInfo._mapEventConfig = {}

function MainlineAvgInfo:Awake()
end

function MainlineAvgInfo:FadeOut(callback)
  if type(callback) == "function" then
    callback()
  end
end

function MainlineAvgInfo:OnEnable()
end

function MainlineAvgInfo:OnDisable()
end

function MainlineAvgInfo:OnDestroy()
end

function MainlineAvgInfo:OnRelease()
end

function MainlineAvgInfo:OpenLevelInfo(nMainlineId, nStar, tbTarget)
  self.nMainlineId = nMainlineId
  local mapMainline = ConfigTable.GetData_Mainline(nMainlineId)
  if mapMainline == nil then
    printError("nil mainlineData" .. nMainlineId)
    return
  end
  NovaAPI.SetTMPText(self._mapNode.mainLineAvgLvNum, mapMainline.Num)
  NovaAPI.SetTMPText(self._mapNode.mainLineAvgLvName, mapMainline.Name)
  NovaAPI.SetTMPText(self._mapNode.mainLineAvgLvDes, mapMainline.Desc)
  self:SetPngSprite(self._mapNode.imgAVGLevelIcon, mapMainline.MainlineImg)
  self.tbReward = decodeJson(mapMainline.RewardPreview)
  for index = 1, 2 do
    if self.tbReward[index] ~= nil then
      local bRecive = false
      if self.tbReward[index][3] == 1 and 0 < nStar then
        bRecive = true
      end
      self.tbReward[index][4] = bRecive
    end
  end
  self.tbAfterReward = {}
  for key, value in pairs(self.tbReward) do
    table.insert(self.tbAfterReward, value)
  end
  for index = 1, 2 do
    if self.tbAfterReward[index] ~= nil then
      if self.tbReward[index][4] == nil then
      end
      local bReceive = self.tbReward[index][4]
      self._mapNode.tcAvgItem[index]:SetItem(self.tbAfterReward[index][1], nil, nil, nil, bReceive, self.tbAfterReward[index][3] == 1, self.tbAfterReward[index][3] == 2)
    else
      self._mapNode.tcAvgItem[index]:SetItem(nil)
    end
  end
  self._mapNode.animator:Play("t_window_04_t_in")
end

function MainlineAvgInfo:OnBtnClick_Close()
  self.gameObject:SetActive(false)
  EventManager.Hit("SelectMainlineBattle", false)
end

function MainlineAvgInfo:OnBtnClick_Confirm()
end

function MainlineAvgInfo:OnBtnClick_MonsterInfo(btn)
  EventManager.Hit("OpenMainlineMonsterInfo", self.nMainlineId)
end

function MainlineAvgInfo:OnBtnClick_AllReward(btn)
  EventManager.Hit("OpenAllReward", self.tbReward)
end

function MainlineAvgInfo:OnBtnClick_Reward(btn)
  local nIdx = table.indexof(self._mapNode.avgItemBtn, btn)
  if self.tbAfterReward[nIdx] ~= nil then
    local nTid = self.tbAfterReward[nIdx][1]
    UTILS.ClickItemGridWithTips(nTid, btn.transform, false, true, false)
  end
end

function MainlineAvgInfo:OnBtnClick_OpenAvg(btn)
  self.gameObject:SetActive(false)
  EventManager.Hit("SelectMainlineBattle", false)
  EventManager.Hit(EventId.SendMsgEnterBattle)
end

return MainlineAvgInfo

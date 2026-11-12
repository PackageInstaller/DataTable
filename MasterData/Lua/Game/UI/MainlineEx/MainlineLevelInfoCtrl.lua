local MainlineLevelInfoCtrl = class("MainlineLevelInfoCtrl", BaseCtrl)
MainlineLevelInfoCtrl._mapNodeConfig = {
  txtLevelRecommend = {sComponentName = "TMP_Text"},
  txtNum = {sComponentName = "TMP_Text"},
  txtName = {sComponentName = "TMP_Text"},
  txtIntroduce = {sComponentName = "TMP_Text"},
  Task = {sComponentName = "Transform", nCount = 3},
  item = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 5
  },
  itemBtn = {
    sNodeName = "item",
    sComponentName = "Button",
    callback = "OnBtnClick_Reward",
    nCount = 5
  },
  btnCloseLevelInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnConfirmInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtCountEnergy = {sComponentName = "TMP_Text"},
  btnCancelInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnEnemy = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_MonsterInfo"
  },
  imgIconInfo = {sComponentName = "Image"},
  btnAllReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AllReward"
  }
}
MainlineLevelInfoCtrl._mapEventConfig = {}

function MainlineLevelInfoCtrl:Awake()
  self.animator = self.gameObject:GetComponent("Animator")
end

function MainlineLevelInfoCtrl:FadeOut(callback)
  if type(callback) == "function" then
    callback()
  end
end

function MainlineLevelInfoCtrl:OnEnable()
end

function MainlineLevelInfoCtrl:OnDisable()
end

function MainlineLevelInfoCtrl:OnDestroy()
end

function MainlineLevelInfoCtrl:OnRelease()
end

function MainlineLevelInfoCtrl:OpenLevelInfo(nMainlineId, nStar, tbTarget)
  self.nMainlineId = nMainlineId
  local mapMainline = ConfigTable.GetData_Mainline(nMainlineId)
  if mapMainline == nil then
    printError("nil mainlineData" .. nMainlineId)
    return
  end
  for index = 1, 3 do
    local rtTask = self._mapNode.Task[index]
    local rtDone = rtTask:Find("imgDone").gameObject
    local rtUnDone = rtTask:Find("imgUnDone").gameObject
    rtDone:SetActive(tbTarget[index])
    rtUnDone:SetActive(not tbTarget[index])
  end
  self.tbReward = decodeJson(mapMainline.RewardPreview)
  for index = 1, 5 do
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
  for index = 1, 5 do
    self._mapNode.itemBtn[index].interactable = self.tbAfterReward[index] ~= nil
    if self.tbAfterReward[index] ~= nil then
      if self.tbReward[index][4] == nil then
      end
      local bReceive = self.tbReward[index][4]
      self._mapNode.item[index]:SetItem(self.tbAfterReward[index][1], nil, nil, nil, bReceive, self.tbAfterReward[index][3] == 1, self.tbAfterReward[index][3] == 2)
    else
      self._mapNode.item[index]:SetItem(nil)
    end
  end
  self.gameObject:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.txtLevelRecommend, mapMainline.Recommend)
  NovaAPI.SetTMPText(self._mapNode.txtNum, mapMainline.Num)
  NovaAPI.SetTMPText(self._mapNode.txtName, mapMainline.Name)
  NovaAPI.SetTMPText(self._mapNode.txtIntroduce, mapMainline.Desc)
  NovaAPI.SetTMPText(self._mapNode.txtCountEnergy, mapMainline.EnergyConsume)
  self.animator:Play("open")
end

function MainlineLevelInfoCtrl:OnBtnClick_Close()
  self.gameObject:SetActive(false)
  EventManager.Hit("SelectMainlineBattle", false)
end

function MainlineLevelInfoCtrl:OnBtnClick_Confirm()
  local mapMainline = ConfigTable.GetData_Mainline(self.nMainlineId)
  if nil ~= mapMainline then
    local nNeedEnergy = mapMainline.EnergyConsume
    local nCurEnergy = PlayerData.Base:GetCurEnergy().nEnergy
    if nNeedEnergy > nCurEnergy then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("MainlineData_Energy"))
      return
    end
    self.gameObject:SetActive(false)
    EventManager.Hit("SelectMainlineBattle", true)
  end
end

function MainlineLevelInfoCtrl:OnBtnClick_MonsterInfo(btn)
  EventManager.Hit("OpenMainlineMonsterInfo", self.nMainlineId)
end

function MainlineLevelInfoCtrl:OnBtnClick_AllReward(btn)
  EventManager.Hit("OpenAllReward", self.tbReward)
end

function MainlineLevelInfoCtrl:OnBtnClick_Reward(btn)
  local nIdx = table.indexof(self._mapNode.itemBtn, btn)
  if self.tbAfterReward[nIdx] ~= nil then
    local nTid = self.tbAfterReward[nIdx][1]
    UTILS.ClickItemGridWithTips(nTid, btn.transform, false, true, false)
  end
end

return MainlineLevelInfoCtrl

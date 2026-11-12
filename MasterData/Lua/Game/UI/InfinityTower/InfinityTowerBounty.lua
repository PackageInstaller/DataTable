local InfinityTowerBounty = class("InfinityTowerBounty", BaseCtrl)
InfinityTowerBounty._mapNodeConfig = {
  goBounty = {
    sNodeName = "t_window_04"
  },
  txt_BV_Title = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Bounty_Level"
  },
  btnLevel = {
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  btnPreview = {
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  btnLevelTog = {
    sNodeName = "btnLevel",
    sComponentName = "UIButton",
    callback = "OnBtnClick_LevelTog"
  },
  btnPreviewTog = {
    sNodeName = "btnPreview",
    sComponentName = "UIButton",
    callback = "OnBtnClick_PreviewTog"
  },
  bv_obj_Bounty = {},
  bv_tex_currentLv = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Current_Level"
  },
  bv_tex_BountyLv = {sComponentName = "TMP_Text"},
  bv_tex_promotion = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Promotion_Conditions"
  },
  pr_CondList = {sNodeName = "pr_Cond", nCount = 3},
  bv_PromotionRewardTop = {},
  tex_PromotionRewardTop = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Bounty_TopGrade"
  },
  bv_tex_daily = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Daily_Bounty"
  },
  bv_objRewardItem = {},
  bv_rewardItemRoot = {sComponentName = "Transform"},
  bv_tex_RewardNone = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Get_RewardNone"
  },
  btnGetDaily = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GetDaily"
  },
  bv_txt_GetReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Get_Reward"
  },
  btnGetDailyGray = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GetDaily"
  },
  bv_txt_GetRewardGray = {
    sComponentName = "TMP_Text",
    sLanguageId = "LoginReward_Received"
  },
  bv_obj_Preview = {},
  bv_tex_PreviewLv = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Bounty_Level"
  },
  bv_tex_PreviewDaily = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Daily_Bounty"
  },
  bv_tex_PreviewConditions = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Promotion_Conditions"
  },
  previewList = {
    sComponentName = "LoopScrollView"
  },
  btnCloseBV = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  MaskClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  }
}
InfinityTowerBounty._mapEventConfig = {
  InfinityTower_DailyCallback = "OnEvent_InfinityTowerDailyCallback"
}

function InfinityTowerBounty:Awake()
  self.goAni = self.gameObject:GetComponent("Animator")
  self.rewardItem = {}
  self.previewRewardItem = {}
  self.isOpen = false
end

function InfinityTowerBounty:OnEnable()
  self:SetPageBtnText()
end

function InfinityTowerBounty:SetPageBtnText()
  self._mapNode.btnLevel:SetText(ConfigTable.GetUIText("InfinityTower_Bounty_Level"))
  self._mapNode.btnPreview:SetText(ConfigTable.GetUIText("InfinityTower_Bounty_Preview"))
end

function InfinityTowerBounty:InitView()
  self.isOpen = true
  self._mapNode.goBounty.gameObject:SetActive(false)
  self.gameObject:SetActive(true)
  self.bountycount = 0
  self.tabBountyData = {}
  
  local function foreach_Base(baseData)
    self.bountycount = self.bountycount + 1
    self.tabBountyData[baseData.Level] = baseData
  end
  
  ForEachTableLine(DataTable.InfinityTowerBountyLevel, foreach_Base)
  self:InitBountyMsg()
  self:InitPreviewMsg()
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goBounty.gameObject:SetActive(true)
    self:OnBtnClick_LevelTog()
  end
  
  cs_coroutine.start(wait)
end

function InfinityTowerBounty:OnEvent_InfinityTowerDailyCallback()
  if self.isOpen then
    self:InitBountyMsg()
  end
end

function InfinityTowerBounty:InitBountyMsg()
  local currentLv = PlayerData.InfinityTower.BountyLevel
  NovaAPI.SetTMPText(self._mapNode.bv_tex_BountyLv, tostring(currentLv))
  local nextData = self.tabBountyData[currentLv + 1]
  for i = 1, 3 do
    self:InitConditionsList(self._mapNode.pr_CondList[i], i, nextData)
  end
  self._mapNode.bv_PromotionRewardTop:SetActive(nextData == nil)
  local curData = self.tabBountyData[currentLv]
  local tbItem = {}
  local _base = decodeJson(curData.RewardShow)
  for k, v in ipairs(_base) do
    table.insert(tbItem, {
      id = v[1],
      count = v[2]
    })
  end
  local isGet = not PlayerData.InfinityTower.isHaveDailyReward
  self:SetRewardItem(tbItem, isGet)
  self._mapNode.bv_tex_RewardNone.gameObject:SetActive(#tbItem == 0)
  if #tbItem == 0 then
    self._mapNode.btnGetDaily.gameObject:SetActive(false)
    self._mapNode.btnGetDailyGray.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.bv_txt_GetRewardGray, ConfigTable.GetUIText("InfinityTower_Get_Reward"))
  else
    self._mapNode.btnGetDaily.gameObject:SetActive(PlayerData.InfinityTower.isHaveDailyReward)
    self._mapNode.btnGetDailyGray.gameObject:SetActive(not PlayerData.InfinityTower.isHaveDailyReward)
    NovaAPI.SetTMPText(self._mapNode.bv_txt_GetRewardGray, ConfigTable.GetUIText("LoginReward_Received"))
  end
end

function InfinityTowerBounty:InitConditionsList(goGrid, index, data)
  if data == nil then
    goGrid:SetActive(false)
    return
  end
  local _cond = data["Cond" .. index]
  if _cond ~= 0 then
    local bv_obj_Conditions_1 = goGrid.transform:Find("bv_obj_Conditions_1").gameObject
    local bv_obj_Conditions_2 = goGrid.transform:Find("bv_obj_Conditions_2").gameObject
    local bv_tex_Conditions = goGrid.gameObject:GetComponent("TMP_Text")
    NovaAPI.SetTMPText(bv_tex_Conditions, data["CondDesc" .. index])
    local isPass = PlayerData.InfinityTower:JudgeInfinityTowerCond(_cond, data["CondParam" .. index])
    bv_obj_Conditions_1:SetActive(isPass)
    bv_obj_Conditions_2:SetActive(not isPass)
    goGrid:SetActive(true)
  else
    goGrid:SetActive(false)
  end
end

function InfinityTowerBounty:SetRewardItem(tabItem, isGet)
  local childCount = self._mapNode.bv_rewardItemRoot.childCount
  for i = 1, childCount do
    self._mapNode.bv_rewardItemRoot:GetChild(i - 1).gameObject:SetActive(false)
  end
  local index = 1
  for i, v in pairs(tabItem) do
    local objItem
    if index > self._mapNode.bv_rewardItemRoot.childCount then
      objItem = instantiate(self._mapNode.bv_objRewardItem, self._mapNode.bv_rewardItemRoot)
    else
      objItem = self._mapNode.bv_rewardItemRoot:GetChild(index - 1).gameObject
    end
    local btn = objItem:GetComponent("UIButton")
    btn.onClick:RemoveAllListeners()
    
    local function clickCb()
      self:ShowItemTips(v.id, btn.gameObject)
    end
    
    btn.onClick:AddListener(clickCb)
    objItem:SetActive(true)
    self.rewardItem[objItem] = self:BindCtrlByNode(objItem, "Game.UI.TemplateEx.TemplateItemCtrl")
    self.rewardItem[objItem]:SetItem(v.id, nil, v.count, nil, isGet, nil, nil, true)
    index = index + 1
  end
end

function InfinityTowerBounty:InitPreviewMsg()
  self._mapNode.previewList:Init(self.bountycount, self, self.InitPreviewList)
end

function InfinityTowerBounty:InitPreviewList(goGrid, gridIndex)
  local index = gridIndex + 1
  local tex_PreviewCond_Lv = goGrid.transform:Find("gridRt/tex_PreviewCond_Lv"):GetComponent("TMP_Text")
  local obj_PCond_RewardItem = goGrid.transform:Find("gridRt/obj_PCond_RewardItem").gameObject
  local obj_PCond_RewardRoot = goGrid.transform:Find("gridRt/obj_PCond_Reward/Viewport/obj_PCond_RewardRoot").transform
  local obj_PCond_CondItem = goGrid.transform:Find("gridRt/obj_PCond_CondItem").gameObject
  local obj_PCond_CondRoot = goGrid.transform:Find("gridRt/obj_PCond_CondRoot").transform
  local obj_PCond_CurrentLv = goGrid.transform:Find("gridRt/obj_PCond_CurrentLv").gameObject
  local tex_PCond_CurrentLv = goGrid.transform:Find("gridRt/obj_PCond_CurrentLv/tex_PCond_CurrentLv"):GetComponent("TMP_Text")
  local tex_PCond_RewardNone = goGrid.transform:Find("gridRt/tex_PCond_RewardNone"):GetComponent("TMP_Text")
  local obj_PCond_CondTop = goGrid.transform:Find("gridRt/obj_PCond_CondTop").gameObject
  local tex_PCond_CondTop = goGrid.transform:Find("gridRt/obj_PCond_CondTop/tex_PCond_CondTop"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(tex_PCond_RewardNone, ConfigTable.GetUIText("InfinityTower_Get_RewardNone"))
  NovaAPI.SetTMPText(tex_PCond_CondTop, ConfigTable.GetUIText("InfinityTower_Bounty_TopGrade"))
  NovaAPI.SetTMPText(tex_PCond_CurrentLv, ConfigTable.GetUIText("InfinityTower_Current_Level"))
  local childItemCount = obj_PCond_RewardRoot.childCount
  for i = 1, childItemCount do
    obj_PCond_RewardRoot:GetChild(i - 1).gameObject:SetActive(false)
  end
  local childCondCount = obj_PCond_CondRoot.childCount
  for i = 1, childCondCount do
    obj_PCond_CondRoot:GetChild(i - 1).gameObject:SetActive(false)
  end
  if self.previewRewardItem[index] ~= nil then
    for go, ctrl in ipairs(self.previewRewardItem[index]) do
      self:UnbindCtrlByNode(ctrl)
    end
  end
  self.previewRewardItem[index] = {}
  NovaAPI.SetTMPText(tex_PreviewCond_Lv, index)
  obj_PCond_CurrentLv:SetActive(PlayerData.InfinityTower.BountyLevel == index)
  local bountyData = self.tabBountyData[index]
  local tabItem = {}
  local _base = decodeJson(bountyData.RewardShow)
  for k, v in ipairs(_base) do
    table.insert(tabItem, {
      id = v[1],
      count = v[2]
    })
  end
  local indexCount = 1
  for i, v in pairs(tabItem) do
    local objItem
    if indexCount > obj_PCond_RewardRoot.childCount then
      objItem = instantiate(obj_PCond_RewardItem, obj_PCond_RewardRoot)
    else
      objItem = obj_PCond_RewardRoot:GetChild(indexCount - 1).gameObject
    end
    local btn = objItem:GetComponent("UIButton")
    btn.onClick:RemoveAllListeners()
    
    local function clickCb()
      self:ShowItemTips(v.id, btn.gameObject)
    end
    
    btn.onClick:AddListener(clickCb)
    objItem:SetActive(true)
    local _objR = objItem.transform:Find("AniRoot/_PCond_RewardItem").gameObject
    self.previewRewardItem[index][_objR] = self:BindCtrlByNode(_objR, "Game.UI.TemplateEx.TemplateItemCtrl")
    self.previewRewardItem[index][_objR]:SetItem(v.id, nil, v.count, nil, false, nil, nil, true)
    indexCount = indexCount + 1
  end
  tex_PCond_RewardNone.gameObject:SetActive(#tabItem == 0)
  local bountyDataNext = self.tabBountyData[index + 1]
  if bountyDataNext ~= nil then
    obj_PCond_CondTop:SetActive(false)
    for i = 1, 3 do
      local objItem
      if i > obj_PCond_CondRoot.childCount then
        objItem = instantiate(obj_PCond_CondItem, obj_PCond_CondRoot)
      else
        objItem = obj_PCond_CondRoot:GetChild(i - 1).gameObject
      end
      local _cond = bountyDataNext["Cond" .. i]
      if _cond ~= 0 then
        local tex = objItem.transform:Find("tex_PCond_CondItem"):GetComponent("TMP_Text")
        NovaAPI.SetTMPText(tex, bountyDataNext["CondDesc" .. i])
        objItem:SetActive(true)
      else
        objItem:SetActive(false)
      end
    end
  else
    obj_PCond_CondTop:SetActive(true)
  end
end

function InfinityTowerBounty:ShowItemTips(nTid, rtBtn)
  UTILS.ClickItemGridWithTips(nTid, rtBtn, false, true, false)
end

function InfinityTowerBounty:OnBtnClick_LevelTog()
  self._mapNode.bv_obj_Bounty:SetActive(true)
  self._mapNode.bv_obj_Preview:SetActive(false)
  self.nSelectType = 1
  self:SetTogSelect()
  self.goAni:Play("goBountyView_Bounty")
end

function InfinityTowerBounty:OnBtnClick_PreviewTog()
  self._mapNode.bv_obj_Bounty:SetActive(false)
  self._mapNode.bv_obj_Preview:SetActive(true)
  local currentLv = PlayerData.InfinityTower.BountyLevel
  self._mapNode.previewList:SetScrollGridPos(currentLv, 0.1, 0)
  self.nSelectType = 2
  self:SetTogSelect()
  self.goAni:Play("goBountyView_Preview")
end

function InfinityTowerBounty:SetTogSelect()
  self._mapNode.btnLevel:SetDefault(self.nSelectType == 1)
  self._mapNode.btnPreview:SetDefault(self.nSelectType == 2)
end

function InfinityTowerBounty:OnBtnClick_GetDaily()
  if not PlayerData.InfinityTower.isHaveDailyReward then
    local currentLv = PlayerData.InfinityTower.BountyLevel
    local curData = self.tabBountyData[currentLv]
    local tbItem = {}
    local _base = decodeJson(curData.RewardShow)
    for k, v in ipairs(_base) do
      table.insert(tbItem, {
        id = v[1],
        count = v[2]
      })
    end
    if 0 < #tbItem then
      local strTips = ConfigTable.GetUIText("InfinityTower_Get_RewardTips")
      EventManager.Hit(EventId.OpenMessageBox, strTips)
    else
      local strTips = ConfigTable.GetUIText("InfinityTower_Get_RewardNone")
      EventManager.Hit(EventId.OpenMessageBox, strTips)
    end
    return
  end
  PlayerData.InfinityTower:ITDailyRewardReq()
end

function InfinityTowerBounty:OnBtnClick_Close()
  self.isOpen = false
  self._mapNode.goBounty.gameObject:SetActive(false)
  self.gameObject:SetActive(false)
end

function InfinityTowerBounty:UnbindAllGrids()
  for go, ctrl in ipairs(self.rewardItem) do
    self:UnbindCtrlByNode(ctrl)
  end
  self.rewardItem = {}
end

function InfinityTowerBounty:OnDisable()
  self:UnbindAllGrids()
end

return InfinityTowerBounty

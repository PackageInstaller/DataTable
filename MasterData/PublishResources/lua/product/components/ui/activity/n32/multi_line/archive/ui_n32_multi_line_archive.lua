_class("UIN32MultiLineArchive", UIController)
UIN32MultiLineArchive = UIN32MultiLineArchive

function UIN32MultiLineArchive:Constructor()
end

function UIN32MultiLineArchive:LoadDataOnEnter(TT, res)
  self._campaignModule = self:GetModule(CampaignModule)
  local comType = ECampaignType.CAMPAIGN_TYPE_N32
  local comId = ECampaignN32ComponentID.ECAMPAIGN_N32_MULTILINE_MISSION
  self._multiLineData = UIMultiLineData:New()
  if not self._multiLineData:LoadData(TT, res, comType, comId) then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaignModule._id, nil, nil)
    return
  end
  res:SetSucc(true)
  self._componentId = self._multiLineData:GetComponentID()
end

function UIN32MultiLineArchive:OnShow(uiParams)
  self._animInfo = {
    ["in"] = {
      "uieff_UIN32MultiLineArchive_in",
      433
    },
    out = {
      "uieff_UIN32MultiLineArchive_out",
      200
    },
    switchin = {
      "uieff_UIN32MultiLineArchive_switch_in",
      433
    },
    switchout = {
      "uieff_UIN32MultiLineArchive_switch_out",
      167
    }
  }
  self:SetController(uiParams[1])
  self:InitComponent()
  self:InitUI()
  self:PlayAnim("in")
end

function UIN32MultiLineArchive:InitComponent()
  self._btnstab = self:GetUIComponent("UISelectObjectPath", "btns")
  self._awards = self:GetUIComponent("UISelectObjectPath", "awards")
  self._itemtab = self:GetUIComponent("UISelectObjectPath", "tabs")
  self._titleText = self:GetUIComponent("UILocalizationText", "titleText")
  self._contentText = self:GetUIComponent("UILocalizationText", "contentText")
  self._rewardText = self:GetUIComponent("UILocalizationText", "rewardText")
  self._contentRect = self:GetUIComponent("RectTransform", "contentText")
  self._headImg = self:GetUIComponent("RawImageLoader", "contentImg")
  self._headRawImg = self:GetUIComponent("RawImage", "contentImg")
  self._archiveContentGo = self:GetGameObject("archiveContent")
  self._archiveTitleText = self:GetUIComponent("UILocalizationText", "archiveTitle")
  self._archiveTextText = self:GetUIComponent("UILocalizationText", "archiveText")
  self._itemContent = self:GetGameObject("itemContent")
  self._itemInfo = self:GetUIComponent("UISelectObjectPath", "itemInfo")
  self._safeArea = self:GetGameObject("SafeArea")
  self._rightcontent = self:GetUIComponent("RectTransform", "rightcontent")
  self._tabRect = self:GetUIComponent("RectTransform", "tabs")
  self._liftScRect = self:GetUIComponent("RectTransform", "liftSc")
  self._liftcontent = self:GetUIComponent("RectTransform", "contentText")
  self._anim = self:GetUIComponent("Animation", "SafeArea")
end

function UIN32MultiLineArchive:CheckBtnRedPoint(petInfo)
  if not petInfo then
    return false
  end
  for index, value in ipairs(petInfo.FilesID) do
    local readed = self._multiLineData:GetPetFileReaded(value)
    if not readed then
      return self._multiLineData:CheckPetFileReceived(value)
    end
  end
  return false
end

function UIN32MultiLineArchive:InitUI()
  self._petInfos = self._multiLineData:MultiLinePetCfg(self._componentId)
  self._petIndex = 1
  local guideModuel = self:GetModule(GuideModule)
  if guideModuel:IsGuideProcess(122004) then
    self._petIndex = self:GetHasUnlockDocIndex()
  end
  self._petInfo = self._petInfos[self._petIndex]
  self._fileSelectIndex = 1
  self._fileId = self._petInfo.FilesID[1]
  self._spreadContent = false
  self._btnstab:SpawnObjects("UIN32MultiLineArchiveBtn", #self._petInfos)
  self._btnItems = self._btnstab:GetAllSpawnList()
  for i, v in ipairs(self._btnItems) do
    v:SetData(i, self._petIndex, self._petInfos[i], self:CheckBtnRedPoint(self._petInfos[i]), function(index)
      self:BtnClickCallBack(index)
    end)
  end
  self:GetReward()
  self:RefreshUI()
end

function UIN32MultiLineArchive:GetHasUnlockDocIndex()
  local index = 1
  for i, v in ipairs(self._petInfos) do
    local files = v.FilesID
    for k, fileId in pairs(files) do
      if self._multiLineData:CheckPetFileReceived(fileId) then
        return i
      end
    end
  end
  return index
end

function UIN32MultiLineArchive:RefreshUI()
  self._petInfo = self._petInfos[self._petIndex]
  local temp = self._petInfo.Rewards
  local items = self._awards:GetAllSpawnList()
  self._awards:SpawnObjects("UIN32MultiLineArchiveRewardItem", #temp)
  for i, v in ipairs(items) do
    v:SetData(i, temp[i], self._multiLineData:CheckPetRewardReceived(self._petInfo.PetID), function(itemId, pos)
      self:RewardItemClickCallBack(itemId, pos)
    end)
  end
  temp = self._petInfo.FilesID
  self._itemtab:SpawnObjects("UIN32MultiLineArchiveItem", #temp)
  temp = self:SortFileItems(temp)
  items = self._itemtab:GetAllSpawnList()
  for i, v in ipairs(items) do
    v:SetData(i, temp[i], self._multiLineData:MultiLinePetFilesCfg(self._componentId, temp[i]), self._multiLineData:CheckPetFileReceived(temp[i]), self._multiLineData:CheckMultilineMissionPassed(self._componentId, temp[i]), function(index, file, sp)
      self:ItemClickCallBack(index, file, sp)
    end)
    if self._multiLineData:CheckPetFileReceived(temp[i]) and not self._multiLineData:GetPetFileReaded(temp[i]) then
      self._multiLineData:SetPetFileReaded(temp[i])
    end
  end
  for i, v in ipairs(self._btnItems) do
    v:RefreshRed(self:CheckBtnRedPoint(self._petInfos[i]))
  end
  if self._controller then
    self._controller:RefreshDocRed()
  end
  self._titleText:SetText(StringTable.Get(self._petInfo.PetName))
  self._contentText:SetText(StringTable.Get(self._petInfo.PetInfo))
  self._contentRect.parent.anchoredPosition = Vector2(0, 0)
  self._headImg:LoadImage(self._petInfo.HeadImg)
  self._headRawImg.color = Color(1.0, 1.0, 1.0, 0.23529411764705882)
  local count = self:GetReceivedCount(self._petInfo) .. "/" .. #self._petInfo.FilesID
  self._rewardText:SetText(StringTable.Get("str_n32_multiline_petfile_reward_title") .. count)
  self._itemContent:SetActive(self._spreadContent)
  self._tabRect.anchoredPosition = Vector2(0, 0)
  self:StartTask(function(TT)
    self:SetRect(TT)
  end)
end

function UIN32MultiLineArchive:SetRect(TT)
  YIELD(TT, 200)
  self._rightcontent = self:GetUIComponent("RectTransform", "rightcontent")
  self._tabRect = self:GetUIComponent("RectTransform", "tabs")
  local height = self._tabRect.sizeDelta.y <= 465.5 and self._tabRect.sizeDelta.y - 0.5 or 465.5
  self._rightcontent.sizeDelta = Vector2(977.6, height)
  self._liftScRect = self:GetUIComponent("RectTransform", "liftSc")
  height = self._liftcontent.sizeDelta.y + 5 <= 225 and self._liftcontent.sizeDelta.y + 5 - 0.5 or 225
  self._liftScRect.sizeDelta = Vector2(488.542, height)
end

function UIN32MultiLineArchive:SortFileItems(tempTable)
  local temp1, temp2, temp3 = {}, {}, {}
  for index, value in ipairs(tempTable) do
    if self._multiLineData:CheckPetFileReceived(value) then
      if self._multiLineData:GetPetFileReaded(value) then
        table.insert(temp2, value)
      else
        table.insert(temp1, value)
      end
    else
      table.insert(temp3, value)
    end
  end
  for index, value in ipairs(temp2) do
    temp1[#temp1 + 1] = value
  end
  for index, value in ipairs(temp3) do
    temp1[#temp1 + 1] = value
  end
  return temp1
end

function UIN32MultiLineArchive:RefreshArchiveContent()
  local cfg = self._multiLineData:MultiLinePetFilesCfg(self._componentId, self._fileId)
  self._itemContent:SetActive(false)
  self._itemContent.transform:SetSiblingIndex(self._fileSelectIndex)
  if cfg then
    self._archiveTextText:SetText(StringTable.Get(cfg[1].DocDesc))
  end
end

function UIN32MultiLineArchive:BtnClickCallBack(index)
  self._spreadContent = false
  local lastIndex = self._petIndex
  if index ~= self._petIndex then
    self._petIndex = index
  end
  self._petInfo = self._petInfos[self._petIndex]
  self:PlayAnim("switchout", function()
    for i, v in ipairs(self._btnItems) do
      v:Refresh(self._petIndex, lastIndex)
    end
    self:GetReward()
    self:RefreshUI()
    self:PlayAnim("switchin")
  end)
end

function UIN32MultiLineArchive:GetReward()
  if self:CheckPetAllReceived(self._petInfo) and not self._multiLineData:CheckPetRewardReceived(self._petInfo.PetID) then
    self:StartTask(function(TT)
      local asyncRes = AsyncRequestRes:New()
      local rewards
      asyncRes, rewards = self._multiLineData:GetComponent():HandleMultiLineMissionGetReward(TT, asyncRes, self._petInfo.PetID)
      if asyncRes:GetSucc() and rewards then
        self:CheckAndShowItemReward(rewards, function()
          self:RefreshUI()
        end)
      end
    end)
  end
end

function UIN32MultiLineArchive:CheckPetAllReceived(petInfo)
  for key, value in pairs(petInfo.FilesID) do
    if not self._multiLineData:CheckPetFileReceived(value) then
      return false
    end
  end
  return true
end

function UIN32MultiLineArchive:GetReceivedCount(petInfo)
  local count = 0
  for key, value in pairs(petInfo.FilesID) do
    if self._multiLineData:CheckPetFileReceived(value) then
      count = count + 1
    end
  end
  return count
end

function UIN32MultiLineArchive:CheckAndShowItemReward(itemReward, finshCallback)
  if table.count(itemReward) ~= 0 then
    self:ShowDialog("UIGetItemController", itemReward, function()
      if finshCallback then
        finshCallback()
      end
    end)
  elseif finshCallback then
    finshCallback()
  end
end

function UIN32MultiLineArchive:RewardItemClickCallBack(itemId, go)
  local deltaPosition = go.transform.position - self._safeArea.transform.position
  self:ShowDialog("UICommonItemInfo", itemId, deltaPosition, "UIN32MultiLineSelectInfo.prefab")
end

function UIN32MultiLineArchive:ItemClickCallBack(index, fileId, spreadContent)
  self._fileId = fileId
  self._fileSelectIndex = index
  self._spreadContent = false
  local items = self._itemtab:GetAllSpawnList()
  for i, v in ipairs(items) do
    v:Refresh(i, self._multiLineData:CheckPetFileReceived(self._petInfo.FilesID[i]), self._multiLineData:CheckMultilineMissionPassed(self._componentId, self._petInfo.FilesID[i]), self._fileSelectIndex)
  end
end

function UIN32MultiLineArchive:BtnCloseOnClick()
  self:PlayAnim("out", function()
    self:CloseDialog()
  end)
end

function UIN32MultiLineArchive:SetController(controller)
  self._controller = controller
end

function UIN32MultiLineArchive:PlayAnim(name, callBack)
  local animinfo = self._animInfo[name]
  self:StartTask(function(TT)
    local lockName = "UIN32MultiLineArchive:" .. name
    self:Lock(lockName)
    self._anim:Play(animinfo[1])
    YIELD(TT, animinfo[2])
    self:UnLock(lockName)
    if callBack then
      callBack()
    end
  end)
end

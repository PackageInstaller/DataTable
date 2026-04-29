_class("UIN32MultiLineDialogueDetails", UIController)
UIN32MultiLineDialogueDetails = UIN32MultiLineDialogueDetails

function UIN32MultiLineDialogueDetails:Constructor()
  self._missionId = 0
end

function UIN32MultiLineDialogueDetails:LoadDataOnEnter(TT, res, uiParams)
  self._missionId = uiParams[1]
  self._isPassMission = uiParams[2]
  self._endCB = uiParams[3]
end

function UIN32MultiLineDialogueDetails:OnShow(uiParams)
  self._txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self._txtDetailsValue = self:GetUIComponent("UILocalizationText", "txtDetailsValue")
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._imgDrawingLoader = self:GetUIComponent("RawImageLoader", "imgDrawing")
  self._imgHeadLoader = self:GetUIComponent("RawImageLoader", "imgHead")
  self._safeArea = self:GetUIComponent("RectTransform", "safeArea")
  self._animation = self:GetUIComponent("Animation", "animation")
  self:Flush()
  self:FlushRewards()
  self:InAnimation()
end

function UIN32MultiLineDialogueDetails:OnHide()
end

function UIN32MultiLineDialogueDetails:BtnAnywhereOnClick(go)
  self:OutAnimation()
end

function UIN32MultiLineDialogueDetails:BtnCloseOnClick(go)
  self:OutAnimation()
end

function UIN32MultiLineDialogueDetails:BtnEnterOnClick(go)
  self:ShowDialog("UIN32MultiLineDialogue", self._missionId, self._endCB)
  local lockName = "UIN32MultiLineDialogueDetails:CloseDialog"
  self:StartTask(function(TT)
    self:Lock(lockName)
    YIELD(TT, 333)
    self:CloseDialog()
    self:UnLock(lockName)
  end)
end

function UIN32MultiLineDialogueDetails:Flush()
  local cfgMission = Cfg.cfg_campaign_mission[self._missionId]
  local cfgChat = Cfg.cfg_mission_multiline_chat[self._missionId]
  self._txtTitle:SetText(StringTable.Get(cfgMission.Name))
  self._txtDetailsValue:SetText(StringTable.Get(cfgMission.Desc))
  self._imgDrawingLoader:LoadImage(cfgChat.DetailsDrawing)
  self._imgHeadLoader:LoadImage(cfgChat.DetailsHead)
end

function UIN32MultiLineDialogueDetails:FlushRewards()
  local cfgMission = Cfg.cfg_campaign_mission[self._missionId]
  local dropId = cfgMission.FirstDropId
  local dropRewards = Cfg.cfg_drop({DropID = dropId})
  if dropRewards == nil then
    return
  end
  self._dataRewards = {}
  for k, v in pairs(dropRewards) do
    local asset = RoleAsset:New()
    asset.dropId = v.ID
    asset.assetid = v.AssetID
    asset.count = v.MinCount
    table.insert(self._dataRewards, asset)
  end
  table.sort(self._dataRewards, function(a, b)
    return a.dropId < b.dropId
  end)
  local count = #self._dataRewards
  self._widgetRewards = self._content:SpawnObjects("UIN32MultiLineDialogueDetailsReward", count)
  for k, v in pairs(self._dataRewards) do
    local ui = self._widgetRewards[k]
    ui:SetData(v, self._isPassMission)
  end
end

function UIN32MultiLineDialogueDetails:OnShowItemInfo(reward, go)
  local deltaPosition = go.transform.position - self._safeArea.transform.position
  self:ShowDialog("UICommonItemInfo", reward, deltaPosition, "UIN32MultiLineSelectInfo.prefab")
end

function UIN32MultiLineDialogueDetails:InAnimation()
  local lockName = "UIN32MultiLineDialogueDetails:InAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("uieff_UIN32MultiLineDialogueDetails_in")
    YIELD(TT, 400)
    self:UnLock(lockName)
  end)
end

function UIN32MultiLineDialogueDetails:OutAnimation(cbFinish)
  local lockName = "UIN32MultiLineDialogueDetails:OutAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("uieff_UIN32MultiLineDialogueDetails_out")
    YIELD(TT, 200)
    self:CloseDialog()
    self:UnLock(lockName)
    if cbFinish then
      cbFinish()
    end
  end)
end

_class("UIN32MultiLineDialogueDetailsReward", UICustomWidget)
UIN32MultiLineDialogueDetailsReward = UIN32MultiLineDialogueDetailsReward

function UIN32MultiLineDialogueDetailsReward:Constructor()
end

function UIN32MultiLineDialogueDetailsReward:OnShow(uiParams)
  self._iconLoader = self:GetUIComponent("RawImageLoader", "imgIcon")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self._uiObtained = self:GetUIComponent("RectTransform", "uiObtained")
end

function UIN32MultiLineDialogueDetailsReward:OnHide()
end

function UIN32MultiLineDialogueDetailsReward:ButtonOnClick(go)
  self:RootUIOwner():OnShowItemInfo(self._roleAsset, go)
end

function UIN32MultiLineDialogueDetailsReward:SetData(roleAsset, isObtained)
  self._roleAsset = roleAsset
  self._isObtained = isObtained
  local cfgItem = Cfg.cfg_item[self._roleAsset.assetid]
  if cfgItem ~= nil then
    self._iconLoader:LoadImage(cfgItem.Icon)
  end
  self._txtName.gameObject:SetActive(false)
  self._txtCount:SetText(string.format("x%d", self._roleAsset.count))
  self._uiObtained.gameObject:SetActive(isObtained)
end

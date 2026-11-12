local MiningGridListCtrl = class("MiningGridListCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local miningCellType = GameEnum.miningCellType
local ColumnCount = {
  2,
  3,
  4,
  3,
  4,
  3,
  2
}
MiningGridListCtrl._mapNodeConfig = {
  cell = {
    nCount = 21,
    sCtrlName = "Game.UI.Activity.Mining.MiningGridCellCtrl"
  },
  reward_Go = {nCount = 3},
  reward = {nCount = 3, sComponentName = "Image"}
}

function MiningGridListCtrl:Init()
  self.nActId = 0
  self:HideReward()
end

function MiningGridListCtrl:OnDestroy(...)
end

function MiningGridListCtrl:SetData(actId)
  self.nActId = actId
end

function MiningGridListCtrl:InitGridCell(data, callback)
  self.destroyCallback = callback
  
  local function funcCallback(nId)
    self:Knock(nId)
  end
  
  self._mapNode.cell[data.nIndex]:SetData(data.nId, data.nStatus, data.bMark, funcCallback, data.nIndex)
end

function MiningGridListCtrl:HideReward()
  for _, go in pairs(self._mapNode.reward_Go) do
    go:SetActive(false)
  end
end

function MiningGridListCtrl:FindReward(rewardIndex, scoreTra)
  WwiseAudioMgr:PostEvent("mode_digging1_get")
  EventManager.Hit(EventId.BlockInput, true)
  local go = self._mapNode.reward_Go[rewardIndex]
  local Trail = self._mapNode.reward[rewardIndex].transform:Find("Trail")
  Trail.gameObject:SetActive(true)
  
  local function animaFunc()
    go.transform:SetAsLastSibling()
    local beginPos = go.transform.position
    local controlPos = Vector3(1, -2, 0)
    local endPos = scoreTra.position
    
    local function wait()
      local totalMoveTime = 0.3
      local moveTime = 0
      local normalizedTime = 0
      while normalizedTime < 1 do
        moveTime = moveTime + CS.UnityEngine.Time.unscaledDeltaTime
        normalizedTime = moveTime / totalMoveTime
        normalizedTime = normalizedTime <= 1 and normalizedTime or 1
        local x, y, z = UTILS.GetBezierPointByT(beginPos, controlPos, endPos, normalizedTime)
        local angleZ = 100 * normalizedTime * 2
        angleZ = angleZ <= 100 and angleZ or 100
        go.transform.localEulerAngles = Vector3(0, 0, angleZ)
        go.transform.position = Vector3(x, y, z)
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      end
      go:SetActive(false)
      go.transform:SetSiblingIndex(1)
      Trail.gameObject:SetActive(false)
      EventManager.Hit("MiningGameRewardFxOver")
      EventManager.Hit(EventId.BlockInput, false)
    end
    
    cs_coroutine.start(wait)
  end
  
  local img_reward = self._mapNode.reward[rewardIndex]
  local animator = img_reward:GetComponent("Animator")
  animator:Play("reward_in")
  self:AddTimer(1, 0.5, animaFunc)
end

function MiningGridListCtrl:ChangeGridState(data, nEffectType)
  self._mapNode.cell[data.nIndex]:UpdateData(data.nStatus, nEffectType, true)
end

function MiningGridListCtrl:Knock(nId)
  self.destroyCallback(nId)
end

function MiningGridListCtrl:InitRewardList(tbRewardList)
  for i = 1, math.min(3, #tbRewardList) do
    local rewardConfig = ConfigTable.GetData("MiningTreasure", tbRewardList[i].nId)
    if rewardConfig ~= nil then
      local rewardImage = self._mapNode.reward[i]
      local Trail = rewardImage.transform:Find("Trail")
      Trail.gameObject:SetActive(false)
      local go = self._mapNode.reward_Go[i]
      if rewardConfig.Icon ~= "" then
        self:SetPngSprite(rewardImage, rewardConfig.Icon)
        rewardImage:SetNativeSize()
      end
      local rewardPosList = tbRewardList[i].tbPosIndex
      if rewardConfig.MiningItemType == GameEnum.miningRewardType.RewardTypeA then
        go.transform.anchoredPosition = self._mapNode.cell[rewardPosList[1]].gameObject.transform.parent.anchoredPosition
      elseif rewardConfig.MiningItemType == GameEnum.miningRewardType.RewardTypeB then
        local pos1 = self._mapNode.cell[rewardPosList[1]].gameObject.transform.parent.anchoredPosition
        local pos2 = self._mapNode.cell[rewardPosList[2]].gameObject.transform.parent.anchoredPosition
        go.transform.anchoredPosition = (pos1 + pos2) / 2
      elseif rewardConfig.MiningItemType == GameEnum.miningRewardType.RewardTypeC then
        go.transform.anchoredPosition = self._mapNode.cell[rewardPosList[2]].gameObject.transform.parent.anchoredPosition
      elseif rewardConfig.MiningItemType == GameEnum.miningRewardType.RewardTypeD then
        local pos1 = self._mapNode.cell[rewardPosList[1]].gameObject.transform.parent.anchoredPosition
        local pos2 = self._mapNode.cell[rewardPosList[2]].gameObject.transform.parent.anchoredPosition
        local pos3 = self._mapNode.cell[rewardPosList[3]].gameObject.transform.parent.anchoredPosition
        go.transform.anchoredPosition = (pos1 + pos2 + pos3) / 3
      end
      go.transform.localRotation = Quaternion.Euler(0, 0, 0)
      if rewardConfig.MiningItemType == GameEnum.miningRewardType.RewardTypeB or rewardConfig.MiningItemType == GameEnum.miningRewardType.RewardTypeC then
        local rotate = self:GetRotation(rewardPosList)
        go.transform.localRotation = Quaternion.Euler(0, 0, rotate)
      elseif rewardConfig.MiningItemType == GameEnum.miningRewardType.RewardTypeD then
        local rotate = self:GetRotationByTypeD(rewardPosList)
        go.transform.localRotation = Quaternion.Euler(0, 0, rotate)
      end
      if not tbRewardList[i].bIsGet then
        go:SetActive(true)
      end
    end
  end
end

function MiningGridListCtrl:GetRotation(posList)
  table.sort(posList, function(a, b)
    return a < b
  end)
  local nDir = self:GetDir(posList[2], posList[1])
  return (nDir - 1) * 60
end

function MiningGridListCtrl:GetRotationByTypeD(posList)
  local n2GridColumn = 0
  local n1GridColumn = 0
  local tbColList = {}
  for _, pos in ipairs(posList) do
    local nC, nR = self:GetGridIndex(pos)
    if tbColList[nC] == nil then
      tbColList[nC] = 1
    else
      tbColList[nC] = tbColList[nC] + 1
    end
  end
  for key, value in pairs(tbColList) do
    if value == 2 then
      n2GridColumn = key
    else
      n1GridColumn = key
    end
  end
  local nRotate = 0
  if n2GridColumn > n1GridColumn then
    nRotate = -90
  elseif n2GridColumn < n1GridColumn then
    nRotate = 90
  end
  return nRotate
end

function MiningGridListCtrl:GetDir(nRootIndex, nDirIndex)
  local nDir = 0
  local nRootC, nRootR = self:GetGridIndex(nRootIndex)
  local nDirC, nDirR = self:GetGridIndex(nDirIndex)
  if nRootC == nDirC then
    if nRootR > nDirR then
      nDir = GameEnum.miningRewardDir.Down
    else
      nDir = GameEnum.miningRewardDir.Up
    end
  elseif nRootC > nDirC then
    if (nRootC % 2 == 1 or nRootC == 2) and nRootC ~= 7 then
      if nRootR == nDirR then
        nDir = GameEnum.miningRewardDir.LeftUp
      else
        nDir = GameEnum.miningRewardDir.LeftDown
      end
    elseif nRootR == nDirR then
      nDir = GameEnum.miningRewardDir.LeftDown
    else
      nDir = GameEnum.miningRewardDir.LeftUp
    end
  elseif nRootC < nDirC then
    if nRootC % 2 == 1 and nRootC ~= 1 then
      if nRootR == nDirR then
        nDir = GameEnum.miningRewardDir.RightUp
      else
        nDir = GameEnum.miningRewardDir.RightDown
      end
    elseif nRootR == nDirR then
      nDir = GameEnum.miningRewardDir.RightDown
    else
      nDir = GameEnum.miningRewardDir.RightUp
    end
  end
  return nDir
end

function MiningGridListCtrl:GetGridIndex(nIndex)
  local nColumn = 0
  local nRow = 0
  local nTemp = 0
  for i = 1, #ColumnCount do
    local nlastTemo = nTemp
    nTemp = nTemp + ColumnCount[i]
    if nIndex <= nTemp then
      nColumn = i
      nRow = nIndex - nlastTemo
      break
    end
  end
  return nColumn, nRow
end

function MiningGridListCtrl:ShowReward(tbRewardList)
  for i = 1, math.min(3, #tbRewardList) do
    local rewardPosList = tbRewardList[i].tbPosIndex
    for _, index in pairs(rewardPosList) do
      self._mapNode.cell[index]:ShowHint()
    end
  end
end

return MiningGridListCtrl

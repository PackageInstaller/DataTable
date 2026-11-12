local GachaCoverCtrl_PermanentCharReward = class("GachaCoverCtrl_PermanentCharReward", BaseCtrl)
GachaCoverCtrl_PermanentCharReward._mapNodeConfig = {
  goTimeBg = {sNodeName = "imgTimeBg"},
  TMPCountDown = {sComponentName = "TMP_Text"},
  imgActProgress = {sComponentName = "Image"},
  txtActValue = {sComponentName = "TMP_Text"},
  btnBubble = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Bubble"
  },
  txtNum = {nCount = 3, sComponentName = "TMP_Text"},
  icon = {nCount = 3, sComponentName = "Image"},
  goComplete = {nCount = 3, sComponentName = "GameObject"},
  redDot = {nCount = 3}
}

function GachaCoverCtrl_PermanentCharReward:PlayInAnim()
  local anim = self.gameObject.transform:GetComponent("Animator")
  anim:SetTrigger("tIn")
end

function GachaCoverCtrl_PermanentCharReward:SetCover(nId)
  self.nId = nId
  self.tbReward = PlayerData.Gacha:GetGachaReward(nId)
  if type(self.tbReward) ~= "table" then
    printError("角色卡池累抽赠奖数据错误：界面，卡池id" .. tostring(nId))
    return
  end
  local nLimit = #self._mapNode.btnBubble
  table.sort(self.tbReward, function(a, b)
    return a.nIdx < b.nIdx
  end)
  if nLimit > #self.tbReward then
    printError("角色卡池累抽赠奖数据错误：界面，赠送次数错误，目前界面做死的，不应小于：" .. tostring(nLimit))
    return
  end
  local nMax = self.tbReward[nLimit].nNum
  local nCur = PlayerData.Gacha:GetGachaTotalTimes(nId)
  if nMax < nCur then
    nCur = nMax
  end
  local tbProgress = {
    0.18,
    0.66,
    1
  }
  for i, v in ipairs(tbProgress) do
    local _nMax = self.tbReward[i].nNum
    if nCur <= _nMax then
      self._mapNode.imgActProgress.fillAmount = nCur / _nMax * tbProgress[i]
      break
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtActValue, tostring(nCur) .. "/" .. tostring(nMax))
  for i = 1, nLimit do
    local data = self.tbReward[i]
    local cfg = ConfigTable.GetData("Item", data.nItemId)
    NovaAPI.SetTMPText(self._mapNode.txtNum[i], tostring(data.nNum))
    self:SetPngSprite(self._mapNode.icon[i], cfg.Icon)
    self._mapNode.goComplete[i]:SetActive(data.bRec == true)
    RedDotManager.RegisterNode(RedDotDefine.Gacha_Reward, {nId, i}, self._mapNode.redDot[i])
  end
  self:SetCountDownTime()
end

function GachaCoverCtrl_PermanentCharReward:SetCountDownTime()
  local cfg = ConfigTable.GetData("Gacha", self.nId)
  if cfg == nil then
    self._mapNode.goTimeBg:SetActive(false)
    return
  end
  local sTimeStr = cfg.EndTime
  if type(sTimeStr) == "string" and sTimeStr ~= "" then
    self._mapNode.goTimeBg:SetActive(true)
    local nEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(sTimeStr)
    local curTime = CS.ClientManager.Instance.serverTimeStamp
    local remainTime = nEndTime - curTime
    if 86400 <= remainTime then
      local day = math.floor(remainTime / 86400)
      local hour = math.floor((remainTime - day * 86400) / 3600)
      if hour == 0 then
        day = day - 1
        hour = 24
      end
      sTimeStr = orderedFormat(ConfigTable.GetUIText("Energy_LeftTime_Day"), day, hour)
    elseif 3600 <= remainTime then
      local hour = math.floor(remainTime / 3600)
      local min = math.floor((remainTime - hour * 3600) / 60)
      if min == 0 then
        hour = hour - 1
        min = 60
      end
      sTimeStr = orderedFormat(ConfigTable.GetUIText("Energy_LeftTime_Hour"), hour, min)
    else
      sTimeStr = ConfigTable.GetUIText("Energy_LeftTime_LessThenHour")
    end
    local text = orderedFormat(ConfigTable.GetUIText("GachaCover_TimeCountDown"), sTimeStr)
    NovaAPI.SetTMPText(self._mapNode.TMPCountDown, text)
  else
    self._mapNode.goTimeBg:SetActive(false)
  end
end

function GachaCoverCtrl_PermanentCharReward:EnableCover()
end

function GachaCoverCtrl_PermanentCharReward:DisableCover()
end

function GachaCoverCtrl_PermanentCharReward:OnBtnClick_Bubble(btn, nIdx)
  printLog(tostring(nIdx))
  local mapData = self.tbReward[nIdx]
  if type(mapData) == "table" then
    if mapData.bCan == true and mapData.bRec == false then
      local function callback(mapChangeInfo)
        self.tbReward[nIdx].bRec = true
        
        self._mapNode.goComplete[nIdx]:SetActive(true)
        UTILS.OpenReceiveByChangeInfo(mapChangeInfo)
      end
      
      PlayerData.Gacha:GetReward(self.nId, mapData.nId, mapData.nIdx, callback)
    else
      local mapData = {
        nTid = mapData.nItemId,
        bShowDepot = false,
        bShowJumpto = false
      }
      EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btn.transform, mapData)
    end
  end
end

return GachaCoverCtrl_PermanentCharReward

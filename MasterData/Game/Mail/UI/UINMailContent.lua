local UINMailContent = class("UINMailContent", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local JumpManager = require("Game.Jump.JumpManager")
local UrlUtil = require("Common.UrlUtil")
local cs_MessageCommon = CS.MessageCommon
local cs_UnityWebRequest = CS.UnityEngine.Networking.UnityWebRequest

function UINMailContent:OnInit()
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Mail, false)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.poolMailItem = UIItemPool.New(UINBaseItemWithReceived, self.ui.rewardItem)
  self.ui.rewardItem:SetActive(false)
  self.ui.tex_Content.onHrefClick:AddListener(BindCallback(self, self.OnClickHerf))
  UIUtil.AddButtonListener(self.ui.btn_Get, self, self.m_GetReward)
  UIUtil.AddButtonListener(self.ui.btn_Delete, self, self.m_DeleteOneMail)
  UIUtil.AddButtonListener(self.ui.btn_Collect, self, self.OnClickTreasure)
  self.timerId = TimerManager:StartTimer(1, self.m_OutOfDataTime, self, false, false, true)
end

function UINMailContent:UpdateContent(mailData)
  self.mailData = mailData
  if mailData == nil then
    self.ui.empty:SetActive(true)
    self.ui.normal:SetActive(false)
    return
  end
  self.ui.empty:SetActive(false)
  self.ui.normal:SetActive(true)
  self:m_RefreshStaticUI(mailData)
  self:m_RefreshReward(mailData)
  self:m_OutOfDataTime()
end

function UINMailContent:m_RefreshStaticUI(mailData)
  local isHaveAtt, attDic, isPicked = mailData:IsHaveAtt()
  local isTreasure = mailData:GetIsTreasure()
  if isTreasure then
    self.ui.tex_Collect:SetIndex(1)
    self.ui.img_Collect:SetIndex(1)
    if isHaveAtt then
      self.ui.expiryDate:SetIndex(1)
    else
      self.ui.expiryDate:SetIndex(0)
    end
  else
    self.ui.tex_Collect:SetIndex(0)
    self.ui.img_Collect:SetIndex(0)
    self.ui.expiryDate:SetIndex(0)
  end
  local mailWindow = UIManager:GetWindow(UIWindowTypeID.Mail)
  if mailWindow ~= nil then
    mailWindow:RefreshSenderPic(mailData)
  end
  self.ui.tex_Tile.text = mailData:GetTitle()
  self.ui.tex_Frome.text = mailData:GetSender()
  local ymd, hm = mailData:GetTime()
  self.ui.tex_Time:SetIndex(0, ymd, hm)
  local text = self:__DealContent(mailData:GetContent())
  if self.__lastText ~= nil and self.__lastText == text then
    return
  end
  self.__lastText = text
  self.ui.tex_Content.text = text
end

function UINMailContent:m_RefreshReward(mailData)
  if PlayerDataCenter.timestamp > mailData.expiredTm then
    self.ui.reward:SetActive(false)
    self.ui.expiryDate.gameObject:SetActive(false)
    self.ui.btn_Delete.gameObject:SetActive(true)
    return
  end
  self.ui.expiryDate.gameObject:SetActive(true)
  local isHaveAtt, attDic, isPicked, receivedDic = mailData:IsHaveAtt()
  self.ui.reward:SetActive(isHaveAtt)
  if isHaveAtt then
    local attList = self:_SortAttDicData(attDic)
    self.poolMailItem:HideAll()
    for _, cfg in ipairs(attList) do
      local reward = self.poolMailItem:GetOne()
      local count = attDic[cfg.id]
      reward:InitItemWithCount(cfg, count, nil, isPicked or receivedDic[cfg.id])
    end
    self.ui.btn_Get.gameObject:SetActive(not isPicked)
    self.ui.btn_Delete.gameObject:SetActive(isPicked)
  else
    self.ui.btn_Delete.gameObject:SetActive(true)
  end
end

function UINMailContent:_SortAttDicData(attDic)
  local attList = {}
  for id, num in pairs(attDic) do
    local itemCfg = ConfigData.item[id]
    if itemCfg == nil then
      error("Can't read itemCfg with id=" .. tostring(id))
    else
      table.insert(attList, itemCfg)
    end
  end
  return CommonUtil.DefaultItemsSort(attList)
end

local tiemType = {
  day = 0,
  hour = 1,
  min = 2,
  second = 3
}

function UINMailContent:m_OutOfDataTime()
  if self.mailData == nil then
    return
  end
  local time = self.mailData:GetTimeBeforeExpired()
  if 86400 < time then
    local num = math.ceil(time // 86400)
    self.ui.tex_ExpiryDate:SetIndex(tiemType.day, tostring(num))
  elseif 3600 < time then
    local num = math.ceil(time // 3600)
    self.ui.tex_ExpiryDate:SetIndex(tiemType.hour, tostring(num))
  elseif 60 < time then
    local num = math.ceil(time // 60)
    self.ui.tex_ExpiryDate:SetIndex(tiemType.min, tostring(num))
  elseif 0 < time then
    self.ui.tex_ExpiryDate:SetIndex(tiemType.second, tostring(time))
  end
end

function UINMailContent:OnClickTreasure()
  local isTreasure = self.mailData:GetIsTreasure()
  if isTreasure then
    self.ctrl:ReqCancelTreasuredMail(self.mailData.uid)
  else
    self.ctrl:ReqTreasuredMail(self.mailData.uid)
  end
end

function UINMailContent:m_GetReward()
  local isHaveAtt, attDic, isPicked, receivedDic = self.mailData:IsHaveAtt()
  local containAth = false
  local containFairy = false
  local maxFairyNum = 0
  for k, item in ipairs(self.poolMailItem.listItem) do
    local itemCfg = item.itemCfg
    if not receivedDic[itemCfg.id] then
      if itemCfg ~= nil and itemCfg.type == eItemType.Arithmetic then
        containAth = true
      end
      if itemCfg ~= nil and itemCfg.type == eItemType.FairyCard then
        local num = attDic[itemCfg.id]
        if maxFairyNum < num then
          maxFairyNum = num
        end
        containFairy = true
      end
    end
  end
  if containAth and #PlayerDataCenter.allAthData:GetAllAthList() >= ConfigData.game_config.athMaxNum then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
    return
  end
  local fairyCtrl = ControllerManager:GetController(ControllerTypeId.Fairy)
  if containFairy and fairyCtrl then
    local nowNum = fairyCtrl:GetFairyCount()
    local maxNum = fairyCtrl:GetFairyBagMaxNum()
    if maxNum < nowNum + maxFairyNum then
      local msg = string.format(ConfigData:GetTipContent(22017))
      cs_MessageCommon.ShowMessageBox(msg, function()
        JumpManager:Jump(JumpManager.eJumpTarget.DynFairy, nil, nil, {1})
      end, nil)
      return
    end
  end
  self.ctrl:ReqReceiveAttachment(self.mailData.uid)
end

function UINMailContent:m_DeleteOneMail()
  local function DeleteOneMail()
    AudioManager:PlayAudioById(1057)
    
    self.ctrl:ReqDeleteOneMail(self.mailData.uid)
  end
  
  local isTreasure = self.mailData:GetIsTreasure()
  if isTreasure then
    local msgWin = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    msgWin:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(346), DeleteOneMail)
    return
  end
  DeleteOneMail()
end

function UINMailContent:OnClickHerf(herfStr)
  local arg = {}
  local index = string.find(herfStr, ":")
  arg[1] = string.sub(herfStr, 1, index - 1)
  arg[2] = string.sub(herfStr, index + 1, -1)
  if arg[1] == "GameJump" then
    local typeAndArgs = string.split(arg[2], "=")
    local jumpTypeId = tonumber(typeAndArgs[1])
    local jumpArgs
    if typeAndArgs[2] ~= nil then
      jumpArgs = CommonUtil.SplitStrToNumber(typeAndArgs[2], "_")
    end
    if 0 < jumpTypeId then
      JumpManager:Jump(jumpTypeId, function(jumpCallback)
        if jumpTypeId == JumpManager.eJumpTarget.Mail then
          return
        end
        if jumpTypeId ~= JumpManager.eJumpTarget.UserCenter then
          local win = UIManager:GetWindow(UIWindowTypeID.Mail)
          win:Delete()
        end
        if jumpCallback ~= nil then
          jumpCallback()
        end
      end, nil, jumpArgs)
    end
  elseif arg[1] == "link" then
    local webLink = arg[2]
    CS.UnityEngine.Application.OpenURL(webLink)
  elseif arg[1] == "token" then
    local webLink = arg[2]
    webLink = UrlUtil.GetWebURL(webLink)
    CS.UnityEngine.Application.OpenURL(webLink)
  end
end

function UINMailContent:__DealContent(content)
  content = self:__DealPlayerName(content)
  return content
end

function UINMailContent:__DealPlayerName(content)
  local p = "<cmdr>"
  local playName = PlayerDataCenter:GetSelfName()
  content = string.gsub(content, p, playName)
  return content
end

function UINMailContent:OnDelete()
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  base.OnDelete(self)
end

return UINMailContent

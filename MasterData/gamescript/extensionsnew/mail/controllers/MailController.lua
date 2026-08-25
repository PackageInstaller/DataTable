local MailController = NewClass("MailController", BaseController)

function MailController:OnInit()
end

function MailController:OnReset()
end

function MailController:OpenMailView()
  UIManager.Instance:Reopen(Urls.MailView)
end

function MailController:OpenTreasureMailView()
  UIManager.Instance:Reopen(Urls.TreasureMailView)
end

function MailController:OpenMailIntroView()
  UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("Mail_Description_Title"), LT.Text("Mail_Description_Detail"))
end

function MailController:OpenTreasureBox()
  MailModel.Instance:SetTreasureRedState(MailDataUtils.TreasureRedState.NotRed)
  RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.TreasureMail, RedPointDataUtils.RedAttrType.Red)
  self:OpenTreasureMailView()
end

function MailController:DeleteMail(uid, index, onDeleteSuccess)
  if not MailModel.Instance:CheckChosenEmpty() then
    return
  end
  local mailUid = uid or MailModel.Instance.selectMailUid
  if not MailModel.Instance:IsMailRead(mailUid) then
    Logger.Debug("邮件尚未读")
    return
  end
  local mailIndex = index or MailModel.Instance.selectMailIndex
  
  local function func()
    MailModel.Instance:ReqDeleteMail(mailUid, mailIndex, function(mail, idx)
      if onDeleteSuccess then
        onDeleteSuccess(mail, idx)
        return
      end
      MailModel.Instance:OnDeleteMailSuccess(mail)
      MailModel.Instance:SetSelectMailUid()
      MailModel.Instance:SetSelectMailIndex()
      MailModel.Instance:LocalNotify(NotifyId.OnChangeMailData)
    end)
  end
  
  Alert.Show(20063, nil, func)
end

function MailController:DeleteTreasureMail(uid, index, onDeleteSuccess)
  if not MailModel.Instance:CheckTreasureChosenEmpty() then
    return
  end
  local mailUid = uid or MailModel.Instance.selectTreasureMailUid
  local mailIndex = index or MailModel.Instance.selectTreasureMailIndex
  
  local function func()
    MailModel.Instance:ReqDeleteMail(mailUid, mailIndex, function(mail, idx)
      if onDeleteSuccess then
        onDeleteSuccess(mail, idx)
        return
      end
      MailModel.Instance:OnDeleteMailSuccess(mail)
      MailModel.Instance:SetSelectTreasureMailUid()
      MailModel.Instance:SetSelectTreasureMailIndex()
      MailModel.Instance:LocalNotify(NotifyId.OnChangeTreasureMailData)
    end)
  end
  
  Alert.Show(20064, nil, func)
end

function MailController:DeleteAllReadMail()
  if MailModel.Instance:IsEmpyMailBox(MailModel.Instance.mailList) then
    return
  end
  local readMailNum = MailModel.Instance:HasReadMailNum()
  if 0 == readMailNum then
    return
  end
  
  local function func()
    MailModel.Instance:ReqDeleteAllMail("mail")
  end
  
  Alert.Show(20062, nil, func)
end

local function _CalcItemNum(list, itemId, itemNum)
  for _, itemData in pairs(list) do
    if itemData and itemData.tid == itemId then
      itemNum = itemNum + (itemData.num or 0)
      break
    end
  end
  return itemNum
end

local function _CheckItemOver(isAll, itemId, checkFunc)
  local itemNum = 0
  local model = MailModel.Instance
  if isAll then
    for key, _ in pairs(model.mails) do
      local list = model:GetAttachments(key)
      if list then
        itemNum = _CalcItemNum(list, itemId, itemNum)
      end
    end
  else
    local uid = model.selectMailUid
    local list = model:GetAttachments(uid)
    if list then
      itemNum = _CalcItemNum(list, itemId, itemNum)
    end
  end
  if itemNum > 0 then
    do return checkFunc end
    return checkFunc, itemNum, _CalcItemNum(list, itemId, itemNum), list, itemId, itemNum, model:GetAttachments(key), _CalcItemNum(list, itemId, itemNum), list, itemId, itemNum
  else
    return false
  end
end

function MailController:ReceiveAttachment(uid)
  local mailUid = uid or MailModel.Instance.selectMailUid
  if not mailUid then
    return
  end
  
  local function reqGetAttachment()
    MailModel.Instance:ReqGetAttachment(mailUid)
  end
  
  local energyItemId = DT.GetConstant("EnergyItemTid")
  local params = DT.GetOriginalConstant("DailyChallengeSkipConsume")
  local skipItemId = params[1]
  if _CheckItemOver(false, energyItemId, GetEnergyCheckUtils.EnergyIsOverMax) then
    GetEnergyCheckUtils.TipsShow(reqGetAttachment)
  elseif _CheckItemOver(false, skipItemId, GetChallengeSkipItemCheckUtils.ItemIsOverMax) then
    GetChallengeSkipItemCheckUtils.TipsShow(reqGetAttachment)
  else
    reqGetAttachment()
  end
end

function MailController:ReceiveAllAttachment()
  if MailModel.Instance:IsEmpyMailBox(MailModel.Instance.mailList) then
    return
  end
  
  local function reqGetAllAttachment()
    MailModel.Instance:ReqGetAllAttachment()
  end
  
  local params = DT.GetOriginalConstant("DailyChallengeSkipConsume")
  local skipItemId = params[1]
  
  local function tryReqGetAllAttachment()
    if _CheckItemOver(true, skipItemId, GetChallengeSkipItemCheckUtils.ItemIsOverMax) then
      GetChallengeSkipItemCheckUtils.TipsShow(reqGetAllAttachment)
      return
    end
    reqGetAllAttachment()
  end
  
  MailModel.Instance:ReqAllGainEnergyItemCount(function(svrData)
    local energy = svrData and svrData.count or 0
    if GetEnergyCheckUtils.EnergyIsOverMax(energy or 0) then
      GetEnergyCheckUtils.TipsShow(tryReqGetAllAttachment)
      return
    end
    tryReqGetAllAttachment()
  end)
end

return MailController

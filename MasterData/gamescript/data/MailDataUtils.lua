local MailDataUtils = {}
local MAIL_SURVEY_UID_BASE = "Survey_"
MailDataUtils.TreasureRedState = {NotRed = 0, ShouldShowRed = 1}

function MailDataUtils.Init()
  DataCenter.mailData.surveyMails = {}
  DataCenter.mailData.hasAddMail = false
  DataCenter.mailData.hasDelMail = false
end

function MailDataUtils.SetSyncStatus(hasAdd, hasDel)
  if nil ~= hasAdd then
    DataCenter.mailData.hasAddMail = hasAdd
  end
  if nil ~= hasDel then
    DataCenter.mailData.hasDelMail = hasDel
  end
end

function MailDataUtils.RemoveMailRed()
  RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Mail, RedPointDataUtils.RedAttrType.Red)
end

function MailDataUtils.GetLocalSurveyMailUid(surveyId)
  if not surveyId then
    return
  end
  return MAIL_SURVEY_UID_BASE .. surveyId
end

function MailDataUtils.OnHandleSurveyData(succ, surveyList)
  if not succ or not surveyList then
    return
  end
  if #surveyList <= 0 then
    DataCenter.mailData.surveyMails = {}
    return
  end
  local readSurveys = MailDataUtils.GetReadSurveyCache()
  for _, survey in ipairs(surveyList) do
    if MailDataUtils._SurveyIdInMailCfg(survey.resource_id) then
    else
      local surveyEndTime = survey.end_timestamp and math.floor(survey.end_timestamp / 1000) or 0
      if not MailDataUtils.CheckSurveyMailTime({end_time = surveyEndTime}) then
        Logger.Debug("[mail] 问卷已过期:", survey.resource_id, surveyEndTime)
      else
        local uid = MailDataUtils.GetLocalSurveyMailUid(survey.resource_id)
        if uid then
          survey.read = readSurveys and readSurveys[uid]
        end
        local mail = MailDataUtils.CreateClientSurveyMail(survey)
        local clientMail = DataCenter.mailData.surveyMails[mail.mailUid]
        if clientMail then
          for k, v in pairs(mail) do
            clientMail[k] = v
          end
        else
          DataCenter.mailData.surveyMails[mail.mailUid] = mail
        end
      end
    end
  end
end

function MailDataUtils._SurveyIdInMailCfg(id)
  if not id then
    return
  end
  if not MailDataUtils.surveyIdDict then
    MailDataUtils.surveyIdDict = {}
    for _, cfg in pairs(DT.Mail) do
      if cfg.SurveyId then
        MailDataUtils.surveyIdDict[cfg.SurveyId] = true
      end
    end
  end
  return MailDataUtils.surveyIdDict[id]
end

function MailDataUtils.CheckSurveyMailTime(surveyMail)
  if not surveyMail then
    return false
  end
  local now = TimeUtils.GetServerTime()
  return now <= surveyMail.end_time
end

function MailDataUtils.CreateClientSurveyMail(survey)
  if not survey then
    return
  end
  local mail = {
    mailUid = MailDataUtils.GetLocalSurveyMailUid(survey.resource_id),
    survey_id = survey.resource_id,
    title = survey.name,
    content = survey.desc,
    read = survey.read,
    hasDetail = false,
    sender = LT.Text("QuestionnaireEmailSender"),
    collection = false,
    ts = survey.start_timestamp and math.floor(survey.start_timestamp / 1000),
    endTime = survey.end_timestamp and math.floor(survey.end_timestamp / 1000),
    itemList = {},
    isClientSurvey = true
  }
  if survey.end_timestamp and survey.start_timestamp then
    mail.validTime = math.floor((survey.end_timestamp - survey.start_timestamp) / 1000)
  end
  return mail
end

function MailDataUtils.SetReadSurveyCache(uid)
  local key = CommonDefine.LocalSaveKey.LocalSurveyMailRead
  local readSurveys = MobileFileDataManager.Instance:GetPlayerFileValue(CommonDefine.LocalSaveKey.LocalSurveyMailRead)
  readSurveys = readSurveys or {}
  readSurveys[uid] = true
  MobileFileDataManager.Instance:SetPlayerFileValue(key, readSurveys)
  MobileFileDataManager.Instance:OnSavePlayerFileInfo()
end

function MailDataUtils.GetReadSurveyCache()
  local readSurveys = MobileFileDataManager.Instance:GetPlayerFileValue(CommonDefine.LocalSaveKey.LocalSurveyMailRead)
  if nil == readSurveys then
    return {}
  end
  return readSurveys
end

return MailDataUtils

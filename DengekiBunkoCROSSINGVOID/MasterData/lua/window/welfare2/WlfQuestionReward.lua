local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local ACU = require("Common/ActivityUtil")
local GotoUtil = require("Common/GotoUtil")
local S = require("Common/Singleton")
local DBH = require("Manager/DataBindingHandler")
local m_configDataManager = S:Get("ConfigDataManager")
local m_activityManager = S:Get("ActivityManager")
local mActiveDungeons = {}
local mActivated = false
local mNowActivityId
local mDungeons = {}
local m_ActivityId = 0
local m_wlfConfig
local QuestionState = {}
QuestionState.None = -1
QuestionState.Start = 0
QuestionState.Doing = 1
QuestionState.DoingWaitNext = 2
QuestionState.End = 3
local m_state = 0
local m_tipsTimer, m_select, m_curQuestionId, m_defaultActorPos, m_defaultActorShadowPos
local AnswerRight = {
  color = CS.NGUIMath.HexToColor(210795007),
  bg = "Question/question_bg_3"
}

function Start()
  local maxLen = #REF.CheckinAccuGifts
  local resGifts = PB.all("QuestionActivtyProcess")
  local barWidth = REF.CheckinAccuProgress.UISprite.localSize.x
  for i = 1, maxLen do
    local refBtn = REF.CheckinAccuGifts[i - 1]
    WU.BindButtonEvent(refBtn.root, OnBtnGiftClick)
    refBtn.Label.UILabel.text = tostring(resGifts[i].process)
    local p = refBtn.root.transform.localPosition
    refBtn.root.transform.localPosition = CS.UnityEngine.Vector3(resGifts[i].process / resGifts[maxLen].process * barWidth, p.y, p.z)
  end
  WU.BindButtonEvent(REF.ButtonStart, OnButtonStart)
  WU.BindButtonEvent(REF.ButtonConfirm, OnButtonConfirm)
  WU.BindButtonEvent(REF.ButtonClose, OnButtonClose)
  m_defaultActorPos = REF.ActorMgring.transform.localPosition
end

function OnButtonClose()
  enterQuestionStartState()
end

function IsEnough()
  local info = PB.get("QuestionActivtyConfig", m_ActivityId)
  local costStock = this:GetData("fci/item/" .. info.questionActivtyCost.id)
  if costStock and costStock.count >= info.questionActivtyCost.count then
    return true
  end
  return false
end

function OnEnable()
  m_wlfConfig = PB.get("WelfareConfig", "QuestionReward")
  m_ActivityId = m_wlfConfig.relatedActivityIds[1]
  REF.Body.gameObject:SetActive(false)
  this:BindRemote(this:GameRequest(GetSystemDataKey()), function(res)
    if res == nil then
      return
    end
    REF.Body.gameObject:SetActive(true)
    InitState()
  end)
end

function InitState()
  local data = this:GetData(GetSystemDataKey())
  if data then
    if not IsEnoughCount() then
      enterQuestionEndState()
    else
      enterQuestionStartState()
    end
  end
end

function IsEnoughCount()
  local data = this:GetData(GetSystemDataKey())
  if data.questionCount <= data.dayAnwserTimes then
    return false
  else
    return true
  end
end

function OnButtonStart()
  enterQuestionDoingState(true)
end

function OnButtonConfirm()
  enterQuestionDoingWaitNextState()
end

function UpdateQuestionActivityTime()
  local data = this:GetData(GetSystemDataKey())
  local activity = m_activityManager.GetActivitySync(m_wlfConfig.relatedActivityType, m_ActivityId)
  if activity then
    local startTime = CS.GameTime.UtcToLocal(activity.timestampStart)
    local endTime = CS.GameTime.UtcToLocal(activity.timestampEnd)
    local strTime = WU.GetString("Window_Month_Day_Hour", startTime.Month, startTime.Day, startTime.Hour) .. " ~ " .. WU.GetString("Window_Month_Day_Hour", endTime.Month, endTime.Day, endTime.Hour + 1)
    strTime = strTime .. "\239\188\136" .. WU.GetString("WindowGacha_FreeTips4") .. "\239\188\137"
    REF.LabelEveryDayActTime10.UIHtmlLabel.text = strTime
  end
  REF.LabelCount.UILabel.text = data.curProcess
end

function enterQuestionStartState()
  SwitchState(QuestionState.Start)
  UpdateData()
  UpdateQuestionActivityTime()
  local data = this:GetData(GetSystemDataKey())
  if data.dayNotFirstFlag then
    REF.LabelContinue.UILabel.text = WU.GetString("WindowsQuestion_Continue")
  else
    REF.LabelContinue.UILabel.text = WU.GetString("WindowQuestion_Start")
  end
end

function enterQuestionEndState()
  SwitchState(QuestionState.End)
  UpdateData()
  UpdateQuestionActivityTime()
end

function enterQuestionDoingState(bCheckByNet)
  REF.TouchMask.gameObject:SetActive(false)
  REF.SpriteTipsBg.UISprite.graify = false
  if not IsEnoughCount() then
    enterQuestionEndState()
  elseif bCheckByNet then
    this:GameRequest("fci/question/exam-state/" .. m_ActivityId):Get(function(data)
      ReqNewQuestion(data.examing ~= true)
    end)
  else
    ReqNewQuestion(true)
  end
end

function GetSystemDataKey()
  return "fci/question/system/" .. m_ActivityId
end

function enterQuestionDoingWaitNextState()
  if m_select then
    this:GameRequest("fci/question/exam/" .. m_ActivityId):Post({quesitonId = m_curQuestionId, anwser = m_select}, function(res)
      SwitchState(QuestionState.DoingWaitNext)
      local data = this:GetData(GetSystemDataKey())
      data.curProcess = res.curProcess
      data.dayAnwserTimes = res.dayAnwserTimes
      UpdateQuestionDoingWaitNextState(res)
    end)
  end
end

function UpdateQuestionDoingWaitNextState(data)
  UpdateAnswerTimes()
  local questionData = this:GetData("QuestionData")
  local infoQuestion = PB.get("QuestionActivtyDescription", questionData.quesiton.id)
  local refCorrectAnswer = REF.QuestionGrid[infoQuestion.correctAnwser]
  refCorrectAnswer.SpriteCorrect.gameObject:SetActive(true)
  refCorrectAnswer.Correct.gameObject:SetActive(true)
  local info = PB.get("QuestionActivtyConfig", m_ActivityId)
  if m_tipsTimer then
    this:StopCoroutine(m_tipsTimer)
    m_tipsTimer = nil
  end
  REF.Tips.gameObject:SetActive(true)
  if data.result then
    REF.SpriteXiaoJiu.UISprite.spriteName = "Question/saku_2"
    local index = math.random(1, info.questionTips1MaxNum)
    REF.HtmlLabelTips.UIHtmlLabel.text = WU.GetString("WindowQuestion_AnswerCorrect_" .. index)
    CS.SoundManager.Instance:PlaySound("Sound/system/s_System_CorrectAnswer")
  else
    local refAnswer = REF.QuestionGrid[m_select]
    refAnswer.SpriteError.gameObject:SetActive(true)
    local index = math.random(1, info.questionTips1MaxNum)
    REF.SpriteXiaoJiu.UISprite.spriteName = "Question/saku_3"
    REF.HtmlLabelTips.UIHtmlLabel.text = WU.GetString("WindowQuestion_AnswerError_" .. index)
    REF.SpriteTipsBg.UISprite.graify = true
    CS.SoundManager.Instance:PlaySound("Sound/system/s_System_WrongAnswer")
  end
  m_select = nil
  REF.TouchMask.gameObject:SetActive(true)
  this:DelayInvokeInSeconds(3, function()
    enterQuestionDoingState(false)
  end)
end

function Select(index)
  local refAnswer = REF.QuestionGrid[index - 1]
  refAnswer.Toggle.UIToggle.value = true
  OnSelect(index)
end

function ReqNewQuestion(bJudge)
  local function req()
    this:GameRequest("fci/question/exam/" .. m_ActivityId):Get(function(res)
      DBH.ResChange(res.resChange)
      
      SwitchState(QuestionState.Doing)
      local data = this:GetData(GetSystemDataKey())
      data.dayNotFirstFlag = true
      this:SetData("QuestionData", res)
      UpdateQuestionDoingState()
    end)
  end
  
  if bJudge then
    if IsEnough() then
      req()
    else
      local strError = WU.GetString("WindowsQuestion_NotEnough")
      WU.ShowHintText(strError)
      if m_state ~= QuestionState.Start then
        SwitchState(QuestionState.Start)
      end
    end
  else
    req()
  end
end

function UpdateAnswerTimes()
  local configData = this:GetData(GetSystemDataKey())
  if configData then
    local left = configData.questionCount - configData.dayAnwserTimes
    REF.LabelLeftCount.UILabel.text = WU.GetString("WindowQuestion_LeftCount", left)
    REF.LabelStartLeftCount.UILabel.text = WU.GetString("WindowQuestion_LeftCount", left)
  end
end

function OnSelect(index)
  if m_state == QuestionState.Doing then
    m_select = index - 1
  end
end

function UpdateQuestionDoingState()
  local questionData = this:GetData("QuestionData")
  local configData = this:GetData(GetSystemDataKey())
  local info = PB.get("QuestionActivtyConfig", m_ActivityId)
  if questionData.quesiton == nil then
    warning("Debug", "question is nil")
    SwitchState(QuestionState.None)
    return
  end
  if questionData and configData and info then
    m_curQuestionId = questionData.quesiton.id
    local infoQuestion = PB.get("QuestionActivtyDescription", m_curQuestionId)
    UpdateAnswerTimes()
    local actorId = 1009
    if infoQuestion.ActorId ~= 0 then
      actorId = infoQuestion.ActorId
    end
    local actorTex = string.format("actor_portrait_%da", actorId)
    REF.Actoring.UITexture.mainTexturePath = "Texture/ActorPortrait/" .. actorTex
    REF.ActorShadowing.UITexture.mainTexturePath = "Texture/ActorPortrait/" .. actorTex
    if infoQuestion.Scale and infoQuestion.Scale ~= 0 then
      REF.ActorMgring.transform.localScale = CS.UnityEngine.Vector3(infoQuestion.Scale, infoQuestion.Scale, infoQuestion.Scale)
    else
      REF.ActorMgring.transform.localScale = CS.UnityEngine.Vector3(0.95, 0.95, 0.95)
    end
    REF.ActorMgring.transform.localPosition = CS.UnityEngine.Vector3(m_defaultActorPos.x, m_defaultActorPos.y, m_defaultActorPos.z)
    if infoQuestion.OffsetX and infoQuestion.OffsetX ~= 0 then
      REF.ActorMgring.transform.localPosition = CS.UnityEngine.Vector3(infoQuestion.OffsetX, m_defaultActorPos.y, m_defaultActorPos.z)
    end
    if infoQuestion.OffsetY and infoQuestion.OffsetY ~= 0 then
      REF.ActorMgring.transform.localPosition = CS.UnityEngine.Vector3(REF.ActorMgring.transform.localPosition.x, infoQuestion.OffsetY, m_defaultActorPos.z)
    end
    local strQuestion = WU.GetString("QuestionReward_" .. m_curQuestionId)
    REF.LabelQuestion.UIHtmlLabel.text = strQuestion
    for i = 1, 4 do
      local refAnswer = REF.QuestionGrid[i - 1]
      local strAnswer = string.format("QuestionReward_%d_%d", m_curQuestionId, i)
      refAnswer.LabelAn.UIHtmlLabel.text = WU.GetString(strAnswer)
      refAnswer.SpriteError.gameObject:SetActive(false)
      refAnswer.SpriteCorrect.gameObject:SetActive(false)
      refAnswer.Correct.gameObject:SetActive(false)
      refAnswer.Toggle.UIToggle.optionCanBeNone = true
      refAnswer.Toggle.UIToggle.value = false
      refAnswer.Toggle.UIToggle.optionCanBeNone = false
      WU.BindButtonEvent(refAnswer.Toggle, function()
        OnSelect(i)
      end)
    end
    if m_tipsTimer then
      this:StopCoroutine(m_tipsTimer)
    end
    REF.Tips.gameObject:SetActive(false)
    m_tipsTimer = this:DelayInvokeInSeconds(info.questionTipsInterval1, function()
      REF.Tips.gameObject:SetActive(true)
      REF.SpriteXiaoJiu.UISprite.spriteName = "Question/saku_1"
      local randomIndex = math.random(1, info.questionTips1MaxNum)
      REF.HtmlLabelTips.UIHtmlLabel.text = WU.GetString("WindowQuestion_TimeOutTips1_" .. randomIndex)
      m_tipsTimer = this:DelayInvokeInSeconds(info.questionTipsInterval1, function()
        local correct = infoQuestion.correctAnwser
        local tempErr = {}
        for i = 1, 4 do
          if i - 1 ~= correct then
            local temp = "A"
            if i == 2 then
              temp = "B"
            elseif i == 3 then
              temp = "C"
            elseif i == 4 then
              temp = "D"
            end
            tempErr[#tempErr + 1] = temp
          end
        end
        local randomError = math.random(1, #tempErr)
        local randomIndex = math.random(1, info.questionTips1MaxNum)
        REF.HtmlLabelTips.UIHtmlLabel.text = WU.GetString("WindowQuestion_TimeOutTips2_" .. randomIndex, tempErr[randomError])
      end)
    end)
  end
end

function SwitchState(state)
  if state == QuestionState.Start then
    REF.StateCommonSE.gameObject:SetActive(true)
    REF.StateStart.gameObject:SetActive(true)
    REF.StateDoing.gameObject:SetActive(false)
    REF.StateEnd.gameObject:SetActive(false)
  elseif state == QuestionState.Doing or state == QuestionState.DoingWaitNext then
    REF.StateCommonSE.gameObject:SetActive(false)
    REF.StateStart.gameObject:SetActive(false)
    REF.StateDoing.gameObject:SetActive(true)
    REF.StateEnd.gameObject:SetActive(false)
    if QuestionState.DoingWaitNext == state then
      REF.Doing.gameObject:SetActive(false)
    else
      REF.Doing.gameObject:SetActive(true)
    end
  elseif state == QuestionState.End then
    REF.StateCommonSE.gameObject:SetActive(true)
    REF.StateStart.gameObject:SetActive(false)
    REF.StateDoing.gameObject:SetActive(false)
    REF.StateEnd.gameObject:SetActive(true)
  else
    REF.StateCommonSE.gameObject:SetActive(false)
    REF.StateStart.gameObject:SetActive(false)
    REF.StateDoing.gameObject:SetActive(false)
    REF.StateEnd.gameObject:SetActive(false)
  end
  m_state = state
end

function UpdateData()
  UpdateRewardProgress()
  UpdateBtnGiftView()
  UpdateAnswerTimes()
  UpdateRed()
end

function UpdateRed()
  local data = this:GetData(GetSystemDataKey())
  local isRed = m_activityManager.IsRedForWlfQuestion(data)
  RU.SetRedMark("Welfare/QuestionReward/" .. m_ActivityId, isRed)
end

function UpdateRewardProgress()
  local data = this:GetData(GetSystemDataKey())
  local info = PB.all("QuestionActivtyProcess")
  local len = info[#info].process
  REF.CheckinAccuProgress.UIProgressBar.value = data.curProcess / len
end

function UpdateBtnGiftView()
  local info = PB.all("QuestionActivtyProcess")
  for i = 1, #REF.CheckinAccuGifts do
    SetBtnGiftView(REF.CheckinAccuGifts[i - 1], info[i], i - 1)
  end
end

function SetBtnGiftView(ref, giftInfo, index)
  ref["@giftInfo"] = giftInfo
  local data = this:GetData(GetSystemDataKey())
  local pos = table.find(data.gotProcess, function(k, v)
    return v == index + 1
  end)
  local isGiftGot = pos ~= nil
  ref["@isGiftGot"] = isGiftGot
  local canGetGift = data.curProcess >= giftInfo.process
  ref["@canGetGift"] = canGetGift
  ref.Glow.gameObject:SetActive(canGetGift and not isGiftGot)
  WU.SetActive(ref.Icon, true)
  if isGiftGot then
    ref["$UIButton"].normalSprite = "mission/mission_close"
  elseif canGetGift then
    WU.SetActive(ref.Icon, false)
  else
    ref["$UIButton"].normalSprite = "mission/mission_open"
  end
end

function OnBtnGiftClick(go)
  local ref = _ENV["$"](go)
  local info = ref["@giftInfo"]
  if info == nil then
    error("Checkin", "ref userdata is nil")
    return
  end
  if ref["@canGetGift"] then
    if ref["@isGiftGot"] then
      local title = WU.GetString("Window_QuestionRewardTitle")
      local buttonTitle = WU.GetString("WindowGacha_Close")
      WU.AcquireWindowAsync("RewardPreview", function(ui)
        _ENV["$"](ui)["$$SetView"](info.rewards, title, "", true, buttonTitle)
        for i, v in ipairs(info.rewards) do
          if v.type == PB.enum.ResourceType.ResActor then
            _ENV["$"](ui)["$$SetCustomActorInfo"](v.id, info.quality)
          end
        end
      end)
    else
      this:GameRequest("fci/question/process-reward/" .. info.activityId):Post({
        process = info.process
      }, function(result)
        local data = this:GetData(GetSystemDataKey())
        data.gotProcess = result.gotProcess
        DBH.ResChange(result.resChange)
        WU.ShowRewards(result.resChange)
        UpdateData()
      end)
    end
  else
    local title = WU.GetString("Window_QuestionRewardTitle")
    local data = this:GetData(GetSystemDataKey())
    local strContent = string.format("%d/%d", data.curProcess, info.process)
    local content = strContent
    WU.AcquireWindowAsync("RewardPreview", function(ui)
      _ENV["$"](ui)["$$SetView"](info.rewards, title, content, false)
      for i, v in ipairs(info.rewards) do
        if v.type == PB.enum.ResourceType.ResActor then
          _ENV["$"](ui)["$$SetCustomActorInfo"](v.id, v.quality)
        end
      end
    end)
  end
end

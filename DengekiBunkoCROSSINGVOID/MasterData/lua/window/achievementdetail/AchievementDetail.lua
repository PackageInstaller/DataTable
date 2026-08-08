local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local HU = require("Common/HtmlUtil")
local IU = require("Common/ItemUtil")
local DBH = require("Manager/DataBindingHandler")
local m_info

function SetupWindow()
  WU.BindButtonEvent(REF.BtnGetReward, GetReward)
end

function SetViewRaw(data)
  local id = tonumber(data.id)
  local info = PB.get("AchievementInfo", data.id)
  REF.LabelAwardTitle.UIHtmlLabel.text = ""
  REF.LabelAchievementName.UIHtmlLabel.text = WU.GetString("AchievementName_" .. id)
  REF.LabelAchievementGoal.UIHtmlLabel.text = GetGoalText(info)
  local desc = WU.GetString("AchievementDesc_" .. id)
  REF.LabelAchievementDesc.UIHtmlLabel.text = desc
  REF.LabelAchievementDesc.gameObject:SetActive(desc ~= "AchievementDesc_" .. id)
  REF.ProgressBar.gameObject:SetActive(false)
  REF.SpriteComplete.gameObject:SetActive(true)
  REF.BtnGetReward.gameObject:SetActive(false)
  REF.SpriteDoing.gameObject:SetActive(false)
  REF.Rewards.gameObject:SetActive(false)
  REF.LabelCompleteTime.gameObject:SetActive(false)
  SetDisplayRole(info)
end

function SetView(data)
  if data == nil then
    error("Achievement", "@data is nil")
  end
  m_info = data
  SetDisplayRole(data.info)
  REF.LabelAchievementName.UIHtmlLabel.text = WU.GetString("AchievementName_" .. m_info.id)
  REF.LabelAchievementGoal.UIHtmlLabel.text = GetGoalText(m_info.info)
  local desc = WU.GetString("AchievementDesc_" .. m_info.id)
  REF.LabelAchievementDesc.UIHtmlLabel.text = desc
  REF.LabelAchievementDesc.gameObject:SetActive(desc ~= "AchievementDesc_" .. m_info.id)
  REF.ProgressBar.UIProgressBar.value = m_info.progress / m_info.info.maxProgress
  REF.LabelProgress.UIHtmlLabel.text = m_info.progress .. "/" .. m_info.info.maxProgress
  if m_info.progress >= m_info.info.maxProgress then
    REF.SpriteProgress.UISprite.spriteName = "levelup_bar_02"
  else
    REF.SpriteProgress.UISprite.spriteName = "levelup_bar_01"
  end
  REF.ProgressBar.gameObject:SetActive(not m_info.rewardGot)
  REF.SpriteComplete.gameObject:SetActive(m_info.rewardGot)
  REF.LabelCompleteTime.gameObject:SetActive(m_info.rewardGot)
  REF.BtnGetReward.gameObject:SetActive(m_info.isDone and not m_info.rewardGot)
  REF.SpriteDoing.gameObject:SetActive(not m_info.isDone)
  if m_info.rewardGot then
    REF.LabelCompleteTime.UIHtmlLabel.text = WU.RenderTime(m_info.doneTime) .. WU.GetString("Window_Complete")
  end
  for i = 1, #REF.Rewards do
    local ref = REF.Rewards[i - 1]["$"]
    ref.gameObject:SetActive(i <= #m_info.info.reward)
    if i <= #m_info.info.reward then
      ref["$SetData"](m_info.info.reward[i].type, m_info.info.reward[i].id, m_info.info.reward[i].count)
    end
  end
end

function GetReward()
  WU.RecordButtonClick(100136401)
  this:GameRequest("fci/achievement/" .. m_info.id .. "/reward/"):Post(nil, function(result)
    DBH.ResChange(result.resChange)
    WU.ShowRewards(result.resChange)
    m_info.rewardGot = true
    this:SetData("fci/achievement/", result.newAchievements)
    this:DelayInvokeInFrames(1, function()
      WU.RecycleWindow(this)
    end)
  end)
end

function SetDisplayRole(info)
  local roleId = info.displayRoleId
  if roleId == 0 then
    roleId = 117
  end
  local _, actorConfig = PB.all("ActorConfig"):find(function(_, v)
    return v.role == roleId
  end)
  REF.TextureActor.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. actorConfig.animRes
  REF.TextureActor.transform.localPosition = CS.UnityEngine.Vector3(actorConfig.portraitOffsetX, actorConfig.portraitOffsetY, 0)
end

function GetGoalText(info)
  return WU.GetString("AchievementGoal_" .. info.id, HU.ApplyFontColor(info.maxProgress, "#55DDFF"), ColorParam(info.param))
end

function ColorParam(param)
  local p = {}
  for i = 1, #param do
    table.insert(p, HU.ApplyFontColor(param[i], "#55DDFF"))
  end
  return table.unpack(p)
end

function Focus(on)
  WU.RecordWindowFocus(1001364, on)
end

_class("UIN25VampireChallengeTaskItem", UICustomWidget)
UIN25VampireChallengeTaskItem = UIN25VampireChallengeTaskItem

function UIN25VampireChallengeTaskItem:Constructor()
end

function UIN25VampireChallengeTaskItem:OnShow(uiParams)
  self._atlas = self:GetAsset("UIN25VampireTaskAndLevel.spriteatlas", LoadType.SpriteAtlas)
  self.bgimg = self:GetUIComponent("Image", "bg")
  self.iconimg = self:GetUIComponent("RawImageLoader", "icon")
  self.txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self.slider = self:GetUIComponent("Slider", "sldProgress")
  self.percenttxt = self:GetUIComponent("UILocalizationText", "txtPercent")
  self.txtExptxt = self:GetUIComponent("UILocalizationText", "txtExp")
  self.txtTalenttxt = self:GetUIComponent("UILocalizationText", "txtTalent")
  self.txtExpGo = self:GetGameObject("txtExp")
  self.backgroundimg = self:GetUIComponent("Image", "background")
  self.fillimg = self:GetUIComponent("Image", "fill")
  self.expimg = self:GetUIComponent("Image", "exp")
  self.talentimg = self:GetUIComponent("Image", "talent")
  self.canGainGo = self:GetGameObject("canGain")
  self.cantGainGo = self:GetGameObject("cantGain")
  self.cantGainGo:SetActive(false)
  self.gotGo = self:GetGameObject("got")
  self.exp = self:GetGameObject("exp")
  self.talent = self:GetGameObject("talent")
  self.rootGo = self:GetGameObject("root")
  self.anim = self:GetUIComponent("Animation", "ani")
  self.rootGo:SetActive(false)
  self.eff = self:GetGameObject("eff")
  self.canvasGroup = self:GetUIComponent("CanvasGroup", "root")
  self.redBgGo = self:GetGameObject("redBg")
  self.redBgGo:SetActive(false)
end

function UIN25VampireChallengeTaskItem:OnHide()
end

function UIN25VampireChallengeTaskItem:Flush(data, manager, playAni)
  self.rootGo:SetActive(true)
  if playAni then
    self.anim:Play("uieffanim_UIN25VampireChallengeTaskItem_in")
  else
    self.canvasGroup.alpha = 1
  end
  self.manager = manager
  self.quest = data
  self.questInfo = self.quest:QuestInfo()
  local reward = self.questInfo.rewards
  self.eff:SetActive(self.quest:Status() < QuestStatus.QUEST_Completed)
  self.canGainGo:SetActive(self.quest:Status() == QuestStatus.QUEST_Completed)
  self.cantGainGo:SetActive(self.quest:Status() < QuestStatus.QUEST_Completed)
  if self.canGainGo.activeSelf then
    self.cantGainGo:SetActive(false)
  end
  self.gotGo:SetActive(false)
  local bg = "N25_mcwf_di1"
  local sliderBg = "N25_mcwf_progressbar2"
  local sliderFill = "N25_mcwf_progressbar1"
  local expimg = "N25_mcwf_di5"
  local talentimg = "N25_mcwf_di5"
  local expColor = "<color=#fff4ed>%s</color><color=#f7c058>%s</color>"
  local talentColor = "<color=#fff4ed>%s</color><color=#f7c058>+%s</color>"
  local percentColor = "<color=#6e4c10>%s</color>/<color=#000000>%s</color>"
  local titleColor = "<color=#ffffff>%s</color>"
  if self.quest:Status() < QuestStatus.QUEST_Completed then
    bg = "N25_mcwf_di2"
    sliderBg = "N25_mcwf_progressbar2"
    sliderFill = "N25_mcwf_progressbar1"
    expimg = "N25_mcwf_di6"
    talentimg = "N25_mcwf_di6"
    percentColor = "<color=#ffffff>%s</color>/<color=#a58b72>%s</color>"
  elseif self.quest:Status() == QuestStatus.QUEST_Completed then
    bg = "N25_mcwf_di1"
    sliderBg = "N25_mcwf_progressbar2"
    sliderFill = "N25_mcwf_progressbar1"
    expimg = "N25_mcwf_di5"
    talentimg = "N25_mcwf_di5"
    percentColor = "<color=#6e4c10>%s</color>/<color=#000000>%s</color>"
  else
    bg = "N25_mcwf_di3"
    sliderBg = "N25_mcwf_progressbar2"
    sliderFill = "N25_mcwf_progressbar3"
    expimg = "N25_mcwf_di7"
    talentimg = "N25_mcwf_di7"
    expColor = "<color=#b99d83>%s</color><color=#f7c058>%s</color>"
    talentColor = "<color=#b99d83>%s</color><color=#f7c058>+%s</color>"
    percentColor = "<color=#b99d83>%s</color>/<color=#9b826b>%s</color>"
    titleColor = "<color=#9b826b>%s</color>"
  end
  local itemStr = reward[1].assetid == 3000290 and "str_n25_task_talentpoint" or "str_n25_task_exp"
  local str = string.format(expColor, StringTable.Get(itemStr), reward[1].count)
  self.txtExptxt:SetText(str)
  self.talent:SetActive(false)
  if reward[2] then
    itemStr = reward[2].assetid == 3000290 and "str_n25_task_talentpoint" or "str_n25_task_exp"
    str = string.format(talentColor, StringTable.Get(itemStr), reward[2].count)
    self.talent:SetActive(true)
    self.txtTalenttxt:SetText(str)
  end
  str = string.format(percentColor, self.questInfo.cur_progress, self.questInfo.total_progress)
  self.slider.value = self.questInfo.cur_progress / self.questInfo.total_progress
  self.percenttxt:SetText(str)
  str = string.format(titleColor, StringTable.Get(self.questInfo.QuestDesc))
  self.txtTitle:SetText(str)
  self.bgimg.sprite = self._atlas:GetSprite(bg)
  self.backgroundimg = self._atlas:GetSprite(sliderBg)
  self.fillimg = self._atlas:GetSprite(sliderFill)
  self.expimg.sprite = self._atlas:GetSprite(expimg)
  self.talentimg.sprite = self._atlas:GetSprite(talentimg)
end

function UIN25VampireChallengeTaskItem:CanGainOnClick(go)
  if self.manager then
    self.manager:ReqAwards(self.questInfo.quest_id)
  end
end

function UIN25VampireChallengeTaskItem:CantGainOnClick(go)
end

function UIN25VampireChallengeTaskItem:GotOnClick(go)
end

function UIN25VampireChallengeTaskItem:PlayOutAni(taskId)
  if self.questInfo.quest_id == taskId then
    self.cantGainGo:SetActive(false)
    self.anim:Play("uieffanim_UIN25VampireChallengeTaskItem_out")
  end
end

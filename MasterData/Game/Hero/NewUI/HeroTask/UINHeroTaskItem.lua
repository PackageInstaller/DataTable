local UINHeroTaskItem = class("UINHeroTaskItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local TaskEnum = require("Game.Task.TaskEnum")
local JumpManager = require("Game.Jump.JumpManager")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function UINHeroTaskItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Get, self, self.OnClickGet)
  UIUtil.AddButtonListener(self.ui.btn_Goto, self, self.OnClickGoto)
  self.ui.rewardItem:SetActive(false)
  self.rewardPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.rewardItem)
end

function UINHeroTaskItem:InitHeroTaskItem(taskInfo, heroData)
  self.taskInfo = taskInfo
  self.heroData = heroData
  local isFinish = self.heroData:HasGetQuestReward(self.taskInfo.indx)
  self.rewardPool:HideAll()
  for i, v in ipairs(taskInfo.rewardIds) do
    local item = self.rewardPool:GetOne(true)
    local itemCfg = ConfigData.item[v]
    local num = taskInfo.rewardCounts[i]
    item:InitItemWithCount(itemCfg, num, nil, isFinish)
  end
  self:UpdateUI()
end

function UINHeroTaskItem:UpdateUI()
  local tempStr = ConfigData:GetTipContent(7001)
  local heroName = self.heroData:GetHeroName(true)
  self.ui.tex_TaskIntro.text = string.format(tempStr, heroName, self.taskInfo.param)
  self.ui.obj_Unfinish:SetActive(false)
  self.ui.obj_Completed:SetActive(false)
  self.ui.btn_Get.gameObject:SetActive(false)
  self.ui.btn_Goto.gameObject:SetActive(false)
  local isFinish = self.heroData:HasGetQuestReward(self.taskInfo.indx)
  local isComplect = self.taskInfo.isComplect
  self.ui.tex_TaskIntro.color = Color.black
  if isFinish then
    self.ui.img_Buttom:SetIndex(2)
    self.ui.tex_TaskIntro.color = self.ui.col_isFinish
    self.ui.tex_Progress.color = self.ui.col_isFinish
  elseif isComplect then
    self.ui.img_Buttom:SetIndex(1)
  else
    self.ui.img_Buttom:SetIndex(0)
  end
  self.ui.obj_Unfinish.gameObject:SetActive(not isComplect and not isFinish)
  self.ui.btn_Get.gameObject:SetActive(isComplect and not isFinish)
  self.ui.obj_Completed:SetActive(isFinish)
  local aim = self.taskInfo.param
  local schedule
  if self.heroData.level >= self.taskInfo.param then
    schedule = self.taskInfo.param
  else
    schedule = self.heroData.level
  end
  self.ui.tex_Progress.text = tostring(schedule) .. "/" .. tostring(aim)
  local progress = schedule / aim
  progress = progress < 1 and progress or 1
  self.ui.img_Fill.fillAmount = progress
  for i, v in ipairs(self.rewardPool.listItem) do
    v:SetPickedUIActive(isFinish)
  end
end

function UINHeroTaskItem:OnClickGoto()
  if self.taskInfo.stcData.jump_id ~= nil and self.taskInfo.stcData.jump_id > 0 then
    JumpManager:Jump(self.taskInfo.stcData.jump_id, nil, nil, self.taskInfo.stcData.jumpArgs)
  end
end

function UINHeroTaskItem:OnClickGet()
  local stcTask = self.taskInfo.stcData
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  NetworkManager:GetNetwork(NetworkTypeID.Hero):CS_HERO_QuestFinish(self.taskInfo.hero_id, self.taskInfo.indx, function()
    self.heroData:SetQuestGeted(self.taskInfo.indx)
    MsgCenter:Broadcast(eMsgEventId.OnHeroTaskChange, self.heroData)
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local rewardTips = string.format(ConfigData:GetTipContent(360), "", self.ui.tex_TaskIntro.text, self.taskInfo.param, self.taskInfo.param)
      local CRData = CommonRewardData.CreateCRDataUseList(self.taskInfo.rewardIds, self.taskInfo.rewardCounts):SetCRHeroSnapshoot(self._heroIdSnapShoot):SetCRRewardTips(rewardTips)
      window:AddAndTryShowReward(CRData)
    end)
  end)
end

function UINHeroTaskItem:OnDelete()
  base.OnDelete(self)
end

return UINHeroTaskItem

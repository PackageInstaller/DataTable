local base = UIBaseNode
local UINCarnivalLevelItem = class("UINCarnivalLevelItem", base)
local UINCarnivalLevelRewardItem = require("Game.ActivityCarnival.UI.CarnivalProgress.UINCarnivalLevelRewardItem")

function UINCarnivalLevelItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_RewardBg, self, self._OnClickPickReward)
  UIUtil.AddButtonListener(self.ui.btn_Unlock, self, self.OnClickJump)
  self.rewardItemPool = UIItemPool.New(UINCarnivalLevelRewardItem, self.ui.rewardItem, false)
end

function UINCarnivalLevelItem:InitCarnivalLevelItem(carnivalData, levelData, isPicked, pickRewardFunc, jumpFunc)
  self.ui.tex_Level.text = tostring(levelData.level)
  self._carnivalData = carnivalData
  self._pickRewardFunc = pickRewardFunc
  self._jumpFunc = jumpFunc
  self._levelData = levelData
  local unlock = levelData.curLevel >= levelData.level
  self.ui.canvasGroup.alpha = unlock and 1 or 0.5
  local pickable = not isPicked and unlock
  self._pickable = pickable
  self.rewardItemPool:HideAll()
  for k, itemId in ipairs(levelData.carnivalExpCfg.rewardIds) do
    local itemNum = levelData.carnivalExpCfg.rewardNums[k]
    local rewardItem = self.rewardItemPool:GetOne()
    local clickEvent = pickable and BindCallback(self, self._OnClickPickReward) or nil
    rewardItem:InitCarnivalLevelRewardItem(itemId, itemNum, clickEvent, isPicked, pickable)
  end
  self.ui.img_RewardBg.color = pickable and self.ui.color_pickable or self.ui.color_cantPick
  self:_UpdExpBar(levelData)
  self:_UpdUnlock(levelData)
end

function UINCarnivalLevelItem:_UpdExpBar(levelData)
  local showExpBar = true
  if levelData.level >= levelData.maxLevel then
    showExpBar = false
  elseif levelData.curLevel == levelData.level then
    local curExp = levelData.curExp
    local totalExp = levelData.carnivalExpCfg.need_exp
    self.ui.img_ExpProgress.fillAmount = curExp / totalExp
    self.ui.tex_ExpProgress:SetIndex(0, tostring(curExp), tostring(totalExp))
    self.ui.tex_ExpProgress.gameObject:SetActive(true)
  elseif levelData.curLevel > levelData.level then
    self.ui.tex_ExpProgress.gameObject:SetActive(false)
    self.ui.img_ExpProgress.fillAmount = 1
  else
    self.ui.tex_ExpProgress.gameObject:SetActive(false)
    self.ui.img_ExpProgress.fillAmount = 0
  end
  self.ui.obj_Exp:SetActive(showExpBar)
end

function UINCarnivalLevelItem:_UpdUnlock(levelData)
  local hasUnlock = true
  local levelEnvDic = ConfigData.activity_carnival_env.levelEnvDic[self._carnivalData:GetActId()]
  if levelData.carnivalExpCfg.unlock_story > 0 then
    local storyCfg = ConfigData.story_avg[levelData.carnivalExpCfg.unlock_story]
    self.ui.obj_StoryIcon:SetActive(true)
    self.ui.tex_Name.text = LanguageUtil.GetLocaleText(storyCfg.name)
    self.ui.tex_Number:SetIndex(0, tostring(storyCfg.number))
    self.ui.tex_Title:SetIndex(0)
  elseif 0 < levelData.carnivalExpCfg.unlock_sector_stage then
    local stageCfg = ConfigData.sector_stage[levelData.carnivalExpCfg.unlock_sector_stage]
    self.ui.obj_StoryIcon:SetActive(true)
    self.ui.tex_Name.text = LanguageUtil.GetLocaleText(stageCfg.name)
    self.ui.tex_Number:SetIndex(0, tostring(stageCfg.num))
    self.ui.tex_Title:SetIndex(0)
  elseif levelEnvDic[levelData.level] ~= nil then
    local envCfg = self._carnivalData:GetCarnivalEnvCfgById(levelEnvDic[levelData.level])
    self.ui.obj_StoryIcon:SetActive(false)
    self.ui.tex_Name.text = LanguageUtil.GetLocaleText(envCfg.env_name)
    self.ui.tex_Number:SetIndex(1, tostring(envCfg.id))
    self.ui.tex_Title:SetIndex(1)
  else
    hasUnlock = false
  end
  self.ui.obj_Unlock:SetActive(hasUnlock)
end

function UINCarnivalLevelItem:_OnClickPickReward()
  if self._pickable and self._pickRewardFunc ~= nil then
    self._pickRewardFunc(self._levelData.level)
  end
end

function UINCarnivalLevelItem:OnClickJump()
  if self._jumpFunc ~= nil then
    self._jumpFunc(self._levelData)
  end
end

function UINCarnivalLevelItem:OnDelete()
  self.rewardItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINCarnivalLevelItem

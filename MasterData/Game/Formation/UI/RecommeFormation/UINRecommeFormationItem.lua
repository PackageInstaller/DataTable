local UINRecommeFormationItem = class("UINRecommeFormationItem", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadWithStarItem = require("Game.CommonUI.Hero.UINHeroHeadWithStarItem")
local UINCommanderSkill = require("Game.Formation.UI.2DFormation.UINCommanderSkill")
local eFriendEnum = require("Game.Friend.eFriendEnum")
local CS_MessageCommon = CS.MessageCommon

function UINRecommeFormationItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.obj_HeroHead:SetActive(false)
  self.ui.obj_EmptyHero:SetActive(false)
  self.ui.skillItem:SetActive(false)
  self.skillIconPool = UIItemPool.New(UINCommanderSkill, self.ui.skillItem)
  self.heroHeadPool = UIItemPool.New(UINHeroHeadWithStarItem, self.ui.obj_HeroHead)
  self.emptyIconList = {}
  UIUtil.AddButtonListener(self.ui.btn_Use, self, self.OnClickCopy)
  UIUtil.AddButtonListener(self.ui.btn_ViewChip, self, self.OnClickLookChip)
  UIUtil.AddButtonListener(self.ui.btn_OpenUserInfo, self, self.OnClickOpenUserInfo)
end

function UINRecommeFormationItem:InitRecommeItem(recommeCtr, data, isOpenCopy, recordInfo, resloader)
  self.recommeCtr = recommeCtr
  self.data = data
  self.resloader = resloader
  local isSupportChip = recordInfo.recommeSupoortChip
  self.ui.tex_UserName.text = self.data.playerName
  self.ui.tex_MainTeamPower.text = tostring(self.data.firstPower)
  self.ui.tex_BenchTeamPower.text = tostring(self.data.benchPower)
  local isAllow = data:IsAllowCopy()
  self.ui.img_Use.color = isAllow and self.ui.colorNorImg or self.ui.colorGrayImg
  self.ui.text_Use.color = isAllow and self.ui.colorNorText or self.ui.colorGrayText
  if self.data:IsRecommeFixedSkill() then
    self.ui.tex_ComSkillName:SetIndex(0)
  else
    self.ui.tex_ComSkillName:SetIndex(1, LanguageUtil.GetLocaleText(self.data.treeCfg.name))
  end
  self.skillIconPool:HideAll()
  for i = 1, #self.data.slotSkillList do
    local skillId = self.data.slotSkillList[i]
    if skillId ~= nil and 0 < skillId then
      local item = self.skillIconPool:GetOne()
      item:InitCommanderSkill(skillId, self.resloader)
    end
  end
  local stageCount = recordInfo:GetRecommeMaxStageNum()
  local allCount = stageCount + recordInfo:GetRecommeMaxBenchNum()
  self.heroHeadPool:HideAll()
  for i = 1, #self.emptyIconList do
    self.emptyIconList[i]:SetActive(false)
  end
  local emptyIndex = self:__RefreshHeroIcon(1, self.ui.mainTeam, 1, stageCount)
  self:__RefreshHeroIcon(emptyIndex, self.ui.benchTeam, stageCount + 1, allCount)
  local isEmptyChip = self.data.chipList == nil or 0 >= #self.data.chipList
  self.ui.canvasGroup_ViewChip.alpha = isEmptyChip and self.ui.float_chipEmptyAlpha or 1
  self.ui.obj_EmptyChip:SetActive(not isSupportChip)
  self.ui.btn_Use.gameObject:SetActive(isOpenCopy)
  self.ui.btn_ViewChip.gameObject:SetActive(isSupportChip)
end

function UINRecommeFormationItem:__RefreshHeroIcon(emptyIndex, parentTr, startIndex, endIndex)
  for i = startIndex, endIndex do
    local recommanHeroInfo = self.data.recommanHeroDic[i]
    if recommanHeroInfo ~= nil then
      local item = self.heroHeadPool:GetOne()
      local isHas = PlayerDataCenter.heroDic[recommanHeroInfo.basic.dataId] ~= nil
      local isMvp = recommanHeroInfo.basic.dataId == self.data.mvpHeroId
      item:InitHead(recommanHeroInfo.basic, isHas, isMvp)
      item.gameObject.transform:SetParent(parentTr)
      item.gameObject.transform:SetAsLastSibling()
    else
      local emptyIcon
      if emptyIndex <= #self.emptyIconList then
        emptyIcon = self.emptyIconList[emptyIndex]
      else
        emptyIcon = self.ui.obj_EmptyHero:Instantiate()
        table.insert(self.emptyIconList, emptyIcon)
      end
      emptyIndex = emptyIndex + 1
      emptyIcon:SetActive(true)
      emptyIcon.transform:SetParent(parentTr)
      emptyIcon.transform:SetAsLastSibling()
    end
  end
  return emptyIndex
end

function UINRecommeFormationItem:OnClickCopy()
  if self.data:IsAllowCopy() then
    local showingWindow = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    showingWindow:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(TipContent.Recomme_Confirm), function()
      UIUtil.OnClickBackByUiTab(self)
      self.recommeCtr:ExitRecommeFormation(self.data)
    end, nil)
  else
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Recomme_Fail))
  end
end

function UINRecommeFormationItem:OnClickLookChip()
  if self.data.chipList == nil or #self.data.chipList <= 0 then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Recomme_ChipEmpty))
    return
  end
  PlayerClickCollectManager:BtnClickNumCollect(1001)
  UIManager:ShowWindowAsync(UIWindowTypeID.ViewChips, function(windows)
    if windows ~= nil then
      windows.transform:SetAsLastSibling()
      if self.data.chipList ~= nil then
        windows:InitChips(self.data.chipList, self.resloader)
        windows:SetViewChipsCloseCallback(function()
          UIUtil.ReShowTopStatus()
        end)
        UIUtil.HideTopStatus()
      end
    end
  end)
end

function UINRecommeFormationItem:OnClickOpenUserInfo()
  PlayerDataCenter:GetUserInfoByUID(self.data.playerId, function(userInfoData)
    if userInfoData == nil then
      return
    end
    local oringLayoutLevel = UIWindowGlobalConfig[UIWindowTypeID.CommonUserInfo].LayoutLevel
    UIWindowGlobalConfig[UIWindowTypeID.CommonUserInfo].LayoutLevel = UIWindowGlobalConfig[UIWindowTypeID.RecommeFormation].LayoutLevel
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonUserInfo, function(win)
      if win == nil then
        return
      end
      win:InitUserInfoView(userInfoData, eFriendEnum.eFriendApplyWay.Rank)
      UIWindowGlobalConfig[UIWindowTypeID.CommonUserInfo].LayoutLevel = oringLayoutLevel
    end)
  end)
end

return UINRecommeFormationItem

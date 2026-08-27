local UIFairyNotice = class("UIFairyNotice", UIBaseWindow)
local base = UIBaseWindow
local cs_resloader = CS.ResLoader
local UINFairyNoticeSkillGroup = require("Game.Fairy.UI.Notice.UINFairyNoticeSkillGroup")
local UINCommonStars = require("Game.Fairy.UI.UINCommonStars")
local UINFairyUpgradeTipItem = require("Game.Fairy.UI.UINFairyUpgradeTipItem")

function UIFairyNotice:OnInit()
  UIUtil.SetTopStatus(self, self.Delete, nil, nil, nil, true)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Upgrade, self, self._OnClickUpgrade)
  self.resloader = cs_resloader.Create()
  self.commonStars = UINCommonStars.New()
  self.commonStars:Init(self.ui.stars)
  self.upgradeTipItemPool = UIItemPool.New(UINFairyUpgradeTipItem, self.ui.obj_tipItem, false)
  self.fairyNoticeSkillGroup = UINFairyNoticeSkillGroup.New()
  self.fairyNoticeSkillGroup:Init(self.ui.obj_skillGroup)
end

function UIFairyNotice:SetSkillList(skillList, orginSkillList)
  self.skillList = skillList
  self.orginSkillList = orginSkillList
end

function UIFairyNotice:SetFyNoticeStarFrom(startStar)
  self._startStar = startStar
end

function UIFairyNotice:InitFairyNotice(fairyData, isSkillReset, isPreview, confirmFunc)
  self.fairyData = fairyData
  self.isSkillReset = isSkillReset
  self.isPreview = isPreview
  self.confirmFunc = confirmFunc
  if isSkillReset then
    self.ui.obj_topUpgradeFrame:SetActive(false)
  else
    self.ui.obj_topUpgradeFrame:SetActive(true)
    self:RefreshTopFrame()
  end
  self.fairyNoticeSkillGroup:SetSkillList(self.skillList, self.orginSkillList)
  self.fairyNoticeSkillGroup:InitFairyNoticeSkillGroup(self.fairyData, self.resloader, self.isPreview, self.isSkillReset, self._startStar)
  self:RefreshBtnUIShow()
end

function UIFairyNotice:RefreshBtnUIShow()
  if self.isPreview then
    self.ui.btn_Upgrade.gameObject:SetActive(true)
    self.ui.btn_Cancel.gameObject:SetActive(true)
    self.ui.btn_Confirm.gameObject:SetActive(false)
    self.ui.tex_Text:SetIndex(self.isSkillReset and 1 or 0)
    self.ui.tex_Title:SetIndex(self.isSkillReset and 0 or 2)
    self.ui.obj_fx:SetActive(false)
    self.ui.obj_mask:SetActive(false)
  else
    self.ui.btn_Upgrade.gameObject:SetActive(false)
    self.ui.btn_Cancel.gameObject:SetActive(false)
    self.ui.btn_Confirm.gameObject:SetActive(true)
    self.ui.tex_Title:SetIndex(self.isSkillReset and 1 or 3)
    self.ui.obj_fx:SetActive(true)
    self.ui.obj_mask:SetActive(true)
  end
end

function UIFairyNotice:RefreshTopFrame()
  local starNum = self.fairyData:GetFairyCurStar()
  if self.isPreview then
    starNum = starNum + 1
  end
  self.commonStars:RefreshStarsByNum(starNum)
  self.upgradeTipItemPool:HideAll()
  local fromLevel
  if self._startStar ~= nil then
    fromLevel = self.fairyData:GetFyStarMaxLevel(self._startStar)
  end
  local tipOne = self.upgradeTipItemPool:GetOne(true)
  tipOne:InitFairyUpgradeTipItem(0, self.fairyData, not self.isPreview, fromLevel)
  local nowSkillNum = not self.isPreview and self.fairyData:GetLastMaxSkillNum() or self.fairyData:GetMaxSkillNum()
  if self._startStar ~= nil then
    nowSkillNum = self.fairyData:GetFyStarSkillNum(self._startStar)
  end
  local nextSkillNum = not self.isPreview and self.fairyData:GetMaxSkillNum() or self.fairyData:GetNextMaxSkillNum()
  if nowSkillNum < nextSkillNum then
    local tipTow = self.upgradeTipItemPool:GetOne(true)
    tipTow:InitFairyUpgradeTipItem(1, self.fairyData)
    local addSkillNum = nextSkillNum - nowSkillNum
    tipTow:InitFairyUpgradeTipItem(1, nil, nil, nil, addSkillNum)
  end
end

function UIFairyNotice:_OnClickUpgrade()
  local function Confirm()
    if self.confirmFunc then
      self.confirmFunc()
      
      self:_OnClickClose()
    end
  end
  
  if self.fairyNoticeSkillGroup.isBelow then
    CS.MessageCommon.ShowMessageBox(ConfigData:GetTipContent(22016), Confirm, nil)
  else
    Confirm()
  end
end

function UIFairyNotice:_OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIFairyNotice:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.commonStars:Delete()
  self.fairyNoticeSkillGroup:Delete()
  self.upgradeTipItemPool:HideAll()
  base.OnDelete(self)
end

return UIFairyNotice

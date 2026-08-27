local UINUserInfoSupportHeroNode = class("UINUserInfoSupportHeroNode", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadWithStarItem = require("Game.CommonUI.Hero.UINHeroHeadWithStarItem")
local FriendSupportHeroData = require("Game.Formation.Data.FriendSupportHeroData")
local cs_MessageCommon = CS.MessageCommon

function UINUserInfoSupportHeroNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._onClickAddSupport = BindCallback(self, self.OnClickAddSupport)
  UIUtil.AddButtonListener(self.ui.btn_AddSupport, self, self.OnClickAddSupport)
  UIUtil.AddButtonListener(self.ui.btn_Empty, self, self.OnClickEmpty)
  self.headItem = UINHeroHeadWithStarItem.New()
  self.headItem:Init(self.ui.obj_HeroHeadItem)
  self._refreshAll = BindCallback(self, self.RefreshAll)
end

function UINUserInfoSupportHeroNode:InitSupportHero(index, userInfoData, resLoader, couldEditSelf)
  self.index = index
  self.userInfoData = userInfoData
  self.resLoader = resLoader
  self.supportHeroInfo = userInfoData:GetSupportHoreInfoList()[index]
  self.isSelf = userInfoData:GetIsSelfUserInfo()
  self.supportHoreIdDic = userInfoData:GetSupportHoreIdDic()
  self.couldEditSelf = couldEditSelf
  self.isEmpty = self.supportHeroInfo == false or self.supportHeroInfo.assistsBrief.id == 0
  local unlockCfg = ConfigData.support_count[index]
  local isUnlock = CheckCondition.CheckLua(unlockCfg.pre_condition, unlockCfg.pre_para1, unlockCfg.pre_para2)
  if isUnlock then
    self.ui.btn_Empty.gameObject:SetActive(self.isEmpty and not self.isSelf)
    self.ui.btn_AddSupport.gameObject:SetActive(self.isEmpty and self.isSelf)
    self.ui.obj_Normal:SetActive(not self.isEmpty)
  else
    self.ui.btn_Empty.gameObject:SetActive(true)
    self.ui.btn_AddSupport.gameObject:SetActive(false)
    self.ui.obj_Normal:SetActive(false)
  end
  self:RefreshSupportHero()
end

function UINUserInfoSupportHeroNode:RefreshSupportHero()
  if self.isEmpty then
    return
  end
  local heroData
  if self.isSelf then
    if not self.supportHeroInfo then
      return
    end
    heroData = PlayerDataCenter.heroDic[self.supportHeroInfo.assistsBrief.id]
  else
    if not self.supportHeroInfo then
      return
    end
    heroData = FriendSupportHeroData.GenSupportHeroData(self.userInfoData, self.supportHeroInfo.assistsBrief.id)
  end
  self.ui.tex_HeroName.text = heroData:GetHeroName(true)
  self.ui.tex_Power.text = tostring(heroData:GetFightingPower())
  self.headItem:InitHead(heroData, nil, nil, self._onClickAddSupport)
end

function UINUserInfoSupportHeroNode:OnClickAddSupport()
  if not self.userInfoData:GetIsSelfUserInfo() or not self.couldEditSelf then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.UserInfoSelectSupport, function(win)
    if win ~= nil then
      if self.isEmpty then
        win:InitSelectSupportHero(self.index, nil, self.userInfoData:GetSupportHoreIdDic(), self._refreshAll)
      else
        win:InitSelectSupportHero(self.index, self.supportHeroInfo.assistsBrief.id, self.userInfoData:GetSupportHoreIdDic(), self._refreshAll)
      end
    end
  end)
end

function UINUserInfoSupportHeroNode:OnClickEmpty()
  if not self.isSelf then
    return
  end
  local unlockCfg = ConfigData.support_count[self.index]
  local unlockInfo = CheckCondition.GetUnlockInfoLua(unlockCfg.pre_condition, unlockCfg.pre_para1, unlockCfg.pre_para2)
  cs_MessageCommon.ShowMessageTips(unlockInfo)
end

function UINUserInfoSupportHeroNode:RefreshAll()
  self:InitSupportHero(self.index, self.userInfoData, self.resLoader, self.couldEditSelf)
end

function UINUserInfoSupportHeroNode:OnDelete()
  base.OnDelete(self)
end

return UINUserInfoSupportHeroNode

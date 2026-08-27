local UINHeroListFavorHeroNode = class("UINHeroListFavorHeroNode", UIBaseNode)
local base = UIBaseNode
local HeroListStateEnum = require("Game.Hero.NewUI.HeroListStateEnum")

function UINHeroListFavorHeroNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_FollowHero, self, self.__OnFavorHeroTogChange)
  UIUtil.AddButtonListener(self.ui.btn_BatchFollow, self, self.__OnClickEditFavor)
  UIUtil.AddButtonListener(self.ui.buttonYes, self, self.__OnClickEditYes)
  UIUtil.AddButtonListener(self.ui.buttonNo, self, self.__OnClickEditNo)
  if CS.ClientConsts.IsAudit then
    self.ui.tog_FollowHero.gameObject:SetActive(false)
  end
end

function UINHeroListFavorHeroNode:InitFavorHeroNode(newUIHeroList)
  self.newUIHeroList = newUIHeroList
end

function UINHeroListFavorHeroNode:OnHeroListFlageChange(flag)
  local isShowFavor = HeroListStateEnum.isHaveFlag(flag, HeroListStateEnum.eHeroListFlag.showFavor)
  local isEditorFavor = HeroListStateEnum.isHaveFlag(flag, HeroListStateEnum.eHeroListFlag.editorFavor)
  local showFavorBg = isShowFavor or isEditorFavor
  self.ui.img_FavorBg:SetActive(showFavorBg)
  local isShowEmpty = #self.newUIHeroList.heroSortList.curHeroList <= 0
  self.ui.img_FollowEmpty:SetActive(isShowEmpty)
  self.ui.tex_Empty:SetIndex(isShowFavor and 0 or 1)
  self.ui.btn_BatchFollow.gameObject:SetActive(isShowFavor and not isEditorFavor)
  self.ui.yesNoNode:SetActive(isEditorFavor)
end

function UINHeroListFavorHeroNode:__OnFavorHeroTogChange(bool)
  if bool then
    if PlayerDataCenter.favorHeroData == nil then
      error("can't get favorHeroData")
      return
    end
    self.newUIHeroList:ChangeHeroListFlage(true, HeroListStateEnum.eHeroListFlag.showFavor)
  else
    if PlayerDataCenter.favorHeroData ~= nil then
      PlayerDataCenter.favorHeroData:CleanFavorHeroBuffDic()
    end
    self.newUIHeroList:ChangeHeroListFlage(false, HeroListStateEnum.eHeroListFlag.showFavor | HeroListStateEnum.eHeroListFlag.editorFavor)
    self.newUIHeroList.heroSortList:SetAllFavorHero()
  end
end

function UINHeroListFavorHeroNode:__OnClickEditFavor()
  self.newUIHeroList:ChangeHeroListFlage(true, HeroListStateEnum.eHeroListFlag.editorFavor)
  self.newUIHeroList.heroSortList:SetAllFavorHero()
end

function UINHeroListFavorHeroNode:__OnClickEditYes()
  PlayerDataCenter.favorHeroData:ApplyFavorHeroBuffDic()
  PlayerDataCenter.favorHeroData:CleanFavorHeroBuffDic()
  self.newUIHeroList:ChangeHeroListFlage(false, HeroListStateEnum.eHeroListFlag.editorFavor)
  self.newUIHeroList.heroSortList:SetAllFavorHero()
end

function UINHeroListFavorHeroNode:__OnClickEditNo()
  PlayerDataCenter.favorHeroData:CleanFavorHeroBuffDic()
  self.newUIHeroList:ChangeHeroListFlage(false, HeroListStateEnum.eHeroListFlag.editorFavor)
  self.newUIHeroList.heroSortList:SetAllFavorHero()
end

function UINHeroListFavorHeroNode:OnDelete()
  base.OnDelete(self)
end

return UINHeroListFavorHeroNode

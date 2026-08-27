local UINEpCampFetter = class("UINEpCampFetter", UIBaseNode)
local base = UIBaseNode
local UINEpCampFetterSkillItem = require("Game.Exploration.UI.CampFetter.UINEpCampFetterSkillItem")
local UINEpCampFetterDetailCampItem = require("Game.Exploration.UI.CampFetter.UINEpCampFetterDetailCampItem")

function UINEpCampFetter:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_CampBondSkill, self, self.__OnClickActiveCampFetter)
  UIUtil.AddButtonListener(self.ui.btn_CampBond, self, self.__ShowAllCampFetterDetail)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.__CloseAllCampFetterDetail)
  self.fetterSkillItemPool = UIItemPool.New(UINEpCampFetterSkillItem, self.ui.obj_effItem)
  self.ui.obj_effItem:SetActive(false)
  self.detailCampItemPool = UIItemPool.New(UINEpCampFetterDetailCampItem, self.ui.obj_campItem)
  self.ui.obj_campItem:SetActive(false)
  self:__CloseAllCampFetterDetail()
end

function UINEpCampFetter:InitEpCampFetter(resLoader)
  self.resLoader = resLoader
end

function UINEpCampFetter:RefreshAllCampFetter(usingCampFetterList, totalUsingNum, resLoader)
  local hasFetterSkill = 0 < totalUsingNum
  self.ui.obj_campFetterlist:SetActive(hasFetterSkill)
  self.ui.obj_empty:SetActive(not hasFetterSkill)
  if hasFetterSkill then
    local isFirst = true
    self.fetterSkillItemPool:HideAll()
    self.detailCampItemPool:HideAll()
    for _, campFetterDatas in ipairs(usingCampFetterList) do
      for _, fetterData in ipairs(campFetterDatas.campFetterList) do
        if fetterData.isUsing then
          local item = self.fetterSkillItemPool:GetOne()
          item:InitEpCampFetterSkillItem(fetterData.cfg, isFirst, self.resLoader)
          isFirst = false
        end
      end
      local item = self.detailCampItemPool:GetOne()
      item:InitDetailCampItem(campFetterDatas, self.resLoader)
    end
  end
end

function UINEpCampFetter:__ShowAllCampFetterDetail()
  if ExplorationManager.epCtrl == nil or not ExplorationManager.epCtrl.campFetterCtrl:IsHaveCampFetter() then
    return
  end
  self.ui.obj_bondEff:SetActive(true)
  self.ui.btn_Close.gameObject:SetActive(true)
end

function UINEpCampFetter:__CloseAllCampFetterDetail()
  self.ui.obj_bondEff:SetActive(false)
  self.ui.btn_Close.gameObject:SetActive(false)
end

function UINEpCampFetter:SetHasEpActiveCampFetter(hasEpActive)
  self.ui.obj_btn_CampBondSkill:SetActive(hasEpActive)
end

function UINEpCampFetter:SetActiveCampFetter(campId, heroNum, couldUse, cdStr)
  if couldUse then
    self.ui.img_btn_CampBondSkill:SetIndex(0)
    local campFetterCfg = ConfigData.camp_connection[campId][heroNum]
    self.ui.img_CampFetterIcon.sprite = AtlasUtil.GetSpriteFromAtlas(UIAtlasConsts.Atlas_CampFetterIcon, campFetterCfg.icon, self.resLoader)
    self.ui.tex_campFetterName:SetIndex(0, LanguageUtil.GetLocaleText(campFetterCfg.name))
    self.ui.tex_subText:SetIndex(0, LanguageUtil.GetLocaleText(ConfigData.camp[campId].name))
  else
    self.ui.img_btn_CampBondSkill:SetIndex(1)
    local campFetterCfg = ConfigData.camp_connection[campId][heroNum]
    self.ui.img_CampFetterIcon.sprite = AtlasUtil.GetSpriteFromAtlas(UIAtlasConsts.Atlas_CampFetterIcon, campFetterCfg.icon, self.resLoader)
    self.ui.tex_campFetterName:SetIndex(1)
    self.ui.tex_subText:SetIndex(1, cdStr)
  end
end

function UINEpCampFetter:SetClickActiveCampFetter(useCampFetterCallback)
  self.useCampFetterCallback = useCampFetterCallback
end

function UINEpCampFetter:__OnClickActiveCampFetter()
  if self.useCampFetterCallback ~= nil then
    self.useCampFetterCallback()
  end
end

function UINEpCampFetter:OnDelete()
  base.OnDelete(self)
end

return UINEpCampFetter

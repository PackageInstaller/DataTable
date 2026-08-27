local UINFmtCampFetterItem = class("UINFmtCampFetterItem", UIBaseNode)
local base = UIBaseNode
local UINFmtCampFetterSkillItem = require("Game.Formation.UI.2DFormation.UINFmtCampFetterSkillItem")

function UINFmtCampFetterItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.bondEffItem:SetActive(false)
  self.FetterSkillItemPool = UIItemPool.New(UINFmtCampFetterSkillItem, self.ui.bondEffItem)
  UIUtil.AddButtonListener(self.ui.btn_campItem, self, self.__OnClick)
end

function UINFmtCampFetterItem:InitFmtCampFetterItem(campId, count, resloader, clickCallback)
  self.gameObject.name = tostring(campId)
  self.campId = campId
  self.clickCallback = clickCallback
  local campCfg = ConfigData.camp[campId]
  self.ui.img_CampIcon.sprite = CRH:GetSprite(campCfg.icon, CommonAtlasType.CareerCamp)
  self.ui.tex_HeroCount.text = tostring(count)
  local campFetterList = ConfigData.camp_connection.fetterList[campId]
  self.FetterSkillItemPool:HideAll()
  for index, neededHeroCount in ipairs(campFetterList) do
    if neededHeroCount <= count then
      local skillItem = self.FetterSkillItemPool:GetOne()
      local campFetterCfg = ConfigData.camp_connection[campId][neededHeroCount]
      skillItem:InitFetterSkillItem(campFetterCfg, index == 1, resloader)
    end
  end
end

function UINFmtCampFetterItem:__OnClick()
  if self.clickCallback ~= nil then
    self.clickCallback(self.campId)
  end
end

function UINFmtCampFetterItem:OnDelete()
  base.OnDelete(self)
end

return UINFmtCampFetterItem

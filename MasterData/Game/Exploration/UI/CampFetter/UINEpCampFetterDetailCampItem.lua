local UINEpCampFetterDetailCampItem = class("UINEpCampFetterDetailCampItem", UIBaseNode)
local base = UIBaseNode
local UINEpCampFetterDetailSkillItem = require("Game.Exploration.UI.CampFetter.UINEpCampFetterDetailSkillItem")

function UINEpCampFetterDetailCampItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.detailCampItemPool = UIItemPool.New(UINEpCampFetterDetailSkillItem, self.ui.obj_bondEffDetailItem)
  self.ui.obj_bondEffDetailItem:SetActive(false)
end

function UINEpCampFetterDetailCampItem:InitDetailCampItem(campFetterDatas, resloader)
  local campId = campFetterDatas.campId
  local campFetterList = campFetterDatas.campFetterList
  local campHeroCount = campFetterDatas.campHeroCount
  self.ui.tex_CampName.text = LanguageUtil.GetLocaleText(ConfigData.camp[campId].name)
  self.ui.tex_HeroCount:SetIndex(0, tostring(campHeroCount))
  self.detailCampItemPool:HideAll()
  for index, fetterData in ipairs(campFetterList) do
    if fetterData.isUsing then
      local item = self.detailCampItemPool:GetOne()
      item:InitDetailSkillItem(fetterData.cfg, resloader)
    end
  end
end

function UINEpCampFetterDetailCampItem:OnDelete()
  base.OnDelete(self)
end

return UINEpCampFetterDetailCampItem

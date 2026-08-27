local UINFairySkillDetailsDown = class("UINFairySkillDetailsDown", UIBaseNode)
local base = UIBaseNode
local UINFairySkillDownItem = require("Game.Fairy.UI.SkillDetails.UINFairySkillDownItem")
local FairySkillData = require("Game.Fairy.Data.FairySkillData")
local SkillButtonEnum = {Special = 1, Common = 2}

function UINFairySkillDetailsDown:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_skill1, self, self._OnClickSpecialSkillTog)
  UIUtil.AddButtonListener(self.ui.btn_skill2, self, self._OnClickCommonSkillTog)
  self.skillDownItemPool = UIItemPool.New(UINFairySkillDownItem, self.ui.obj_downItem, false)
end

function UINFairySkillDetailsDown:InitFairySkillDetailsDown(fairyData, resloader)
  self.fairyData = fairyData
  self.resloader = resloader
  self.flag = SkillButtonEnum.Special
  self:InitFairyFakeData()
  self:RefreshFairyDownSkill()
end

function UINFairySkillDetailsDown:InitFairyFakeData()
  self.skillSpecialDataList = {}
  self.skillCommonDataList = {}
  local poolId = ConfigData.fairy_data[self.fairyData:GetFairyID()].skill_list
  local skillIdList = ConfigData.fairy_skill.poolId2SkillId[poolId]
  for i, id in ipairs(skillIdList) do
    local data = FairySkillData.GenFairyFakeData(id)
    if data:IsUniqueSkill() then
      table.insert(self.skillSpecialDataList, data)
    else
      table.insert(self.skillCommonDataList, data)
    end
  end
end

function UINFairySkillDetailsDown:RefreshFairyDownSkill()
  self.skillDownItemPool:HideAll()
  local nowList = self.flag == SkillButtonEnum.Special and self.skillSpecialDataList or self.skillCommonDataList
  for i, data in pairs(nowList) do
    local item = self.skillDownItemPool:GetOne()
    item:InitFairySkillDownItem(data, self.resloader)
  end
end

function UINFairySkillDetailsDown:_OnClickSpecialSkillTog()
  if self.flag == SkillButtonEnum.Special then
    return
  end
  self.flag = SkillButtonEnum.Special
  self.ui.img_skill1.color = self.ui.col_selected
  self.ui.img_skill2.color = self.ui.col_dark
  self:RefreshFairyDownSkill()
end

function UINFairySkillDetailsDown:_OnClickCommonSkillTog()
  if self.flag == SkillButtonEnum.Common then
    return
  end
  self.flag = SkillButtonEnum.Common
  self.ui.img_skill1.color = self.ui.col_dark
  self.ui.img_skill2.color = self.ui.col_selected
  self:RefreshFairyDownSkill()
end

function UINFairySkillDetailsDown:OnDelete()
  self.skillDownItemPool:HideAll()
  self.skillSpecialDataList = nil
  self.skillCommonDataList = nil
end

return UINFairySkillDetailsDown

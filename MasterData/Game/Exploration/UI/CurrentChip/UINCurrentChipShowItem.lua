local UINCurrentChipShowItem = class("UINCurrentChipShowItem", UIBaseNode)
local base = UIBaseNode
local UINDungeonInfoChipDetailTag = require("Game.CommonUI.DungeonState.Info.UINDungeonInfoChipDetailTag")
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")

function UINCurrentChipShowItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.tagPool = UIItemPool.New(UINDungeonInfoChipDetailTag, self.ui.obj_tagItem)
  self.ui.obj_tagItem:SetActive(false)
  self.chipItem = UINChipItem.New()
  self.chipItem:Init(self.ui.uINChipItem)
  UIUtil.AddButtonListener(self.ui.btn_Intro, self, self.OnClickIntro)
end

function UINCurrentChipShowItem:InitChipShow(chipData, ShowRichIntroFunc)
  self.chipData = chipData
  self.ShowRichIntroFunc = ShowRichIntroFunc
  local qualityColor = ItemQualityColor[chipData:GetQuality()]
  self.tagPool:HideAll()
  local tagId = self.chipData.chipCfg.fun_tag
  if tagId ~= 0 then
    local chipTagCfg = ConfigData.chip_tag[tagId]
    local item = self.tagPool:GetOne(true)
    item:InitTagItem(chipTagCfg, qualityColor)
  end
  for i, v in ipairs(self.ui.img_arr) do
    v.color = qualityColor
  end
  self.ui.tex_Description.text = self.chipData:GetChipDescription()
  self.ui.tex_name.text = self.chipData:GetName()
  self.chipItem:InitChipItem(chipData, false, nil, true)
  local tab = {}
  if 0 < #self.chipData.chipCfg.skill_list then
    local skillId = self.chipData.chipCfg.skill_list[1]
    local labelDic = ConfigData.battle_skill.skill_label_Dic[skillId]
    if labelDic ~= nil then
      for id, unlockLevel in pairs(labelDic) do
        table.insert(tab, id)
      end
    end
  end
  self.uiIntroData = {}
  self.uiIntroData.skillLabeIdList = tab
  self.ui.btn_Intro.gameObject:SetActive(0 < #tab)
end

function UINCurrentChipShowItem:OnClickIntro()
  if #self.uiIntroData.skillLabeIdList <= 0 then
    return
  end
  if self.ShowRichIntroFunc ~= nil then
    self.ShowRichIntroFunc(self)
  end
end

return UINCurrentChipShowItem

local base = UIBaseWindow
local UICharDunNormalQuest = class("UICharDunNormalQuest", base)
local HeroGrowV3Enum = require("Game.ActivityHeroGrowV3.Data.HeroGrowV3Enum")
local UINCharDunNormalQuestItem = require("Game.ActivityHeroGrowV3.UI.Normal.UINCharDunNormalQuestItem")

function UICharDunNormalQuest:OnInit()
  UIUtil.SetTopStatus(self, self.__OnClickClose)
  self.__onClickQuest = BindCallback(self, self.__OnClickQuest)
  self.questItem1 = UINCharDunNormalQuestItem.New()
  self.questItem1:Init(self.ui.QuestItem)
  self.questItem2 = UINCharDunNormalQuestItem.New()
  self.questItem2:Init(self.ui.QuestItem2)
end

function UICharDunNormalQuest:InitHGV3NormalQuest(heroGrowV3Data, lastNormalType, backFunc)
  self.heroGrowV3Data = heroGrowV3Data
  self.backFunc = backFunc
  self:__Refresh()
  if lastNormalType ~= nil then
    local normalDtaDic = self.heroGrowV3Data:GetGetHGV3NormalDataDic()
    local openNormalData = normalDtaDic[lastNormalType]
    self:__OnClickQuest(openNormalData)
  end
end

function UICharDunNormalQuest:__Refresh()
  self.ui.Tex_Title.text = self.heroGrowV3Data:GetHGV3NormalName()
  local decoColor = self.heroGrowV3Data:GetHGV3DecoColor()
  for _, colorComp in pairs(self.ui.color_array) do
    colorComp.color = decoColor
  end
  local normalDtaDic = self.heroGrowV3Data:GetGetHGV3NormalDataDic()
  local decoColor = self.heroGrowV3Data:GetHGV3DecoColor()
  self.questItem1:InitHGV3NormalQuestItem(normalDtaDic[HeroGrowV3Enum.HGV3NormalQuestType.officialTeam], decoColor, self.__onClickQuest)
  self.questItem2:InitHGV3NormalQuestItem(normalDtaDic[HeroGrowV3Enum.HGV3NormalQuestType.freeTeam], decoColor, self.__onClickQuest)
end

function UICharDunNormalQuest:__OnClickQuest(normalData)
  UIManager:ShowWindowAsync(UIWindowTypeID.CahrDunVer3NormalMap, function(win)
    if win == nil then
      return
    end
    win:InitCharDunNormalQuestMap(self.heroGrowV3Data, normalData)
  end)
end

function UICharDunNormalQuest:__OnClickClose()
  if self.backFunc then
    self.backFunc()
  end
  self:Delete()
end

function UICharDunNormalQuest:OnDelete()
  base.OnDelete(self)
end

return UICharDunNormalQuest

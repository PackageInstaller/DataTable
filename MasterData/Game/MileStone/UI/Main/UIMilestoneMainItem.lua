local UIMilestoneMainItem = class("UIMilestoneMainItem", UIBaseNode)
local base = UIBaseNode
local MilestoneUtil = require("Game.MileStone.MilestoneUtil")

function UIMilestoneMainItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_click, self, self.__OnClick)
end

function UIMilestoneMainItem:InitMilestoneMainItem(MSDData, resloader, clickFunc)
  self.MSDData = MSDData
  self.clickFunc = clickFunc
  self.ui.text_nameEN.text = self.MSDData:GetMlstDimensionNameEn()
  self.ui.tex_Title.text = self.MSDData:GetMlstDimensionName()
  self.ui.img_icon.sprite = AtlasUtil.GetSpriteFromAtlas("Milestone", self.MSDData:GetMlstDimensionIcon(), resloader)
  self:RefreshMilestoneMainItem()
end

function UIMilestoneMainItem:RefreshMilestoneMainItem()
  local stage = self.MSDData:GetMlstDimensionStage()
  local stageChar = MilestoneUtil.GetSPSStageId2EngChar(stage)
  local score = self.MSDData:GetMlstDimensionScore()
  local curScore = self.MSDData:GetMlstDimensionScore()
  local curScoreMax = self.MSDData:GetMlstDimensionScoreMax()
  local rate
  if curScoreMax == 0 then
    rate = 1
  else
    rate = math.clamp(curScore / curScoreMax, 0, 1)
  end
  self.ui.tex_Percent.text = tostring(math.floor(rate * 100)) .. "%"
  self.ui.tex_Class.text = stageChar
end

function UIMilestoneMainItem:__OnClick()
  if self.clickFunc ~= nil then
    local msModuleId = self.MSDData:GetMlstDimensionId()
    self.clickFunc(msModuleId)
  end
end

function UIMilestoneMainItem:ShowMilestoneMainItemBlueDot(show)
  self.ui.blueDot:SetActive(show)
  if show then
    self.ui.img_bottom.color = self.ui.color_bluedot
  else
    self.ui.img_bottom.color = self.ui.color_normal
  end
end

function UIMilestoneMainItem:OnDelete()
  base.OnDelete(self)
end

return UIMilestoneMainItem

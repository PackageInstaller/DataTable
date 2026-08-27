local UINSectorLevelChapterBtn = class("UINSectorLevel23ChapterBtn", UIBaseNode)
local base = UIBaseNode
local cs_DoTween = CS.DG.Tweening.DOTween
local SectorChapterEnum = require("Game.Sector.Enum.SectorLevelChapterEnum")

function UINSectorLevelChapterBtn:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickSectorChapterLv)
end

function UINSectorLevelChapterBtn:InitSectorChapterLvBtn(modeId, callback)
  self.modeId = modeId
  self.callback = callback
  self:_InitUI(self.modeId)
end

function UINSectorLevelChapterBtn:_InitUI(modeId)
  self.chapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter)
  local repeatName = self.chapterCtrl:GetRepeatName()
  local mainName = self.chapterCtrl:GetMainName()
  if modeId == SectorChapterEnum.levelSelectButtonType.mainButton then
    self.ui.img_LIcon:SetIndex(1)
    self.ui.img_Line.color = self.ui.Line_color[2]
    self.ui.tex_CNName:SetIndex(1, mainName)
    self.ui.img_RIcon:SetIndex(1)
    self.ui.img_RIcon.transform.localEulerAngles = Vector3.Temp(0, 0, 0)
    self.ui.tex_ENName:SetIndex(0)
  elseif modeId == SectorChapterEnum.levelSelectButtonType.repeatButton then
    self.ui.img_LIcon:SetIndex(0)
    self.ui.img_Line.color = self.ui.Line_color[1]
    self.ui.tex_CNName:SetIndex(0, repeatName)
    self.ui.img_RIcon:SetIndex(1)
    self.ui.img_RIcon.transform.localEulerAngles = Vector3.Temp(0, 0, 180)
    self.ui.tex_ENName:SetIndex(0)
  elseif modeId == SectorChapterEnum.levelSelectButtonType.normalDiffButton then
    self.ui.img_LIcon:SetIndex(2)
    self.ui.img_Line.color = self.ui.Line_color[4]
    self.ui.tex_CNName:SetIndex(2)
    self.ui.img_RIcon:SetIndex(0)
    self.ui.tex_ENName:SetIndex(1)
  elseif modeId == SectorChapterEnum.levelSelectButtonType.hardDiffButton then
    self.ui.img_LIcon:SetIndex(3)
    self.ui.img_Line.color = self.ui.Line_color[3]
    self.ui.tex_CNName:SetIndex(3)
    self.ui.img_RIcon:SetIndex(0)
    self.ui.tex_ENName:SetIndex(1)
  end
end

function UINSectorLevelChapterBtn:OnClickSectorChapterLv()
  if self.callback ~= nil then
    self.callback(self.modeId)
  end
end

function UINSectorLevelChapterBtn:OnDelete()
  base.OnDelete(self)
end

return UINSectorLevelChapterBtn

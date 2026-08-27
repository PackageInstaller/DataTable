local UINSummer23ChapterInteractItem = class("UINSummer23ChapterInteractItem", UIBaseNode)
local base = UIBaseNode
local SectorChapterEnum = require("Game.Sector.Enum.SectorLevelChapterEnum")

function UINSummer23ChapterInteractItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_interactiveIcon, self, self._OnClickRoot)
end

function UINSummer23ChapterInteractItem:RefreshSummer23InteractiveItem(interactCfg, carnival23Data)
  self.ui.tex_name_en.text = LanguageUtil.GetLocaleText(interactCfg.obj_name_en)
  self.ui.tex_name.text = LanguageUtil.GetLocaleText(interactCfg.obj_name)
  local mainCfg = carnival23Data:GetCarnival23Cfg()
  local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
  local sectorId = mainCfg.normal_sector
  sectorLevelChapterCtrl:ChangeChapterDataType(SectorChapterEnum.chapterDataType.actCarnival23)
  local chapterNum = sectorLevelChapterCtrl:GetLastUnCompleteChapter(sectorId)
  self.ui.tex_chapter.text = ConfigData:GetTipContent(349, chapterNum)
  self.ui.img_interactiveIcon:SetIndex(interactCfg.phase - 1)
  self.ui.img_Planet:SetIndex(interactCfg.ui_image_id - 1)
end

function UINSummer23ChapterInteractItem:SetInfoBoardOpen(bool)
  self.ui.obj_infoBoard:SetActive(bool)
end

function UINSummer23ChapterInteractItem:CloseAllAni()
end

function UINSummer23ChapterInteractItem:SetArrowOpen(arrowDir)
  self.ui.img_Arrow2.gameObject:SetActive(true)
  self.ui.img_Arrow1.gameObject:SetActive(false)
  local angle = Vector3.Angle(Vector3.up, arrowDir)
  local norDir = Vector3.Cross(Vector3.up, arrowDir)
  if norDir.z > 0 then
    angle = angle * -1
  end
  angle = angle + 45
  self.ui.img_Arrow2.rotation = Quaternion.AngleAxis(angle, Vector3.back)
end

function UINSummer23ChapterInteractItem:SetArrowClose()
  self.ui.img_Arrow2.gameObject:SetActive(false)
  self.ui.img_Arrow1.gameObject:SetActive(true)
end

function UINSummer23ChapterInteractItem:SetSummer23InteractiveItemEntt(actLbEntt)
  self._actLbEntt = actLbEntt
end

function UINSummer23ChapterInteractItem:GetInteractiveItemWidth()
  return 76
end

function UINSummer23ChapterInteractItem:_OnClickRoot()
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actLbCtrl == nil then
    return
  end
  actLbCtrl.actLbCmderCtrl:LbCmdMove2Entt(self._actLbEntt)
end

function UINSummer23ChapterInteractItem:OnDelete()
end

return UINSummer23ChapterInteractItem

local UINSectorChapterLvSwitchBtn = class("UINSectorChapterLvSwitchBtn", UIBaseNode)
local base = UIBaseNode
local cs_DoTween = CS.DG.Tweening.DOTween
local bgPictureDic = {
  "Activity/Winter23/UI_Winter23SelectNormalBg.png",
  "Activity/Winter23/UI_Winter23SelectHardBg.png"
}

function UINSectorChapterLvSwitchBtn:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickSectorChapterLv)
end

function UINSectorChapterLvSwitchBtn:InitSectorChapterLvBtn(diffIdx, diffCfg, resloader, callback)
  self.index = diffIdx
  self.callback = callback
  self.cfg = diffCfg
  self.resloader = resloader
  self:_InitUI(diffIdx, diffCfg)
  self:SetSectorChapterLvState(false)
end

function UINSectorChapterLvSwitchBtn:SetSectorChapterLvState(flag)
  if flag == self._flag then
    return
  end
  self._flag = flag
  self.ui.item_group.alpha = flag and 1 or 0.3
end

function UINSectorChapterLvSwitchBtn:_InitUI(diffIdx, diffCfg)
  local index = diffIdx - 1
  self.ui.img_Icon:SetIndex(diffCfg.difficulty_id - 1)
  local path = PathConsts:GetResImagePath(bgPictureDic[diffCfg.difficulty_id])
  self.resloader:LoadABAssetAsync(path, function(texture)
    if IsNull(self.transform) or IsNull(texture) then
      return
    end
    self.ui.img_Bottom.texture = texture
  end)
  self.ui.tex_Mode.text = LanguageUtil.GetLocaleText(diffCfg.difficulty_name_en)
  self.ui.tex_TitleName.text = LanguageUtil.GetLocaleText(diffCfg.difficulty_name)
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(diffCfg.difficulty_desc)
end

function UINSectorChapterLvSwitchBtn:OnClickSectorChapterLv()
  if self.callback ~= nil then
    self.callback(self.index)
  end
end

function UINSectorChapterLvSwitchBtn:OnDelete()
  base.OnDelete(self)
end

return UINSectorChapterLvSwitchBtn

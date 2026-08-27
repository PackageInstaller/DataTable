local UINHeroInfoAchriveNode = class("UINHeroInfoAchriveNode", UIBaseNode)
local base = UIBaseNode
local cs_DoTween = CS.DG.Tweening.DOTween

function UINHeroInfoAchriveNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.lastInitHeroId = nil
end

function UINHeroInfoAchriveNode:InitUsefulData(heroData, HeroInfoTextUtil, resloader)
  self.heroData = heroData
  self.HeroInfoTextUtil = HeroInfoTextUtil
  self.resloader = resloader
end

function UINHeroInfoAchriveNode:InitHeroInfoNode()
  if self.lastInitHeroId == self.heroData.dataId then
    return
  end
  self.lastInitHeroId = self.heroData.dataId
  local heroName = self.heroData:GetName()
  local campName = LanguageUtil.GetLocaleText(self.heroData:GetCampCfg().name)
  local battleCareerName = LanguageUtil.GetLocaleText(self.heroData:GetCareerCfg().name)
  local birthday, model, cv, archives_career = self.heroData:GetHeroArchiveInfo()
  local campIcon = LanguageUtil.GetLocaleText(self.heroData:GetCampCfg().icon)
  self.resloader:LoadABAssetAsync(PathConsts:GetCampPicPath(campIcon), function(texture)
    if IsNull(self.transform) then
      return
    end
    if IsNull(texture) then
      return
    end
    self.ui.img_buttom.texture = texture
  end)
  self.ui.tex_Name.text = heroName
  self.ui.tex_Career.text = archives_career
  self.ui.tex_Type.text = model
  self.ui.tex_Camp.text = campName
  self.ui.tex_Birthday.text = birthday
  self.ui.tex_Pos.text = battleCareerName
  local careerText = self.HeroInfoTextUtil.GetArchiveText(self.heroData.dataId, ConfigData.game_config.heroInfoCareerTextKey)
  self.ui.tex_Record.text = careerText or ""
  self:__InitAchriveTween()
  if self.heroData.dataId == 1058 then
    self.ui.tex_Camp.text = ConfigData:GetTipContent(766)
  end
end

function UINHeroInfoAchriveNode:__InitAchriveTween()
  AudioManager:PlayAudioById(1121)
  if self.tweenSeq ~= nil then
    self.tweenSeq:Restart()
    return
  end
  local tweenSeq = cs_DoTween.Sequence()
  for index, component in ipairs(self.ui.tweenList) do
    tweenSeq:Append(component:DOFade(0, 0.05):SetLoops(2):From())
  end
  tweenSeq:SetAutoKill(false)
  self.tweenSeq = tweenSeq
end

function UINHeroInfoAchriveNode:OnTcpLogOut_HeroInfoNode()
end

function UINHeroInfoAchriveNode:OnDelete()
  self.tweenSeq:Kill()
  self.tweenSeq = nil
  for index, component in ipairs(self.ui.tweenList) do
    component:DOKill()
  end
  base.OnDelete(self)
end

return UINHeroInfoAchriveNode

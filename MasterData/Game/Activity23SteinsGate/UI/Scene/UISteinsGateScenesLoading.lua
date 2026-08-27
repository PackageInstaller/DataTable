local UISteinsGateScenesLoading = class("UISteinsGateScenesLoading", UIBaseWindow)
local base = UIBaseWindow
local cs_DoTween = CS.DG.Tweening.DOTween

function UISteinsGateScenesLoading:OnInit()
end

function UISteinsGateScenesLoading:PlaySGScenesLoading(playId)
  self:RefreshLocationInfo(playId)
  local __initSeq = cs_DoTween.Sequence():AppendCallback(function()
    self.ui.ani_mask:Play()
  end):AppendInterval(1)
  if self.playCfg == nil then
    __initSeq:AppendCallback(function()
      self:OnTweenEnd()
    end)
  else
    __initSeq:AppendCallback(function()
      self.ui.ani_location.gameObject:SetActive(true)
      self.ui.ani_location:Play()
    end):AppendInterval(3.5):AppendCallback(function()
      self:OnTweenEnd()
    end)
  end
  self.tweenSeq = __initSeq
end

function UISteinsGateScenesLoading:RefreshLocationInfo(playId)
  self.playCfg = ConfigData.activity_23steinsgate_avg_text[playId]
  if self.playCfg == nil then
    return
  end
  local des = LanguageUtil.GetLocaleText(self.playCfg.text)
  local desTimeLine = LanguageUtil.GetLocaleText(self.playCfg.digit)
  local haveDes = not string.IsNullOrEmpty(des)
  local haveTimeLine = not string.IsNullOrEmpty(desTimeLine)
  self.ui.tex_Des.gameObject:SetActive(haveDes)
  self.ui.tex_TimeLine.gameObject:SetActive(haveTimeLine)
  self.ui.tex_Des.text = des
  self.ui.tex_TimeLine.text = desTimeLine
end

function UISteinsGateScenesLoading:__ClearTween()
  if self.tweenSeq ~= nil then
    self.tweenSeq:Kill()
    self.tweenSeq = nil
  end
end

function UISteinsGateScenesLoading:OnTweenEnd()
  self:__ClearTween()
  self:Delete()
end

function UISteinsGateScenesLoading:OnDelete()
  self:__ClearTween()
  base.OnDelete(self)
end

return UISteinsGateScenesLoading

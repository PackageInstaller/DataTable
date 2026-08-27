local base = UIBaseNode
local UINSectorItem = class("UINSectorItem", base)
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local cs_DoTween = CS.DG.Tweening.DOTween

function UINSectorItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self._OnClickRoot)
  self.PlaySctItemUnlockAnimCallback = BindCallback(self, self.PlaySctItemUnlockAnim)
  MsgCenter:AddListener(eMsgEventId.SectorChapterUnlockSuccess, self.PlaySctItemUnlockAnimCallback)
end

function UINSectorItem:InitSectorItem(sctChaptData, clickFunc)
  self._sctChaptData = sctChaptData
  self._clickFunc = clickFunc
  self.ui.tex_SectorNumber:SetIndex(0, sctChaptData:GetSctChaptSerialNum())
  self.ui.tex_SectorName.text = sctChaptData:GetSctChaptName()
  self.ui.tex_ENName.text = sctChaptData:GetSctChaptEnName()
  self.gameObject.name = tostring(sctChaptData:GetSctChaptSectorId())
  local posList = sctChaptData:GetSctChaptUIPosList()
  self.transform.anchoredPosition = Vector2.Temp(posList[1], posList[2])
  self:UpdSctChaptChallengeProgress()
end

function UINSectorItem:UpdSctChaptChallengeProgress()
  local allCount = 0
  local completeCount = 0
  local curChallengeTaskNum = 0
  local allChallengeTaskNum = 0
  allCount, completeCount, curChallengeTaskNum, allChallengeTaskNum = SectorStageDetailHelper.GetSectorStagePerformance(self._sctChaptData:GetSctChaptSectorId(), self._sctChaptData:IsSctChanllengeOpen())
  local progress = completeCount / allCount
  self.ui.sliderProgress.value = progress
  progress = math.floor(progress * 100)
  self.ui.tex_Progress:SetIndex(0, tostring(progress))
  if self._sctChaptData:IsSctChanllengeOpen() then
    self.ui.challenge:SetActive(true)
    self.ui.tex_TotalChall:SetIndex(0, tostring(curChallengeTaskNum), tostring(allChallengeTaskNum))
  else
    self.ui.challenge:SetActive(false)
  end
  local unlockCostOk = self._sctChaptData:IsSectorChapterUnlockCostOk()
  self.ui.img_Lock:SetActive(not unlockCostOk)
  self:_SetNameAlpha(unlockCostOk and 1 or 0.5)
  self.ui.anim_progress.gameObject:SetActive(unlockCostOk)
  local pointColor = self.ui.img_Point.color
  pointColor.a = (unlockCostOk and 110 or 50) / 255
  self.ui.img_Point.color = pointColor
  if unlockCostOk then
    local unlockColorIdx = self._sctChaptData:GetSctChapterUnlockColorIdx()
    self:_SetRingColor(self.ui.color_Circle[unlockColorIdx])
  else
    self:_SetRingColor(Color.gray)
  end
end

function UINSectorItem:_OnClickRoot()
  if self._clickFunc ~= nil then
    self._clickFunc(self._sctChaptData, self)
  end
end

function UINSectorItem:ShowSctChaptItemInEp(show)
  self.ui.inExplore:SetActive(show)
end

function UINSectorItem:_SetNameAlpha(alpha)
  self.ui.nameCg.alpha = alpha
  self.ui.nameCg.enabled = alpha < 1
end

function UINSectorItem:PlaySctItemUnlockAnim(reSectorId, callback)
  local sectorId = self._sctChaptData:GetSctChaptSectorId()
  if sectorId ~= reSectorId then
    return
  end
  self:_KillUnlockSeq()
  UIUtil.AddOneCover("sctorUnlcokAnim")
  self.ui.anim_lock:Play()
  local seq = cs_DoTween.Sequence()
  self._unlockSeq = seq
  seq:Append(self.ui.nameCg:DOFade(1, 0.5)):AppendCallback(function()
    self:_SetNameAlpha(1)
  end):InsertCallback(0.5, function()
    self.ui.anim_progress.gameObject:SetActive(true)
    self.ui.anim_progress:Play()
  end):InsertCallback(2, function()
    self:UpdSctChaptChallengeProgress()
    UIUtil.CloseOneCover("sctorUnlcokAnim")
    if callback then
      callback()
    end
    self._unlockSeq = nil
  end)
end

function UINSectorItem:_KillUnlockSeq()
  if self._unlockSeq then
    self._unlockSeq:Kill()
    self._unlockSeq = nil
  end
end

function UINSectorItem:SetSctChaptItemAlpha(alpha)
  self.ui.canvasGroup.alpha = alpha
  self.ui.canvasGroup.enabled = alpha < 1
end

function UINSectorItem:SetSctChaptItemShowTween(sequence)
  self:SetSctChaptItemAlpha(0)
  sequence:Append(self.ui.canvasGroup:DOFade(1, 1)):AppendCallback(function()
    self:SetSctChaptItemAlpha(1)
  end)
end

function UINSectorItem:_SetRingColor(color)
  for k, img in ipairs(self.ui.img_CircleList) do
    img.color = Color.Temp(color.r, color.g, color.b, img.color.a)
  end
end

function UINSectorItem:OnDelete()
  self:_KillUnlockSeq()
  MsgCenter:RemoveListener(eMsgEventId.SectorChapterUnlockSuccess, self.PlaySctItemUnlockAnimCallback)
  base.OnDelete(self)
end

return UINSectorItem

local UINActBlackHoleFloorSelectItem = class("UINActBlackHoleFloorSelectItem", UIBaseNode)
local base = UIBaseNode
local CS_MessageCommon = CS.MessageCommon

function UINActBlackHoleFloorSelectItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Bk, self, self.OnClickFloorSelectBk)
end

function UINActBlackHoleFloorSelectItem:InitActBlackHoleFloorSelectItem(floorData, clickFunc)
  self.floorData = floorData
  self.floorCfg = self.floorData:GetBHFloorCfg()
  self.clickFunc = clickFunc
  self.isUnlock, self.lockData = self.floorData:GetFloorDataUnlockState()
  self:RefreshFloorSelectItem()
end

function UINActBlackHoleFloorSelectItem:RefreshFloorSelectItem()
  self.ui.obj_lock:SetActive(not self.isUnlock)
  local scoreNum = self.floorData:GetNowScore()
  if 0 < scoreNum then
    self.ui.tex_Score:SetIndex(0, tostring(scoreNum))
  elseif self.isUnlock then
    self.ui.tex_Score:SetIndex(1)
  else
    self.ui.tex_Score:SetIndex(2)
  end
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(self.floorCfg.floor_name)
  if self.floorCfg.is_boss then
    self.ui.img_ScoreBk.color = self.ui.color_boss
    self.ui.img_Icon:SetIndex(2)
  else
    self.ui.img_ScoreBk.color = self.ui.color_normal
    self.ui.img_Icon:SetIndex(1 < self.floorCfg.dungeon_num and 1 or 0)
  end
end

function UINActBlackHoleFloorSelectItem:OnClickFloorSelectBk()
  if not self.isUnlock then
    CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7506, LanguageUtil.GetLocaleText(self.lockData:GetBHFloorName())))
    return
  end
  if self.clickFunc then
    self.clickFunc(self.floorData, self)
  end
end

function UINActBlackHoleFloorSelectItem:PlayFloorSelectItemSingleAni(delayTime)
  self:__StopTween()
  self.ui.aniNode.transform:DOLocalMoveX(-20, 0.3):From():SetDelay(delayTime):SetLink(self.ui.aniNode.gameObject)
  self.ui.canvasGroup:DOFade(0, 0.3):From():SetDelay(delayTime):SetLink(self.gameObject)
end

function UINActBlackHoleFloorSelectItem:__StopTween()
  self.ui.aniNode.transform:DOComplete()
  self.ui.canvasGroup:DOComplete()
end

function UINActBlackHoleFloorSelectItem:PlayFloorSelectItemUnlockAni(delayTime)
  self:__StopUnlockAni()
  self.ui.obj_lock:SetActive(self.isUnlock)
  self._UnlockAniStartTimer = TimerManager:StartTimer(delayTime, function()
    self.ui.anim_lock:Play()
  end, self, true)
  self.ui.anim_textfade:DOFade(0, 0.25):SetDelay(1.08 + delayTime):SetLink(self.gameObject)
  self.ui.anim_image:DOFade(0, 0.25):SetDelay(1.08 + delayTime):SetLink(self.gameObject)
end

function UINActBlackHoleFloorSelectItem:__StopUnlockAni()
  self.ui.anim_textfade:DOComplete()
  self.ui.anim_image:DOComplete()
end

function UINActBlackHoleFloorSelectItem:OnDelete()
  TimerManager:StopTimer(self._UnlockAniStartTimer)
  base.OnDelete(self)
end

return UINActBlackHoleFloorSelectItem

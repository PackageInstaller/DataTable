local UIN_HBHeroCampIndexItem = class("UIN_HBHeroCampIndexItem", UIBaseNode)
local base = UIBaseNode
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_DoTweenLoopType = CS.DG.Tweening.LoopType

function UIN_HBHeroCampIndexItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_item, self, self.__OnClick)
end

function UIN_HBHeroCampIndexItem:InitCampIndexItem(campCfg, handBookCtrl)
  self.campId = campCfg.id
  self.handBookCtrl = handBookCtrl
  self.ui.img_CampIcon.sprite = CRH:GetSprite(campCfg.icon, CommonAtlasType.CareerCamp)
  self.ui.tex_Camp.text = LanguageUtil.GetLocaleText(campCfg.name)
  self:HBCIIRefreshCollectRate()
end

function UIN_HBHeroCampIndexItem:HBCIIRefreshCollectRate()
  local collectRate, totalNum = self.handBookCtrl:GetCampHeroCollectNum(self.campId)
  self.ui.tex_Count:SetIndex(0, tostring(collectRate), tostring(totalNum))
end

function UIN_HBHeroCampIndexItem:__OnClick()
  AudioManager:PlayAudioById(1221)
  UIManager:ShowWindowAsync(UIWindowTypeID.HandBookHeroCampHeroList, function(win)
    win:InitHBHeroHeroList(self.campId)
    UIManager:HideWindow(UIWindowTypeID.HandBookHeroCampIndex)
  end)
end

function UIN_HBHeroCampIndexItem:DoHBCampIndexItemZoomOutTween(index, totalNum)
  local sequence = cs_DoTween.Sequence()
  local mid = totalNum // 2 + 1
  local step = mid - index
  local flag = 0 < step and 1 or -1
  if step == 0 then
    flag = 0
  end
  local absStrp = math.abs(step)
  local assTime = absStrp * 0.1
  if flag ~= 0 then
    local pos = self.transform.localPosition
    local fromPos = Vector3.New(pos.x + step * 150 + (step - flag) * 70, pos.y, pos.z)
    sequence:Append(self.transform:DOLocalMove(fromPos, 0.35 + assTime):From())
  end
  local scale = 0.85 ^ (absStrp + 1)
  sequence:Join(self.transform:DOScale(scale, 0.35 + assTime):From())
  local alpha = 1 - absStrp / (mid - 1)
  if alpha < 0.99 then
    sequence:Join(self.ui.cg_item:DOFade(alpha, 0.5 + assTime):From())
  end
  sequence:Join(self.ui.img_CampIcon.transform:DOLocalMoveY(0, 0.35):From():SetDelay(0.4 + assTime / 2))
  sequence:Join(self.ui.cg_progress.transform:DOLocalMoveY(-170, 0.3):From())
  sequence:Join(self.ui.cg_progress:DOFade(0, 0.3):From())
  sequence:Join(self.ui.img_btnBg:DOFade(0.4, 0.1):From():SetLoops(3, cs_DoTweenLoopType.Yoyo):SetDelay(assTime / 2))
  self.__sequence = sequence
end

function UIN_HBHeroCampIndexItem:OnDelete()
  if self.__sequence ~= nil then
    self.__sequence:Kill()
    self.__sequence = nil
  end
  base.OnDelete(self)
end

return UIN_HBHeroCampIndexItem

_class("UISeasonMazeRoomRandomEventOption", UICustomWidget)
UISeasonMazeRoomRandomEventOption = UISeasonMazeRoomRandomEventOption

function UISeasonMazeRoomRandomEventOption:OnShow()
  self.mask = self:GetGameObject("Mask")
  self.descText = self:GetUIComponent("RollingText", "desc")
  self.anim = self:GetUIComponent("Animation", "anim")
end

function UISeasonMazeRoomRandomEventOption:SetData(cfg, uiCtrl)
  self.cfg = cfg
  self.uiCtrl = uiCtrl
  self.descText:RefreshText(StringTable.Get(cfg.OptionDesc))
  self.curGold = self.uiCtrl._component:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  self.curLv = self.uiCtrl._component:GetAttrValue(SeasonMazeAttrType.SMAT_Lv)
  self.lock = false
  local goldCond = cfg.GoldCond
  local lvLess = cfg.LvLess
  local lvMore = cfg.LvMore
  if goldCond and 0 < goldCond and goldCond > self.curGold then
    self.lock = true
  end
  if lvLess and 0 < lvLess and lvLess > self.curLv then
    self.lock = true
  end
  if lvMore and 0 < lvMore and lvMore < self.curLv then
    self.lock = true
  end
  self.mask:SetActive(self.lock)
end

function UISeasonMazeRoomRandomEventOption:PlayShowAnim()
  self.anim:Play("uieffanim_UISeasonMazeRoomRandomEventOption_in")
end

function UISeasonMazeRoomRandomEventOption:PlayHideAnim()
  self.anim:Play("uieffanim_UISeasonMazeRoomRandomEventOption_out")
end

function UISeasonMazeRoomRandomEventOption:BtnOnClick()
  if self.lock then
    return
  end
  self.uiCtrl:OnOptionSelect(self.cfg)
end

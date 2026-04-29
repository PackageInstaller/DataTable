_class("UIN22MedalChangeBoardItem", UICustomWidget)
UIN22MedalChangeBoardItem = UIN22MedalChangeBoardItem

function UIN22MedalChangeBoardItem:Constructor()
  self.mMedal = GameGlobal.GetModule(MedalModule)
  self.mItem = GameGlobal.GetModule(ItemModule)
  self.data = self.mMedal:GetN22MedalEditData()
end

function UIN22MedalChangeBoardItem:OnShow()
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.goBtnReplace = self:GetGameObject("BtnReplace")
  self.goUsing = self:GetGameObject("using")
end

function UIN22MedalChangeBoardItem:OnHide()
  self.imgIcon:DestoryLastImage()
end

function UIN22MedalChangeBoardItem:Flush(board, curId, callback)
  self.id = board.medal_id
  self.callback = callback
  if self.id == curId then
    self.goBtnReplace:SetActive(false)
    self.goUsing:SetActive(true)
  else
    self.goUsing:SetActive(false)
    if board.status == RewardStatus.E_MEDAL_REWARD_LOCK then
      self.goBtnReplace:SetActive(false)
    else
      self.goBtnReplace:SetActive(true)
    end
  end
  local boardIconHD = UIN22MedalEdit.GetMedalBoardBgHd(self.id)
  self.imgIcon:LoadImage(boardIconHD)
end

function UIN22MedalChangeBoardItem:BtnReplaceOnClick(go)
  if self.callback then
    self.callback()
  end
end

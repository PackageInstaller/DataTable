_class("UIBouncePrepare", UICustomWidget)
UIBouncePrepare = UIBouncePrepare

function UIBouncePrepare:OnShow(uiParams)
  self:InitWidget()
end

function UIBouncePrepare:InitWidget()
  self._atlas = self:GetAsset("UIN28MinigameIn.spriteatlas", LoadType.SpriteAtlas)
  self._txt = self:GetUIComponent("Image", "txt")
end

function UIBouncePrepare:Start(finishCall)
  self._finishCall = finishCall
  self:StartTask(self.StartAni, self)
end

function UIBouncePrepare:StartAni(TT)
  self:Lock("UIBouncePrepare:StartAni")
  for i = 3, 1, -1 do
    self._txt.sprite = self._atlas:GetSprite("N28_yrj_jngq_countdown0" .. i)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BoucneCounter)
    YIELD(TT, 1000)
  end
  YIELD(TT, 500)
  self:UnLock("UIBouncePrepare:StartAni")
  if self._finishCall then
    self._finishCall()
  end
end

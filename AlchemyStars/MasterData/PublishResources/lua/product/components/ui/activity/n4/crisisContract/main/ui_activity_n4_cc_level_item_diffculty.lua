_class("UIActivityN4CCLevelItemDiffculty", UICustomWidget)
UIActivityN4CCLevelItemDiffculty = UIActivityN4CCLevelItemDiffculty

function UIActivityN4CCLevelItemDiffculty:OnShow(uiParams)
  self:InitWidget()
  self._atlas = self:GetAsset("UIN4CC.spriteatlas", LoadType.SpriteAtlas)
end

function UIActivityN4CCLevelItemDiffculty:InitWidget()
  self.passImg = self:GetGameObject("passImg")
  self.lockImg = self:GetGameObject("lockImg")
  self.imgBg = self:GetUIComponent("Image", "imgBg")
end

function UIActivityN4CCLevelItemDiffculty:SetData(state, index)
  self.lockImg:SetActive(state == UIActivityN4CCHelper.DiffultyState.Lock)
  self.passImg:SetActive(state == UIActivityN4CCHelper.DiffultyState.Pass)
  local imgCfg = UIActivityN4CCHelper.DiffultyBgImg[state]
  self.imgBg.sprite = self._atlas:GetSprite(imgCfg[index])
end

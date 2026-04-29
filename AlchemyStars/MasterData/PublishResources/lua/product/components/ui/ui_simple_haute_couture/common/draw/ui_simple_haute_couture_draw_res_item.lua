_class("UISimpleHauteCoutureDrawResItem", UICustomWidget)
UISimpleHauteCoutureDrawResItem = UISimpleHauteCoutureDrawResItem

function UISimpleHauteCoutureDrawResItem:Constructor()
end

function UISimpleHauteCoutureDrawResItem:OnShow(uiParams)
  self:_GetComponents()
end

function UISimpleHauteCoutureDrawResItem:_GetComponents()
  self._num = self:GetUIComponent("UILocalizationText", "num")
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._skinImg = self:GetUIComponent("RawImageLoader", "skinImg")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "anim")
  self._rect = self:GetUIComponent("RectTransform", "bg")
  self._drawEff = {}
  self._drawEff[1] = self:GetGameObject("eff_01")
  self._drawEff[2] = self:GetGameObject("eff_02")
  self._drawEff[3] = self:GetGameObject("eff_03")
  self._drawEff[4] = self:GetGameObject("eff_04")
  self._drawEff[5] = self:GetGameObject("eff_05")
  self._drawEff[6] = self:GetGameObject("eff_06")
end

function UISimpleHauteCoutureDrawResItem:SetData(data, index, bigDrawPic)
  self._data = data
  self._bigDrawPic = bigDrawPic
  self:_Init()
  self._rect.localScale = Vector3(0.98, 0.98, 1)
  self._canvasGroup.alpha = 0
  self:StartTask(function(TT)
    YIELD(TT, index * 45)
    if not tolua.isnull(self._anim) then
      self._anim:Play("uieffanim_UISimpleHauteCoutureDrawResItem")
    end
  end)
end

function UISimpleHauteCoutureDrawResItem:_Init()
  for _, effObj in pairs(self._drawEff) do
    effObj:SetActive(false)
  end
  local isSkin = self._data.assetid < 4999999 and self._data.assetid > 4000000
  local item = Cfg.cfg_item[self._data.assetid]
  self._num:SetText(self._data.count)
  self._skinImg.gameObject:SetActive(isSkin)
  self._skinImg:LoadImage(self._bigDrawPic)
  local probabilityCfg = Cfg.cfg_junior_skin_draw_probablity({
    ItemID = self._data.assetid,
    Count = self._data.count
  })[1]
  self._drawEff[probabilityCfg.Color]:SetActive(true)
  self._icon:LoadImage(item.Icon)
  self._name:SetText(StringTable.Get(item.Name))
end

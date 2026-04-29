_class("UIWordAndElemItem", UICustomWidget)
UIWordAndElemItem = UIWordAndElemItem

function UIWordAndElemItem:OnShow()
  self._alpha = self:GetUIComponent("CanvasGroup", "word")
  self._atlas = self:GetAsset("UIStage.spriteatlas", LoadType.SpriteAtlas)
  self._img1 = self:GetUIComponent("Image", "elemBtn")
  self._img2 = self:GetUIComponent("Image", "wordBtn")
  self._tex1 = self:GetUIComponent("UILocalizationText", "tex1")
  self._tex2 = self:GetUIComponent("UILocalizationText", "tex2")
end

function UIWordAndElemItem:SetData(cfg, black)
  self._tb = {}
  local buff = cfg.BaseWordBuff
  if buff then
    local words = type(buff) == "table" and buff or {buff}
    for _, wordId in ipairs(buff) do
      table.insert(self._tb, self:_GetWordDesc(cfg.ID, wordId))
    end
  end
  self._show = #self._tb ~= 0
  if self._show then
    self._alpha.alpha = 1
  else
    self._alpha.alpha = 0.4
  end
  local texColor, sprite
  if black then
    sprite = "map_black_btn01"
    texColor = Color(0.8588235294117647, 0.8588235294117647, 0.8588235294117647, 1)
  else
    sprite = "map_bantou21_frame"
    texColor = Color(0.9098039215686274, 0.9098039215686274, 0.9098039215686274, 1)
  end
  self._img1.sprite = self._atlas:GetSprite(sprite)
  self._img2.sprite = self._atlas:GetSprite(sprite)
  self._tex1.color = texColor
  self._tex2.color = texColor
end

function UIWordAndElemItem:ElemBtnOnClick(go)
  GameGlobal.UAReportForceGuideEvent("UIStageClick", {
    "restrainBtnOnClick"
  }, true)
  self:ShowDialog("UIStageElemTips")
end

function UIWordAndElemItem:WordBtnOnClick(go)
  if self._show then
    GameGlobal.UAReportForceGuideEvent("UIStageClick", {
      "restrainBtnOnClick"
    }, true)
    self:ShowDialog("UIStageWordTips", self._tb)
  end
end

function UIWordAndElemItem:_GetWordDesc(levelId, wordId)
  local word = Cfg.cfg_word_buff[wordId]
  if not word then
    Log.exception("cfg_word_buff 中找不到词缀:", wordId, "levelId:", levelId)
  end
  local name = StringTable.Get(word.Word[1])
  local desc = StringTable.Get(word.Desc)
  local tex = "【" .. name .. "】 " .. desc
  return tex
end

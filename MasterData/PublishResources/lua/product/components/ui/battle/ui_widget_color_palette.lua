_class("UIWidgetColorPalette", UICustomWidget)
UIWidgetColorPalette = UIWidgetColorPalette

function UIWidgetColorPalette:OnShow(uiParams)
  self._curPieceTypes = {}
  self._animationNames = {
    [PieceType.Blue] = {
      "uieff_UIWidgetColorPalette_blue_open",
      "uieff_UIWidgetColorPalette_blue_loop"
    },
    [PieceType.Red] = {
      "uieff_UIWidgetColorPalette_red_open",
      "uieff_UIWidgetColorPalette_red_loop"
    },
    [PieceType.Green] = {
      "uieff_UIWidgetColorPalette_green_open",
      "uieff_UIWidgetColorPalette_green_loop"
    },
    [PieceType.Yellow] = {
      "uieff_UIWidgetColorPalette_yellow_open",
      "uieff_UIWidgetColorPalette_yellow_loop"
    }
  }
  self:InitWidget()
  self:AttachEvent(GameEventType.ColorPaletteRefresh, self.OnColorPaletteChange)
end

function UIWidgetColorPalette:InitWidget()
  self._colorGO = {}
  self._colorGO[PieceType.Blue] = self:GetGameObject("Blue")
  self._colorGO[PieceType.Red] = self:GetGameObject("Red")
  self._colorGO[PieceType.Green] = self:GetGameObject("Green")
  self._colorGO[PieceType.Yellow] = self:GetGameObject("Yellow")
end

function UIWidgetColorPalette:SetData(pstID)
  self._pstID = pstID
  self:_Clear()
end

function UIWidgetColorPalette:OnColorPaletteChange(pstID, pieceTypes)
  if self._pstID == pstID and pieceTypes then
    if 0 < #pieceTypes then
      local newPieceTypes = {}
      for _, pieceType in ipairs(pieceTypes) do
        if pieceType ~= PieceType.Any and not table.icontains(self._curPieceTypes, pieceType) then
          table.insert(newPieceTypes, pieceType)
          table.insert(self._curPieceTypes, pieceType)
        end
      end
      for _, pieceType in ipairs(newPieceTypes) do
        if self._colorGO[pieceType] then
          local go = self._colorGO[pieceType]
          go:SetActive(true)
          local animation = go:GetComponent("Animation")
          local animationNames = self._animationNames[pieceType]
          animation.enabled = false
          animation.enabled = true
          animation:PlayQueued(animationNames[1], UnityEngine.QueueMode.PlayNow)
          animation:PlayQueued(animationNames[2], UnityEngine.QueueMode.CompleteOthers)
        end
      end
    else
      self:_Clear()
    end
  end
end

function UIWidgetColorPalette:_Clear()
  for _, go in pairs(self._colorGO) do
    go:SetActive(false)
  end
  table.clear(self._curPieceTypes)
end

function UIWidgetColorPalette:PlayAnimation()
  for _, pieceType in ipairs(self._curPieceTypes) do
    if self._colorGO[pieceType] then
      local go = self._colorGO[pieceType]
      if go.activeSelf then
        local animation = go:GetComponent("Animation")
        local animationNames = self._animationNames[pieceType]
        animation.enabled = false
        animation.enabled = true
        animation:Play(animationNames[2])
      end
    end
  end
end

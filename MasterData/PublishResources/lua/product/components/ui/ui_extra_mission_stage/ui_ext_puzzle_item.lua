_class("UIExtPuzzleItem", UICustomWidget)
UIExtPuzzleItem = UIExtPuzzleItem
local posTab = {
  [1] = Vector2(-450, 201),
  [2] = Vector2(-112, 201),
  [3] = Vector2(250, 201),
  [4] = Vector2(-450, -65),
  [5] = Vector2(-112, -65),
  [6] = Vector2(250, -65)
}
local sizeTab = {
  [1] = Vector2(338, 266),
  [2] = Vector2(363, 266),
  [3] = Vector2(358, 266),
  [4] = Vector2(338, 258),
  [5] = Vector2(363, 258),
  [6] = Vector2(358, 266)
}

function UIExtPuzzleItem:OnShow()
  self._module = self:GetModule(ExtMissionModule)
  self._atlas = self:GetAsset("UIExtraMissionStage.spriteatlas", LoadType.SpriteAtlas)
  self._black = self:GetUIComponent("Image", "black")
  self._cucoloris = self:GetUIComponent("RawImageLoader", "cucoloris")
  self._cg = self:GetUIComponent("RawImageLoader", "cg")
  self._select = self:GetUIComponent("Image", "select")
  self._new = self:GetGameObject("new")
  self._stars = self:GetUIComponent("Transform", "stars")
  self._idx = self:GetUIComponent("RectTransform", "idx")
  self._nameTex = self:GetUIComponent("UILocalizationText", "nameTex")
  self._bg = self:GetUIComponent("RectTransform", "bg")
end

function UIExtPuzzleItem:SetData(idx, extid, extidx, stageid, stageidx, callback)
  self._index = idx
  self._extid = extid
  self._stageid = stageid
  self._callback = callback
  self._extIdx = extidx
  self._stageIdx = stageidx
  self._nameTex:SetText(self._extIdx .. "-" .. self._index)
  local posT = posTab[self._index]
  local x = posT.x
  local y = posT.y
  self._idx.anchoredPosition = Vector2(x, y)
  local sizeT = sizeTab[self._index]
  local w = sizeT.x
  local h = sizeT.y
  self._bg.sizeDelta = Vector2(w, h)
  self:GetStars()
  self:LoadPic()
  self:Select(self._index == self._stageIdx)
end

function UIExtPuzzleItem:LoadPic()
  self._black.sprite = self._atlas:GetSprite("outbound_fanwai_shadow" .. self._index)
  self._select.sprite = self._atlas:GetSprite("outbound_fanwai_xuan" .. self._index)
  local cfg_ext = Cfg.cfg_extra_mission[self._extid]
  if cfg_ext then
    if self._state ~= EnumExtMissionState.Disable then
      self._cucoloris.gameObject:SetActive(false)
      local cg = cfg_ext.StageTextureListColor[self._index]
      self._cg:LoadImage(cg)
    else
      self._cg.gameObject:SetActive(false)
      local cucoloris = cfg_ext.StageTextureListCucoloris[self._index]
      self._cucoloris:LoadImage(cucoloris)
    end
  end
end

function UIExtPuzzleItem:GetStars()
  local stars = self._module:UI_GetExtTaskState(self._extid, self._stageid)
  if stars < 0 then
    self._state = EnumExtMissionState.Disable
  elseif stars == 0 then
    local isFirstFail = self._module:UI_IsFirstFail(self._extid, self._stageid)
    if isFirstFail then
      self._state = EnumExtMissionState.New
    else
      self._state = EnumExtMissionState.Open
    end
  elseif 0 < stars then
    self._state = EnumExtMissionState.Down
  end
  if self._state == EnumExtMissionState.New then
    self._new:SetActive(true)
    self._stars.gameObject:SetActive(false)
  else
    self._new:SetActive(false)
    self._stars.gameObject:SetActive(true)
    for i = 1, 3 do
      local img = self._stars:GetChild(i).gameObject:GetComponent("Image")
      if stars >= i then
        img.sprite = self._atlas:GetSprite("outbound_fanwai_icon5")
      else
        img.sprite = self._atlas:GetSprite("outbound_fanwai_icon6")
      end
      img:SetNativeSize()
    end
  end
end

function UIExtPuzzleItem:bgOnClick(go)
  if self._state == EnumExtMissionState.Disable then
    ToastManager.ShowToast(StringTable.Get("str_extra_mission_error_task_lock"))
  elseif self._callback then
    self._callback(self._index)
  end
end

function UIExtPuzzleItem:Select(select)
  self._select.gameObject:SetActive(select)
end

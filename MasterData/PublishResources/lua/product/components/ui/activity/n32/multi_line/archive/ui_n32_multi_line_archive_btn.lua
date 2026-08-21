_class("UIN32MultiLineArchiveBtn", UICustomWidget)
UIN32MultiLineArchiveBtn = UIN32MultiLineArchiveBtn

function UIN32MultiLineArchiveBtn:OnShow()
  self._animInfo = {
    ["in"] = {
      "uieff_UIN32MultiLineArchiveBtn_in",
      233
    },
    switch1 = {
      "uieff_UIN32MultiLineArchiveBtn_switch01",
      167
    },
    switch2 = {
      "uieff_UIN32MultiLineArchiveBtn_switch02",
      400
    }
  }
  self:InitComponent()
end

function UIN32MultiLineArchiveBtn:InitComponent()
  self._textnText = self:GetUIComponent("UILocalizationText", "textn")
  self._textsText = self:GetUIComponent("UILocalizationText", "texts")
  self._redPoint = self:GetGameObject("redPoint")
  self._select = self:GetGameObject("bg_select")
  self._noselect = self:GetGameObject("bg_noselect")
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UIN32MultiLineArchiveBtn:InitUI()
  self._textnText:SetText(StringTable.Get(self._info.PetName))
  self._textsText:SetText(StringTable.Get(self._info.PetName))
  self._redPoint:SetActive(self._isRed)
  if self._index == self._selectIndex then
    self:PlayAnim("in")
  end
end

function UIN32MultiLineArchiveBtn:SetData(index, selectIndex, info, isRed, callBack)
  self._index = index
  self._callBack = callBack
  self._info = info
  self._playerId = info.PetID
  self._selectIndex = selectIndex
  self._isRed = isRed
  self:InitUI()
end

function UIN32MultiLineArchiveBtn:Refresh(selectIndex, lastIndex)
  self._selectIndex = selectIndex
  if self._index == self._selectIndex then
    self:PlayAnim("switch2")
  end
  if self._index == lastIndex then
    self:PlayAnim("switch1")
  end
end

function UIN32MultiLineArchiveBtn:RefreshRed(isRed)
  self._isRed = isRed
  self._redPoint:SetActive(isRed)
end

function UIN32MultiLineArchiveBtn:BtnOnClick(go)
  if self._callBack then
    self._callBack(self._index)
  end
end

function UIN32MultiLineArchiveBtn:PlayAnim(name, callBack)
  local animinfo = self._animInfo[name]
  self:StartTask(function(TT)
    local lockName = "UIN32MultiLineArchive:" .. name
    self:Lock(lockName)
    self._anim:Play(animinfo[1])
    YIELD(TT, animinfo[2])
    self:UnLock(lockName)
    if callBack then
      callBack()
    end
  end)
end

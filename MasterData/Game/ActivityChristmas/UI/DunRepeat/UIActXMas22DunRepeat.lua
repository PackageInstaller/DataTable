local UIActXMas22DunRepeat = class("UIActXMas22DunRepeat", UIBaseWindow)
local base = UIBaseWindow
local UIActXMas22DunRepeatItem = require("Game.ActivityChristmas.UI.DunRepeat.UINActXMas22DunRepeatItem")
local cs_DoTween = CS.DG.Tweening.DOTween

function UIActXMas22DunRepeat:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseChallenge, {
    ConstGlobalItem.SKey
  })
  self._itemPool = UIItemPool.New(UIActXMas22DunRepeatItem, self.ui.item)
  self.ui.item:SetActive(false)
  self.__OnSelectChallengeCallback = BindCallback(self, self.__OnSelectChallenge)
end

function UIActXMas22DunRepeat:InitXMas22DunRepeat(xMas22Data, callback, delayEnterCallback)
  self._xMas22Data = xMas22Data
  self._callback = callback
  self._dungeonLevelDic = self._xMas22Data:GetSeasonDungeonInfo()
  self._starList = {}
  self._itemPool:HideAll()
  local allNum = 0
  local unlockNum = 0
  for _, dungeonlevel in pairs(self._dungeonLevelDic) do
    local item = self._itemPool:GetOne()
    item:InitXMas22ChallengeItem(dungeonlevel, self.__OnSelectChallengeCallback)
    local idx = dungeonlevel:GetDungeonIndex()
    item.transform:SetParent(self.ui.posList[idx])
    item.transform.anchoredPosition = Vector2.zero
    allNum = allNum + 1
    local isLocked = not dungeonlevel:GetIsLevelUnlock()
    if not isLocked then
      unlockNum = math.max(idx, unlockNum)
    end
  end
  for i = 1, allNum do
    local isLocked = i > unlockNum
    local star = self.ui.obj_star:Instantiate(self.ui.main.transform)
    star:GetComponent(typeof(CS.UnityEngine.UI.Image)).color = isLocked and self.ui.starDarkColor or self.ui.starWhiteColor
    star:SetActive(true)
    star.transform.anchoredPosition = Vector2.New(self.ui.posList[i].anchoredPosition.x, star.transform.anchoredPosition.y)
    table.insert(self._starList, star)
    if 1 < i and not isLocked then
      local note = self.ui.obj_note:Instantiate(self.ui.main.transform)
      note:SetActive(true)
      local posX = (self.ui.posList[i].anchoredPosition.x - self.ui.posList[i - 1].anchoredPosition.x) / 2 + self.ui.posList[i - 1].anchoredPosition.x
      local posY = star.transform.anchoredPosition.y + (i % 2 == 0 and 12 or -8)
      note.transform.anchoredPosition = Vector2.New(posX, posY)
    end
  end
  local fillNum = 0.142 + (unlockNum - 1) * 0.179
  if 0.85 < fillNum then
    fillNum = 1
    self.ui.obj_img_MaxLine:SetActive(true)
  else
    self.ui.obj_img_MaxLine:SetActive(false)
  end
  self.ui.fill.fillAmount = fillNum
  if delayEnterCallback ~= nil then
    local lengthTime = self.ui.ani_root.clip.length
    self._delayTimerId = TimerManager:StartTimer(lengthTime, delayEnterCallback, nil, true)
  end
end

function UIActXMas22DunRepeat:__OnSelectChallenge(dungenLevelData)
  local isLocked = not dungenLevelData:GetIsLevelUnlock()
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonLevelDetail, function(win)
    if win == nil then
      return
    end
    win:InitDungeonLevelDetail(dungenLevelData, isLocked)
    win:SetDungeonLevelBgClose(true)
  end)
end

function UIActXMas22DunRepeat:OnCloseChallenge()
  self:Delete()
  if self._callback ~= nil then
    self._callback()
  end
end

function UIActXMas22DunRepeat:OnDelete()
  UIManager:DeleteWindow(UIWindowTypeID.DungeonLevelDetail)
  if self._delayTimerId ~= nil then
    TimerManager:StopTimer(self._delayTimerId)
    self._delayTimerId = nil
  end
  base.OnDelete(self)
end

return UIActXMas22DunRepeat

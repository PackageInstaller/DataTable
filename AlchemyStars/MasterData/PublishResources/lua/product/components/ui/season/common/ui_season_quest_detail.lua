_class("UISeasonQuestDetail", UIController)
UISeasonQuestDetail = UISeasonQuestDetail

function UISeasonQuestDetail:LoadDataOnEnter(TT, res, uiParams)
  local list = uiParams and uiParams[1]
  if list == nil or #list == 0 then
    Log.exception("UISeasonQuestDetail:LoadDataOnEnter() list is empty")
    res:SetSucc(false)
  end
end

function UISeasonQuestDetail:OnShow(uiParams)
  local list = uiParams and uiParams[1]
  self._data = list
  self:_SetData(1)
  self:_PlayAnim(1)
end

function UISeasonQuestDetail:OnHide()
end

function UISeasonQuestDetail:_SetData(index)
  self._index = Mathf.Clamp(index, 1, #self._data)
  self:_SetPage(index)
  self:_SetBtnObj(index)
  local id = self._data[index]
  if id == nil then
    Log.exception("UISeasonQuestDetail:_SetData(", index, ") id = nil")
    return
  end
  local cfg = UISeasonCfgHelper.CfgSeason_QuestItemClient(id)
  self:_SetTitle(cfg)
end

function UISeasonQuestDetail:_PlayAnim(type, callback)
  local tb = {
    {
      animName = "uieffanim_UISeasonQuestDetail_in",
      duration = 867
    },
    {
      animName = "uieffanim_UISeasonQuestDetail_middlePreBtn",
      duration = 667
    },
    {
      animName = "uieffanim_UISeasonQuestDetail_out",
      duration = 233
    }
  }
  UIWidgetHelper.PlayAnimation(self, "_anim", tb[type].animName, tb[type].duration, callback)
end

function UISeasonQuestDetail:_SetTitle(cfg)
  local title, desc = cfg.Title, cfg.Desc
  UIWidgetHelper.SetLocalizationText(self, "_txtTitle", StringTable.Get(title))
  UIWidgetHelper.SetLocalizationText(self, "_txtDesc", StringTable.Get(desc))
end

function UISeasonQuestDetail:_SetPage(index)
  local all = #self._data
  self:GetGameObject("_txtPage"):SetActive(all ~= 1)
  local str = string.format("-%s/%s-", index, all)
  UIWidgetHelper.SetLocalizationText(self, "_txtPage", str)
end

function UISeasonQuestDetail:_SetBtnObj(index)
  local isPre = index ~= 1
  self:GetGameObject("PreBtn"):SetActive(isPre)
  local isNext = index ~= #self._data
  self:GetGameObject("NextBtn"):SetActive(isNext)
end

function UISeasonQuestDetail:CloseBtnOnClick(go)
  self:_PlayAnim(3, function()
    self:CloseDialog()
  end)
end

function UISeasonQuestDetail:PreBtnOnClick(go)
  self:_ChangePage(self._index - 1)
end

function UISeasonQuestDetail:NextBtnOnClick(go)
  self:_ChangePage(self._index + 1)
end

function UISeasonQuestDetail:_ChangePage(index)
  self:_PlayAnim(2)
  self:StartTask(function(TT)
    YIELD(TT, 300)
    self:_SetData(index)
  end)
end

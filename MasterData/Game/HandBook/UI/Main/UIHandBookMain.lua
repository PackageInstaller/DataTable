local UIHandBookMain = class("UIHandBookMain", UIBaseWindow)
local base = UIBaseWindow
local eEnterType = require("Game.HandBook.HandBookEnum").eEnterType
local cs_Tweening = CS.DG.Tweening
local CS_ClientConsts = CS.ClientConsts

function UIHandBookMain:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseHandBook)
  UIUtil.AddButtonListener(self.ui.heroRelation, self, self.OnClickHero)
  UIUtil.AddButtonListener(self.ui.skin, self, self.OnClickSkin)
  UIUtil.AddButtonListener(self.ui.activity, self, self.OnClickActivity)
  UIUtil.AddButtonListener(self.ui.card, self, self.OnClickCard)
  self.ui.skin_slider.value = 0
  self.ui.hero_slider.value = 0
  self._lockedStateDic = {}
  if CS.ClientConsts.IsAudit then
    for i, v in ipairs(self.ui.lockObjs) do
      v:SetActive(false)
    end
  end
  if CS_ClientConsts.IsAudit then
    self.ui.activity.gameObject:SetActive(false)
  end
end

function UIHandBookMain:InitHandBookMain()
  self._hbCtrl = ControllerManager:GetController(ControllerTypeId.HandBook, true)
  self._refreshFunc = {
    [eEnterType.Hero] = BindCallback(self, self.__RefreshHBMainHero),
    [eEnterType.Skin] = BindCallback(self, self.__RefreshHBMainSkin),
    [eEnterType.Activity] = BindCallback(self, self.__RefreshHBMainActivity),
    [eEnterType.Card] = BindCallback(self, self.__RefreshHBMainCard)
  }
  self._isInInit = true
  for enterType, cfg in pairs(ConfigData.handbook) do
    local flag = CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para1)
    if not flag then
      self._lockedStateDic[enterType] = true
    end
    local refreshFunc = self._refreshFunc[enterType]
    if refreshFunc ~= nil then
      refreshFunc(true)
    else
      error("入口刷新方法不存在")
    end
  end
  self._isInInit = false
end

function UIHandBookMain:OnClickHero()
  if self._lockedStateDic[eEnterType.Hero] then
    return
  end
  self._hbCtrl:OpenHandBookHeroIndex()
end

function UIHandBookMain:OnClickSkin()
  if self._lockedStateDic[eEnterType.Skin] then
    return
  end
  self._hbCtrl:OpenHandBookHeroSkinTheme()
end

function UIHandBookMain:OnClickActivity()
  if self._lockedStateDic[eEnterType.Activity] then
    return
  end
  self._hbCtrl:OpenHandBookActivity(self.ui.activity.transform.position)
end

function UIHandBookMain:OnClickCard()
  if self._lockedStateDic[eEnterType.Card] then
    return
  end
  self._hbCtrl:OpenHandBookCard()
end

function UIHandBookMain:__GetLockedDes(enterType)
  local cfg = ConfigData.handbook[enterType]
  local des = CheckCondition.GetUnlockInfoLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para1)
  return des
end

function UIHandBookMain:CheckAndRefreshCollect()
  for enterType, _ in pairs(self._lockedStateDic) do
    local cfg = ConfigData.handbook[enterType]
    local flag = CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para1)
    if flag then
      self._lockedStateDic[enterType] = nil
      self._refreshFunc[enterType](true)
    end
  end
end

function UIHandBookMain:RefreshHBCollectByType(enterType)
  if not self._lockedStateDic[enterType] then
    self._refreshFunc[enterType]()
  end
end

function UIHandBookMain:__RefreshHBMainHero(isRefreshActive)
  local enterType = eEnterType.Hero
  local flag = not self._lockedStateDic[enterType]
  local cfg = ConfigData.handbook[enterType]
  if self._isInInit then
    self.ui.hero_hBNameCN.text = LanguageUtil.GetLocaleText(cfg.title)
    self.ui.hero_hBNameEN.text = LanguageUtil.GetLocaleText(cfg.title_en)
    if not flag then
      self.ui.tex_hero_LockDes.text = self:__GetLockedDes(enterType)
    end
  end
  if isRefreshActive then
    self.ui.hero_lock:SetActive(not flag)
    self.ui.hero_slider.gameObject:SetActive(flag)
    self.ui.hero_tex_Percent.gameObject:SetActive(flag and cfg.collect_bar)
  end
  if flag and cfg.collect_bar then
    local count, totalCount = self._hbCtrl:GetHBHeroAllCollect()
    local process = count / (totalCount or 1)
    process = math.clamp(process, 0, 1)
    self.ui.hero_tex_Percent.text = tostring(math.ceil(process * 100)) .. "%"
    self.ui.hero_slider:DOComplete()
    self.ui.hero_slider:DOValue(process, 0.5):SetEase(cs_Tweening.Ease.OutQuad)
  end
end

function UIHandBookMain:__RefreshHBMainSkin(isRefreshActive)
  local enterType = eEnterType.Skin
  local flag = not self._lockedStateDic[enterType]
  local cfg = ConfigData.handbook[enterType]
  if self._isInInit then
    self.ui.skin_hBNameCN.text = LanguageUtil.GetLocaleText(cfg.title)
    self.ui.skin_hBNameEN.text = LanguageUtil.GetLocaleText(cfg.title_en)
    if not flag then
      self.ui.tex_skin_LockDes.text = self:__GetLockedDes(enterType)
    end
  end
  if isRefreshActive then
    self.ui.skin_lock:SetActive(not flag)
    self.ui.skin_slider.gameObject:SetActive(flag)
    self.ui.skin_tex_Percent.gameObject:SetActive(flag and cfg.collect_bar)
  end
  if flag and cfg.collect_bar then
    local count, totalCount = self._hbCtrl:GetHBSkinAllCollect()
    local process = count / (totalCount or 1)
    process = math.clamp(process, 0, 1)
    self.ui.skin_tex_Percent.text = tostring(math.floor(process * 100)) .. "%"
    self.ui.skin_slider:DOComplete()
    self.ui.skin_slider:DOValue(process, 0.5):SetEase(cs_Tweening.Ease.OutQuad)
  end
end

function UIHandBookMain:__RefreshHBMainActivity(isRefreshActive)
  local enterType = eEnterType.Activity
  local flag = not self._lockedStateDic[enterType]
  if self._isInInit then
    local cfg = ConfigData.handbook[enterType]
    self.ui.act_hBNameCN.text = LanguageUtil.GetLocaleText(cfg.title)
    self.ui.act_hBNameEN.text = LanguageUtil.GetLocaleText(cfg.title_en)
    if not flag then
      self.ui.tex_act_LockDes.text = self:__GetLockedDes(enterType)
    end
  end
  if isRefreshActive then
    self.ui.act_lock:SetActive(not flag)
  end
end

function UIHandBookMain:__RefreshHBMainCard(isRefreshActive)
  local enterType = eEnterType.Card
  local flag = not self._lockedStateDic[enterType]
  local isForeceHide = ConfigData.handbook[enterType].is_hide
  if isForeceHide then
    self.ui.card.gameObject:SetActive(false)
    self.ui.obj_cardHideLock:SetActive(true)
    return
  end
  if self._isInInit then
    local cfg = ConfigData.handbook[enterType]
    self.ui.card_hBNameCN.text = LanguageUtil.GetLocaleText(cfg.title)
    self.ui.card_hBNameEN.text = LanguageUtil.GetLocaleText(cfg.title_en)
    if not flag then
      self.ui.tex_card_LockDes.text = self:__GetLockedDes(enterType)
    end
  end
  if isRefreshActive then
    self.ui.card_lock:SetActive(not flag)
    self.ui.card_slider.gameObject:SetActive(flag)
    self.ui.card_tex_Percent.gameObject:SetActive(flag)
  end
  if flag then
    local process = self._hbCtrl:GetHBCardAllCollect()
    self.ui.card_tex_Percent.text = tostring(math.floor(process * 100)) .. "%"
    self.ui.card_slider:DOComplete()
    self.ui.card_slider:DOValue(process, 0.5):SetEase(cs_Tweening.Ease.OutQuad)
  end
end

function UIHandBookMain:OnCloseHandBook()
  self:OnCloseWin()
  self:Delete()
  UIManager:DeleteWindow(UIWindowTypeID.HandBookBackground)
  ControllerManager:DeleteController(ControllerTypeId.HandBook)
end

return UIHandBookMain

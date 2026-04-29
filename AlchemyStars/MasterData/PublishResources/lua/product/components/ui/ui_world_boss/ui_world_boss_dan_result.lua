_class("UIWorldBossDanResult", UIController)
UIWorldBossDanResult = UIWorldBossDanResult

function UIWorldBossDanResult:Constructor()
  self._loginModule = self:GetModule(LoginModule)
  self._timeEvents = {}
end

function UIWorldBossDanResult:OnShow(uiParams)
  self._danValue = uiParams[1]
  self._danRank = uiParams[2]
  self._danName = uiParams[3]
  self._missionId = uiParams[4]
  self:_GetComponents()
  self:_OnValue()
  self:StartTask(function(TT)
    local lockName = "UIWorldBossDanResult_Show"
    self:Lock(lockName)
    YIELD(TT, 1000)
    self:UnLock(lockName)
  end)
end

function UIWorldBossDanResult:OnHide()
  for key, value in pairs(self._timeEvents) do
    GameGlobal.Timer():CancelEvent(value)
  end
end

function UIWorldBossDanResult:_GetComponents()
  self._danNameText = self:GetUIComponent("UILocalizationText", "DanName")
  self._dan = self:GetUIComponent("UISelectObjectPath", "Dan")
  self._danGo = self:GetGameObject("Dan")
  self._danRect = self:GetUIComponent("RectTransform", "Dan")
  self._bgBtn = self:GetGameObject("bgBtn")
  self._useAnim = true
  if self._useAnim then
    self:_InitWidgetBadgeAnim()
  end
end

function UIWorldBossDanResult:_InitWidgetBadgeAnim()
  self._anim = self:GetUIComponent("Animation", "UIWorldBossDanResult")
  self._curDanAreaGoForAnim = self:GetGameObject("curItem")
  self._curBadgeIconBase = self:GetUIComponent("RawImageLoader", "CurDanIcon")
  self._curBadgeIconBaseImg = self:GetUIComponent("RawImage", "CurDanIcon")
  self._curBadgeIconBaseForAnimMr = self:GetUIComponent("MeshRenderer", "CurDanIconForAnim")
  self._curBadgeMaskMr = self:GetUIComponent("MeshRenderer", "CurDanMask")
  self._curBadgeIconBaseGo = self:GetGameObject("CurDanIcon")
  self._curBadgePlusIconGo = self:GetGameObject("CurDanPlusIcon")
  self._curBadgeIconFrontGo = self:GetGameObject("CurDanIconFrontBg")
  self._curBadgeIconFrontText = self:GetUIComponent("UILocalizationText", "CurDanIconFrontText")
  self._curBadgeIconFrontTextBack = self:GetUIComponent("UILocalizationText", "CurDanIconFrontTextBack")
end

function UIWorldBossDanResult:_OnValue()
  if self._useAnim then
    self:_CheckDoBadgeAnim()
  else
    UIWorldBossHelper.InitDanBadge(self._dan, self._danGo, self._danRect, self._danValue, self._danRank)
  end
  self._danNameText:SetText(StringTable.Get(self._danName))
end

function UIWorldBossDanResult:_CheckDoBadgeAnim()
  if UIWorldBossHelper.IsNoDan(self._danValue, self._danRank) then
    return
  end
  local animTime = 4433
  if self._danRank > 0 then
    self:_PlayBadgeAnim("uieff_WorldBoss_Dan_NewDan_Ret", animTime)
  elseif UIWorldBossHelper.IsNormalTopDan(self._danValue, self._danRank) then
    self:_PlayBadgeAnim("uieff_WorldBoss_Dan_NewDan_Ret", animTime)
  else
    self:_PlayBadgeAnim("uieff_WorldBoss_Dan_NewDan_Y_Ret", animTime)
  end
end

function UIWorldBossDanResult:_PlayBadgeAnim(animName, animTime)
  self:_FillCurBadge(self._danValue, self._danRank)
  self._anim:Play(animName)
  self:_LockForBadgeAnim(animTime)
end

function UIWorldBossDanResult:_FillCurBadge(danId, rankLevel)
  if UIWorldBossHelper.IsNoDan(danId, rankLevel) then
    self._curBadgeIconBase:LoadImage("1601191_logo")
    self._curBadgeIconBaseGo:SetActive(false)
    self._curBadgeIconFrontGo:SetActive(false)
    return
  end
  local badgeBase = UIWorldBossHelper.GetDanBadgeBase(danId, rankLevel)
  if badgeBase then
    self._curBadgeIconBase:LoadImage(badgeBase)
    self._curBadgeIconBaseForAnimMr.sharedMaterial:SetTexture("_MainTex", self._curBadgeIconBaseImg.material.mainTexture)
    self._curBadgeMaskMr.sharedMaterial:SetTexture("_MainTex", self._curBadgeIconBaseImg.material.mainTexture)
    if 0 < rankLevel then
      self._curBadgeIconFrontGo:SetActive(true)
      self._curBadgeIconFrontText:SetText(tostring(rankLevel))
      if self._curBadgeIconFrontTextBack then
        self._curBadgeIconFrontTextBack:SetText(tostring(rankLevel))
      end
    else
      self._curBadgeIconFrontGo:SetActive(false)
    end
    local bPlus = UIWorldBossHelper.IsPlusDan(danId, rankLevel)
    self._curBadgePlusIconGo:SetActive(bPlus)
  end
end

function UIWorldBossDanResult:_LockForBadgeAnim(timeLen)
  self:Lock("wbdr_LockForBadgeAnim")
  local te = GameGlobal.Timer():AddEvent(timeLen, function()
    self:UnLock("wbdr_LockForBadgeAnim")
  end)
  table.insert(self._timeEvents, te)
end

function UIWorldBossDanResult:ConfirmBtnOnClick(go)
  self:_Close()
end

function UIWorldBossDanResult:BgBtnOnClick(go)
  self:_Close()
end

function UIWorldBossDanResult:_Close()
  LocalDB.SetInt("UIWorldBossDanResult" .. self._loginModule:GetRoleShowID(), self._missionId)
  self:CloseDialog()
end

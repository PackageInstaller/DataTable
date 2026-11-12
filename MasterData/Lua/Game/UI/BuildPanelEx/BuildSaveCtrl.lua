local BuildSaveCtrl = class("BuildSaveCtrl", BaseCtrl)
BuildSaveCtrl._mapNodeConfig = {
  btnRename = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Rename"
  },
  img_BottomBar = {},
  btn_Preference = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Preference"
  },
  btn_PreferenceIcon = {sComponentName = "Button"},
  btn_Delete = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_DeleteBuild"
  },
  btn_Save = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SaveBuild"
  },
  btn_Lock = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Lock"
  },
  txtBuildLock = {sComponentName = "TMP_Text"},
  txt_Delete = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Btn_Del"
  },
  txt_Save = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Btn_Save"
  },
  btn_LockIcon = {sComponentName = "Button"},
  txtLike = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Btn_Like"
  },
  Mask = {
    sComponentName = "CanvasGroup"
  },
  goDeleteResult = {},
  txt_DeleteResultHintItemCount = {sComponentName = "Text"},
  txt_DeleteResultTitle = {
    sComponentName = "Text",
    sLanguageId = "RoguelikeBuild_Common_HintTitle"
  },
  txt_DeleteResult = {sComponentName = "Text", sLanguageId = "BUILD_08"},
  btn_DeleteResultClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_DeleteResult"
  },
  btn_DeleteResultConfirm = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_DeleteResult"
  },
  txt_btnDeleteResultConfirm = {
    sComponentName = "Text",
    sLanguageId = "RoguelikeBuild_Common_BtnConfirm"
  },
  goBg = {sNodeName = "---BG---"},
  goblur = {
    sNodeName = "t_fullscreen_blur_black"
  },
  goBuildContent = {},
  goBonus = {
    sCtrlName = "Game.UI.BuildPanelEx.RogueBonusCtrl"
  },
  BuildDetail = {
    sCtrlName = "Game.UI.BuildPanelEx.BuildDetailItemCtrl"
  },
  PerkList = {
    sCtrlName = "Game.UI.BuildPanelEx.BuildPerkCtrl"
  }
}
BuildSaveCtrl._mapEventConfig = {}

function BuildSaveCtrl:InitPanel()
  self._mapNode.BuildDetail:Refresh(self.mapBuild)
  self._mapNode.PerkList:Refresh(self.mapBuild)
  self.bLock = self.mapBuild.bLock
  self._mapNode.btn_LockIcon.interactable = self.bLock
  NovaAPI.SetTMPText(self._mapNode.txtBuildLock, self.bLock and ConfigTable.GetUIText("RoguelikeBuild_Save_Lock") or ConfigTable.GetUIText("RoguelikeBuild_Save_Unlock"))
  NovaAPI.SetTMPColor(self._mapNode.txtBuildLock, self.bLock and Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764) or Color(0.5803921568627451, 0.6666666666666666, 0.7529411764705882))
end

function BuildSaveCtrl:InitPanelDelete()
  self._mapNode.goBuildContent:SetActive(false)
  self._mapNode.goBg:SetActive(false)
  
  local function wait1()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
  end
  
  local function wait2()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    NovaAPI.SetText(self._mapNode.txt_DeleteResultHintItemCount, self.mapBuild)
    self._mapNode.goDeleteResult:SetActive(true)
  end
  
  cs_coroutine.start(wait1)
  cs_coroutine.start(wait2)
end

function BuildSaveCtrl:OpenConfirmHint()
  local nCoin = math.floor(math.min(math.max(self.mapBuild.nScore / tonumber(self.tbCoinRate[1]), tonumber(self.tbCoinRate[2])), tonumber(self.tbCoinRate[3])))
  local sTip = ""
  if self.mapBuild.mapRank.Rarity == GameEnum.itemRarity.SSR then
    sTip = ConfigTable.GetUIText("BUILD_07")
  else
    sTip = ConfigTable.GetUIText("BUILD_10")
  end
  local msg = {
    nType = AllEnum.MessageBox.Item,
    sContent = sTip,
    tbItem = {
      [1] = {
        nTid = AllEnum.CoinItemId.FRRewardCurrency,
        nCount = nCoin
      }
    },
    callbackConfirm = function()
      local function callback(mapChangeInfo)
        UTILS.OpenReceiveByChangeInfo(mapChangeInfo, function()
          self:ClosePanel()
        end)
      end
      
      PlayerData.Build:SaveBuild(self.mapBuild.nBuildId, true, self.bLock, self.bPreference, self.sName, callback)
    end
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function BuildSaveCtrl:Awake()
  self._mapNode.goBuildContent:SetActive(false)
  if NovaAPI.GetCurrentModuleName() ~= "MainMenuModuleScene" then
    CS.AdventureModuleHelper.PauseLogic()
  end
  self.tbCoinRate = ConfigTable.GetConfigArray("StarTowerBuildTransformParas")
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.bSuccess = tbParam[1]
    self.mapBuild = tbParam[2]
    self.tbBonus = tbParam[3]
  end
end

function BuildSaveCtrl:OnEnable()
  if type(self.mapBuild) == "table" then
    self:InitPanel()
  else
    self:InitPanelDelete()
  end
  if NovaAPI.GetCurrentModuleName() ~= "MainMenuModuleScene" then
    self._mapNode.goBg:SetActive(false)
    self._mapNode.goblur:SetActive(true)
  else
    self._mapNode.goBg:SetActive(true)
    self._mapNode.goblur:SetActive(false)
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goBuildContent:SetActive(true)
  end
  
  cs_coroutine.start(wait)
end

function BuildSaveCtrl:OnDisable()
end

function BuildSaveCtrl:OnDestroy()
end

function BuildSaveCtrl:OnRelease()
end

function BuildSaveCtrl:ClosePanel()
  if NovaAPI.GetCurrentModuleName() == "MainMenuModuleScene" then
    EventManager.Hit(EventId.CloesCurPanel)
  else
    CS.AdventureModuleHelper.ResumeLogic()
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.Mask, 0)
    self._mapNode.Mask.gameObject:SetActive(true)
    local sequence = DOTween.Sequence()
    sequence:Append(self._mapNode.Mask:DOFade(1, 0.5):SetUpdate(true))
    sequence:AppendCallback(function()
      if self.bSuccess then
        NovaAPI.EnterModule("MainMenuModuleScene", true)
      else
        local function levelEndCallback()
          EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
          
          NovaAPI.EnterModule("MainMenuModuleScene", true)
        end
        
        EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
        CS.AdventureModuleHelper.LevelStateChanged(true)
      end
    end)
    sequence:SetUpdate(true)
  end
end

function BuildSaveCtrl:OnBtnClick_Preference(btn)
  self.bPreference = not self.bPreference
  self._mapNode.btn_PreferenceIcon.interactable = self.bPreference
  NovaAPI.SetTMPColor(self._mapNode.txtLike, self.bPreference and Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764) or Color(0.5803921568627451, 0.6666666666666666, 0.7529411764705882))
end

function BuildSaveCtrl:OnBtnClick_Lock(btn)
  self.bLock = not self.bLock
  self._mapNode.btn_LockIcon.interactable = self.bLock
  NovaAPI.SetTMPText(self._mapNode.txtBuildLock, self.bLock and ConfigTable.GetUIText("RoguelikeBuild_Save_Lock") or ConfigTable.GetUIText("RoguelikeBuild_Save_Unlock"))
  NovaAPI.SetTMPColor(self._mapNode.txtBuildLock, self.bLock and Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764) or Color(0.5803921568627451, 0.6666666666666666, 0.7529411764705882))
end

function BuildSaveCtrl:OnBtnClick_DeleteBuild(btn)
  if self.mapBuild.mapRank.Rarity == GameEnum.itemRarity.SSR then
    self:OpenConfirmHint()
    return
  end
  
  local function callback(mapChangeInfo)
    UTILS.OpenReceiveByChangeInfo(mapChangeInfo, function()
      self:ClosePanel()
    end)
  end
  
  PlayerData.Build:SaveBuild(self.mapBuild.nBuildId, true, self.bLock, self.bPreference, self.sName, callback)
end

function BuildSaveCtrl:OnBtnClick_SaveBuild(btn)
  local function callback()
    local msg = {
      nType = AllEnum.MessageBox.Alert,
      
      sContent = ConfigTable.GetUIText("BUILD_09"),
      callbackConfirm = function()
        self:ClosePanel()
      end
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
    btn.interactable = true
  end
  
  btn.interactable = false
  PlayerData.Build:SaveBuild(self.mapBuild.nBuildId, false, self.bLock, self.bPreference, self.sName, callback)
end

function BuildSaveCtrl:OnBtnClick_Rename(btn)
  local function callback(sName)
    self._mapNode.BuildDetail:SetName(sName)
    
    self.sName = sName
  end
  
  EventManager.Hit(EventId.OpenPanel, PanelId.BuildRename, self.mapBuild, callback, true)
end

function BuildSaveCtrl:OnBtnClick_DeleteResult(btn)
  self._mapNode.goDeleteResult:SetActive(false)
  self:ClosePanel()
end

return BuildSaveCtrl

local StarTowerBuildSaveCtrl = class("StarTowerBuildSaveCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
StarTowerBuildSaveCtrl._mapNodeConfig = {
  goBg = {sNodeName = "---BG---"},
  goblur = {
    sNodeName = "t_fullscreen_blur_black"
  },
  goBuildContent = {},
  BuildDetail = {
    sCtrlName = "Game.UI.StarTower.Build.StarTowerBuildDetailItemCtrl"
  },
  ContentList = {
    sCtrlName = "Game.UI.StarTower.Build.StarTowerBuildContentCtrl"
  },
  btnLock = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Lock"
  },
  btnPreference = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Preference"
  },
  btnSave = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Save"
  },
  btnDelete = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Delete"
  },
  btnPreferenceIcon = {sComponentName = "Button"},
  btnRename = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Rename"
  },
  btnLockIcon = {sComponentName = "Button"},
  txtBuildLock = {sComponentName = "TMP_Text"},
  txtLike = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_Like"
  },
  txtSave = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_Save"
  },
  Mask = {
    sComponentName = "CanvasGroup"
  },
  goDeleteResult = {},
  goDeleteAnim = {
    sNodeName = "goDeleteResult",
    sComponentName = "Animator"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "RoguelikeBuild_Common_HintTitle"
  },
  txtDeleteTip = {sComponentName = "TMP_Text", sLanguageId = "BUILD_08"},
  imgRewardIcon = {sComponentName = "Image"},
  txtDeleteRewardCount = {sComponentName = "TMP_Text"},
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_DeleteResult"
  },
  btnConfirm2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_DeleteResult"
  },
  txtDeleteBtn = {
    sComponentName = "TMP_Text",
    sLanguageId = "RoguelikeBuild_Common_BtnConfirm"
  }
}
StarTowerBuildSaveCtrl._mapEventConfig = {}
StarTowerBuildSaveCtrl._mapRedDotConfig = {}

function StarTowerBuildSaveCtrl:InitPanel()
  self._mapNode.goBuildContent:SetActive(true)
  self._mapNode.BuildDetail:Refresh(self.mapBuild)
  self._mapNode.ContentList:Refresh(self.mapBuild)
  self.bLock = self.mapBuild.bLock
  self._mapNode.btnLockIcon.interactable = self.bLock
  NovaAPI.SetTMPText(self._mapNode.txtBuildLock, self.bLock and ConfigTable.GetUIText("RoguelikeBuild_Save_Lock") or ConfigTable.GetUIText("RoguelikeBuild_Save_Unlock"))
  NovaAPI.SetTMPColor(self._mapNode.txtBuildLock, self.bLock and Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764) or Color(0.5803921568627451, 0.6666666666666666, 0.7529411764705882))
end

function StarTowerBuildSaveCtrl:InitPanelDelete()
  self._mapNode.goBuildContent:SetActive(false)
  self._mapNode.goBg:SetActive(false)
  self._mapNode.goDeleteResult:SetActive(true)
  self._mapNode.goDeleteAnim:Play("t_window_04_t_in")
  NovaAPI.SetTMPText(self._mapNode.txtDeleteRewardCount, string.format("x%d", self.mapBuild))
  local nDeleteReturnId = ConfigTable.GetConfigNumber("StarTowerBuildDeleteReturnItemId")
  local mapCfg = ConfigTable.GetData_Item(nDeleteReturnId)
  if mapCfg ~= nil then
    self:SetPngSprite(self._mapNode.imgRewardIcon, mapCfg.Icon)
  end
end

function StarTowerBuildSaveCtrl:OpenConfirmHint()
  local nCoin = math.floor(math.min(math.max(self.mapBuild.nScore / tonumber(self.tbCoinRate[1]), tonumber(self.tbCoinRate[2])), tonumber(self.tbCoinRate[3])))
  
  local function CheckCallback()
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
  
  PlayerData.Build:CheckCoinMax(nCoin, CheckCallback)
end

function StarTowerBuildSaveCtrl:ClosePanel()
  if NovaAPI.GetCurrentModuleName() == "MainMenuModuleScene" then
    EventManager.Hit(EventId.CloesCurPanel)
    PlayerData.Base:CheckNextDayForSweep()
  else
    PanelManager.InputEnable(nil, true)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.Mask, 0)
    self._mapNode.Mask.gameObject:SetActive(true)
    local sequence = DOTween.Sequence()
    sequence:Append(self._mapNode.Mask:DOFade(1, 0.5):SetUpdate(true))
    sequence:AppendCallback(function()
      if self.bSuccess then
        NovaAPI.EnterModule("MainMenuModuleScene", true, 17)
      else
        local function levelEndCallback()
          EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
          
          NovaAPI.EnterModule("MainMenuModuleScene", true, 17)
        end
        
        EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
        CS.AdventureModuleHelper.LevelStateChanged(true, 0, true)
      end
    end)
    sequence:SetUpdate(true)
  end
end

function StarTowerBuildSaveCtrl:Awake()
  self._mapNode.goBuildContent:SetActive(false)
  if NovaAPI.GetCurrentModuleName() ~= "MainMenuModuleScene" then
    PanelManager.InputDisable()
  end
  self.tbCoinRate = ConfigTable.GetConfigArray("StarTowerBuildTransformParas")
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.bSuccess = tbParam[1]
    self.mapBuild = tbParam[2]
    if type(tbParam[3]) == "function" then
      self._fnCloseCallback = tbParam[3]
    else
      self.bSweep = tbParam[4]
    end
  end
end

function StarTowerBuildSaveCtrl:OnEnable()
  if NovaAPI.GetCurrentModuleName() ~= "MainMenuModuleScene" then
    self._mapNode.goBg:SetActive(false)
    self._mapNode.goblur:SetActive(true)
  else
    self._mapNode.goBg:SetActive(true)
    self._mapNode.goblur:SetActive(false)
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if type(self.mapBuild) == "table" then
      self:InitPanel()
    else
      self:InitPanelDelete()
    end
  end
  
  cs_coroutine.start(wait)
end

function StarTowerBuildSaveCtrl:OnDisable()
  if self._fnCloseCallback ~= nil then
    local fnCloseCallback = self._fnCloseCallback
    self._fnCloseCallback = nil
    fnCloseCallback()
  end
end

function StarTowerBuildSaveCtrl:OnDestroy()
end

function StarTowerBuildSaveCtrl:OnRelease()
end

function StarTowerBuildSaveCtrl:OnBtnClick_Rename()
  local function callback(sName)
    self._mapNode.BuildDetail:SetName(sName)
    
    self.sName = sName
  end
  
  EventManager.Hit(EventId.OpenPanel, PanelId.BuildRename, self.mapBuild, callback, true, self.sName)
end

function StarTowerBuildSaveCtrl:OnBtnClick_Lock()
  self.bLock = not self.bLock
  self._mapNode.btnLockIcon.interactable = self.bLock
  NovaAPI.SetTMPText(self._mapNode.txtBuildLock, self.bLock and ConfigTable.GetUIText("RoguelikeBuild_Save_Lock") or ConfigTable.GetUIText("RoguelikeBuild_Save_Unlock"))
  NovaAPI.SetTMPColor(self._mapNode.txtBuildLock, self.bLock and Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764) or Color(0.5803921568627451, 0.6666666666666666, 0.7529411764705882))
end

function StarTowerBuildSaveCtrl:OnBtnClick_Preference()
  self.bPreference = not self.bPreference
  self._mapNode.btnPreferenceIcon.interactable = self.bPreference
  NovaAPI.SetTMPColor(self._mapNode.txtLike, self.bPreference and Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764) or Color(0.5803921568627451, 0.6666666666666666, 0.7529411764705882))
end

function StarTowerBuildSaveCtrl:OnBtnClick_Save(btn)
  local function callback()
    local msg = {
      nType = AllEnum.MessageBox.Alert,
      
      sContent = ConfigTable.GetUIText("BUILD_09"),
      callbackConfirm = function()
        self:ClosePanel()
      end
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
  
  PlayerData.Build:SaveBuild(self.mapBuild.nBuildId, false, self.bLock, self.bPreference, self.sName, callback)
end

function StarTowerBuildSaveCtrl:OnBtnClick_Delete()
  if self.bLock then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Build_LockDelete"))
    return
  end
  self:OpenConfirmHint()
end

function StarTowerBuildSaveCtrl:OnBtnClick_DeleteResult()
  self._mapNode.goDeleteResult:SetActive(false)
  self:ClosePanel()
end

return StarTowerBuildSaveCtrl

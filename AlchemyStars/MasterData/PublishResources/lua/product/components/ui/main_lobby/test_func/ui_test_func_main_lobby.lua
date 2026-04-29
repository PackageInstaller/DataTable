_class("UITestFuncMainLobby", UICustomWidget)
UITestFuncMainLobby = UITestFuncMainLobby

function UITestFuncMainLobby:SetData(data)
  self._main = UITestFuncBtnManager:New(self, "Content_Main", "PagePool")
  self:_SetContent_Main(self._main)
  self._main:SpawnBtns()
  self._sub = UITestFuncBtnManager:New(self, "Content_Sub", "PagePool")
  self:_SetContent_Sub(self._sub)
  self._sub:SpawnBtns()
end

function UITestFuncMainLobby:_SetContent_Main(manager)
  manager:AddBtn_SwitchState("局内测试", UIStateType.UICoreGameTest)
  manager:AddBtn_SwitchState("剧情测试", UIStateType.UIStoryViewer)
  manager:AddBtn_SwitchState("3D剧情", UIStateType.UICutsceneTest)
  manager:AddBtn_ShowDialog("赛季剧情测试", "UISeasonStoryController", 65010301)
  manager:AddBtn_SubPage("家园剧情测试", "UITestFuncHomelandStory", "UITestFunc_HomelandStory.prefab")
  manager:AddBtn_Default("场景测试", function()
    GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.CorGamePerformanceTest_Enter)
  end)
  manager:AddBtn_Default("局内技能测试", function()
    self:GetModule(SkillPerfModule):EnterCoreGame()
  end)
  manager:AddBtn_SubPage("LocalDB 测试", "UITestFuncLocalDB", "UITestFunc_LocalDB.prefab")
  manager:AddBtn_SubPage("Jump 测试", "UITestFuncJump", "UITestFunc_Jump.prefab")
  manager:AddBtn_SubPage("Guide Clear", "UITestFuncGuideClear", "UITestFunc_GuideClear.prefab")
  manager:AddBtn_SubPage("Server Time", "UITestFuncServerTime", "UITestFunc_ServerTime.prefab")
  manager:AddBtn_Toggle("活动调试开关", self:_GetToggleFunc_ActivityDebug())
  manager:AddBtn_ShowDialog("关卡测试", "UILevelTestController")
  manager:AddBtn_ShowDialog("赛季秘境入口", "UISeasonMazeEnterController")
end

function UITestFuncMainLobby:_SetContent_Sub(manager)
  manager:AddBtn_Default("崩溃测试", function()
    self:_CrashTest()
  end)
  manager:AddBtn_Default("清除登录状态", function()
    self:_ResetLoginState()
  end)
  manager:AddBtn_Default("掉线", function()
    self:_BackToLogin()
  end)
  manager:AddBtn_Default("IOS商店评分", function()
    self:_IosStoreReview()
  end)
  manager:AddBtn_Default("删除公告存档", function()
    self:_DeleteNoticeKey()
  end)
  manager:AddBtn_Default("恢复音频", function()
    self:_RecoveryAudio()
  end)
  manager:AddBtn_Default("心悦测试", function()
    UIXinyueHelper.OpenUrl()
  end)
  manager:AddBtn_Toggle("卡池计数查看", self:_GetToggleFunc_GamblePoolCount())
  manager:AddBtn_Default("战斗通行证", function()
    UIActivityBattlePassHelper.OpenMainController()
  end)
  manager:AddBtn_Default("战斗通行证-购买精英", function()
    UIActivityBattlePassHelper.OpenBuyGiftResultController(CampaignGiftType.ECGT_ADVANCED)
  end)
  manager:AddBtn_Default("战斗通行证-购买豪华", function()
    UIActivityBattlePassHelper.OpenBuyGiftResultController(CampaignGiftType.ECGT_LUXURY)
  end)
  manager:AddBtn_ShowDialog("通用活动调试窗口", "UIN28GronruPlatform")
  manager:AddBtn_ShowDialog("熔炼室", "UIAircraftItemSmeltController")
  manager:AddBtn_ShowDialog("战术模拟器", "UIAircraftTactic")
  manager:AddBtn_ShowDialog("活动中心-指定跳转", "UISideEnterCenterController", {
    campaign_type = 10060,
    single_mode = true,
    params = {true}
  })
  manager:AddBtn_ShowDialog("分享测试", "UIShareDemoController")
  manager:AddBtn_ShowDialog("好友链测试", "UIFriendsDemoController")
  manager:AddBtn_ShowDialog("赛季 S2", "UIS2MainController")
  manager:AddBtn_SwitchState("活动30商店买", UIStateType.UIN30ShopController)
  manager:AddBtn_Toggle("显示弹跳包围盒", function()
    BounceDebug.ShowObjRect = not BounceDebug.ShowObjRect
  end, function()
    return BounceDebug.ShowObjRect
  end)
  manager:AddBtn_Toggle("弹跳角色永生", function()
    BounceDebug.PlayerLiveForever = not BounceDebug.PlayerLiveForever
  end, function()
    return BounceDebug.PlayerLiveForever
  end)
end

function UITestFuncMainLobby:_CrashTest()
  local bigTable = {}
  local index = 1
  while true do
    bigTable[index] = {}
    for i = 1, 999999999 do
      bigTable[index][i] = tostring(index) .. [[
CrashCrashCrashCrashCrashCrashCrashCrashCrashCrash
                CrashCrashCrashCrashCrashCrashCrashCrashCrashCrash
                CrashCrashCrashCrashCrashCrashCrashCrashCrashCrash
                CrashCrashCrashCrashCrashCrashCrashCrashCrashCrash
                CrashCrashCrashCrashCrashCrashCrashCrashCrashCrash
                CrashCrashCrashCrashCrashCrashCrashCrashCrashCrash
                CrashCrashCrashCrashCrashCrashCrashCrashCrashCrash
                CrashCrashCrashCrashCrashCrashCrashCrashCrashCrash
                CrashCrashCrashCrashCrashCrashCrashCrashCrashCrash
                CrashCrashCrashCrashCrashCrashCrashCrashCrashCrash]] .. tostring(i)
    end
    index = index + 1
  end
end

function UITestFuncMainLobby:_ResetLoginState()
  LocalDB.Delete(LoginKeyName.FirstLogin)
  LocalDB.Delete(LoginKeyName.LoginPrivacy)
  LocalDB.Delete(LoginKeyName.LoginPUTime)
  LocalDB.Delete(LoginKeyName.ZoneId)
  LocalDB.Delete(LoginKeyName.FirstLaunchApp)
  LocalDB.Delete(LoginKeyName.PrivecyVersion)
  ToastManager.ShowToast("已清除")
end

function UITestFuncMainLobby:_BackToLogin()
  GameGlobal.GameLogic():BackToLogin(false, LoginModule, BackToLoginReason.LoginFailed, true, 303)
end

function UITestFuncMainLobby:_IosStoreReview()
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, StringTable.Get("str_common_guide_appraise_title"), StringTable.Get("str_common_guide_appraise_context"), function()
    local app_store_id = "6443444750"
    local srm = GameStore.StoreReviewManager:New()
    srm:RequestSystemBasedReview(app_store_id)
  end, nil, function()
  end, nil)
end

function UITestFuncMainLobby:_DeleteNoticeKey()
  local key1 = GameGlobal.GameLogic():GetOpenId() .. "SystemNotice"
  local key2 = GameGlobal.GameLogic():GetOpenId() .. "ActiveNotice"
  UnityEngine.PlayerPrefs.DeleteKey(key1)
  UnityEngine.PlayerPrefs.DeleteKey(key2)
  ToastManager.ShowToast("删除")
end

function UITestFuncMainLobby:_RecoveryAudio()
  require("tolua.reflection")
  tolua.loadassembly("CriMw.CriWare.Runtime")
  local type = typeof("CriWare.CriAtomPlugin")
  local func = tolua.getmethod(type, "Pause", typeof("System.Boolean"))
  func:Call(false)
  func:Destroy()
  ToastManager.ShowToast("恢复音频")
  Log.debug("恢复音频")
end

function UITestFuncMainLobby:_GetToggleFunc_ActivityDebug()
  local function click()
    local key = UIActivityHelper.GetDebugOpenKey()
    
    if LocalDB.HasKey(key) then
      ToastManager.ShowToast("Close")
      LocalDB.Delete(key)
    else
      LocalDB.SetInt(key, 1)
      ToastManager.ShowToast("Open")
    end
  end
  
  local function getValue()
    local key = UIActivityHelper.GetDebugOpenKey()
    local hasKey = LocalDB.HasKey(key)
    return hasKey
  end
  
  return click, getValue
end

function UITestFuncMainLobby:_GetToggleFunc_GamblePoolCount()
  local function click()
    local gambleModule = GameGlobal.GetModule(GambleModule)
    
    local value = gambleModule:GetShowPoolCountCalc()
    return gambleModule:SetShowPoolCountCalc(not value)
  end
  
  local function getValue()
    local gambleModule = GameGlobal.GetModule(GambleModule)
    return gambleModule:GetShowPoolCountCalc()
  end
  
  return click, getValue
end

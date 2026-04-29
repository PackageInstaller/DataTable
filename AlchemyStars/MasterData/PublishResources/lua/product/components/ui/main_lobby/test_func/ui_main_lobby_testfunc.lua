_class("UIMainLobbyTestFunc", UICustomWidget)
UIMainLobbyTestFunc = UIMainLobbyTestFunc

function UIMainLobbyTestFunc:_GetComponents()
  self._window = self:GetGameObject("TestFuncWindow")
  self._gameobj = self:GetGameObject()
  local btnTest = self:GetUIComponent("Image", "btnTest")
  btnTest.alphaHitTestMinimumThreshold = 0.1
end

function UIMainLobbyTestFunc:OnShow(uiParams)
  self:_GetComponents()
  self._window:SetActive(false)
  self._btnManager = UITestFuncBtnManager:New(self)
  self:_FillActiveGroupData(self._btnManager)
  local pool = self:GetUIComponent("UISelectObjectPath", "Group_Activity")
  self._btnManager:SpawnBtns(pool)
  self:ShowSaveHomeList()
end

function UIMainLobbyTestFunc:OnHide()
end

function UIMainLobbyTestFunc:Switch(show)
  self._gameobj:SetActive(show)
end

function UIMainLobbyTestFunc:TestFuncEntryOnClick()
  self._window:SetActive(true)
end

function UIMainLobbyTestFunc:TestFuncWindowOnClick()
  self._window:SetActive(false)
end

function UIMainLobbyTestFunc:storyTestBtnOnClick()
  self:SwitchState(UIStateType.UIStoryViewer)
end

function UIMainLobbyTestFunc:coreTestBtnOnClick()
  self:SwitchState(UIStateType.UICoreGameTest)
end

function UIMainLobbyTestFunc:cutsceneTestBtnOnClick()
  self:SwitchState(UIStateType.UICutsceneTest)
end

function UIMainLobbyTestFunc:crashTestBtnOnClick()
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

function UIMainLobbyTestFunc:DebugTestBtnOnClick()
  local key = UIActivityHelper.GetDebugOpenKey()
  if LocalDB.HasKey(key) then
    ToastManager.ShowToast("Close")
    LocalDB.Delete(key)
  else
    LocalDB.SetInt(key, 1)
    ToastManager.ShowToast("Open")
  end
end

function UIMainLobbyTestFunc:DBTestBtnOnClick()
  local obj = UIWidgetHelper.SpawnObject(self, "LocalDBPool", "UITestFuncLocalDB")
  obj:GetGameObject():SetActive(true)
end

function UIMainLobbyTestFunc:JumpTestBtnOnClick()
  local obj = UIWidgetHelper.SpawnObject(self, "JumpPool", "UITestFuncJump")
  obj:GetGameObject():SetActive(true)
end

function UIMainLobbyTestFunc:ActivityEntryTestBtnOnClick()
  local obj = UIWidgetHelper.SpawnObject(self, "ActivityEntryPool", "UITestFuncActivityEntry")
  obj:GetGameObject():SetActive(true)
end

function UIMainLobbyTestFunc:btnTestOnClick()
  local mSvrTime = GameGlobal.GetModule(SvrTimeModule)
  local nowTimestamp = mSvrTime:GetServerTime()
  Log.fatal("### btnTestOnClick", nowTimestamp)
  self:GuideBookStrTaskExportTable()
end

function UIMainLobbyTestFunc:GuideBookStrTaskExportTable()
  if GuideBookStrTask then
    GuideBookStrTask:GetInstance():ExportTable()
  end
end

function UIMainLobbyTestFunc:_FillActiveGroupData(btnManager)
  btnManager:_AddCallback("战斗通行证", function()
    UIActivityBattlePassHelper.OpenMainController()
  end)
  btnManager:_AddCallback("战斗通行证-购买精英", function()
    UIActivityBattlePassHelper.OpenBuyGiftResultController(CampaignGiftType.ECGT_ADVANCED)
  end)
  btnManager:_AddCallback("战斗通行证-购买豪华", function()
    UIActivityBattlePassHelper.OpenBuyGiftResultController(CampaignGiftType.ECGT_LUXURY)
  end)
  btnManager:_AddFunShowDialog("活动中心-回流", "UISideEnterCenterController", {
    {
      campaign_type = 10060,
      params = {true},
      single_mode = true
    }
  })
  btnManager:_AddFunShowDialog("熔炼室", "UIAircraftItemSmeltController")
  btnManager:_AddFunShowDialog("盗掘者迁徙季", "UIActivityGraveRobberMainController")
  btnManager:_AddFunShowDialog("战术模拟器", "UIAircraftTactic")
  btnManager:_AddFunShowDialog("N9答题测试", "UIN9AnswerControllerTest")
  btnManager:_AddFunSwitchState("周安爬塔", "UIStateType.UIWeekTower")
  btnManager:_AddFunShowDialog("N16答题测试", "UIN16AnswerControllerTest")
  btnManager:_AddFunShowDialog("UICampainEnter", "UICampainEnterController", {1})
  btnManager:_AddToggleFunc("卡池计数查看", function(value)
    local gambleModule = GameGlobal.GetModule(GambleModule)
    return gambleModule:SetShowPoolCountCalc(value)
  end, function()
    local gambleModule = GameGlobal.GetModule(GambleModule)
    return gambleModule:GetShowPoolCountCalc()
  end)
  btnManager:_AddFunSwitchState("伊芙活动", UIStateType.UIActivityEveSinsaMainController)
  btnManager:_AddFunSwitchState("樱龙活动", UIStateType.UISakuraEntryController)
  btnManager:_AddFunSwitchState("夏活1", UIStateType.UISummer1)
  btnManager:_AddFunSwitchState("夏活2", UIStateType.UISummer2)
  btnManager:_AddFunSwitchState("活动N5", UIStateType.UIActivityN5)
  btnManager:_AddFunSwitchState("活动N6", UIStateType.UIActivityN6)
  btnManager:_AddFunSwitchState("活动N7", UIStateType.UIActivityN7MainController)
  btnManager:_AddFunSwitchState("活动N8", UIStateType.UIActivityN8MainController)
  btnManager:_AddFunSwitchState("活动N9", UIStateType.UIActivityN9MainController)
  btnManager:_AddFunSwitchState("活动10", UIStateType.UIN10MainController)
  btnManager:_AddFunSwitchState("活动11", UIStateType.UIN11Main)
  btnManager:_AddFunSwitchState("活动12", UIStateType.UIN12MainController)
  btnManager:_AddFunSwitchState("活动13", UIStateType.UIN13MainController)
  btnManager:_AddFunSwitchState("活动14", UIStateType.UIN14Main)
  btnManager:_AddFunSwitchState("活动15", UIStateType.UIN15MainController)
  btnManager:_AddFunSwitchState("活动16", UIStateType.UIActivityN16MainController)
  btnManager:_AddFunSwitchState("活动17", UIStateType.UIN17MainController)
  btnManager:_AddFunSwitchState("活动18", UIStateType.UIN18Main)
  btnManager:_AddFunSwitchState("活动19", UIStateType.UIN19MainController)
  btnManager:_AddFunSwitchState("活动19P5", UIStateType.UIN19P5)
  btnManager:_AddFunSwitchState("活动20", UIStateType.UIActivityN20MainController)
  btnManager:_AddFunSwitchState("活动20", UIStateType.UIActivityN20MainController)
  btnManager:_AddFunSwitchState("活动21", UIStateType.UIN21Controller)
  btnManager:_AddFunSwitchState("活动22", UIStateType.UIActivityN22MainController)
  btnManager:_AddFunSwitchState("活动22 委托", UIStateType.UIN22EntrustStageController)
  btnManager:_AddFunSwitchState("活动27", UIStateType.UIN27Controller)
  btnManager:_AddFunShowDialog("活动回顾", "UIExtraSelect")
  btnManager:_AddFunShowDialog("卡莲高级时装复刻", "UIHauteCoutureDraw_Review")
  btnManager:_AddSubpageFunc("N25偶像", "UITestFuncSubpageN25Idol")
  btnManager:_AddFunSwitchState("活动27邮局", "UIN27PostInnerGameController")
  btnManager:_AddFunSwitchState("活动27邮局主界面", "UIN27MiniGameController")
  btnManager:_AddFunSwitchState("活动28AVG", "UIN28AVGMain")
  btnManager:_AddFunSwitchState("活动28小游戏", "UIN28GronruGameFlash")
  btnManager:_AddFunSwitchState("活动30商店买", "UIN30ShopController")
  btnManager:_AddToggleFunc("显示弹跳包围盒", function(value)
    BounceDebug.ShowObjRect = value
  end, function()
    return BounceDebug.ShowObjRect
  end)
  btnManager:_AddToggleFunc("小林家小游戏", function()
    self:ShowDialog("UIXiaoLinJiaMainController")
  end)
  btnManager:_AddToggleFunc("弹跳角色永生", function(value)
    BounceDebug.PlayerLiveForever = value
  end, function()
    return BounceDebug.PlayerLiveForever
  end)
  btnManager:_AddCallback("赛季", function()
    GameGlobal.GetUIModule(SeasonModule):OpenSeasonThemeUI()
  end)
  btnManager:_AddFunShowDialog("N34派遣小游戏", "UIN34DispatchMain")
  btnManager:_AddCallback("赛季对话框", function()
    self:ShowDialog("UISeasonStoryController", 65150101)
  end)
end

function UIMainLobbyTestFunc:ShowSaveHomeList()
  self._homeStoryInp = self:GetUIComponent("InputField", "HomeStoryInputField")
  local uiHomeModule = GameGlobal.GetUIModule(HomelandModule)
  local saveStoryList = uiHomeModule:SaveStoryList()
  if saveStoryList and next(saveStoryList) then
    local showTex = ""
    for i = 1, #saveStoryList do
      local id = saveStoryList
      showTex = showTex .. tostring(id)
      if i ~= #saveStoryList then
        showTex = showTex .. ","
      end
    end
    self._homeStoryInp.text = showTex
  end
end

function UIMainLobbyTestFunc:HomeStorySaveBtnOnClick(go)
  local uiHomeModule = GameGlobal.GetUIModule(HomelandModule)
  local tex = self._homeStoryInp.text
  local idStrs = string.split(tex, ",")
  local idList = {}
  for i = 1, #idStrs do
    local succ = pcall(function()
      local id = tonumber(idStrs[i])
      table.insert(idList, id)
    end)
  end
  local tips = ""
  for i = 1, #idList do
    local id = idList[i]
    tips = tips .. tostring(id)
    if i ~= #idList then
      tips = tips .. ","
    end
  end
  local count = table.count(idList)
  ToastManager.ShowToast("保存成功,触发剧情" .. count .. "个,ID:" .. tips)
  uiHomeModule:SaveStoryList(idList)
end

function UIMainLobbyTestFunc:PerfSkillTestBtnOnClick()
  self:GetModule(SkillPerfModule):EnterCoreGame()
end

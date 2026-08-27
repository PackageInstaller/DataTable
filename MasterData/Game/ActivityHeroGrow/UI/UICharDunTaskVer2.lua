local UICharDunTaskVer2 = class("UICharDunTaskVer2", UIBaseWindow)
local base = UIBaseWindow
local UINTaskVer2DayItem = require("Game.ActivityHeroGrow.UI.UINTaskVer2DayItem")
local UINTaskVer2DayTaskItem = require("Game.ActivityHeroGrow.UI.UINTaskVer2DayTaskItem")
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local TaskEnum = require("Game.Task.TaskEnum")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local cs_ResLoader = CS.ResLoader

function UICharDunTaskVer2:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickWin)
  self._dayPool = UIItemPool.New(UINTaskVer2DayItem, self.ui.dayItem)
  self.ui.dayItem:SetActive(false)
  self._taskPool = UIItemPool.New(UINTaskVer2DayTaskItem, self.ui.taskItem)
  self.ui.taskItem:SetActive(false)
  self._rewardPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.rewardItem)
  self.ui.rewardItem:SetActive(false)
  self.__ReceiveTaskCallback = BindCallback(self, self.__ReceiveTask)
  self.__SelectDayCallback = BindCallback(self, self.__SelectDay)
  UIUtil.AddButtonListener(self.ui.btn_GetAll, self, self.OnClickAllGet)
  UIUtil.AddButtonListener(self.ui.btn_ItemClick, self, self.OnClickItemClick)
  self.__RefreshUICallback = BindCallback(self, self.__RefreshUI)
  MsgCenter:AddListener(eMsgEventId.HeroGrowActivityUpdate, self.__RefreshUICallback)
  self.__TaskProcessCallback = BindCallback(self, self.__TaskProcess)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskProcessCallback)
  self._resloader = cs_ResLoader.Create()
end

function UICharDunTaskVer2:InitCharDunTaskVer2(heroGrowData)
  self._heroGrow = heroGrowData
  self:__ReplaceByUICfg()
  self:__InitUI()
  self:__AutoSelectEnter()
end

function UICharDunTaskVer2:__ReplaceByUICfg()
  local uiCfg = ConfigData.activity_hero_ui_config[self._heroGrow:GetActId()]
  local bgPath = PathConsts:GetCharDunVer2Bg(uiCfg.background_res)
  self.ui.background.gameObject:SetActive(false)
  self._resloader:LoadABAssetAsync(bgPath, function(texture)
    if texture == nil or IsNull(self.transform) then
      return
    end
    self.ui.background.gameObject:SetActive(true)
    self.ui.background.texture = texture
  end)
  if #uiCfg.main_top_res == 0 then
    self.ui.Img_Up.gameObject:SetActive(false)
  else
    local nameResPath = PathConsts:GetCharDunVer2Bg(uiCfg.main_top_res)
    self._resloader:LoadABAssetAsync(nameResPath, function(texture)
      if texture == nil or IsNull(self.transform) then
        return
      end
      self.ui.Img_Up.gameObject:SetActive(true)
      self.ui.Img_Up.texture = texture
    end)
    self.ui.Img_Up.transform.sizeDelta = Vector2.Temp(uiCfg.main_top_size[1], uiCfg.main_top_size[2])
  end
  if #uiCfg.main_down_res == 0 then
    self.ui.Img_Down.gameObject:SetActive(false)
  else
    local nameResPath = PathConsts:GetCharDunVer2Bg(uiCfg.main_down_res)
    self._resloader:LoadABAssetAsync(nameResPath, function(texture)
      if texture == nil or IsNull(self.transform) then
        return
      end
      self.ui.Img_Down.gameObject:SetActive(true)
      self.ui.Img_Down.texture = texture
    end)
    self.ui.Img_Down.transform.sizeDelta = Vector2.Temp(uiCfg.main_down_size[1], uiCfg.main_down_size[2])
  end
end

function UICharDunTaskVer2:__InitUI()
  self._dayPool:HideAll()
  local allDaycfg = ConfigData.activity_hero_task_daily[self._heroGrow:GetActId()]
  for day, _ in ipairs(allDaycfg) do
    local item = self._dayPool:GetOne()
    item:InitTaskVer2DayItem(self._heroGrow, day, self.__SelectDayCallback)
  end
  local uiCfg = ConfigData.activity_hero_ui_config[self._heroGrow:GetActId()]
  local heroId = self._heroGrow:GetHeroGrowCfg().hero_id
  local skinId = uiCfg.quest_skin
  if uiCfg.quest_skin_type == 1 then
    self:__LoadPic(heroId, skinId)
  else
    self:__LoadL2D(heroId, skinId)
  end
end

function UICharDunTaskVer2:__LoadL2D(heroId, skinId)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    error("skinCfg is NIL")
    return
  end
  local resName = skinCfg.src_id_pic
  self._resloader:LoadABAssetAsync(PathConsts:GetCharacterLive2DPath(resName), function(l2dModelAsset)
    if IsNull(l2dModelAsset) then
      return
    end
    self.liveGo = l2dModelAsset:Instantiate()
    self.liveGo.transform:SetParent(self.ui.heroHolder.transform)
    self.liveGo.transform:SetLayer(LayerMask.UI)
    local cs_CubismInterationController = self.liveGo.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = HeroCubismInteration.New()
      self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
      self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
      self.heroCubismInteration:SetRenderControllerSetting(self:GetWindowSortingLayer(), self.ui.heroHolder, nil, true)
      self.heroCubismInteration:SetL2DPosType("CharDunTask", false)
    end
  end)
end

function UICharDunTaskVer2:__LoadPic(heroId, skinId)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    error("skinCfg is NIL")
    return
  end
  local resName = skinCfg.src_id_pic
  self._resloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(resName), function(prefab)
    self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder.transform)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("CharDunTask")
  end)
end

function UICharDunTaskVer2:__AutoSelectEnter()
  local allDaycfg = ConfigData.activity_hero_task_daily[self._heroGrow:GetActId()]
  local canReceiveDay = 0
  local waitComplete = 0
  local lastunlockDay = 0
  for i = 1, #allDaycfg do
    if self._heroGrow:IsHeroGrowDailyTaskIsUnlock(i) then
      lastunlockDay = i
      if self._heroGrow:IsHeroGrowDailyTaskCanComplete(i) then
        canReceiveDay = i
      elseif not self._heroGrow:IsHeroGrowDailyTaskReceive(i) then
        waitComplete = i
      end
    end
  end
  if 0 < canReceiveDay then
    self:__SelectDay(canReceiveDay)
  elseif 0 < waitComplete then
    self:__SelectDay(waitComplete)
  else
    self:__SelectDay(lastunlockDay)
  end
end

function UICharDunTaskVer2:__CollectTaskDatas(day)
  local allDaycfg = ConfigData.activity_hero_task_daily[self._heroGrow:GetActId()]
  local dayCfg = allDaycfg[self._selectDay]
  local taskDatas = {}
  for _, taskId in ipairs(dayCfg.open_task_list) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    if taskData ~= nil then
      table.insert(taskDatas, taskData)
    end
  end
  for _, taskId in ipairs(dayCfg.wait_task_list) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    if taskData ~= nil then
      table.insert(taskDatas, taskData)
    end
  end
  return taskDatas
end

function UICharDunTaskVer2:SortTaskDatas(taskDatas)
  table.sort(taskDatas, function(a, b)
    local isComA = a:CheckComplete()
    local isComB = b:CheckComplete()
    if isComA ~= isComB then
      return isComA
    end
    if a.isPicked ~= b.isPicked then
      return not a.isPicked
    end
    return a.id < b.id
  end)
end

function UICharDunTaskVer2:__RefreshUI()
  local taskList = self:__CollectTaskDatas(self._selectDay)
  self:SortTaskDatas(taskList)
  self._taskPool:HideAll()
  for _, taskData in ipairs(taskList) do
    local item = self._taskPool:GetOne()
    item:InitTaskItem(taskData)
    item:BindCommitFunc(self.__ReceiveTaskCallback)
  end
  local allDaycfg = ConfigData.activity_hero_task_daily[self._heroGrow:GetActId()]
  local dayCfg = allDaycfg[self._selectDay]
  self._rewardPool:HideAll()
  local itemids = dayCfg.full_reward_ids
  local itemNums = dayCfg.full_reward_nums
  local isUnLock = self._heroGrow:IsHeroGrowDailyTaskIsUnlock(self._selectDay)
  local isCanReceive = self._heroGrow:IsHeroGrowFullRewardCanReceive(self._selectDay)
  local isPicked = self._heroGrow:IsHeroGrowFullRewardReceived(self._selectDay)
  for i, itemId in ipairs(itemids) do
    local itemCount = itemNums[i]
    local itemCfg = ConfigData.item[itemId]
    local item = self._rewardPool:GetOne()
    item:InitItemWithCount(itemCfg, itemCount, nil, isPicked)
  end
  self.ui.img_Arrow:SetActive(false)
  if isUnLock then
    if isCanReceive then
      self.ui.state:SetIndex(1)
      self.ui.tex_State:SetIndex(1)
      self.ui.img_Arrow:SetActive(true)
    elseif isPicked then
      self.ui.state:SetIndex(2)
      self.ui.tex_State:SetIndex(2)
    else
      self.ui.state:SetIndex(0)
      self.ui.tex_State:SetIndex(0)
    end
  else
    self.ui.state:SetIndex(2)
    self.ui.tex_State:SetIndex(2)
  end
  self.ui.btn_GetAll.gameObject:SetActive(self._heroGrow:IsHeroGrowExistTaskReceive())
  for i, v in ipairs(self._dayPool.listItem) do
    v:RefreshTaskVer2DayState()
  end
  self.ui.text:SetIndex(self._heroGrow:IsHeroGrowDailyTaskIsUnlock(#allDaycfg) and 1 or 0)
end

function UICharDunTaskVer2:__TaskProcess(taskData)
  if taskData:CheckComplete() then
    self:__RefreshUI()
    return
  end
  for i, v in ipairs(self._taskPool.listItem) do
    v:RefreshUI()
  end
end

function UICharDunTaskVer2:__ReceiveTask(taskData, taskItem)
  if not taskData:CheckComplete() then
    return
  end
  local network = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  network:CS_Activity_Quest_Commit(self._heroGrow:GetActFrameId(), taskData.id, function()
    if not IsNull(self.transform) then
      self:__RefreshUI()
      local rewards, nums = taskData:GetTaskCfgRewards()
      local CommonRewardData = require("Game.CommonUI.CommonRewardData")
      local CRData = CommonRewardData.CreateCRDataUseList(rewards, nums)
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        if window == nil then
          return
        end
        window:AddAndTryShowReward(CRData)
      end)
    end
  end)
end

function UICharDunTaskVer2:__SelectDay(day)
  if not self._heroGrow:IsHeroGrowDailyTaskIsUnlock(day) then
    return
  end
  self._heroGrow:LookedHeroGrowDailyTaskNewReddot(day)
  for i, v in ipairs(self._dayPool.listItem) do
    v:RefreshTaskVer2DaySelect(day)
  end
  self._selectDay = day
  self:__RefreshUI()
end

function UICharDunTaskVer2:OnClickAllGet()
  if not self._heroGrow:IsHeroGrowExistTaskReceive() then
    return
  end
  self._heroGrow:ReqHeroGrowDailyTaskAllReward(function()
    if not IsNull(self.transform) then
      self:__RefreshUI()
    end
  end)
end

function UICharDunTaskVer2:OnClickItemClick()
  if not self._heroGrow:IsHeroGrowFullRewardCanReceive(self._selectDay) then
    return
  end
  self._heroGrow:ReqHeroGrowDailyFullReward(self._selectDay, function()
    if not IsNull(self.transform) then
      self:__RefreshUI()
    end
  end)
end

function UICharDunTaskVer2:OnClickWin()
  self:Delete()
end

function UICharDunTaskVer2:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.HeroGrowActivityUpdate, self.__RefreshUICallback)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskProcessCallback)
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  self._resloader:Put2Pool()
  self._resloader = nil
  base.OnDelete(self)
end

return UICharDunTaskVer2

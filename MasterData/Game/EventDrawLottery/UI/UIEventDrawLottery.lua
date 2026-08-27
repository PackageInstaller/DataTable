local UIEventDrawLottery = class("UIEventDrawLottery", UIBaseWindow)
local base = UIBaseWindow
local CS_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local JumpManager = require("Game.Jump.JumpManager")
local cs_ResLoader = CS.ResLoader
local CS_DOTweenAnimation = CS.DG.Tweening.DOTweenAnimation
local UINDrawLotteryTaskItem = require("Game.EventDrawLottery.UI.Task.UINDrawLotteryTaskItem")
local UINDrawLotteryBpMain = require("Game.EventDrawLottery.UI.BP.UINDrawLotteryBpMain")
local UINActivityTimer = require("Game.ActivityFrame.UI.UINActivityTimer")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroL2dInterationController = require("Game.Hero.Live2D.HeroL2dInterationController")
local SkinEnum = require("Game.Skin.SkinEnum")
local eMoveDir = {Left = 1, Right = 2}

function UIEventDrawLottery:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  self.resloader = cs_ResLoader.Create()
  self.oriHeroHolderPos = self.ui.HeroHolder.transform.localPosition
  self.oriPicHolderPos = self.ui.PicHolder.transform.localPosition
  self._fromWhere = SkinEnum.fromWhere.bp
  self.taskItemPool = UIItemPool.New(UINDrawLotteryTaskItem, self.ui.obj_taskItem, false)
  self.bpMain = UINDrawLotteryBpMain.New()
  self.bpMain:Init(self.ui.obj_bPList)
  self._actTimerNode = UINActivityTimer.New()
  self._actTimerNode:Init(self.ui.obj_time)
  self.refreshTaskCallback = BindCallback(self, self.RefreshDrawLotteryTaskGroup)
  self.refreshBpCallback = BindCallback(self, self.RefreshDrawLotteryBpMain)
  UIUtil.AddButtonListener(self.ui.btn_Check, self, self.__OnClickDrawLotterySkinPreview)
  UIUtil.AddButtonListener(self.ui.btn_GetAll, self, self.OnClickOneKeyBp)
  UIUtil.AddButtonListener(self.ui.btn_TaskLog, self, self.__OnClickDrawLotteryBtnTaskLog)
  UIUtil.AddButtonListener(self.ui.btn_Tips, self, self.OnClickRuleTip)
  UIUtil.AddValueChangedListener(self.ui.tog_live2d, self, self.__OnChangeLive2dValue)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.refreshBpCallback)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.refreshTaskCallback)
  MsgCenter:AddListener(eMsgEventId.TaskDelete, self.refreshTaskCallback)
end

function UIEventDrawLottery:InitEventDrawLottery(actId)
  self.drawLotteryCtrl = ControllerManager:GetController(ControllerTypeId.EventDrawLottery)
  if self.drawLotteryCtrl == nil then
    return
  end
  self:InitNormalData(actId)
  self:RefreshEventDrawLottery()
  TimerManager:StopTimer(self._timerId)
  self._timerId = TimerManager:StartTimer(1, self.__TimerCountdown, self)
  self:__TimerCountdown()
end

function UIEventDrawLottery:InitNormalData(actId)
  self.actData = self.drawLotteryCtrl:GetEventDrawLotteryDataByActId(actId)
  self.groupNum = self.actData:GetDrawLotteryGroupNum()
  self.bpMain:InitDrawLotteryBpMain(self.actData, BindCallback(self, self.OnClickBpItem))
  self.mainCfg = self.actData:GetDrawLotteryMainCfg()
  self._skinId = self.mainCfg.skin_id
  self._heroId = self.mainCfg.hero_id
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  self.resModelCfg = skinCtr:GetResModel(self._heroId, self._skinId or nil)
end

function UIEventDrawLottery:RefreshEventDrawLottery()
  self:RefreshDrawLotteryNormalUI()
  self:RefreshDrawLotteryTaskGroup()
  self:RefreshDrawLotteryBpMain()
  self:RefreshHeroShow()
end

function UIEventDrawLottery:RefreshHeroShow()
  local skinCfg = ConfigData.skin[self._skinId]
  local heroCfg = ConfigData.hero_data[self._heroId]
  self.ui.tex_SkinName.text = LanguageUtil.GetLocaleText(skinCfg.name)
  self.ui.tex_HeroName.text = LanguageUtil.GetLocaleText(heroCfg.name)
  self:RefreshSkinLimitMain()
end

function UIEventDrawLottery:RefreshDrawLotteryNormalUI()
  self.ui.tex_ActName.text = LanguageUtil.GetLocaleText(self.mainCfg.title)
  self.ui.tex_Des.text = ConfigData:GetTipContent(self.mainCfg.activity_des)
  CS_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.tex_Des.transform)
end

function UIEventDrawLottery:RefreshDrawLotteryTaskGroup()
  self.taskItemPool:HideAll()
  for i = 1, self.groupNum do
    local taskData = self.actData:GetDrawLotteryNowTaskStage(i)
    local stageId = self.actData:GetStageIdByTaskData(taskData)
    local item = self.taskItemPool:GetOne()
    item:InitDrawLotteryTaskItem(self.actData, taskData, stageId)
  end
  local taskItemWindow = UIManager:GetWindow(UIWindowTypeID.EventDrawLotteryTaskWindow)
  if taskItemWindow and taskItemWindow.active then
    taskItemWindow:RefreshTaskWindow()
  end
end

function UIEventDrawLottery:RefreshDrawLotteryBpMain()
  self.bpMain:RefreshDrawLotteryBpList()
  local haveReward = self.actData:GetDrawLotteryBpCanPick()
  self.ui.btn_GetAll.gameObject:SetActive(haveReward)
end

function UIEventDrawLottery:RefreshSkinLimitMain()
  local live2d_level = self.mainCfg.skin_type
  local isOpen = PlayerDataCenter.skinData:GetLive2dSwitchState(self._heroId, self._skinId or 0)
  self.ui.tog_live2d.gameObject:SetActive(0 < live2d_level)
  if 0 < live2d_level then
    self.ui.text_live2d:SetIndex(live2d_level - 1)
  end
  self:LoadSkinLimitRes()
end

function UIEventDrawLottery:LoadSkinLimitRes()
  self.isLive2dTogValid = false
  local live2dlevel = self.mainCfg.skin_type
  local isHaveL2D = 0 < live2dlevel
  if isHaveL2D then
    local isOpen = PlayerDataCenter.skinData:GetLive2dSwitchState(self._heroId, self._skinId or 0)
    self.ui.tog_live2d.isOn = isOpen
    if isOpen then
      self.ui.ani_tog:DORewind()
    else
      self.ui.ani_tog:DOComplete()
    end
    self.isLive2dTogValid = true
  end
  self:LoadViewRes()
end

function UIEventDrawLottery:LoadViewRes()
  self.ui.HeroHolder.transform.localPosition = self.oriHeroHolderPos
  self.ui.PicHolder.transform.localPosition = self.oriPicHolderPos
  if not IsNull(self.l2dModelIns) then
    HeroCubismInteration.DestroyInterationInstance(self.l2dModelIns)
    self.l2dModelIns = nil
    self.l2dBinding = nil
  end
  if not IsNull(self.bigImgObj) then
    DestroyUnityObject(self.bigImgObj)
  end
  if self.Live2DResloader ~= nil then
    self.Live2DResloader:Put2Pool()
    self.Live2DResloader = nil
    self.l2dBinding = nil
  end
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  self.l2dBinding = nil
  local live2dlevel = self.mainCfg.skin_type
  local isHaveL2D = 0 < live2dlevel
  local skinCfg = ConfigData.skin[self._skinId]
  local resModel = self.resModelCfg
  if isHaveL2D then
    if self.ui.tog_live2d.isOn then
      self:__TryLoadLive2D(skinCfg, resModel)
    else
      self:__LoadPic(PathConsts:GetCharacterBigImgPrefabPath(resModel.src_id_pic, self._fromWhere))
    end
  else
    local picResPath
    picResPath = PathConsts:GetCharacterBigImgPrefabPath(resModel.src_id_pic, self._fromWhere)
    self:__LoadPic(picResPath)
  end
end

function UIEventDrawLottery:__TryLoadLive2D(skinCfg, resModel)
  if skinCfg == nil then
    error("skinCfg is nil")
    return
  end
  local skinId = skinCfg.id
  local live2dCfg = ConfigData.skin_live2d[skinId]
  local isHaveSkin = skinCfg.isdefault_skin or PlayerDataCenter.skinData:IsHaveSkin(skinId)
  local isHideHolight = PlayerDataCenter.skinData:IsHideHolight(skinId)
  local l2dPath = PathConsts:GetCharacterLive2DPath(resModel.src_id_pic, self._fromWhere)
  self:__LoadLive2D(l2dPath, isHideHolight)
end

function UIEventDrawLottery:__LoadLive2D(path, isHideHolight)
  self.Live2DResloader = cs_ResLoader.Create()
  self.Live2DResloader:LoadABAssetAsync(path, function(l2dModelAsset)
    if IsNull(self.transform) or IsNull(l2dModelAsset) then
      return
    end
    self.l2dModelIns = l2dModelAsset:Instantiate(self.ui.heroFade.transform)
    self.l2dModelIns.transform:SetLayer(LayerMask.UI)
    self.l2dBinding = {}
    UIUtil.LuaUIBindingTable(self.l2dModelIns, self.l2dBinding)
    local cs_CubismInterationController = self.l2dModelIns.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = HeroCubismInteration.New()
      local heroId = self._heroId
      local skinId = self._skinId
      self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
      self.heroCubismInteration:SetInterationOpenWait(false)
      self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
      self.heroCubismInteration:SetRenderControllerSetting(self:GetWindowSortingLayer(), self.ui.heroFade, 1, true)
      self.heroCubismInteration:SetL2DPosType("HeroSkin", false)
    end
    self.l2dBinding.renderController.uiCanvasGroup = self.ui.heroFade
    self.l2dBinding.renderController.SortingLayer = "UINormal"
    self.l2dBinding.renderController.SortingOrder = 100
    self.l2dBinding.renderController.InfluencedByUICanvas = true
    HeroL2dInterationController.ActiveLive2dHolight(self.l2dBinding.renderController, not isHideHolight)
    local posData = self.actData:GetDrawLotterySkinPosData()
    if posData ~= nil then
      self.l2dModelIns.transform.localPosition = Vector3.New(posData.live2dPosX, posData.live2dPosY, 0)
    end
  end)
end

function UIEventDrawLottery:__LoadPic(path)
  self.bigImgResloader = cs_ResLoader.Create()
  self.bigImgResloader:LoadABAssetAsync(path, function(prefab)
    if IsNull(prefab) or IsNull(self.transform) then
      return
    end
    self.bigImgObj = prefab:Instantiate(self.ui.PicHolder.transform)
    local commonPicCtrl = self.bigImgObj:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroSkin")
    local posData = self.actData:GetDrawLotterySkinPosData()
    if posData ~= nil then
      self.bigImgObj.transform.anchoredPosition = Vector2.New(posData.bgPosX, posData.bgPosY)
    end
  end)
end

function UIEventDrawLottery:__TimerCountdown()
  local title, timeStr, expireTime = ActivityFrameUtil.GetShowEndTimeStr(self.actData)
  local dayStr, diff = ActivityFrameUtil.GetCountdownTimeStr(expireTime)
  if diff < 0 then
    TimerManager:StopTimer(self._timerId)
  end
  self._actTimerNode:Show()
  self._actTimerNode:UpdActTimer(title, timeStr, dayStr)
end

function UIEventDrawLottery:OnClickBpItem(index)
  self.actData:SendDrawLotteryOnePick(index)
end

function UIEventDrawLottery:OnClickOneKeyBp()
  self.actData:SendDrawLotteryAllPick()
end

function UIEventDrawLottery:__OnChangeLive2dValue(flag)
  if not self.isLive2dTogValid then
    return
  end
  PlayerDataCenter.skinData:RecordLive2dSwitchState(self._heroId, self._skinId or 0, flag)
  self:LoadViewRes()
  if flag then
    self.ui.ani_tog:DOPlayBackwards()
  else
    self.ui.ani_tog:DOPlayForward()
  end
end

function UIEventDrawLottery:OnClickRuleTip()
  local tipId, tipContentId = self.actData:GetDrawLotteryGameTip()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfo(ConfigData:GetTipContent(tipContentId), ConfigData:GetTipContent(tipId), nil, true)
  end)
end

function UIEventDrawLottery:__OnClickDrawLotteryBtnTaskLog()
  UIManager:ShowWindowAsync(UIWindowTypeID.EventDrawLotteryTaskWindow, function(win)
    if win == nil then
      return
    end
    win:InitDrawLotteryTaskWindow(self.actData)
  end)
end

function UIEventDrawLottery:__OnClickDrawLotterySkinPreview()
  JumpManager:Jump(JumpManager.eJumpTarget.HeroSkin, nil, nil, {
    self._skinId,
    require("Game.Skin.SkinEnum").fromWhere.bp
  }, true)
end

function UIEventDrawLottery:GenCoverJumpReturnCallback()
  if self.Live2DResloader ~= nil then
    self.Live2DResloader:Put2Pool()
    self.Live2DResloader = nil
    self.l2dBinding = nil
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  if not IsNull(self.bigImgGameObject) then
    DestroyUnityObject(self.bigImgGameObject)
  end
  self.bigImgGameObject = nil
  if not IsNull(self.l2dModelIns) then
    HeroCubismInteration.DestroyInterationInstance(self.l2dModelIns)
  end
  self.l2dModelIns = nil
  self.l2dBinding = nil
  local dataTable = {}
  for key, value in pairs(self) do
    dataTable[key] = value
  end
  return function()
    for key, value in pairs(dataTable) do
      self[key] = value
    end
    self.curIndex = dataTable.curIndex
    self:Show()
    self:RefreshEventDrawLottery()
  end
end

function UIEventDrawLottery:OnHide()
  if not IsNull(self.bigImgObj) then
    DestroyUnityObject(self.bigImgObj)
  end
  if not IsNull(self.l2dModelIns) then
    HeroCubismInteration.DestroyInterationInstance(self.l2dModelIns)
    self.l2dModelIns = nil
    self.l2dBinding = nil
  end
  base.OnHide(self)
end

function UIEventDrawLottery:OnDeleteEntity()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  if self.Live2DResloader ~= nil then
    self.Live2DResloader:Put2Pool()
    self.Live2DResloader = nil
    self.l2dBinding = nil
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  base.OnDeleteEntity(self)
end

function UIEventDrawLottery:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.refreshBpCallback)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.refreshTaskCallback)
  MsgCenter:RemoveListener(eMsgEventId.TaskDelete, self.refreshTaskCallback)
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  if not IsNull(self.bigImgObj) then
    DestroyUnityObject(self.bigImgObj)
  end
  if not IsNull(self.l2dModelIns) then
    HeroCubismInteration.DestroyInterationInstance(self.l2dModelIns)
    self.l2dModelIns = nil
    self.l2dBinding = nil
  end
  base.OnDelete(self)
end

return UIEventDrawLottery

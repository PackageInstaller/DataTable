local DormController = class("DormController", ControllerBase)
local DormUtil = require("Game.Dorm.DormUtil")
local util = require("XLua.Common.xlua_util")
local AllDormData = require("Game.Dorm.Data.AllDormData")
local DormEnum = require("Game.Dorm.DormEnum")
local DormHouseCtrl = require("Game.Dorm.Ctrl.DormHouseCtrl")
local DormRoomCtrl = require("Game.Dorm.Ctrl.DormRoomCtrl")
local DormShopCtrl = require("Game.Dorm.Ctrl.DormShopCtrl")
local DormCheckInCtrl = require("Game.Dorm.Ctrl.DormCheckInCtrl")
local DormCharacterCtrl = require("Game.Dorm.Ctrl.DormCharacterCtrl")
local DormCmderCtrl = require("Game.Dorm.Ctrl.DormCmderCtrl")
local DormAStarPathCtrl = require("Game.Dorm.Ctrl.DormAStarPathCtrl")
local DormCameraCtrl = require("Game.Dorm.Ctrl.DormCameraCtrl")
local DormVisitCtrl = require("Game.Dorm.Ctrl.DormVisitCtrl")
local ShopEnum = require("Game.Shop.ShopEnum")
local DormHouseData = require("Game.Dorm.Data.DormHouseData")
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local cs_MessageCommon = CS.MessageCommon
local cs_QualitySettings = CS.UnityEngine.QualitySettings

function DormController:OnInit()
  self.dormNetwork = NetworkManager:GetNetwork(NetworkTypeID.Dorm)
  self.__onChangeDormBindComplete = BindCallback(self, self.OnChangeDormBindComplete)
end

function DormController:PreInitDorm()
  self.state = DormEnum.eDormState.None
  self.__onDormTouchTap = BindCallback(self, self.OnDormTouchTap)
  self.__onDormTouchGesture = BindCallback(self, self.OnDormTouchGesture)
  self.ctrls = {}
  self.houseCtrl = DormHouseCtrl.New(self)
  self.roomCtrl = DormRoomCtrl.New(self)
  self.shopCtrl = DormShopCtrl.New(self)
  self.astarPathCtrl = DormAStarPathCtrl.New(self)
  self.characterCtrl = DormCharacterCtrl.New(self)
  self.cmderCtrl = DormCmderCtrl.New(self)
  self.dmCheckInCtrl = DormCheckInCtrl.New(self)
  self.cameraCtrl = DormCameraCtrl.New(self)
  self.dormVisitCtrl = DormVisitCtrl.New(self)
end

function DormController:EnterDorm()
  self.dormOwnerId = nil
  self.dormNetwork:CS_DORM_GlobalDetail()
end

function DormController:EnterOtherDorm(userId, userName)
  if self.dormOwnerId == userId then
    return
  end
  self.dormOwnerId = nil
  self.dormOwnerName = userName
  self.dormNetwork:CS_DORM_Visit(userId)
end

function DormController:RecvDormOtherDetailData(dormVisitOut)
  local dormHouseData = DormHouseData.New()
  for houseId, data in pairs(dormVisitOut.data) do
    dormHouseData:InitHouseData(data)
    break
  end
  local dormOwnerUserId = dormVisitOut.visitee
  self.dormOwnerId = dormOwnerUserId
  self.dormOwnerName = dormVisitOut.name
  UIManager:DeleteWindow(UIWindowTypeID.UserInfo)
  UIManager:DeleteWindow(UIWindowTypeID.CommonUserInfo)
  UIManager:DeleteWindow(UIWindowTypeID.UserFreined)
  local stateData = UIUtil.FindTopStatusDataByWinId(UIWindowTypeID.DormMain)
  if stateData ~= nil then
    stateData.topBtnOnlyReturn = true
  end
  if self:HasInDorm() then
    self.dormVisitCtrl:RefreshRoomLikeCount(dormOwnerUserId, dormVisitOut.favor)
    self:ChangedToVisitDormHouse(dormHouseData)
  else
    self.dormNetwork:CS_DORM_GlobalDetail(function(msg)
      self:InitDormDetail(msg)
      UIManager:DeleteAllWindow()
      self:LoadDormScene(dormHouseData, nil, function()
        self:EnterNewDormHouse(dormHouseData, true)
        self.dormVisitCtrl:RefreshRoomLikeCount(dormOwnerUserId, dormVisitOut.favor)
        self.houseCtrl:TryPlayDmAllRoomUnlockFx()
        for pos, roomEntity in pairs(self.houseCtrl.roomEnityDic) do
          self:DirectlyEnterTheRoom(roomEntity)
          return false
        end
        return false
      end)
    end)
  end
end

function DormController:InitDormDetail(msg)
  self:PreInitDorm()
  self.allDormData = AllDormData.New()
  self.allDormData:InitDormData(msg)
  self.dormVisitCtrl:RefreshDormVisitCtrl(msg.visit)
end

function DormController:RecvDormDetailData(msg, LoadAfterCallback)
  self:InitDormDetail(msg)
  UIManager:DeleteAllWindow()
  local defaultHouseId = 0
  if 0 < #self.allDormData.houseIdList then
    defaultHouseId = self.allDormData.houseIdList[1]
  end
  local showUnlockFx = false
  for i = #ConfigData.dorm_house.id_sort_list, 1, -1 do
    local houseId = ConfigData.dorm_house.id_sort_list[i]
    local houseData = self.allDormData.houseDic[houseId]
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    local readedNew = saveUserData:GetNewDormHouseReaded(houseId)
    if houseData ~= nil and not houseData:IsDmHouseLock() and not readedNew and not houseData:IsDefaultUnlockDmHouse() then
      defaultHouseId = houseId
      showUnlockFx = true
      break
    end
  end
  local dormHouseData = self.allDormData.houseDic[defaultHouseId]
  if dormHouseData == nil then
    error("RecvDormDetailData don't exist defaultHouseId = " .. defaultHouseId)
  end
  self:LoadDormScene(dormHouseData, nil, function()
    local dormHouseData = self.allDormData.houseDic[defaultHouseId]
    self:EnterNewDormHouse(dormHouseData, showUnlockFx)
    self.houseCtrl:TryPlayDmAllRoomUnlockFx()
    if LoadAfterCallback ~= nil then
      LoadAfterCallback()
    end
  end)
end

function DormController:LoadDormScene(dormHouseData, onPreLoadAfter, onLoadAfter)
  self.comResloader = CS.ResLoader.Create()
  self.comRes = {}
  
  local function preLoadFunc()
    self:LoadDormHouseNeedRes(dormHouseData)
    local effectWait = self.comResloader:LoadABAssetAsyncAwait("Res/Effect/Prefabs/FX_Pick.prefab")
    local fntBottomWait = self.comResloader:LoadABAssetAsyncAwait(PathConsts:GetDormFntPath("FntBottom"))
    local gridWallWait = self.comResloader:LoadABAssetAsyncAwait(PathConsts:GetDormRoomPath("DormWallGrid"))
    local gridFloorWait = self.comResloader:LoadABAssetAsyncAwait(PathConsts:GetDormRoomPath("DormFloorGrid"))
    local selectRoleWait = self.comResloader:LoadABAssetAsyncAwait(PathConsts:GetDormFntPath("SelectCharacter"))
    local greetRoleWait = self.comResloader:LoadABAssetAsyncAwait("FX/Common/FX_Talk/FXP_Talk1-new.prefab")
    local cmderPrefabWait = self.comResloader:LoadABAssetAsyncAwait(PathConsts:GetCharacterDormModelPath(DormUtil.GetDormCmderResName()))
    local cmderHeadFxWait = self.comResloader:LoadABAssetAsyncAwait(PathConsts:GetDormPath("CommonPrefab/Fx_CmdHeadGem"))
    local vowedRoleHeadFxWait = self.comResloader:LoadABAssetAsyncAwait("FX/Common/FX_Common_vow_aixin/FXP_Common_vow_aixin.prefab")
    local dormConfigAssetWait = self.comResloader:LoadABAssetAsyncAwait("Res/ScriptableConfig/DormConfigAsset.asset")
    local moveRoomGoEffectWait = self.comResloader:LoadABAssetAsyncAwait("FX/UI_effct/DormitoryEffcet/FXP_Shelter_go.prefab")
    local moveRoomInEffectWait = self.comResloader:LoadABAssetAsyncAwait("FX/UI_effct/DormitoryEffcet/FXP_Shelter_in.prefab")
    coroutine.yield(effectWait)
    self.comRes.selectRoomEffectPrefab = effectWait.Result
    coroutine.yield(fntBottomWait)
    self.comRes.fntBottomPrefab = fntBottomWait.Result
    coroutine.yield(gridWallWait)
    self.comRes.gridWallPrefab = gridWallWait.Result
    coroutine.yield(gridFloorWait)
    self.comRes.gridFloorPrefab = gridFloorWait.Result
    coroutine.yield(selectRoleWait)
    self.comRes.selectRolePrefab = selectRoleWait.Result
    coroutine.yield(greetRoleWait)
    self.comRes.greetRolePrefab = greetRoleWait.Result
    coroutine.yield(cmderPrefabWait)
    self.comRes.cmderPrefab = cmderPrefabWait.Result
    coroutine.yield(cmderHeadFxWait)
    self.comRes.cmderHeadFxPrefab = cmderHeadFxWait.Result
    coroutine.yield(vowedRoleHeadFxWait)
    self.comRes.vowedRoleHeadFxPrefab = vowedRoleHeadFxWait.Result
    coroutine.yield(dormConfigAssetWait)
    self.comRes.dormConfigAsset = dormConfigAssetWait.Result
    self.comRes.dormConfigAsset:FirstLoadDormConfig()
    coroutine.yield(moveRoomGoEffectWait)
    self.comRes.moveRoomGoEffectPrefab = moveRoomGoEffectWait.Result
    coroutine.yield(moveRoomInEffectWait)
    self.comRes.moveRoomInEffectPrefab = moveRoomInEffectWait.Result
    UIManager:ShowWindowAsync(UIWindowTypeID.DormMain)
    repeat
      coroutine.yield(nil)
      self.dormWindow = UIManager:GetWindow(UIWindowTypeID.DormMain)
    until self.dormWindow
    if onPreLoadAfter ~= nil then
      onPreLoadAfter()
    end
  end
  
  UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(3)
  CS.GSceneManager.Instance:LoadSceneAsyncByAB(Consts.SceneName.Dorm, function(ok)
    AudioManager:PlayAudioById(3001)
    AudioManager:PlayAudioById(1088)
    CS.RenderManager.Instance:SetUnityShadow(true)
    self.__oldShadowDistance = cs_QualitySettings.shadowDistance
    cs_QualitySettings.shadowDistance = DormEnum.DormShadowDistance
    self.__oldLoadBias = cs_QualitySettings.lodBias
    cs_QualitySettings.lodBias = DormEnum.DormLodBias
    self:InitDorm()
    if onLoadAfter ~= nil then
      onLoadAfter()
    end
  end, util.cs_generator(preLoadFunc))
end

function DormController:ExitDorm()
  self:Delete()
  UIManager:DeleteAllWindow()
  UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(3)
  CS.GSceneManager.Instance:LoadSceneAsyncByAB(Consts.SceneName.Main, function(ok)
    ControllerManager:GetController(ControllerTypeId.HomeController, true):OnEnterHome()
    UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
      if window == nil then
        return
      end
      window:SetFrom2Home(AreaConst.Sector, true)
    end)
  end)
end

function DormController:GetDormState()
  return self.state
end

function DormController:IsDormState(state)
  return self.state == state
end

function DormController:GetDormConfigAsset()
  return self.comRes.dormConfigAsset
end

function DormController:HasInDorm()
  return self.ctrls ~= nil
end

function DormController:InitDorm()
  self.bind = {}
  UIUtil.LuaUIBindingTable(CS.DormCameraController.Instance.transform.parent, self.bind)
  CS_LeanTouch.OnFingerTap("+", self.__onDormTouchTap)
  CS_LeanTouch.OnGesture("+", self.__onDormTouchGesture)
  for _, v in pairs(self.ctrls) do
    v:OnEnterDormScene()
  end
end

function DormController:LoadDormHouseNeedRes(dormHouseData)
  if self.houseResloader ~= nil then
    self.houseResloader:Put2Pool()
  end
  self.houseResloader = CS.ResLoader.Create()
  self.houseComRes = {}
  local curHouse = dormHouseData
  if curHouse == nil then
    error("LoadDormHouseNeedRes dormHouseData = nil")
    return
  end
  local defaultRoomId = curHouse:GetHouseDefaultRoom()
  local roomCfg = ConfigData.dorm_room[defaultRoomId]
  self.houseComRes.defaultDmRoomCfg = roomCfg
  local roomUnlockFxWait
  if not string.IsNullOrEmpty(roomCfg.unlock_fx) then
    local path = roomCfg.unlock_fx .. PathConsts.PrefabExtension
    roomUnlockFxWait = self.houseResloader:LoadABAssetAsyncAwait(path)
  end
  local hasBgEffect = not string.IsNullOrEmpty(curHouse:GetDormEffectResPath())
  local bgEffectWait
  if hasBgEffect then
    bgEffectWait = self.houseResloader:LoadABAssetAsyncAwait(PathConsts:GetFullPrefabPath(curHouse:GetDormEffectResPath()))
  end
  local roomWait = self.houseResloader:LoadABAssetAsyncAwait(PathConsts:GetDormPath("CommonPrefab/Room"))
  local lockRoomWait = self.houseResloader:LoadABAssetAsyncAwait(PathConsts:GetDormPath(roomCfg.lock_prefab))
  local defaultFloorWait = self.houseResloader:LoadABAssetAsyncAwait(PathConsts:GetDormPath(roomCfg.default_floor))
  local defaultWallWait = self.houseResloader:LoadABAssetAsyncAwait(PathConsts:GetDormPath(roomCfg.default_wall))
  if roomUnlockFxWait ~= nil then
    coroutine.yield(roomUnlockFxWait)
    self.houseComRes.roomUnlockFxPrefab = roomUnlockFxWait.Result
  end
  if hasBgEffect then
    coroutine.yield(bgEffectWait)
    self.houseComRes.bgEffectPrefab = bgEffectWait.Result
  end
  coroutine.yield(roomWait)
  self.houseComRes.roomPrefab = roomWait.Result
  coroutine.yield(lockRoomWait)
  self.houseComRes.lockRoomPrefab = lockRoomWait.Result
  coroutine.yield(defaultFloorWait)
  self.houseComRes.defaultFloorPrefab = defaultFloorWait.Result
  coroutine.yield(defaultWallWait)
  self.houseComRes.defaultWallPrefab = defaultWallWait.Result
end

function DormController:EnterNewDormHouse(dormHouseData, showUnlockFx)
  self.houseCtrl:EnterDormHouse(dormHouseData, showUnlockFx)
end

function DormController:ChangedDormHouse(houseId, afterEnterFunc)
  local houseData = self.allDormData.houseDic[houseId]
  if houseData == nil then
    return
  end
  if self.state == DormEnum.eDormState.HouseEdit then
    UIUtil.OnClickBackByUiTab(self.dormWindow)
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local readed = saveUserData:GetNewDormHouseReaded(houseId)
  local showUnlockHouseFx = not houseData:IsDmHouseLock() and not readed and not houseData:IsDefaultUnlockDmHouse()
  if not houseData:IsDmHouseLock() then
    PlayerDataCenter.dormBriefData:SetDormHouseNewReaded(houseId)
  end
  if not houseData:IsDmHouseUnlockableReaded() then
    PlayerDataCenter.dormBriefData:SetDmHouseUnlockableReaded(houseId)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.SceneChangesMask, function(win)
    win:InitSceneChangesMask(function()
      local function asyncLoadFunc()
        local dormHouseData = self.allDormData.houseDic[houseId]
        
        self:LoadDormHouseNeedRes(dormHouseData)
        UIManager:HideWindow(UIWindowTypeID.ClickContinue)
        self:EnterNewDormHouse(dormHouseData, showUnlockHouseFx)
        self.__changeDormHouseCo = nil
      end
      
      UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.black, false)
      self.__changeDormHouseCo = GR.StartCoroutine(util.cs_generator(asyncLoadFunc))
    end, function()
      if afterEnterFunc ~= nil then
        afterEnterFunc()
      end
      if showUnlockHouseFx then
        self.houseCtrl:TryPlayDmAllRoomUnlockFx()
      end
    end)
  end)
end

function DormController:ChangedToVisitDormHouse(visitHouseData, afterEnterFunc)
  if visitHouseData == nil then
    return
  end
  if self.state == DormEnum.eDormState.HouseEdit then
    UIUtil.OnClickBackByUiTab(self.dormWindow)
  end
  local uiDormVisitWinodw = UIManager:GetWindow(UIWindowTypeID.DormVisit)
  if uiDormVisitWinodw ~= nil then
    UIManager:DeleteWindow(UIWindowTypeID.DormVisit)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.SceneChangesMask, function(win)
    win:InitSceneChangesMask(function()
      self:EmitExitDormRoomStart(true)
      
      local function asyncLoadFunc()
        local dormHouseData = visitHouseData
        self:LoadDormHouseNeedRes(dormHouseData)
        UIManager:HideWindow(UIWindowTypeID.ClickContinue)
        self:EnterNewDormHouse(dormHouseData, false)
        self.__changeDormHouseCo = nil
        for pos, roomEntity in pairs(self.houseCtrl.roomEnityDic) do
          self:DirectlyEnterTheRoom(roomEntity)
          return
        end
      end
      
      UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.black, false)
      self.__changeDormHouseCo = GR.StartCoroutine(util.cs_generator(asyncLoadFunc))
    end, function()
      if afterEnterFunc ~= nil then
        afterEnterFunc()
      end
    end)
  end)
end

function DormController:TryBuyNewHouse(houseId)
  local houseData = self.allDormData.houseDic[houseId]
  if houseData == nil or not houseData:IsDmHouseLock() then
    return
  end
  local costItemId, costItemNum = houseData:GetDmHouseBuyCost()
  if costItemId ~= ConstGlobalItem.DmHouseTicket then
    error("Unsurported house Unlock")
    return
  end
  local haveNum = PlayerDataCenter:GetItemCount(costItemId)
  if 0 < haveNum then
    PlayerDataCenter.dormBriefData:CheckDmHouseUnlock()
    return
  end
  local quickBuyData = ShopEnum.eQuickBuy.DmHouse
  local shopId = quickBuyData.shopId
  local needItemNum = costItemNum - PlayerDataCenter:GetItemCount(costItemId)
  local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  local isUnlcok, unlockNotice = shopCtrl:ShopIsUnlock(shopId)
  if not isUnlcok then
    cs_MessageCommon.ShowMessageTips(unlockNotice)
    return
  end
  shopCtrl:GetShopData(shopId, function(shopData)
    local goodData = shopData:GetNormalShopGoodByItemId(costItemId)
    if goodData == nil then
      error("Cant get goodData from normalShop, itemId = " .. costItemId)
      return
    end
    if goodData:GetShopGoodCouldBuyNum() <= 0 then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(2047))
      return
    end
    local needCurrencyNum = goodData.newCurrencyNum * needItemNum
    local fomatMsg = ConfigData:GetTipContent(335)
    local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
    payCtrl:PaidCurrencyExecute(goodData.currencyId, needCurrencyNum, costItemId, needItemNum, function()
      shopCtrl:ReqBuyGoods(goodData.shopId, goodData.shelfId, needItemNum)
    end, nil, fomatMsg)
  end)
end

function DormController:GetSelfUserId()
  return PlayerDataCenter.inforData:GetUserUID()
end

function DormController:GetDormOwnerUserId()
  return self.dormOwnerId
end

function DormController:GetDormOwnerName()
  return self.dormOwnerName
end

function DormController:IsSelfDorm()
  local dormOwnerId = self:GetDormOwnerUserId()
  return dormOwnerId == nil or dormOwnerId == self:GetSelfUserId()
end

function DormController:GetCurHouse()
  return self.houseCtrl.curHouse
end

function DormController:GetCurRoomEntity()
  return self.roomCtrl.roomEntity
end

function DormController:GetCurRoom()
  local roomEntity = self:GetCurRoomEntity()
  if roomEntity == nil then
    return nil
  end
  return roomEntity.roomData
end

function DormController:GetBindFntDataList()
  if self.state == DormEnum.eDormState.House or self.state == DormEnum.eDormState.HouseEdit then
    local houseData = self:GetCurHouse()
    local bindFntDataList = houseData:GetHouseBindFntDataList()
    return bindFntDataList
  elseif self.state == DormEnum.eDormState.Room or self.state == DormEnum.eDormState.RoomEdit then
    local roomData = self:GetCurRoom()
    return roomData:GetRoomCanBindList()
  end
end

function DormController:GetAllBindFntData()
  if self.allDormData == nil then
    return
  end
  return self.allDormData:GetAllBindFntData()
end

function DormController:SetAllBindFntDataDirty()
  if self.allDormData == nil then
    return
  end
  self.allDormData:SetAllBindFntDataDirty()
end

function DormController:ChangeDormBind(fntData, newHeroId)
  local oldHeroId = fntData:GetFntParam()
  if oldHeroId == newHeroId then
    return
  end
  local curRoomData = fntData:GetFntRoom()
  self._dormBindDatas = {newHeroId = newHeroId, fntData = fntData}
  local houseId = self.houseCtrl.curHouse.id
  local roomPos = curRoomData.spos
  local bind = newHeroId ~= 0
  local heroId = bind and newHeroId or oldHeroId
  local index = curRoomData:GetFntDataIndex(fntData) - 1
  self.dormNetwork:CS_DORM_BindUnbindHero(heroId, bind, houseId, roomPos, index, self.__onChangeDormBindComplete)
end

function DormController:OnChangeDormBindComplete(dataList)
  local success = dataList[0]
  if success then
    local oldBindId = self._dormBindDatas.fntData:GetFntParam()
    self._dormBindDatas.fntData:SetFntParam(self._dormBindDatas.newHeroId)
    local curRoomData = self._dormBindDatas.fntData:GetFntRoom()
    local allBindFntData = self:GetAllBindFntData()
    if allBindFntData == nil then
      return
    end
    local newHeroBindFntData = allBindFntData.boundDic[self._dormBindDatas.newHeroId]
    if newHeroBindFntData ~= nil then
      newHeroBindFntData:SetFntParam(0)
      local newheroRoomData
      newheroRoomData = newHeroBindFntData:GetFntRoom()
      if newheroRoomData ~= curRoomData then
        local fntDatas = newheroRoomData:GetFntDatas()
        newheroRoomData:UpdateRoomFntData(fntDatas, false)
      end
    end
    local newfntDatas = curRoomData:GetFntDatas()
    curRoomData:UpdateRoomFntData(newfntDatas, false)
    self:SetAllBindFntDataDirty()
    self.characterCtrl:SetBindCharacterChange(self._dormBindDatas.fntData, oldBindId, self._dormBindDatas.newHeroId)
    if self.dormWindow ~= nil then
      self.dormWindow:RefreshDormHeroList()
    end
  end
  self._dormBindDatas = nil
end

function DormController:EnterDormOverview()
  print("UIWindowTypeID.DormOverview: the prefab is Delete")
end

function DormController:RecvPurchaseHouse(houseId)
  if self.allDormData == nil then
    return
  end
  self.allDormData:AddNewHouse(houseId)
  if self.houseCtrl:GetCurHouseId() == houseId then
    PlayerDataCenter.dormBriefData:SetDormHouseNewReaded(houseId)
  end
  if self.dormWindow ~= nil then
    self.dormWindow:RefreshDormWindow()
  end
end

function DormController:EmitEnterDormHouse()
  self.state = DormEnum.eDormState.House
  for _, v in pairs(self.ctrls) do
    v:OnEnterDormHouse()
  end
end

function DormController:EmitEnterDormHouseEditMode()
  self.state = DormEnum.eDormState.HouseEdit
  for _, v in pairs(self.ctrls) do
    v:OnEnterDormHouseEditMode()
  end
end

function DormController:EmitExitDormHouseEditMode(success)
  self.state = DormEnum.eDormState.House
  for _, v in pairs(self.ctrls) do
    v:OnExitDormHouseEditMode(success)
  end
end

function DormController:EmitEnterDormRoomEditMode(roomEntity)
  self.state = DormEnum.eDormState.RoomEdit
  for _, v in pairs(self.ctrls) do
    v:OnEnterDormRoomEditMode(roomEntity)
  end
end

function DormController:EmitExitDormRoomEditMode(roomEntity, success)
  self.state = DormEnum.eDormState.Room
  for _, v in pairs(self.ctrls) do
    v:OnExitDormRoomEditMode(roomEntity, success)
  end
end

function DormController:EmitEnterDormRoomStart(roomEntity)
  self.state = DormEnum.eDormState.House2Room
  UIManager:HideWindow(UIWindowTypeID.DormMain)
  for _, v in pairs(self.ctrls) do
    v:OnEnterDormRoomStart(roomEntity)
  end
end

function DormController:EmitEnterDormRoomEnd()
  self.state = DormEnum.eDormState.Room
  local roomEntity = self:GetCurRoomEntity()
  if roomEntity == nil then
    return
  end
  for _, v in pairs(self.ctrls) do
    v:OnEnterDormRoomEnd(roomEntity)
  end
end

function DormController:DirectlyEnterTheRoom(roomEntity)
  if self._DmFntEntityInLoadingCo ~= nil then
    GR.StopCoroutine(self._DmFntEntityInLoadingCo)
    self._DmFntEntityInLoadingCo = nil
  end
  self:EmitEnterDormRoomStart(roomEntity)
  UIManager:ShowWindowAsync(UIWindowTypeID.SceneChangesMask, function(win)
    if win == nil then
      return
    end
    win:InitSceneChangesMask(function()
      self.cameraCtrl:EnterRoomCameraState(roomEntity)
      self.bind.roomTarget.position = roomEntity.transform.position + self.bind.roomTarPosOffset
      self.dormWindow:ShowDmStateNode(false)
    end, function()
      if self._DmFntEntityInLoadingCo ~= nil then
        GR.StopCoroutine(self._DmFntEntityInLoadingCo)
        self._DmFntEntityInLoadingCo = nil
      end
      self._DmFntEntityInLoadingCo = GR.StartCoroutine(util.cs_generator(function()
        while roomEntity == nil or roomEntity:IsAnyDmFntEntityInLoading() do
          coroutine.yield(nil)
        end
        self:EmitEnterDormRoomEnd()
        self.roomCtrl:ShowDormRoomUI()
      end))
    end)
  end)
end

function DormController:EmitExitDormRoomStart(toOtherRoom)
  self.state = DormEnum.eDormState.Room2House
  local roomEntity = self:GetCurRoomEntity()
  if roomEntity == nil then
    return
  end
  for _, v in pairs(self.ctrls) do
    v:OnExitDormRoomStart(roomEntity, toOtherRoom)
  end
end

function DormController:EmitExitDormRoomEnd()
  self.state = DormEnum.eDormState.House
  UIManager:ShowWindowOnly(UIWindowTypeID.DormMain)
  for _, v in pairs(self.ctrls) do
    v:OnExitDormRoomEnd()
  end
end

function DormController:EnterDormEditor(callback)
  if not self:IsDormState(DormEnum.eDormState.House) then
    return
  end
  self:EmitEnterDormHouseEditMode()
  self.dormWindow:ShowDormEditMode(true)
end

function DormController:OpenDormShop()
  self.shopCtrl:EnterDormShop()
end

function DormController:OpenDormWarehouse()
  if self.state == DormEnum.eDormState.House or self.state == DormEnum.eDormState.HouseEdit then
  elseif self.state == DormEnum.eDormState.Room or self.state == DormEnum.eDormState.RoomEdit then
    self.roomCtrl:ShowFntWarehouse(true)
  end
end

function DormController:OnDormTouchTap(finger)
  if finger.StartedOverGui then
    return
  end
  if self:IsDormState(DormEnum.eDormState.House) then
    if self.dormWindow ~= nil then
      self.dormWindow:Show()
    end
    UIManager:ShowWindowOnly(UIWindowTypeID.TopStatus)
    return
  end
  if self:IsDormState(DormEnum.eDormState.Room) then
    local roomWindow = UIManager:GetWindow(UIWindowTypeID.DormRoom)
    if roomWindow ~= nil and roomWindow:IsRoomUIHideState() then
      UIManager:ShowWindowOnly(UIWindowTypeID.DormRoom)
      UIManager:ShowWindowOnly(UIWindowTypeID.TopStatus)
      UIManager:ShowWindowOnly(UIWindowTypeID.DormInput)
      UIManager:ShowWindowOnly(UIWindowTypeID.DormInteract)
    end
    return
  end
end

function DormController:OnDormTouchGesture(fingerList)
end

function DormController:ReqDormTimingProductPick(tmProductData, callback)
  if not tmProductData:CanTmProductRes(true) then
    return
  end
  self._reqTmProductPickCallback = callback
  self._OnDormTimingProductPickFunc = self._OnDormTimingProductPickFunc or BindCallback(self, self.OnDormTimingProductPick)
  NetworkManager:GetNetwork(NetworkTypeID.TimingProduct):CS_TimingProduct_Pick(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm, tmProductData.id, self._OnDormTimingProductPickFunc)
end

function DormController:OnDormTimingProductPick(objList)
  if self._reqTmProductPickCallback ~= nil then
    self._reqTmProductPickCallback()
  end
  if objList.Count == 0 then
    error("objList.Count == 0")
    return
  end
  local addItemDic = objList[0]
  self:_OnGetRes(addItemDic)
end

function DormController:ReqDormTimingProductPickAll(callback)
  local tmProductGroupDic = PlayerDataCenter.allTimingProduct:GetTimingProductDataGroupItemId(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm)
  local fullWareHouseItemDic = {}
  local cantGetOne = false
  for k, tmProductDic in pairs(tmProductGroupDic) do
    for k2, tmProductData in pairs(tmProductDic) do
      local cantGet = tmProductData:CanTmProductRes(false, fullWareHouseItemDic)
      if cantGet then
        cantGetOne = true
      end
    end
  end
  for name, _ in pairs(fullWareHouseItemDic) do
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.ItemInWarehouseFull, name), true)
  end
  if not cantGetOne then
    return
  end
  self._reqTmProductPickAllCallback = callback
  self._OnDormTimingProductPickAllFunc = self._OnDormTimingProductPickAllFunc or BindCallback(self, self.OnDormTimingProductPickAll)
  NetworkManager:GetNetwork(NetworkTypeID.TimingProduct):CS_TimingProduct_PickAll(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm, self._OnDormTimingProductPickAllFunc)
end

function DormController:OnDormTimingProductPickAll(objList)
  if self._reqTmProductPickAllCallback ~= nil then
    self._reqTmProductPickAllCallback()
  end
  if objList.Count == 0 then
    error("objList.Count == 0")
    return
  end
  local addItemDic = objList[0]
  self:_OnGetRes(addItemDic)
end

function DormController:_OnGetRes(addItemDic)
  for resId, resNum in pairs(addItemDic) do
    local itemCfg = ConfigData.item[resId]
    if itemCfg ~= nil then
      local msg = ConfigData:GetTipContent(TipContent.Building_GainReward, LanguageUtil.GetLocaleText(itemCfg.name), resNum)
      cs_MessageCommon.ShowMessageTips(msg, true)
    end
  end
  AudioManager:PlayAudioById(1090)
end

function DormController:__ClearData()
  self.state = DormEnum.eDormState.None
  self.bind = nil
  self.allDormData = nil
  if self.__onDormTouchTap ~= nil then
    CS_LeanTouch.OnFingerTap("-", self.__onDormTouchTap)
    self.__onDormTouchTap = nil
  end
  if self.__onDormTouchGesture ~= nil then
    CS_LeanTouch.OnGesture("-", self.__onDormTouchGesture)
    self.__onDormTouchGesture = nil
  end
  if self.comResloader ~= nil then
    self.comResloader:Put2Pool()
    self.comResloader = nil
  end
  self.comRes = nil
  if self.houseResloader ~= nil then
    self.houseResloader:Put2Pool()
    self.houseResloader = nil
  end
  self.houseComRes = nil
  if self.__changeDormHouseCo ~= nil then
    GR.StopCoroutine(self.__changeDormHouseCo)
    self.__changeDormHouseCo = nil
  end
  if self.ctrls ~= nil then
    for _, v in pairs(self.ctrls) do
      v:OnDelete()
    end
    self.ctrls = nil
  end
  CS.RenderManager.Instance:SetUnityShadow(false)
  if self.__oldShadowDistance ~= nil then
    cs_QualitySettings.shadowDistance = self.__oldShadowDistance
    self.__oldShadowDistance = nil
  end
  if self.__oldLoadBias ~= nil then
    cs_QualitySettings.lodBias = self.__oldLoadBias
    self.__oldLoadBias = nil
  end
  AudioManager:RemoveCueSheet(eAuCueSheet.DormFurniture)
end

function DormController:OnDelete()
  self:__ClearData()
end

return DormController

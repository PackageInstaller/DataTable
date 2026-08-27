local UIStrategyOverview = class("UIStrategyOverview", UIBaseWindow)
local base = UIBaseWindow
local UINStOList = require("Game.StrategyOverview.UI.StOList.UINStOList")
local UIStOSideNode = require("Game.StrategyOverview.UI.Side.UIStOSideNode")
local UINBuildLogicLvPreview = require("Game.StrategyOverview.UI.BuildLogicLvPreview.UINBuildLogicLvPreview")
local UINStoCareerList = require("Game.StrategyOverview.UI.CareerList.UINStOCareerList")
local BuildingEnum = require("Game.Oasis.Data.BuildingEnum")
local CS_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local CS_Input = CS.UnityEngine.Input
local LockGoType = {Normal = 1, Rhombus = 2}

function UIStrategyOverview:OnInit()
  UIUtil.SetTopStatus(self, self._OnClickClose, {
    ConstGlobalItem.NormalGold,
    ConstGlobalItem.BuildBlueprint
  })
  self.resLoader = CS_ResLoader.Create()
  self.stOList = UINStOList.New(self, self.ui)
  self.stOList:Init(self.ui.stOList)
  self.stOList:Hide()
  self.stOSide = UIStOSideNode.New(self)
  self.stOSide:Init(self.ui.side)
  self.previewNode = UINBuildLogicLvPreview.New()
  self.previewNode:Init(self.ui.previewNode)
  self.previewNode:Hide()
  self.stOCareerList = UINStoCareerList.New(self, self.ui)
  self.stOCareerList:Init(self.ui.careerList)
  self.stOCareerList:Hide()
  self.__onItemRefresh = BindCallback(self, self._OnItemRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateARGItem, self.__onItemRefresh)
  self.__RefreshStOBuleDot = BindCallback(self, self.RefreshStOBuleDot)
  RedDotController:AddListener(RedDotDynPath.StrategyOverviewPath, self.__RefreshStOBuleDot)
  self.ui.tran_rect.localPosition = Vector3.New(0, -50, 0)
  UIUtil.AddValueChangedListener(self.ui.tog_GotoOverview, self, self.OnValueChangeOverview)
  UIUtil.AddValueChangedListener(self.ui.tog_GotoCareer, self, self.OnValueChangeCareer)
  self.lockGoList = {}
  self.lockRhombusGoList = {}
  local UINStOTechItemBaseEdge = require("Game.StrategyOverview.UI.StOItemEdge.UINStOTechItemBaseEdge")
  local UINStOTechItemRewardEdge = require("Game.StrategyOverview.UI.StOItemEdge.UINStOTechItemRewardEdge")
  local UINStOTechItemRhombusEdge = require("Game.StrategyOverview.UI.StOItemEdge.UINStOTechItemRhombusEdge")
  self.TechItemEdgeCfgTable = {
    [BuildingEnum.TechItemEdgeType.SmallEdge] = {
      tableClass = UINStOTechItemBaseEdge,
      prefab = self.ui.prefab_NorEdge,
      scale = 0.75
    },
    [BuildingEnum.TechItemEdgeType.MiddleEdge] = {
      tableClass = UINStOTechItemBaseEdge,
      prefab = self.ui.prefab_BigEdge
    },
    [BuildingEnum.TechItemEdgeType.RhombusEdge] = {
      tableClass = UINStOTechItemRhombusEdge,
      prefab = self.ui.prefab_RhombusEdge,
      lockGoType = LockGoType.Rhombus
    },
    [BuildingEnum.TechItemEdgeType.RewardEdge] = {
      tableClass = UINStOTechItemRewardEdge,
      prefab = self.ui.prefab_rewardEdge
    }
  }
  self.__multiTouchEnabledBeforeOpen = CS_Input.multiTouchEnabled
  CS_Input.multiTouchEnabled = false
end

function UIStrategyOverview:OnShow()
  base.OnShow(self)
  AudioManager:PlayAudioById(1066)
end

function UIStrategyOverview:InitUIStO(stOCtrl, techDataList)
  self:InitData(stOCtrl, self.stOList, self.ui.tog_GotoOverview, techDataList)
  self.stOList:InitStOList(self.resLoader, techDataList)
end

function UIStrategyOverview:InitCareerStO(stOCtrl, techDataList)
  self:InitData(stOCtrl, self.stOCareerList, self.ui.tog_GotoCareer, techDataList)
  self.stOCareerList:InitStOCareer(self.resLoader, techDataList)
  local checkFunc, selectFunc = self.stOCareerList:GetCareerListSelectNextFunc()
  self.stOSide:SetNextJumpCallback(checkFunc, selectFunc)
end

function UIStrategyOverview:InitData(stOCtrl, StOList, tog, techDataList)
  self.stOCtrl = stOCtrl
  self._cancleTogFunEnble = true
  tog.isOn = true
  StOList:Show()
  self._cancleTogFunEnble = false
  self.currentShowList = self.stOList
  self:RefreshLevelShow()
  self:RefreshStOBuleDot()
end

function UIStrategyOverview:ShowStOTechSide(buildingData)
  self.stOSide:InitStOSideNode(buildingData)
end

function UIStrategyOverview:OnStOBuildUpgradeComplete(buildingData)
  self.currentShowList:OnBuildUpgradeStOList(buildingData)
  self.stOSide:OnBuildUpgradeStOSide(buildingData)
  self:RefreshLevelShow()
end

function UIStrategyOverview:UpdateUIStOBuilding(buildingData)
  self.currentShowList:RefreshAllStOListTech(buildingData)
  self.stOSide:OnBuildUpgradeStOSide(buildingData)
  self:RefreshLevelShow()
end

function UIStrategyOverview:_OnItemRefresh(itemIdDic)
  local noChanged = true
  for itemId, _ in pairs(itemIdDic) do
    if ConfigData.buildingLevel.resConsumeDic[itemId] ~= nil then
      noChanged = false
      break
    end
  end
  if noChanged then
    return
  end
  self.currentShowList:RefreshAllStOListTech()
  self.stOSide:RefreshStOSide()
end

function UIStrategyOverview:_OnClickClose()
  ControllerManager:DeleteController(ControllerTypeId.StrategyOverview)
end

function UIStrategyOverview:ShowStOPreview(buildingData)
  self.previewNode:Show()
  self.previewNode:InitBuildLogicLvPreview(buildingData)
end

function UIStrategyOverview:OnValueChangeOverview(flag)
  if self._cancleTogFunEnble then
    return
  end
  if not flag then
    self.stOList:Hide()
    return
  end
  self.stOList:Show()
  if not self.stOList.isInit then
    local strategyCtrl = ControllerManager:GetController(ControllerTypeId.StrategyOverview)
    local techList = strategyCtrl:GetTechDataList()
    self.stOList:InitStOList(self.resLoader, techList)
  end
  self.currentShowList = self.stOList
  self.currentShowList:EnterStOList()
end

function UIStrategyOverview:OnValueChangeCareer(flag)
  if self._cancleTogFunEnble then
    return
  end
  if not flag then
    self.stOCareerList:Hide()
    self.stOSide:SetNextJumpCallback(nil, nil)
    return
  end
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding1) then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding1))
    self.ui.tog_GotoOverview.isOn = true
    return
  end
  self.stOCareerList:Show()
  if not self.stOCareerList.isInit then
    local strategyCtrl = ControllerManager:GetController(ControllerTypeId.StrategyOverview)
    local techList = strategyCtrl:GetCareerMaster()
    self.stOCareerList:InitStOCareer(self.resLoader, techList)
  end
  self.currentShowList = self.stOCareerList
  self.stOCareerList:EnterStOList()
  local checkFunc, selectFunc = self.stOCareerList:GetCareerListSelectNextFunc()
  self.stOSide:SetNextJumpCallback(checkFunc, selectFunc)
end

function UIStrategyOverview:GetStOTechLock(edgeType)
  local lockType = LockGoType.Normal
  if edgeType ~= nil then
    local edgeElement = self.TechItemEdgeCfgTable[edgeType]
    if edgeElement ~= nil and edgeElement.lockGoType ~= nil then
      lockType = edgeElement.lockGoType
    end
  end
  local lockGo
  if lockType == LockGoType.Normal then
    if #self.lockGoList > 0 then
      lockGo = table.remove(self.lockGoList)
    else
      lockGo = self.ui.prefab_obj_IsLock:Instantiate()
    end
  elseif 0 < #self.lockRhombusGoList then
    lockGo = table.remove(self.lockRhombusGoList)
  else
    lockGo = self.ui.prefab_obj_IsLockRhombus:Instantiate()
  end
  return lockGo
end

function UIStrategyOverview:ReturnStOTechLock(edgeType, lockGo)
  lockGo.transform:SetParent(self.ui.prefabPool.transform)
  local lockType = LockGoType.Normal
  if edgeType ~= nil then
    local edgeElement = self.TechItemEdgeCfgTable[edgeType]
    if edgeElement ~= nil and edgeElement.lockGoType ~= nil then
      lockType = edgeElement.lockGoType
    end
  end
  if lockType == LockGoType.Normal then
    table.insert(self.lockGoList, lockGo)
  else
    table.insert(self.lockRhombusGoList, lockGo)
  end
end

function UIStrategyOverview:GetFX_LevelUp()
  return self.ui.prefab_fX_LevelUp
end

function UIStrategyOverview:SelectStOTechItem(parentGroup, buildingData)
  self.ui.prefab_obj_OnSelelct.transform:SetParent(parentGroup.transform)
  self.ui.prefab_obj_OnSelelct.transform.localPosition = Vector3.zero
  self.ui.prefab_obj_OnSelelct.transform.localScale = Vector3.one
  self.ui.prefab_obj_OnSelelct.transform.localRotation = Quaternion.Euler(0, 0, 0)
  self:ShowStOTechSide(buildingData)
end

function UIStrategyOverview:RefreshLevelShow()
  self.ui.tex_Level_StO:SetIndex(0, tostring(PlayerDataCenter.AllBuildingData.stoTotalLevel))
  self.ui.tex_Level_Career:SetIndex(0, tostring(PlayerDataCenter.AllBuildingData.careerTotalLevel))
end

function UIStrategyOverview:GetTechItemEdge(nodeType)
  local edgeCfg = self.TechItemEdgeCfgTable[nodeType or 0]
  if edgeCfg == nil then
    edgeCfg = self.TechItemEdgeCfgTable[BuildingEnum.TechItemEdgeType.MiddleEdge]
  end
  local copyPrefab = edgeCfg.prefab:Instantiate()
  local tableClass = edgeCfg.tableClass.New()
  tableClass:Init(copyPrefab)
  tableClass:SetPreData(nodeType, edgeCfg.scale or 1)
  return tableClass
end

function UIStrategyOverview:RefreshStOBuleDot()
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.StrategyOverview, RedDotStaticTypeId.SectorBuilding)
  self.ui.blueDot_StO:SetActive(ok and node:GetRedDotCount() > 0)
  ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.StrategyOverview, RedDotStaticTypeId.CareerRewardBuild)
  if ok and node:GetRedDotCount() > 0 then
    self.ui.redDot_Career:SetActive(true)
    self.ui.blueDot_Career:SetActive(false)
  else
    ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.StrategyOverview, RedDotStaticTypeId.CareerBuilding)
    self.ui.blueDot_Career:SetActive(ok and node:GetRedDotCount() > 0)
    self.ui.redDot_Career:SetActive(false)
  end
end

function UIStrategyOverview:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemRefresh)
  MsgCenter:RemoveListener(eMsgEventId.UpdateARGItem, self.__onItemRefresh)
  RedDotController:RemoveListener(RedDotDynPath.StrategyOverviewPath, self.__RefreshStOBuleDot)
  CS_Input.multiTouchEnabled = self.__multiTouchEnabledBeforeOpen
  self.stOList:Delete()
  self.stOCareerList:Delete()
  self.stOSide:Delete()
  self.previewNode:Delete()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  base.OnDelete(self)
end

return UIStrategyOverview

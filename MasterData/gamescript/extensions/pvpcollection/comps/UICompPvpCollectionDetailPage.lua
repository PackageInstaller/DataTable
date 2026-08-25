local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local PVPCollectionType = CommonDefine.PVPCollectionType
local CommonSkillNum = 4
local UICompPvpCollectionDetailPage, Super = NewViewComponent("UICompPvpCollectionDetailPage")

function UICompPvpCollectionDetailPage:ctor(uiNode, view)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Pvp_Panel_Collection_DetailResource(uiNode)
  self:_InitViewData()
end

function UICompPvpCollectionDetailPage:OnBuildComponent()
end

function UICompPvpCollectionDetailPage:OnEnterComponent()
  self:_RefreshView()
end

function UICompPvpCollectionDetailPage:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnPvpCollectionSelectChange, self._OnPvpCollectionSelect, self)
end

function UICompPvpCollectionDetailPage:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Maniac, System.fn(self, self._OnClickBtnManiac))
  self:AddButtonClickListener(self.ui.Btn_Image_Show, System.fn(self, self._OnClickBtnImageShow))
  self:AddButtonClickListener(self.ui.Btn_PVPTrain, System.fn(self, self._OnClickPvpTrain))
  self:AddUICustomInputlistener(self.ui.Image_Detailed_Bg, System.fn(self, self._OnCustomInputDetailBg))
end

function UICompPvpCollectionDetailPage:_OnPvpCollectionSelect()
  self:_RefreshView()
end

function UICompPvpCollectionDetailPage:_OnClickBtnImageShow()
  self:_SetSelectSkillTid(nil)
end

function UICompPvpCollectionDetailPage:_OnClickBtnManiac()
  self:_RefreshUltiSkillDetail(true)
end

function UICompPvpCollectionDetailPage:_OnClickPvpTrain()
  local tid = PvpCollectionModel.Instance:GetSelectCollectionTid()
  local awakerTid = PvpCollectCfgUtils.GetCollectAwakerTid(tid)
  local pvpTrainData = BattlePVPTrainMockDataUtil.MockDataToBattleData(awakerTid)
  self:OnExitComponent()
  BattleManager.Instance:EnterBattle(pvpTrainData)
end

function UICompPvpCollectionDetailPage:_OnCustomInputDetailBg(hover)
  if GuidePanelUtils.IsViewAtTop(Urls.CommonCardKeyWorldDescPanel) then
    return
  end
  if not hover then
    self:_RefreshUltiSkillDetail(false)
  end
end

function UICompPvpCollectionDetailPage:_InitViewData()
  PvpCollectionModel.Instance:SetSelectAwakerSkillTid(nil)
end

function UICompPvpCollectionDetailPage:_SetSelectSkillTid(skillTid)
  PvpCollectionModel.Instance:SetSelectAwakerSkillTid(skillTid)
  self:_RefreshCardComp()
end

function UICompPvpCollectionDetailPage:_GetAwakerUltiSkillDesc()
  local targetCollectionTid = PvpCollectionModel.Instance:GetSelectCollectionTid()
  local ultiSkillTid = PvpCollectCfgUtils.GetCollectAwakerUltiSkillTid(targetCollectionTid)
  local awakerTid = PvpCollectCfgUtils.GetCollectAwakerTid(targetCollectionTid)
  if not awakerTid then
    return
  end
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awakerData then
    return
  end
  do return SkillUtils.GetAwakerSkillDesc, awakerData, ultiSkillTid end
  return SkillUtils.GetAwakerSkillDesc, awakerData, ultiSkillTid, 1
end

function UICompPvpCollectionDetailPage:_GetJumpItemTid()
  local targetCollectionTid = PvpCollectionModel.Instance:GetSelectCollectionTid()
  local config = PvpCollectCfgUtils.GetCfg(targetCollectionTid)
  local rst = config.Item
  local itemCfg = DT.Item[rst]
  if itemCfg and itemCfg.DropItemGets then
    rst = itemCfg.DropItemGets
  end
  return rst
end

function UICompPvpCollectionDetailPage:_RefreshView()
  local targetCollectionTid = PvpCollectionModel.Instance:GetSelectCollectionTid()
  local collectionType = PvpCollectCfgUtils.GetCollectionType(targetCollectionTid)
  if collectionType == PVPCollectionType.Awaker then
    self:_RefreshAwakerDetail(targetCollectionTid)
  else
    self:_RefreshWeaponOrKeeperSkillDetail(targetCollectionTid)
  end
end

function UICompPvpCollectionDetailPage:_RefreshAwakerDetail(targetCollectionTid)
  self:SetActive(self.ui.Image_Role, true)
  self:SetActive(self.ui.Image_Weapons, false)
  local name = PvpCollectCfgUtils.GetCollectionName(targetCollectionTid)
  self:SetText(self.ui.Text_Name_Role, LT.Text(name))
  local hpAttrCfg = ActorAttrTypeCfgUtils.GetCfgByName("hp")
  self:SetImage(self.ui.Image_Hoist_Icon, hpAttrCfg and hpAttrCfg.Icon)
  self:SetText(self.ui.Text_Hoist_Name, hpAttrCfg and LT.Text(hpAttrCfg.Text))
  self:SetText(self.ui.Text_Hoist_CurrValue, PvpCollectCfgUtils.GetCollectAwakerHp(targetCollectionTid))
  self:SetText(self.ui.Text_Role_Quantity, PvPSeasonDataUtils.GetSeasonCollectWinTimes(targetCollectionTid))
  self:SetText(self.ui.Text_Role_TotalWins, PVPCollectionDataUtils.GetCollectionWinTimes(targetCollectionTid))
  self:_RefreshAwakerUltiSkill(targetCollectionTid)
  self:_RefreshAwakerCommonSkill(targetCollectionTid)
  self:SetText(self.ui.Text_Train_Name, LT.Text("PVPAwakerTrain"))
  self:SetActive(self.ui.Btn_PVPTrain, true)
end

function UICompPvpCollectionDetailPage:_RefreshAwakerUltiSkill(targetCollectionTid)
  local ultiSkillTid = PvpCollectCfgUtils.GetCollectAwakerUltiSkillTid(targetCollectionTid)
  local ultiSkillCfg = SkillCfgUtils.GetCfg(ultiSkillTid)
  local skillName = BattleSkillUtils.GetSkillName(ultiSkillCfg, 0, 0)
  self:SetText(self.ui.Text_Maniac, skillName)
  self:SetText(self.ui.Text_Skill_Name, skillName)
  self:SetText(self.ui.Text_Skill_Desc, self:_GetAwakerUltiSkillDesc())
end

function UICompPvpCollectionDetailPage:_RefreshAwakerCommonSkill(targetCollectionTid)
  local skillTypeInfoList = PvpCollectCfgUtils.GetCollectAwakerSkillInfoList(targetCollectionTid)
  if not skillTypeInfoList then
    return
  end
  for i = 1, CommonSkillNum do
    local skillTypeInfo = skillTypeInfoList[i]
    local obj = self.ui["Btn_Card_" .. i]
    self:SetActive(obj, nil ~= skillTypeInfo)
    if not obj or not skillTypeInfo then
    else
      local viewData = {
        skillTid = skillTypeInfo.tid,
        num = skillTypeInfo.num,
        clickCallback = function()
          self:_SetSelectSkillTid(skillTypeInfo.tid)
        end
      }
      self:AddViewComponentOnce(obj, UICompPvpCollectionDetailSkillItem, viewData)
    end
  end
end

function UICompPvpCollectionDetailPage:_RefreshWeaponOrKeeperSkillDetail(targetCollectionTid)
  self:SetActive(self.ui.Image_Role, false)
  self:SetActive(self.ui.Image_Weapons, true)
  self:SetActive(self.ui.Btn_PVPTrain, false)
  local name = PvpCollectCfgUtils.GetCollectionName(targetCollectionTid)
  self:SetText(self.ui.Text_Name_First, LT.Text(name))
  self:SetText(self.ui.Text_Attribute_CurrValue, PvpCollectCfgUtils.GetCollectionPvpSkillCost(targetCollectionTid))
  self:SetText(self.ui.Text_TotalWins, PVPCollectionDataUtils.GetCollectionWinTimes(targetCollectionTid))
  self:SetText(self.ui.Text_Quantity, PvPSeasonDataUtils.GetSeasonCollectWinTimes(targetCollectionTid))
  self:SetText(self.ui.Text_Source, LT.Text("TipsOriginTitle"))
  local config = PvpCollectCfgUtils.GetCfg(targetCollectionTid)
  local itemTid = config.Item
  self.ui.ScrollView:GetComponent(T_ScrollRect).verticalNormalizedPosition = 1
  self:SetText(self.ui.Text_introduce, PvpCollectCfgUtils.GetCollectionPvpSkillDesc(targetCollectionTid), nil, nil, {isCenterY = true})
  StrUtils.SetPreferredHeight(self.ui.Text_introduce)
  local isTaleActive = PVPCollectionDataUtils.HasOwnedCollection(targetCollectionTid)
  self:SetActive(self.ui.Text_Tale, isTaleActive)
  self:SetText(self.ui.Text_Tale, PvpCollectCfgUtils.GetItemStoryDescByCollectTid(targetCollectionTid))
  StrUtils.SetPreferredHeight(self.ui.Text_Tale)
  if ItemDataUtils.GetItemNum(itemTid) > 0 then
    self:SetActive(self.ui.Image_Resource, false)
    self:SetActive(self.ui.ScrollView_Resource, false)
    return
  end
  local collectionType = PvpCollectCfgUtils.GetCollectionType(targetCollectionTid)
  if collectionType and collectionType ~= PVPCollectionType.KeeperSkill then
    self:SetActive(self.ui.Image_Resource, false)
    self:SetActive(self.ui.ScrollView_Resource, false)
    return
  end
  local getsList = BagExtModel.Instance:GetItemGets(itemTid)
  local existedJumper = #getsList > 0
  if not existedJumper then
    self:SetActive(self.ui.Image_Resource, false)
    self:SetActive(self.ui.ScrollView_Resource, false)
    return
  end
  self:SetActive(self.ui.Image_Resource, true)
  self:SetActive(self.ui.ScrollView_Resource, true)
  local MAX_JUMP_BTN_NUM = 5
  for i = 1, MAX_JUMP_BTN_NUM do
    local getsId = getsList[i]
    local go = self.ui["UI_Common_Item_Exchange_" .. i]
    self:SetActive(go, nil ~= getsId)
    if getsId then
      self:_RefreshJumperItem(go, getsId)
    end
  end
  local tmpComp = self:GetTextComp(self.ui.Text_introduce)
  local height = tmpComp.preferredHeight
  if isTaleActive then
    tmpComp = self:GetTextComp(self.ui.Text_Tale)
    height = height + tmpComp.preferredHeight
  end
  local scrollY = 110 - height - 100
  CS.Framework.TransformUtil.SetLocalPos(self.ui.Image_Resource.transform, 650, 150 - height - 100, 0)
  CS.Framework.TransformUtil.SetLocalPos(self.ui.ScrollView_Resource.transform, 630, scrollY, 0)
  local sizeCtx = self.ui.Content_Resource.transform.sizeDelta
  sizeCtx.y = 74 * #getsList
  self.ui.Content_Resource.transform.sizeDelta = sizeCtx
  local ctxSVSize = self.ui.ScrollView_Resource.transform.sizeDelta
  local minScroll = -470
  ctxSVSize.y = math.max(0, scrollY - minScroll)
  self.ui.ScrollView_Resource.transform.sizeDelta = ctxSVSize
end

function UICompPvpCollectionDetailPage:_RefreshJumperItem(uiNode, getsId)
  local uiRes = UI_Common_Item_ExchangeResource(uiNode)
  local itemGetsConfig = DT.ItemGets[getsId]
  local itemTid = self:_GetJumpItemTid()
  local canJumped = FuncJumpManager.Instance:CanJump(getsId, itemTid)
  local justShow = FuncJumpManager.Instance:IsJustShow(getsId)
  self:SetText(uiRes.Text_Name, itemGetsConfig and itemGetsConfig.Desc or "")
  self:SetTextColorType(uiRes.Text_Name, canJumped and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark)
  self:SetActive(uiRes.Group_Select, canJumped)
  self:SetActive(uiRes.Image_Arrow, not justShow)
  self:SetActive(uiRes.Group_Normal, not canJumped)
  self:AddButtonClickListener(uiRes.Btn_Click, function()
    if justShow then
      return
    end
    FuncJumpManager.Instance:JumpFunc(getsId, itemTid)
  end)
end

function UICompPvpCollectionDetailPage:_RefreshCardComp()
  local selectSkillTid = PvpCollectionModel.Instance:GetSelectAwakerSkillTid()
  self:SetActive(self.ui.Image_Show, selectSkillTid)
  self:SetActive(self.ui.Group_Keyword, selectSkillTid)
  if not selectSkillTid then
    return
  end
  local targetCollectionTid = PvpCollectionModel.Instance:GetSelectCollectionTid()
  local awakerTid = PvpCollectCfgUtils.GetCollectAwakerTid(targetCollectionTid)
  local awakerData = awakerTid and AwakerDataUtils.GetAwakerData(awakerTid) or nil
  local cardComp = self.binder:BindComponent(CardBaseComponent(self.ui.Item_Card_Base, nil, selectSkillTid, nil, nil, nil, nil, nil, nil, {awakerData = awakerData}))
  local list = CardDataUtils.GetCardEffectGroupList(selectSkillTid, 0, nil, nil, awakerData)
  if self.descComp then
    self.descComp.binder:teardown()
  end
  self.descComp = self.binder:BindComponent(CommonKeyWordDescGroup(self.ui.Group_Keyword, {
    cardComp:GetCardDesc()
  }, list, nil, {
    awakerData = awakerData,
    skillTid = selectSkillTid,
    skillLevel = 1
  }))
end

function UICompPvpCollectionDetailPage:_RefreshUltiSkillDetail(visible)
  self:SetActive(self.ui.Image_Detailed_Empty, visible)
end

function UICompPvpCollectionDetailPage:OnExitComponent()
  Super.OnExitComponent(self)
end

return UICompPvpCollectionDetailPage

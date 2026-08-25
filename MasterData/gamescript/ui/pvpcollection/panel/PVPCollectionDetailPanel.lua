local CommonDefine = require("World.Enums.CommonDefine")
local PVPCollectionType = CommonDefine.PVPCollectionType
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local PVPCollectionDetailPanel, Super = System.NewClass("PVPCollectionDetailPanel", UIBasePanel)
PVPCollectionDetailPanel.uiResCls = UI_Pvp_Panel_Collection_DetailResource

function PVPCollectionDetailPanel:ctor(data)
  Super.ctor(self)
  self.data = data
end

function PVPCollectionDetailPanel:OnBind(binder)
  self.binder = binder
  self.model = binder:createModel(PVPCollectionDetailPanelModel, self.data)
  binder:BindToVisible(self.ui.Image_Role, System.fn(self, self._ShowAwakerDetailComp))
  binder:BindToVisible(self.ui.Image_Weapons, System.fn(self, self._ShowWeaponOrKeeperSkill))
  self:_BindAwakerDetailComp(binder)
  self:_BindWeaponOrKeeperSkillDetailComp(binder)
end

function PVPCollectionDetailPanel:_ShowAwakerDetailComp()
  local collectTid = self.model.collectionTid
  if not collectTid or 0 == collectTid then
    return
  end
  local collectionType = self.model:GetCollectionType(collectTid)
  return collectionType and collectionType == PVPCollectionType.Awaker
end

function PVPCollectionDetailPanel:_ShowWeaponOrKeeperSkill()
  local collectTid = self.model.collectionTid
  if not collectTid or 0 == collectTid then
    return
  end
  local collectionType = self.model:GetCollectionType(collectTid)
  return collectionType and collectionType ~= PVPCollectionType.Awaker
end

function PVPCollectionDetailPanel:_BindAwakerDetailComp(binder)
  local targetTypeList = {
    PVPCollectionType.Awaker
  }
  binder:BindToText(self.ui.Text_Name_Role, System.bind(self._GetTargetCollectionTypeName, self, targetTypeList))
  binder:BindToImage(self.ui.Image_Hoist_Icon, function()
    do return self.model.GetAwakerAttrIcon end
    return self.model.GetAwakerAttrIcon, self.model
  end)
  binder:BindToText(self.ui.Text_Hoist_Name, function()
    do return self.model.GetAwakerAttrName end
    return self.model.GetAwakerAttrName, self.model
  end)
  binder:BindToText(self.ui.Text_Hoist_CurrValue, function()
    do return self.model.GetAwakerAttrValue end
    return self.model.GetAwakerAttrValue, self.model
  end)
  binder:BindToText(self.ui.Text_Role_Quantity, function()
    do return self.model.GetCollectionWinTimes end
    return self.model.GetCollectionWinTimes, self.model
  end)
  self:_BindUltiSkill(binder)
  self:_BindSkillCards(binder)
  self:_BindSelectSkillCardShow(binder)
end

function PVPCollectionDetailPanel:_BindSkillCards(binder)
  binder:BindToRaw(function(childBinder, nVal)
    if not nVal or 0 == nVal then
      return
    end
    local list = self.model:GetSkillTypeInfoList(nVal)
    if not list then
      return
    end
    for i = 1, self.model.SHOW_SKILL_NUM do
      local data = list[i]
      local obj = self.ui["Btn_Card_" .. i]
      if obj then
        if data then
          local function _OnClick()
            self.model:SetAwakerCollectionSelectedSkill(data.tid)
          end
          
          local function _OnSelect()
            return self.model.selectAwakerSkillTid == data.tid
          end
          
          local itemData = {
            skillTid = data.tid,
            num = data.num,
            clickCallback = _OnClick,
            isSelectFunc = _OnSelect
          }
          childBinder:BindComponent(PVPCollectionDetailSkillItem(obj, itemData))
        end
        childBinder:SetActive(obj, nil ~= data)
      end
    end
  end, function()
    return self.model.collectionTid
  end)
end

function PVPCollectionDetailPanel:_BindUltiSkill(binder)
  binder:BindToText(self.ui.Text_Maniac, function()
    do return self.model.GetAwakerUltiSkillName end
    return self.model.GetAwakerUltiSkillName, self.model
  end)
  binder:BindToVisible(self.ui.Image_Detailed_Empty, System.fn(self, self._IsSelectUltiSkillShow))
  binder:BindToText(self.ui.Text_Skill_Name, function()
    do return end
    return self.model.GetAwakerUltiSkillName, nil
  end)
  binder:BindToText(self.ui.Text_Skill_Desc, function()
    do return end
    return self.model.GetAwakerUltiSkillDesc, nil
  end, nil, nil, {banKeywordBtn = true})
  binder:BindButtonClick(self.ui.Btn_Maniac, System.bind(self._OnClickUltiSkill, self, true))
  binder:BindButtonClick(self.ui.Btn_Mask_UltiSkill, System.bind(self._OnClickUltiSkill, self, false))
  binder:BindToRaw(function(childBinder, nVal)
    if nVal then
      local skillTid = self.model:GetAwakerPVPUltiSkillTid()
      local skillLevel = 1
      local awakerData = {}
      childBinder:SetActive(self.ui.Group_Keyword_Ulti_Skill, true)
      local desc = SkillUtils.GetAwakerSkillDesc(awakerData, skillTid, skillLevel)
      childBinder:BindComponent(CommonKeyWordDescGroup(self.ui.Group_Keyword_Ulti_Skill, {desc}, list, nil))
    end
  end, function()
    return self.model.showUltiSkillDesc
  end)
end

function PVPCollectionDetailPanel:_BindSelectSkillCardShow(binder)
  binder:BindToVisible(self.ui.Image_Show, System.fn(self, self._IsSkillCardShow))
  binder:BindToRaw(function(childBinder, nVal)
    childBinder:SetActive(self.ui.Group_Keyword, nVal and 0 ~= nVal)
    if not nVal or 0 == nVal then
      return
    end
    local cardComp = childBinder:BindComponent(CardBaseComponent(self.ui.Item_Card_Base, nil, nVal))
    local list = CardDataUtils.GetCardEffectGroupList(nVal, 0)
    childBinder:BindComponent(CommonKeyWordDescGroup(self.ui.Group_Keyword, {
      cardComp:GetCardDesc()
    }, list))
  end, function()
    return self.model.selectAwakerSkillTid
  end)
  
  local function _OnNotHoverClick(hover)
    if not hover then
      self.model:SetAwakerCollectionSelectedSkill(0)
    end
  end
  
  binder:BindButtonClick(self.ui.Btn_Image_Show, _OnNotHoverClick)
end

function PVPCollectionDetailPanel:_BindSelectUltiSkillShow(binder)
  binder:BindToVisible(self.ui.Image_Maniac, System.fn(self, self._IsSelectUltiSkillShow))
  binder:BindToText(self.ui.Text_Skill_Desc, System.fn(self.model, self.model.GetAwakerUltiSkillDesc), nil, nil, {banKeywordBtn = true})
end

function PVPCollectionDetailPanel:_BindJumpers()
  self.binder:SetText(self.ui.Text_Source, LT.Text("TipsOriginTitle"))
  self.binder:BindToRaw(function(childBinder, collectTid)
    local config = PVPCollectionDataUtils.GetConfig(collectTid)
    local itemTid = config.Item
    self.ui.ScrollView:GetComponent(T_ScrollRect).verticalNormalizedPosition = 1
    self.binder:SetText(self.ui.Text_introduce, self.model:GetWeaponOrKeeperSkillDesc())
    StrUtils.SetPreferredHeight(self.ui.Text_introduce)
    local isTaleActive = PVPCollectionDataUtils.HasOwnedCollection(collectTid)
    self.ui.Text_Tale:SetActive(isTaleActive)
    self.binder:SetText(self.ui.Text_Tale, self.model:GetWeaponOrKeeperSkillStory())
    StrUtils.SetPreferredHeight(self.ui.Text_Tale)
    if ItemDataUtils.GetItemNum(itemTid) > 0 then
      self.ui.Image_Resource:SetActive(false)
      self.ui.ScrollView_Resource:SetActive(false)
      return
    end
    local collectionType = self.model:GetCollectionType(collectTid)
    if collectionType and collectionType ~= PVPCollectionType.KeeperSkill then
      self.ui.Image_Resource:SetActive(false)
      self.ui.ScrollView_Resource:SetActive(false)
      return
    end
    local getsList = BagExtModel.Instance:GetItemGets(itemTid)
    local existedJumper = #getsList > 0
    if not existedJumper then
      self.ui.Image_Resource:SetActive(false)
      self.ui.ScrollView_Resource:SetActive(false)
      return
    end
    self.ui.Image_Resource:SetActive(true)
    self.ui.ScrollView_Resource:SetActive(true)
    local MAX_JUMP_BTN_NUM = 5
    for i = 1, MAX_JUMP_BTN_NUM do
      local getsId = getsList[i]
      local go = self.ui["UI_Common_Item_Exchange_" .. i]
      go:SetActive(nil ~= getsId)
      if getsId then
        self:_RefreshJumperItem(childBinder, go, getsId)
      end
    end
    local tmpComp = childBinder:GetTextComp(self.ui.Text_introduce)
    local height = tmpComp.preferredHeight
    if isTaleActive then
      tmpComp = childBinder:GetTextComp(self.ui.Text_Tale)
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
  end, function()
    return self.model.collectionTid
  end)
end

function PVPCollectionDetailPanel:_RefreshJumperItem(childBinder, uiNode, getsId)
  local uiRes = UI_Common_Item_ExchangeResource(uiNode)
  local itemGetsConfig = DT.ItemGets[getsId]
  local itemTid = self:_GetJumpItemTid()
  local canJumped = FuncJumpManager.Instance:CanJump(getsId, itemTid)
  local justShow = FuncJumpManager.Instance:IsJustShow(getsId)
  childBinder:SetText(uiRes.Text_Name, itemGetsConfig and itemGetsConfig.Desc or "")
  childBinder:SetTextColorType(uiRes.Text_Name, canJumped and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark)
  uiRes.Group_Select:SetActive(canJumped)
  uiRes.Image_Arrow:SetActive(not justShow)
  uiRes.Group_Normal:SetActive(not canJumped)
  childBinder:BindButtonClick(uiRes.Btn_Click, function()
    if justShow then
      return
    end
    FuncJumpManager.Instance:JumpFunc(getsId, itemTid)
  end)
end

function PVPCollectionDetailPanel:_GetJumpItemTid()
  local config = PVPCollectionDataUtils.GetConfig(self.model.collectionTid)
  local rst = config.Item
  local itemCfg = DT.Item[rst]
  if itemCfg and itemCfg.DropItemGets then
    rst = itemCfg.DropItemGets
  end
  return rst
end

function PVPCollectionDetailPanel:_BindWeaponOrKeeperSkillDetailComp(binder)
  local targetTypeList = {
    PVPCollectionType.Weapon,
    PVPCollectionType.KeeperSkill
  }
  binder:BindToText(self.ui.Text_Name_First, System.bind(self._GetTargetCollectionTypeName, self, targetTypeList))
  binder:BindToText(self.ui.Text_Attribute_CurrValue, function()
    do return self.model.GetCollectionCost end
    return self.model.GetCollectionCost, self.model
  end)
  binder:BindToText(self.ui.Text_Quantity, function()
    do return self.model.GetCollectionWinTimes end
    return self.model.GetCollectionWinTimes, self.model
  end)
  self:_BindJumpers()
end

function PVPCollectionDetailPanel:_GetTargetCollectionTypeName(targetTypeList)
  if not targetTypeList then
    return
  end
  local collectionType = self.model:GetCollectionType(self.model.collectionTid)
  if not collectionType then
    return
  end
  for _, targetType in ipairs(targetTypeList) do
    if targetType == collectionType then
      return PVPCollectionDataUtils.GetCollectionName(self.model.collectionTid)
    end
  end
  return
end

function PVPCollectionDetailPanel:_IsSkillCardShow()
  return 0 ~= self.model.selectAwakerSkillTid
end

function PVPCollectionDetailPanel:_IsSelectUltiSkillShow()
  return self.model.showUltiSkillDesc
end

function PVPCollectionDetailPanel:_OnClickUltiSkill(show)
  self.model:SetUltiSkillDescShow(show)
end

function PVPCollectionDetailPanel:Close()
  Super.Close(self)
end

return PVPCollectionDetailPanel

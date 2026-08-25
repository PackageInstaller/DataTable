local _SetAnchoredPos = CS.Framework.TransformUtil.SetAnchoredPos
local TRINKET_SLOT_COUNT = 6
local Vector2 = CS.UnityEngine.Vector2
local cacheVec2Pos = Vector2(9999, 9999)
local T_UIScreenSpaceMask = typeof(CS.UIScreenSpaceMask)
local ScreenSpaceMaskable = CS.ScreenSpaceMaskable
local T_Image = typeof(CS.UnityEngine.UI.Image)
local RefineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
local skillDescCache = {
  [1] = "Text_Skill_01",
  [2] = "Text_Skill_02",
  [3] = "Text_Skill_03",
  [4] = "Text_Skill_04",
  [5] = "Text_Skill_05"
}
local trinkDescCache = {
  [1] = "Team_Icon_01",
  [2] = "Team_Icon_02",
  [3] = "Team_Icon_03",
  [4] = "Team_Icon_04",
  [5] = "Team_Icon_05",
  [6] = "Team_Icon_06"
}
local MAX_STAR_NUM = 3
local startUICache = {
  [1] = "Star_1",
  [2] = "Star_2",
  [3] = "Star_3"
}
local BattleAssistItem, Super = System.NewComponent("BattleAssistItem")

function BattleAssistItem:ctor(uiMap, battleAssistModel, data, weaponUIs)
  Super.ctor(self)
  self.ui = uiMap
  self.model = battleAssistModel
  self.data = data
  self.posTemp = {}
  self.funclist = {}
  self.weaponUIs = weaponUIs
  self.fansNum = self.data.playerInfo.followerNum or 0
end

function BattleAssistItem:OnBind(binder)
  self.binder = binder
  binder:LoadAllLangFont(self.ui.Text_Name)
  self:InitObjState()
  self:BindAwakerIcon()
  self:BindAvatarImg()
  self:BindAwakerFavor()
  self:BindSchoolIcon()
  self:BindWeapon()
  self:BindTrinket()
  self:BindSelectedVisible()
  self:RefreshPlayerName()
  self:BindAwakerName()
  self:BindAwakerLv()
  self:SetFansNum()
  self:BindRecentAssist()
  self:BindCommonlyAssist()
  self:BindRecommendAssist()
  self:BindPotency()
  self:BindSkillList()
  self:BindTalent()
  self:BindAttention()
  self:BindClickBtn()
  self:_BindShoolBan()
  self:BindEvents(binder)
  self:StartCall()
end

function BattleAssistItem:BindEvents(binder)
  binder:BindEvent(EventMgr.Instance.SocialAttention, System.fn(self, self.UpdateWhenAttention))
  binder:BindEvent(EventMgr.Instance.UpdateSocialEvent, System.fn(self, self.SocialRelationChange))
  binder:BindEvent(EventMgr.Instance.SocialSetStarAssist, System.fn(self, self.SocialStarAssistChange))
end

function BattleAssistItem:UpdateWhenAttention(targetUid, newRelation)
  if targetUid ~= self.data.playerInfo.uid then
    return
  end
  self:_UpdateAssistPlayerInfo(self.data, nil, newRelation)
  self.fansNum = self.data.playerInfo.followerNum or 0
  self:SetFansNum(self.fansNum)
end

function BattleAssistItem:InitObjState()
  for i = 1, TRINKET_SLOT_COUNT do
    local imageObj = self.ui[trinkDescCache[i]]
    if imageObj then
      self:SetActive(imageObj, false)
    end
  end
  self:SetActive(self.ui.Image_Weapon_1, false)
  self:SetActive(self.ui.Image_Weapon_2, false)
  self:SetActive(self.ui.Trinket_Icon, false)
  self:SetActive(self.ui.Image_Conflict, false)
  self:SetActive(self.ui.Text_Lv, false)
  self:SetActive(self.ui.Btn_Attention, false)
  self:SetActive(self.ui.Image_Iocn, false)
end

function BattleAssistItem:Add2TimerCall(func)
  func()
end

function BattleAssistItem:StartCall()
  self.binder:BindTimer(0.05, #self.funclist, function()
    local func = table.remove(self.funclist, 1)
    func()
  end)
end

function BattleAssistItem:RefreshPlayerName()
  self.binder:SetText(self.ui.Text_Name, SocialDataUtils.GetPlayerName(self.data.playerInfo))
end

function BattleAssistItem:BindAwakerName()
  local tid = self.data.awakerData.tid
  self.binder:SetText(self.ui.Text_Figure, AwakerDataUtils.GetAwakerName(tid))
end

function BattleAssistItem:SetFansNum(newFansNum)
  self.binder:SetText(self.ui.Text_FansNum, newFansNum or self.fansNum or "0")
end

function BattleAssistItem:BindRecentAssist()
  self.binder:BindToVisible(self.ui.Image_Recent, function()
    return not self.data.isStarAssist and self.data.isRecentUsed
  end)
end

function BattleAssistItem:BindCommonlyAssist()
  self.binder:BindToVisible(self.ui.Image_Commonly, function()
    return self.data.isStarAssist
  end)
end

function BattleAssistItem:BindRecommendAssist()
  local isRecommend = self.data.playerInfo.relation ~= SocialDefine.SocialRelationType.Cor and self.data.playerInfo.relation ~= SocialDefine.SocialRelationType.Atten
  self.binder:BindToVisible(self.ui.Image_Recommend, function()
    return not self.data.isStarAssist and not self.data.isRecentUsed and isRecommend and self.data.playerInfo.relation ~= SocialDefine.SocialRelationType.Cor and self.data.playerInfo.relation ~= SocialDefine.SocialRelationType.Atten
  end)
end

function BattleAssistItem:BindSchoolIcon()
  local awakerData = self.data.awakerData
  local awakerCfg = DT.AwakerConfig[awakerData.tid]
  local schoolId = awakerCfg.School
  self:SetActive(self.ui.Image_Iocn, true)
  self.binder:SetImage(self.ui.Image_Iocn, AwakerDataUtils.GetSchoolIcon(schoolId))
end

function BattleAssistItem:BindAwakerLv()
  self.binder:SetText(self.ui.Text_LvNum, self.data.awakerData.level)
end

function BattleAssistItem:SocialRelationChange(uid, relation)
  print("soc change", uid, relation)
  if self.data.playerInfo.uid == uid then
    self.model:UpdateAssistPlayerInfo(self.data, nil, relation)
  end
end

function BattleAssistItem:SocialStarAssistChange(assistData, isStarAssist)
  if not assistData then
    return
  end
  local targetUid = not assistData.assistUid and assistData.playerInfo and assistData.playerInfo.uid
  if not targetUid then
    return
  end
  if targetUid == self.data.assistUid or targetUid == self.data.playerInfo.uid then
    self.model:UpdateAssistStarAssist(self.data, isStarAssist)
  end
end

function BattleAssistItem:BindAvatarImg()
  self:SetActive(self.ui.Btn_Attention, true)
  self.binder:BindComponent((CommonHeadItem(self.ui.UI_Common_Head, {
    headIcon = ItemDataUtils.GetAvatarIcon(self.data.playerInfo.icon),
    frameIcon = ItemDataUtils.GetItemIcon(self.data.playerInfo.avatarFrame),
    clickCb = function()
      SocialDataUtils.OpenPlayerInfoPanel(SocialDefine.PlayerInfoPage.Overview, self.data.assistUid)
    end
  })))
end

function BattleAssistItem:BindAttention()
  self:SetActive(self.ui.Text_Lv, true)
  local binder = self.binder
  binder:SetText(self.ui.Text_Lv, LT.Textf("Team_AwakerLevel", self.data.playerInfo.lv))
  
  local function attentionCb(newRelation)
    self:_UpdateAssistPlayerInfo(self.data, nil, newRelation)
  end
  
  local function socialNoteSuccess(name)
    self:_UpdateAssistPlayerInfo(self.data, name)
  end
  
  local function attentionSuccess(newRelation)
    self:_UpdateAssistPlayerInfo(self.data, nil, newRelation)
  end
  
  binder:BindToRaw(function(childBinder, relation)
    local buttonComp = self.ui.Btn_Attention:GetComponent(typeof(CS.Z1Client.Z1Button))
    buttonComp.onClick:RemoveAllListeners()
    if relation == SocialDefine.SocialRelationType.UnAtten then
      childBinder:BindZ1Button(self.ui.Btn_Attention, function()
        SocialDataUtils.ReqOnSocialAttention(self.data.assistUid, function(newRelation)
          attentionSuccess(SocialDefine.SocialRelationType.Atten)
        end)
      end, function()
        if self.data.playerInfo.relation == SocialDefine.SocialRelationType.UnAtten then
          return CommonDefine.BtnType.Normal
        else
          return CommonDefine.BtnType.Unclickable
        end
      end)
    else
      self:_CreateAttentionBtnCom(childBinder, attentionCb, socialNoteSuccess)
    end
  end, function()
    return self.data.playerInfo.relation
  end)
end

function BattleAssistItem:_CreateAttentionBtnCom(childBinder, attentionCb, socialNoteSuccess)
  SocialDataUtils.CreateAttentionBtnCom(childBinder, self.data, self.ui.Btn_Attention, System.fn(self, self.Refresh), attentionCb, socialNoteSuccess)
end

function BattleAssistItem:_UpdateAssistPlayerInfo(targetData, name, newRelation)
  self.model:UpdateAssistPlayerInfo(targetData, name, newRelation)
end

function BattleAssistItem:Refresh()
  self:BindAttention()
  self:RefreshPlayerName()
end

function BattleAssistItem:BindPotency()
  self.binder:BindToRaw(function(childBinder, data)
    if not data then
      return
    end
    local awakerTid = data[1]
    local potencyLevel = data[2]
    childBinder:BindComponent(CommonAwakerPotencyItem(self.ui.UI_Common_Item_Potency, {awakerTid = awakerTid, potencyLevel = potencyLevel}))
  end, function()
    return {
      self.data.awakerData.tid,
      self.data.awakerData.potencyLevel
    }
  end)
end

function BattleAssistItem:BindSkillList()
  local skillList, specialSkill = AwakerDataUtils.GetAwakerSkillsData({
    skills = self.data.awakerData.slots
  })
  if not specialSkill then
    return
  end
  self:SetActive(self.ui.Text_Mad, true)
  self.binder:SetText(self.ui.Text_Mad, specialSkill.level)
  for i = 1, #skillList do
    local skillData = skillList[i]
    local index = skillData.slot
    local ui = self.ui[skillDescCache[index - 1]]
    if ui and skillData then
      self:SetActive(ui, true)
      local str = string.format("/%s", skillData.level or 1)
      self.binder:SetText(ui, str)
    end
  end
end

function BattleAssistItem:BindTalent()
  local awakerData = self.data.awakerData
  if awakerData then
    self.binder:SetText(self.ui.Txt_Talent, TalentDataUtils.GetDisplayTalentLvDesc(awakerData.talents))
  end
end

function BattleAssistItem:BindWeapon()
  self:SetActive(self.ui.Image_Weapon_1, true)
  self:SetActive(self.ui.Image_Weapon_2, true)
  local weaponGroup = {}
  local weaponSlots = AwakerDataUtils.GetWeaponSlotData(self.data.awakerData)
  weaponGroup[1] = weaponSlots and weaponSlots[1] and weaponSlots[1].weaponUid or 0
  weaponGroup[2] = weaponSlots and weaponSlots[2] and weaponSlots[2].weaponUid or 0
  for weaponSlot, weaponUid in ipairs(weaponGroup) do
    local weaponData = ItemDataUtils.GetWeaponByUid(weaponUid)
    local itemData = {
      uid = weaponUid,
      tid = weaponData and weaponData.tid or 0,
      weaponSlot = weaponSlot,
      selectedFunc = function()
        return false
      end,
      isPreview = true
    }
    self:BindBindWeaponEx(self.weaponUIs[weaponSlot], itemData)
  end
end

function BattleAssistItem:SetActive(obj, state)
  if true == state then
    self:ShowObj(obj)
  else
    self:HideObj(obj)
  end
end

function BattleAssistItem:ShowObj(obj)
  local x = self.posTemp[obj] and self.posTemp[obj].x or obj.transform.anchoredPosition.x
  local y = self.posTemp[obj] and self.posTemp[obj].y or obj.transform.anchoredPosition.y
  _SetAnchoredPos(obj.transform, x, y)
end

function BattleAssistItem:HideObj(obj)
  if self.posTemp[obj] == nil then
    self.posTemp[obj] = {
      x = obj.transform.anchoredPosition.x,
      y = obj.transform.anchoredPosition.y
    }
  end
  _SetAnchoredPos(obj.transform, cacheVec2Pos.x, cacheVec2Pos.y)
end

function BattleAssistItem:OnUnbind()
  for obj, pos in pairs(self.posTemp) do
    obj.transform.anchoredPosition = pos
  end
  self:_RecycleTrinketLightComps()
  self.posTemp = nil
end

function BattleAssistItem:_RecycleTrinketLightComps()
  for _, lightComp in ipairs(self._trinketLightComps or {}) do
    lightComp:OnExitComponent()
  end
  self._trinketLightComps = {}
end

function BattleAssistItem:BindTrinket()
  local trinketUids = self.data.awakerData.trinkets
  self.trinketDatas = {}
  local trinketDatas = self.trinketDatas
  local isEmptyTrinkets = true
  for i, uid in pairs(trinketUids) do
    local trinket = self.data.items[uid]
    trinketDatas[i] = trinket
    if trinket then
      isEmptyTrinkets = false
    end
  end
  self:_RecycleTrinketLightComps()
  for i, trinket in pairs(trinketDatas) do
    local pos = ItemDataUtils.GetTrinketPosIndex(trinket)
    if pos then
      local imageObj = self.ui[trinkDescCache[i]]
      if imageObj then
        local tid = trinket and trinket.tid or 0
        self:SetActive(imageObj, tid and tid > 0)
        local lightComp = UICompTrinketIconMat(imageObj, {
          binder = self.binder
        })
        lightComp:EnableLight(AwakerTrinketDataUtils.IsTrinketBoundForLightByBoundTable(trinketUids[i], AwakerTrinketDataUtils.GetSnapshotBoundTrinkets(self.data.awakerData)), i)
        table.insert(self._trinketLightComps, lightComp)
      end
    end
  end
  AwakerTrinketDataUtils.RefreshBoundTrinketTags(self.ui, self.data.awakerData.tid, trinketUids, AwakerTrinketDataUtils.GetSnapshotBoundTrinkets(self.data.awakerData), self.data.items)
  local isSuitGatherAll = AwakerTrinketDataUtils.IsSuitGatherAll(trinketDatas)
  self:SetActive(self.ui.Trinket_Icon, isSuitGatherAll)
  if isSuitGatherAll then
    local suitId = trinketDatas[1].suitId
    self.binder:SetImage(self.ui.Trinket_Icon, AwakerTrinketDataUtils.GetSuitIcon(suitId))
  end
  if isEmptyTrinkets then
    self.ui.Image_Conversion:SetActive(false)
    self.binder:SetText(self.ui.Text_Conversion, "")
  else
    self.ui.Image_Conversion:SetActive(true)
    self.binder:SetText(self.ui.Text_Conversion, AwakerTrinketDataUtils.GetTrinketSuitCompletionRate(trinketDatas) .. "%")
  end
end

function BattleAssistItem:BindAwakerFavor()
  if not self.ui.Image_AwakerFavor then
    return
  end
  local awakerTid = self.data.awakerData.tid
  self.binder:BindToVisible(self.ui.Image_AwakerFavor, function()
    do return FavorabilityVisualUtils.IsPremiumCardFaceUnlocked, awakerTid end
    return FavorabilityVisualUtils.IsPremiumCardFaceUnlocked, awakerTid, self.data.awakerData
  end)
end

function BattleAssistItem:BindAwakerIcon()
  local awakerTid = self.data.awakerData.tid
  local curSkin = self.data.awakerData.curSkin
  local portraitNo = AwakerSkinUtils.GetSkinResNum(curSkin, awakerTid)
  local path = AwakerDataUtils.GetPortraitByNo(portraitNo)
  self.binder:SetImage(self.ui.Image_Awaker, path, true)
  PortraitUtils.HorizontalCenter(self.ui.Root_Awaker.transform, self.ui.Image_Awaker.transform, portraitNo)
  PortraitUtils.VerticalCenter(self.ui.Root_Awaker.transform, self.ui.Image_Awaker.transform, portraitNo)
  self.screenSpaceMask = self.ui.Root_Awaker.gameObject:GetComponent(T_UIScreenSpaceMask)
  if self.screenSpaceMask then
    self.screenSpaceMask:MaskableGameObject()
    self.screenSpaceMaskable = ScreenSpaceMaskable.Get(self.ui.Image_Awaker.gameObject)
    if not IsNil(self.screenSpaceMaskable) then
      self.screenSpaceMaskable.enabled = true
      self.screenSpaceMaskable:LateUpdate()
    end
  end
  self.awakerImgComp = self.ui.Image_Awaker:GetComponent(T_Image)
  if self.awakerImgComp.material.name ~= "Z1_UI_PortraitScreenSpaceMask_Tmp" then
    local mat = self.binder:LoadAsset("UI/UI_Battle/UI_Battle_Marerial/Z1_UI_PortraitScreenSpaceMask.mat")
    local copyMat = GameObject.Instantiate(mat)
    self.awakerImgComp.material = copyMat
    self.awakerImgComp.material.name = "Z1_UI_PortraitScreenSpaceMask_Tmp"
  end
end

function BattleAssistItem:BindClickBtn()
  self.binder:BindZ1Button(self.ui.Btn_Click, function()
    self.model:SelectAssistUid(self.data.assistUid)
  end)
  self.binder:BindButtonClick(self.ui.Btn_Click_Trinket, function()
    UIManager.Instance:Reopen(Urls.TrinketGroupDetailTipsView, self.trinketDatas, AwakerTrinketDataUtils.GetSnapshotBoundTrinkets(self.data.awakerData))
  end)
  self.binder:BindZ1Button(self.ui.UI_Common_Btn_Redact_Team, function()
    self.model:ShowAssistAwakerDetail(self.data.assistUid)
  end)
end

function BattleAssistItem:_BindShoolBan()
  self.binder:BindToRaw(function(childBinder, schoolBan)
    self:SetActive(self.ui.Image_Conflict, schoolBan)
  end, function()
    local awakerId = self.data.awakerData.tid
    local awakerCfg = DT.AwakerConfig[awakerId]
    local schoolId = awakerCfg.School
    local schoolBan = self.model:SchoolBan(schoolId)
    return schoolBan
  end)
end

function BattleAssistItem:BindSelectedVisible()
  self.binder:BindToVisible(self.ui.Group_Sel, function()
    return self.model:GetAssistUID() == self.data.assistUid
  end)
end

function BattleAssistItem:BindBindWeaponEx(weaponUIs, weaponData)
  self:SetActive(weaponUIs.Image_Weapon, weaponData.uid and 0 ~= weaponData.uid)
  local level = ItemDataUtils.GetWeaponRefineLevelByUid(weaponData.uid)
  local itemData = ItemDataUtils.GetItemByUid(weaponData.uid)
  if itemData then
    self.binder:SetImage(weaponUIs.Weapon_Icon_1, DT.Item[itemData.tid].SpIcon)
  end
  local showStars = math.min(level, RefineStage1MaxLevel)
  for i = 1, MAX_STAR_NUM do
    local obj = weaponUIs[startUICache[i]]
    if obj then
      self:SetActive(obj, i <= showStars)
    end
  end
  if level > RefineStage1MaxLevel then
    weaponUIs.Image_Max_1:SetActive(true)
    self.binder:SetText(weaponUIs.Text_Max_1, level - RefineStage1MaxLevel)
  else
    weaponUIs.Image_Max_1:SetActive(false)
  end
  self.binder:BindButtonClick(weaponUIs.Btn_Click, function()
    if weaponData.isPreview then
      if 0 ~= weaponData.uid then
        ItemDataUtils.ShowItemDetailTips(self.binder, weaponUIs.Btn_Click, weaponData.uid, weaponData.tid, true)
      end
      return
    end
  end)
end

return BattleAssistItem

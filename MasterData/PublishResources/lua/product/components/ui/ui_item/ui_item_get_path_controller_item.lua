_class("UIItemGetPathControllerItem", UICustomWidget)
UIItemGetPathControllerItem = UIItemGetPathControllerItem

function UIItemGetPathControllerItem:OnShow(uiParams)
  self._itemModule = GameGlobal.GetModule(ItemModule)
  self._txtGetWay = self:GetUIComponent("UILocalizationText", "txt_getway")
  self._txtGetWay_white = self:GetUIComponent("UILocalizationText", "txt_getway_white")
  self._txtRandom = self:GetUIComponent("UILocalizationText", "txt_random")
  self._txtpar = self:GetUIComponent("RevolvingTextWithDynamicScroll", "txt_getwayobj")
  self._bg1 = self:GetGameObject("bg1")
  self._bg2 = self:GetGameObject("bg2")
  self._index = -1
  self._jumpGo = self:GetGameObject("btn_goto")
  self._jumpImg = self:GetUIComponent("Image", "btn_goto")
  self._gotoText = self:GetUIComponent("UILocalizationText", "gotoText")
  self._gotoNewText = self:GetUIComponent("UILocalizationText", "gotoNewText")
  self._lockGo = self:GetGameObject("btn_lock")
  self._ecBtnTex = self:GetUIComponent("UILocalizationText", "btn_ec")
  self._ecBtnTexRect = self:GetUIComponent("RectTransform", "btn_ec")
  self._ecBtnGo = self:GetGameObject("Button_ec")
  self._ecImg = self:GetUIComponent("Image", "Button_ec")
  self._useBtnGo = self:GetGameObject("Button_use")
  self._btnSweepGo = self:GetGameObject("button_Sweep")
  self._maskRect = self:GetUIComponent("RectTransform", "txt_getwayobj")
  self._maskWidth = {
    [1] = Vector2(768, 64),
    [2] = Vector2(568, 64),
    [3] = Vector2(360, 64)
  }
  self._atlas = self:GetAsset("UIItemMain.spriteatlas", LoadType.SpriteAtlas)
  local sprite1 = self._atlas:GetSprite("items_kuang1_btn")
  local sprite2 = self._atlas:GetSprite("items_kuang2_btn")
  self._getIntro = self:GetGameObject("Button_getIntro")
  self._enough2sprite = {
    [1] = sprite1,
    [2] = sprite2
  }
end

function UIItemGetPathControllerItem:OnHide()
  if self.jumpData then
    self.jumpData:SetForceShowTarget()
  end
end

function UIItemGetPathControllerItem:SetData(itemDataInfo, index, itemid, needNum, needNumRawData)
  self._index = index
  self._itemid = itemid
  self._needNum = needNum
  self._needNumRawData = needNumRawData
  self._itemDataInfo = itemDataInfo
  self._jumpId = itemDataInfo.jumpId
  self._useItemId = itemDataInfo.useItemId
  self._itemDataInfo = itemDataInfo
  self:SetType(itemDataInfo.way, itemDataInfo.enabled, itemDataInfo.randomText)
  self._txtGetWay:SetText(itemDataInfo.desc)
  self._txtRandom:SetText(itemDataInfo.randomText)
  self._txtGetWay_white:SetText(itemDataInfo.desc)
  self._txtpar:OnRefreshRevolving()
end

function UIItemGetPathControllerItem:SetType(type, enable, randomTex)
  local maskWidthType = 1
  self._bg2:SetActive(false)
  self._bg1:SetActive(false)
  self._jumpGo:SetActive(false)
  self._lockGo:SetActive(false)
  self._useBtnGo:SetActive(false)
  self._ecBtnGo:SetActive(false)
  self._getIntro:SetActive(false)
  self._txtGetWay.gameObject:SetActive(false)
  self._txtGetWay_white.gameObject:SetActive(false)
  self._btnSweepGo:SetActive(false)
  self._type = type
  if type == GetWayItemType.Jump then
    self._gotoText.gameObject:SetActive(true)
    self._gotoNewText.gameObject:SetActive(false)
    local module = GameGlobal.GetModule(RoleModule)
    local unLock = module:CheckModuleUnlock(GameModuleID.MD_Aircraft)
    if enable and unLock then
      self._bg1:SetActive(true)
      self._txtGetWay.gameObject:SetActive(true)
      if self._itemDataInfo.smeltRoomInfo then
        if self._itemDataInfo.smeltRoomInfo and not self._itemDataInfo.smeltRoomInfo.conform then
          self._gotoText.gameObject:SetActive(false)
          self._gotoNewText.gameObject:SetActive(true)
          self._gotoNewText:SetText(StringTable.Get("str_item_public_goto_aircraft"))
          local gotonewRectTf = self._gotoNewText.gameObject:GetComponent("RectTransform")
          gotonewRectTf.sizeDelta = Vector2(128, 56)
        end
      else
        self._gotoNewText:SetText("")
        self._gotoText:SetText(StringTable.Get("str_common_getway_goto"))
      end
      local canSweep, missionId = self:CheckSweep()
      self._missionId = missionId
      self._jumpGo:SetActive(not canSweep)
      self._btnSweepGo:SetActive(canSweep)
    else
      self._lockGo:SetActive(true)
      self._bg2:SetActive(true)
      self._txtGetWay_white.gameObject:SetActive(true)
    end
    maskWidthType = 2
  elseif type == GetWayItemType.Text then
    self._bg2:SetActive(true)
    self._txtGetWay_white.gameObject:SetActive(true)
    maskWidthType = 1
  elseif type == GetWayItemType.Use then
    self._useBtnGo:SetActive(true)
    self._bg1:SetActive(true)
    self._txtGetWay.gameObject:SetActive(true)
    maskWidthType = 2
  elseif type == GetWayItemType.EC then
    self._ecBtnGo:SetActive(true)
    self._bg1:SetActive(true)
    self._txtGetWay.gameObject:SetActive(true)
    self._useItemEnough = false
    local item_a_count = self._itemDataInfo.useItemCount
    local item_a_id = self._useItemId
    local nowCount = self._itemModule:GetItemCount(item_a_id)
    if item_a_count <= nowCount then
      self._useItemEnough = true
    end
    local tex = ""
    local sprite, pos, width
    if self._useItemEnough then
      tex = StringTable.Get("str_item_public_use")
      sprite = self._enough2sprite[1]
      pos = -34
      width = 120
    else
      tex = StringTable.Get("str_item_public_get_path_not_enough")
      sprite = self._enough2sprite[2]
      pos = 0
      width = 200
    end
    self._ecBtnTex:SetText(tex)
    maskWidthType = 2
  elseif type == GetWayItemType.GetWayIntroduce then
    self._getIntro:SetActive(true)
    self._bg1:SetActive(true)
    self._txtGetWay.gameObject:SetActive(true)
    maskWidthType = 2
  end
  if not string.isnullorempty(randomTex) then
    maskWidthType = 3
  end
  self._maskRect.sizeDelta = self._maskWidth[maskWidthType]
end

function UIItemGetPathControllerItem:btngotoOnClick(go)
  local aps = GameGlobal.GetModule(SerialAutoFightModule):GetApsData()
  aps:GotoWithItemGetPath(self._jumpId, self._itemid)
  local jumpData = GameGlobal.GetModule(SerialAutoFightModule):GetJumpData()
  jumpData:Track_Jump(self._jumpId)
  local jumpModule = self:GetModule(QuestModule).uiModule
  local param = self._itemDataInfo.smeltRoomInfo
  if param then
    param.NeedNumRawData = self._needNumRawData
  end
  jumpModule:GotoWithItemGetPath(self._jumpId, self._itemid, FromUIType.NormalUI, "UIBackPackController", UIStateType.UIMain, param)
end

function UIItemGetPathControllerItem:Button_SweepOnClick(go)
  local cfg = Cfg.cfg_mission[self._missionId]
  local power = cfg.NeedPower
  local targetItem = self:RootUIOwner():GetTargetItem()
  local title = StringTable.Get("str_battle_auto_fight_option_title_sweep_getPath", self._itemDataInfo.desc)
  self.jumpData = GameGlobal.GetModule(SerialAutoFightModule):GetJumpData()
  self.jumpData:SetForceShowTarget(targetItem[1], targetItem[2])
  local unlock = true
  local params = {
    matchType = MatchType.MT_Mission,
    stageId = self._missionId,
    needPower = power,
    uuid = self.uiid,
    unlock = unlock,
    trackData = self.jumpData,
    campParams = nil,
    toIndex = nil,
    checkFunction = nil,
    onlyShowSweep = true,
    titleWhenOnlyShowSweep = title,
    autoFightCallback = function(count)
      self:_DoFight(count)
    end
  }
  self:ShowDialog("UISerialAutoFightOption", params)
end

function UIItemGetPathControllerItem:_DoFight(autoFightCount)
  if not self:IsPowerEnough() then
    self:ShowDialog("UIGetPhyPointController")
    return
  end
end

function UIItemGetPathControllerItem:IsPowerEnough()
  if self._curStage then
    local roleModule = self:GetModule(RoleModule)
    local leftPower = roleModule:GetAssetCount(RoleAssetID.RoleAssetPhyPoint)
    local enough = leftPower >= self._curStage.need_power
    if not enough and self._module:IsFirstPassMission(self._curStage.id) and self._module:IsMissionFirstPassCanIgnorPower(self._curStage.id) then
      enough = true
    end
    return enough
  end
end

function UIItemGetPathControllerItem:BtnECOnClick(go)
  if self._type == GetWayItemType.EC then
    local item_b_id = self._itemid
    local item_b_count = 1
    local item_a_id = self._useItemId
    local item_a_count = self._itemDataInfo.useItemCount
    self:ShowDialog("UIItemExChangeController", item_a_id, item_a_count, item_b_id, item_b_count, self._useItemEnough)
  end
end

function UIItemGetPathControllerItem:BtnuseOnClick(go)
  if self._type == GetWayItemType.Use then
    local itemid = self._useItemId
    local item_data
    local item_datas = self._itemModule:GetItemByTempId(itemid)
    if item_datas and table.count(item_datas) > 0 then
      for key, value in pairs(item_datas) do
        item_data = value
        break
      end
    end
    local cfgItemGift = Cfg.cfg_item_gift[item_data:GetTemplateID()]
    if cfgItemGift and cfgItemGift.SpecialOpenType ~= nil then
      self:ShowDialog("UIBackPackUseBox", item_data, {
        self._itemid,
        self._needNum
      })
    elseif item_data:GetCount() == 1 then
      self:ShowDialog("UIBackPackBox", item_data, 1)
    else
      self:ShowDialog("UIItemSaleAndUseWithCountController", item_data, EnumItemSaleAndUseState.Use, function(item_data, count)
        self:ShowDialog("UIBackPackBox", item_data, count)
      end)
    end
  end
end

function UIItemGetPathControllerItem:BtnGetIntroOnClick(go)
  GameGlobal.UIStateManager():ShowDialog("UIDrawCardAwardConversionForOtherController")
end

function UIItemGetPathControllerItem:btncloseOnClick(go)
end

function UIItemGetPathControllerItem:btnlockOnClick(go)
  ToastManager.ShowToast(StringTable.Get("str_activity_intro_lock"))
end

function UIItemGetPathControllerItem:GetIndex()
  return self._index
end

function UIItemGetPathControllerItem:CheckSweep()
  local aircraftModule = self:GetModule(AircraftModule)
  local room = aircraftModule:GetResRoom()
  if not room then
    return
  end
  local cfg = Cfg.cfg_jump[self._jumpId]
  if cfg and cfg.JumpID == 1 and cfg.JumpParam then
    local missionId = cfg.JumpParam[1]
    local matchType = MatchType.MT_Mission
    local param = {missionId}
    local out = true
    local enable, msg = self:GetModule(RoleModule):GetAutoFightStatusUI(param, matchType, out)
    local cfg = Cfg.cfg_mission[missionId]
    local isAutoFightUnLock = cfg.EnableSweep == 1 and enable
    if not isAutoFightUnLock then
      return
    end
    self._curStage = DiscoveryStage:New()
    self._curStage:Init(missionId, 1)
    local misssionModule = GameGlobal.GetModule(MissionModule)
    local passStage = misssionModule:GetPassMissionById(missionId)
    local canActiveSatge = misssionModule:GetCanActiveMissionById(missionId)
    if passStage then
      local starCount, completeStarList = misssionModule:ParseStarInfo(passStage.star)
      self._curStage:UpdateStar(starCount)
      self._curStage:UpdateCondition(completeStarList)
      self._curStage:UpdateState(DiscoveryStageState.Nomal)
    end
    if canActiveSatge then
      self._curStage:UpdateStar(0)
      self._curStage:UpdateState(DiscoveryStageState.CanPlay)
    end
    if not self._curStage:HasPassThreeStar() then
      return
    end
    if isAutoFightUnLock then
      return true, missionId
    end
  end
end

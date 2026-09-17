local page = class("pageMOD", G_UIPageBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _goodsTpl = L_GameTpl:getGoodsTpl()
local COST_ITEM_GOODS_ID = 910004
local COST_ITEM_SHOP_ID = 9100
local PageStep = {
  SEX = 1,
  AVATAR = 2,
  NAME = 3
}
local SexToggle = {MALE = true, FEMALE = false}

function page.bind()
  return {
    active_scene = false,
    active_weather = true,
    tab_module = -1,
    module_sex = {
      moduleName = "pages/MOD/moduleModSex"
    },
    toggle_sex = SexToggle.MALE,
    active_toggle_sex = false,
    active_logo = false,
    active_sex_camera = false,
    pos_sex_camera = C_Vector3(0, 0.8800049, -4.85),
    active_avatar_cameras = true,
    pos_avatar_camera = C_Vector3(0, 0, 0),
    active_name_camera = false,
    active_last_button = false,
    module_avatar = {
      moduleName = "pages/mod/moduleModAvatar"
    },
    module_name = {
      moduleName = "pages/mod/moduleModName"
    },
    active_hideAll = false,
    anim_btn = "",
    active_BlurBg = true,
    active_LightForUI = false,
    active_btn_next = true,
    active_btn_reCustomizeCharacter = false,
    module_btn_reCustomizeCharacter = L_Const.ModuleInfo.ModuleBtn,
    active_rect_reCustomizeCostItem = false,
    cellIcon = L_Const.ModuleInfo.CellIconBag,
    img_costItem = nil,
    text_costItemNumInfo = "",
    active_btnConfirm = false,
    txt_btnConfirm = ""
  }
end

function page.methods()
  return {
    onClickNext = function(self)
      self:onClickNext()
    end,
    onClickLast = function(self)
      self:onClickLast()
    end,
    onClickConfirm = function(self)
      self:onClickConfirm()
    end
  }
end

function page:update()
  self.modules.module_avatar:update()
end

function page:onClickNext()
  if self._step == PageStep.NAME then
    self.modules.module_name:finishMod()
  else
    self:setStep(self._step + 1)
  end
end

function page:setStep(step)
  if self._step == step then
    return
  end
  self._step = step
  if self._step == PageStep.AVATAR then
    self:refreshStepView()
    self.bind.pos_sex_camera = C_Vector3(self.bind.toggle_sex == SexToggle.MALE and 0.4 or -0.4, 0.8800049, -4.85)
    self.bind.pos_avatar_camera = C_Vector3(0, 0, 0)
    self.modules.module_name:hideAll()
    self.modules.module_avatar:showAll()
  elseif self._step == PageStep.NAME then
    self.modules.module_avatar:resetModOffset()
    self.modules.module_avatar:hideAll()
    self.modules.module_name:initAll()
    if not self.isNewPlayer then
      self.modules.module_name:startCapture()
    else
      self:refreshStepView()
    end
  end
end

function page:onClickLast()
  if self._step == PageStep.AVATAR then
    L_UI:open("pageMOD", nil, function()
      L_UI:close("pageMOD2")
      C_CameraManager.mainCamera:GetComponent(typeof(C_CinemachineBrain)):ManualUpdate()
    end)
  elseif self._step == PageStep.NAME then
    self:setStep(PageStep.AVATAR)
  end
end

function page:refreshStepView()
  self.bind.tab_module = self._step
  self.bind.anim_btn = "anim_mod_btn_fresh"
  local showLast = self._step ~= PageStep.AVATAR or not self.isNewPlayer
  self.bind.active_last_button = showLast
  self.bind.active_logo = not showLast
  L_TimerManager:newOrResetTimer(self, "camerarefresh", function()
    self.bind.active_avatar_cameras = self._step == PageStep.AVATAR
    self.bind.active_name_camera = self._step == PageStep.NAME
  end, 0.033)
end

function page:preOpen(options)
  self.isNewPlayer = L_PlayerStore:getIsNewPlayer()
  self:registerEvents()
  if options and options.callback then
    options.callback()
  else
  end
  self.bindComponents.SceneNode.transform.parent = nil
  self.bindComponents.SceneNode.worldCamera = C_CameraManager.mainCamera
  self.bindComponents.SceneNode.transform.localScale = C_Vector3.one
  self.bindComponents.SceneNode.transform.position = C_Vector3.zero
  L_ModStore:setIsChanged(false)
  if not self.isNewPlayer then
    self.initSex = options.sex == 1
  end
  self:setStep(PageStep.AVATAR)
  if self.isNewPlayer and not C_LoginManager.GetOpenInterim() then
    L_AudioUtil.playBgm("Play_Music_Dressing")
  else
    L_AudioUtil.playSound("Play_Music_Dressing")
  end
  self:initReCustomizeRelated()
end

function page:registerEvents()
  if not self.isNewPlayer then
  end
end

function page:initReCustomizeRelated()
  self.bind.active_btn_next = self.isNewPlayer
  self.bind.active_btn_reCustomizeCharacter = not self.isNewPlayer
  self.bind.active_rect_reCustomizeCostItem = not self.isNewPlayer
  self.bind.active_btnConfirm = not self.isNewPlayer
  if not self.isNewPlayer then
    if self._step ~= PageStep.AVATAR then
      self:setStep(PageStep.AVATAR)
    end
    self.bind.active_rect_reCustomizeCostItem = false
    self.bind.active_btn_reCustomizeCharacter = false
    self.bind.txt_btnConfirm = L_Lang:get(L_WordsTpl:getValue("avatar_second_btn_text"))
  end
end

function page:initCostItemNumInfo()
  local numOfCostItemInBag = C_BagMgr:getItemNumByItemId(self.costItemId)
  local numStringOfCostItemInBag = L_GameUtil.itemShowNum(numOfCostItemInBag)
  if numOfCostItemInBag < self.costItemNeedNum then
    numStringOfCostItemInBag = L_GameUtil.fillColor(numStringOfCostItemInBag, L_Const.colorHtml.red005)
  end
  local numStringOfCostItemNeed = L_GameUtil.itemShowNum(self.costItemNeedNum)
  self.bind.text_costItemNumInfo = string.format("%s/%s", numStringOfCostItemInBag, numStringOfCostItemNeed)
end

function page:refreshCostItemNumInfo()
  self:initCostItemNumInfo()
end

function page:initCostItemGoodsInfo()
  self.costItemGoodsId = COST_ITEM_GOODS_ID
  self.costItemShopId = COST_ITEM_SHOP_ID
  L_ShopStore:req_listShopItems(self.costItemShopId)
end

function page:onEvent_syncShopInfosComplete()
  local goodsItem = L_ShopStore:getGoodsItemByShopAndgoodsId(self.costItemShopId, self.costItemGoodsId)
  if goodsItem == nil then
    self.costItemBuyTipCellData = nil
    return
  end
  self.costResBarItemTplId = L_GameTpl:getGameConstTpl():getData("AVARAT_RESOURCE_BAR", L_Const.GameTplType.int)
  local tpl = _goodsTpl:getTplById(self.costItemGoodsId)
  local isComplete = L_ConditionManager:isComplete(_goodsTpl:getCommonCondition(tpl))
  local stockNum = L_ShopStore:getStock(self.costItemShopId, goodsItem.slotId)
  self.costItemBuyTipCellData = {
    goodsId = goodsItem.goodsId,
    resBarItemTplIdList = {
      self.costResBarItemTplId
    },
    slotId = goodsItem.slotId,
    curShopId = self.costItemShopId,
    soldOutMask = L_ShopStore:getIsLimitGoods(self.costItemShopId, goodsItem.slotId) and stockNum <= 0,
    lockActive = not isComplete,
    stockNum = stockNum,
    deadTime = goodsItem.deadTime
  }
end

function page:initReCustomizeCharacterBtnDisplayInfo()
  local moduleBtn = self.modules.module_btn_reCustomizeCharacter
  moduleBtn:setData({
    txtName = L_Lang:get(L_WordsTpl:getValue("avatar_second_btn_text")),
    callback = function()
      self:onClickReCustomizeCharacterBtn()
    end,
    itemType = self.reCustomizeCostCurrencyInfo[1],
    itemId = self.reCustomizeCostCurrencyInfo[2],
    itemNum = self.reCustomizeCostCurrencyInfo[3]
  })
end

function page:refreshReCustomizeCharacterBtnDisplayInfo()
  self:initReCustomizeCharacterBtnDisplayInfo()
end

function page:onRefreshBag()
  self:refreshCostItemNumInfo()
end

function page:onClickReCustomizeCharacterBtn()
  local numOfCostItemInBag = C_BagMgr:getItemNumByItemId(self.costItemId)
  if numOfCostItemInBag < self.costItemNeedNum then
    if self.costItemBuyTipCellData then
      local option = CS.Lens.Gameplay.UI.ShopBuyTipOptions.Get()
      option.goodsId = self.costItemBuyTipCellData.goodsId
      option.slotId = self.costItemBuyTipCellData.slotId
      option.curShopId = self.costItemBuyTipCellData.curShopId
      option.soldOutMask = self.costItemBuyTipCellData.soldOutMask
      option.lockActive = self.costItemBuyTipCellData.lockActive
      option.stockNum = self.costItemBuyTipCellData.stockNum
      option.deadTime = self.costItemBuyTipCellData.deadTime
      option.resBarItemTplIdList = self.costItemBuyTipCellData.resBarItemTplIdList
      C_UIMgr.Open("pageSpecialShopBuyTip", option)
    else
      L_FlyMsgManager:showNormalMsg(L_Lang:get(L_WordsTpl:getValue("avatar_store_lock")))
    end
    return
  end
  local numOfResoureBarItemInBag = L_ItemTplManager:getItemNum(self.reCustomizeCostCurrencyInfo[1], self.reCustomizeCostCurrencyInfo[2])
  if numOfResoureBarItemInBag < self.reCustomizeCostCurrencyInfo[3] then
    L_FlyMsgManager:showNormalMsg(L_Lang:get(L_WordsTpl:getValue("avatar_no_money")))
    return
  end
  L_GameUtil.showCommonTip({
    txtTitle = L_Lang:get(L_WordsTpl:getValue("avatar_double_check")),
    txtContent = L_Lang:get(L_WordsTpl:getValue("avatar_double_check_item")),
    confirmCallback = function()
      self:onClickNext()
    end,
    itemList = {
      {
        itemType = self.costItemType,
        itemId = self.costItemId,
        itemNum = self.costItemNeedNum
      }
    }
  })
end

function page:onClickConfirm()
  L_GameUtil.showCommonTip({
    txtTitle = L_Lang:get(L_WordsTpl:getValue("avatar_double_check")),
    txtContent = L_Lang:get(L_WordsTpl:getValue("avatar_double_check_item")),
    confirmCallback = function()
      self:onClickNext()
    end
  })
end

function page:show()
  self.bindComponents.SceneNode.gameObject:ActiveTrans(true)
  self.bind.active_BlurBg = false
  L_LoadingManager:closeLoading()
end

function page:hide()
  self.bindComponents.SceneNode.gameObject:ActiveTrans(false)
end

function page:close()
  if not self.isNewPlayer or C_LoginManager:GetOpenInterim() then
    L_AudioUtil.playSound("Stop_Music_Dressing")
  end
  C_GameObject.Destroy(self.bindComponents.SceneNode.gameObject)
  L_ModStore.modData = {}
end

function page:unRegisterEvents()
end

function page:escHandle()
  L_UI:open("pageMOD", nil, function()
    L_UI:close("pageMOD2")
    C_CameraManager.mainCamera:GetComponent(typeof(C_CinemachineBrain)):ManualUpdate()
  end)
end

function page:closeMask()
  local data = {
    coverdTime = 0.1,
    fadeOut = true,
    fadeIn = false,
    isCompleteClose = true
  }
  L_GameUtil.openMask(data)
end

function page:check(options, callback)
  local canMod = L_GameUtil.checkCanMod()
  callback(canMod)
end

return page

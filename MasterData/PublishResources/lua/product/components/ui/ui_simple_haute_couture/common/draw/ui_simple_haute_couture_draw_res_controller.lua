_class("UISimpleHauteCoutureDrawResController", UIController)
UISimpleHauteCoutureDrawResController = UISimpleHauteCoutureDrawResController

function UISimpleHauteCoutureDrawResController:OnShow(uiParams)
  local drawType = uiParams[1]
  local data = uiParams[2]
  self._campaign = uiParams[3]
  self.isHomeGameServer = uiParams[4]
  self._hasSkin = uiParams[5]
  self._randomLotteryComponent = self._campaign:GetComponent(ECampaignPetSkinComponentID.RANDOMLOTTERY)
  self._cfgMap = self._randomLotteryComponent:GetFirstCfg()
  self._cfgMain = self._randomLotteryComponent:GetCfgMain()
  self:_GetComponents()
  self:CheckHasSkinReward(data, drawType)
end

function UISimpleHauteCoutureDrawResController:_GetComponents()
  self.atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self._simpleIcon = self:GetUIComponent("RawImageLoader", "simpleIcon")
  self._simpleName = self:GetUIComponent("UILocalizationText", "simpleName")
  self._simpleNum = self:GetUIComponent("UILocalizationText", "simpleNum")
  self._drawMultipleNum = self:GetUIComponent("UILocalizationText", "drawMultipleNum")
  self._drawSimpleNum = self:GetUIComponent("UILocalizationText", "drawSimpleNum")
  self._content = self:GetUIComponent("UISelectObjectPath", "content")
  self._topContent = self:GetUIComponent("UISelectObjectPath", "topContent")
  self._topTips = self:GetUIComponent("UISelectObjectPath", "toptips")
  self._topTipsInfo = self._topTips:SpawnObject("UITopTipsContext")
  self._drawIcon1 = self:GetUIComponent("Image", "drawIcon1")
  self._drawIcon2 = self:GetUIComponent("Image", "drawIcon2")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._simpleObj = self:GetGameObject("Simple")
  self._multipleObj = self:GetGameObject("Multiple")
  self._simpleBtnObj = self:GetGameObject("SimpleBtn")
  self._multipleBtnObj = self:GetGameObject("MultipleBtn")
  self._simpleDrawEff = {}
  self._simpleDrawEff[1] = self:GetGameObject("UiEff_choujiang_fei_01")
  self._simpleDrawEff[2] = self:GetGameObject("UiEff_choujiang_fei_02")
  self._simpleDrawEff[3] = self:GetGameObject("UiEff_choujiang_fei_03")
  self._simpleDrawEff[4] = self:GetGameObject("UiEff_choujiang_fei_04")
  self._simpleDrawEff[5] = self:GetGameObject("UiEff_choujiang_fei_05")
  self._simpleDrawEff[6] = self:GetGameObject("UiEff_choujiang_fei_06")
end

function UISimpleHauteCoutureDrawResController:_Init(type, data)
  for i = 1, 6 do
    self._simpleDrawEff[i]:SetActive(false)
  end
  if type == SimpleHauteCoutureDrawType.Single then
    self._simpleObj:SetActive(false)
    self._simpleObj:SetActive(true)
    self._multipleObj:SetActive(false)
    self._simpleBtnObj:SetActive(true)
    self._multipleBtnObj:SetActive(false)
    local roleAsset = data.m_rewards[1]
    local item = Cfg.cfg_item[roleAsset.assetid]
    self._simpleIcon:LoadImage(item.Icon)
    self._simpleName:SetText(StringTable.Get(item.Name))
    self._simpleNum:SetText(roleAsset.count)
    local probabilityCfg = Cfg.cfg_junior_skin_draw_probablity({
      ItemID = roleAsset.assetid,
      Count = roleAsset.count
    })[1]
    self._simpleDrawEff[probabilityCfg.Color]:SetActive(true)
  elseif type == SimpleHauteCoutureDrawType.Multiple then
    self._simpleObj:SetActive(false)
    self._multipleObj:SetActive(true)
    self._simpleBtnObj:SetActive(false)
    self._multipleBtnObj:SetActive(true)
    local items = self._content:SpawnObjects("UISimpleHauteCoutureDrawResItem", 10)
    for i, item in pairs(items) do
      item:SetData(data.m_rewards[i], i, self._cfgMain.DrawPic)
    end
  end
  local topMenu = self._topContent:SpawnObject("UISimpleHauteCoutureTopMenu")
  topMenu:SetData(self._topTipsInfo, self._cfgMap.CostItemID, RoleAssetID.RoleAssetDiamond, self._cfgMain.ScoreID, function()
    self:CloseDialog()
    self:ShowDialog("UISimpleHauteCouturePurchaseController", self._campaign, self.isHomeGameServer)
  end)
  local iconCfg = Cfg.cfg_top_tips[self._cfgMap.CostItemID]
  if iconCfg then
    self._drawIcon1.sprite = self.atlas:GetSprite(iconCfg.Icon)
    self._drawIcon2.sprite = self.atlas:GetSprite(iconCfg.Icon)
  end
  local itemModule = self:GetModule(ItemModule)
  local itemNum = itemModule:GetItemCount(self._cfgMap.CostItemID)
  if 10 <= itemNum then
    self._drawSimpleNum.color = Color(1, 1, 1)
    self._drawMultipleNum.color = Color(1, 1, 1)
  elseif 1 <= itemNum then
    self._drawSimpleNum.color = Color(1, 1, 1)
    self._drawMultipleNum.color = Color(0.8980392156862745, 0.21176470588235294, 0)
  else
    self._drawSimpleNum.color = Color(0.8980392156862745, 0.21176470588235294, 0)
    self._drawMultipleNum.color = Color(0.8980392156862745, 0.21176470588235294, 0)
  end
end

function UISimpleHauteCoutureDrawResController:CheckHasSkinReward(data, type)
  local skinTb = {}
  local num = type == SimpleHauteCoutureDrawType.Single and 1 or 10
  local awards = self.isHomeGameServer and self:GetLastExtraAwardList(num) or {}
  for i = 1, num do
    local reward = data.m_rewards[i]
    if reward.assetid < 4999999 and reward.assetid > 4000000 then
      local skinID = reward.assetid - RoleAssetID.RoleAssetPetSkinBegin
      local skinNum = skinTb[skinID] and skinTb[skinID] + 1 or 1
      skinTb[skinID] = skinNum
    end
    table.insert(awards, reward)
  end
  self:StartTask(function(TT)
    if table.count(skinTb) > 0 then
      for skinID, skinNum in pairs(skinTb) do
        if self._hasSkin then
          self:_Init(type, data)
          self:Lock("UISimpleHauteCoutureDrawResController:CheckHasSkinReward")
          self._anim:Play("uieffanim_UISimpleHauteCoutureDrawResController_in")
          YIELD(TT, 1334)
          self:UnLock("UISimpleHauteCoutureDrawResController:CheckHasSkinReward")
          self:ShowDialog("UIGetItemController", awards, function()
            self:AlreadyGetSkin(skinID, skinTb[skinID])
          end, true)
        else
          skinTb[skinID] = skinTb[skinID] - 1
          local skin = RoleAsset:New()
          skin.assetid = skinID
          local unlockCgId
          local skinCfg = Cfg.cfg_pet_skin[skin.assetid]
          if skinCfg then
            unlockCgId = skinCfg.ImmediateCgId
          end
          self:ShowDialog("UIPetSkinObtainController", skin, function()
            GameGlobal.UIStateManager():CloseDialog("UIPetSkinObtainController")
            self:_Init(type, data)
            self:Lock("UISimpleHauteCoutureDrawResController:CheckHasSkinReward")
            self._anim:Play("uieffanim_UISimpleHauteCoutureDrawResController_in")
            YIELD(TT, 1334)
            self:UnLock("UISimpleHauteCoutureDrawResController:CheckHasSkinReward")
            self:ShowDialog("UIGetItemController", awards, function()
              if unlockCgId then
                local cfg_cg = Cfg.cfg_cg_book[unlockCgId]
                if cfg_cg then
                  self:ShowDialog("UIPetSkinsGetCgController", cfg_cg.StaticPic, false, skinCfg.CgId, 1)
                end
                ToastManager.ShowToast(StringTable.Get("str_senior_skin_draw_new_cg_tips"))
                if 0 < skinTb[skinID] then
                  self:AlreadyGetSkin(skinID, skinTb[skinID])
                end
              end
              self:CheckSkinHasGot()
            end, true)
          end)
        end
      end
    else
      self:_Init(type, data)
      self._anim:Play("uieffanim_UISimpleHauteCoutureDrawResController_in")
      self:Lock("UISimpleHauteCoutureDrawResController:CheckHasSkinReward")
      YIELD(TT, 1334)
      self:UnLock("UISimpleHauteCoutureDrawResController:CheckHasSkinReward")
      self:ShowDialog("UIGetItemController", awards, nil, true)
    end
  end)
end

function UISimpleHauteCoutureDrawResController:AlreadyGetSkin(skinID, skinNum)
  local skinCfg = Cfg.cfg_pet_skin[skinID]
  local skinName = StringTable.Get(skinCfg.SkinName)
  if not skinCfg.SkinAward then
    Log.exception("请添加皮肤重复获得奖励！！！cfg_pet_skin")
    return
  end
  local convertID = skinCfg.SkinAward[1][1]
  local convertCount = skinCfg.SkinAward[1][2] * skinNum
  local convertAsset = NewRoleAsset(convertID, convertCount)
  self:ShowDialog("UIMsgBoxWithAssets", StringTable.Get("str_common_gift_get_item"), StringTable.Get("str_pay_duplicate_skin_name_msg", skinName), {convertAsset}, function()
    self:CheckSkinHasGot()
  end)
  return
end

function UISimpleHauteCoutureDrawResController:GetLastExtraAwardList(num)
  if not self._campaign then
    return
  end
  local componentID = self._randomLotteryComponent:GetComponentCfgId()
  local cfg = Cfg.cfg_component_random_lottery({ComponentID = componentID})[1]
  if not cfg or not cfg.FixedRewards then
    return {}
  end
  local result = {}
  local awardList = cfg.FixedRewards
  for _, v in pairs(awardList) do
    local asset = RoleAsset:New()
    asset.assetid = v[1]
    asset.count = v[2] * num
    asset.heartstone = true
    table.insert(result, asset)
  end
  return result
end

function UISimpleHauteCoutureDrawResController:CheckSkinHasGot()
  local petModule = self:GetModule(PetModule)
  local hasSkin = petModule:HaveSkin(self._cfgMain.SkinID)
  self._hasSkin = hasSkin
  return hasSkin
end

function UISimpleHauteCoutureDrawResController:BackBtnOnClick()
  self:StartTask(function(TT)
    self:Lock("uieffanim_UISimpleHauteCoutureDrawResController_out")
    self._anim:Play("uieffanim_UISimpleHauteCoutureDrawResController_out")
    YIELD(TT, 400)
    self:UnLock("uieffanim_UISimpleHauteCoutureDrawResController_out")
    self:CloseDialog()
  end)
end

function UISimpleHauteCoutureDrawResController:SimpleBtnOnClick()
  self:CheckSkinHasGot()
  self:_DrawCard(SimpleHauteCoutureDrawType.Single)
end

function UISimpleHauteCoutureDrawResController:MultipleBtnOnClick()
  self:CheckSkinHasGot()
  self:_DrawCard(SimpleHauteCoutureDrawType.Multiple)
end

function UISimpleHauteCoutureDrawResController:_DrawCard(type)
  local itemModule = self:GetModule(ItemModule)
  local itemCfg = Cfg.cfg_item[self._cfgMap.CostItemID]
  local itemNum = itemModule:GetItemCount(self._cfgMap.CostItemID)
  local costNum = self._cfgMap.OneCostCount
  local title = ""
  local costName = StringTable.Get(itemCfg.Name)
  local str = self.isHomeGameServer and "str_junior_skin_draw_common_main_draw_tip1" or "str_junior_skin_draw_common_main_draw_tip2"
  if type == SimpleHauteCoutureDrawType.Multiple then
    costNum = costNum * 10
  end
  title = self.isHomeGameServer and StringTable.Get(str, costNum, costName, costNum, costNum) or StringTable.Get(str, costNum, costName, costNum)
  if itemNum >= costNum then
    self:ShowDialog("UISimpleHauteCoutureConfirm", self._cfgMap.CostItemID, title, costNum, function()
      self:StartTask(function(TT)
        local res = AsyncRequestRes:New()
        local isSingle = type == SimpleHauteCoutureDrawType.Single
        local data = self._randomLotteryComponent:HandleReceiveRandomLotteryCost(TT, res, self._cfgMap.ID, isSingle)
        if res:GetSucc() then
          self:CheckHasSkinReward(data, type)
        else
          Log.fatal("抽卡失败：", res:GetResult())
        end
      end)
    end)
  else
    self:CloseDialog()
    self:ShowDialog("UISimpleHauteCouturePurchaseController", self._campaign, self.isHomeGameServer)
  end
end

local SimpleHauteCoutureDrawType = {Single = 1, Multiple = 2}
_enum("SimpleHauteCoutureDrawType", SimpleHauteCoutureDrawType)

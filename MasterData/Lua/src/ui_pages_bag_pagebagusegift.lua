local this = class("pageBagUseGift", G_UIPageBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local soulEssenceCardEffect = require("ui.manager.bag.soulEssenceCardEffect")

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    img_icon = nil,
    img_qualityCircle = nil,
    txt_num = nil,
    txt_title = nil,
    go_limit = false,
    img_limit = "",
    txt_limit = "",
    moduleGiftContent = {
      moduleName = "pages/bag/moduleGiftContent"
    },
    module_selectNum = L_Const.ModuleInfo.SelectNum
  }
end

function this.methods()
  return {
    onClick_bg = function(self)
      self:escHandle()
    end,
    onClick_close = function(self)
      self:escHandle()
    end,
    onClick_use = function(self)
      if (self._itemId == 1810001 or self._itemId == 1810002 or self._itemId == 1810003) and C_SoulEssenceMgr:getSoulEssenceListCount() >= L_GameConstTpl:getData("BAG_LIMIT_SOULESSENCE", L_Const.GameTplType.int) then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_soulessence_bag_full"))
        return
      end
      local tpl = _commonItemTpl:getTplById(self._itemId)
      local type = _commonItemTpl:getType(tpl)
      local dontShowReward = type == 356
      C_BagMgr:ReqUseItem(self._itemId, self._selectNum, {
        self._selectGiftType,
        self._selectGiftId
      }, function(rspData)
        local rewards = require("ui.manager.reward.rewardData").new()
        rewards.rewardShowType = L_Const.rewardShowType.full
        local data = C_DataUtil.ParseRewardConfig(rspData.rewards, true, nil, true)
        rewards:constructList(data)
        self.bPlayCloseAnim = false
        if self._itemId == 1810001 or self._itemId == 1810002 or self._itemId == 1810003 then
          soulEssenceCardEffect.show(rewards, function()
            self.bPlayCloseAnim = false
            self:escHandle()
          end)
        else
          self:escHandle()
          rewards.replaceIfSame = true
          L_RewardManager:ShowReward(rewards)
        end
      end, dontShowReward)
    end
  }
end

function this:created(...)
  this.super.created(self, ...)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self._itemId = options.itemId
  self._targetItemId = options.targetItemId
  self._selectNum = 1
  self._targetItemNum = options.itemNum or 0
  self.bPlayCloseAnim = true
  self:initPage()
end

function this:close()
  this.super.close(self)
  self:clearLimitRefreshTimer()
end

function this:clearLimitRefreshTimer()
  if self.refreshTimer then
    self.refreshTimer:stop()
    self.refreshTimer = nil
  end
end

function this:onTopBarRefresh()
  C_IntegrateMgr.TopBarModule:setTopBarCloseFunc(function()
    self:escHandle()
  end)
  C_IntegrateMgr.TopBarModule:setTopBarMainBtnFunc(function()
    self:escHandle()
  end)
end

function this:escHandle()
  if self.bPlayCloseAnim == false then
    L_UI:close(self.pageName)
  else
    self.bindComponents.animation:Play("anim_tip_bg_close")
    self:newOrResetTimer("closeTimer", function()
      L_UI:close(self.pageName)
    end, 0.2)
  end
end

function this:initPage()
  local tpl = _commonItemTpl:getTplById(self._itemId)
  self.bind.img_icon = _commonItemTpl:getIcon(tpl)
  self.bind.img_qualityCircle = string.format("UI/Atlas/Bag/tex_bag_rarity_tips_w_%s.png", _commonItemTpl:getRarity(tpl))
  local maxCanUseNum = C_BagMgr:GetMaxCanUseNum(self._itemId)
  self.bind.txt_num = tostring(C_BagMgr:getItemNumByItemId(self._itemId))
  local bagUseType = _commonItemTpl:getUseType(tpl)
  if bagUseType == L_BagConst.bagUseType.selectGift or bagUseType == L_BagConst.bagUseType.customizedGiftPack then
    self.bind.txt_title = L_WordsTpl:getValue("notice_bag_useChooseBox")
  elseif bagUseType == L_BagConst.bagUseType.randomGift or bagUseType == L_BagConst.bagUseType.randomGiftPack then
    self.bind.txt_title = L_WordsTpl:getValue("notice_bag_useRandomBox")
  elseif bagUseType == L_BagConst.bagUseType.fixGift or bagUseType == L_BagConst.bagUseType.fixedGiftPack then
    self.bind.txt_title = L_WordsTpl:getValue("notice_bag_useCommonBox")
  end
  self._selectGiftType = nil
  self._selectGiftId = nil
  local rewards = L_DataUtil.parseRewardConfig(_commonItemTpl:getGiftBagReward(tpl))
  local tmp = {}
  for i, v in ipairs(rewards) do
    local callback
    if bagUseType == L_BagConst.bagUseType.selectGift or bagUseType == L_BagConst.bagUseType.customizedGiftPack then
      if v.itemId == self._targetItemId then
        self._selectGiftType = v.itemType
        self._selectGiftId = v.itemId
        if self._targetItemNum > 0 and 0 < maxCanUseNum then
          local needCount = math.ceil(self._targetItemNum / v.itemNum)
          self._selectNum = maxCanUseNum >= needCount and needCount or maxCanUseNum
        end
      end
      
      function callback()
        self._selectGiftType = v.itemType
        self._selectGiftId = v.itemId
        self:setGiftListActive()
      end
    elseif bagUseType == L_BagConst.bagUseType.fixGift and v.itemId == self._targetItemId and self._targetItemNum > 0 and 0 < maxCanUseNum then
      local needCount = math.ceil(self._targetItemNum / v.itemNum)
      self._selectNum = maxCanUseNum >= needCount and needCount or maxCanUseNum
    end
    table.insert(tmp, {
      itemType = v.itemType,
      itemId = v.itemId,
      itemNum = v.itemNum,
      callback = callback
    })
  end
  self.modules.moduleGiftContent:setUseGiftData(tmp)
  if self._selectGiftId ~= nil then
    self:setGiftListActive()
  elseif bagUseType == L_BagConst.bagUseType.selectGift or bagUseType == L_BagConst.bagUseType.customizedGiftPack then
    self._selectGiftType = tmp[1].itemType
    self._selectGiftId = tmp[1].itemId
    self:setGiftListActive()
  end
  self:clearLimitRefreshTimer()
  if C_BagMgr:isLimitItem(self._itemId) then
    self.bind.go_limit = true
    self.bind.img_limit = "Assets/Arts/UI/Page/Common/icon/tex_common_icon_countdown_03.png"
    local bOwn = C_BagMgr:getItemNumByItemId(self._itemId) > 0
    if bOwn then
      local bagItem = C_BagMgr:getItem(self._itemId)
      local deadTime = bagItem and bagItem.deadTime or 0
      if 0 < deadTime then
        local function refreshLimitTxt()
          if deadTime <= L_TimeUtil.getServerTime() then
            self.bind.txt_limit = L_WordsTpl:getValue("item_expired")
            
            self:clearLimitRefreshTimer()
          else
            self.bind.txt_limit = L_TimeUtil.getLeftTimeString2(deadTime)
          end
        end
        
        refreshLimitTxt()
        if deadTime > L_TimeUtil.getServerTime() then
          self.refreshTimer = Timer.repeated(1, refreshLimitTxt)
        end
      else
        self.bind.txt_limit = ""
      end
    else
      self.bind.txt_limit = L_WordsTpl:getValue("limit_time_use")
    end
  else
    self.bind.go_limit = false
  end
  self:initModuleNum()
end

function this:initModuleNum()
  local max = C_BagMgr:GetMaxCanUseNum(self._itemId)
  
  local function func(num)
    self._selectNum = num
  end
  
  self.modules.module_selectNum:initModule(func, max, 1, self._selectNum)
  func(self._selectNum)
end

function this:setGiftListActive()
  for i, v in pairs(self.modules.moduleGiftContent:getCellList()) do
    v:setSel(self._selectGiftId == v.bind.itemId and self._selectGiftType == v.bind.itemType)
  end
end

return this

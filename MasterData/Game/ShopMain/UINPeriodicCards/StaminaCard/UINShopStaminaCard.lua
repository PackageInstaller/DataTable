local base = require("Game.ShopMain.UINMonthCard")
local UINShopStaminaCard = class("UINPeriodicMonthCard", base)
local UINStaminaCardInfoItem = require("Game.ShopMain.UINPeriodicCards.StaminaCard.UINStaminaCardInfoItem")
local CommonLogicUtil = require("Game.Common.CommonLogicUtil.CommonLogicUtil")

function UINShopStaminaCard:OnInit()
  base.OnInit(self)
  UIUtil.AddButtonListener(self.ui.btn_Tip, self, self._OnClickTips)
  self._infoItemPool = UIItemPool.New(UINStaminaCardInfoItem, self.ui.obj_Info, false)
end

function UINShopStaminaCard:InitMonthCard()
  base.InitMonthCard(self)
  local hasDungeonRewardRateNumAdd = false
  self._infoItemPool:HideAll()
  local cardData = PlayerDataCenter.dailySignInData:GetMonthCardData(self.monthCardId)
  local privilegeIdList = cardData:GetMonthCardPrivilegeIdList()
  for k, id in ipairs(privilegeIdList) do
    local cfg = ConfigData.month_card_privilege[id]
    for k, logic in ipairs(cfg.logic) do
      if logic == eLogicType.DungeonRewardRateNumAdd then
        if hasDungeonRewardRateNumAdd then
          goto lbl_53
        end
        hasDungeonRewardRateNumAdd = true
      end
      local para1 = cfg.para1[k]
      local para2 = cfg.para2[k]
      local para3 = cfg.para3[k]
      local infoStr = CommonLogicUtil.GetDesString(logic, para1, para2, para3, eLogicDesType.StaminaCard)
      local infoItem = self._infoItemPool:GetOne()
      infoItem:InitStaminaCardInfoItem(infoStr)
      ::lbl_53::
    end
  end
end

function UINShopStaminaCard:_OnClickTips()
  UIManager:CreateWindowAsync(UIWindowTypeID.CommonRuleInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonRule(self.monthCardCfg.rule_id)
  end)
end

function UINShopStaminaCard:OnDelete()
  self._infoItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINShopStaminaCard

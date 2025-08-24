local Base = require("ui.uiobject")
local GoodsItemClass = require("uimodule.battle_bag.battle_item")
local BagCfg = require("gamelogic.character.fight_bag_configs")
local Item_Helper = require("utils.item_helper")
local M = Util.create_child_mt(Base)

function M:ui_finish_load()
  self.v_attack_equip = GoodsItemClass:ui_wrap(self, self.v_uiobjects.AttackEquip, false)
  self.v_defend_equip = GoodsItemClass:ui_wrap(self, self.v_uiobjects.DefendEquip, false)
  self:set_button("AddAttack", function()
    Util.show_message_tip(2107)
  end)
  self:set_button("AddDefend", function()
    Util.show_message_tip(2107)
  end)
end

function M:ui_on_show(data, ...)
  self:_refresh_bag()
  self:_regist_client_event()
end

function M:ui_on_hide()
end

function M:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_FIGHT_BAG_UPDATE, self.response_bag_update_event, self)
end

function M:response_bag_update_event(msg)
  self:_refresh_bag()
end

function M:_refresh_bag()
  self.v_uiobjects.AddAttack:SetActive(true)
  self.v_uiobjects.AddDefend:SetActive(true)
  self.v_attack_equip:set_enable(false)
  self.v_defend_equip:set_enable(false)
  local list = FightBagMgr:get_bag(BagCfg.BagType.COLLECT)
  for _, v in pairs(list) do
    if v.Cfg.Type == BagCfg.CollectType.EQUIP then
      if v.Cfg.Arg[1] == BagCfg.EQUIP_TYPE.ATTACK then
        self.v_attack_equip:set_enable(true, v.id, {item_data = v})
        self.v_uiobjects.AddAttack:SetActive(false)
      elseif v.Cfg.Arg[1] == BagCfg.EQUIP_TYPE.DEFEND then
        self.v_defend_equip:set_enable(true, v.id, {item_data = v})
        self.v_uiobjects.AddDefend:SetActive(false)
      end
    end
  end
end

return M

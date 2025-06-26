-- -----------------------------------------------
-- ***** 协议文件，自动生成，请勿编辑！*****
-- @Id:    17     
-- @Name:  bag   
-- @Desc:  道具协议   
-- -----------------------------------------------
module(..., package.seeall);

 
--- *s2c* 道具初始化列表 17000
SC_BAG_INIT =
{
    17000, 
    {"type", "int8", "背包类型"}, 
    {"capacity", "int16", "背包容量"}, 
    {"is_last_data", "int8", "是否最后一条数据 0否1是"}, 
    {"list", pt_prop_bag, "道具列表", "repeated"},
}
 
--- *s2c* 道具更新 17001
SC_BAG_UPDATE =
{
    17001, 
    {"type", "int8", "背包类型(1:背包)"}, 
    {"updateList", pt_prop_bag, "更新,添加列表", "repeated"}, 
    {"delList", "int32", "删除列表", "repeated"},
}
 
--- *c2s* 使用物品byId 17002
CS_USE_BY_ID =
{
    17002, 
    {"id", "int32", "物品id"}, 
    {"target", "int32", "作用对象：0-玩家，其余：战员id"}, 
    {"count", "int16", "物品数量"}, 
    {"use_args", "int32", "使用的参数", "repeated"},
}
 
--- *c2s* 使用物品byTid 17003
CS_USE_BY_TID =
{
    17003, 
    {"tid", "int32", "道具模版id"}, 
    {"target", "int32", "作用对象：0-玩家，其余：战员id"}, 
    {"count", "int16", "物品数量"}, 
    {"use_args", "int32", "使用的参数", "repeated"},
}
 
--- *c2s* 装备详细信息 17004
CS_EQUIP_DETAIL =
{
    17004, 
    {"hero_id", "int32", "战员id：0-背包中，其余：战员id"}, 
    {"equip_id", "int32", "装备唯一id"},
}
 
--- *s2c* 装备详细信息 17005
SC_EQUIP_DETAIL =
{
    17005, 
    {"hero_id", "int32", "战员id：0-背包中，其余：战员id"}, 
    {"equip_id", "int32", "装备唯一id"}, 
    {"nuclear_attr", pt_attr, "核能技能属性", "repeated"}, 
    {"remake_attr", pt_remake_attr, "改造属性", "repeated"}, 
    {"bracelet_remake_attr", pt_bracelet_remake_attr, "烙痕改造属性", "repeated"}, 
    {"total_attr", pt_attr, "总属性", "repeated"}, 
    {"strength_pre_attr", pt_attr, "下一强化预览属性列表", "repeated"}, 
    {"break_pre_attr", pt_attr, "下一突破预览属性列表", "repeated"}, 
    {"skill_effect", pt_skill_effect_value, "技能效果", "repeated"}, 
    {"break_add_attr", pt_break_add_attr, "突破附加属性列表", "repeated"}, 
    {"pre_bracelet_refine_skill_attr", pt_skill_effect_value, "手环下一突破精炼预览属性", "repeated"},
}
 
--- *s2c* 商城信息 17006
SC_SHOP_DATA =
{
    17006, 
    {"shop_data", pt_shop_data, "商城信息列表", "repeated"},
}
 
--- *c2s* 购买商店道具 17007
CS_SHOP_BUY =
{
    17007, 
    {"shop_type", "int8", "商店类型标签"}, 
    {"shop_id", "int32", "商品id"}, 
    {"num", "int16", "购买数量"},
}
 
--- *s2c* 购买商店道具返回 17008
SC_SHOP_BUY =
{
    17008, 
    {"shop_type", "int8", "商店类型标签"}, 
    {"shop_id", "int32", "商品id"}, 
    {"num", "int16", "购买数量"}, 
    {"award_list", pt_prop_award, "奖励列表", "repeated"},
}
 
--- *c2s* 请求某个商店的数据 17009
CS_SHOP_TYPE_DATA =
{
    17009, 
    {"shop_type", "int8", "商店类型标签"},
}
 
--- *s2c* 某个类型商店的数据 17010
SC_SHOP_TYPE_DATA =
{
    17010, 
    {"shop_type", "int8", "商店类型标签"}, 
    {"next_refresh_time", "int32", "0-该商店没有定时刷新功能，其他-下次刷新时间"}, 
    {"had_refresh", "int16", "已经刷新次数"}, 
    {"refresh_limit", "int16", "0-无限，其他-刷新上限"}, 
    {"cost_pay", "int8", "刷新消耗的货币类型"}, 
    {"cost_item", "int32", "刷新的道具tid"}, 
    {"cost_num", "int32", "刷新消耗的数量"},
}
 
--- *c2s* 请求商店刷新 17011
CS_SHOP_REFRESH =
{
    17011, 
    {"shop_type", "int8", "商店类型标签"},
}
 
--- *s2c* 请求商店刷新返回 17012
SC_SHOP_REFRESH =
{
    17012, 
    {"shop_type", "int8", "商店类型标签"}, 
    {"result", "int8", "1-成功，其他-错误原因"},
}
 
--- *s2c* 通用奖励获取 17013
SC_PROP_AWARD_SEND =
{
    17013, 
    {"award_list", pt_prop_award, "道具列表", "repeated"},
}
 
--- *c2s* 批量使用tid 17014
CS_USE_MORE_TID =
{
    17014, 
    {"use_list", pt_use_tid_info, "使用的道具tid列表", "repeated"},
}
 
--- *c2s* 分解道具 17015
CS_DECOMPOSE_ITEM =
{
    17015, 
    {"item_id_list", "int32", "道具id列表", "repeated"},
}
 
--- *c2s* 出售道具 17016
CS_SELL_ITEM =
{
    17016, 
    {"item_list", pt_item_num, "道具列表", "repeated"},
}
 
--- *c2s* 道具加锁 17017
CS_LOCK_ITEM =
{
    17017, 
    {"item_id", "int32", "道具id"},
}
 
--- *c2s* 道具解锁 17018
CS_UNLOCK_ITEM =
{
    17018, 
    {"item_id", "int32", "道具id"},
}
 
--- *s2c* 更新商品信息 17019
SC_UPDATE_SHOP_DATA =
{
    17019, 
    {"shop_data", pt_shop_data, "商品信息列表", "repeated"},
}
 
--- *s2c* 刷新商城信息 17020
SC_REFRESH_SHOP_DATA =
{
    17020, 
    {"shop_type", "int8", "商店类型标签"}, 
    {"shop_data", pt_shop_data, "商城信息列表", "repeated"},
}

module("hero.HeroEquipController", Class.impl(Controller))

-- 构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

-- 析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

-- 游戏开始的回调
function gameStartCallBack(self)
end

-- 模块间事件监听
function listNotification(self)
    -- 打开装备套装选择界面
    GameDispatcher:addEventListener(EventName.OPEN_HERO_EQUIP_SUIT_PANEL, self.__onOpenHeroEquipSuitPanelHandler, self)
    -- 打开装备背包选择界面
    GameDispatcher:addEventListener(EventName.OPEN_HERO_EQUIP_BAG_PANEL, self.__onOpenHeroEquipBagPanelHandler, self)
    -- 打开英雄装备属性列表面板
    GameDispatcher:addEventListener(EventName.OPEN_HERO_EQUIP_ATTR_LIST_PANEL, self.__onOpenEquipAttrListPanelHandler, self)
    -- 请求装备英雄装备
    GameDispatcher:addEventListener(EventName.REQ_HERO_ADD_EQUIP, self.__onReqHeroAddEquipHandler, self)
    -- 请求卸下英雄装备
    GameDispatcher:addEventListener(EventName.REQ_HERO_DEL_EQUIP, self.__onReqHeroDelEquipHandler, self)
    -- 请求抢夺英雄装备
    GameDispatcher:addEventListener(EventName.REQ_HERO_ROB_EQUIP, self.__onReqHeroRobEquipHandler, self)

    -- 打开手环背包选择界面
    GameDispatcher:addEventListener(EventName.OPEN_BRACELETS_BAG_PANEL, self.__onOpenBraceletsSuitPanelHandler, self)
    
    -- 打开手环信息弹窗界面
    GameDispatcher:addEventListener(EventName.OPEN_BRACELETS_TIPS_PANEL, self.onOpenBraceletsTipsHandler, self)

    -- 请求全部战员穿戴装备简易信息
    GameDispatcher:addEventListener(EventName.REQ_ALL_HERO_EQUIP, self.__onReqAllHeroEquipHandler, self)
    -- 打开芯片界面
    GameDispatcher:addEventListener(EventName.OPEN_HERO_EQUIP_PANEL, self.__onOpenHeroEquipPanelHandler, self)
    -- 打开切换角色界面
    GameDispatcher:addEventListener(EventName.OPEN_HERO_EQUIP_CHANGE_HERO_PANEL, self.__onOpenHeroEquipChangeHeroPanelHandler, self)

    hero.HeroEquipManager:addEventListener(hero.HeroEquipManager.HERO_BAG_EQUIP_CHANGE, self.__onClickReplaceHandler, self)
end

-- 注册server发来的数据
function registerMsgHandler(self)
    return { --- *s2c* 装备英雄装备 13016
    SC_LOAD_EQUIP = self.__onResHeroAddEquipHandler, --- *s2c* 卸下英雄装备 13018
    SC_UNLOAD_EQUIP = self.__onResHeroDelEquipHandler, --- *s2c* 英雄装备更新 13019
    SC_UPDATE_EQUIP = self.__onResHeroUpdateEquipHandler, --- *s2c* 抢夺英雄装备 13035
    SC_ROB_EQUIP = self.__onResHeroRobEquipHandler, --- *s2c* 全部战员简易信息 13103
    SC_ALL_HERO_EQUIP_INFO = self.__onResAllHeroEquipHandler}
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 装备英雄装备 13016
function __onResHeroAddEquipHandler(self, msg)
    if (msg.result == 1) then
        gs.Message.Show(_TT(71446))
    else
        gs.Message.Show("穿戴芯片失败")
    end
end

-- 卸下英雄装备 13018
function __onResHeroDelEquipHandler(self, msg)
    if (msg.result == 1) then
        gs.Message.Show(_TT(71447))
    else
        gs.Message.Show("卸下芯片失败")
    end
end

-- 英雄装备更新 13019
function __onResHeroUpdateEquipHandler(self, msg)
    hero.HeroEquipManager:parseHeroUpdateEquipMsg(msg)
end

-- 抢夺英雄装备 13035
function __onResHeroRobEquipHandler(self, msg)
    if (msg.result == 1) then
        gs.Message.Show(_TT(71446))
    else
        gs.Message.Show("抢夺英雄装备失败")
    end
end

-- --- 全部战员简易装备信息 13103
function __onResAllHeroEquipHandler(self, msg)
    for i = 1, #msg.all_hero_equip_info, 1 do
        local heroId = msg.all_hero_equip_info[i].hero_id
        local equipList =  msg.all_hero_equip_info[i].equip_list
        local heroVo = hero.HeroManager:getHeroVo(heroId)
        if (heroVo and (not heroVo.equipList or #heroVo.equipList <= 0)) then
            heroVo:setEquipDetailList(equipList)
        end
    end
     GameDispatcher:dispatchEvent(EventName.UPDATE_ALL_HERO_EQUIP, {})
 end

---------------------------------------------------------------请求------------------------------------------------------------------
-- 请求装备英雄装备
function __onReqHeroAddEquipHandler(self, args)
    --- *c2s* 装备英雄装备 13015
    local list = {}
    if type(args.equipId) == "table" then
        for i = 1, #args.equipId do
            table.insert(list, args.equipId[i])
        end
    else
        table.insert(list, args.equipId)
      
    end
    SOCKET_SEND(Protocol.CS_LOAD_EQUIP, {hero_id = args.heroId, equip_id = list}, Protocol.SC_LOAD_EQUIP,1)
end

-- 请求卸下英雄装备
function __onReqHeroDelEquipHandler(self, args)

    local posList = {}
    local heroId = 0
    if args.compatible == nil then
        local equipVo = args.equipVo
        heroId = equipVo.heroId
        table.insert(posList,equipVo.subType)
    else
        heroId = args.equipVo[1].heroId
        for i = 1, #args.equipVo do
            table.insert(posList, args.equipVo[i].subType)
        end     
    end
   
    SOCKET_SEND(Protocol.CS_UNLOAD_EQUIP, {hero_id = heroId, pos = posList}, Protocol.SC_UNLOAD_EQUIP,1)
end

-- 请求交换英雄装备
function __onReqHeroRobEquipHandler(self, args)
    local heroId = args.heroId
    local beRobbedEquipId = args.beRobbedEquipId
    local beRobbedHeroId = args.beRobbedHeroId
    --- *c2s* 战员抢夺装备 13034
    SOCKET_SEND(Protocol.CS_ROB_EQUIP, {hero_id = heroId, rob_hero_id = beRobbedHeroId, rob_pos_id = beRobbedEquipId}, Protocol.SC_ROB_EQUIP)
end

-- 请求全部战员穿戴装备简易信息
function __onReqAllHeroEquipHandler(self, args)
    --- *c2s* 全部战员简易信息 13102
    SOCKET_SEND(Protocol.CS_ALL_HERO_EQUIP_INFO, Protocol.SC_ALL_HERO_EQUIP_INFO)
end

------------------------------------------------------------------------ 英雄装备套装面板 ------------------------------------------------------------------------
function __onOpenHeroEquipSuitPanelHandler(self, args)
    if self.m_heroSuitBagPanel == nil then
        self.m_heroSuitBagPanel = hero.HeroEquipSuitPanel.new()
        self.m_heroSuitBagPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEquipSuitPanelHandler, self)
    end
    local equipSlotPos = args.slotPos
    local heroId = args.heroId
    self.m_heroSuitBagPanel:open({heroId = heroId, equipSlotPos = equipSlotPos})
end

function onDestroyEquipSuitPanelHandler(self)
    self.m_heroSuitBagPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEquipSuitPanelHandler, self)
    self.m_heroSuitBagPanel = nil
end

------------------------------------------------------------------------ 英雄装备背包面板 ------------------------------------------------------------------------
function __onOpenHeroEquipBagPanelHandler(self, args)
    -- if self.m_heroEquipBagPanel == nil then
    --     self.m_heroEquipBagPanel = hero.HeroEquipBagPanel.new()
    --     self.m_heroEquipBagPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEquipBagPanelHandler, self)
    -- end
    -- local equipSlotPos = args.slotPos
    -- local heroId = args.heroId
    -- local suitId = args.suitId
    -- self.m_heroEquipBagPanel:open({heroId = heroId, equipSlotPos = equipSlotPos, suitId = suitId})
end

function onDestroyEquipBagPanelHandler(self)
    -- self.m_heroEquipBagPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEquipBagPanelHandler, self)
    -- self.m_heroEquipBagPanel = nil
end

------------------------------------------------------------------------ 英雄装备属性列表面板 ------------------------------------------------------------------------
function __onOpenEquipAttrListPanelHandler(self, args)
    if self.m_heroEquipAttrListPanel == nil then
        self.m_heroEquipAttrListPanel = hero.HeroEquipAttrListPanel.new()
        self.m_heroEquipAttrListPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEquipAttrListPanelHandler, self)
    end
    if (args and args.heroVo) then
        self.m_heroEquipAttrListPanel:open(args.heroVo)
    end
end

function onDestroyEquipAttrListPanelHandler(self)
    self.m_heroEquipAttrListPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDetailsPanelHandler, self)
    self.m_heroEquipAttrListPanel = nil
end

------------------------------------------------------------------------ 英雄手环背包面板 ------------------------------------------------------------------------
function __onOpenBraceletsSuitPanelHandler(self, args)
    if self.m_heroBraceletsPanel == nil then
        self.m_heroBraceletsPanel = hero.HeroBraceletsPanel.new()
        self.m_heroBraceletsPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBraceletsBagPanelHandler, self)
    end
    local equipSlotPos = args.slotPos
    local heroId = args.heroId
    self.m_heroBraceletsPanel:open({heroId = heroId, equipSlotPos = equipSlotPos})
end

function onDestroyBraceletsBagPanelHandler(self)
    self.m_heroBraceletsPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBraceletsBagPanelHandler, self)
    self.m_heroBraceletsPanel = nil
end

function __onOpenHeroEquipPanelHandler(self, args)
    if self.m_heroEquipPanel == nil then
        self.m_heroEquipPanel = hero.HeroEquipPanel.new()
        self.m_heroEquipPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroEquipPanelHandler, self)
    end
    self.m_heroEquipPanel:open(args)
end

function onDestroyHeroEquipPanelHandler(self)
    self.m_heroEquipPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroEquipPanelHandler, self)
    self.m_heroEquipPanel = nil

    equipBuild.EquipBuildManager:resetData();
end

function __onOpenHeroEquipChangeHeroPanelHandler(self)
    if self.m_heroEquipChangePanel == nil then
        self.m_heroEquipChangePanel = hero.HeroEquipChangeHeroPanel.new()
        self.m_heroEquipChangePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroEquipChangeHeroPanelHandler, self)
    end
    self.m_heroEquipChangePanel:open(args)
end

function onDestroyHeroEquipChangeHeroPanelHandler(self)
    self.m_heroEquipChangePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroEquipChangeHeroPanelHandler, self)
    self.m_heroEquipChangePanel = nil
end

function __onClickReplaceHandler(self, args)
    if self.m_heroEquipPanel then
        self.m_heroEquipPanel:onChangeToReplace(args)
    end
end

--手环信息面板
function onOpenBraceletsTipsHandler(self, args)
    if self.m_heroBraceletsTips == nil then
        self.m_heroBraceletsTips = hero.HeroBraceletsTipsPanel.new()
        self.m_heroBraceletsTips:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBraceletsTipsHandlerr, self)
    end

    self.m_heroBraceletsTips:open(args)
end

function onDestroyBraceletsTipsHandlerr(self)
    self.m_heroBraceletsTips:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBraceletsTipsHandlerr, self)
    self.m_heroBraceletsTips = nil
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]

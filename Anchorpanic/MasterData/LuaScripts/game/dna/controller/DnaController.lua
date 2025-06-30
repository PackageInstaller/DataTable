--[[
-----------------------------------------------------
   @CreateTime:2024/12/11 16:31:22
   @Author:zengweiwen
   @Copyright: (LY)2021 雷焰网络
   @Description:TODO
]]

module("game.dna.controller.DnaController", Class.impl(Controller))

function ctor(self)
    super.ctor(self)
    self.viewInstanceDic = {}
end

function listNotification(self)
    --ui事件
    GameDispatcher:addEventListener(EventName.OPEN_DNA_CULTIVATE_PANEL, self.onOpenDnaCultivatePanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_DNA_CULTIVATE_CHOICE_VIEW, self.onOpenDnaCultivateChoiceViewHandler,
        self)
    GameDispatcher:addEventListener(EventName.OPEN_DNA_MANUAL_VIEW, self.onOpenDnaManualViewHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_DNA_TIPS_VIEW, self.onOpenDnaTipsViewHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_DNA_SKILL_ALL_LV_TIPS_VIEW, self.onOpenDnaSkillAllLvTipsViewHandler,
        self)
    GameDispatcher:addEventListener(EventName.OPEN_DNA_SWITCH_ACTIVE_ATTR_VIEW, self
        .onOpenDnaSwitchActiveAttrViewHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_DNA_OPEN_BOX_EFX_PANEL, self
        .onOpenDnaOpenBoxEfxPanelHandler, self)

    --请求事件
    GameDispatcher:addEventListener(EventName.REQ_WEAR_DNA_EGG, self.onReqWearDnaEggHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_LVLUP_DNA_EGG, self.onReqLvlupDnaEggHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_LVLUP_DNA_HATCH, self.onReqLvlupDnaHatchHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_HERO_EGG_CAL_SWITCH, self.onReqHeroEggCalSwitchHandler, self)
end

function registerMsgHandler(self)
    return {
        -- *s2c* 战员孵化 13354
        SC_HERO_EGG_HATCH = self.onScHeroEggHatchHandler,
        --- *s2c* dna蛋图鉴 12106
        SC_HERO_EGG_MANUAL = self.onScHeroEggManualHandler
    }
end

--通用打开界面的接口排除繁琐代码
local function __openView(self, viewClass, args)
    local viewInstance = self.viewInstanceDic[viewClass.__cname]
    if not viewInstance then
        viewInstance = viewClass.new()
        viewInstance:addEventListener(View.EVENT_VIEW_DESTROY, self.onCloseViewHandler, self)
        self.viewInstanceDic[viewClass.__cname] = viewInstance
    end
    viewInstance:open(args)
end

function onCloseViewHandler(self, event, viewInstance)
    viewInstance:removeEventListener(View.EVENT_VIEW_DESTROY, self.onCloseViewHandler, self)
    self.viewInstanceDic[viewInstance.__cname] = nil
end

-------------------------------------------------响应-----------------------------------------

--打开dna培养界面
function onOpenDnaCultivatePanelHandler(self, msg)
    __openView(self, dna.DnaCultivatePanel, {
        heroId = msg.heroId,
        teamId = msg.teamId
    })
end

--打开dna培养选择界面
function onOpenDnaCultivateChoiceViewHandler(self, msg)
    __openView(self, dna.DnaCultivateChoiceView, { heroId = msg.heroId })
end

--打开dna图鉴界面
function onOpenDnaManualViewHandler(self, msg)
    __openView(self, dna.DnaManualView)
end

--打开dna tips界面
function onOpenDnaTipsViewHandler(self, msg)
    __openView(self, dna.DnaTips, {
        type = msg.type,
        cfgVo = msg.cfgVo
    })
end

function onOpenDnaSkillAllLvTipsViewHandler(self, msg)
    __openView(self, dna.DnaSkillAllLvTipsView, {
        heroVo = msg.heroVo,
        heroEggDataCfgVo = msg.heroEggDataCfgVo,
        cur_de_blocking = msg.cur_de_blocking,
        isActiveSkill = msg.isActiveSkill
    })
end

function onOpenDnaSwitchActiveAttrViewHandler(self, msg)
    __openView(self, dna.DnaSwitchActiveAttrView, {
        heroId = msg.heroId,
    })
end

function onOpenDnaOpenBoxEfxPanelHandler(self, msg)
    __openView(self, dna.DnaOpenBoxEfxPanel, {
        eggMaxQuality = msg.eggMaxQuality,
        callBack = msg.callBack,
    })
end

--孵化成功返回
function onScHeroEggHatchHandler(self, msg)
    __openView(self, dna.DnaIncubateSucceedView, { heroId = msg.hero_id })
    GameDispatcher:dispatchEvent(EventName.DNA_INCUBATE_SUCCEED)
end

--图鉴信息返回
function onScHeroEggManualHandler(self, msg)
    dna.DnaManager:parseDnaEggMsg(msg)
end

-------------------------------------------------请求-----------------------------------------
--- *c2s* 战员蛋装备 13351
function onReqWearDnaEggHandler(self, msg)
    SOCKET_SEND(Protocol.CS_HERO_EGG_EQUIP, { hero_id = msg.hero_id, egg_id = msg.egg_id })
end

--- *c2s* 战员蛋升级 13352
function onReqLvlupDnaEggHandler(self, msg)
    SOCKET_SEND(Protocol.CS_HERO_EGG_UPGRADE, { hero_id = msg.hero_id })
end

--- *c2s* 战员孵化 13353
function onReqLvlupDnaHatchHandler(self, msg)
    SOCKET_SEND(Protocol.CS_HERO_EGG_HATCH, { hero_id = msg.hero_id })
end

--- *c2s* 战员蛋属性开关 13355
function onReqHeroEggCalSwitchHandler(self, msg)
    SOCKET_SEND(Protocol.CS_HERO_EGG_CAL_SWITCH, {
        hero_id = msg.hero_id,
        close_attr_list = msg.close_attr_list
    })
end

return _M

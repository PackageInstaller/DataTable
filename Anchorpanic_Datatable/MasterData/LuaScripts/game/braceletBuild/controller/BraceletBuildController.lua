module("braceletBuild.BraceletBuildController", Class.impl(Controller))

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
    -- 请求卸下英雄手环
    GameDispatcher:addEventListener(EventName.REQ_HERO_ADD_BRACELET, self.onReqHeroAddBraceletHandler, self)
    -- 请求卸下英雄手环
    GameDispatcher:addEventListener(EventName.REQ_HERO_DEL_BRACELET, self.onReqHeroDelBraceletHandler, self)
    -- 请求抢夺英雄手环
    GameDispatcher:addEventListener(EventName.REQ_HERO_ROB_BRACELET, self.onReqHeroRobBraceletHandler, self)

    -- 打开手环培养界面
    GameDispatcher:addEventListener(EventName.OPEN_BRACELETS_BUILD_PANEL, self.onOpenBraceletsBuildPanelHandler, self)
    --请求手环精炼
    GameDispatcher:addEventListener(EventName.REQ_BRACELETS_REFINE, self.onReqBraceletsRefineHandler, self)

    --请求手环改造属性
    GameDispatcher:addEventListener(EventName.REQ_HERO_BRA_EMPOWER, self.onReq_Hero_Bra_Empower, self)
    --确认手环属性改造
    GameDispatcher:addEventListener(EventName.REQ_HERO_BRA_SAVE_ATTR, self.onReq_Hero_Bra_Save_Attr, self)
    --手环属性改造锁定词条
    GameDispatcher:addEventListener(EventName.REQ_HERO_BRA_LOCK_ATTR, self.onReq_Hero_Bra_Lock_Attr, self)
    GameDispatcher:addEventListener(EventName.REQ_HERO_EMPOWERSAVEINFO, self.onReq_Hero_BraEmpowerSaveInfo, self)

    --打开烙痕消耗确定弹窗
    GameDispatcher:addEventListener(EventName.OPEN_BRACELETEMPOWER_SUREPANEL, self.openBraceletEmpowerSurePanel, self)

    GameDispatcher:addEventListener(EventName.OPEN_BRACELETEMPOWER_TIPSPANEL, self.openBraceletEmpowerTipsPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_OPENBRACELETEMPOWER_UPPANEL, self.openBraceletEmpowerUpPanel, self)
end

-- 注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_EQUIP_STRENGTH = self.onResBraceletStrengthenHandler,

        SC_EQUIP_BREAKUP = self.onResBraceletBreakUpHandler,
        SC_EQUIP_BRACELET_REFINE = self.onBraceletRefineHandler,

        SC_LOAD_BRACELET = self.onResHeroAddBraceletHandler,
        SC_UNLOAD_BRACELET = self.onResHeroDelBraceletHandler,
        SC_ROB_BRACELET = self.onResHeroRobBraceletHandler,

        SC_BRACELET_EQUIP_REMAKE = self.onResHeroBraAttr,
        SC_BRACELET_EQUIP_REMAKE_CONFIRM = self.onResHeroBraSaveAttr,
        SC_BRACELET_EQUIP_REMAKE_LOCK = self.onResHeroBraLockAttr,
        SC_BRACELET_EQUIP_REMAKE_UNCONFIRM = self.onResHeroBraEmpowerSaveInfo,
    }
end

--穿戴手环返回
function onResHeroAddBraceletHandler(self, msg)
    if (msg.result == 1) then
        gs.Message.Show(_TT(71446))
    else
        gs.Message.Show("穿戴手环失败")
    end
end
--卸下手环返回
function onResHeroDelBraceletHandler(self, msg)
    if (msg.result == 1) then
        gs.Message.Show(_TT(71447))
    else
        gs.Message.Show("卸下手环失败")
    end
end
--交换手环返回
function onResHeroRobBraceletHandler(self, msg)
    if (msg.result == 1) then
        gs.Message.Show(_TT(71446))
    else
        gs.Message.Show("抢夺手环失败")
    end
end

--手环属性改装返回
function onResHeroBraAttr(self, msg)
    logAll(msg, "*s2c* 战员手环改造 13332")

    if msg.result == 0 then
        gs.Message.Show("烙痕赋能失败")
        return
    end

    self:openBraceletEmpowerSupPanel(msg.equip_id, msg.remake_type, msg.new_attr)

    if msg.remake_type == 1 then
        local equipVo = bag.BagManager:getPropsVoById(msg.equip_id, bag.BagType.Bracelets)
        if equipVo then
            if table.empty(equipVo:getBracelet_remake_attr()) then
                self:updataEquipBracelet_remake_attr(self.mBraceletEmpowerTempAttr.equip_id, self.mBraceletEmpowerTempAttr.bracelet_remake_attr)
            end
        end
    end
    GameDispatcher:dispatchEvent(EventName.RES_HERO_BRA_EMPOWER, self.mBraceletEmpowerTempAttr)
end

function openBraceletEmpowerSupPanel(self, equip_id, remake_type, attrList)
    if self.mBraceletEmpowerSurePanel then
        self.mBraceletEmpowerSurePanel:close()
    end

    local bracelet_remake_attr = {}
    for _, attr in pairs(attrList) do
        bracelet_remake_attr[attr.remake_pos] = {attrType = attr.key, attrValue = attr.value, level = attr.level, maxLevel = attr.max_level, is_lock = attr.is_lock == 1, pos = attr.remake_pos}
    end

    self.mBraceletEmpowerTempAttr = {equip_id = equip_id, remake_type = remake_type, bracelet_remake_attr = bracelet_remake_attr}
    GameDispatcher:dispatchEvent(EventName.OPEN_OPENBRACELETEMPOWER_UPPANEL, self.mBraceletEmpowerTempAttr)
end

--手环属性确定返回
function onResHeroBraSaveAttr(self, msg)
    logAll(msg, "*s2c* 确认改造结果 13334")

    if msg.result == 0 then
        gs.Message.Show("烙痕赋能保存失败")
        return
    end

    if self.mBraceletEmpowerUpPanel then
        self.mBraceletEmpowerUpPanel:close()
    end

    --再次打开确认弹窗
    if self.mBraceletEmpowerTempAttr.remake_type == 2 then
        local LockAttrCount = 0
        for pos, attr in pairs(self.mBraceletEmpowerTempAttr.bracelet_remake_attr) do
            if attr.is_lock then
                LockAttrCount = LockAttrCount + 1
            end
        end

        local sysParamTid = 0
        if LockAttrCount == 0 then
            sysParamTid = 1932
        elseif LockAttrCount == 1 then
            sysParamTid = 1936
        elseif LockAttrCount == 2 then
            sysParamTid = 1938
        end
        local item = sysParam.SysParamManager:getValue(sysParamTid)
        local itemList = {}
        for i = 1, #item do
            table.insert(itemList, {tid = item[i][1], num = item[i][2]})
        end
        GameDispatcher:dispatchEvent(EventName.OPEN_BRACELETEMPOWER_SUREPANEL, {type = 2, itemList = itemList, equipId = self.mBraceletEmpowerTempAttr.equip_id})
    end

    if msg.is_save == 1 then
        self:updataEquipBracelet_remake_attr(self.mBraceletEmpowerTempAttr.equip_id, self.mBraceletEmpowerTempAttr.bracelet_remake_attr)
    end

    GameDispatcher:dispatchEvent(EventName.RES_HERO_BRA_SAVE_ATTR, self.mBraceletEmpowerTempAttr)
    self.mBraceletEmpowerTempAttr = nil
end

function updataEquipBracelet_remake_attr(self, equip_id, attr)
    local equipVo = bag.BagManager:getPropsVoById(equip_id, bag.BagType.Bracelets)
    if equipVo then
        local bracelet_remake_attr = {}

        for k, v in pairs(attr) do
            table.insert(bracelet_remake_attr, {key = v.attrType, value = v.attrValue, level = v.level, max_level = v.maxLevel, is_lock = v.is_lock and 1 or 0, remake_pos = v.pos})
        end
        equipVo:setBracelet_remake_attr(bracelet_remake_attr)
    end
end

--手环属性锁定返回
function onResHeroBraLockAttr(self, msg)
    logAll(msg, "*s2c* 烙痕锁定 13336")

    if msg.result == 0 then
        gs.Message.Show("烙痕赋能锁定属性失败")
        return
    end

    if msg.is_lock == 1 then
        gs.Message.Show(_TT(93119))
    else
        gs.Message.Show(_TT(93120))
    end

    if self.mBraceletEmpowerSurePanel then
        self.mBraceletEmpowerSurePanel:close()
    end

    local equipVo = bag.BagManager:getPropsVoById(msg.equip_id, bag.BagType.Bracelets)
    if equipVo then
        local bracelet_remake_attr = {}
        local attList = equipVo:getBracelet_remake_attr()
        for k, v in pairs(attList) do
            if v.pos == msg.pos then
                v.is_lock = msg.is_lock == 1
            end
        end
    end

    GameDispatcher:dispatchEvent(EventName.RES_HERO_BRA_LOCK_ATTR, {equip_id = msg.equip_id, pos = msg.pos, is_lock = msg.is_lock == 1})
end

--是否有未保存的赋能信息返回
function onResHeroBraEmpowerSaveInfo(self, msg)
    logAll(msg, "是否有未保存信息返回")
    if msg.result == 0 or table.empty(msg.new_attr) then
        return
    end

    self:openBraceletEmpowerSupPanel(msg.equip_id, 2, msg.new_attr)
end

function onReq_Hero_Bra_Empower(self, args)
    logAll({equip_id = args.equipId, remake_type = args.type}, "**c2s* 战员烙痕改造 13331")
    SOCKET_SEND(Protocol.CS_BRACELET_EQUIP_REMAKE, {equip_id = args.equipId, remake_type = args.type}, Protocol.SC_BRACELET_EQUIP_REMAKE)
end

function onReq_Hero_Bra_Save_Attr(self, args)
    logAll({is_save = args.isSave and 1 or 0, equip_id = args.equipId}, " *c2s* 确认改造结果 13333")

    SOCKET_SEND(Protocol.CS_BRACELET_EQUIP_REMAKE_CONFIRM, {is_save = args.isSave and 1 or 0, equip_id = args.equipId}, Protocol.SC_BRACELET_EQUIP_REMAKE_CONFIRM)

end

function onReq_Hero_Bra_Lock_Attr(self, args)
    logAll({equip_id = args.equipId, pos = args.pos, is_lock = args.is_lock and 1 or 0}, "*c2s* 烙痕锁定 13335")

    SOCKET_SEND(Protocol.CS_BRACELET_EQUIP_REMAKE_LOCK, {equip_id = args.equipId, pos = args.pos, is_lock = args.is_lock and 1 or 0}, Protocol.SC_BRACELET_EQUIP_REMAKE_LOCK)
end

---是否有未保存的赋能信息
function onReq_Hero_BraEmpowerSaveInfo(self, equip_id)
    logAll({equip_id = equip_id}, "请求是否有未保存的赋能信息")
    SOCKET_SEND(Protocol.CS_BRACELET_EQUIP_REMAKE_UNCONFIRM, {equip_id = equip_id}, Protocol.SC_BRACELET_EQUIP_REMAKE_UNCONFIRM)
end

--请求装备手环
function onReqHeroAddBraceletHandler(self, args)
    SOCKET_SEND(Protocol.CS_LOAD_BRACELET, {hero_id = args.heroId, bracelet_id = args.equipId}, Protocol.SC_LOAD_BRACELET, 1)
end

--请求卸下手环
function onReqHeroDelBraceletHandler(self, args)
    SOCKET_SEND(Protocol.CS_UNLOAD_BRACELET, {hero_id = args.equipVo.heroId}, Protocol.SC_UNLOAD_BRACELET, 1)
end

-- 请求交换手环
function onReqHeroRobBraceletHandler(self, args)
    local heroId = args.heroId
    local beRobbedEquipId = args.beRobbedEquipId
    SOCKET_SEND(Protocol.CS_ROB_BRACELET, {hero_id = heroId, rob_bracelet_id = beRobbedEquipId}, Protocol.SC_ROB_BRACELET, 1)
end

function onReqBraceletsRefineHandler(self, args)
    -- *c2s* 装备手环精炼 13100
    SOCKET_SEND(Protocol.CS_EQUIP_BRACELET_REFINE, {
        id = args.heroId,
        equip_id = args.equipId,
        cost_list = args.list
    }, Protocol.SC_EQUIP_BRACELET_REFINE)
end

function onResBraceletStrengthenHandler(self, msg)
    local equipPos = msg.equip_pos
    if (equipPos == PropsEquipSubType.SLOT_7) then
        if msg.result <= 0 then
            gs.Message.Show(_TT(4371))
        else
            local strengthenLvl = msg.strength_lv
            local strengthenExp = msg.strength_exp
            local heroId = msg.hero_id
            local equipId = msg.equip_id
            --local curEquipVo = braceletBuild.BraceletBuildManager:getLastStBraceletVO(self.selectEquipVo)
            local curEquipVo = braceletBuild.BraceletBuildManager:getOpenEquipVo()

            --if curEquipVo then
            local oldEquipVo = curEquipVo:clone()
            local function attrUpdate(self, args)
                GameDispatcher:removeEventListener(EventName.UPDATE_BRACELET_DETAIL_DATA, attrUpdate, self)

                curEquipVo.strengthenLvl = strengthenLvl
                curEquipVo.strengthenExp = strengthenExp
                local function finishCall()
                    if (oldEquipVo.strengthenLvl == curEquipVo.strengthenLvl) then
                        gs.Message.Show(_TT(4372))
                    else
                        self:onBraceletStrengthenSucPanel({
                            oldEquipVo = oldEquipVo,
                            curEquipVo = curEquipVo,
                            isBreakUp = false
                        })
                    end
                end

                GameDispatcher:dispatchEvent(EventName.UPDATE_BRACELETS_STRENGTHEN_PANEL, {
                    oldEquipVo = oldEquipVo,
                    curEquipVo = curEquipVo,
                    finishCall = finishCall
                })

            end
            --curEquipVo:addEventListener(curEquipVo.UPDATE_EQUIP_DETAIL_DATA, attrUpdate, self)
            GameDispatcher:addEventListener(EventName.UPDATE_BRACELET_DETAIL_DATA, attrUpdate, self)
            --end
        end
    end
    -- 芯片的放在EquipController处理
end

function onResBraceletBreakUpHandler(self, msg)
    local equipPos = msg.equip_pos
    if (equipPos == PropsEquipSubType.SLOT_7) then
        if msg.result <= 0 then
            gs.Message.Show(_TT(4371))
        else
            local tuPoRank = msg.breakup_rank
            local heroId = msg.hero_id
            local equipId = msg.equip_id
            local curEquipVo = braceletBuild.BraceletBuildManager:getOpenEquipVo()

            --if curEquipVo then
            local oldEquipVo = curEquipVo:clone()

            local function attrUpdate(self, args)
                GameDispatcher:removeEventListener(EventName.UPDATE_BRACELET_DETAIL_DATA, attrUpdate, self)
                --curEquipVo:removeEventListener(curEquipVo.UPDATE_EQUIP_DETAIL_DATA, attrUpdate, self)

                curEquipVo.tuPoRank = tuPoRank
                self:onBraceletStrengthenSucPanel({
                    oldEquipVo = oldEquipVo,
                    curEquipVo = curEquipVo,
                    isBreakUp = true
                })
                GameDispatcher:dispatchEvent(EventName.UPDATE_BRACELETS_BREAKUP_PANEL, {
                    oldEquipVo = oldEquipVo,
                    curEquipVo = curEquipVo
                })
            end
            GameDispatcher:addEventListener(EventName.UPDATE_BRACELET_DETAIL_DATA, attrUpdate, self)
            --curEquipVo:addEventListener(curEquipVo.UPDATE_EQUIP_DETAIL_DATA, attrUpdate, self)
            --end
        end
    end
end

function onBraceletRefineHandler(self, msg)
    if (msg.result <= 0) then
        gs.Message.Show(_TT(4370))
    else
        local heroId = msg.hero_id
        local equipId = msg.equip_id
        local refineLvl = msg.refine_lv

        local curEquipVo = braceletBuild.BraceletBuildManager:getOpenEquipVo()

        local function attrUpdate(self, args)
            GameDispatcher:removeEventListener(EventName.UPDATE_BRACELET_DETAIL_DATA, attrUpdate, self)
            --curEquipVo:removeEventListener(curEquipVo.UPDATE_EQUIP_DETAIL_DATA, attrUpdate, self)

            curEquipVo.refineLvl = refineLvl
            GameDispatcher:dispatchEvent(EventName.UPDATE_BRACELETS_REFINE_PANEL, {
                heroId = heroId,
                equipId = equipId
            })

            self:openBraceletRefineSurPanel({
                curEquipVo = curEquipVo
            })
        end
        GameDispatcher:addEventListener(EventName.UPDATE_BRACELET_DETAIL_DATA, attrUpdate, self)
        --curEquipVo:addEventListener(curEquipVo.UPDATE_EQUIP_DETAIL_DATA, attrUpdate, self)
    end
end

----------------------------------------------------手环赋能
function openBraceletEmpowerTipsPanel(self, args)
    if self.mBraceletEmpowerTipsPanel == nil then
        self.mBraceletEmpowerTipsPanel = braceletBuild.BraceletEmpowerTipsPanel.new()
        self.mBraceletEmpowerTipsPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBraceletEmpowerTipsPanelHandler, self)
    end
    self.mBraceletEmpowerTipsPanel:open(args)
end

function onDestroyBraceletEmpowerTipsPanelHandler(self)
    self.mBraceletEmpowerTipsPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBraceletEmpowerTipsPanelHandler, self)
    self.mBraceletEmpowerTipsPanel = nil
end

function openBraceletEmpowerSurePanel(self, args)
    if self.mBraceletEmpowerSurePanel == nil then
        self.mBraceletEmpowerSurePanel = braceletBuild.BraceletEmpowerSurePanel.new()
        self.mBraceletEmpowerSurePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBraceletEmpowerSurePanelHandler, self)
    end
    self.mBraceletEmpowerSurePanel:open(args)
end

function onDestroyBraceletEmpowerSurePanelHandler(self)
    self.mBraceletEmpowerSurePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBraceletEmpowerSurePanelHandler, self)
    self.mBraceletEmpowerSurePanel = nil
end

function openBraceletEmpowerUpPanel(self, args)
    if self.mBraceletEmpowerUpPanel == nil then
        self.mBraceletEmpowerUpPanel = braceletBuild.BraceletEmpowerUpPanel.new()
        self.mBraceletEmpowerUpPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBraceletEmpowerUpPanelHandler, self)
    end
    self.mBraceletEmpowerUpPanel:open(args)
end

function onDestroyBraceletEmpowerUpPanelHandler(self)
    self.mBraceletEmpowerUpPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBraceletEmpowerUpPanelHandler, self)
    self.mBraceletEmpowerUpPanel = nil
end

--------------------------------------------------

function onBraceletStrengthenSucPanel(self, args)
    if self.mBraceletStrengthenSucPanel == nil then
        self.mBraceletStrengthenSucPanel = braceletBuild.BraceletStrengthenSucPanel.new()
        self.mBraceletStrengthenSucPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStrengthenSucPanelHandler, self)
    end
    self.mBraceletStrengthenSucPanel:open(args)
end

function onDestroyStrengthenSucPanelHandler(self)
    self.mBraceletStrengthenSucPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStrengthenSucPanelHandler, self)
    self.mBraceletStrengthenSucPanel = nil
end

function openBraceletRefineSurPanel(self, args)
    if self.mBraceletRefineSucPanel == nil then
        self.mBraceletRefineSucPanel = braceletBuild.BraceletRefineSucPanel.new()
        self.mBraceletRefineSucPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRefineSucPanelHandler, self)
    end
    local curEquipVo = args.curEquipVo
    self.mBraceletRefineSucPanel:open({
        curEquipVo = curEquipVo
    })
end

function onDestroyRefineSucPanelHandler(self)
    self.mBraceletRefineSucPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRefineSucPanelHandler, self)
    self.mBraceletRefineSucPanel = nil
end

function onOpenBraceletsBuildPanelHandler(self, args)
    local heroId = nil
    local equipId = nil
    local slotPos = nil
    if (args) then
        local equipVo = args.equipVo
        heroId = equipVo.heroId
        equipId = equipVo.id
        slotPos = equipVo.subType
        --braceletBuild.BraceletBuildManager.nowHeroId = args.heroId
    end
    braceletBuild.BraceletBuildManager:setHeroId(heroId)
    braceletBuild.BraceletBuildManager:setEquipId(equipId)
    braceletBuild.BraceletBuildManager:setOpenEquipVo(args.equipVo)
    if not args or not args.type then
        args = {
            type = braceletBuild.BuildTabType.STRENGTHEN
        }
    end

    if self.m_equipBuildPanel == nil then
        self.m_equipBuildPanel = braceletBuild.BraceletBuildPanel.new()
        self.m_equipBuildPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEquipBuildPanelHandler, self)
    end
    self.m_equipBuildPanel:open(args)
end

function onDestroyEquipBuildPanelHandler(self)
    self.m_equipBuildPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEquipBuildPanelHandler, self)
    self.m_equipBuildPanel = nil
end

return _M

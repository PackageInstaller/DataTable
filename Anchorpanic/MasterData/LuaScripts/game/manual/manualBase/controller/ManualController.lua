--[[ 
-----------------------------------------------------
@filename       : ManualController
@Description    : 图鉴
@date           : 2022-2-22 10:25:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualController", Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
    manual.ManualModuleManager:resetData()
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    -- 档案请求检查触发
    GameDispatcher:addEventListener(EventName.OPEN_MANUAL_PANEL, self.onOpenManualPanelMainHandler, self)
    -- 打开故事信息界面
    GameDispatcher:addEventListener(EventName.OPEN_STORY_INFO_VIEW, self.onOpenManualStoryInfoViewHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_BRACELES_DETAIL, self.onOpenManualBracelesInfoViewHandler, self)

    manual.ManualManager:addEventListener(manual.ManualManager.OPEN_MONSTER_INFOVIEW, self.onOpenMonsterInfoViewHandler, self)
    --打开模组界面
    GameDispatcher:addEventListener(EventName.OPEN_MODULE_DETAIL, self.onOpenModuleInfoViewHandler, self)
    --打开世界界面
    GameDispatcher:addEventListener(EventName.OPEN_WORLD_VIEW, self.onOpenManualWorldTabViewHandler, self)
    --打开战员界面
    GameDispatcher:addEventListener(EventName.OPEN_MANUALHERO_VIEW, self.onOpenManualHeroViewHandler, self)

end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 怪物图鉴 12100
        SC_MONSTER_MANUAL = self.onResManualMonsterMsgHandler,
        --- *s2c* 音乐图鉴 12103
        SC_MUSIC_MANUAL = self.onResManualMusicMsgHandler,
        --- *s2c* 故事图鉴 12104
        SC_STORY_MANUAL = self.onResManualStoryMsgHandler,
        --- *s2c* 手环图鉴 12102
        SC_BRACELET_MANUAL = self.onResEquipMsgHandler,
        --- *s2c* 模组套装图鉴 12101
        SC_EQUIP_SUIT_MANUAL = self.onResModuleMgsHandler,
        --- *s2c* 世界观图鉴 12105
        SC_WORLD_MANUAL = self.onResWorldMgsHandler
    }
end

---------------------------------------------------------------请求--------------------------------------------------------------------------
-- --- *c2s* 请求档案面板信息 19160
-- function __onReqPanelInfoHandler(self, args)
--     SOCKET_SEND(Protocol.CS_PANEL_INFO, {})
-- end

---------------------------------------------------------------返回--------------------------------------------------------------------------
--- *s2c* 怪物图鉴 12100
function onResManualMonsterMsgHandler(self, msg)
    if msg then
        manual.ManualManager:parseHasFightList(msg.is_init == 1, msg.mon_list)
    end
end

--- *s2c* 手环图鉴 12102
function onResEquipMsgHandler(self, msg)
    manual.ManualManager:parseHasGotEquip(msg)
end

--- *s2c* 音乐图鉴 12103
function onResManualMusicMsgHandler(self, msg)
    manual.ManualMusicManager:parseManualMusicMsg(msg)
end
--- *s2c* 故事图鉴 12104
function onResManualStoryMsgHandler(self, msg)
    manual.ManualStoryManager:parseManualStoryMsg(msg)
end
--- *s2c* 模组套装图鉴 12101
function onResModuleMgsHandler(self, msg)
    manual.ManualModuleManager:parserModuleInfo(msg)
    GameDispatcher:dispatchEvent(EventName.UPDATE_MODULE_DETAIL)
end
--- *s2c* 世界观图鉴 12105
function onResWorldMgsHandler(self, msg)
    manual.ManualWorldManager:parseManualWorldMsg(msg)
end

---------------------------------------------------------------面板--------------------------------------------------------------------------
-- 打开档案面板
function onOpenManualPanelMainHandler(self, args)
    local type = args.type
    if (type == manual.ManualType.Monster) then
        if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_MANUAL_MONSTER, true) == false then
            return
        end
        local type = nil
        if args and args.subType then
            type = args.subType
        else
            type = manual.ManualType.Variation
        end
        local data = nil
        if args and args.data then
            data = args.data
        else
            data = {}
        end
        manual.ManualManager:setLastIndex(type)
        self:onOpenMonsterMainViewHandler(type, data)
    elseif type == manual.ManualType.Story then
        self:onOpenManualStoryViewHandler(args)
    elseif type == manual.ManualType.Music then
        self:onOpenManualMusicViewHandler()
    elseif type == manual.ManualType.Module then
        self:onOpenModulePanelHandler()
    elseif type == manual.ManualType.World then
        self:onOpenManualWorldTabViewHandler()
    elseif type == manual.ManualType.Hero then
        self:onOpenManualHeroPanelHandler()
    elseif type == manual.ManualType.SolderingMark then
        self:onOpenBracelesTabViewHandler()
    elseif type == manual.ManualType.Fashion then
        self:onOpenManualFashionPanelHandler()
    elseif type then
        gs.Message.Show(_TT(47102))
    else
        if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_MANUAL, true) == false then
            return
        end
        self:onOpenManualPanelHandler()
    end
end
---------------------------------------------------------------怪物信息面板--------------------------------------------------------------------------
function onOpenMonsterInfoViewHandler(self, args)
    if self.mMonsterInfoView == nil then
        self.mMonsterInfoView = manual.ManualMonsterInfoView.new()
        self.mMonsterInfoView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMonsterInfoViewHandler, self)
    end
    self.mMonsterInfoView:open(args)
end

function onDestroyMonsterInfoViewHandler(self)
    self.mMonsterInfoView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMonsterInfoViewHandler, self)
    self.mMonsterInfoView = nil
end

---------------------------------------------------------------怪物主界面--------------------------------------------------------------------------
function onOpenMonsterMainViewHandler(self, type, data)
    if (not self.mManualMonsterPanel) then
        self.mManualMonsterPanel = manual.ManualMonsterPanel.new()
        self.mManualMonsterPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMonsterMainViewHandler, self)
    end
    self.mManualMonsterPanel:open({ type = type, data = data })
end

function onDestroyMonsterMainViewHandler(self)
    self.mManualMonsterPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMonsterMainViewHandler, self)
    self.mManualMonsterPanel = nil
end
---------------------------------------------------------------图鉴-战员主界面--------------------------------------------------------------------------
function onOpenManualHeroPanelHandler(self, data)
    if (not self.mManualHeroPanel) then
        self.mManualHeroPanel = manual.ManualHeroPanel.new()
        self.mManualHeroPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyManualHeroPanelHandler, self)
    end
    self.mManualHeroPanel:open(data)
end

function onDestroyManualHeroPanelHandler(self)
    self.mManualHeroPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyManualHeroPanelHandler, self)
    self.mManualHeroPanel = nil
end
---------------------------------------------------------------图鉴-战员界面--------------------------------------------------------------------------
function onOpenManualHeroViewHandler(self, args)
    if (not self.mManualHeroView) then
        self.mManualHeroView = manual.ManualHeroView.new()
        self.mManualHeroView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyManualHeroViewHandler, self)
    end
    self.mManualHeroView:open(args)
end

function onDestroyManualHeroViewHandler(self)
    self.mManualHeroView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyManualHeroViewHandler, self)
    self.mManualHeroView = nil
end
---------------------------------------------------------------烙痕（手环）------------------------------------------------------------------------
function onOpenBracelesTabViewHandler(self)
    if (not self.mManualBracelesPanel) then
        self.mManualBracelesPanel = manual.ManualBracelesTabView.new()
        self.mManualBracelesPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBracelesTabViewHandler, self)
    end
    self.mManualBracelesPanel:open({ type = 1 })
end

function onDestroyBracelesTabViewHandler(self)
    self.mManualBracelesPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBracelesTabViewHandler, self)
    self.mManualBracelesPanel = nil
end

function onOpenManualBracelesInfoViewHandler(self, args)
    if self.mBracelesInfoView == nil then
        self.mBracelesInfoView = manual.ManualBracelesInfoView.new()
        self.mBracelesInfoView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBracelesInfoViewHandler, self)
    end
    self.mBracelesInfoView:open(args)
end

function onDestroyBracelesInfoViewHandler(self)
    self.mBracelesInfoView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBracelesInfoViewHandler, self)
    self.mBracelesInfoView = nil
end
---------------------------------------------------------------故事主界面--------------------------------------------------------------------------
function onOpenManualStoryViewHandler(self, args)
    if self.mManualStoryView == nil then
        self.mManualStoryView = manual.ManualStoryView.new()
        self.mManualStoryView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyManualStoryViewHandler, self)
    end
    self.mManualStoryView:open(args)
end

function onDestroyManualStoryViewHandler(self)
    self.mManualStoryView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyManualStoryViewHandler, self)
    self.mManualStoryView = nil
end

function onOpenManualStoryInfoViewHandler(self, args)
    if self.mManualStoryInfoView == nil then
        self.mManualStoryInfoView = manual.ManualStoryInfoView.new()
        self.mManualStoryInfoView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyManualStoryInfoViewHandler, self)
    end
    self.mManualStoryInfoView:open(args)
end

function onDestroyManualStoryInfoViewHandler(self)
    self.mManualStoryInfoView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyManualStoryInfoViewHandler, self)
    self.mManualStoryInfoView = nil
end

---------------------------------------------------------------图鉴主界面--------------------------------------------------------------------------
function onOpenManualPanelHandler(self, args)
    if self.mManualPanel == nil then
        self.mManualPanel = manual.ManualPanel.new()
        self.mManualPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyManualPanelHandler, self)
    end
    self.mManualPanel:open(args)
end

function onDestroyManualPanelHandler(self)
    self.mManualPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyManualPanelHandler, self)
    self.mManualPanel = nil
end

---------------------------------------------------------------图鉴世界主界面--------------------------------------------------------------------------
function onOpenManualWorldTabViewHandler(self, args)
    if self.ManualWorldTabView == nil then
        self.ManualWorldTabView = manual.ManualWorldTabView.new()
        self.ManualWorldTabView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyManualWorldTabViewHandler, self)
    end
    self.ManualWorldTabView:open(args)
end

function onDestroyManualWorldTabViewHandler(self)
    self.ManualWorldTabView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyManualWorldTabViewHandler, self)
    self.ManualWorldTabView = nil
end

---------------------------------------------------------------音乐主界面--------------------------------------------------------------------------
function onOpenManualMusicViewHandler(self, args)
    if self.mManualMusicView == nil then
        self.mManualMusicView = manual.ManualMusicView.new()
        self.mManualMusicView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyManualMusicViewHandler, self)
    end
    self.mManualMusicView:open(args)
end

function onDestroyManualMusicViewHandler(self)
    self.mManualMusicView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyManualMusicViewHandler, self)
    self.mManualMusicView = nil
end

---------------------------------------------------------------模组界面--------------------------------------------------------------------------
function onOpenModulePanelHandler(self, args)
    if self.mModulePanel == nil then
        self.mModulePanel = manual.ManualModulePanel.new()
        self.mModulePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOpenModulePanelHandler, self)
    end
    self.mModulePanel:open(args)
end

function onDestroyOpenModulePanelHandler(self)
    self.mModulePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOpenModulePanelHandler, self)
    self.mModulePanel = nil
end
--打开模组详细界面
function onOpenModuleInfoViewHandler(self, args)
    if self.mModuleInfoView == nil then
        self.mModuleInfoView = manual.ManualModuleInfoView.new()
        self.mModuleInfoView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOpenModuleInfoViewHandler, self)
    end
    self.mModuleInfoView:open(args)
end

function onDestroyOpenModuleInfoViewHandler(self)
    self.mModuleInfoView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOpenModuleInfoViewHandler, self)
    self.mModuleInfoView = nil
end

function onOpenManualFashionPanelHandler(self,args)
    if self.mManualFashionPanel == nil then
        self.mManualFashionPanel = manual.ManualFashionTabView.new()
        self.mManualFashionPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOpenManualFashionPanelHandler, self)
    end
    self.mManualFashionPanel:open(args)
end

function onDestroyOpenManualFashionPanelHandler(self)
    self.mManualFashionPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOpenManualFashionPanelHandler, self)
    self.mManualFashionPanel = nil
end



return _M

--[[ 替换语言包自动生成，请勿修改！
]]
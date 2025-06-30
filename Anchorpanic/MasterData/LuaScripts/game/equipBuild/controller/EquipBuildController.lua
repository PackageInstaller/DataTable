module("equipBuild.EquipBuildController", Class.impl(Controller))

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
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    -- 打开芯片培养界面
    GameDispatcher:addEventListener(EventName.OPEN_EQUIP_BUILD_PANEL, self.__onOpenEquipBuildPanelHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {}
end

------------------------------------------------------------------------ 培养面板 ------------------------------------------------------------------------
function __onOpenEquipBuildPanelHandler(self, args)
    local heroId = nil
    local equipId = nil
    local slotPos = nil
    if (args) then
        local equipVo = args.equipVo
        heroId = equipVo.heroId
        equipId = equipVo.id
        slotPos = equipVo.subType
    end
    equipBuild.EquipStrengthenManager:setHeroId(heroId)
    equipBuild.EquipStrengthenManager:setEquipId(equipId)
    equipBuild.EquipStrengthenManager:setOpenEquipVo(args.equipVo)
    if not args or not args.type then
        args = {
            type = equipBuild.BuildTabType.STRENGTHEN
        }
    end

    if self.m_equipBuildPanel == nil then
        self.m_equipBuildPanel = equipBuild.EquipBuildPanel.new()
        self.m_equipBuildPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEquipBuildPanelHandler, self)
    end
    self.m_equipBuildPanel:open(args)
end

function onDestroyEquipBuildPanelHandler(self)
    self.m_equipBuildPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEquipBuildPanelHandler, self)
    self.m_equipBuildPanel = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

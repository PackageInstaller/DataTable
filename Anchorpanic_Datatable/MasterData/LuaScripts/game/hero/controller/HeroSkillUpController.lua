module("hero.HeroSkillUpController", Class.impl(Controller))

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
    -- 打开英雄技能升级材料选择界面
    GameDispatcher:addEventListener(
        EventName.OPEN_SKILL_UP_MATERIAL_PANEL,
        self.__onOpenSkillUpMaterialPanelHandler,
        self
    )
    -- 更新英雄技能升级材料选择界面
    GameDispatcher:addEventListener(
        EventName.UPDATE_SKILL_UP_MATERIAL_PANEL,
        self.__onUpdateSkillUpMaterialPanelHandler,
        self
    )
    -- 打开英雄技能升级材料选择提示界面
    GameDispatcher:addEventListener(
        EventName.OPEN_SKILL_UP_MATERIAL_TIP_PANEL,
        self.__onOpenSkillUpMaterialTipPanelHandler,
        self
    )

    -- 请求英雄技能效果预览信息
    GameDispatcher:addEventListener(EventName.REQ_HERO_SKILL_UP_EFFECT, self.__onReqHeroSkillUpEffectHandler, self)
    -- 请求技能升级
    GameDispatcher:addEventListener(EventName.REQ_HERO_SKILL_UP, self.__onReqHeroSkillUpHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_SKILL_UP_SUC_PANEL, self.__onOpenSkillUpSucPanelHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_GROW_SKILL_UP_PANEL,self.__onOpenGrowSkillUpSucPanelHandler,self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        -- *s2c* 战员技能效果预览信息
        SC_NORMAL_SKILL_LV_UP = self.__onSkillUpEffectMsgHandler,
        --- *s2c* 战员技能升级信息 13121
        SC_SKILL_LV_UP = self.__onResHeroSkillrUpMsgHandler
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- *s2c* 战员技能效果预览信息
function __onSkillUpEffectMsgHandler(self, msg)
    local heroVo = hero.HeroManager:getHeroVo(msg.hero_id)
    if (heroVo) then
        heroVo:setSkillUpEffect(msg.present_skill_effect, msg.next_skill_effect, false)
        local skillVo = fight.SkillManager:getSkillRo(msg.present_skill_effect[1].skill_id)
        hero.HeroManager:dispatchEvent(
            hero.HeroManager.HERO_SKILLUP_EFFECT_UPDATE,
            {heroId = heroVo.id, skillId = msg.present_skill_effect[1].skill_id}
        )
    end

    if (msg.type == 0) then
        local skillId = msg.present_skill_effect[1].skill_id
        local preValue = msg.present_skill_effect[1].effect_values[1].value
        local nextValue = nil
        if msg.next_skill_effect == nil or #msg.next_skill_effect == 0 then
        else
            nextValue = msg.next_skill_effect[1].effect_values[1].value
        end
        TipsFactory:skillTips(nil, skillId, heroVo, false, {preValue, nextValue})
        return
    elseif msg.type == 1 then
        --local heroVo = hero.HeroManager:getHeroVo(msg.hero_id)
        --local skillId = msg.present_skill_effect[1].skill_id
        --local skillLv = msg.present_skill_effect[1].skill_lv
        -- GameDispatcher:dispatchEvent(EventName.OPEN_GROW_SKILL_UP_PANEL,msg)
        --self:__onOpenSkillUpSucPanelHandler({heroVo = heroVo, skillId = skillId, skillLvl = skillLv})
    end
end

-- 英雄技能升级结果
function __onResHeroSkillrUpMsgHandler(self, msg)
    local result = msg.result
    local heroId = msg.hero_id
    local skillId = msg.skill_id
    local skillLvl = msg.skill_lv
    if (result <= 0) then
        gs.Message.Show("英雄技能升级失败")
    else
        -- 关闭材料界面
        if (self.m_skillUpMaterialPanel) then
            self.m_skillUpMaterialPanel:close()
        end
        -- 本地维护技能等级
        local heroVo = hero.HeroManager:getHeroVo(heroId)
        heroVo.activeSkillDic[skillId] = skillLvl

        gs.Message.Show(_TT(27030))
        -- self:__onOpenSkillUpSucPanelHandler({heroVo = heroVo, skillId = skillId, skillLvl = skillLvl})
        GameDispatcher:dispatchEvent(EventName.UPDATE_SKILL_UP_PANEL, {heroId = heroId, skillId = skillId})
    end
end

---------------------------------------------------------------请求------------------------------------------------------------------
--请求战员技能效果信息
function __onReqHeroSkillUpEffectHandler(self, args)
    SOCKET_SEND(Protocol.CS_SKILL_LV_UP_INFO, {hero_id = args.heroId, skill_id = args.skillId})
end

-- 请求英雄技能升级
function __onReqHeroSkillUpHandler(self, args)
    --- *c2s* 战员技能升级 13120
    SOCKET_SEND(
        Protocol.CS_SKILL_LV_UP,
        {hero_id = args.heroId, skill_id = args.skillId}
    )
end

------------------------------------------------------------------------ 打开英雄技能升级材料面板 ------------------------------------------------------------------------
function __onOpenSkillUpMaterialPanelHandler(self, args)
    if self.m_skillUpMaterialPanel == nil then
        self.m_skillUpMaterialPanel = hero.HeroSkillUpMaterialPanel.new()
        self.m_skillUpMaterialPanel:addEventListener(
            View.EVENT_VIEW_DESTROY,
            self.onDestroySkillUpMaterialPanelHandler,
            self
        )
    end
    if (self.m_skillUpMaterialPanel.isPop == 0) then
        self.m_skillUpMaterialPanel:open(args)
    end
end

function __onUpdateSkillUpMaterialPanelHandler(self)
    if (self.m_skillUpMaterialPanel and self.m_skillUpMaterialPanel.isPop == 1) then
        self.m_skillUpMaterialPanel:updateView()
    end
end

function onDestroySkillUpMaterialPanelHandler(self)
    self.m_skillUpMaterialPanel:removeEventListener(
        View.EVENT_VIEW_DESTROY,
        self.onDestroySkillUpMaterialPanelHandler,
        self
    )
    self.m_skillUpMaterialPanel = nil
end

------------------------------------------------------------------------ 英雄技能升级材料选择提示面板 ------------------------------------------------------------------------
function __onOpenSkillUpMaterialTipPanelHandler(self, args)
    if self.m_skillUpMaterialTipPanel == nil then
        self.m_skillUpMaterialTipPanel = hero.HeroSkillUpMaterialTipPanel.new()
        self.m_skillUpMaterialTipPanel:addEventListener(
            View.EVENT_VIEW_DESTROY,
            self.onDestroySkillUpMaterialTipPanelHandler,
            self
        )
    end
    self.m_skillUpMaterialTipPanel:open(args)
end

function onDestroySkillUpMaterialTipPanelHandler(self)
    self.m_skillUpMaterialTipPanel:removeEventListener(
        View.EVENT_VIEW_DESTROY,
        self.onDestroySkillUpMaterialTipPanelHandler,
        self
    )
    self.m_skillUpMaterialTipPanel = nil
end

------------------------------------------------------------------------ 英雄技能升级成功面板 ------------------------------------------------------------------------
function __onOpenSkillUpSucPanelHandler(self, args)
    if self.m_heroSkillUpSucPanel == nil then
        self.m_heroSkillUpSucPanel = hero.HeroSkillUpSucPanel.new()
        self.m_heroSkillUpSucPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySkillUpSucPanelHandler, self)
    end
    self.m_heroSkillUpSucPanel:open(args)
end

function onDestroySkillUpSucPanelHandler(self)
    self.m_heroSkillUpSucPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySkillUpSucPanelHandler, self)
    self.m_heroSkillUpSucPanel = nil
end

------------------------------------------------------------------------ 英雄增幅技能升级成功面板 ------------------------------------------------------------------------
function __onOpenGrowSkillUpSucPanelHandler(self, args)
    if self.m_heroGrowSkillUpSucPanel == nil then
        self.m_heroGrowSkillUpSucPanel = hero.HeroGrowSkillUpSucPanel.new()
        self.m_heroGrowSkillUpSucPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyGrowSkillUpSucPanelHandler, self)
    end
    self.m_heroGrowSkillUpSucPanel:open(args)
end

function onDestroyGrowSkillUpSucPanelHandler(self)
    self.m_heroGrowSkillUpSucPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyGrowSkillUpSucPanelHandler, self)
    self.m_heroGrowSkillUpSucPanel = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

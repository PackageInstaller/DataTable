module("hero.HeroController", Class.impl(Controller))

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
    if self.mMgr then
        for i = 1, #self.mMgr do
            if (self.mMgr[i] and self.mMgr[i].resetData) then
                self.mMgr[i]:resetData()
            end
        end
    end
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    -- 打开英雄面板
    GameDispatcher:addEventListener(EventName.OPEN_HERO_PANEL, self.__onOpenHeroPanelHandler, self)
    -- 打开英雄升格技能面板
    GameDispatcher:addEventListener(EventName.OPEN_HERO_STARSKILL_VIEW, self.onOpenStarSkillViewHandler, self)
    -- 打开英雄信息面板
    GameDispatcher:addEventListener(EventName.OPEN_HERO_INFO_PANEL, self.__onOpenHeroInfoPanelHandler, self)
    -- 打开英雄详情信息面板
    GameDispatcher:addEventListener(EventName.OPEN_HERO_DETAILS_PANEL, self.__onOpenDetailsPanelHandler, self)
    -- 打开英雄剧情信息面板
    GameDispatcher:addEventListener(EventName.OPEN_HERO_STORY_PANEL, self.__onOpenStoryPanelHandler, self)
    -- 打开技能详情信息面板
    GameDispatcher:addEventListener(EventName.OPEN_HERO_SKILL_DETAILS_PANEL, self.__onOpenSkillDetailsPanelHandler, self)
    -- 打开英雄属性列表面板
    GameDispatcher:addEventListener(EventName.OPEN_HERO_ATTR_LIST_PANEL, self.__onOpenAttrListPanelHandler, self)
    -- 打开英雄培养面板
    GameDispatcher:addEventListener(EventName.OPEN_HERO_DEVELOP_PANEL, self.__onOpenDevelopPanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_HERO_RECRUITINFOPANEL, self.onOpenHeroRecruitInfoPanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_HERO_DETAILSINFOPANEL, self.onOpenHeroDetailsInfoPanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_HERO_INTRODUCETIONPANEL, self.onOpenHeroIntroductionPanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_HERO_PARTICULARS_PANEL, self.onOpenHeroParticularsPanelHandler, self)
    -- 打开英雄职业界面
    GameDispatcher:addEventListener(EventName.OPEN_HERO_JOB_PANEL, self.__onOpenJobHandler, self)
    -- 打开英雄技能交换界面
    GameDispatcher:addEventListener(EventName.OPEN_HERO_SKILL_EDIT_PANEL, self.onOpenSkillEditHandler, self)
    -- 打开英雄碎片合成面板
    GameDispatcher:addEventListener(EventName.OPEN_HERO_FRAGMENT_COMPOSE_PANEL, self.__onOpenHeroFragmentComposePanelHandler, self)
    -- 打开英雄等级目标面板
    GameDispatcher:addEventListener(EventName.OPEN_HERO_LVL_TARGET_PANEL, self.__onOpenHeroLvlTargetPanelHandler, self)

    -- 打开英雄军衔晋升预览界面
    GameDispatcher:addEventListener(EventName.OPEN_MILITARY_RANK_PREVIEW_PANEL, self.__onOpenMilitaryRankPreviewPanelHandler, self)
    -- 打开英雄军衔材料选择界面
    GameDispatcher:addEventListener(EventName.OPEN_MILITARY_RANK_MATERIAL_PANEL, self.__onOpenMilitaryRankMaterialPanelHandler, self)
    -- 打开英雄军衔材料选择提示界面
    GameDispatcher:addEventListener(EventName.OPEN_MILITARY_RANK_MATERIAL_TIP_PANEL, self.__onOpenMilitaryRankMaterialTipPanelHandler, self)

    -- 打开英雄升品预览界面
    GameDispatcher:addEventListener(EventName.OPEN_COLOR_UP_PREVIEW_PANEL, self.__onOpenColorUpPreviewPanelHandler, self)

    -- 打开英雄升品材料选择界面
    GameDispatcher:addEventListener(EventName.OPEN_COLOR_UP_MATERIAL_PANEL, self.__onOpenColorUpMaterialPanelHandler, self)

    -- 打开英雄升品材料选择提示界面
    GameDispatcher:addEventListener(EventName.OPEN_COLOR_UP_MATERIAL_TIP_PANEL, self.__onOpenColorUpMaterialTipPanelHandler, self)

    -- 打开升品成功属性提升界面
    GameDispatcher:addEventListener(EventName.OPEN_COLOR_UP_SUC_ATT_PANEL, self.__onOpenColorUpSucPanelHandler, self)

    -- 打开英雄升星预览界面
    GameDispatcher:addEventListener(EventName.OPEN_STAR_UP_PREVIEW_PANEL, self.__onOpenStarUpPreviewPanelHandler, self)
    -- 打开英雄升星材料选择界面
    GameDispatcher:addEventListener(EventName.OPEN_STARUP_MATERIAL_PANEL, self.__onOpenStarUpMaterialPanelHandler, self)
    -- 打开英雄升星材料选择提示界面
    GameDispatcher:addEventListener(EventName.OPEN_STAR_UP_MATERIAL_TIP_PANEL, self.__onOpenStarUpMaterialTipPanelHandler, self)
    -- 打开英雄技能描述界面
    GameDispatcher:addEventListener(EventName.OPEN_HERO_SKILL_DES_PANEL, self.__onOpenHeroSkillDesPanelHandler, self)
    -- 打开英雄展示选择界面
    GameDispatcher:addEventListener(EventName.OPEN_HERO_SHOW_SELECT_PANEL, self.__onOpenHeroShowSelectPanelHandler, self)
    -- 打开发行的战员展示界面
    GameDispatcher:addEventListener(EventName.OPEN_HERO_ISSUE_SHOW_PANEL, self.__onOpenHeroIssueShowPanelHandler, self)
    -- 打开战员预览升格界面
    GameDispatcher:addEventListener(EventName.OPEN_HERO_UPGRADE_PANEL, self.onOpenHeroUpGradePanelHandler, self)
    --打开角色档案描述
    GameDispatcher:addEventListener(EventName.OPEN_HERO_DETAIL_DES_TIPS, self.onOpenDetailDesTipsHandler, self)

    -- 请求英雄详细数据
    GameDispatcher:addEventListener(EventName.REQ_HERO_DATA, self.__onReqHeroDataHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_HERO_LVL_UP, self.__onReqHeroLvlUpHandler, self)

    GameDispatcher:addEventListener(EventName.REQ_CS_RESET_HERO_LV, self.onReqCsResetHeroLvHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_CS_RESET_HERO_LV_PRE_VIEW, self.onReqCsResetHeroLvPreViewHandler, self)



    GameDispatcher:addEventListener(EventName.REQ_HERO_STAR_UP, self.__onReqHeroStarUpHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_HERO_COLOR_UP, self.__onReqHeroColorUpHandler, self)
    -- 请求英雄预览属性
    GameDispatcher:addEventListener(EventName.REQ_HERO_PREVIEW_ATTR, self.__onReqHeroPreviewAttrHandler, self)
    -- 请求英雄军阶晋升
    GameDispatcher:addEventListener(EventName.REQ_HERO_MILITARY_RANK_UP, self.__onReqHeroMilitaryRankUpHandler, self)

    GameDispatcher:addEventListener(EventName.REQ_HERO_ADD_FIGHT_SKILL, self.__onReqHeroAddFightSkillHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_HERO_DEL_FIGHT_SKILL, self.__onReqHeroDelFightSkillHandler, self)

    -- 请求英雄基础+强化+突破装备属性
    GameDispatcher:addEventListener(EventName.REQ_HERO_EQUIP_ALL_TOTAL_ATTR, self.__onReqHeroEquipAllTotalAttrHandler, self)

    -- 请求英雄锁定改变
    GameDispatcher:addEventListener(EventName.REQ_HERO_LOCK_CHANGE, self.onHeroLockHandler, self)
    -- 请求英雄喜欢
    GameDispatcher:addEventListener(EventName.REQ_HERO_LICK_CHANGE, self.__onReqHeroLikeChangeHandler, self)
    -- 请求战员增幅
    GameDispatcher:addEventListener(EventName.REQ_HERO_GROWUP, self.__onHeroGrowHandler, self)
    -- 请求战员交互属性
    -- GameDispatcher:addEventListener(EventName.REQ_HERO_INCREASE_ATTR, self.__onHeroIncreaseHandler, self)
    -- 请求战员技能信息
    GameDispatcher:addEventListener(EventName.REQ_HERO_SKILL_INFO, self.__onReqHeroSkillInfoHandler, self)
    -- 请求升星属性
    -- GameDispatcher:addEventListener(EventName.REQ_STAR_UP_ATTR, self.onReqHeroStarInfoHandler, self)
    -- 请求战员碎片合成
    GameDispatcher:addEventListener(EventName.REQ_HERO_FRAGMENT_COMPOSE, self.__onReqHeroFragmentComposeHandler, self)
    -- 请求领取战员等级奖励
    GameDispatcher:addEventListener(EventName.REQ_HERO_REC_TARGET, self.__onReqHeroRecTargetHandler, self)
    -- 请求战员初始战力
    GameDispatcher:addEventListener(EventName.REQ_HERO_INIT_POWER, self.__onReqHeroInitPowerHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_REQRESONANCE, self.__onReqHeroResonance, self)
    GameDispatcher:addEventListener(EventName.UPDATE_IS_IN_COMMITING, self._onCommintingUpdate, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 英雄预览数据 13043
        SC_HERO_PRE_LIST = self.__onResHeroPreListMsgHandler,
        --- *s2c* 英雄数据 13000
        SC_HERO_DATA = self.__onResHeroListMsgHandler,
        --- *s2c* 新增英雄数据 13001
        SC_UPDATE_HERO_LIST = self.__onResUpdateHeroMsgHandler,
        --- *s2c* 返回英雄详细数据 13011
        SC_HERO_DETAIL = self.__onResHeroDataMsgHandler,
        --- *s2c* 更新英雄属性 13003
        SC_HERO_UPDATE_ATTR = self.__onResHeroAttrListMsgHandler,
        --- *s2c* 英雄进化 13005
        SC_HERO_EVOLUTION = self.__onResHeroStarUpMsgHandler,
        --- *s2c* 英雄使用道具升级 13007
        SC_HERO_LEVELUP = self.__onResHeroLvlUpMsgHandler,
        --- *s2c* 英雄提升军阶 13013
        SC_HERO_MILITARY_RANK_UP = self.__onResHeroMilitaryRankUpMsgHandler,
        --- *s2c* 英雄升品 13099
        SC_HERO_COLOR_UPGRADE = self.__onResHeroColorUpMsgHandler,
        --- *s2c* 英雄预览属性 13025
        SC_ATTR_PREVIEW = self.__onResHeroPreviewAttrMsgHandler,
        --- *s2c* 增加出战技能 13047
        SC_ADD_FIGHT_SKILL = self.__onResHeroAddFightSkillMsgHandler,
        --- *s2c* 删除出战技能 13047
        SC_DEL_FIGHT_SKILL = self.__onResHeroDelFightSkillMsgHandler,
        --- *s2c* 更新英雄装备总属性 13080
        SC_HERO_UPDATE_EQUIP_ATTR = self.__onResHeroEquipTotalAttrMsgHandler,
        --- *s2c* 基础+强化+突破装备属性 13082
        SC_HERO_UPDATE_EQUIP_ATTR1 = self.__onResHeroEquipAllTotalAttrMsgHandler,
        --- *s2c* 更新战员int32属性 13091
        SC_HERO_UPDATE_ATTR_INT = self.onHeroAttrDataMsgHandler,
        --- *s2c* 更新战员int64属性 13092
        SC_HERO_UPDATE_ATTR_BIGINT = self.onHeroAttrDataMsgHandler,
        --- *s2c* 更新战员string属性 13093
        SC_HERO_UPDATE_ATTR_STRING = self.onHeroAttrDataMsgHandler,
        --- *s2c* 战员增幅结果
        -- SC_HERO_INCREASE = self.onHeroIncreaseMsgHandler,
        -- *s2c* 战员增幅属性结果
        SC_HERO_INCREASE_ATTR = self.onHeroIncreaseAttrMsgHandler,
        -- *s2c* 战员升星属性结果
        -- SC_HERO_EVOLUTION_ATTR = self.onHeroEvolutionAttrMsgHandler,
        --- *s2c* 战员碎片合成战员结果 13161
        SC_FRAGMENT_COMPOSE = self.onHeroFragmentComposeMsgHandler,

        --- *s2c* 已领取的战员等级奖励结果 13201
        SC_HERO_LV_REWARD = self.onResHeroLvlTargetHasRecMsgHandler,
        --- *s2c* 领取战员等级奖励结果 13203
        SC_RECEIVE_HERO_LV_REWARD = self.onResHeroLvlTargetRecMsgHandler,

        --新增的解锁看板娘道具
        SC_ADD_HERO_NEW_ACTION = self.onRecvSC_ADD_HERO_NEW_ACTION,

        --- *s2c* 所有的战员动作 13280
        SC_HERO_ACTION_LIST = self.onRecvSC_HERO_ACTION_LIST,

        -- 返回战员初始战力
        SC_HERO_INIT_POWER = self.onRecHeroInitPower,

        --- *s2c* 战员共鸣 13340
        SC_RESONANCE = self.onReceiveResonance,
        --- *s2c* 重置战员等级-前瞻 13365
        SC_RESET_HERO_LV_PRE_VIEW = self.onScResetHeroLvPreViewHandler,
        --- *s2c* 时装场景全部解锁信息 13370
        SC_FASHION_SCENE_PANEL = self.onFashionScenePanelHandler,
        --- *s2c* 解锁时装场景 13371
        SC_UNLOCK_FASHION_SCENE = self.onUnlockFashionSceneHandler,
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
function _onCommintingUpdate(self)
    hero.HeroManager:parseConfigData()
end

--- *s2c* 新增战员动作 13280
function onRecvSC_ADD_HERO_NEW_ACTION(self, msg)
    hero.HeroManager:addUnlockLiveAction(msg.model_id, msg.action_id)
    GameDispatcher:dispatchEvent(EventName.UPDATE_LIVEVIEWUPDATEACTION)
end

--初始站员解锁动作
function onRecvSC_HERO_ACTION_LIST(self, msg)
    --已解锁的看板娘动作
    for k, heroList in pairs(msg.action_list) do
        for k, v in pairs(heroList.action_list) do
            hero.HeroManager:addUnlockLiveAction(heroList.model_id, v)
        end
    end

    GameDispatcher:dispatchEvent(EventName.UPDATE_LIVEVIEWUPDATEACTION)
end


-- 返回战员初始战力
function onRecHeroInitPower(self, msg)
    GameDispatcher:dispatchEvent(EventName.UPDATE_HERO_INIT_POWER, msg)
end

function onScResetHeroLvPreViewHandler(self, msg)
    if not msg.result or msg.result == 0 then
       return 
    end
    self:onOpenHeroLvlUpResetViewHandler({
        award_list = msg.award_list,
        hero_id = msg.hero_id
    })
end

function onFashionScenePanelHandler(self,msg)
    hero.HeroManager:parseHeroSceneData(msg)
end

function onUnlockFashionSceneHandler(self,msg)
   hero.HeroManager:parseHeroSceneUnlockData(msg)
end

-- 初始英雄预览列表
function __onResHeroPreListMsgHandler(self, msg)
    hero.HeroManager:parseMsgHeroPreList(msg.hero_pre_list)
end

-- 英雄列表
function __onResHeroListMsgHandler(self, msg)
    hero.HeroManager:parseMsgHeroList(msg.hero_info)
end

-- 更新英雄列表
function __onResUpdateHeroMsgHandler(self, msg)
    hero.HeroManager:parseMsgUpdateHeroList(msg.add_hero_list, msg.del_hero_list)
end

-- 英雄详细数据更新
function __onResHeroDataMsgHandler(self, msg)
    hero.HeroManager:parseMsgHeroDataUpdate(msg.hero_info)
end

-- 英雄装备总属性数据更新
function __onResHeroEquipTotalAttrMsgHandler(self, msg)
    hero.HeroManager:parseMsgHeroEquipTotalAttrUpdate(msg)
end

-- 英雄装备全部总属性数据更新（英雄装备总属性界面专用(6芯片部位)）
function __onResHeroEquipAllTotalAttrMsgHandler(self, msg)
    hero.HeroManager:parseMsgHeroEquipAllTotalAttrUpdate(msg)
end

-- 英雄升级结果
function __onResHeroLvlUpMsgHandler(self, msg)
    local heroId = msg.id
    local result = msg.result
    if fight.FightManager:getIsFighting() then
        print('==============__onResHeroLvlUpMsgHandler 但是在fighting')
        return
    end
    if (result <= 0) then
        gs.Message.Show(_TT(29552))
    else
        local function attrUpdate(self, args)
            -- local heroVo = hero.HeroManager:getHeroVo(args.heroId)
            -- if heroVo then
            --     self:stopCurPlayCVData()
            --     self.curPlayCvData = AudioManager:playHeroCVByFieldName(heroVo.tid, "level_voice", function()
            --         self.curPlayCvData = nil
            --     end)
            -- end
            AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_upgrade.prefab"))
            hero.HeroManager:removeEventListener(hero.HeroManager.HERO_ATTR_UPDATE, attrUpdate, self)
            GameDispatcher:dispatchEvent(EventName.UPDATE_LVLUP_PANEL, {heroId = heroId})
            hero.HeroFlagManager:dispatchEvent(hero.HeroFlagManager.FLAG_UPDATE, {heroId = heroId, flagType = hero.HeroFlagManager.FLAG_TAB_LVL_UP})
        end
        -- 后端确保先发结果再发属性更新
        hero.HeroManager:addEventListener(hero.HeroManager.HERO_ATTR_UPDATE, attrUpdate, self)
    end
end

-- 英雄军阶晋升结果
function __onResHeroMilitaryRankUpMsgHandler(self, msg)
    local heroId = msg.id
    local result = msg.result
    local militaryRank = msg.military_rank
    if (result > 0) then
        local curHeroVo = hero.HeroManager:getHeroVo(heroId)
        local oldHeroVo = hero.HeroVo.new()
        oldHeroVo.id = curHeroVo.id
        oldHeroVo.tid = curHeroVo.tid
        oldHeroVo.evolutionLvl = curHeroVo.evolutionLvl
        oldHeroVo.color = curHeroVo.color
        oldHeroVo.militaryRank = curHeroVo.militaryRank
        oldHeroVo:setAttrList(curHeroVo.attrList)
        oldHeroVo.allElementDefine = curHeroVo.allElementDefine

        local function attrUpdate(self, args)
            if (args.heroId == oldHeroVo.id) then
                -- local heroVo = hero.HeroManager:getHeroVo(args.heroId)
                -- if heroVo then
                --     self:stopCurPlayCVData()
                --     self.curPlayCvData = AudioManager:playHeroCVByFieldName(heroVo.tid, "military_voice", function()
                --         self.curPlayCvData = nil
                --     end)
                -- end
                hero.HeroManager:removeEventListener(hero.HeroManager.HERO_ATTR_UPDATE, attrUpdate, self)
                GameDispatcher:dispatchEvent(EventName.UPDATE_MILITARY_RANK_PANEL, {heroId = heroId})
                local curMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(curHeroVo.tid, curHeroVo.militaryRank)
                if (curMilitaryRankVo and curMilitaryRankVo.unlockSkillId > 0) then
                    -- self:__onOpenGetNewSkillPanelHandler({ oldHeroVo = oldHeroVo, skillId = curMilitaryRankVo.unlockSkillId }, 1)
                    self:__onOpenLevelUpSucPanelHandler({oldHeroVo = oldHeroVo, type = 1, isBlur = false})
                else
                    self:__onOpenLevelUpSucPanelHandler({oldHeroVo = oldHeroVo, type = 1})
                end
                -- gs.Message.ShowHeroMsg("<size=80>晋</size> 升成功")
            end
        end
        curHeroVo:setMilitaryRankPreviewAttr(nil)
        -- 后端确保先发结果再发属性更新
        hero.HeroManager:addEventListener(hero.HeroManager.HERO_ATTR_UPDATE, attrUpdate, self)
        -- 军阶晋升成功后自己维护该字段
        hero.HeroManager:updateHeroField(curHeroVo, hero.DataFieldKey.HERO_MILITARY_RANK, militaryRank, true)
    end
end

-- 英雄升品结果
function __onResHeroColorUpMsgHandler(self, msg)
    local heroId = msg.id
    local result = msg.result
    local color = msg.color
    if (result <= 0) then
        -- gs.Message.Show("英雄升品失败")
    else
        local curHeroVo = hero.HeroManager:getHeroVo(heroId)
        local oldHeroVo = hero.HeroVo.new()
        oldHeroVo.id = curHeroVo.id
        oldHeroVo.tid = curHeroVo.tid
        oldHeroVo.color = curHeroVo.color
        oldHeroVo.militaryRank = curHeroVo.militaryRank
        oldHeroVo:setAttrList(curHeroVo.attrList)

        local function attrUpdate(self, args)
            if (args.heroId == oldHeroVo.id) then
                hero.HeroManager:removeEventListener(hero.HeroManager.HERO_ATTR_UPDATE, attrUpdate, self)
                GameDispatcher:dispatchEvent(EventName.UPDATE_COLOR_UP_PANEL, {heroId = heroId})

                local curColorUpConfigVo = hero.HeroColorUpManager:getHeroColorUpConfigVo(curHeroVo.tid, curHeroVo.color)
                if (curColorUpConfigVo and curColorUpConfigVo.skillId > 0) then
                    -- GameDispatcher:dispatchEvent(EventName.OPEN_SUC_ATT_PANEL, {oldHeroVo = oldHeroVo})
                    self:__onOpenGetNewSkillPanelHandler({oldHeroVo = oldHeroVo, skillId = curColorUpConfigVo.skillId})
                else
                    -- GameDispatcher:dispatchEvent(EventName.OPEN_COLOR_UP_SUC_ATT_PANEL, {oldHeroVo = oldHeroVo})
                end
                gs.Message.Show("英雄升品到" .. color .. "成功")
            end
        end
        -- 后端确保先发结果再发属性更新
        hero.HeroManager:addEventListener(hero.HeroManager.HERO_ATTR_UPDATE, attrUpdate, self)
        -- 英雄升品成功后自己维护该字段
        hero.HeroManager:updateHeroField(curHeroVo, hero.DataFieldKey.HERO_COLOR, color, true)
    end
end

-- 英雄升星进化结果
function __onResHeroStarUpMsgHandler(self, msg)
    local heroId = msg.id
    local result = msg.result
    local starLvl = msg.evolution
    -- local clolor = msg.color
    if (result <= 0) then
        gs.Message.Show("英雄升星失败")
    else
        local curHeroVo = hero.HeroManager:getHeroVo(heroId)
        local oldHeroVo = hero.HeroVo.new()
        oldHeroVo.id = curHeroVo.id
        oldHeroVo.tid = curHeroVo.tid
        oldHeroVo.evolutionLvl = curHeroVo.evolutionLvl
        -- oldHeroVo.color = curHeroVo.color
        oldHeroVo.militaryRank = curHeroVo.militaryRank
        oldHeroVo:setAttrList(curHeroVo.attrList)
        oldHeroVo.allElementDefine = curHeroVo.allElementDefine
        local function attrUpdate(self, args)
            if (args.heroId == oldHeroVo.id) then
                -- local heroVo = hero.HeroManager:getHeroVo(args.heroId)
                -- if heroVo then
                --     self:stopCurPlayCVData()
                --     self.curPlayCvData = AudioManager:playHeroCVByFieldName(heroVo.tid, "star_voice", function()
                --         self.curPlayCvData = nil
                --     end)
                -- end
                hero.HeroManager:removeEventListener(hero.HeroManager.HERO_ATTR_UPDATE, attrUpdate, self)
                LoopManager:setTimeout(0.8, nil, function()
                    --GameDispatcher:dispatchEvent(EventName.UPDATE_STARUP_PANEL, { heroId = heroId })
                    local curStarConfigVo = hero.HeroStarManager:getHeroStarConfigVo(curHeroVo.tid, curHeroVo.evolutionLvl)
                    if (curStarConfigVo and curStarConfigVo.passiveSkillId > 0) then
                        -- self:__onOpenGetNewSkillPanelHandler({ oldHeroVo = oldHeroVo, skillId = curStarConfigVo.passiveSkillId }, 2)
                        self:__onOpeStarUpShowOneViewnHandler({tid = curHeroVo.tid}) --,isNoSkip = true
                        self:__onOpenLevelUpSucPanelHandler({oldHeroVo = oldHeroVo, type = 2, isBlur = false})
                    else
                        self:__onOpenLevelUpSucPanelHandler({oldHeroVo = oldHeroVo, type = 2})
                    end
                end)

                -- gs.Message.ShowHeroMsg("<size=80>进</size> 化成功")
            end
        end
        -- 后端确保先发结果再发属性更新
        hero.HeroManager:addEventListener(hero.HeroManager.HERO_ATTR_UPDATE, attrUpdate, self)
        -- 升星成功后自己维护星级字段
        hero.HeroManager:updateHeroField(curHeroVo, hero.DataFieldKey.HERO_EVOLUTION_LVL, starLvl, true)
        -- 升星成功后自己维护品质字段
        -- hero.HeroManager:updateHeroField(curHeroVo, hero.DataFieldKey.HERO_COLOR, clolor, true)
    end
end

-- 英雄预览属性返回(1：军阶
function __onResHeroPreviewAttrMsgHandler(self, msg)
    if self.ReqHeroPreviewAttrHeroId_list then
        self.ReqHeroPreviewAttrHeroId_list[msg.hero_id] = nil
    end

    local previewType = msg.module_id
    local heroVo = hero.HeroManager:getHeroVo(msg.hero_id)
    if (previewType == hero.PreviewAttrType.MILITARY_RANK) then
        heroVo:setMilitaryRankPreviewAttr(msg.attr_preview)
    elseif (previewType == hero.PreviewAttrType.STAR_UP) then
        heroVo:setStarUpPreviewAttr(msg.attr_preview, msg.param_int)
    elseif (previewType == hero.PreviewAttrType.COLOR_UP) then
        heroVo:setColorUpPreviewAttr(msg.attr_preview)
    elseif (previewType == hero.PreviewAttrType.FAVORABLE) then
        heroVo:setFavorablePreviewAttr(msg.attr_preview)
    end
end

-- 更新英雄属性列表
function __onResHeroAttrListMsgHandler(self, msg)
    hero.HeroManager:parseMsgHeroAttrList(msg.id, msg.attr_list)
end

--- 更新增加出战技能 13047
function __onResHeroAddFightSkillMsgHandler(self, msg)
    hero.HeroManager:parseMsgHeroAddFightSkill(msg)
end

--- 更新删除出战技能 13047
function __onResHeroDelFightSkillMsgHandler(self, msg)
    hero.HeroManager:parseMsgHeroDelFightSkill(msg)
end

-- 更新英雄属性数据
function onHeroAttrDataMsgHandler(self, msg)
    if (not msg) then
        return
    end
    hero.HeroManager:parseMsgHeroFieldValue(msg.id, msg.attr_list)
end

-- 英雄增幅结果
-- function onHeroIncreaseMsgHandler(self, msg)
--     if (msg.result == 1) then
--         GameDispatcher:dispatchEvent(EventName.UPDATE_HERO_GROW_TABVIEW)
--     end
-- end

-- 获得的战员字段
function onHeroIncreaseAttrMsgHandler(self, msg)
    GameDispatcher:dispatchEvent(EventName.UPDATE_HERO_GROW_ATTR, msg)
end

-- *s2c* 获得的战员升星字段 19119
-- function onHeroEvolutionAttrMsgHandler(self, msg)
--     GameDispatcher:dispatchEvent(EventName.UPDATE_EVOLUTION_ATTR, msg)
-- end

-- 战员碎片合成结果
function onHeroFragmentComposeMsgHandler(self, msg)
    if (msg.result == 1) then
        GameDispatcher:dispatchEvent(EventName.HERO_DETAIL_CLOSE)
        hero.HeroShowManager:setIsMess(true)
        hero.HeroManager:setAllSortList()
        -- GameDispatcher:dispatchEvent(EventName.HERO_DATA_UPDATE)
        local resultVo = {tid = msg.hero_tid, item_list = {}}
        hero.HeroShowManager:setShowGainHeroList({resultVo})
        -- hero.HeroShowManager:setAllFinishCall(function() nil end)
        GameDispatcher:dispatchEvent(EventName.CHECK_HERO_GAIN_SHOW)
    else
        gs.Message.Show("集结失败")
    end
end

--- *s2c* 已领取的战员等级奖励结果 13201
function onResHeroLvlTargetHasRecMsgHandler(self, msg)
    hero.HeroLvlTargetManager:parseRecTargetAwardList(msg.lv_reward_list)
end

--- *s2c* 领取战员等级奖励结果 13203
function onResHeroLvlTargetRecMsgHandler(self, msg)
    if (msg.result == 1) then
        hero.HeroLvlTargetManager:parseRecTargetAward(msg.hero_tid, msg.id, true)
        local targetConfigVo = hero.HeroLvlTargetManager:getLvlTargetConfigVo(msg.hero_tid, msg.id)
        ShowAwardPanel:showAwardId(targetConfigVo.awardId)
    else
        gs.Message.Show(_TT(53505)) --"领取失败"
    end
end

--- *s2c* 战员共鸣 13340
function onReceiveResonance(self, msg)
    logAll(msg, "*s2c* 战员共鸣 13340")
    if msg.result == 0 then
        gs.Message.Show(_TT(62209))
        return
    elseif msg.result == 1 then
        gs.Message.Show(_TT(110004))
    end
    GameDispatcher:dispatchEvent(EventName.HERO_RESONANCE_SERVER, msg.hero_id)
end

---------------------------------------------------------------请求------------------------------------------------------------------
--- *c2s* 战员共鸣 13339
function __onReqHeroResonance(self, args)
    logAll({hero_id = args.heroId, pos = args.pos}, "*c2s* 战员共鸣 13339")
    SOCKET_SEND(Protocol.CS_RESONANCE, {hero_id = args.heroId, pos = args.pos}, Protocol.SC_RESONANCE)
end

-- 请求英雄详细数据
function __onReqHeroDataHandler(self, args)
    local heroId = args.heroId
    --- *c2s* 请求英雄详细数据 13010
    SOCKET_SEND(Protocol.CS_HERO_DETAIL, {id = heroId}, Protocol.SC_HERO_DETAIL)
end

-- 请求英雄升级
function __onReqHeroLvlUpHandler(self, args)
    local heroId = args.heroId
    -- local itemList = {}
    -- for i = 1, #args.list do
    --     table.insert(itemList, { item_id = args.list[i].key, num = args.list[i].value })
    -- end
    --- *c2s* 英雄使用道具升级 13006
    SOCKET_SEND(Protocol.CS_HERO_LEVELUP, {id = heroId, level = args.level}, Protocol.SC_HERO_LEVELUP)
end

function onReqCsResetHeroLvHandler(self,args)
    SOCKET_SEND(Protocol.CS_RESET_HERO_LV, {hero_id = args.hero_id})
end

function onReqCsResetHeroLvPreViewHandler(self, args)
    --- *c2s* 重置战员等级-前瞻 13364
    SOCKET_SEND(Protocol.CS_RESET_HERO_LV_PRE_VIEW, {hero_id = args.hero_id}, Protocol.SC_RESET_HERO_LV_PRE_VIEW)
end

-- 请求英雄升星进化
function __onReqHeroStarUpHandler(self, args)
    if (self.m_starUpMaterialPanel) then
        self.m_starUpMaterialPanel:close()
    end
    --- *c2s* 英雄进化 13004
    SOCKET_SEND(Protocol.CS_HERO_EVOLUTION, {id = args.heroId}, Protocol.SC_HERO_EVOLUTION)
end

-- 请求英雄升品
function __onReqHeroColorUpHandler(self, args)
    if (self.m_colorUpMaterialPanel) then
        self.m_colorUpMaterialPanel:close()
    end
    --- *c2s* 战员提升品质 13098
    SOCKET_SEND(Protocol.CS_HERO_COLOR_UPGRADE, {id = args.heroId, cost_id = args.costHeroIdList}, Protocol.SC_HERO_COLOR_UPGRADE)
end

-- 请求英雄的预览属性
function __onReqHeroPreviewAttrHandler(self, args)
    if not self.ReqHeroPreviewAttrHeroId_list then
        self.ReqHeroPreviewAttrHeroId_list = {}
    end
    if self.ReqHeroPreviewAttrHeroId_list[args.heroId] then
        return
    end
    self.ReqHeroPreviewAttrHeroId_list[args.heroId] = 1
    --- *c2s* 预览属性 13024
    SOCKET_SEND(Protocol.CS_ATTR_PREVIEW, {hero_id = args.heroId, module_id = args.previewType}, Protocol.SC_ATTR_PREVIEW)
end

-- 请求英雄军衔升级
function __onReqHeroMilitaryRankUpHandler(self, args)
    if (self.m_militaryRankMaterialPanel) then
        self.m_militaryRankMaterialPanel:close()
    end
    --- *c2s* 英雄提升军阶 13013
    SOCKET_SEND(Protocol.CS_HERO_MILITARY_RANK_UP, {id = args.heroId, cost_id = args.costHeroIdList}, Protocol.SC_HERO_MILITARY_RANK_UP)
end

-- 请求英雄增加出站技能
function __onReqHeroAddFightSkillHandler(self, args)
    --- *c2s* 增加出战技能
    SOCKET_SEND(Protocol.CS_ADD_FIGHT_SKILL, {hero_id = args.heroId, skill_id = args.skillId, pos = args.skillPos})
end

-- 请求英雄删除出站技能
function __onReqHeroDelFightSkillHandler(self, args)
    --- *c2s* 增加出战技能
    SOCKET_SEND(Protocol.CS_DEL_FIGHT_SKILL, {hero_id = args.heroId, skill_id = args.skillId})
end

--- 请求英雄全部装备属性
function __onReqHeroEquipAllTotalAttrHandler(self, args)
    SOCKET_SEND(Protocol.CS_HERO_UPDATE_EQUIP_ATTR1, {id = args.heroId}, Protocol.SC_HERO_UPDATE_EQUIP_ATTR1)
end

-- 请求英雄锁状态改变
function onHeroLockHandler(self, args)
    local heroId = args.heroId
    local isLock = args.isLock
    local isShowMessage = args.isShowMessage == nil and true or args.isShowMessage
    if isLock == 1 then
        SOCKET_SEND(Protocol.CS_LOCK_HERO, {id = heroId})
        if isShowMessage then
            gs.Message.Show(_TT(4056))
        end
    else
        SOCKET_SEND(Protocol.CS_UNLOCK_HERO, {id = heroId})
        if isShowMessage then
            gs.Message.Show(_TT(4057))
        end
    end

    GameDispatcher:dispatchEvent(EventName.REQ_CANNOTDEL_HERO_DATA)
end

-- 请求英雄喜欢状态改变
function __onReqHeroLikeChangeHandler(self, args)
    local heroId = args.heroId
    local isLike = args.isLike
    local isShowMessage = args.isShowMessage == nil and true or args.isShowMessage
    if isLike == 1 then
        SOCKET_SEND(Protocol.CS_LIKE_HERO, {id = heroId})
        if (isShowMessage) then
            gs.Message.Show("设置喜欢成功")
        end
    else
        SOCKET_SEND(Protocol.CS_UNLIKE_HERO, {id = heroId})
        if (isShowMessage) then
            gs.Message.Show("解除喜欢成功")
        end
    end
    GameDispatcher:dispatchEvent(EventName.REQ_CANNOTDEL_HERO_DATA)
end

--请求战员增幅
function __onHeroGrowHandler(self, args)
    SOCKET_SEND(Protocol.CS_HERO_INCREASE, {hero_id = args.id})
end

--请求战员增幅属性
-- function __onHeroIncreaseHandler(self, args)
--     SOCKET_SEND(Protocol.CS_HERO_INCREASE_ATTR, { hero_id = args.heroId })
-- end

--请求战员升星属性
-- function onReqHeroStarInfoHandler(self, args)
-- SOCKET_SEND(Protocol.CS_HERO_EVOLUTION_ATTR, { hero_id = args.heroId })
-- end

--请求战员技能信息
function __onReqHeroSkillInfoHandler(self, args)
    SOCKET_SEND(Protocol.CS_NORMAL_SKILL_LV_UP, {hero_id = args.heroId, skill_id = args.skillId})
end

--请求战员碎片合成
function __onReqHeroFragmentComposeHandler(self, args)
    --- *c2s* 战员碎片合成战员 13160
    SOCKET_SEND(Protocol.CS_FRAGMENT_COMPOSE, {hero_tid = args.heroTid})
end

--请求领取战员等级奖励
function __onReqHeroRecTargetHandler(self, args)
    --- *c2s* 领取战员等级奖励 13202
    SOCKET_SEND(Protocol.CS_RECEIVE_HERO_LV_REWARD, {hero_tid = args.heroTid, id = args.targetId})
end

--请求战员初始战力
function __onReqHeroInitPowerHandler(self, args)
    --- *c2s* 战员初始战力 13162
    SOCKET_SEND(Protocol.CS_HERO_INIT_POWER, {hero_tid = args.heroTid})
end


--打开英雄重置等级弹窗
function onOpenHeroLvlUpResetViewHandler(self, args)
    local destroyView = function()
        self.mHeroLvlUpResetView:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.mHeroLvlUpResetView = nil
    end
    if self.mHeroLvlUpResetView == nil then
        self.mHeroLvlUpResetView = hero.HeroLvlUpResetView.new()
        self.mHeroLvlUpResetView:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end
    self.mHeroLvlUpResetView:open(args)

    return self.mHeroLvlUpResetView
end













------------------------------------------------------------------------ 英雄面板 ------------------------------------------------------------------------
function __onOpenHeroPanelHandler(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO, true) == false then
        return
    end

    local heroId = nil
    if (args) then
        heroId = args.heroId
    end
    -- local function _updateResProgressBar(self, current, total)
    --     if(current >= total)then
    if self.m_heroPanel == nil then
        self.m_heroPanel = hero.HeroPanel.new()
        self.m_heroPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroPanelHandler, self)
    end
    self.m_heroPanel:open(heroId)
    --     end
    -- end
    -- AssetLoader.PreLoadListAsyn01({"ui_main_10"}, _updateResProgressBar, self)
end

function onDestroyHeroPanelHandler(self)
    self.m_heroPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroPanelHandler, self)
    self.m_heroPanel = nil
end

------------------------------------------------------------------------ 英雄面板 ------------------------------------------------------------------------
function __onOpenHeroInfoPanelHandler(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO, true) == false then
        return
    end

    if self.m_heroInfoPanel == nil then
        self.m_heroInfoPanel = hero.HeroInfoPanel.new()
        self.m_heroInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroInfoPanelHandler, self)
    end

    local heroId = nil
    if (args) then
        heroId = args.heroId and args.heroId or hero.HeroManager:getFirstHeroId()
    end
    self.m_heroInfoPanel:open(heroId)
end

function onDestroyHeroInfoPanelHandler(self)
    self.m_heroInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroInfoPanelHandler, self)
    self.m_heroInfoPanel = nil
end

------------------------------------------------------------------------ 英雄详情面板 ------------------------------------------------------------------------
function __onOpenDetailsPanelHandler(self, args)
    if not args.type then
        args.type = favorable.FavorableConst.HERO_FILE_CASE
    end
    if self.m_heroDetailsPanel == nil then
        self.m_heroDetailsPanel = hero.HeroDetailPanel.new()
        self.m_heroDetailsPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDetailsPanelHandler, self)
    end
    self.m_heroDetailsPanel:open(args)

end

function onDestroyDetailsPanelHandler(self)
    self.m_heroDetailsPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDetailsPanelHandler, self)
    self.m_heroDetailsPanel = nil
end


------------------------------------------------------------------------ 英雄剧情面板 ------------------------------------------------------------------------

function __onOpenStoryPanelHandler(self,args)
    if not args.type then
        args.type = favorable.FavorableConst.HERO_STORY
    end
    if self.m_heroStoryPanel == nil then
        self.m_heroStoryPanel = hero.HeroStoryPanel.new()
        self.m_heroStoryPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStoryPanelHandler, self)
    end
    self.m_heroStoryPanel:open(args)
end

function onDestroyStoryPanelHandler(self)
    self.m_heroStoryPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStoryPanelHandler, self)
    self.m_heroStoryPanel = nil
end

------------------------------------------------------------------------ 英雄详情描述TIPS ------------------------------------------------------------------------
function onOpenDetailDesTipsHandler(self, args)
    if self.mHeroDetailDesTips == nil then
        self.mHeroDetailDesTips = hero.HeroDetailDesTips.new()
        self.mHeroDetailDesTips:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDetailDesTipsHandler, self)
    end
    if self.mHeroDetailDesTips.isPop == 1 then
        self.mHeroDetailDesTips:updateView(args)
        return
    end
    self.mHeroDetailDesTips:open(args)
end

function onDestroyDetailDesTipsHandler(self)
    self.mHeroDetailDesTips:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDetailDesTipsHandler, self)
    self.mHeroDetailDesTips = nil
end

------------------------------------------------------------------------ 技能详情面板 ------------------------------------------------------------------------
function __onOpenSkillDetailsPanelHandler(self, args)
    if self.m_heroSkillDetailsPanel == nil then
        self.m_heroSkillDetailsPanel = hero.HeroSkillDetailSubTabView.new()
        self.m_heroSkillDetailsPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySkillDetailsPanelHandler, self)
    end
    self.m_heroSkillDetailsPanel:open(args)
end

function onDestroySkillDetailsPanelHandler(self)
    self.m_heroSkillDetailsPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySkillDetailsPanelHandler, self)
    self.m_heroSkillDetailsPanel = nil
end

------------------------------------------------------------------------ 英雄属性列表面板 ------------------------------------------------------------------------
function __onOpenAttrListPanelHandler(self, args)
    if self.m_heroAttrListPanel == nil then
        self.m_heroAttrListPanel = hero.HeroAttrListPanel.new()
        self.m_heroAttrListPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyAttrListPanelHandler, self)
    end
    if (args and args.heroVo) then
        self.m_heroAttrListPanel:open(args.heroVo)
    end
end

function onDestroyAttrListPanelHandler(self)
    self.m_heroAttrListPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDetailsPanelHandler, self)
    self.m_heroAttrListPanel = nil
end

------------------------------------------------------------------------ 英雄升格技能列表面板 ------------------------------------------------------------------------
function onOpenStarSkillViewHandler(self, args)
    if self.mStarSkillView == nil then
        self.mStarSkillView = hero.HeroStarSkillView.new()
        self.mStarSkillView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStarSkillViewHandler, self)
    end
    if (args) then
        self.mStarSkillView:open(args)
    end
end

function onDestroyStarSkillViewHandler(self)
    self.mStarSkillView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStarSkillViewHandler, self)
    self.mStarSkillView = nil
end

------------------------------------------------------------------------ 英雄详情面板 ------------------------------------------------------------------------
function __onOpenHeroDetailsInfoPanelHandler(self, args)
    if self.m_HeroDetailsInfoPanel == nil then
        self.m_HeroDetailsInfoPanel = hero.HeroDetailsInfoPanel.new()
        self.m_HeroDetailsInfoPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroDetailsInfoPanelHandler, self)
    end
    self.m_HeroDetailsInfoPanel:open(args)
end

function onDestroyHeroDetailsInfoPanelHandler(self)
    self.m_HeroDetailsInfoPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDevelopPanelHandler, self)
    self.m_HeroDetailsInfoPanel = nil
end
------------------------------------------------------------------------ 英雄详情面板 ------------------------------------------------------------------------
-- 这两个统一走LinkController回来打开
function onOpenHeroRecruitInfoPanelHandler(self, args)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.HeroPreview, param = args})
end
function onOpenHeroDetailsInfoPanelHandler(self, args)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.HeroPreview, param = args})
end

-- 打开介绍预览界面
function onOpenHeroIntroductionPanelHandler(self, args)
    if self.mHeroIntroductionPanel == nil then
        self.mHeroIntroductionPanel = hero.HeroIntroductionPanel.new()
        self.mHeroIntroductionPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroIntroductionPanelHandler, self)
    end
    self.mHeroIntroductionPanel:open(args)
end

function onDestroyHeroIntroductionPanelHandler(self)
    self.mHeroIntroductionPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroIntroductionPanelHandler, self)
    self.mHeroIntroductionPanel = nil
end
------------------------------------------------------------------------ 英雄简介界面 ------------------------------------------------------------------------

function onOpenHeroParticularsPanelHandler(self, args)
    if self.mHeroParticularsPanel == nil then
        self.mHeroParticularsPanel = hero.HeroParticularsPanel.new()
        self.mHeroParticularsPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroParticularsPanelHandler, self)
    end
    self.mHeroParticularsPanel:open(args)
end

function onDestroyHeroParticularsPanelHandler(self)
    self.mHeroParticularsPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroParticularsPanelHandler, self)
    self.mHeroParticularsPanel = nil
end

------------------------------------------------------------------------ 英雄升格预览界面 ------------------------------------------------------------------------

function onOpenHeroUpGradePanelHandler(self, args)
    if self.mHeroUpGradePanel == nil then
        self.mHeroUpGradePanel = hero.HeroUpGradePanel.new()
        self.mHeroUpGradePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroUpGradePanelHandler, self)
    end
    self.mHeroUpGradePanel:open(args)
end

function onDestroyHeroUpGradePanelHandler(self)
    self.mHeroUpGradePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroUpGradePanelHandler, self)
    self.mHeroUpGradePanel = nil
end

------------------------------------------------------------------------ 英雄培养面板 ------------------------------------------------------------------------
function __onOpenDevelopPanelHandler(self, args)
    local funId = funcopen.FuncOpenConst.FUNC_ID_HERO_CULTURE
    if (funcopen.FuncOpenManager:isOpen(funId, true) == false) then
        return
    end
    local heroId = nil
    local tabType = nil
    if (args) then
        heroId = args.heroId and args.heroId or hero.HeroManager:getFirstHeroId()
        tabType = args.tabType and args.tabType or hero.DevelopTabType.LVL_UP
    end
    if (tabType == hero.DevelopTabType.LVL_UP) then
        funId = funcopen.FuncOpenConst.FUNC_ID_HERO_LV_UP
    elseif (tabType == hero.DevelopTabType.COLOR_UP) then
        funId = funcopen.FuncOpenConst.FUNC_ID_HERO_COLOR_UP
    elseif (tabType == hero.DevelopTabType.SKILL) then
        funId = funcopen.FuncOpenConst.FUNC_ID_HERO_SKILL
    elseif (tabType == hero.DevelopTabType.STAR_UP) then
        funId = funcopen.FuncOpenConst.FUNC_ID_HERO_STAR
    elseif (tabType == hero.DevelopTabType.ASSIST) then
        funId = funcopen.FuncOpenConst.FUNC_ID_HERO_ASSIST
    elseif (tabType == hero.DevelopTabType.GROW) then
        funId = funcopen.FuncOpenConst.FUNC_ID_HERO_GROW
    end
    if (funcopen.FuncOpenManager:isOpen(funId, true) == false) then
        return
    end

    if self.m_heroDevelopPanel == nil then
        self.m_heroDevelopPanel = hero.HeroDevelopPanel.new()
        self.m_heroDevelopPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDevelopPanelHandler, self)
    end
    if (self.m_heroDevelopPanel.isPop == 1) then
        self.m_heroDevelopPanel:onClickClose()
        self.m_heroDevelopPanel:open({heroId = heroId, tabType = tabType, subData = args.subData, teamId = args.teamId, isPrepare = args.isPrepare})
    end
    self.m_heroDevelopPanel:open({heroId = heroId, tabType = tabType, subData = args.subData, teamId = args.teamId, isPrepare = args.isPrepare})
end

function onDestroyDevelopPanelHandler(self)
    self.m_heroDevelopPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDevelopPanelHandler, self)
    self.m_heroDevelopPanel = nil
end

------------------------------------------------------------------------ 英雄职业面板 ------------------------------------------------------------------------
function __onOpenJobHandler(self, args)
    if self.mJobPanel == nil then
        self.mJobPanel = hero.HeroJobPanel.new()
        self.mJobPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyJobPanelHandler, self)
    end
    local heroVo = args.heroVo
    self.mJobPanel:open(heroVo)
end

function onDestroyJobPanelHandler(self)
    self.mJobPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyJobPanelHandler, self)
    self.mJobPanel = nil
end

------------------------------------------------------------------------ 英雄技能编辑面板 ------------------------------------------------------------------------
function onOpenSkillEditHandler(self, args)
    if self.mSkillEditPanel == nil then
        self.mSkillEditPanel = hero.HeroSkillEditPanel.new()
        self.mSkillEditPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySkillEditPanelHandler, self)
    end
    self.mSkillEditPanel:open(args)
end

function onDestroySkillEditPanelHandler(self)
    self.mSkillEditPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySkillEditPanelHandler, self)
    self.mSkillEditPanel = nil
end

------------------------------------------------------------------------ 英雄升品预览面板 ------------------------------------------------------------------------
function __onOpenColorUpPreviewPanelHandler(self, args)
    if self.m_colorUpPreviewPanel == nil then
        self.m_colorUpPreviewPanel = hero.HeroColorUpPreviewPanel.new()
        self.m_colorUpPreviewPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyColorUpPreviewPanelHandler, self)
    end
    local heroVo = args.heroVo
    self.m_colorUpPreviewPanel:open(heroVo)
end

function onDestroyColorUpPreviewPanelHandler(self)
    self.m_colorUpPreviewPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyColorUpPreviewPanelHandler, self)
    self.m_colorUpPreviewPanel = nil
end

------------------------------------------------------------------------ 英雄升品材料选择面板 ------------------------------------------------------------------------
function __onOpenColorUpMaterialPanelHandler(self, args)
    if self.m_colorUpMaterialPanel == nil then
        self.m_colorUpMaterialPanel = hero.HeroColorUpMaterialPanel.new()
        self.m_colorUpMaterialPanel:addEventListener(
            View.EVENT_VIEW_DESTROY,
            self.onDestroyColorUpMaterialPanelHandler,
            self
        )
    end
    local heroVo = args.heroVo
    self.m_colorUpMaterialPanel:open(heroVo)
end

function onDestroyColorUpMaterialPanelHandler(self)
    self.m_colorUpMaterialPanel:removeEventListener(
        View.EVENT_VIEW_DESTROY,
        self.onDestroyColorUpMaterialPanelHandler,
        self
    )
    self.m_colorUpMaterialPanel = nil
end

------------------------------------------------------------------------ 英雄升品材料选择提示面板 ------------------------------------------------------------------------
function __onOpenColorUpMaterialTipPanelHandler(self, args)
    if self.m_colorUpMaterialTipPanel == nil then
        self.m_colorUpMaterialTipPanel = hero.HeroColorUpMaterialTipPanel.new()
        self.m_colorUpMaterialTipPanel:addEventListener(
            View.EVENT_VIEW_DESTROY,
            self.onDestroyColorUpMaterialTipPanelHandler,
            self
        )
    end
    local heroId = args.heroId
    self.m_colorUpMaterialTipPanel:open(heroId)
end

function onDestroyColorUpMaterialTipPanelHandler(self)
    self.m_colorUpMaterialTipPanel:removeEventListener(
        View.EVENT_VIEW_DESTROY,
        self.onDestroyColorUpMaterialTipPanelHandler,
        self
    )
    self.m_colorUpMaterialTipPanel = nil
end

------------------------------------------------------------------------ 英雄升品成功面板 ------------------------------------------------------------------------
function __onOpenGetNewSkillPanelHandler(self, args, type)
    local oldHeroVo = args.oldHeroVo
    local curHeroVo = hero.HeroManager:getHeroVo(oldHeroVo.id)
    local skillId = args.skillId

    if self.m_HeroGetNewSkillPanel == nil then
        self.m_HeroGetNewSkillPanel = hero.HeroGetNewSkillPanel.new()
        self.m_HeroGetNewSkillPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyGetNewPanelHandler, self)
    end
    self.m_HeroGetNewSkillPanel:open({oldHeroVo = oldHeroVo, curHeroVo = curHeroVo, skillId = skillId})
    if (type == 1) then --军阶
        self.m_HeroGetNewSkillPanel:setMilitary()
    elseif (type == 2) then --进化
        self.m_HeroGetNewSkillPanel:setStarUp()
    end
end

function onDestroyGetNewPanelHandler(self)
    self.m_HeroGetNewSkillPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyGetNewPanelHandler, self)
    self.m_HeroGetNewSkillPanel = nil
end

-- 打开升品成功界面
function __onOpenColorUpSucPanelHandler(self, args)
    local oldHeroVo = args.oldHeroVo
    local curHeroVo = hero.HeroManager:getHeroVo(oldHeroVo.id)

    if self.m_heroColorUpSucPanel == nil then
        self.m_heroColorUpSucPanel = hero.HeroColorUpSucPanel.new()
        self.m_heroColorUpSucPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyColorUpSucPanelHandler, self)
    end
    self.m_heroColorUpSucPanel:open({oldHeroVo = oldHeroVo, curHeroVo = curHeroVo})
end

function onDestroyColorUpSucPanelHandler(self)
    self.m_heroColorUpSucPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyColorUpSucPanelHandler, self)
    self.m_heroColorUpSucPanel = nil
end

------------------------------------------------------------------------ 英雄升星预览面板 ------------------------------------------------------------------------
function __onOpenStarUpPreviewPanelHandler(self, args)
    if self.m_starUpPreviewPanel == nil then
        self.m_starUpPreviewPanel = hero.HeroStarUpPreviewPanel.new()
        self.m_starUpPreviewPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStarUpPreviewPanelHandler, self)
    end
    local heroVo = args.heroVo
    self.m_starUpPreviewPanel:open(heroVo)
end

function onDestroyStarUpPreviewPanelHandler(self)
    self.m_starUpPreviewPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStarUpPreviewPanelHandler, self)
    self.m_starUpPreviewPanel = nil
end

------------------------------------------------------------------------ 英雄升星材料选择面板 ------------------------------------------------------------------------
function __onOpenStarUpMaterialPanelHandler(self, args)
    if self.m_starUpMaterialPanel == nil then
        self.m_starUpMaterialPanel = hero.HeroStarUpMaterialPanel.new()
        self.m_starUpMaterialPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStarUpMaterialPanelHandler, self)
    end
    local heroVo = args.heroVo
    self.m_starUpMaterialPanel:open(heroVo)
end

function onDestroyStarUpMaterialPanelHandler(self)
    self.m_starUpMaterialPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStarUpMaterialPanelHandler, self)
    self.m_starUpMaterialPanel = nil
end

------------------------------------------------------------------------ 英雄升星材料选择提示面板 ------------------------------------------------------------------------
function __onOpenStarUpMaterialTipPanelHandler(self, args)
    if self.m_starUpMaterialTipPanel == nil then
        self.m_starUpMaterialTipPanel = hero.HeroStarUpMaterialTipPanel.new()
        self.m_starUpMaterialTipPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStarUpMaterialTipPanelHandler, self)
    end
    local heroId = args.heroId
    self.m_starUpMaterialTipPanel:open(heroId)
end

function onDestroyStarUpMaterialTipPanelHandler(self)
    self.m_starUpMaterialTipPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStarUpMaterialTipPanelHandler, self)
    self.m_starUpMaterialTipPanel = nil
end

------------------------------------------------------------------------ 英雄升星成功弹窗 ------------------------------------------------------------------------
function __onOpeStarUpShowOneViewnHandler(self, args)
    if self.m_starUpShowOneView == nil then
        self.m_starUpShowOneView = hero.HeroStarUpShowOneView.new()
        self.m_starUpShowOneView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStarUpShowOneViewHandler, self)
    end

    self.m_starUpShowOneView:open(args)
end

function onDestroyStarUpShowOneViewHandler(self)
    self.m_starUpShowOneView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStarUpShowOneViewHandler, self)
    self.m_starUpShowOneView = nil
end

------------------------------------------------------------------------ 英雄军衔预览面板 ------------------------------------------------------------------------
function __onOpenMilitaryRankPreviewPanelHandler(self, args)
    if self.m_militaryRankPreviewPanel == nil then
        self.m_militaryRankPreviewPanel = hero.HeroMilitaryRankPreviewPanel.new()
        self.m_militaryRankPreviewPanel:addEventListener(
            View.EVENT_VIEW_DESTROY,
            self.onDestroyMilitaryRankPreviewPanelHandler,
            self
        )
    end
    local heroVo = args.heroVo
    self.m_militaryRankPreviewPanel:open(heroVo)
end

function onDestroyMilitaryRankPreviewPanelHandler(self)
    self.m_militaryRankPreviewPanel:removeEventListener(
        View.EVENT_VIEW_DESTROY,
        self.onDestroyMilitaryRankPreviewPanelHandler,
        self
    )
    self.m_militaryRankPreviewPanel = nil
end

------------------------------------------------------------------------ 英雄军衔材料选择面板 ------------------------------------------------------------------------
function __onOpenMilitaryRankMaterialPanelHandler(self, args)
    if self.m_militaryRankMaterialPanel == nil then
        self.m_militaryRankMaterialPanel = hero.HeroMilitaryRankMaterialPanel.new()
        self.m_militaryRankMaterialPanel:addEventListener(
            View.EVENT_VIEW_DESTROY,
            self.onDestroyMilitaryRankMaterialPanelHandler,
            self
        )
    end
    local heroVo = args.heroVo
    self.m_militaryRankMaterialPanel:open(heroVo)
end

function onDestroyMilitaryRankMaterialPanelHandler(self)
    self.m_militaryRankMaterialPanel:removeEventListener(
        View.EVENT_VIEW_DESTROY,
        self.onDestroyMilitaryRankMaterialPanelHandler,
        self
    )
    self.m_militaryRankMaterialPanel = nil
end

------------------------------------------------------------------------ 英雄军衔材料选择提示面板 ------------------------------------------------------------------------
function __onOpenMilitaryRankMaterialTipPanelHandler(self, args)
    if self.m_militaryRankMaterialTipPanel == nil then
        self.m_militaryRankMaterialTipPanel = hero.HeroMilitaryRankMaterialTipPanel.new()
        self.m_militaryRankMaterialTipPanel:addEventListener(
            View.EVENT_VIEW_DESTROY,
            self.onDestroyMilitaryRankMaterialTipPanelHandler,
            self
        )
    end
    local heroId = args.heroId
    self.m_militaryRankMaterialTipPanel:open(heroId)
end

function onDestroyMilitaryRankMaterialTipPanelHandler(self)
    self.m_militaryRankMaterialTipPanel:removeEventListener(
        View.EVENT_VIEW_DESTROY,
        self.onDestroyMilitaryRankMaterialTipPanelHandler,
        self
    )
    self.m_militaryRankMaterialTipPanel = nil
end

------------------------------------------------------------------------ 英雄军衔、星级提升成功面板 ------------------------------------------------------------------------
function __onOpenLevelUpSucPanelHandler(self, args)
    -- if(self.mLvUpSucPanelSn) then
    --     LoopManager:removeFrameByIndex(self.mLvUpSucPanelSn)
    -- end
    local function SucPanel()
        local oldHeroVo = args.oldHeroVo
        local isBlur = args.isBlur
        local curHeroVo = hero.HeroManager:getHeroVo(oldHeroVo.id)

        if self.HeroLevelUpSucPanel == nil then
            self.HeroLevelUpSucPanel = hero.HeroLevelUpSucPanel.new()
            local function onDestroyMilitaryRankUpSucPanelHandler(self)
                self.HeroLevelUpSucPanel:removeEventListener(
                    View.EVENT_VIEW_DESTROY,
                    self.onDestroyMilitaryRankUpSucPanelHandler,
                    self
                )
                self.HeroLevelUpSucPanel = nil
            end
            self.HeroLevelUpSucPanel:addEventListener(
                View.EVENT_VIEW_DESTROY,
                onDestroyMilitaryRankUpSucPanelHandler,
                self
            )
        end
        self.HeroLevelUpSucPanel:setIsBlur(isBlur == nil)
        self.HeroLevelUpSucPanel:open({oldHeroVo = oldHeroVo, curHeroVo = curHeroVo})
        self.HeroLevelUpSucPanel:setMilitaryUp()
        if (self.mLvUpSucPanelSn) then
            LoopManager:removeFrameByIndex(self.mLvUpSucPanelSn)
        end
    end

    if (args.type == 1) then
        self.mLvUpSucPanelSn = LoopManager:addFrame(2, 1, self, SucPanel)
    end
end

------------------------------------------------------------------------ 英雄技能描述面板 ------------------------------------------------------------------------
function __onOpenHeroSkillDesPanelHandler(self, args)
    if self.m_heroSkillDesPanel == nil then
        self.m_heroSkillDesPanel = hero.HeroSkillDesPanel.new()
        self.m_heroSkillDesPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroSkillDesPanelHandler, self)
    end
    self.m_heroSkillDesPanel:open()
    local skillVo = args.skillVo
    local heroId = args.heroId
    self.m_heroSkillDesPanel:setData(heroId, skillVo)
end

function onDestroyHeroSkillDesPanelHandler(self)
    self.m_heroSkillDesPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroSkillDesPanelHandler, self)
    self.m_heroSkillDesPanel = nil
end

------------------------------------------------------------------------ 英雄技能描述面板 ------------------------------------------------------------------------
function __onOpenHeroShowSelectPanelHandler(self, args)
    if self.mHeroSingleSelectPanel == nil then
        self.mHeroSingleSelectPanel = hero.HeroSingleSelectPanel.new()
        self.mHeroSingleSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroShowSelectPanelHandler, self)
    end
    self.mHeroSingleSelectPanel:open(args)
end

function onDestroyHeroShowSelectPanelHandler(self)
    self.mHeroSingleSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroShowSelectPanelHandler, self)
    self.mHeroSingleSelectPanel = nil
end

------------------------------------------------------------------------ 发行的战员展示界面 ------------------------------------------------------------------------
function __onOpenHeroIssueShowPanelHandler(self, args)
    if self.mHeroIssueShowPanel == nil then
        self.mHeroIssueShowPanel = hero.HeroIssueShowPanel.new()
        self.mHeroIssueShowPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroIssueShowPanelHandler, self)
    end
    self.mHeroIssueShowPanel:open()
end

function onDestroyHeroIssueShowPanelHandler(self)
    self.mHeroIssueShowPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroIssueShowPanelHandler, self)
    self.mHeroIssueShowPanel = nil
end

------------------------------------------------------------------------ 英雄碎片合成面板 ------------------------------------------------------------------------
function __onOpenHeroFragmentComposePanelHandler(self, args)
    if self.m_heroFragmentComposePanel == nil then
        self.m_heroFragmentComposePanel = hero.HeroFragmentComposePanel.new()
        self.m_heroFragmentComposePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroFragmentComposePanelHandler, self)
    end
    self.m_heroFragmentComposePanel:open(args)
end

function onDestroyHeroFragmentComposePanelHandler(self)
    self.m_heroFragmentComposePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroFragmentComposePanelHandler, self)
    self.m_heroFragmentComposePanel = nil
end

------------------------------------------------------------------------ 战员等级目标面板 ------------------------------------------------------------------------
function __onOpenHeroLvlTargetPanelHandler(self, args)
    if self.mHeroLvlTargetPanel == nil then
        self.mHeroLvlTargetPanel = hero.HeroLvlTargetPanel.new()
        self.mHeroLvlTargetPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroLvlTargetPanelHandler, self)
    end
    self.mHeroLvlTargetPanel:open(args)
end

function onDestroyHeroLvlTargetPanelHandler(self)
    self.mHeroLvlTargetPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroLvlTargetPanelHandler, self)
    self.mHeroLvlTargetPanel = nil
end

-------------------关闭当前播放的CV
function stopCurPlayCVData(self)
    if self.curPlayCvData then
        AudioManager:stopAudioSound(self.curPlayCvData)
        self.curPlayCvData = nil
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
语言包: _TT(4057):"解除锁定成功"
语言包: _TT(4056):"锁定成功"
语言包: _TT(29552):"升级失败"
]]

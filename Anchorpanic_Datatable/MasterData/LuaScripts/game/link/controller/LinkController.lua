--[[
-----------------------------------------------------
@filename       : LinkController
@Description    : ui跳转链接
@date           : 2020-11-05 17:27:07
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.link.controller.LinkController', Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_LINK_UI, self.openLinkHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {

    }
end

-- 根据UIcode打开对应面板链接
function openLinkHandler(self, args)
    local linkId = args.linkId
    local param = args.param
    local isCloseAll = args.isCloseAll

    if linkId == 0 then
        logWarn("uicode == 0", "LinkController")
        return
    end

    local configVo = link.LinkManager:getLinkData(linkId)
    if not configVo then
        logError(string.format("uicode%s没有配置，找策划哥", linkId))
        return
    end

    if configVo.funcOpenId > 0 then
        local isOpen = funcopen.FuncOpenManager:isOpen(configVo.funcOpenId, true)
        if not isOpen then
            AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_unlock.prefab"))
            return
        end
    end

    if(subPack and subPack.SubDownLoadController and subPack.SubDownLoadController:isForbidUIByDownload(linkId))then
        logInfo("=========该UIcode资源正在下载，请稍等=========")
        return
    end

    if gs.PopPanelManager.openUICode == linkId then
        logInfo("=========该UIcode已处于打开状态，故不做处理=========")
        return
    end

    if isCloseAll then
        note.NoteManager:setWillByCloseAll(true)
        gs.PopPanelManager.CloseAll()
    end
    
    if linkId == LinkCode.Adventure then
        GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL)
        --GameDispatcher:dispatchEvent(EventName.OPEN_BATTLE_MAP_HALL)
    elseif linkId == LinkCode.Pvp then
        GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_ENTRANCE_PANEL)
    elseif linkId == LinkCode.Task then
        GameDispatcher:dispatchEvent(EventName.OPEN_TASK_HALL_PANEL)
    elseif linkId == LinkCode.Recruit then
        GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_PANEL)
    elseif linkId == LinkCode.Hero then
        GameDispatcher:dispatchEvent(EventName.OPEN_HERO_PANEL, {})
    elseif linkId == LinkCode.Bag then
        GameDispatcher:dispatchEvent(EventName.OPEN_BAG_PANEL, {})
    elseif linkId == LinkCode.Friend then
        GameDispatcher:dispatchEvent(EventName.OPEN_FRIEND_PANEL)
    elseif linkId == LinkCode.Shop then
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Shop})
    elseif linkId == LinkCode.FirstCharge then--首充
        GameDispatcher:dispatchEvent(EventName.OPEN_FIRSTCHARGE_PANEL)
    elseif linkId == LinkCode.FashionPermit then--时装通行证
        if activity.ActivityManager:getActivityVoById(activity.ActivityId.Fashion_Permit) then
            local clientTime = GameManager:getClientTime()
            local remainingTime = activity.ActivityManager:getActivityVoById(activity.ActivityId.Fashion_Permit):getEndTime() - clientTime
            if remainingTime > 0 then
                GameDispatcher:dispatchEvent(EventName.OPEN_FASHIONPERMIT_PANEL)
            else
                gs.Message.Show(_TT(95053))
            end
        else
            gs.Message.Show(_TT(95053))
        end
    elseif linkId == LinkCode.FashionPermitTwo then--时装通行证
        if activity.ActivityManager:getActivityVoById(activity.ActivityId.Fashion_Permit_Two) then
            local clientTime = GameManager:getClientTime()
            local remainingTime = activity.ActivityManager:getActivityVoById(activity.ActivityId.Fashion_Permit_Two):getEndTime() - clientTime
            if remainingTime > 0 then
                GameDispatcher:dispatchEvent(EventName.OPEN_FASHIONPERMIT_TWO_PANEL)
            else
                gs.Message.Show(_TT(95053))
            end
        else
            gs.Message.Show(_TT(95053))
        end
    elseif linkId == LinkCode.Supercial then--时装通行证
        GameDispatcher:dispatchEvent(EventName.OPEN_SUPERCIAL_PANEL)
    elseif linkId == LinkCode.Covenant then
        --屏蔽盟约 改为 --基础建设
        --GameDispatcher:dispatchEvent(EventName.OPEN_COVENANT_SELECT_PANEL)
        GameDispatcher:dispatchEvent(EventName.OPEN_BUILDBASE_SCENE)
    elseif linkId == LinkCode.Mail then
        GameDispatcher:dispatchEvent(EventName.OPEN_MAIL_PANEL)
    elseif linkId == LinkCode.GrowthFund then
        GameDispatcher:dispatchEvent(EventName.OPEN_ACTIVITY_PANEL, {type = activity.ActivityConst.ACTIVITY_GROUTHFUND})
    elseif linkId == LinkCode.Bulletin then
        GameDispatcher:dispatchEvent(EventName.OPEN_BULLETIN_PANEL, {bulletinId = param})
    elseif linkId == LinkCode.HomePage then
        GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_PANEL)
    elseif linkId == LinkCode.StaminaBuy then
        GameDispatcher:dispatchEvent(EventName.OPEN_ADD_STAMINA_PANEL, {isByProps = false, needCost = 0, callFun = nil, callObj = nil})
    elseif linkId == LinkCode.CoinsBuy then
        GameDispatcher:dispatchEvent(EventName.OPEN_CONVERT_VIEW)
    elseif linkId == LinkCode.MainUI then
        if not isCloseAll then
            gs.PopPanelManager.CloseAll()
        end
    elseif linkId == LinkCode.HomeWelfare then
        GameDispatcher:dispatchEvent(EventName.OPEN_WELFAREOPT_PANEL)
        --GameDispatcher:dispatchEvent(EventName.OPEN_WELFARE_PANEL)
    elseif linkId == LinkCode.SpecialSupply then--特供活动
        GameDispatcher:dispatchEvent(EventName.OPEN_ACTIVITY_SPECIAL_SUPPLY_PANEL)
    elseif linkId == LinkCode.ActivityCarnivaGift then--狂欢好礼
        GameDispatcher:dispatchEvent(EventName.OPEN_ACTIVITY_SPECIAL_SUPPLY_PANEL, {type = activity.ActivitySpecialSupplyConst.ACTIVITY_CARNIVA_GIFT})
    elseif linkId == LinkCode.Activity then--活动
        GameDispatcher:dispatchEvent(EventName.OPEN_ACTIVITY_PANEL)
    elseif linkId == LinkCode.OrganizeBackpacks then--小游戏-整理背包
        GameDispatcher:dispatchEvent(EventName.OPEN_ORGANIZE_BACKPACKS_GAME_DUP_VIEW)
    elseif linkId == LinkCode.Shopping then--交易所
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL)
    elseif linkId == LinkCode.HomeSignIn then
        GameDispatcher:dispatchEvent(EventName.OPEN_ACTIVITY_PANEL, {type = activity.ActivityConst.ACTIVITY_DAILYCHECKIN})
        -- elseif linkId == LinkCode.Dormitory then
        -- GameDispatcher:dispatchEvent(EventName.ENTER_DORMITORY_SCENE)
    elseif linkId == LinkCode.Purchase then--充值
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Recharge, subType = purchase.TabType.RECHARGE})
    elseif linkId == LinkCode.MonthCard then--月卡
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Recharge, subType = purchase.TabType.MONTH_CARD})
    elseif linkId == LinkCode.StrengthCard then--体力月卡
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Recharge, subType = purchase.TabType.STRENGTH_CARD})
    elseif linkId == LinkCode.FashionShop then--皮肤商店
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Recharge, subType = purchase.TabType.SKIN_SHOP,openFashionType = fashionShop.ShopType.NOMAL })
    elseif linkId == LinkCode.SHOPCOMBO then--皮肤商店 组合包
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Recharge, subType = purchase.TabType.SKIN_SHOP,openFashionType = fashionShop.ShopType.COMBO })
    elseif linkId == LinkCode.SHOPSCENE then--皮肤商店 场景
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Recharge, subType = purchase.TabType.SKIN_SHOP,openFashionType = fashionShop.ShopType.SCENE })
    elseif linkId == LinkCode.SHOPPAIRTS then--皮肤商店 配件
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Recharge, subType = purchase.TabType.SKIN_SHOP,openFashionType = fashionShop.ShopType.PAIRTS })
    elseif linkId == LinkCode.DirectBuy then-- 直购礼包
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Recharge, subType = purchase.TabType.DIRECT_BUY})
    elseif linkId == LinkCode.FashionCionShop then--时装币商店
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Recharge, subType = purchase.TabType.FASHIONCION_SHOP})
    elseif linkId == LinkCode.GradeGift then--等级礼包
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Recharge, subType = purchase.TabType.GRADE_GIFT})
    elseif linkId == LinkCode.ShopLimitGift then--等级礼包
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Recharge, subType = purchase.TabType.DIRECT_BUY, subChildType = 3})
    elseif linkId == LinkCode.MainMap or linkId == LinkCode.MainMap2 then
        GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_MAIN})
        --GameDispatcher:dispatchEvent(EventName.OPEN_MAIN_STAGE_PANEL)
    elseif linkId == LinkCode.DupDaily then
        GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_DUP})
        -- GameDispatcher:dispatchEvent(EventName.OPEN_BATTLE_MAP_HALL, { type = battleMap.HallTabType.DUP_MAP_TAB })
        --GameDispatcher:dispatchEvent(EventName.OPEN_DUP_DAILY_PANEL)
    elseif linkId == LinkCode.Challenge then
        GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_CHALLAGE})
        --GameDispatcher:dispatchEvent(EventName.OPEN_DUP_CHALLENGE_PANEL)
    elseif linkId == LinkCode.BranchStory then
        GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_STORY})
        --GameDispatcher:dispatchEvent(EventName.OPEN_BRANCH_STORY_PANEL, { type = param and param.type or nil, data = param and param.data or nil })
    elseif linkId == LinkCode.Biography then
        -- GameDispatcher:dispatchEvent(EventName.OPEN_BATTLE_MAP_HALL, { type = battleMap.HallTabType.HERO_BIOGRAPHY })
        -- GameDispatcher:dispatchEvent(EventName.OPEN_HERO_BIOGRAPHY_PANEL)
        GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_BIOGRAPHY})
    elseif linkId == LinkCode.PvpArena then
        GameDispatcher:dispatchEvent(EventName.REQ_ARENA_OK, {type = 1})
    elseif linkId == LinkCode.PvpArenaHell then
        --GameDispatcher:dispatchEvent(EventName.REQ_ARENA_HELL_INFO)
        if arenaEntrance.ArenaEntranceManager:getIsReset() == 1 then
            gs.Message.Show(_TT(176))
        else
            GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_HELL_PANEL)
        end

        --GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_HALL_PANEL, { type = arena.ArenaHallType.ARENA })
    elseif linkId == LinkCode.TaskDaily then
        GameDispatcher:dispatchEvent(EventName.OPEN_TASK_HALL_PANEL, {type = task.HallTabType.DAILY_TASK})
    elseif linkId == LinkCode.TaskWeek then
        GameDispatcher:dispatchEvent(EventName.OPEN_TASK_HALL_PANEL, {type = task.HallTabType.WEEK_TASK})

    elseif linkId == LinkCode.RecruitSuper then
        local recruit_id = param or recruit.RecruitManager:getRecruitIdByType(recruit.RecruitType.RECRUIT_TOP)
        GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_PANEL, {recruitId = recruit_id})
    elseif linkId == LinkCode.RecruitNomal then
        local recruit_id = param or recruit.RecruitManager:getRecruitIdByType(recruit.RecruitType.RECRUIT_COMMON)
        GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_PANEL, {recruitId = recruit_id})
    elseif linkId == LinkCode.RecruitNewPlayer then
        local recruit_id = param or recruit.RecruitManager:getRecruitIdByType(recruit.RecruitType.RECRUIT_NEW_PLAYER)
        GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_PANEL, {recruitId = recruit_id})
    elseif linkId == LinkCode.RecruitBracelets then
        local recruit_id = param or recruit.RecruitManager:getRecruitIdByType(recruit.RecruitType.RECRUIT_BRACELETS)
        GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_PANEL, {recruitId = recruit_id})
    elseif linkId == LinkCode.RecruitActivity then
        local recruit_id = param or recruit.RecruitManager:getRecruitIdByType(recruit.RecruitType.RECRUIT_ACTIVITY_1)
        GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_PANEL, {recruitId = recruit_id})
    elseif linkId == LinkCode.RecruitBraceletsActivity then
        local recruit_id = param or recruit.RecruitManager:getRecruitIdByType(recruit.RecruitType.RECRUIT_ACTIVITY_2)
        GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_PANEL, {recruitId = recruit_id})
    elseif linkId == LinkCode.RecruitAppActTop then
        local recruit_id = param or recruit.RecruitManager:getRecruitIdByType(recruit.RecruitType.RECRUIT_APP_ACTTOP)
        GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_PANEL, {recruitId = recruit_id})
    elseif linkId == LinkCode.RecruitAppBracelets then
        local recruit_id = param or recruit.RecruitManager:getRecruitIdByType(recruit.RecruitType.RECRUIT_APP_BRACELETS)
        GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_PANEL, {recruitId = recruit_id})

    elseif linkId == LinkCode.HeroDismiss then
        GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DISMISS_PANEL)

    elseif linkId == LinkCode.HeroTeam then
        formation.openFormation(formation.TYPE.PLAYER_EDIT, nil, nil, nil)
    elseif linkId == LinkCode.HeroCulture then
        -- print(hero.HeroManager:getPanelShowHeroId())
        local id = role.RoleManager:getRoleVo():getShowBoardHeroId()
        hero.HeroManager:setPanelShowHeroId(id)
        GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DEVELOP_PANEL, {heroId = id, tabType = hero.DevelopTabType.LVL_UP})

    elseif linkId == LinkCode.BagBreak then
        -- 该uicode只跳转装备分解，需要跳转其他分解类型，新增uicode
        GameDispatcher:dispatchEvent(EventName.OPEN_BAG_BREAK_VIEW, {tabType = bag.BagTabType.EQUIP, suitId = nil})
    elseif linkId == LinkCode.BagBracelet then
        GameDispatcher:dispatchEvent(EventName.OPEN_BAG_PANEL, {tabType = bag.BagTabType.BRACELETS})
    elseif linkId == LinkCode.FriendRecommend then
        GameDispatcher:dispatchEvent(EventName.OPEN_FRIEND_PANEL, {type = friend.TabType.RECOMMEND})
    elseif linkId == LinkCode.FriendApply then
        GameDispatcher:dispatchEvent(EventName.OPEN_FRIEND_PANEL, {type = friend.TabType.APPLY})
    elseif linkId == LinkCode.ShopNomal then
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Shop, subType = ShopType.NOMAL})
    elseif linkId == LinkCode.ShopRogueLike then--兑换商店-无限城
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Shop, subType = ShopType.ROGUELIKE})
    elseif linkId == LinkCode.ShopDoundless then--兑换商店-无限城
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Shop, subType = ShopType.DOUNDLESS})
    elseif linkId == LinkCode.ShopDupApostles then--兑换商店-异想回渊
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Shop, subType = ShopType.APOSTLES2})
    elseif linkId == LinkCode.ShopDecoration then--兑换商店-装潢商店
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Shop, subType = ShopType.DECORATE})
    elseif linkId == LinkCode.ShopArm then
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Shop, subType = ShopType.ARENA})
    elseif linkId == LinkCode.ShopArenaHell then
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Shop, subType = ShopType.ARENAHELL})
    elseif linkId == LinkCode.ShopGuild then
        if guild.GuildManager:getJoinGuilded() then
            GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Shop, subType = ShopType.GUILD})
        else
            GameDispatcher:dispatchEvent(EventName.CAN_OPEN_GUILD)
        end
    elseif linkId == LinkCode.ShopBlack then
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Shop, subType = ShopType.BLACK})
    elseif linkId == LinkCode.ShopConvert then
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Shop, subType = ShopType.CONVERT})
    elseif linkId == LinkCode.ShopDismiss then
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Shop, subType = ShopType.DISMISS})
    elseif linkId == LinkCode.ShopFragments then
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Shop, subType = ShopType.FRAGMENTS})
    elseif linkId == LinkCode.ShopFragmentsOutput then
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Shop, subType = ShopType.OUTPUT})
    elseif linkId == LinkCode.ShopFragmentsAssist then
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Shop, subType = ShopType.ASSIST})
    elseif linkId == LinkCode.ShopFragmentFragment then
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Shop, subType = ShopType.FRAGMENT})
    elseif linkId == LinkCode.ShopDna then
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Shop, subType = ShopType.DNA})
    elseif linkId == LinkCode.ShopDormitory then
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Shop, subType = ShopType.DECORATE})
    elseif linkId == LinkCode.ShopDisaster then
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Shop, subType = ShopType.DISASTER})
    elseif linkId == LinkCode.SurveyWebView then
        GameDispatcher:dispatchEvent(EventName.OPEN_SURVEY_WEBVIEW, param)
    elseif linkId == LinkCode.WebView then
        GameDispatcher:dispatchEvent(EventName.OPEN_WEBVIEW, param)
    elseif linkId == LinkCode.HomeHead then
        GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_PANEL, {type = role.RoleInfoTab.RoleInfoTab})
    elseif linkId == LinkCode.Setting then
        GameDispatcher:dispatchEvent(EventName.OPEN_SYSTEMSETTINGPANEL, {type = systemSetting.SettingTabKey.QualitySetting})
    elseif linkId == LinkCode.HomeAchievement then
        GameDispatcher:dispatchEvent(EventName.OPEN_ACHIEVEMENTMAIN_PANEL, {})
    elseif linkId == LinkCode.HeroLvUp then
        GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DEVELOP_PANEL, {tabType = hero.DevelopTabType.LVL_UP})
    elseif linkId == LinkCode.HeroSkill then
        GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DEVELOP_PANEL, {tabType = hero.DevelopTabType.SKILL})
    elseif linkId == LinkCode.HeroStar then
        GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DEVELOP_PANEL, {tabType = hero.DevelopTabType.STAR_UP})
    elseif linkId == LinkCode.HeroEquip then
        GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DEVELOP_PANEL, {tabType = hero.DevelopTabType.EQUIP})
    elseif linkId == LinkCode.HeroColorUp then
        GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DEVELOP_PANEL, {tabType = hero.DevelopTabType.COLOR_UP})
    elseif linkId == LinkCode.HeroAssist then
        GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DEVELOP_PANEL, {tabType = hero.DevelopTabType.ASSIST})

        -- elseif linkId == LinkCode.HeroEquipStrengthen then
        --     -- gs.Message.Show('装备强化')
        --     -- GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_BUILD_PANEL, {})
        -- elseif linkId == LinkCode.HeroEquipReTrofit then
        --     -- gs.Message.Show('芯片改造')
        -- elseif linkId == LinkCode.HeroEquipRefactor then
        --     -- gs.Message.Show('芯片重构')
    elseif linkId == LinkCode.DupEquip then
        GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_DUP)
    elseif linkId == LinkCode.DupMoney then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_DAILY_PANEL, {dupType = DupType.DUP_MONEY, dupId = 0, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupExp then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_DAILY_PANEL, {dupType = DupType.DUP_EXP, dupId = 0, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupEquipLow then
        GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_DUP, {dupType = DupType.DUP_EQUIP_LOW, dupId = 0, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupEquipMid then
        GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_DUP, {dupType = DupType.DUP_EQUIP_MID, dupId = 0, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupEquipHigh then
        GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_DUP, {dupType = DupType.DUP_EQUIP_HIGH, dupId = 0, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupEquipTupo then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_DAILY_PANEL, {dupType = DupType.DUP_EQUIP_TUPO, dupId = 0, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupBracelets then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_DAILY_PANEL, {dupType = DupType.DUP_BRACELETS, dupId = 0, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupAttackHardening then --潜能副本-直击
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_HERO_STAR_UP, dupId = DupPontencyDupId.AttackHardening_1, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupAttackHardening_2 then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_HERO_STAR_UP, dupId = DupPontencyDupId.AttackHardening_2, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupAttackHardening_3 then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_HERO_STAR_UP, dupId = DupPontencyDupId.AttackHardening_3, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupElectric then--潜能副本-骋电
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_ELECTRIC_POTENCY, dupId = DupPontencyDupId.Electric_1, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupElectric_2 then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_ELECTRIC_POTENCY, dupId = DupPontencyDupId.Electric_2, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupElectric_3 then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_ELECTRIC_POTENCY, dupId = DupPontencyDupId.Electric_3, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupIce then--潜能副本-寒霜
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_ICE_POTENCY, dupId = DupPontencyDupId.Ice_1, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupIce_2 then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_ICE_POTENCY, dupId = DupPontencyDupId.Ice_2, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupIce_3 then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_ICE_POTENCY, dupId = DupPontencyDupId.Ice_3, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupCavitation then--潜能副本-量蚀
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_CAVITATION_POTENCY, dupId = DupPontencyDupId.Cavitation_1, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupCavitation_2 then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_CAVITATION_POTENCY, dupId = DupPontencyDupId.Cavitation_2, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupCavitation_3 then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_CAVITATION_POTENCY, dupId = DupPontencyDupId.Cavitation_3, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupLife then--潜能副本-生蕴
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_LIFE_POTENCY, dupId = DupPontencyDupId.Life_1, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupLife_2 then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_LIFE_POTENCY, dupId = DupPontencyDupId.Life_2, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupLife_3 then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_LIFE_POTENCY, dupId = DupPontencyDupId.Life_3, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupFire then--潜能副本-轰炎
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_FIRE_POTENCY, dupId = DupPontencyDupId.Fire_1, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupFire_2 then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_FIRE_POTENCY, dupId = DupPontencyDupId.Fire_2, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupFire_3 then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_FIRE_POTENCY, dupId = DupPontencyDupId.Fire_3, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupHeroStarUp then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_HERO_STAR_UP, dupId = DupPontencyDupId.AttackHardening_1, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupHeroStarUp_2 then--潜能副本-直击
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_HERO_STAR_UP, dupId = DupPontencyDupId.AttackHardening_2, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupHeroStarUp_3 then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_HERO_STAR_UP, dupId = DupPontencyDupId.AttackHardening_3, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupHeroGrowUp then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_DAILY_PANEL, {dupType = DupType.DUP_HERO_GROW_UP, dupId = 0, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupHeroSkillUp then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_DAILY_PANEL, {dupType = DupType.DUP_HERO_SKILL, dupId = 0, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupBraceletUp then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_DAILY_PANEL, {dupType = DupType.DUP_BRACELET_UP, dupId = 0, isFight = false, isJump = true})
    elseif linkId == LinkCode.DupBraceletEvolve then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_DAILY_PANEL, {dupType = DupType.DUP_BRACELET_EVOLVE, dupId = 0, isFight = false, isJump = true})
    elseif linkId == LinkCode.ChellengeTower then
        dup.DupClimbTowerManager:setPosIndex()
        GameDispatcher:dispatchEvent(EventName.OPEN_CHALLENGE_DUP, DupType.DUP_CLIMB_TOWER)
    elseif linkId == LinkCode.ChellengeDeepTower then
        dup.DupClimbTowerManager:setDeepPosIndex()
        GameDispatcher:dispatchEvent(EventName.OPEN_DEEP_TOWER_PANEL)
    elseif linkId == LinkCode.InfiniteCity then
        -- 无限城
        GameDispatcher:dispatchEvent(EventName.OPEN_INFINITE_CITY_MAIN_PANEL)
    elseif linkId == LinkCode.InfiniteCityDup then
        GameDispatcher:dispatchEvent(EventName.OPEN_INFINITE_CITY_DUP_PANEL)
    elseif linkId == LinkCode.InfiniteCityShop then
        GameDispatcher:dispatchEvent(EventName.OPEN_INFINITE_CITY_SHOP_PANEL)
    elseif linkId == LinkCode.Ikcon then
        --插画
        GameDispatcher:dispatchEvent(EventName.OPEN_IKON_VIEW)
        -- elseif linkId == LinkCode.CovenantGraduateSchool then
        --     -- 打开盟约助手界面
        --     GameDispatcher:dispatchEvent(EventName.OPEN_COVENANT_HELPER_BUILD_PANEL, {helperId = param.helperId})
    elseif linkId == LinkCode.CovenantHeadQuarter then
        GameDispatcher:dispatchEvent(EventName.OPEN_COVENANT_HQ_PANEL)
    elseif linkId == LinkCode.CovenantExplore then
        --打开盟约探索界面
        GameDispatcher:dispatchEvent(EventName.OPEN_EXPLORE_PANEL)
    elseif linkId == LinkCode.CovenantShop then
        --打开盟约商店界面
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Shop, subType = ShopType.COVENANT})
        --GameDispatcher:dispatchEvent(EventName.OPEN_COVENANT_SHOP_PANEL)
    elseif linkId == LinkCode.CovenantGraduateSchool then
        --打开盟约研究所界面
        GameDispatcher:dispatchEvent(EventName.OPEN_COVENANT_HELPER_BUILD_PANEL, {})
    elseif linkId == LinkCode.CovenantScienceTree then
        --打开盟约科技树界面
        GameDispatcher:dispatchEvent(EventName.OPEN_COVENANT_TALENT_PANEL)
    elseif linkId == LinkCode.CovenantFactory then
        --打开盟约加工厂界面
        -- GameDispatcher:dispatchEvent(EventName.OPEN_ORDER_FACTORY_PANEL)
    elseif linkId == LinkCode.HeroFashion then
        -- 打开时装界面
        GameDispatcher:dispatchEvent(EventName.OPEN_FASHION_PANEL, {heroId = param.heroId, type = param.type})
    elseif linkId == LinkCode.Training then
        -- 打开训练界面
        GameDispatcher:dispatchEvent(EventName.ENTER_TRAINING_SCENE, {})
    elseif linkId == LinkCode.ActivityTarget then
        GameDispatcher:dispatchEvent(EventName.OPEN_WELFAREOPT_PANEL, {type = welfareOpt.WelfareOptConst.WELFAREOPT_SEVENTDAY_TARGET})
    elseif linkId == LinkCode.DupMaze then
        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_PANEL)
    elseif linkId == LinkCode.DupApostlesWar then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_APOSTLES_WAR_PANEL)
    elseif linkId == LinkCode.Permit then
        if activity.ActivityManager:getActivityVoById(activity.ActivityId.Permit) then
            local clientTime = GameManager:getClientTime()
            local remainingTime = activity.ActivityManager:getActivityVoById(activity.ActivityId.Permit):getEndTime() - clientTime
            if remainingTime > 0 then
                GameDispatcher:dispatchEvent(EventName.OPEN_ACTIVITY_PANEL, {type = activity.ActivityConst.ACTIVITY_PERMIT})
            else
                gs.Message.Show(_TT(95053))
            end
        else
            gs.Message.Show(_TT(95053))
        end
        -- 通行证

    elseif linkId == LinkCode.DupImplied then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_IMPLIED_ENTER_PANEL)
    elseif linkId == LinkCode.ChellengeCodeHope then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_CODE_HOPE_PANEL)
    elseif linkId == LinkCode.RogueLike then
        GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_MAIN_PANEL)
    elseif linkId == LinkCode.Doundless then
        GameDispatcher:dispatchEvent(EventName.REQ_DOUNDLESS_INFO)
        --GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_MAIN_PANEL)
    elseif linkId == LinkCode.Manual then
        -- 打开档案界面
        GameDispatcher:dispatchEvent(EventName.OPEN_MANUAL_PANEL, {type = nil})
    elseif linkId == LinkCode.MiniFacory then
        -- GameDispatcher:dispatchEvent(EventName.OPEN_MINIFAC_PANEL)
    elseif linkId == LinkCode.CovenantSkill then
        GameDispatcher:dispatchEvent(EventName.OPEN_COVENANT_SKILL_PANEL)
    elseif linkId == LinkCode.CovenantTask then
        GameDispatcher:dispatchEvent(EventName.OPEN_COVENANT_TASK)
    elseif linkId == LinkCode.BranchStoryEquip then
        GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_STORY, subPage = branchStory.BranchStoryConst.EQUIP})
    elseif linkId == LinkCode.BranchStoryMain then
        GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_STORY, subPage = branchStory.BranchStoryConst.MAIN})
    elseif linkId == LinkCode.BranchTactivs then
        GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_STORY, subPage = branchStory.BranchStoryConst.TACTIVS})
    elseif linkId == LinkCode.BranchPower then
        GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_STORY, subPage = branchStory.BranchStoryConst.POWER})
    elseif linkId == LinkCode.HeroFashionClothes then
        GameDispatcher:dispatchEvent(EventName.OPEN_FASHION_PANEL, {propsVo = param})
    elseif linkId == LinkCode.WelfareOptSevenLoading then
        --福利-七天登录
        GameDispatcher:dispatchEvent(EventName.OPEN_ACTIVITY_PANEL, {type = activity.ActivityConst.ACTIVITY_SEVENLOADING})
    elseif linkId == LinkCode.WelfareOptNoviceGoal then
        --福利-新人训练营
        GameDispatcher:dispatchEvent(EventName.OPEN_WELFAREOPT_PANEL, {type = welfareOpt.WelfareOptConst.WELFAREOPT_NOVICEGOAL})
    elseif linkId == LinkCode.WelfareOptSevenDayTarget then
        --福利-七日目标
        GameDispatcher:dispatchEvent(EventName.OPEN_WELFAREOPT_PANEL, {type = welfareOpt.WelfareOptConst.WELFAREOPT_SEVENTDAY_TARGET})
        --GameDispatcher:dispatchEvent(EventName.OPEN_ACTIVITY_PANEL, { type = activity.ActivityConst.ACTIVITY_SEVENTDAY_TARGET })
    elseif linkId == LinkCode.Communication then
        -- 手环通讯
        GameDispatcher:dispatchEvent(EventName.OPEN_COMMUNICATE_PANEL)
    elseif linkId == LinkCode.Cycle then
        GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_MAIN_PANEL)
    elseif linkId == LinkCode.MainActivity then--1.1主题活动主界面
        local dup_id = sysParam.SysParamManager:getValue(SysParamType.SandPlayDupId)
        if dup_id ~= 0 then
            local mapId = sandPlay.SandPlayManager:getMapId()
            if mapId then
                dup_id = mapId
            end

            sandPlay.SandPlayManager:setNextMapId(dup_id)
            GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.SANDPLAY_GAME)
        else
            GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINACTIVITY_PANEL)
        end
    elseif linkId == LinkCode.HappyFarm then--开心农场
        local dup_id = sysParam.SysParamManager:getValue(SysParamType.HappyFarmDupId)
        sandPlay.SandPlayManager:setNextMapId(dup_id)
        GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.SANDPLAY_GAME)

    elseif linkId == LinkCode.HappyFarm_Breed then--农场养殖
        GameDispatcher:dispatchEvent(EventName.OPEN_SANDPLAY_HAPPYFARM_BREEDPANEL, param)
    elseif linkId == LinkCode.HappyFarm_Task then--农场任务
        GameDispatcher:dispatchEvent(EventName.OPEN_SANDPLAY_HAPPYFARM_TASKPANEL)
    elseif linkId == LinkCode.HappyFarm_Warehouse then--农场仓库
        GameDispatcher:dispatchEvent(EventName.OPEN_SANDPLAY_HAPPYFARM_FIELD, {tab = 2})
    elseif linkId == LinkCode.HappyFarm_Shop then--农场养殖
        GameDispatcher:dispatchEvent(EventName.OPEN_SANDPLAY_HAPPYFARM_SHOPPANEL)

    elseif linkId == LinkCode.ThreeSheep then--痒了又痒
        GameDispatcher:dispatchEvent(EventName.THREESHEEP_OPEN_STAGEMAINUI, {})
    elseif linkId == LinkCode.ShootBrick then--打砖块
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOOTBRICK_STAGEPANEL, {})

    elseif linkId == LinkCode.DanKe then--蛋壳
        GameDispatcher:dispatchEvent(EventName.OPEN_DANKE_STAGEPANEL)
    elseif linkId == LinkCode.PutImage then--拼图游戏
        GameDispatcher:dispatchEvent(EventName.OPEN_PUTIMAGE_STAGEPANEL)
     elseif linkId == LinkCode.Linklink then--连连看游戏
        GameDispatcher:dispatchEvent(EventName.LINKLINK_OPEN_STAGEMAINUI)
    elseif linkId == LinkCode.MainActivitySign then--1.1主题活动-骑兵补给（签到）
        GameDispatcher:dispatchEvent(EventName.OPEN_MAINACTIVITY_SIGN_VIEW)
    elseif linkId == LinkCode.ActiveDup then -- 1.1副本
        GameDispatcher:dispatchEvent(EventName.OPEN_ACTIVEDUP_STAGE_PANEL)
    elseif linkId == LinkCode.ActiveDeepDup then
        GameDispatcher:dispatchEvent(EventName.OPEN_ACTIVEDUP_STAGE_PANEL, mainActivity.ActiveDupStyleType.Difficulty)
    elseif linkId == LinkCode.ActiveDeepHell then
        GameDispatcher:dispatchEvent(EventName.OPEN_ACTIVEDUP_STAGE_PANEL, mainActivity.ActiveDupStyleType.Hard)
    elseif linkId == LinkCode.NoviceActivity then--新人活动
        GameDispatcher:dispatchEvent(EventName.OPEN_NOVICE_ACTIVITY_PANEL)
    elseif linkId == LinkCode.NoviceRechargePanel then--新人活动 --累充
        if not activity.ActivityManager:getNoviceActivityRechargeIsOpen() then
            gs.Message.Show("活动已结束") -- 活动已结束
            return
        end
        GameDispatcher:dispatchEvent(EventName.OPEN_NOVICE_ACTIVITY_PANEL, {type = noviceActivity.NoviceActivityConst.NOVICEACTIVITY_RECHARGE})
    elseif linkId == LinkCode.MainActivityShop then--1.1主题活动 商店
        local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.Shop)
        if activityVo:getTimeRemaining() <= 0 then
            gs.Message.Show("活动已结束") -- 活动已结束
            return
        elseif not activityVo:getIsCanOpen() then
            gs.Message.Show(activityVo:getLockDec()) -- 未到活动时间
            return
        end

        GameDispatcher:dispatchEvent(EventName.OPEN_MAINACTIVITYSHOP_PANEL)
    elseif linkId == LinkCode.MainActivityTask then--1.1主题活动 任务
        GameDispatcher:dispatchEvent(EventName.OPEN_MAINACTIVITYTASK_PANEL)
    elseif linkId == LinkCode.MainActivityTrial then--1.1主题活动 试玩
        local recruit_id = sysParam.SysParamManager:getValue(SysParamType.MAINACTIVITY_TRIAL_RECRUITID)
        GameDispatcher:dispatchEvent(EventName.OPEN_MAINACTIVITY_TRIAL_PANEL, {recruit_id = recruit_id})
    elseif linkId == LinkCode.MainActivityGameplay then--1.2 主题活动 鹿灵试炼

        GameDispatcher:dispatchEvent(EventName.OPEN_FIELDEXPLORATIONMAINUI, param)
    elseif linkId == LinkCode.Celebration then--周年庆
        GameDispatcher:dispatchEvent(EventName.OPEN_CELEBRATION_PANEL)
    elseif linkId == LinkCode.NoviceRafflePanel then--周年庆-抽奖
        GameDispatcher:dispatchEvent(EventName.OPEN_CELEBRATION_PANEL, {type = Celebration.CelebrationConst.Raffle})
    elseif linkId == LinkCode.CelebrationSsrOption then--周年庆-SSR月卡自选
        GameDispatcher:dispatchEvent(EventName.OPEN_CELEBRATION_PANEL, {type = Celebration.CelebrationConst.SSR_Optional})
    elseif linkId == LinkCode.CelebrationTask then--周年庆典-庆典任务
        GameDispatcher:dispatchEvent(EventName.OPEN_CELEBRATION_PANEL, {type = Celebration.CelebrationConst.Celebration_Task})
    elseif linkId == LinkCode.CelebrationAccRecharge then--周年庆典-庆典累充
        GameDispatcher:dispatchEvent(EventName.OPEN_CELEBRATION_PANEL, {type = Celebration.CelebrationConst.AccRecharge})
    elseif linkId == LinkCode.CelebrationRoundPrize then--周年庆典-庆典抽奖
        local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.RoundPrize)
        if activityVo:getTimeRemaining() <= 0 then
            gs.Message.Show("活动已结束") -- 活动已结束
            return
        elseif not activityVo:getIsCanOpen() then
            gs.Message.Show(activityVo:getLockDec()) -- 未到活动时间
            return
        end

        -- GameDispatcher:dispatchEvent(EventName.OPEN_CELEBRATION_PANEL, {type = Celebration.CelebrationConst.ROUNDPRIZE})
        GameDispatcher:dispatchEvent(EventName.OPEN_ACTIVITY_SPECIAL_SUPPLY_PANEL, {type = activity.ActivitySpecialSupplyConst.ROUNDPRIZE})
    elseif linkId == LinkCode.CelebrationRoundPrizeTwo then--周年庆典-庆典抽奖
        local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.RoundPrizeTwo)
        if activityVo:getTimeRemaining() <= 0 then
            gs.Message.Show("活动已结束") -- 活动已结束
            return
        elseif not activityVo:getIsCanOpen() then
            gs.Message.Show(activityVo:getLockDec()) -- 未到活动时间
            return
        end

        -- GameDispatcher:dispatchEvent(EventName.OPEN_CELEBRATION_PANEL, {type = Celebration.CelebrationConst.ROUNDPRIZE})
        GameDispatcher:dispatchEvent(EventName.OPEN_ACTIVITY_SPECIAL_SUPPLY_PANEL, {type = activity.ActivitySpecialSupplyConst.ROUNDPRIZE_TWO})
    elseif linkId == LinkCode.FESTIVAL then--周年庆典-七日签到
        GameDispatcher:dispatchEvent(EventName.OPEN_CELEBRATION_PANEL, {type = Celebration.CelebrationConst.WELFAREOPT_HOLIDAY})
    elseif linkId == LinkCode.MainActivityGameplayMap then--1.2 主题活动 鹿灵试炼地图
        local map_id, activity_id = 1, 0

        if not param then
            map_id = fieldExploration.FieldExplorationManager:getMap_id()
            activity_id = fieldExploration.FieldExplorationManager:getActivityId()
        else
            map_id = param.map_id
            activity_id = param.activity_id
        end

        if not activity.ActivityManager:checkIsOpenById(activity_id) then
            local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity_id)
            gs.Message.Show(activityVo:getLockDec())
            return
        end

        GameDispatcher:dispatchEvent(EventName.OPEN_FIELDEXPLORATIONMAPMAINUI, {activity_id = activity_id, map_id = map_id})
    elseif linkId == LinkCode.Gold then--1.6 捡金币
        local map_id = 1
        local activity_id = activity.ActivityId.Gold

        if param then
            map_id = param.map_id
            activity_id = param.activity_id
        end

        if not activity.ActivityManager:checkIsOpenById(activity_id) then
            local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity_id)
            gs.Message.Show(activityVo:getLockDec())
            return
        end

        GameDispatcher:dispatchEvent(EventName.OPEN_FIELDEXPLORATIONMAPMAINUI, {activity_id = activity_id, map_id = map_id})
    elseif linkId == LinkCode.Ciruit then--水管
        if not activity.ActivityManager:checkIsOpenById(activity.ActivityId.Ciruit) then
            local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.Ciruit)
            gs.Message.Show(activityVo:getLockDec())
            return
        end
        GameDispatcher:dispatchEvent(EventName.CIRUIT_OPENSTAGEMAINUI, {area_id = args.area_id})
    elseif linkId == LinkCode.ProduceMaterial then --材料生产
        local state, data = buildBase.BuildBaseManager:getCanProduce(param)
        if state == 0 then
            gs.Message.Show("无此生产物")
        elseif state == 1 then
            GameDispatcher:dispatchEvent(EventName.OPEN_BUILDBASE_PRODUCE_INFO_PANEL, {produceVo = data, openSource = 1})
        elseif state == 2 then
            gs.Message.Show("生产所需材料不足")
        else
            gs.Message.Show(_TT(76208, data))
        end
    elseif linkId == LinkCode.HeroBraceletsStrengthen then --手环强化
        if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_BRACELETS_STRENGTHEN, false) then
            GameDispatcher:dispatchEvent(EventName.OPEN_BRACELETS_BUILD_PANEL, {
                equipVo = param.equipVo,
                heroId = param.heroId
            })
        end
    elseif linkId == LinkCode.HeroEquipStrengthen then --模组强化
        if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_EQUIP_STRENGTHEN, false) then
            GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_BUILD_PANEL, {equipVo = param})
        end
    elseif linkId == LinkCode.Guild then
        GameDispatcher:dispatchEvent(EventName.CAN_OPEN_GUILD)
        --GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_JOIN_PANEL)
    elseif linkId == LinkCode.Returned then
        GameDispatcher:dispatchEvent(EventName.OPEN_RETURNED_MAIN_PANEL)
    elseif linkId == LinkCode.Mining then
        GameDispatcher:dispatchEvent(EventName.OPEN_MINING_DUP_PANEL)
    elseif linkId == LinkCode.Eliminate then
        GameDispatcher:dispatchEvent(EventName.OPEN_ELIMINATE_CHALLENGE_PANEL)
    elseif linkId == LinkCode.Disaster then
        GameDispatcher:dispatchEvent(EventName.CAN_OPEN_DISASTER_PANEL)

    elseif linkId == LinkCode.Seabed then
        GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_MAIN_PANEL)

    elseif linkId == LinkCode.HeroPreview then
        GameDispatcher:dispatchEvent(EventName.OPEN_HERO_INTRODUCETIONPANEL, args.param)
    elseif linkId == LinkCode.HeroFashionShow then
        GameDispatcher:dispatchEvent(EventName.OPEN_SKIN_SHOW_VIEW, args.param)
    elseif linkId == LinkCode.TaptapAward then
        local url = "https://l.taptap.cn/pLauEiwE?channel=rep-rep_w9x8nxhit8g"
        sdk.SdkManager:jumpBrowserWebView(url)
        -- if param == nil then
        --     param = {}
        -- end
        -- param.webUrl = url
        -- GameDispatcher:dispatchEvent(EventName.OPEN_WEBVIEW,  param)
        --GameDispatcher:dispatchEvent()
        --GameDispatcher:dispatchEvent(EventName.OPEN_TAPTAP_AWARD_PANEL)
    elseif linkId == LinkCode.GuildWar then
        local isJoin = guild.GuildManager:getJoinGuilded()
        if isJoin then
            GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.Guild})
            GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_WAR_MAIN_PANEL)
        else
            GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.Guild})
        end
    elseif linkId == LinkCode.ShopGuildWar then
        local isJoin = guild.GuildManager:getJoinGuilded()
        if isJoin then
            GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Shop, subType = ShopType.GUILDWAR})
        else
            GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.Guild})
        end
    end

    if args.noGuide then
        return
    end
    guide.GuideCondition:condition09(linkId)
    storyTalk.StoryTalkCondition:condition12(linkId)
    if activity.ActitvityExtraManager:getIsLimitShopTypeParam(activity.LimitShopActivityType.View, linkId) then
        GameDispatcher:dispatchEvent(EventName.REQ_OPEN_SOME_VIEW_UNLOCK_GIFT, {id = linkId})
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]

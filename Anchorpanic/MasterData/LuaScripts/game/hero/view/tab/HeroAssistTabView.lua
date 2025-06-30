--[[ 
-----------------------------------------------------
@filename       : HeroAssistTabView
@Description    : 英雄助战页面
@date           : 2022-3-1 14:54:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("hero.HeroAssistTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("hero/tab/HeroAssistTab.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mCurHeroId = nil
    self.mItemList = {}
end

function configUI(self)
    super.configUI(self)
    self.mEffectScroller = self:getChildGO("mEffectScroller")
    self.mEffectContent = self:getChildTrans("mEffectContent")
    self.mEffectItem = self:getChildGO("mEffectItem")
end

function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.HERO_DATA_UPDATE, self.onUpdateHeroDetailDataHandler, self)
    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.onUpdateBubbleHandler, self)

    local heroId = args.heroId
    self:setData(heroId)
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.HERO_DATA_UPDATE, self.onUpdateHeroDetailDataHandler, self)
    read.ReadManager:removeEventListener(read.ReadManager.UPDATE_MODULE_READ, self.onUpdateBubbleHandler, self)
    self:resetItemList()
end

function initViewText(self)
end

function addAllUIEvent(self)
end

-- 英雄详细数据更新
function onUpdateHeroDetailDataHandler(self, args)
    local heroId = args.heroId
    if (self.mCurHeroId == heroId) then
        self:__updateView()
    end
end

-- new状态更新
function onUpdateBubbleHandler(self, args)
    if(args)then
        if(args.type == ReadConst.ASSIST_FIGHT)then
            self:__updateView()
        end
    else
        self:__updateView()
    end
end

function setData(self, cusHeroId)
    self.mCurHeroId = cusHeroId
    local heroVo = hero.HeroManager:getHeroVo(cusHeroId)
    if (heroVo:checkIsPreData()) then
        return
    end
    
    self:__updateView()
end

function __updateView(self)
    self:resetItemList()
    
    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    local assistConfigList = hero.HeroAssistManager:getHeroAssistConfigList(curHeroVo.tid)
    for i = 1, #assistConfigList do
        local assistConfigVo = assistConfigList[i]
        local skillVo = fight.SkillManager:getSkillRo(assistConfigVo.skillId)
        local item = SimpleInsItem:create(self.mEffectItem, self.mEffectContent, self.__cname .. ".EffectItem")
        item:getChildGO("mImgSkillIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), true)
        if(skillVo:getType() == fight.FightDef.SKILL_TYPE_ACTIVE_SKILL)then         -- 主动技能
            item:getChildGO("mImgSkillBg"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon4Path("common_1429.png"), true)
        elseif(skillVo:getType() == fight.FightDef.SKILL_TYPE_PASSIVE_SKILL)then    -- 被动技能
            item:getChildGO("mImgSkillBg"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon4Path("common_1430.png"), true)
        end
        if(#skillVo:getLocation() >= 2)then
            item:getChildGO("mImgSkillDefine"):GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor(skillVo:getLocation()[1])
            item:getChildGO("mTextSkillDefine"):GetComponent(ty.Text).text = _TT(skillVo:getLocation()[2])
        else
            item:getChildGO("mImgSkillDefine"):GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor("FFFFFF00")
            item:getChildGO("mTextSkillDefine"):GetComponent(ty.Text).text = ""
        end
        item:getChildGO("mTextSkillName"):GetComponent(ty.Text).text = skillVo:getName()
        item:getChildGO("mTextSkillDes"):GetComponent(ty.Text).text = skillVo:getDesc() --assistConfigVo.des

        item:getChildGO("mTextUnLock"):GetComponent(ty.Text).text = _TT(44503) -- 未解锁

        local isSkillActive = hero.HeroAssistManager:isAssistSkillActive(self.mCurHeroId, assistConfigVo.skillId)
        
        if(isSkillActive)then
            item:getChildGO("mGroupLock"):SetActive(false)
            item:getChildGO("mTextUnLockTip"):GetComponent(ty.Text).text = ""
        else
            local lockTip = ""
            if(assistConfigVo.type == 1)then
                lockTip = _TT(1301, assistConfigVo.subtype)
            elseif(assistConfigVo.type == 2)then
                lockTip = _TT(1302, assistConfigVo.subtype)
            elseif(assistConfigVo.type == 3)then
                lockTip = _TT(1303, assistConfigVo.subtype)
            end
            item:getChildGO("mGroupLock"):SetActive(true)
            item:getChildGO("mTextUnLockTip"):GetComponent(ty.Text).text = lockTip
        end
        item:getChildGO("mImgNew"):SetActive(hero.HeroAssistManager:isShowNew(self.mCurHeroId, assistConfigVo.skillId))

        local function _clickItemFun()
            if (hero.HeroAssistManager:isShowNew(self.mCurHeroId, assistConfigVo.skillId)) then
                local moduleId = hero.HeroAssistManager:getReadModuleId(self.mCurHeroId, assistConfigVo.skillId)
                GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.ASSIST_FIGHT, id = moduleId })
            end
        end
        item:addUIEvent("mImgClick", _clickItemFun, nil)
        table.insert(self.mItemList, item)
    end
end

-- 回收预制体
function resetItemList(self)
    if(self.mItemList)then
        for _, obj in pairs(self.mItemList) do
            obj:poolRecover()
        end
    end
    self.mItemList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

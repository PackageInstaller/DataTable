module('recruit.RecruitRuleItem', Class.impl(BaseReuseItem))

UIRes = UrlManager:getUIPrefabPath("recruit/item/RecruitRuleItem.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
    self.mHeadItem = {}
    self.mItemList = {}
    self.colorStr = {"", "038008", "038008", "038008"}
end
--析构
function dtor(self)
end

function initData(self)
end

function configUI(self)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mItemGrid = self:getChildTrans("mItemGrid")
    self.mEquipGrid = self:getChildTrans("mEquipGrid")
end

--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverItem()
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

end

function recoverItem(self)
    if self.mHeadItem then
        for i, v in pairs(self.mHeadItem) do
            v:poolRecover()
        end
    end
    self.mHeadItem = {}

    if self.mItemList then
        for i, v in pairs(self.mItemList) do
            v:poolRecover()
        end
    end
    self.mItemList = {}

end

function clearTimer(self)
    if self.m_createTimer then
        LoopManager:removeFrameByIndex(self.m_createTimer)
        self.m_createTimer = nil
    end
end

function createItem_1(self)
    self.m_createIndex = self.m_createIndex + 1
    if self.m_createIndex <= #self.heroList then
        local item = BraceletsGrid2:create(self.mEquipGrid, {self.heroList[self.m_createIndex], 1}, 1)
        item:setIsShowName(true)
        item:setClickEnable(true)
        self.mItemList[self.m_createIndex] = item

        if self.m_createIndex == #self.heroList then
            self.createFinishCall()
        end
    end
end

function createItem_2(self)
    self.m_createIndex = self.m_createIndex + 1
    if self.m_createIndex <= #self.heroList then
        local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.heroList[self.m_createIndex])
        local item = HeroHeadGrid:poolGet()

        item:setData(heroConfigVo)
        item:setParent(self.mItemGrid)
        item:setSiblingIndex(self.m_createIndex)
        item:setName(heroConfigVo.name)
        item:setEleType(true)
        item:setType(false)
        item:setLvl(1)
        item:setStarLvl(heroConfigVo:getStar())
        item:setScale(1)
        item:setCallBack(self, function()
            GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DETAILSINFOPANEL, {heroTid = heroConfigVo.tid})
            GameDispatcher:dispatchEvent(EventName.CLOSE_RECRUIT_RULE_PANEL)
        end)
        self.mHeadItem[self.m_createIndex] = item

        if self.m_createIndex == #self.heroList then
            self.createFinishCall()
        end
    end
end

function setData(self, cusParent, ruleList, index, type, createFinishCall)
    self.createFinishCall = createFinishCall
    self.mRecruit_type = type

    self:setParentTrans(cusParent)
    local color = ruleList[index].color
    local pr = ruleList[index].pr
    local floorPr = ruleList[index].floor_pr
    self.heroList = table.copy(ruleList[index].hero_list)

    for i = 1, 3 do
        self.m_childGos["mImgQuality_" .. i]:SetActive(color - 1 == i)
    end

    if self.mRecruit_type == recruit.RecruitType.RECRUIT_BRACELETS
        or self.mRecruit_type == recruit.RecruitType.RECRUIT_APP_BRACELETS
        or self.mRecruit_type == recruit.RecruitType.RECRUIT_ACTIVITY_2 then
        self.mTxtTitle.text = _TT(28030, self.colorStr[color], pr)
    else
        self.mTxtTitle.text = _TT(28031, self.colorStr[color], pr, floorPr)
    end

    self.m_createIndex = 0
    self:createItem()
end

function createItem(self)
    self:recoverItem()

    self:clearTimer()
    if self.m_createIndex > #self.heroList then
        return
    end

    if self.mRecruit_type == recruit.RecruitType.RECRUIT_BRACELETS
        or self.mRecruit_type == recruit.RecruitType.RECRUIT_APP_BRACELETS
        or self.mRecruit_type == recruit.RecruitType.RECRUIT_ACTIVITY_2 then
        if not self.m_createTimer then
            self.m_createTimer = LoopManager:addFrame(1, #self.heroList, self, self.createItem_1)
        end
    else
        if not self.m_createTimer then
            self.m_createTimer = LoopManager:addFrame(1, #self.heroList, self, self.createItem_2)
        end
    end
end

function __sortHeroTidList(tid_1, tid_2)
    if (tid_1 and tid_2) then
        local heroConfigVo_1 = hero.HeroManager:getHeroConfigVo(tid_1)
        local heroConfigVo_2 = hero.HeroManager:getHeroConfigVo(tid_2)
        if (tid_1 and tid_2) then
            -- 英雄品质从大到小
            if (heroConfigVo_1.color > heroConfigVo_2.color) then
                return true
            end
            if (heroConfigVo_1.color < heroConfigVo_2.color) then
                return false
            end
        end
    end
    return false
end

function __sortEquipList(tid_1, tid_2)
    local equipVo1 = props.PropsManager:getPropsConfigVo(tid_1)
    local equipVo2 = props.PropsManager:getPropsConfigVo(tid_2)
    if (equipVo1 and equipVo2) then
        local sortFun = nil
        sortFun = bag.getSortFun(true, bag.BagSortType.COLOR)
        local result = sortFun(equipVo1, equipVo2)
        sortFun = nil
        if (result ~= nil) then
            return result
        end
    end
    return false
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]

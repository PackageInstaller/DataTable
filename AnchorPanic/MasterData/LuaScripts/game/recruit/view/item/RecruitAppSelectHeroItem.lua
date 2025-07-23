-- @FileName:   RecruitAppSelectHeroItem.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-07-25 16:40:26
-- @Copyright:   (LY) 2024 锚点降临

module("recruit.RecruitAppSelectHeroItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mBtnSelect = self:getChildGO("mBtnSelect")
    self.mImgSelect = self:getChildGO("mImgSelect")
    self.heroNode = self:getChildTrans("heroNode")
    self.mImgHave = self:getChildGO("mImgHave")

    self.mTextHave = self:getChildGO("mTextHave"):GetComponent(ty.Text)

    self.mSign = self:getChildGO("mSign")
    self.mTextSign = self:getChildGO("mTextSign"):GetComponent(ty.Text)

    self.mTextTime = self:getChildGO("mTextTime"):GetComponent(ty.Text)
end

function addAllUIEvent(self)
    self:addUIEvent(self.UIObject, function()
        GameDispatcher:dispatchEvent(EventName.RECRUIT_APPSELECT_HERO, self.data.tid)
    end)
end

function active(self)
    super.active(self)

    self.mTextSign.text = _TT(135019)
    GameDispatcher:addEventListener(EventName.RECRUIT_APPSELECT_HERO, self.onSelect, self)
end

-- override 虚拟列表被非激活时自动调用
function deActive(self)
    super.deActive(self)

    if self.m_grid then
        self.m_grid:poolRecover()
        self.m_grid = nil
    end

    self:clearTimer()

    GameDispatcher:removeEventListener(EventName.RECRUIT_APPSELECT_HERO, self.onSelect, self)
end

function setData(self, data)
    super.setData(self, data)

    local recruit_info = recruit.RecruitManager:getRecruitInfo(self.data.recruitId)
    local recruitType = recruit.RecruitManager:getRecruitTypeById(self.data.recruitId)
    self.mSign:SetActive(recruit_info.select_tid == self.data.tid)

    self.mTextHave.text = _TT(135011)
    if recruitType == recruit.RecruitType.RECRUIT_APP_ACTTOP then
        self.m_grid = HeroHeadGrid:poolGet()
        local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.data.tid)
        self.m_grid:setData(heroConfigVo)
        self.m_grid:setParent(self.heroNode)
        self.m_grid:setLvl(1)
        self.m_grid:setEleType(true)
        self.m_grid:setName(heroConfigVo.name)
        self.m_grid:setCallBack(self, function()
            GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DETAILSINFOPANEL, {heroTid = heroConfigVo.tid})
            GameDispatcher:dispatchEvent(EventName.CLOSE_RECRUIT_APP_SELECTPANEL)
        end)

        local heroVo = hero.HeroManager:getHeroVoByTid(self.data.tid)

        local evolutionLvl = heroVo and heroVo.evolutionLvl or 0
        self.m_grid:setStarLvl(evolutionLvl)

        self.mImgHave:SetActive(heroVo ~= nil)
        if evolutionLvl >= 6 then
            self.mTextHave.text = _TT(1055)
        end

    elseif recruitType == recruit.RecruitType.RECRUIT_APP_BRACELETS then
        self.m_grid = BraceletsGrid2:create(self.heroNode, {self.data.tid, 1}, 1)
        self.m_grid:setIsShowName(true)
        self.m_grid:setClickEnable(true)

        self.mImgHave:SetActive(bag.BagManager:getPropsCountByTid(self.data.tid) > 0)
    end

    self.mImgSelect:SetActive(self.data.getSelectTid() == self.data.tid)

    self.m_endTime = recruit_info.select_plus_list[self.data.tid]
    if self.m_endTime ~= nil and GameManager:getClientTime() < self.m_endTime then
        self:clearTimer()

        self:refreshEndTime()

        self.m_TimerOutSn = LoopManager:addTimer(0.5, 0, self, self.refreshEndTime)
    else
        self:clearTimer()
    end
end

function refreshEndTime(self)
    local time = self.m_endTime - GameManager:getClientTime()
    if time <= 0 then
        self:clearTimer()
    else
        self.mTextTime.text = TimeUtil.getFormatTimeBySeconds_9(time)
    end
end

function clearTimer(self)
    if self.m_TimerOutSn then
        LoopManager:removeTimerByIndex(self.m_TimerOutSn)
        self.m_TimerOutSn = nil
    end

    self.mTextTime.text = ""
end

function onSelect(self, heroTid)
    self.mImgSelect:SetActive(heroTid == self.data.tid)
end

return _M

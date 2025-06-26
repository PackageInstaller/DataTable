-- @FileName:   RecruitSelectHeroPanel.lua
-- @Description:   定向卡池选择界面
-- @Author: ZDH
-- @Date:   2024-07-24 14:35:19
-- @Copyright:   (LY) 2024 锚点降临

module('recruit.RecruitSelectHeroPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('recruit/RecruitSelectHeroPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 519)
end

-- 初始化数据
function initData(self)
    self.m_itemList = {}
    self.m_recruitType = nil
end

-- 初始化
function configUI(self)
    self.mBtnConfirm = self:getChildGO("mBtnConfirm")
    self.mBtnConfirmRect = self.mBtnConfirm:GetComponent(ty.RectTransform)

    self.mTextDesc = self:getChildGO("mTextDesc"):GetComponent(ty.Text)

    self.LyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.LyScroller:SetItemRender(recruit.RecruitAppSelectHeroItem)

    self.mBtnGo = self:getChildGO("mBtnGo")
end

-- 激活
function active(self, args)
    super.active(self, args)

    GameDispatcher:addEventListener(EventName.RECRUIT_APPSELECT_HERO, self.onSelect, self)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.refreshProps, self)

    self.m_recruitId = args.recruitId
    self.m_recruitType = recruit.RecruitManager:getRecruitTypeById(self.m_recruitId)
    self.m_appType = args.type
    recruit.RecruitManager:SetOpenAppSelectPanel(self.m_appType)

    local titleLandId, descLandId = 0, 0
    if self.m_appType == 1 then
        if self.m_recruitType == recruit.RecruitType.RECRUIT_APP_ACTTOP then
            titleLandId = 135002
            descLandId = 135004
        elseif self.m_recruitType == recruit.RecruitType.RECRUIT_APP_BRACELETS then
            titleLandId = 135007
            descLandId = 135005
        end
    else
        if self.m_recruitType == recruit.RecruitType.RECRUIT_APP_ACTTOP then
            titleLandId = 135021
            descLandId = 135022
        elseif self.m_recruitType == recruit.RecruitType.RECRUIT_APP_BRACELETS then
            titleLandId = 135026
            descLandId = 135027
        end
    end

    self:setTxtTitle(_TT(titleLandId))
    self.mTextDesc.text = _TT(descLandId)

    local configVo = recruit.RecruitManager:getRecruitConfigVo(self.m_recruitId)
    local heroList = configVo.hero_list[self.m_appType]
    if not table.empty(heroList) then
        local data = {}
        for i = 1, #heroList do
            local sortState = 0
            if self.m_recruitType == recruit.RecruitType.RECRUIT_APP_ACTTOP then
                local heroVo = hero.HeroManager:getHeroVoByTid(heroList[i])
                if heroVo ~= nil then
                    if heroVo.evolutionLvl >= 6 then
                        sortState = 2
                    else
                        sortState = 1
                    end
                end
            end
            table.insert(data, {sortState = sortState, sortIndex = i, tid = heroList[i], recruitId = self.m_recruitId, getSelectTid = function ()
                return self.m_selectHeroTid or 0
            end})
        end

        if self.m_recruitType == recruit.RecruitType.RECRUIT_APP_ACTTOP then
            table.sort(data, function (a, b)
                if a.sortState == b.sortState then
                    return a.sortIndex < b.sortIndex
                else
                    return a.sortState < b.sortState
                end
            end)

        elseif self.m_recruitType == recruit.RecruitType.RECRUIT_APP_BRACELETS then
            table.sort(data, function (a, b)
                local bagCount_a = bag.BagManager:getPropsCountByTid(a.tid)
                local bagCount_b = bag.BagManager:getPropsCountByTid(b.tid)

                if bagCount_a == bagCount_b then
                    return a.tid > b.tid
                else
                    return bagCount_a < bagCount_b
                end
            end)
        end

        if self.LyScroller.Count <= 0 then
            self.LyScroller.DataProvider = data
        else
            self.LyScroller:ReplaceAllDataProvider(data)
        end
    end

    if self.m_appType == 1 then
        self.mBtnConfirmRect.anchoredPosition = gs.Vector2(200,self.mBtnConfirmRect.anchoredPosition.y)
        self.mBtnGo:SetActive(true)
    else
        self.mBtnConfirmRect.anchoredPosition = gs.Vector2(0,self.mBtnConfirmRect.anchoredPosition.y)
        self.mBtnGo:SetActive(false)
    end

    self:refreshProps()
end

-- 非激活
function deActive(self)
    super.deActive(self)

    if self.LyScroller then
        self.LyScroller:CleanAllItem()
    end

    if self.m_consumeGrid then
        self.m_consumeGrid:poolRecover()
        self.m_consumeGrid = nil
    end

    GameDispatcher:removeEventListener(EventName.RECRUIT_APPSELECT_HERO, self.onSelect, self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.refreshProps, self)
end

-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)

    recruit.RecruitManager:SetOpenAppSelectPanel(nil)
end

function initViewText(self)
    self:setBtnLabel(self.mBtnConfirm, 1)

    if self.m_recruitType == recruit.RecruitType.RECRUIT_APP_ACTTOP then
        self:setBtnLabel(self.mBtnGo, 50092)
    elseif self.m_recruitType == recruit.RecruitType.RECRUIT_APP_BRACELETS then
        self:setBtnLabel(self.mBtnGo, 50094)
    end
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnConfirm, self.onClickConfirm)
    self:addUIEvent(self.mBtnGo, self.onClickGo)
end

function onClickGo(self)
    self:close()

    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_APP_SELECTPANEL, {recruitId = self.m_recruitId, type = 2})
end

function refreshProps(self)
    if self.m_appType == 1 then
        local recruit_info = recruit.RecruitManager:getRecruitInfo(self.m_recruitId)
        if recruit_info.select_tid ~= 0 and recruit_info.first_week == 1 then
            local consume_tid = sysParam.SysParamManager:getValue(SysParamType.RECRUIT_APP_ITEM)
            self.m_consumeGrid = PropsGrid:createByData({tid = consume_tid, num = 0, parent = self:getChildTrans("consume"), scale = 1, showUseInTip = true})
            self.m_consumeGrid:setCount(nil, 1)
        end
    else
        local consume_tid = sysParam.SysParamManager:getValue(SysParamType.RECRUIT_SENIORAPP_ITEM)
        self.m_consumeGrid = PropsGrid:createByData({tid = consume_tid, num = 0, parent = self:getChildTrans("consume"), scale = 1, showUseInTip = true})
        self.m_consumeGrid:setCount(nil, 1)
    end
end

function onClickConfirm(self)
    local msg = ""

    local recruit_info = recruit.RecruitManager:getRecruitInfo(self.m_recruitId)
    if recruit_info.select_tid == self.m_selectHeroTid then
        if self.m_recruitType == recruit.RecruitType.RECRUIT_APP_ACTTOP then
            msg = _TT(135017)
        elseif self.m_recruitType == recruit.RecruitType.RECRUIT_APP_BRACELETS then
            msg = _TT(135018)
        end
        gs.Message.Show(msg)
        return
    end

    if not self.m_selectHeroTid then
        if self.m_recruitType == recruit.RecruitType.RECRUIT_APP_ACTTOP then
            msg = _TT(135012)
        elseif self.m_recruitType == recruit.RecruitType.RECRUIT_APP_BRACELETS then
            msg = _TT(135013)
        end
        gs.Message.Show(msg)
        return
    end

    local recruit_info = recruit.RecruitManager:getRecruitInfo(self.m_recruitId)
    if self.m_appType == 1 then
        if recruit_info.select_tid ~= 0 and recruit_info.first_week == 1 then
            local consume_tid = sysParam.SysParamManager:getValue(SysParamType.RECRUIT_APP_ITEM)
            local bagCount = bag.BagManager:getPropsCountByTid(consume_tid)

            local confirmCall = function ()
                if bagCount <= 0 then
                    gs.Message.Show(_TT(156))
                    return
                end

                self:onClickClose()
                GameDispatcher:dispatchEvent(EventName.REQ_APP_RECRUITSELECTTID, {recruit_id = self.m_recruitId, tid = self.m_selectHeroTid})
            end

            if self.m_recruitType == recruit.RecruitType.RECRUIT_APP_ACTTOP then
                local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.m_selectHeroTid)
                msg = _TT(135015, bagCount, heroConfigVo.name)
            elseif self.m_recruitType == recruit.RecruitType.RECRUIT_APP_BRACELETS then
                local vo = props.PropsManager:getTypePropsVoByTid(self.m_selectHeroTid)
                msg = _TT(135016, bagCount, vo:getName())
            end

            UIFactory:alertMessge(msg, true, confirmCall, nil, nil, true)
        else
            if self.m_recruitType == recruit.RecruitType.RECRUIT_APP_ACTTOP then
                local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.m_selectHeroTid)
                msg = _TT(135006, heroConfigVo.name)
            elseif self.m_recruitType == recruit.RecruitType.RECRUIT_APP_BRACELETS then
                local vo = props.PropsManager:getTypePropsVoByTid(self.m_selectHeroTid)
                msg = _TT(135010, vo:getName())
            end

            local confirmCall = function ()
                GameDispatcher:dispatchEvent(EventName.REQ_APP_RECRUITSELECTTID, {recruit_id = self.m_recruitId, tid = self.m_selectHeroTid})
                self:onClickClose()
            end

            UIFactory:alertMessge(msg, true, confirmCall, nil, nil, true)
        end
    else
        local endTime = recruit_info.select_plus_list[self.m_selectHeroTid]
        if endTime == nil or GameManager:getClientTime() >= endTime then
            local confirmCall = function ()
                local consume_tid = sysParam.SysParamManager:getValue(SysParamType.RECRUIT_SENIORAPP_ITEM)
                local bagCount = bag.BagManager:getPropsCountByTid(consume_tid)
                if bagCount <= 0 then
                    gs.Message.Show(_TT(156))
                    return
                end

                self:onClickClose()
                GameDispatcher:dispatchEvent(EventName.REQ_APP_RECRUITSELECTTID, {recruit_id = self.m_recruitId, tid = self.m_selectHeroTid})
            end

            if self.m_recruitType == recruit.RecruitType.RECRUIT_APP_ACTTOP then
                local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.m_selectHeroTid)
                msg = _TT(135024, heroConfigVo.name)
            elseif self.m_recruitType == recruit.RecruitType.RECRUIT_APP_BRACELETS then
                local vo = props.PropsManager:getTypePropsVoByTid(self.m_selectHeroTid)
                msg = _TT(135029, vo:getName())
            end

            UIFactory:alertMessge(msg, true, confirmCall, nil, nil, true)
        else
            self:onClickClose()
            GameDispatcher:dispatchEvent(EventName.REQ_APP_RECRUITSELECTTID, {recruit_id = self.m_recruitId, tid = self.m_selectHeroTid})
        end
    end

end

function onSelect(self, heroTid)
    self.m_selectHeroTid = heroTid
end

return _M

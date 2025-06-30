-- @FileName:   RecruitAppTopTabView.lua
-- @Description:   定向站员卡池
-- @Author: ZDH
-- @Date:   2024-07-23 11:52:40
-- @Copyright:   (LY) 2024 锚点降临

module("recruit.RecruitAppTopTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("recruit/tab/RecruitAppTopTab.prefab")

--构造函数
function ctor(self, recruitId)
    super.ctor(self)
    self.m_recruitId = recruitId
end

-- 初始化数据
function initData(self)
    -- self.m_recruitType = recruit.RecruitType.RECRUIT_APP_ACTTOP
end

function configUI(self)
    self.mBtnLog = self:getChildGO("BtnLog")
    self.mBtnRule = self:getChildGO("BtnRule")
    self.mBtnSeniorApp = self:getChildGO("BtnSeniorApp")
    self.mBtnOne = self:getChildGO("BtnOne")
    self.mBtnTen = self:getChildGO("BtnTen")

    self.mPropsIcon_one = self:getChildGO("PropsIcon_one"):GetComponent(ty.AutoRefImage)
    self.mTxtCount_one = self:getChildGO("TextCount_one"):GetComponent(ty.Text)
    self.mPropsIcon_ten = self:getChildGO("PropsIcon_ten"):GetComponent(ty.AutoRefImage)
    self.mTextCount_ten = self:getChildGO("TextCount_ten"):GetComponent(ty.Text)

    self.mTextRemainTimes_1 = self:getChildGO("TextRemainTimes_1"):GetComponent(ty.Text)
    self.mTextRemainTimes_2 = self:getChildGO("TextRemainTimes_2"):GetComponent(ty.Text)
    self.mTextRemainTimes_3 = self:getChildGO("TextRemainTimes_3"):GetComponent(ty.Text)
    self.TextRemainTimes_4 = self:getChildGO("TextRemainTimes_4"):GetComponent(ty.Text)

    self.mTxtActivetyTime = self:getChildGO("mTxtActivetyTime"):GetComponent(ty.Text)

    self.mNormalGroup = self:getChildGO("mNormalGroup")
    self.mBtnApp = self:getChildGO("mBtnApp")
    self.mImgHero = self:getChildGO("mImgHero"):GetComponent(ty.AutoRefImage)
    self.mHeroNode = self:getChildGO("mHeroNode")

    self.mTextVBtnApp = self:getChildGO("mTextVBtnApp"):GetComponent(ty.Text)

    self.mSpineNode = self:getChildTrans("mSpineNode")
    self.mImgTitle01 = self:getChildGO("mImgTitle01"):GetComponent(ty.Image)

    self.mBtnDetails = self:getChildGO("mBtnDetails")
    self.mImgPro = self:getChildGO("mImgPro"):GetComponent(ty.AutoRefImage)
    self.mImgEleType = self:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)
    self.mTextUpName = self:getChildGO("mTextUpName"):GetComponent(ty.Text)
    self.mText_1 = self:getChildGO("mText_1"):GetComponent(ty.Text)

    self.mTxtData = self:getChildGO("mTxtData"):GetComponent(ty.Text)
    self.mDebugUpInfo = self:getChildGO("mDebugUpInfo")
end

function active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_RECRUIT_PANEL, self.onUpdateViewHandler, self)
    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.onModuleRedUpdate, self)

    self:updateView()
    self:onModuleRedUpdate()
end

function deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_RECRUIT_PANEL, self.onUpdateViewHandler, self)
    read.ReadManager:removeEventListener(read.ReadManager.UPDATE_MODULE_READ, self.onModuleRedUpdate, self)

    self:clearAcitivety()
    self:clearHeroSpine()
end

function initViewText(self)
    self:setBtnLabel(self.mBtnOne, 28007, "招募一次")
    self:setBtnLabel(self.mBtnTen, 28008, "招募十次")
    self:setBtnLabel(self.mBtnSeniorApp, 135020, "招募十次")

    self.mTextVBtnApp.text = _TT(135002)
    self.mText_1.text = _TT(551)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnLog, self.onClickLogHandler)
    self:addUIEvent(self.mBtnRule, self.onClickRuleHandler)
    self:addUIEvent(self.mBtnSeniorApp, self.onClickSeniorAppHandler)

    self:addUIEvent(self.mBtnOne, self.onClickOneHandler)
    self:addUIEvent(self.mBtnTen, self.onClickTenHandler)

    self:addUIEvent(self.mBtnApp, self.onClickAppHeroPanel)

    self:addUIEvent(self.mBtnDetails, self.onClickDetails)

end

function updateShowActivetyTimer(self)
    self:clearAcitivety()

    self.m_appType = 1
    if self.m_recruitInfo.select_tid ~= 0 then
        local configVo = recruit.RecruitManager:getRecruitConfigVo(self.m_recruitId)
        for k, v in pairs(configVo.hero_list[2]) do
            if self.m_recruitInfo.select_tid == v then
                self.m_endTime = self.m_recruitInfo.select_plus_list[self.m_recruitInfo.select_tid]
                self.m_appType = 2
                break
            end
        end
    end

    self:showActivetyTime()
    self.activetyTimeShowTimer = self:addTimer(1, 0, self.showActivetyTime)
end

function showActivetyTime(self)
    if self.m_appType == 1 then
        local clientDt = GameManager:getClientTime()
        clientDt = clientDt - 5 * 3600
        local clientData = os.date("*t", clientDt)

        --算出今天是周几
        local wDay = clientData.wday - 1
        if wDay == 0 then
            wDay = 7
        end

        --与下周一相差几天
        local addDay = 7 - wDay -- 完整的天数
        local addDt = addDay * 86400 + (86400 - (clientData.hour * 3600) - (clientData.min * 60) - clientData.sec) --距离一天所相差的时间

        self.mTxtActivetyTime.text = _TT(135001, TimeUtil.getFormatTimeBySeconds_1(addDt))
    else

        local time = self.m_endTime - GameManager:getClientTime()
        if time <= 0 then
            self.m_appType = 1
        else
            self.mTxtActivetyTime.text = _TT(135025) .. TimeUtil.getFormatTimeBySeconds_9(time)
        end
    end
end

function clearAcitivety(self)
    if self.activetyTimeShowTimer then
        self:removeTimerByIndex(self.activetyTimeShowTimer)
        self.activetyTimeShowTimer = nil
    end
end

function onClickDetails(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_RECRUITINFOPANEL, {
        heroTid = self.m_recruitInfo.select_tid
    })
end

function onClickAppHeroPanel(self)
    -- local recruit_info = recruit.RecruitManager:getRecruitInfo(self.m_recruitType)
    -- if recruit_info.select_tid ~= 0 and recruit_info.first_week == 1 then
    --     gs.Message.Show(_TT(135014))
    --     return
    -- end

    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_APP_SELECTPANEL, {recruitId = self.m_recruitId, type = 1})
end

function onClickLogHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_LOG_PANEL, {recruitId = self.m_recruitId})
end

function onClickRuleHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_RULE_PANEL, {recruitId = self.m_recruitId})
end

function onClickSeniorAppHandler(self)
    if recruit.RecruitManager:updateSeniorAppActRedState() then
        GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, {type = 221, id = 800})
    end

    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_APP_SELECTPANEL, {recruitId = self.m_recruitId, type = 2})
end

function onClickOneHandler(self)
    if self.m_recruitInfo.select_tid == 0 then
        gs.Message.Show(_TT(135008))
        return
    end

    self:checkSend(self.m_recruitId, 1)
end

function onClickTenHandler(self)
    if self.m_recruitInfo.select_tid == 0 then
        gs.Message.Show(_TT(135008))
        return
    end

    self:checkSend(self.m_recruitId, 10)
end

-- 今日已招募次数
function getToDayRecruitTimes(self)
    return self.m_recruitInfo.recruit_daily_times
end

function checkSend(self, recruitId, times)
    GameDispatcher:dispatchEvent(EventName.SEND_RECRUIT, {recruitId = recruitId, times = times})
end

function onUpdateViewHandler(self, args)
    self:updateView()
end

function onDebugInfo(self)
    local upHeroVo = hero.HeroManager:getHeroConfigVo(self.m_recruitInfo.select_tid)

    if GameManager.IS_DEBUG and not GameManager.HIDE_DEBUG_INFO then
        self.mDebugUpInfo:SetActive(true)

        local debugUpInfo = recruit.RecruitManager:getDebugShowRecruitUpInfoMsg(self.m_recruitId)
        if debugUpInfo then
            local msg = ""
            for i, v in ipairs(debugUpInfo.other_ratio) do
                msg = msg .. v.key .. ": " .. v.value .. "\n"
            end
            self.mTxtData.text = "当前大保底UP战员：" .. upHeroVo.name .. " tid: " .. self.m_recruitInfo.select_tid .. "\n当前UP战员权重：" .. debugUpInfo.up_ratio .. "\n其他战员权重：\n" .. msg
        else
            self.mTxtData.text = "获取UP Debug数据出错了，请排查是否是配置出错。卡池ID:" .. self.m_recruitId
        end
    else
        self.mDebugUpInfo:SetActive(false)
        self.mTxtData.text = ""
    end
end

function updateView(self)
    self.m_recruitInfo = recruit.RecruitManager:getRecruitInfo(self.m_recruitId)
    if self.m_recruitInfo then
        local configVo = recruit.RecruitManager:getRecruitConfigVo(self.m_recruitId)
        local costMoneyTid_one = configVo:getCostOneId()
        local costMoneyCount_one = configVo:getCostOneNum()
        local costMoneyTid_ten = configVo:getCostTenId()
        local costMoneyCount_ten = configVo:getCostTenNum()

        self.mTextRemainTimes_1.text = "/" .. configVo:getMinimumTimes()
        self.mTextRemainTimes_2.text = self:getRecruitTimes()
        self.mTextRemainTimes_3.text = _TT(135003)

        self.TextRemainTimes_4.text = _TT(28049, self.m_recruitInfo.guaranteed_times)

        self.mPropsIcon_one:SetImg(UrlManager:getPropsIconUrl(costMoneyTid_one), false)
        self.mTxtCount_one.text = "x" .. costMoneyCount_one
        self.mPropsIcon_ten:SetImg(UrlManager:getPropsIconUrl(costMoneyTid_ten), false)
        self.mTextCount_ten.text = "x" .. costMoneyCount_ten

        local select_id = self.m_recruitInfo.select_tid
        self.mNormalGroup:SetActive(select_id == 0)
        self.mHeroNode:SetActive(select_id ~= 0)
        self.mSpineNode.gameObject:SetActive(select_id ~= 0)

        self.mBtnDetails.gameObject:SetActive(select_id ~= 0)

        if select_id ~= 0 then
            local configHeroVo = hero.HeroManager:getHeroConfigVo(select_id)
            self.mImgEleType:SetImg(UrlManager:getHeroEleTypeIconUrl(configHeroVo.eleType), false)
            self.mImgPro:SetImg(UrlManager:getHeroJobSmallIconUrl(configHeroVo.professionType), false)
            self.mTextUpName.text = configHeroVo.name

            self.mImgHero:SetImg(UrlManager:getHeroHeadUrl(select_id))

            local heroConfigVo = hero.HeroManager:getHeroConfigVo(select_id)
            if heroConfigVo then
                self:clearHeroSpine()

                local showModel = heroConfigVo.showModel
                self.m_heroSpinePath = string.format("arts/fx/spine/%s/RecruitSpine_%s.prefab", showModel, showModel)
                self.m_heroSpineGo = gs.GOPoolMgr:Get(self.m_heroSpinePath)
                if not self.m_heroSpineGo then
                    logError("该站员缺少 Spine id = " .. select_id)
                end

                gs.TransQuick:SetParentOrg(self.m_heroSpineGo.transform, self.mSpineNode)

                local titleColor =
                {
                    ["4101"] = "FFFFFFFF",
                    ["4103"] = "FFFFFFFF",
                    ["4501"] = "FFFFFFFF",
                    ["4515"] = "FFFFFFFF",
                    ["4512"] = "FFFFFFFF",
                    ["4511"] = "FFFFFFFF",
                    ["4510"] = "FFFFFFFF",
                    ["4516"] = "FFFFFFFF",
                    ["4105"] = "FFFFFFFF",
                    ["4502"] = "FFFFFFFF",
                    ["4108"] = "FFFFFFFF",
                    ["4505"] = "FFFFFFFF",
                    ["4507"] = "FFFFFFFF",
                    ["4107"] = "FFFFFFFF",
                    ["4509"] = "4CDCFFFF",
                    ["4513"] = "4CDCFFFF",

                    ["4508"] = "76FF5DFF",
                    ["4514"] = "76FF5DFF",

                    ["4503"] = "0DC1FFFF",
                    ["4106"] = "0DC1FFFF",
                    ["4506"] = "0DC1FFFF",
                    ["4504"] = "0DC1FFFF",

                    ["1503"] = "12FF2FFF",
                    ["3504"] = "12FF2FFF",
                    ["4104"] = "25EDFFFF",

                    ["3108"] = "26EEFFFF",
                }
                local color = titleColor[showModel]
                if color == nil then
                    color = "FFFFFFFF"
                end

                self.mImgTitle01.color = gs.ColorUtil.GetColor(color)
            end
            self:onDebugInfo()
        end
        self:updateShowActivetyTimer()
    end
end

function clearHeroSpine(self)
    if (self.m_heroSpineGo and not gs.GoUtil.IsGoNull(self.m_heroSpineGo)) then
        gs.GOPoolMgr:Recover(self.m_heroSpineGo, self.m_heroSpinePath)
        self.m_heroSpineGo = nil
    end
end

-- 已招募次数
function getRecruitTimes(self)
    return self.m_recruitInfo.recruit_activity_times
end
-- 需要招募次数
function getNeedTimes(self)
    return self.m_recruitInfo.guaranteed_limit
end

function onModuleRedUpdate(self)
    local actBraceletsShopRedState = recruit.RecruitManager:updateSeniorAppActRedState()
    if actBraceletsShopRedState then
        RedPointManager:add(self:getChildTrans("BtnSeniorApp"), nil, 15, 15)
    else
        RedPointManager:remove(self:getChildTrans("BtnSeniorApp"))
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]

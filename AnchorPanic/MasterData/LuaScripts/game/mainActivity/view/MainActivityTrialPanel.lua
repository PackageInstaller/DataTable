--[[
-----------------------------------------------------
@filename       : MainActivityTrialPanel
@Description    : 活动主界面
@date           : 2023-5-22 15:59:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("mainActivity.MainActivityTrialPanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("mainActivity/MainActivityTrialPanel.prefab")
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(92033))
    self:setUICode(LinkCode.MainActivityTrial)
end
-- 初始化数据
function initData(self)
    super.initData(self)

    self.mPropsGrids = {}
end
-- 初始化
function configUI(self)
    super.configUI(self)
    self.mBtnTrial = self:getChildGO("mBtnTrial")
    -- self.mBtnDetails = self:getChildGO("mBtnDetails")
    self.mItemContent = self:getChildTrans("mItemContent")
    -- self.mTextActivityTime = self:getChildGO("mTextActivityTime"):GetComponent(ty.Text)
    self.mTextTips = self:getChildGO("mTextTips"):GetComponent(ty.Text)

    -- self.mImgPro = self:getChildGO("mImgPro"):GetComponent(ty.AutoRefImage)
    -- self.mImgEleType = self:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)

    self.mchildPanel = self:getChildTrans("mchildPanel")

    self.mTextTrial = self:getChildGO("mTextTrial"):GetComponent(ty.Text)
end
-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})

    self.m_recruitId = args.recruit_id
    if self.m_recruitId == nil then
        if not args.dupId then
            logError("试玩传入的 recruit_id 为空，dupId 也为空请检查逻辑")
            return
        else

            local actTopRecruitList = recruit.RecruitManager:getRecruitConfigListByType(recruit.RecruitType.RECRUIT_ACTIVITY_1)
            for _, configVo in pairs(actTopRecruitList) do
                if configVo:getTry_hero() == args.dupId then
                    self.m_recruitId = configVo.id
                    break
                end
            end
        end
    end

    self:loadChildPanel()

    local configVo = recruit.RecruitManager:getRecruitConfigVo(self.m_recruitId)
    self.m_dupId = configVo:getTry_hero()

    local isReceive = not recruit.RecruitManager:getIsShowTrial(self.m_dupId)

    self:clearProps()
    local trial_configVo = mainActivity.MainActivityManager:getTrialConfigVo(self.m_dupId)
    if trial_configVo then
        local awardList = trial_configVo.first_award
        for i = 1, #awardList do
            local propsGrid = PropsGrid:createByData({tid = awardList[i][1], num = awardList[i][2], parent = self.mItemContent, scale = 0.65, showUseInTip = true})
            propsGrid:setHasRec(isReceive)
            table.insert(self.mPropsGrids, propsGrid)
        end
    end

    local menuConfigVo = recruit.RecruitManager:getRecruitMenuVo(self.m_recruitId)
    local md, hm = TimeUtil.getMDHByTime2(TimeUtil.transTime(menuConfigVo.endTime))
    self.mTextActivityTime.text = _TT(85009, md .. " " .. hm)

    local configHeroVo = hero.HeroManager:getHeroConfigVo(configVo:getTrailHero_id())
    self.mImgEleType:SetImg(UrlManager:getHeroEleTypeIconUrl(configHeroVo.eleType), false)
    self.mImgPro:SetImg(UrlManager:getHeroJobSmallIconUrl(configHeroVo.professionType), false)
    self.mTextHeroName.text = configHeroVo.name

end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    MoneyManager:setMoneyTidList()
    self:clearProps()

    if (self.m_childPanelGo and not gs.GoUtil.IsGoNull(self.m_childPanelGo)) then
        gs.GOPoolMgr:Recover(self.m_childPanelGo, self.mChildPanelPath)
        self.m_childPanelGo = nil

        self.m_childPanelGos, self.m_childPanelTrans = nil, nil
    end
end

function loadChildPanel(self)
    local res_list = {101, 111, 112}

    local go_dic = {}
    for i = 1, #res_list do
        local go = self:getChildGO("MainActivityTrial_" .. res_list[i])
        go:SetActive(res_list[i] == self.m_recruitId)
        go_dic[res_list[i]] = go
    end

    self.m_childPanelGo = go_dic[self.m_recruitId]

    gs.TransQuick:SetParentOrg(self.m_childPanelGo.transform, self.mchildPanel)
    gs.TransQuick:UIPos(self.m_childPanelGo:GetComponent(ty.RectTransform), 0, 0)

    self.m_childPanelGos, self.m_childPanelTrans = GoUtil.GetChildHash(self.m_childPanelGo)

    self.mBtnDetails = self.m_childPanelGos["mBtnDetails"]
    self.mTextActivityTime = self.m_childPanelGos["mTextActivityTime"]:GetComponent(ty.Text)

    self.mImgPro = self.m_childPanelGos["mImgPro"]:GetComponent(ty.AutoRefImage)
    self.mImgEleType = self.m_childPanelGos["mImgEleType"]:GetComponent(ty.AutoRefImage)
    self.mTextHeroName = self.m_childPanelGos["mTextHeroName"]:GetComponent(ty.Text)

    self:addUIEvent(self.mBtnDetails, self.onClickDetails)
end

--删除预制体
function clearProps(self)
    if #self.mPropsGrids > 0 then
        for i, _ in ipairs(self.mPropsGrids) do
            self.mPropsGrids[i]:poolRecover()
        end
        self.mPropsGrids = {}
    end
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTextTips.text = _TT(92017)
    self.mTextTrial.text = _TT(29115)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnTrial, self.onClickTrial)
end

function onClickDetails(self)
    local configVo = recruit.RecruitManager:getRecruitConfigVo(self.m_recruitId)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_RECRUITINFOPANEL, {heroTid = configVo:getTrailHero_id()})
end

function onClickTrial(self)
    if subPack.SubDownLoadController:isExistNeedUpdate() then
        gs.Message.Show("请等待资源下载完成获得最佳体验")
        return
    end
    recruit.RecruitManager:setRecruitActionId(self.m_recruitId)
    UIFactory:alertMessge(_TT(28034), true, function()
        fight.FightManager:reqBattleEnter(PreFightBattleType.HeroTrial, self.m_dupId)
    end, _TT(1), nil, true, nil, _TT(2))
end

function __closeOpenAction(self)
    if self.isPop == 1 then
        self:close()
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]

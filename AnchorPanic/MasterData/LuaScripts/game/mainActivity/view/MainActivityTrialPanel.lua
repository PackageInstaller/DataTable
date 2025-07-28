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
    self:setTxtTitle("角色试玩")
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
    self.mBtnDetails = self:getChildGO("mBtnDetails")
    self.mItemContent = self:getChildTrans("mItemContent")
    self.mTextActivityTime = self:getChildGO("mTextActivityTime"):GetComponent(ty.Text)
    self.mTextTips = self:getChildGO("mTextTips"):GetComponent(ty.Text)

    self.mImgPro = self:getChildGO("mImgPro"):GetComponent(ty.AutoRefImage)
    self.mImgEleType = self:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)
end
-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})

    local isReceive = args.is_pass == 1
    self.m_dupId = args.dup_id

    self:clearProps()

    local baseData = RefMgr:getData("try_hero_data")
    local configVo = baseData[self.m_dupId]
    if configVo then
        local awardList = configVo.first_award
        for i = 1, #awardList do
            local propsGrid = PropsGrid:createByData({tid = awardList[i][1], num = awardList[i][2], parent = self.mItemContent, scale = 0.65, showUseInTip = true})
            propsGrid:setHasRec(isReceive)
            table.insert(self.mPropsGrids, propsGrid)
        end
    end

    local menuConfigVo = recruit.RecruitManager:getRecruitMenuVo(recruit.RecruitType.RECRUIT_ACTIVITY_1)
    local md, hm = TimeUtil.getMDHByTime2(TimeUtil.transTime(menuConfigVo.endTime))
    self.mTextActivityTime.text = _TT(85009, md .. " " .. hm)

    local recruitConfigVo = recruit.RecruitManager:getRecruitConfigVo(recruit.RecruitType.RECRUIT_ACTIVITY_1)
    local configHeroVo = hero.HeroManager:getHeroConfigVo(recruitConfigVo:getTrailHero_id())

    self.mImgEleType:SetImg(UrlManager:getHeroEleTypeIconUrl(configHeroVo.eleType), false)
    self.mImgPro:SetImg(UrlManager:getHeroJobSmallIconUrl(configHeroVo.professionType), false)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    MoneyManager:setMoneyTidList()
    self:clearProps()
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
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnDetails, self.onClickDetails)
    self:addUIEvent(self.mBtnTrial, self.onClickTrial)
end

function onClickDetails(self)
    local configVo = recruit.RecruitManager:getRecruitConfigVo(recruit.RecruitType.RECRUIT_ACTIVITY_1)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_RECRUITINFOPANEL, {heroTid = configVo:getTrailHero_id()})
end

function onClickTrial(self)
    UIFactory:alertMessge(_TT(28034), true, function()
        fight.FightManager:reqBattleEnter(PreFightBattleType.HeroTrial, self.m_dupId)
    end, nil, nil, true)
end

function __closeOpenAction(self)
    if self.isPop == 1 then
        self:close()
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]

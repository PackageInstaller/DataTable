--[[ 
-----------------------------------------------------
@filename       : DupImpliedDupInfoView
@Description    : 默示之境副本信息
@date           : 2021-07-06 17:29:10
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_implied.view.DupImpliedDupInfoView', Class.impl("lib.component.BaseContainer"))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupImplied/DupImpliedDupInfoView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.skillList = {}
    self.featuresList = {}
    self.mItemList = {}
end

-- 初始化
function configUI(self)
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mTxtId = self:getChildGO('mTxtId'):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO('mTxtName'):GetComponent(ty.Text)
    self.mTxtStageName = self:getChildGO('mTxtStageName'):GetComponent(ty.Text)

    self.mTxtRountTimeLab = self:getChildGO('mTxtRountTimeLab'):GetComponent(ty.Text)
    self.mTxtHistoryTimeLab = self:getChildGO('mTxtHistoryTimeLab'):GetComponent(ty.Text)
    self.mTxtHistoryTime = self:getChildGO('mTxtHistoryTime'):GetComponent(ty.Text)
    self.mTxtRountTime = self:getChildGO('mTxtRountTime'):GetComponent(ty.Text)
    self.mTxtSkill = self:getChildGO('mTxtSkill'):GetComponent(ty.Text)
    self.mTxtSkillEn = self:getChildGO('mTxtSkillEn'):GetComponent(ty.Text)
    self.mGroupSkill = self:getChildTrans("mGroupSkill")
    self.mTxtSpecial = self:getChildGO('mTxtSpecial'):GetComponent(ty.Text)
    self.mTxtSpecialEn = self:getChildGO('mTxtSpecialEn'):GetComponent(ty.Text)
    self.mGroupSpecial = self:getChildTrans("mGroupSpecial")

    -- self.mTxtAward = self:getChildGO('mTxtAward'):GetComponent(ty.Text)
    -- self.mTxtAwardEn = self:getChildGO('mTxtAwardEn'):GetComponent(ty.Text)
    self.mGroupAward = self:getChildTrans("mGroupAward")

    self.mTxtStamina = self:getChildGO('mTxtStamina'):GetComponent(ty.Text)
    self.mTxtPass = self:getChildGO('mTxtPass'):GetComponent(ty.Text)
    self.mImgStamina = self:getChildGO('mImgStamina'):GetComponent(ty.AutoRefImage)
    self.mGroupCost = self:getChildTrans("mGroupCost")

    self.mBtnFight = self:getChildGO('mBtnFight')
    self.mBtnPass = self:getChildGO('mBtnPass')

    -- self.mImgLineHistoryTime = self:getChildGO('mImgLineHistoryTime')
    -- self.mImgLineRountTime = self:getChildGO('mImgLineRountTime')

end

--激活
function active(self)
    super.active(self)
    self:addOnClick(self.mBtnFight, self.onFightHandler)
    self:addOnClick(self.mBtnClose, self.onCloseHandler)

    self.mTxtHistoryTimeLab.text = _TT(42103) -- "历史最短通关："
    self.mTxtRountTimeLab.text = _TT(42104) --"本轮通关："
    self.mTxtSkill.text = _TT(27137)--"首领BOSS技能"
    self.mTxtSkillEn.text = _TT(27138)--"BOSS SKILLS"
    self.mTxtSpecial.text = _TT(27139)--"首领BOSS特性"
    self.mTxtSpecialEn.text = _TT(27140)--"BOSS CHARACTERISTIC"
    self.mTxtPass.text = _TT(27142)--已通关

    self:setBtnLabel(self.mBtnFight, 27104, "进入挑战")

    stamina.StaminaManager:addEventListener(stamina.StaminaManager.EVENT_STAMINA_UPDATE, self.onStaminaUpdateHandler, self)
end

--非激活
function deActive(self)
    super.deActive(self)
    self:removeOnClick(self.mBtnFight)
    self:recoverItem()
    self:recoverFeaturesItem()

    stamina.StaminaManager:removeEventListener(stamina.StaminaManager.EVENT_STAMINA_UPDATE, self.onStaminaUpdateHandler, self)
end

-- 体力更新
function onStaminaUpdateHandler(self)
    self:updateCost()
end

function show(self, parent, cusDupId)
    self:setParentTrans(parent)
    self:setData(cusDupId)
end

function setData(self, cusDupId)
    self.mId = cusDupId

    self.mDupData = dup.DupImpliedManager:getDupVo(cusDupId)
    self.mDupInfo = dup.DupImpliedManager:getDupInfo(cusDupId)

    self.mTxtId.text = string.format("%02d", self.mDupData.sort)
    self.mTxtName.text = self.mDupData:getName()
    self.mTxtStageName.text = self.mDupData:getStageName()
    -- self.mTxtInfo.text = self.mDupData:getDescribe()
    if self.mDupInfo.histroyPassTime <= 0 then
        self.mTxtHistoryTime.text = "--"
        -- self.mImgLineHistoryTime:SetActive(true)
    else
        -- self.mImgLineHistoryTime:SetActive(false)
        self.mTxtHistoryTime.text = TimeUtil.getMSByTime    (self.mDupInfo.histroyPassTime)
    end
    if self.mDupInfo.roundPassTime <= 0 then
        self.mTxtRountTime.text = "--"
        -- self.mImgLineRountTime:SetActive(true)
        -- self.mTxtAward.text = "首通奖励"--_TT()
        -- self.mTxtAwardEn.text = "REWARD FIRST"--_TT()
        self.mBtnFight:SetActive(true)
        self.mBtnPass:SetActive(false)
    else
        -- self.mImgLineRountTime:SetActive(false)
        self.mTxtRountTime.text = TimeUtil.getMSByTime(self.mDupInfo.roundPassTime)
        -- self.mTxtAward.text = "奖励预览"--_TT(116)
        -- self.mTxtAwardEn.text = "REWARD PREVIEW"--_TT()
        self.mBtnFight:SetActive(false)
        self.mBtnPass:SetActive(true)
    end

    -- self:updateSkill()
    -- self:updateFeatures()
    self:updateAward()
    self:updateCost()
end
-- boss技能
function updateSkill(self)
    self:recoverItem()
    local list = {}
    for i, v in ipairs(self.mDupData:getBossSkillList()) do
        local skillVo = fight.SkillManager:getSkillRo(v)
        if skillVo:getType() ~= 0 then
            table.insert(list, v)
        end
    end
    for i, v in ipairs(list) do
        local skillVo = fight.SkillManager:getSkillRo(v)
        local item = SimpleInsItem:create(self:getChildGO("GroupSkillItem"), self.mGroupSkill, "InfiniteCityBossSkillItem")
        item:getChildGO("mImgSkill"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()))
        item:addUIEvent("mGroup", function()
            TipsFactory:skillTips(nil, v, nil, true)
        end)
        table.insert(self.skillList, item)
    end
end
-- 回收项
function recoverItem(self)
    if self.skillList then
        for i, v in pairs(self.skillList) do
            v:poolRecover()
        end
    end
    self.skillList = {}
end

-- boss特性
function updateFeatures(self)
    self:recoverFeaturesItem()
    for i, v in ipairs(self.mDupData:getFeaturesList()) do
        local item = SimpleInsItem:create(self:getChildGO("GroupSpecialItem"), self.mGroupSpecial, "InfiniteCityBossSpecialItem")
        item:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(string.format("infiniteCity/infiniteCity_%d.png", 52 + v[1])))
        item:setText("mTxtInfo", v[2], "")
        table.insert(self.featuresList, item)
    end
end
-- 回收项
function recoverFeaturesItem(self)
    if self.featuresList then
        for i, v in pairs(self.featuresList) do
            v:poolRecover()
        end
    end
    self.featuresList = {}
end

function updateAward(self)
    self:recoverAwardItem()
    local list = self.mDupData.showDrop
    for i, vo in ipairs(list) do
        local propsGrid = PropsGrid:create(self.mGroupAward, { vo.tid, vo.num }, 1, false)
        table.insert(self.mItemList, propsGrid)
        propsGrid:setHasRec(self.mDupInfo.firstPassFlag == 1)
    end
end
-- 回收项
function recoverAwardItem(self)
    for i = #self.mItemList, 1, -1 do
        local item = self.mItemList[i]
        item:poolRecover()
    end
    self.mItemList = {}
end

-- 更新消耗
function updateCost(self)
    if self.mDupData.needNum <= 0 then
        self.mGroupCost.gameObject:SetActive(false)
        return
    end
    self.mGroupCost.gameObject:SetActive(true)
    self.mImgStamina:SetImg(UrlManager:getPropsIconUrl(self.mDupData.needTid), false)

    local color = ColorUtil.WHITE_NUM
    if not MoneyUtil.judgeNeedMoneyCountByType(MoneyType.ANTIEPIDEMIC_SERUM_TYPE, self.mDupData.needNum, false, false) then
        color = ColorUtil.RED_NUM
    end
    self.mTxtStamina.text = HtmlUtil:color(self.mDupData.needNum, color)
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mGroupCost)--立即刷新
end

function onFightHandler(self)
    stamina.StaminaManager:checkStamina(PreFightBattleType.DupImplied, nil, self.mDupData.needNum, function()
        formation.checkFormationFight(PreFightBattleType.DupImplied, nil, self.mDupData.dupId, formation.TYPE.DUPIMPLIED, nil, { stage = self.mDupData.stage })
        self:onCloseHandler()
    end, self)

end

function onCloseHandler(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_DUP_IMPLIED_DUP_INFO_VIEW)
end

-- 播放UI入场动效
function showUpdateUIAnimator(self)
    local anim = self.UIObject:GetComponent(ty.Animator)
    if not gs.GoUtil.IsCompNull(anim) then
        anim:SetTrigger("exit")
    end
end

-- 播放UI入场动效
function showExitUIAnimator(self)
    local anim = self.UIObject:GetComponent(ty.Animator)
    if not gs.GoUtil.IsCompNull(anim) then
        anim:SetTrigger("show")
    end
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]
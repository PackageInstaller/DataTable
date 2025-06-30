--[[ 
-----------------------------------------------------
@filename       : DupDailyInfoView
@Description    : 日常副本详情
@date           : 2021-01-28 17:13:57
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('dup.DupDailyInfoView', Class.impl("lib.component.BaseContainer"))

UIRes = UrlManager:getUIPrefabPath("dupDaily/DupDailyInfoView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

function getAdaptaTrans(self)
    --return self.base_childTrans["mGroupTop"]
end

-- 初始化数据
function initData(self)
    self.mItemList = {}
    self.mFirstItemList = {}
    self.mSignList = {}
    self.mMultiTime = sysParam.SysParamManager:getValue(SysParamType.DUP_MULTI)

    self.mMultiStorageKey = "DupDailyMultiKey"
end

--初始化UI
function configUI(self)
    self.mTxtInfo = self:getChildGO('TextStageDes'):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO('TextStageId'):GetComponent(ty.Text)
    self.mTxtStageName = self:getChildGO('TextStageName'):GetComponent(ty.Text)

    -- self.mTxtTimes = self:getChildGO('mTxtTimes'):GetComponent(ty.Text)
    self.mTxtStamina = self:getChildGO('mTxtStamina'):GetComponent(ty.Text)
    -- self.mTxtFight = self:getChildGO('mTxtFight'):GetComponent(ty.Text)
    self.mTxtDrop = self:getChildGO('TextAwardTitle'):GetComponent(ty.Text)
    self.mImgStamina = self:getChildGO('mImgStamina'):GetComponent(ty.AutoRefImage)
    self.mGroupCost = self:getChildTrans("mGroupCost")

    self.mImgToucher = self:getChildGO('mImgToucher')
    self.mBtnFight = self:getChildGO('mBtnFight')

    self.mToggleMulti = self:getChildGO('mToggleMulti'):GetComponent(ty.Toggle)
    self.mToggleLabel = self:getChildGO('mToggleLabel'):GetComponent(ty.Text)

    self.mToggleImg =  self:getChildGO('TogImg'):GetComponent(ty.AutoRefImage)

    self.mScroller = self:getChildGO('Scroller'):GetComponent(ty.ScrollRect)
    self.mScrollContent = self.mScroller.content

    self.mFirstScroller = self:getChildGO('mFirstScroller'):GetComponent(ty.ScrollRect)
    self.mFirstScrollContent = self.mFirstScroller.content

    self.mGoReceiveSign = self:getChildGO("mGoReceiveSign")
    self:setGuideTrans("guide_DupDailyInfo_mBtnFight", self:getChildTrans("mBtnFight"))
end

--激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID})
    self:addOnClick(self.mImgToucher, self.onCloseHandler)
    self:addOnClick(self.mBtnFight, self.onFightHandler)

    local function onToggle()
        self:toggleChange()
    end
    self.mToggleMulti.onValueChanged:AddListener(onToggle)

    stamina.StaminaManager:addEventListener(stamina.StaminaManager.EVENT_STAMINA_UPDATE, self.onStaminaUpdateHandler, self)
end

--非激活
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    self:removeOnClick(self.mImgToucher, self.onCloseHandler)
    self:removeOnClick(self.mBtnFight, self.onFightHandler)

    self.mToggleMulti.onValueChanged:RemoveAllListeners()

    stamina.StaminaManager:removeEventListener(stamina.StaminaManager.EVENT_STAMINA_UPDATE, self.onStaminaUpdateHandler, self)
end

function show(self, parent, cusVo)
    self:setParentTrans(parent)
    self:setData(cusVo)
end

-- 体力更新
function onStaminaUpdateHandler(self)
    self:updateCost()
end

-- 多倍挑战选择
function toggleChange(self)
    self:updateCost()
    self:updateItem()

    if self.mToggleMulti.isOn then
        self.mToggleImg:SetImg(UrlManager:getCommon4Path("common_3413.png"))
    else
        self.mToggleImg:SetImg(UrlManager:getCommon4Path("common_3414.png"))
    end

    StorageUtil:saveString0(self.mMultiStorageKey, (self.mToggleMulti.isOn and "1" or "0"))
end

function setData(self, cusVo)
    self.mConfigVo = cusVo
    self.mDupData = dup.DupMainManager:getDupInfoData(self.mConfigVo.type)
    self.mTxtName.text = _TT(122,self.mConfigVo.name) 
    self.mTxtStageName.text = self.mConfigVo:getStageName()
    self.mTxtInfo.text = self.mConfigVo:getExplain()

    -- self.mTxtFight.text = string.format("推荐战力：%d", self.mConfigVo.power)
    -- self.mTxtTimes.text = string.substitute("本日剩余任务次数：{0}", self.mDupData.passTimes)
    self.mTxtDrop.text = _TT(116) --通关奖励
    self:setBtnLabel(self.mBtnFight, 123, "开始挑战")

    -- self.mToggleLabel.text = string.format("%s倍挑战", self.mMultiTime)
    self.mToggleLabel.text = _TT(126, self.mMultiTime)

    -- self.mDupData.curId == 0 or self.mDupData.curId > self.mConfigVo.dupId and -- 已通关
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_DUP_MULTI) then
        self.mToggleMulti.gameObject:SetActive(true)
        self.mToggleMulti.isOn = StorageUtil:getString0(self.mMultiStorageKey) == "1"
    else
        self.mToggleMulti.gameObject:SetActive(false)
    end

    self:updateCost()
    self:updateItem()
end

function updateCost(self)
    self.mImgStamina:SetImg(UrlManager:getPropsIconUrl(self.mConfigVo.needTid), false)
    local cost = self.mConfigVo.needNum * (self.mToggleMulti.isOn and self.mMultiTime or 1)

    local color = ColorUtil.PURE_WHITE_NUM
    if not MoneyUtil.judgeNeedMoneyCountByType(MoneyType.ANTIEPIDEMIC_SERUM_TYPE, cost, false, false) then
        color = ColorUtil.RED_NUM
    end

    self.mTxtStamina.text = HtmlUtil:color(cost, color)
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mGroupCost)--立即刷新
end

function updateItem(self)
    self:removeItem()
    for i = 1, #self.mConfigVo.showDrop do
        local vo = self.mConfigVo.showDrop[i]
        local num = vo.num >= 1 and vo.num * (self.mToggleMulti.isOn and self.mMultiTime or 1) or 1
        local propsGrid = PropsGrid:create(self.mScrollContent, { vo.tid, num }, 0.6)
        -- propsGrid:setPosition(math.Vector3((i - 1) * 130 + 70, 0, 0))
        table.insert(self.mItemList, propsGrid)
    end

    self.mFirstScroller.gameObject:SetActive(#self.mConfigVo.showExtraDrop>0)

    for i = 1, #self.mConfigVo.showExtraDrop do
        local vo = self.mConfigVo.showExtraDrop[i]
        local num = vo.num > 1 and vo.num 
        local propsGrid = PropsGrid:create(self.mFirstScrollContent, { vo.tid, num }, 0.6, false)
        table.insert(self.mFirstItemList, propsGrid)
        --已经通过
        if self.mDupData.curId == 0 or self.mDupData.curId > self.mConfigVo.dupId then
            local signItem = SimpleInsItem:create(self.mGoReceiveSign, propsGrid:getTrans(),"DupDailyInfoViewmGoReceiveSign")
            propsGrid:setIconGray(true)
            table.insert(self.mSignList, signItem)
        end
    end
end

function removeItem(self)
    for i = #self.mItemList, 1, -1 do
        local item = self.mItemList[i]
        item:poolRecover()
        table.remove(self.mItemList, i)
    end

    if (self.mSignList) then
        for i = #self.mSignList, 1, -1 do
            local item = self.mSignList[i]
            item:poolRecover()
        end
    end
    self.mSignList = {}

    for i = #self.mFirstItemList, 1, -1 do
        local item = self.mFirstItemList[i]
        item:poolRecover()
        table.remove(self.mFirstItemList, i)
    end
    self.mFirstItemList={}
end

function onFightHandler(self)
    if not dup.DupDailyUtil:getDupMgr(self.mConfigVo.type):isOpenDate(self.mConfigVo.openDate) then
        gs.Message.Show(_TT(4525))
        return
    end

    local battleType = dup.DupDailyUtil:getBattleType(self.mConfigVo.type)
    local isEnough = stamina.StaminaManager:checkStamina(battleType, nil, self.mConfigVo.needNum * (self.mToggleMulti.isOn and self.mMultiTime or 1), self.__sendFight, self)
end

function __sendFight(self)
    local battleType = dup.DupDailyUtil:getBattleType(self.mConfigVo.type)
    -- mgr:dispatchEvent(preFight.BaseManager.OPEN_PRE_FIGHT_PANEL, self.mConfigVo.dupId)
    local roleLv = role.RoleManager:getRoleVo():getPlayerLvl()
    -- if self.mDupData.passTimes <= 0 then
    --     -- gs.Message.Show('没有剩余次数')
    --     gs.Message.Show(_TT(118))
    -- else
    if self.mDupData.curId ~= 0 and self.mConfigVo.dupId > self.mDupData.curId then
        -- gs.Message.Show('前置关卡未通关')
        gs.Message.Show(_TT(119))
    elseif self.mConfigVo.enterLv > roleLv then
        -- gs.Message.Show(self.mConfigVo.enterLv .. '级开启副本')
        gs.Message.Show(_TT(121, self.mConfigVo.enterLv))
    else
        dup.DupDailyUtil:getDupMgr(self.mConfigVo.type).enterCurId = self.mDupData.curId -- 记录本次进入副本的当前可挑战id，出来的时候对比用
        GameDispatcher:dispatchEvent(EventName.CLOSE_DAILY_DUP_INFO, self.mConfigVo.type)
        local multiTime = self.mToggleMulti.isOn and self.mMultiTime or 1
        formation.checkFormationFight(battleType, nil, self.mConfigVo.dupId, nil, nil, nil, nil, multiTime)
    end
end

function onCloseHandler(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_DAILY_DUP_INFO, self.mConfigVo.type)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(4525):	"未达副本开放时间"
]]

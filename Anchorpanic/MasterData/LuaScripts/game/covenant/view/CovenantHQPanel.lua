--[[ 
-----------------------------------------------------
@filename       : ConvenantHQPanel
@Description    : 盟约总部界面
@date           : 2021-06-15 14:12:00
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] module("covenant.CovenantHQPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("covenant/CovenantHQPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(29563))
    self:setBg("")
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mLockList = {}
    self.mPropsItems = {}
    self.mLevelDatas = {}
    -- self.mSkillList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mScrollViewContent = self:getChildTrans("mScrollViewContent")
    -- 右侧声望部分
    -- last
    self.mGroupLast = self:getChildGO("mGroupLast")
    self.mTxtLastLevel = self:getChildGO("mTxtLastLevel"):GetComponent(ty.Text)
    -- now
    self.mTxtCusLevel = self:getChildGO("mTxtCusLevel"):GetComponent(ty.Text)
    self.mTxtLevel = self:getChildGO("mTxtLevel"):GetComponent(ty.Text)
    self.mTxtPrestige = self:getChildGO("mTxtPrestige"):GetComponent(ty.Text)

    self.mImgReqSliderBg = self:getChildGO("mImgReqSliderBg"):GetComponent(ty.RectTransform)
    self.mImgReqSlider = self:getChildGO("mImgReqSlider"):GetComponent(ty.RectTransform)
    self.mTxtReqLevel = self:getChildGO("mTxtReqLevel"):GetComponent(ty.Text)

    self.mTxtAward = self:getChildGO("mTxtAward"):GetComponent(ty.Text)
    self.mAwardContent = self:getChildTrans("mAwardContent")
    self.mBtnGet = self:getChildGO("mBtnGet")

    self.mBtnNoGet = self:getChildGO("mBtnNoGet")

    self.mBtnNotGet = self:getChildGO("mBtnNotGet")
    self.mLockItem = self:getChildGO("mLockItem")
    -- new
    self.mGroupNew = self:getChildGO("mGroupNew")
    self.mTxtNewLevel = self:getChildGO("mTxtNewLevel"):GetComponent(ty.Text)

    self.mTxtUnLock = self:getChildGO("mTxtUnLock")
    self.mImgUnLock = self:getChildGO("mImgUnLock")

    self.mGroupLockInfo = self:getChildTrans("mGroupLockInfo")

    self:setGuideTrans("guide_covenantHQ_get" , self.mBtnGet.transform)

    -- 左侧
    -- self.mSkillContent = self:getChildTrans("mSkillContent")
end

-- 激活
function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_COVENANT_HQ_PANEL, self.updateView, self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID}, 2)
    self:updateView()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_COVENANT_HQ_PANEL, self.updateView, self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID}, 1)
    self:clearAllItems()
end

function initViewText(self)

    self:setBtnLabel(self.mBtnNoGet, 1040, "升级")
    self:setBtnLabel(self.mBtnGet, 1040, "升级")
    self.mTxtLevel.text = _TT(1361) -- "等阶"
    self.mTxtPrestige.text = _TT(29542) -- "声望"
    self.mTxtAward.text = _TT(29543) -- "奖励"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnGet, self.onGetBtnClick)
    self:addUIEvent(self.mBtnNoGet, self.onGetBtnClick)
end

-- 获取按钮
function onGetBtnClick(self)
    local nextExp = covenant.CovenantManager:getCovenantPrestigeData()[self.cusLevel].next_exp
    if (nextExp == 0) then
        gs.Message.Show(_TT(1081)) -- "满级"
    else
        if (self.cusPeq < nextExp) then
            gs.Message.Show(_TT(41027)) -- "未达成"
        else
            GameDispatcher:dispatchEvent(EventName.REQ_GET_PRESTIGE_AWARD)
        end
    end
end

function updateView(self, args)
    if args == nil then
        self:updateInfoView()
    else
        self:updateInfoView(args.id)
    end
end

function updateInfoView(self, level)
    if level ~= nil then
        self.cusLevel = level
    end
    self:clearAllItems()
    self:updateProgressView()

    self.mGroupLast:SetActive(true)
    self.mGroupNew:SetActive(true)
    self.mTxtLastLevel.text = self.cusLevel - 1
    self.mTxtNewLevel.text = self.cusLevel + 1

    if (self.cusLevel == 1) then
        self.mGroupLast:SetActive(false)
    elseif (self.cusLevel == sysParam.SysParamManager:getValue(SysParamType.COVENANT_MAXLV)) then
        self.mGroupNew:SetActive(false)
        self.mBtnGet:SetActive(false)
        self.mBtnNoGet:SetActive(false)
    end
    local prestigeData = covenant.CovenantManager:getCovenantPrestigeData()
    -- 锁定信息
    for i = 1, #prestigeData[self.cusLevel].describe_list do
        local go = SimpleInsItem:create(self.mLockItem, self.mGroupLockInfo, "LockInfo")
        local lockImg = go:getChildGO("mImgLock"):GetComponent(ty.AutoRefImage)
        local infoTxt = go:getChildGO("mTxtInfo"):GetComponent(ty.Text)

        -- 到达指定等级解锁
        local url = nil
        local targetLv = 999999999
        if self.cusLevel <= targetLv then
            url = "covenant/covenant_head_4.png"
        else
            url = "common5/common_5239.png"
        end
        lockImg:SetImg(UrlManager:getPackPath(url, false))
        infoTxt.text = _TT(prestigeData[self.cusLevel].describe_list[i])
        gs.TransQuick:UIPos(go:getTrans(), (i - 1) * 21.4, -(i - 1) * 46.5)
        table.insert(self.mLockList, go)
    end

    self.mImgUnLock:SetActive(#self.mLockList > 0)
    self.mGroupLockInfo.gameObject:SetActive(#self.mLockList > 0)

    local reward = AwardPackManager:getAwardListById(prestigeData[self.cusLevel].reward)
    for i = 1, #reward do
        local rewardVo = reward[i]
        local propsGrid = PropsGrid:create(self.mAwardContent, {rewardVo.tid, rewardVo.num}, 1)
        table.insert(self.mPropsItems, propsGrid)
    end

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mGroupLockInfo.transform) -- 立即刷新
end

function updateProgressView(self)
    self.cusLevel = covenant.CovenantManager:getPerstigeStage()
    self.mTxtCusLevel.text = self.cusLevel

    self.cusPeq = covenant.CovenantManager:getPrestigeExp()
    local prestigeData = covenant.CovenantManager:getCovenantPrestigeData()

    self.mTxtReqLevel.text = self.cusPeq .. "/" .. prestigeData[self.cusLevel].next_exp

    self.cusForcesId = covenant.CovenantManager:getForcesId()

    local progress = nil
    if self.cusPeq >= prestigeData[self.cusLevel].next_exp then
        progress = prestigeData[self.cusLevel].next_exp

        self.mBtnGet:SetActive(true)
        self.mBtnNoGet:SetActive(false)
    else
        progress = self.cusPeq

        self.mBtnGet:SetActive(false)
        self.mBtnNoGet:SetActive(true)
    end
    gs.TransQuick:SizeDelta01(self.mImgReqSlider, progress / prestigeData[self.cusLevel].next_exp * (self.mImgReqSliderBg.sizeDelta.x))

    -- local selectData = covenant.CovenantManager:getCovenantSelectData(self.cusForcesId)

    -- for i=1,#selectData.skill do
    --     local skillItem = SkillGrid:create(self.mSkillContent, {skillId = selectData.skill[i]}, 1)
    --     table.insert(self.mSkillList, skillItem) 
    -- end
end

-- 清理锁子元素
function clearLockItems(self)
    for i = 1, #self.mLockList do
        self.mLockList[i]:recover()
    end
    self.mLockList = {}
end

-- 清理道具子元素
function clearPropsItem(self)
    for i = 1, #self.mPropsItems do
        self.mPropsItems[i]:poolRecover()
    end

    self.mPropsItems = {}
end

function clearPropsItem(self)
    for i = 1, #self.mPropsItems do
        self.mPropsItems[i]:poolRecover()
    end
    self.mPropsItems = {}
end

-- function clearSkillItem(self)
--     for i = 1, #self.mSkillList do
--         self.mSkillList[i]:poolRecover()
--     end
--     self.mSkillList = {}
-- end

function onCloseAllCall(self)
    super.onCloseAllCall(self)
    self:playerClose()
end

function onClickClose(self)
    super.onClickClose(self)
    self:playerClose()
end

function clearAllItems(self)
    self:clearLockItems()
    self:clearPropsItem()
    -- self:clearSkillItem()
end

function playerClose(self)
    GameDispatcher:dispatchEvent(EventName.CUSTOM_CONVENANT_SCENE_CHANGE)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

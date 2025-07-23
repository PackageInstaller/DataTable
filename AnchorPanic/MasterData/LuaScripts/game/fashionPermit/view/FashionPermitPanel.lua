--[[
-----------------------------------------------------
@filename       : PermitPanel
@Description    : 通行证
@date           : 2023-3-28 15:59:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]] module("fashionPermit.FashionPermitPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("fashionPermit/FashionPermitPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(98101))
    self:setSize(0, 0)
end
-- 初始化数据
function initData(self)
    super.initData(self)
    -- 阶段奖励道具列表
    self.mPropsList = {}
    self.mCurIndex = 0
end

function configUI(self)
    super.configUI(self)
    self.mBtnBuy = self:getChildGO("mBtnBuy")
    self.mBtnTask = self:getChildGO("mBtnTask")
    self.mImgUnlock = self:getChildGO("mImgUnlock")
    self.mBtnActive = self:getChildGO("mBtnActive")
    self.mBtnOneKey = self:getChildGO("mBtnOneKey")
    self.mEffectNode = self:getChildGO("mEffectNode")
    self.mTansStageMoney = self:getChildTrans("mTansStageMoney")
    self.mTansStageNomal = self:getChildTrans("mTansStageNomal")
    self.mTxtExUL = self:getChildGO("mTxtExUL"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mTxtExDsc = self:getChildGO("mTxtExDsc"):GetComponent(ty.Text)
    self.mTxtNextNum = self:getChildGO("mTxtNextNum"):GetComponent(ty.Text)
    self.mTxtPermitLv = self:getChildGO("mTxtPermitLv"):GetComponent(ty.Text)
    self.mProgressBar = self:getChildGO("mProgressBar"):GetComponent(ty.Image)
    self.mTxtShowProgress = self:getChildGO("mTxtShowProgress"):GetComponent(ty.Text)
    -- self.mImgShowHero = self:getChildGO("mImgShowHero"):GetComponent(ty.AutoRefImage)
    self.mScrollRect = self:getChildGO("mLyScroller"):GetComponent(ty.ScrollRect)
    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(fashionPermit.FashionPermitItem)

    self.mBtnShowSkin = self:getChildGO("mBtnShowSkin")

    self.mImgHeroHar = self:getChildGO("mImgHeroHar"):GetComponent(ty.AutoRefImage)
    -- self.mTxtModel = self:getChildGO("mTxtModel"):GetComponent(ty.Text)
     -- self.mTxtVoice = self:getChildGO("mTxtVoice"):GetComponent(ty.Text)
    self.mBtnHis = self:getChildGO("mBtnHis")
   
end

function onClickShowSkinHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_SKIN_SHOW_ONE_VIEW, {
        heroTid = self.heroTid,
        fashionId = self.fashionId,
        isShow3D = true
    })
end

function active(self, args)
    super.active(self, args)

 

    MoneyManager:setMoneyTidList({})

    GameDispatcher:addEventListener(EventName.UPDATE_FASHION_PERMIT_PANEL, self.updateView, self)

    self:updateView()
    self:updateTime()
    self:addTimer(1, 0, self.updateTime)

    -- local count = #permit.PermitManager:getPermitList() / 10
    -- local update = function(pos)
    --     local posX = math.abs(self.mScrollRect.content.transform.anchoredPosition.x) + self.mScrollRect.gameObject.transform.rect.width
    --     local width = self.mScrollRect.content.rect.width
    --     local curIndex = 10
    --     local stageWidth = (width / count)
    --     for i = 0, count do
    --         local stageWidthL = stageWidth * i
    --         local stageWidthR = (i <= count - 1) and ((i + 1) * stageWidth) or width
    --         if posX >= stageWidthL then
    --             curIndex = (i <= count - 1) and ((i + 1) * 10) or (i * 10)
    --         end
    --     end
    --     if self.mCurIndex ~= curIndex then
    --         self.mCurIndex = curIndex
    --         local stageVo = permit.PermitManager:getPermitList()[curIndex]
    --         self:updateStageInfo(stageVo)
    --     end
    -- end
    -- self.mScrollRect.onValueChanged:AddListener(update)
    local count = #fashionPermit.FashionPermitManager:getFashionPermitList() / 1
    local update = function(pos)
        local posX = math.abs(self.mScrollRect.content.transform.anchoredPosition.x) + self.mScrollRect.gameObject.transform.rect.width
        local width = self.mScrollRect.content.rect.width
        local curIndex = 1
        local stageWidth = (width / count)
        for i = 0, count do
            local stageWidthL = stageWidth * i
            local stageWidthR = (i <= count - 1) and ((i + 1) * stageWidth) or width
            if posX >= stageWidthL then
                curIndex = (i <= count - 1) and ((i + 1) * 1) or (i * 1)
            end
        end

        --local curIndex =  #fashionPermit.FashionPermitManager:getFashionPermitList()
        if self.mCurIndex ~= curIndex then
            local stageVo = fashionPermit.FashionPermitManager:getFashionPermitKeyData(curIndex)
            self:updateStageInfo(stageVo)
        end
    end
    self.mScrollRect.onValueChanged:AddListener(update)
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.UPDATE_FASHION_PERMIT_PANEL, self.updateView, self)
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
    self.mScrollRect.onValueChanged:RemoveAllListeners()
    RedPointManager:remove(self.mBtnOneKey.transform)
    RedPointManager:remove(self.mBtnTask.transform)

end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self.mTxtExDsc.text = "周经验上限"
    self:setBtnLabel(self.mBtnBuy, nil, _TT(98103))
    self:setBtnLabel(self.mBtnTask, nil, _TT(98104))
    self:setBtnLabel(self.mBtnActive, nil, _TT(98105))
    self:setBtnLabel(self.mBtnOneKey, nil, _TT(1176))

    self:getChildGO("mTxtHeroName"):GetComponent(ty.Text).text = _TT(98101)
    self:getChildGO("mTxtType"):GetComponent(ty.Text).text = _TT(98115)
    self:setBtnLabel(self.mBtnHis,nil,_TT(138512),"")
    -- self.mTxtModel.text = _TT(98107)
    -- self.mTxtVoice.text = _TT(98108)
end

function onClickBtnHisHandler(self)
    local prefixVersion =
    download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.PrefixVersionKey)

    local isShow = StorageUtil:getBool1(prefixVersion .. "hisFashionHisBuyFashionPermit") == true 
    if not isShow then
        StorageUtil:saveBool1(prefixVersion .. "hisFashionHisBuyFashionPermit", true)
        GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
        GameDispatcher:dispatchEvent(EventName.UPDATE_FASHION_HIS_RED)
        RedPointManager:remove(self.mBtnHis.transform)
    end

    GameDispatcher:dispatchEvent(EventName.OPEN_ACTIVITY_FASHION_HIS_VIEW,{type = activity.FashionHisType.FashionPermit})
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnActive, self.onClickActiveHandler)
    self:addUIEvent(self.mBtnBuy, self.onClickBuyHandler)
    self:addUIEvent(self.mBtnTask, self.onClickTaskHandler)
    self:addUIEvent(self.mBtnOneKey, self.onClickOneKeyReciveHandler)

    self:addUIEvent(self.mBtnShowSkin, self.onClickShowSkinHandler)
    self:addUIEvent(self.mBtnHis, self.onClickBtnHisHandler)
end

function updateView(self)

    self.heroTid = sysParam.SysParamManager:getValue(SysParamType.FASHIONPERMIT_INFO)[1]
    self.fashionId = sysParam.SysParamManager:getValue(SysParamType.FASHIONPERMIT_INFO)[2]
    
    self.mBtnActive:SetActive(fashionPermit.FashionPermitManager:getIsBuyFashionPermit() == false)
    local list = fashionPermit.FashionPermitManager:getFashionPermitList()
    if self.mLyScroller.Count <= 0 then
        self.mLyScroller.DataProvider = list
    else
        self.mLyScroller:ReplaceAllDataProvider(list)
    end
    self:updateState()

    -- local count = #fashionPermit.FashionPermitManager:getFashionPermitList()-- / 1
    -- local stageVo = fashionPermit.FashionPermitManager:getFashionPermitList()[count]
    -- self:updateStageInfo(stageVo)
    self.mLyScroller:SetItemIndex(fashionPermit.FashionPermitManager:getPermitIndex(), 0, 0, 0.1)
    
    -- 部分渠道需要特殊处理
    local isHar = (RefMgr:getSpecialConfig() and sdk.SdkManager:getIsChannelHarmonious())
    self.mImgHeroHar.gameObject:SetActive(isHar)
    self:getChildGO("Spine"):SetActive(not isHar)
    local fashionData = fashion.FashionManager:getHeroFashionConfigVo(fashion.Type.CLOTHES, self.heroTid, self.fashionId)
    self.mImgHeroHar:SetImg(UrlManager:getBgPath("heroRecord_Har/" .. fashionData:getUrlBody()))
end
function closeAllProps(self)
    if self.mPropsList then
        for _, item in ipairs(self.mPropsList) do
            item:poolRecover()
        end
        self.mPropsList = {}
    end
end

function onClickBuyHandler(self)
    if #fashionPermit.FashionPermitManager:getFashionPermitList() <=
        fashionPermit.FashionPermitManager:getFashionPermitedLv() then
        gs.Message.Show(_TT(4303))
    else
        GameDispatcher:dispatchEvent(EventName.OPEN_FASHIONPERMIT_BUY_PANEL)
    end
end

function onClickTaskHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FASHIONPERMIT_TASK_PANEL)
end

function onClickActiveHandler(self)
    local detailId = "1";

    local hasTid = hero.HeroManager:getHeroIdByTid(self.heroTid)
    if hasTid then
        if fashionPermit.FashionPermitManager:getFashionIsUnlock() then
            local vo = fashion.FashionManager:getHeroFashionConfigVo(0, self.heroTid, self.fashionId)
            UIFactory:alertMessge(_TT(98110, _TT(vo.fashionName)), true, function()
                recharge.sendRecharge(recharge.RechargeType.FASHION_PERMIT, nil, detailId)
            end, _TT(1), nil, true, function()
            end, _TT(2), _TT(5))
        else
            recharge.sendRecharge(recharge.RechargeType.FASHION_PERMIT, nil, detailId)
        end
    else
        UIFactory:alertMessge(_TT(98111), true, function()
            if fashionPermit.FashionPermitManager:getFashionIsUnlock() then
                local vo = fashion.FashionManager:getHeroFashionConfigVo(0, self.heroTid, self.fashionId)
                UIFactory:alertMessge(_TT(98110, _TT(vo.fashionName)), true, function()
                    recharge.sendRecharge(recharge.RechargeType.FASHION_PERMIT, nil, detailId)
                end, _TT(1), nil, true, function()
                end, _TT(2), _TT(5))
            else
                recharge.sendRecharge(recharge.RechargeType.FASHION_PERMIT, nil, detailId)
            end
        end, _TT(1), nil, true, function()
        end, _TT(2), _TT(5))
    end
    
end

function onClickOneKeyReciveHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_GAON_FASHION_PERMIT_REWARD_ALL)
end

function updateState(self)
    local curLv = fashionPermit.FashionPermitManager:getFashionPermitedLv()
    self.mBtnBuy:GetComponent(ty.AutoRefImage):SetGray(#fashionPermit.FashionPermitManager:getFashionPermitList() <=
                                                           curLv)
    self.mEffectNode:SetActive(#fashionPermit.FashionPermitManager:getFashionPermitList() > curLv)

    local curStageVo = fashionPermit.FashionPermitManager:getCurPermitKeyData()

    --local keyStageVo = fashionPermit.FashionPermitManager:getCurPermitStageData()
    self:updateStageInfo(curStageVo)
    self.mTxtPermitLv.text = HtmlUtil:size(curLv, 44)

    self.mImgUnlock:SetActive(fashionPermit.FashionPermitManager:getIsBuyFashionPermit() == false)

    local exp = fashionPermit.FashionPermitManager:getFashionPermitExp()
    local maxLv = fashionPermit.FashionPermitManager:getFashionPermitMaxLv()
    local difValue = exp / curStageVo.needExp
    if curLv == maxLv then
        difValue = 1
        self.mTxtShowProgress.text = _TT(4303)
    else
        self.mTxtShowProgress.text = _TT(45013, exp, curStageVo.needExp)
    end

    self.mProgressBar.fillAmount = difValue

    -- local msgVo = permit.PermitManager:getPermitedMsgVo()
    -- if msgVo then
    --     self.mTxtExUL.text = _TT(45013, msgVo.week_exp, sysParam.SysParamManager:getValue(SysParamType.PERMIT_UP_LIMIT_EXP))
    --     local difValue = msgVo.exp / curStageVo.needExp
    --     self.mProgressBar.fillAmount = difValue
    --     self.mTxtShowProgress.text = _TT(45013, msgVo.exp, curStageVo.needExp)
    -- end
    self.mBtnOneKey:SetActive(fashionPermit.FashionPermitManager:getCanReciveNum() >= 1)

    if fashionPermit.FashionPermitManager:getCanReciveNum() >= 1 then
        RedPointManager:add(self.mBtnOneKey.transform, nil, 124.5, 30)
    else
        RedPointManager:remove(self.mBtnOneKey.transform)
    end

    if fashionPermit.FashionPermitManager:canGetTask() then
        RedPointManager:add(self.mBtnTask.transform, nil, 68.7, 25.2)
    else
        RedPointManager:remove(self.mBtnTask.transform)
    end

    if activity.ActitvityExtraManager:getFashionPermitRedInfo() then
        RedPointManager:add(self.mBtnHis.transform, nil, 62.3,13.6)
    else
        RedPointManager:remove(self.mBtnHis.transform)
    end
end

function updateStageInfo(self, curStageVo)
    self:closeAllProps()
    for _, propVo in ipairs(curStageVo:getNoamlAwardList()) do
        local propGrid = PropsGrid:create(self.mTansStageNomal, {
            tid = propVo.tid,
            num = propVo.num ~= nil and propVo.num or 1
        }, 0.7, false)
        propGrid:setHasRec(curStageVo:getIsNomalRecived() and curStageVo:getIsUnlock())
        table.insert(self.mPropsList, propGrid)
    end
    if #curStageVo:getSeniorAwardList() > 1 then
        gs.TransQuick:Scale0(self.mTansStageMoney, 0.5)
    else
        gs.TransQuick:Scale0(self.mTansStageMoney, 0.7)
    end
    for _, propVo1 in ipairs(curStageVo:getSeniorAwardList()) do
        local propGrid1 = PropsGrid:create(self.mTansStageMoney, {
            tid = propVo1.tid,
            num = propVo1.num ~= nil and propVo1.num or 1
        }, 1, false)
        propGrid1:setIconGray((not curStageVo:getIsBuy()))
        propGrid1:setHasRec(curStageVo:getIsSeniorRecived() and curStageVo:getIsUnlock())
        table.insert(self.mPropsList, propGrid1)
    end
    self.mTxtNextNum.text = curStageVo.lv
end

function updateTime(self)
    if activity.ActivityManager:getActivityVoById(activity.ActivityId.PermitFashionHis) then
        local clientTime = GameManager:getClientTime()
        local RemainingTime = activity.ActivityManager:getActivityVoById(activity.ActivityId.PermitFashionHis)
            :getEndTime() - clientTime
        self.mBtnHis:SetActive(RemainingTime > 0)    
    else
        self.mBtnHis:SetActive(false)    
    end

    --
    if activity.ActivityManager:getActivityVoById(activity.ActivityId.Fashion_Permit) then
        local clientTime = GameManager:getClientTime()
        local RemainingTime = activity.ActivityManager:getActivityVoById(activity.ActivityId.Fashion_Permit)
            :getEndTime() - clientTime
        local timeTxt = RemainingTime <= 0 and "活动已结束" or _TT(3530) ..
                            HtmlUtil:colorAndSize(TimeUtil.getFormatTimeBySeconds_9(RemainingTime), "ffffffff", 18)
        self.mTxtTime.text = timeTxt
        if RemainingTime <= 0 then
            self:removeTimer(self.updateTime)
            self:close()
            return
        end
    else
        self:removeTimer(self.updateTime)
        self:close()
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]

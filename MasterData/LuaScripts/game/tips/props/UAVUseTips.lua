module("tips.UAVUseTips", Class.impl(tips.BaseTips))
UIRes = UrlManager:getUIPrefabPath("tips/UAVUseTips.prefab")
panelType = -1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 1 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isAdapta = 0 -- 是否开启适配刘海 0 否 1 是
-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 析构函数
function dtor(self)
    super.dtor(self)
end

-- 初始化UI
function configUI(self)
    super.configUI(self)
    self.mBtnCancle = self:getChildGO("mBtnCancle")
    self.mBtnSure = self:getChildGO("mBtnSure")
    self.mTxtTile_02 = self:getChildGO("mTxtTile_02"):GetComponent(ty.Text)
    self.mTxtSpeedTime = self:getChildGO("mTxtSpeedTime"):GetComponent(ty.InputField)
    self.mTxtRestTime = self:getChildGO("mTxtRestTime"):GetComponent(ty.Text)
    self.mTxtHelpProduce = self:getChildGO("mTxtHelpProduce"):GetComponent(ty.Text)
    self.mTxtCount = self:getChildGO("mTxtCount"):GetComponent(ty.Text)
    self.mNumberStepper = self:getChildGO("mNumberStepper"):GetComponent(ty.LyNumberStepper)
    self.mNumberStepper:Init(0, 0, 1, -1, self.onStepChange, self)
    self.mAni = self.UIObject:GetComponent(ty.Animator)
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mTxtTile_useTips = self:getChildGO("mTxtTile_useTips"):GetComponent(ty.Text)
    -- self.mTxtHelpProduce = self:getChildGO("mTxtHelpProduce"):GetComponent(ty.Text)

    self:setGuideTrans("guide_buildbase_UAVUse_BtnSure", self.mBtnSure.transform)
    self:setGuideTrans("guide_buildbase_UAVUse_BtnRR", self:getChildTrans("mBtnRR"))

end

function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE, self.onUpdateInfo, self)
    self:updateInfo(args)
    self:resetText()
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE, self.onUpdateInfo, self)
    self:recoverSn()
    self:resetText()
end

-- 初始化数据
function initData(self)
    self.timeId = nil
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:setBtnLabel(self.mBtnSure, 1, "确定")
    self:setBtnLabel(self.mBtnCancle, 2, "取消")
    self.mTxtTile_02.text = "/" .. sysParam.SysParamManager:getValue(SysParamType.UAVTOPLIMIT)
    self.mTxtTips.text = _TT(76175)  --(该时间已去除效率加成)
    self.m_childGos["mTxtTilr_01"]:GetComponent(ty.Text).text = "-点击屏幕继续-"
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnSure, self.onGetBtnClick)
    self:addUIEvent(self.mBtnCancle, self.onCloseHandler)
end

function onCloseHandler(self)
    self:recoverSn()
    self.mNumberStepper.CurrCount = 0
    self.mTxtRestTime.text = "00:00:00"
    self:__closeOpenAction()
end
--LyNumStepper回调
function onStepChange(self, cusCount, cusType)
    if cusType == 1 then
        gs.Message.Show(_TT(4018))
    elseif cusType == 2 then
        gs.Message.Show(_TT(4019))
    end
    self:updateCount()
end
--初始化数据 
function updateInfo(self, args)
    self.buildMsgVo = args.buildBaseMsg
    self.buildType = buildBase.BuildBaseManager:getNowBuildType()
    self.mConfig = buildBase.BuildBaseManager:getBuildBaseLevelNeedData(self.buildType)
    self.mCurLvConfig = self.mConfig:getLevelDataVo(self.buildMsgVo.lv)
    self:setRate()
end

--有加速情况设置加速时间和配置表比例
function setRate(self)
    if buildBase.BuildBaseManager:getNowBuildType() == buildBase.BuildBaseType.Factory then
        self.orderVo = buildBase.BuildBaseManager:getFacInfo(buildBase.BuildBaseManager.mNowBuildId)
        if self.orderVo.orderId > 0 then
            local time = buildBase.BuildBaseManager:getFacItemsConfigData(self.orderVo.orderType):getItemVo(self.orderVo.orderId).needTime
            if self.buildMsgVo.startTime > 0 then
                self.produceTime = self.buildMsgVo.time - self.buildMsgVo.startTime
                if time > 0 and next(self.buildMsgVo.skillList) then
                    self.rate = self.produceTime / time
                else
                    self.rate = 1
                end
            end
        end
    else
        if self.buildMsgVo.startTime > 0 then
            self.produceTime = self.buildMsgVo.time - self.buildMsgVo.startTime
            if self.mCurLvConfig.time > 0 then
                self.rate = self.produceTime / self.mCurLvConfig.time
            else
                self.rate = 1
            end
        end
    end

end

--重置显示框
function resetText(self)
    self.mNumberStepper.CurrCount = 0
    self.mTxtRestTime.text = "00:00:00"
    self.mTxtSpeedTime.text = "00:00:00"
    self.mTxtHelpProduce.text = _TT(76199, 0)
end

--刷新显示
function updateView(self)
    --更新倒计时
    self:updateResTime()
    --更新加速栏最大值
    self:getMaxProduce()
    --更新加速时间栏
    self:updateCount()
end

-- 更新剩余时间倒计时
function updateResTime(self)
    self:recoverSn()
    local leftTime = (self.buildMsgVo.fullTime - GameManager:getClientTime())
    if leftTime > 0 then
        leftTime = leftTime / self.rate
    end

    local function updateTime()
        if (leftTime > 0) then
            self.mTxtRestTime.text = TimeUtil.getHMSByTime(leftTime)
            leftTime = leftTime - 1
        else
            self:recoverSn()
        end
    end
    updateTime()
    self.timeId = LoopManager:addTimer(1, 0, self, updateTime)
end

--更改最大值
function getMaxProduce(self)
    if self.buildMsgVo.startTime > 0 then
        local unitUavTime = sysParam.SysParamManager:getValue(SysParamType.UAVREDUCETIME)
        local maxNum = math.ceil((self.buildMsgVo.fullTime - GameManager:getClientTime() - (GameManager:getClientTime() - self.buildMsgVo.startTime)) / (unitUavTime * self.rate))
        self.orderVo = buildBase.BuildBaseManager:getFacInfo(buildBase.BuildBaseManager.mNowBuildId)
        if self.orderVo.orderType > 0 and self.orderVo.orderId > 0 then
            local produceConfig = buildBase.BuildBaseManager:getFacItemsConfigData(self.orderVo.orderType):getItemVo(self.orderVo.orderId)
            local remainCount = math.floor((self.buildMsgVo.maxNum - self.buildMsgVo.produce) / produceConfig.store)

            local alreadyTime = (GameManager:getClientTime() - self.buildMsgVo.startTime) * self.rate
            local remainTime = remainCount * produceConfig.needTime - alreadyTime
            maxNum = math.ceil(remainTime / unitUavTime)
        end

        local allDrone = buildBase.BuildBaseManager:getAllDrone()
        if (maxNum < allDrone) then
            self.mNumberStepper.MaxCount = maxNum
        else
            self.mNumberStepper.MaxCount = allDrone
        end
    else
        self.mNumberStepper.MaxCount = 0
        self.mTxtRestTime.text = "00:00:00"
        self.mTxtCount.text = "0"
    end
end

--更新加速时间栏
function updateCount(self)
    self.mTxtTile_useTips.text = _TT(76198, self.mNumberStepper.CurrCount) -- 是否消耗生产机器人加速制造
    if buildBase.BuildBaseManager:getNowBuildType() == buildBase.BuildBaseType.Factory then
        self.res = 0
        if self.mNumberStepper.CurrCount <= self.mNumberStepper.MaxCount then
            if self.buildMsgVo.startTime > 0 then
                local unitUavTime = sysParam.SysParamManager:getValue(SysParamType.UAVREDUCETIME)
                --无人机时间是否比当前份数生产时间多
                local isCarry = 0
                --单份溢出的无人机份数
                local isCarryFlag = 0
                local configProduceTime = buildBase.BuildBaseManager:getFacItemsConfigData(self.orderVo.orderType):getItemVo(self.orderVo.orderId).needTime
                self.buildMsgVo = buildBase.BuildBaseManager:getBuildBaseData(buildBase.BuildBaseManager:getNowBuildId())
                if self.produceTime > 0 then
                    isCarry = self.buildMsgVo.time - GameManager:getClientTime()
                end
                local RT = 0
                if self.orderVo.count > 1 then
                    -- n份无人机超出当前份数时间剩余的时间
                    RT = self.mNumberStepper.CurrCount * unitUavTime * self.rate - isCarry
                else
                    RT = self.mNumberStepper.CurrCount * unitUavTime * self.rate
                end
                if isCarry > 0 then
                    self.res = self.res + 1
                else
                    self.res = 0
                end
                if self.mNumberStepper.CurrCount > 0 then
                    local numHelper = self.res
                    if self.orderVo.count > 1 then
                        self.res = math.floor(RT / configProduceTime)
                    else
                        self.res = math.floor((self.buildMsgVo.time - GameManager:getClientTime()) / (configProduceTime))
                    end

                    self.res = self.res + numHelper
                    if self.res > 0 then

                        self.mTxtHelpProduce.text = _TT(76199, self.res > self.orderVo.count and self.orderVo.count or self.res)  --协助生产n份

                    else
                        self.mTxtHelpProduce.text = _TT(76199, 0)

                    end
                else
                    self.mTxtHelpProduce.text = _TT(76199, 0)

                end
                self.mTxtSpeedTime.text = TimeUtil.getHMSByTime((self.mNumberStepper.CurrCount * unitUavTime))
            end
            local leftUav = MoneyUtil.getMoneyCountByTid(MoneyTid.UAV_TID)
            if leftUav > 0 then
                self.mTxtCount.text = leftUav
            else
                self.mTxtCount.text = 0
            end
        else
            gs.Message.Show("超过最大值 ")
            self.mNumberStepper.CurrCount = self.mNumberStepper.MaxCount
        end

    else
        self.res = 0
        if self.mNumberStepper.CurrCount <= self.mNumberStepper.MaxCount then
            if self.buildMsgVo.startTime > 0 then
                local unitUavTime = sysParam.SysParamManager:getValue(SysParamType.UAVREDUCETIME)
                --无人机时间是否比当前份数生产时间多
                local isCarry = 0
                --单份溢出的无人机份数
                local isCarryFlag = 0
                if self.produceTime > 0 then
                    isCarry = self.buildMsgVo.time - GameManager:getClientTime()
                end
                -- n份无人机超出当前份数时间剩余的时间
                local RT = self.mNumberStepper.CurrCount * unitUavTime - isCarry
                if RT > 0 then
                    self.res = self.res + 1
                    isCarryFlag = math.floor(isCarry / unitUavTime)
                else
                    self.res = 0
                end
                if self.mNumberStepper.CurrCount > 0 then
                    local numHelper = self.res
                    self.res = math.floor(((self.mNumberStepper.CurrCount - isCarryFlag) * unitUavTime * self.rate) / (self.produceTime))

                    self.res = self.res + numHelper
                    if self.res > 0 then
                        self.mTxtHelpProduce.text = _TT(76199, self.res)

                    else
                        self.mTxtHelpProduce.text = _TT(76199, 0)

                    end
                else
                    self.mTxtHelpProduce.text = _TT(76199, 0)
                end
                self.mTxtSpeedTime.text = TimeUtil.getHMSByTime((self.mNumberStepper.CurrCount * unitUavTime))
            end
            local leftUav = MoneyUtil.getMoneyCountByTid(MoneyTid.UAV_TID)
            if leftUav > 0 then
                self.mTxtCount.text = leftUav
            else
                self.mTxtCount.text = 0
            end
        else
            gs.Message.Show("超过最大值 ")
            self.mNumberStepper.CurrCount = self.mNumberStepper.MaxCount
        end
    end
end
--更新回调函数
function onUpdateInfo(self)
    self:updateInfo({ buildBaseMsg = buildBase.BuildBaseManager:getBuildBaseData(self.buildMsgVo.id) })
    self:updateView()
end

--无人机加速回调
function onGetBtnClick(self)
    if self.buildMsgVo.fullTime - GameManager:getClientTime() > 0 and self.buildMsgVo.startTime > 0 then
        if (self.mNumberStepper.CurrCount > MoneyUtil.getMoneyCountByTid(MoneyTid.UAV_TID)) then
            gs.Message.Show("无人机数量不足")
        else
            if self.mNumberStepper.CurrCount > 0 then
                GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_SPEEDUP, { id = buildBase.BuildBaseManager:getNowBuildId(), costNum = self.mNumberStepper.CurrCount })
                self:__closeOpenAction()
            else
                gs.Message.Show("请增加加速时间")
            end
        end
    else
        gs.Message.Show("生产完成无需加速")
    end
end

function recoverSn(self)
    if (self.timeId) then
        LoopManager:removeTimerByIndex(self.timeId)
        self.timeId = nil

    end
end

-- 在资源销毁前，对需要回收的资源进行回收处理
function recover(self)
    super.recover(self)
    self:initData()
end

function __closeOpenAction(self)
    if (self.panelType ~= 1 and not self.isCloseing) then
        self.isCloseing = true
        local tweenTime = AnimatorUtil.getAnimatorClipTime(self.mAni, "UAVUseTips_Exit")
        gs.UIBlurManager.SetSuperBlur(false, self.UIRootNode, self:getUiNodeName(), self.blurTweenTime)

        if self.mBlurMask then
            gs.GameObject.Destroy(self.mBlurMask)
            self.mBlurMask = nil
        end
        if self.UIObject then
            self.mAni:SetTrigger("exit")
            local _viewTweenFinishCall = function()
                if self.isPop == 1 then
                    self:close()
                end
            end
            self:addTimer(tweenTime, 1, _viewTweenFinishCall)
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(4062):	"<未解锁>"
]]
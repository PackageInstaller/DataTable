--[[ 
-----------------------------------------------------
@filename       : DispatchDroneView
@Description    : 战舰(基建)-派遣坞加速界面
@date           : 2023/3
@Author         : TOoOoOoOoonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("buildBase.DispatchDroneView", Class.impl(tips.BaseTips))
UIRes = UrlManager:getUIPrefabPath("buildBase/DispatchDroneView.prefab")
panelType = 2 -- 窗口类型 1 全屏 2 弹窗
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
    self.mTxtCount = self:getChildGO("mTxtCount"):GetComponent(ty.Text)
    self.mNumberStepper = self:getChildGO("mNumberStepper"):GetComponent(ty.LyNumberStepper)
    self.mNumberStepper:Init(0, 0, 1, -1, self.onStepChange, self)
    self.mAni = self.UIObject:GetComponent(ty.Animator)
    self.mTxtTile_useTips = self:getChildGO("mTxtTile_useTips"):GetComponent(ty.Text)
end

function active(self, exploreId)
    super.active(self, exploreId)
    GameDispatcher:addEventListener(EventName.RESPONSE_BUILDBASE_DISPATCH_SPEEDUP, self.onUpdateInfo, self)
    self.exploreId = exploreId
    self.mAreaMsgVo = buildBase.DispatchDockManager:getAreaInfo(self.exploreId)
    self:resetText()
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.RESPONSE_BUILDBASE_DISPATCH_SPEEDUP, self.onUpdateInfo, self)
    self:recoverSn()
    self:resetText()
end

-- 初始化数据
function initData(self)
    self.timeId = nil
    self.mUnitUavTime = sysParam.SysParamManager:getValue(SysParamType.UAVREDUCETIME)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:setBtnLabel(self.mBtnSure, 1, "确定")
    self:setBtnLabel(self.mBtnCancle, 2, "取消")
    self.mTxtTile_02.text = "/" .. sysParam.SysParamManager:getValue(SysParamType.UAVTOPLIMIT)
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

--重置显示框
function resetText(self)
    self.mNumberStepper.CurrCount = 0
    self.mTxtRestTime.text = "00:00:00"
    self.mTxtSpeedTime.text = "00:00:00"
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
    self.leftTime = self.mAreaMsgVo.endTIme - GameManager:getClientTime()
    local function counter()
        if (self.leftTime > 0) then
            self.leftTime = self.mAreaMsgVo.endTIme - GameManager:getClientTime()
            self.mTxtRestTime.text = TimeUtil.getHMSByTime(self.leftTime)
        else
            self:recoverSn()
        end
    end
    counter()
    self.timeId = LoopManager:addTimer(1, 0, self, counter)
end

--更新加速时间栏
function updateCount(self)
    if self.mNumberStepper.CurrCount <= self.mNumberStepper.MaxCount then
        if self.mAreaMsgVo.endTIme > 0 then
            --无人机时间是否比当前份数生产时间多
            self.mTxtTile_useTips.text = _TT(76197, HtmlUtil:color(self.mNumberStepper.CurrCount, "29F074ff"))
            -- self.mTxtCount_use.text = self.mNumberStepper.CurrCount
            self.mTxtSpeedTime.text = TimeUtil.getHMSByTime((self.mNumberStepper.CurrCount * self.mUnitUavTime))
        end
        local leftUav = MoneyUtil.getMoneyCountByTid(MoneyTid.UAV_TID)
        if leftUav > 0 then
            self.mTxtCount.text = leftUav
        else
            self.mTxtCount.text = 0
        end
    else
        -- gs.Message.Show("超过最大值 ")
        self.mNumberStepper.CurrCount = self.mNumberStepper.MaxCount
    end
end
--更新回调函数
function onUpdateInfo(self)
    self:updateView()
end

--更改最大值
function getMaxProduce(self)
    if self.mAreaMsgVo.endTIme > 0 then
        local maxNum = math.ceil((self.mAreaMsgVo.endTIme - GameManager:getClientTime()) / self.mUnitUavTime)
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

--无人机回调
function onGetBtnClick(self)
    if self.mAreaMsgVo.endTIme - GameManager:getClientTime() > 0 then
        if (self.mNumberStepper.CurrCount > MoneyUtil.getMoneyCountByTid(MoneyTid.UAV_TID)) then
            gs.Message.Show("无人机数量不足")
        else
            if self.mNumberStepper.CurrCount > 0 then
                GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_DISPATCH_SPEEDUP,
                {
                    buildId = buildBase.BuildBaseManager:getNowBuildId(),
                    exploreId = self.exploreId,
                    costNum = self.mNumberStepper.CurrCount
                })
                self:__closeOpenAction()
            else
                gs.Message.Show("请增加加速时间")
            end
        end
    else
        gs.Message.Show("派遣完成无需加速")
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

--动效
function __closeOpenAction(self)
    if (self.panelType ~= 1 and not self.isCloseing) then
        self.isCloseing = true
        local tweenTime = AnimatorUtil.getAnimatorClipTime(self.mAni, "DispatchDroneView_Exit")
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
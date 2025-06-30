--[[ 
-----------------------------------------------------
@filename       : MiniConvertView
@Description    : 迷你工厂兑换页面
@date           : 2022-03-01 13:38:58
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("buildBase.BuildBaseChargeTimerInfo", Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("buildBase/BuildBaseChargeTimerInfo.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = -1 -- 窗口类型 1 全屏 2 弹窗
isAdapta = 0--是否开启适配刘海 0 否 1 是
isBlur = 0
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1056, 558)
end

--析构  
function dtor(self)
    LoopManager:removeTimer(self, self.onUpdateChargeTimerInfo)
end

function initData(self)

end

-- 初始化
function configUI(self)
    self.mBtnChargeSpeedUp = self:getChildGO("mBtnChargeSpeedUp")
    self.mTxtChargeRate = self:getChildGO("mTxtChargeRate"):GetComponent(ty.Text)
    self.mTxtChargeTimer = self:getChildGO("mTxtChargeTimer"):GetComponent(ty.Text)
    self.mImgCircle = self:getChildGO("mImgCircle"):GetComponent(ty.Image)
    self.mTxtChargeSpeedUp = self:getChildGO("mTxtChargeSpeedUp"):GetComponent(ty.Text)
end

--激活
function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE, self.onUpdate, self)
    self.mConfigAll =  sysParam.SysParamManager:getValue(SysParamType.UAVTOPLIMIT )
    self:onUpdate()
    self:showRate()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    LoopManager:removeTimer(self, self.onUpdateChargeTimerInfo)
    GameDispatcher:removeEventListener(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE, self.onUpdate, self)
end



function initViewText(self)
    self.mTxtChargeSpeedUp.text = _TT(76191) 
end

-- UI事件管理
function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mBtnChargeSpeedUp, self.onClickOpenChargeSPView)
end

function onCancel(self)
    self:close()
end


function onUpdate(self)
    self.mEndTime, self.mStartTime = buildBase.BuildBaseManager:getPlantTime()
    local mSpan = self.mEndTime - GameManager:getClientTime()
    if (mSpan < 0) then
        self.mTxtChargeTimer.text = "00:00:00"
       local nowDrone = buildBase.BuildBaseManager:getAllDrone()
        if nowDrone > self.mConfigAll then 
            self.mImgCircle.fillAmount = 1
        else 
            self.mImgCircle.fillAmount = nowDrone /self.mConfigAll
        end 
      
    else
        LoopManager:removeTimer(self, self.onUpdateChargeTimerInfo)
        LoopManager:addTimer(0, 0, self, self.onUpdateChargeTimerInfo)
    end
end

function showRate(self)
    local mNumHelper = buildBase.BuildBaseManager:getPlantSkillInfo()
    self.mOut = mNumHelper / 100
    if self.mOut > 0 then
        self.mTxtChargeRate.text = string.format("%d", self.mOut) .. "%"
    else
        self.mTxtChargeRate.text = string.format("%d", 0) .. "%"
    end
end

function onUpdateChargeTimerInfo(self)
    local leftTime = self.mEndTime - GameManager:getClientTime()
    if (leftTime < 0) then
    else
        self.mTxtChargeTimer.text = TimeUtil.getHMSByTime(leftTime)
        self.mImgCircle.fillAmount = buildBase.BuildBaseManager:getAllDrone() /self.mConfigAll
    end
end

-- 加速发电
function onClickOpenChargeSPView(self)
    local max = sysParam.SysParamManager:getValue(5003) or 200
    if role.RoleManager:getRoleVo():getPlayerDrone() >= max then
        gs.Message.Show(_TT(76196))
        
    else
        GameDispatcher:dispatchEvent(EventName.OPEN_BUILDBASE_CHARGE_SPEED_UP_VIEW)
        self:close()
    end 
   
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]
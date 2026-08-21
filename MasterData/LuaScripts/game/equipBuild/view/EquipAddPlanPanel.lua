--[[ 
-----------------------------------------------------
@filename       : EquipAddPlanPanel
@Description    : 模组方案增加提示界面
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("equipBuild.EquipAddPlanPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("equipBuild/EquipAddPlanPanel.prefab")

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 1 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isAdapta = 0 -- 是否开启适配刘海 0 否 1 是

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 520)
    self:setTxtTitle("确认提示")
end

function initData(self)
    super.initData(self)
end

-- 初始化
function configUI(self)
    self.mTxtTip = self:getChildGO("mTxtTip"):GetComponent(ty.Text)

    self.mBtnCancel = self:getChildGO("CancelBtn")
    self.mBtnConfirm = self:getChildGO("ConfirmBtn")

    self.mNumberStepper = self:getChildGO('mNumberStepper'):GetComponent(ty.LyNumberStepper)
    self.mNumberStepper:Init(1, 1, 1, -1, self.onStepChange, self)

    self.mTxtCost = self:getChildGO("mTxtCost"):GetComponent(ty.Text)
    self.mImgCost = self:getChildGO("mImgCost"):GetComponent(ty.AutoRefImage)
end

function initViewText(self)
   
    self:setBtnLabel(self.mBtnConfirm, 1, "确定")
    self:setBtnLabel(self.mBtnCancel, 2, "取消")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnCancel, self.onClicCancelHandler)
    self:addUIEvent(self.mBtnConfirm, self.onClickConfirmHandler)
end

function onClicCancelHandler(self)
    self:close()
end

function onClickConfirmHandler(self)
    local costInfo = sysParam.SysParamManager:getValue(SysParamType.ADD_EQUIP_PLAN_COST)
    -- local hasCount = MoneyUtil.getMoneyCountByType(costInfo[1][1])
    -- local needCount = self.mNumberStepper.CurrCount * costInfo[1][2]
    local isEnought, tips = MoneyUtil.judgeNeedMoneyCountByTid(costInfo[1][1], self.mNumberStepper.CurrCount * costInfo[1][2], true, true)
    if isEnought then
        GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_ADD_PLAN,self.mNumberStepper.CurrCount)
        self:close()
    else
        UIFactory:alertMessge(tips, true, function()
            GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.Purchase })
            self:close()
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
    end

  
end

function onStepChange(self, cusCount, cusType)
    if cusType == 1 then
        -- '最大值'
        local MaxCount = sysParam.SysParamManager:getValue(SysParamType.ADD_EQUIP_PLAN_COUNT)
        local addCountMax = sysParam.SysParamManager:getValue(SysParamType.ADD_EQUIP_PLAN_COUNT)
        if self.mNumberStepper.MaxCount >= MaxCount - addCountMax then
            gs.Message.Show(_TT(1437))
            return
        end
        gs.Message.Show(_TT(4018))
    elseif cusType == 2 then
        -- '最小值'
        gs.Message.Show(_TT(4019))
    end
    self:updateCost()
 
end

function active(self, args)
    super.active(self, args)
    self.mNumberStepper.CurrCount = 1

    local hasAddCount  = equipBuild.EquipPlanManager:getExtraNum()
    local addCountMax = sysParam.SysParamManager:getValue(SysParamType.ADD_EQUIP_PLAN_COUNT)
    self.mNumberStepper.MaxCount = addCountMax - hasAddCount

    self:updateCost()
  
end

function updateCost(self)
    local costInfo = sysParam.SysParamManager:getValue(SysParamType.ADD_EQUIP_PLAN_COST)
    self.mImgCost:SetImg(MoneyUtil.getMoneyIconUrlByTid(costInfo[1][1]))
    self.mTxtCost.text = self.mNumberStepper.CurrCount * costInfo[1][2]

    local hasCount = MoneyUtil.getMoneyCountByType(costInfo[1][1])
    self.mTxtCost.color = hasCount >= self.mNumberStepper.CurrCount * costInfo[1][2] and  gs.ColorUtil.GetColor("282D30ff") or  gs.ColorUtil.GetColor("BD2A2AFF")

    self.mTxtTip.text = _TT(1418)--"以下模组正被使用，是否继续装备？"

    
    local vo = props.PropsManager:getTypePropsVoByTid(costInfo[1][1])
    local name = vo.name

    self.mTxtTip.text = _TT(1436, self.mNumberStepper.CurrCount * costInfo[1][2] .. name, self.mNumberStepper.CurrCount)
end

function deActive(self)
    super.deActive(self)
end

return _M
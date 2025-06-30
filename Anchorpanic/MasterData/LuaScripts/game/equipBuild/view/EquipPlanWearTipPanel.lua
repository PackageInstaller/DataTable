--[[ 
-----------------------------------------------------
@filename       : EquipPlanWearTipPanel
@Description    : 模组方案穿戴提示界面
@date           : 2023-12-6 00:00:00
@Author         : Zzz
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("equipBuild.EquipPlanWearTipPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("equipBuild/EquipPlanWearTipPanel.prefab")

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
    self.mItemList = {}
end

-- 初始化
function configUI(self)
    self.mTxtTip = self:getChildGO("mTxtTip"):GetComponent(ty.Text)

    self.mBtnCancel = self:getChildGO("CancelBtn")
    self.mBtnConfirm = self:getChildGO("ConfirmBtn")

    self.mContent = self:getChildTrans("Content")
end

function initViewText(self)
    self.mTxtTip.text = _TT(1418)--"以下模组正被使用，是否继续装备？"
    self:setBtnLabel(self.mBtnConfirm, 1, "确定")
    self:setBtnLabel(self.mBtnCancel, 2, "取消")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnCancel, self.onClicCancelHandler)
    self:addUIEvent(self.mBtnConfirm, self.onClickConfirmHandler)
end

function active(self, args)
    super.active(self, args)
    self.mEquipPlanVo = args
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    self:recover()
end

function onClicCancelHandler(self)
    self:close()
end

function onClickConfirmHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_PLANE_WEAR, {equipPlanId = self.mEquipPlanVo.id, heroId = equipBuild.EquipPlanManager:getHeroId()})
    self:close()
end

function updateView(self)
    self:recover()
    for pos, equipId in pairs(self.mEquipPlanVo.equipPosDic)do
        local equipVo = bag.BagManager:getPropsVoById(equipId)
        local equipGrid = EquipGrid:create(self.mContent, equipVo, 1)
        equipGrid:setShowHeroIcon(true)
        table.insert(self.mItemList, equipGrid)
    end
end

function recover(self)
    if(#self.mItemList > 0)then
        for i = #self.mItemList, 1, -1 do
            self.mItemList[i]:poolRecover()
        end
        self.mItemList = {}
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
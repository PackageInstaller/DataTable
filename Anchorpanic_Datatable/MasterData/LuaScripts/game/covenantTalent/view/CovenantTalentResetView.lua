--[[ 
-----------------------------------------------------
@filename       : CovenantTalentResetView
@Description    : 盟约天赋
@date           : 2021-07-02 10:35:56
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.covenantTalent.view.CovenantTalentResetView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("covenantTalent/CovenantTalentResetView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mTxtContent = self:getChildGO("mTxtContent"):GetComponent(ty.Text)
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mGroupProps = self:getChildTrans("mGroupProps")
    self.mGroupCost = self:getChildGO("mGroupCost")
    self.mImgMoneyIcon = self:getChildGO("mImgMoneyIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtMoneyCost = self:getChildGO("mTxtMoneyCost"):GetComponent(ty.Text)
    self.mBtnCancel = self:getChildGO("mBtnCancel")
    self.mBtnConfirm = self:getChildGO("mBtnConfirm")
end

--激活
function active(self, args)
    super.active(self, args)
    self.mHelperId = args.helperId

    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtContent.text = _TT(29530) --"确定消耗以下材料进行基因重组吗？"
    self.mTxtTips.text = _TT(29531) --"(基因重组会将返还当前人偶的基因参数，但基因升级所消耗的金币不返还) "
    self:setBtnLabel(self.mBtnConfirm, 1)
    self:setBtnLabel(self.mBtnCancel, 2)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnConfirm, self.onConfirm)
    self:addUIEvent(self.mBtnCancel, self.onCancel)
end

function onConfirm(self)
    if not MoneyUtil.judgeNeedMoneyCountByTid(self:getCostData().payCoin, self:getCostData().payNum, false, true) then
        return
    end
    local count = bag.BagManager:getPropsCountByTid(self:getCostData().itemTid)
    if count < self:getCostData().itemNum then
        -- gs.Message.Show2("道具不足")
        gs.Message.Show2(_TT(29532))
        return
    end
    GameDispatcher:dispatchEvent(EventName.REQ_GENE_RESET, self.mHelperId)
    self:close()
end
function onCancel(self)
    self:close()
end

function updateView(self)
    self.mImgMoneyIcon:SetImg(MoneyUtil.getMoneyIconUrlByTid(self:getCostData().payCoin), true)
    self.mTxtMoneyCost.text = self:getCostData().payNum
    self.mTxtMoneyCost.color = gs.ColorUtil.GetColor(MoneyUtil.judgeNeedMoneyCountByTid(self:getCostData().payCoin, self:getCostData().payNum, false, false) and "FFFFFFFF" or "ed1941FF")

    if self.mGrid then
        self.mGrid:poolRecover()
        self.mGrid = nil
    end

    if self:getCostData().itemTid ~= 0 then
        self.mGrid = PropsGrid:create(self.mGroupProps, { self:getCostData().itemTid, self:getCostData().itemNum })
        self.mGrid:setCount(self:getCostData().itemNum)

        local count = bag.BagManager:getPropsCountByTid(self:getCostData().itemTid)
        local colorStr = count >= self:getCostData().itemNum and "FFFFFFFF" or "ed1941FF"
        self.mGrid:setCountTextColor(colorStr)
        gs.TransQuick:UIPosY(self.mTxtContent.transform, -235)
    else
        gs.TransQuick:UIPosY(self.mTxtContent.transform, -308)
    end
end

function getCostData(self)
    local helperInfo = covenantTalent.CovenantTalentManager:getHelperInfo(self.mHelperId)
    local resetTimes = helperInfo.resetTimes
    resetTimes = resetTimes + 1
    local data = covenantTalent.CovenantTalentManager:getForcesGeneData(resetTimes)
    return data
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

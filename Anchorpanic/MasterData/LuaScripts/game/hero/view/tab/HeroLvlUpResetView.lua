--[[
-----------------------------------------------------
    @CreateTime:2025/1/24 14:46:44
    @Author:zengweiwen
    @Copyright: (LY)2021 雷焰网络
    @Description:角色升级重置弹窗
]]

module("game.hero.view.tab.HeroLvlUpResetView", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("hero/tab/HeroLvlUpResetView.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2   -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(10000368))
    self:setSize(837, 336)
end

function initData(self)
end

function configUI(self)
    self.mAwardGroup = self:getChildTrans("mAwardGroup")
    self.mBtnCancel = self:getChildGO("mBtnCancel")
    self.mBtnConfirm = self:getChildGO("mBtnConfirm")
    self.mTxtCost = self:getChildGO("mTxtCost"):GetComponent(ty.Text)
    self.mImgCost = self:getChildGO("mImgCost"):GetComponent(ty.AutoRefImage)
end

function initViewText(self)
    super.initViewText(self)
    self:getChildGO("mTxtContent"):GetComponent(ty.TMP_Text).text = _TT(10000369)
    self:getChildGO("mTxtReturnDesc"):GetComponent(ty.Text).text = _TT(10000370)
    self:setBtnLabel(self.mBtnCancel, 2)
    self:setBtnLabel(self.mBtnConfirm, 4238)

    local costCfg = hero.HeroLvlUpManager:getHeroResetLvCostCfg()
    self.mImgCost:SetImg(UrlManager:getPropsIconUrl(costCfg[1]), false)
    local costNum = costCfg[2]
    local isEnough, tipStr = MoneyUtil.judgeNeedMoneyCountByTid(costCfg[1], costCfg[2], false, false)
    if not isEnough then
        costNum = "<color=#f94234>" .. costNum .. "</color>"
    end
    self.mTxtCost.text = costNum
end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mBtnCancel, self.onClickClose)
    self:addUIEvent(self.mBtnConfirm, self.onClickBtnConfirmHandler)
end

function initArgs(self, args)
    self.hero_id = args and args.hero_id or nil
    self.award_list = args and args.award_list or nil
end

function active(self, args)
    super.active(self)
    self:initArgs(args)
    self:recoverGrid()
    for i, pt_prop_award in ipairs(self.award_list) do
        local item = PropsGrid:create(self.mAwardGroup, { tid = pt_prop_award.tid, num = pt_prop_award.count }, 1)
        self.mGridProp[i] = item
    end
end

function deActive(self)
    super.deActive(self)
    self:initArgs()
    self:recoverGrid()
end

function recoverGrid(self)
    if self.mGridProp then
        for _, vo in pairs(self.mGridProp) do
            vo:poolRecover()
        end
    end
    self.mGridProp = {}
end

function onClickBtnConfirmHandler(self)
    local costCfg = hero.HeroLvlUpManager:getHeroResetLvCostCfg()
    local isEnough, tipStr = MoneyUtil.judgeNeedMoneyCountByTid(costCfg[1], costCfg[2], false, true)
    if isEnough then
        GameDispatcher:dispatchEvent(EventName.REQ_CS_RESET_HERO_LV, { hero_id = self.hero_id })
        self:onClickClose()
    end
end

return _M
